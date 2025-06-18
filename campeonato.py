import sqlite3
from collections import defaultdict

DB_FILE = "futebol.db"

def conectar_bd():
    """Conecta ao banco de dados SQLite."""
    try:
        conn = sqlite3.connect(DB_FILE)
        conn.row_factory = sqlite3.Row  # Permite acessar colunas pelo nome
        return conn
    except sqlite3.Error as e:
        print(f"Erro ao conectar ao banco de dados: {e}")
        return None

def informacoes_time():
    """Exibe informações detalhadas de um time escolhido pelo usuário."""
    conn = conectar_bd()
    if not conn:
        return

    try:
        cursor = conn.cursor()
        cursor.execute("SELECT id_clube, nome_clube FROM Clube ORDER BY nome_clube")
        clubes = cursor.fetchall()

        if not clubes:
            print("Nenhum clube cadastrado.")
            return

        print("\n--- Escolha um time ---")
        for clube in clubes:
            print(f"{clube['id_clube']}) {clube['nome_clube']}")

        escolha = input("Digite o número do time: ")
        
        try:
            id_clube_escolhido = int(escolha)
            if id_clube_escolhido not in [c['id_clube'] for c in clubes]:
                print("Escolha inválida.")
                return
        except ValueError:
            print("Entrada inválida. Digite um número.")
            return

        # 1. Dados do Clube, Treinador e Estádio
        query_clube = """
            SELECT c.nome_clube, t.nome_treinador, t.id_treinador, e.nome_estadio AS sede
            FROM Clube c
            LEFT JOIN Treinador t ON c.id_clube = t.id_clube
            JOIN Estadio e ON c.id_estadio_sede = e.id_estadio
            WHERE c.id_clube = ?
        """
        cursor.execute(query_clube, (id_clube_escolhido,))
        info_clube = cursor.fetchone()

        print(f"\n--- INFORMAÇÕES: {info_clube['nome_clube']} ---")
        # Exibição ATUALIZADA para mostrar a Sede
        print(f"Sede (Estádio): {info_clube['sede']}")
        print(f"Técnico: {info_clube['nome_treinador'] or 'Não informado'}")
        
        id_treinador = info_clube['id_treinador']
        if id_treinador:
            cursor.execute("SELECT tipo_cartao, COUNT(*) as total FROM Cartao WHERE id_treinador = ? GROUP BY tipo_cartao", (id_treinador,))
            cartoes_tecnico = cursor.fetchall()
            amarelos = 0
            vermelhos = 0
            for cartao in cartoes_tecnico:
                if cartao['tipo_cartao'] == 'amarelo':
                    amarelos = cartao['total']
                else:
                    vermelhos = cartao['total']
            print(f"Cartões do Técnico: 🟨 {amarelos} | 🟥 {vermelhos}")
        
        print("\n--- Jogadores ---")
        cursor.execute("SELECT nome_jogador, posicao FROM Jogador WHERE id_clube = ? ORDER BY nome_jogador", (id_clube_escolhido,))
        jogadores = cursor.fetchall()
        for jogador in jogadores:
            print(f"- {jogador['nome_jogador']} ({jogador['posicao']})")

        print("\n--- Partidas Realizadas ---")
        query_partidas = """
            SELECT p.data_partida, c_mandante.nome_clube AS mandante, p.placar_mandante, 
                    p.placar_visitante, c_visitante.nome_clube AS visitante, e.nome_estadio
            FROM Partida p
            JOIN Clube c_mandante ON p.id_clube_mandante = c_mandante.id_clube
            JOIN Clube c_visitante ON p.id_clube_visitante = c_visitante.id_clube
            JOIN Estadio e ON p.id_estadio = e.id_estadio
            WHERE p.id_clube_mandante = ? OR p.id_clube_visitante = ?
            ORDER BY p.data_partida
        """
        cursor.execute(query_partidas, (id_clube_escolhido, id_clube_escolhido))
        partidas = cursor.fetchall()
        for partida in partidas:
            print(f"{partida['data_partida']}: {partida['mandante']} {partida['placar_mandante']} x {partida['placar_visitante']} {partida['visitante']} ({partida['nome_estadio']})")
            
    except sqlite3.Error as e:
        print(f"Erro ao consultar o banco de dados: {e}")
    finally:
        if conn:
            conn.close()

def mostrar_ranking(tabela, titulo, unidade):
    """Função genérica para mostrar rankings (artilharia, assistências, cartões)."""
    conn = conectar_bd()
    if not conn:
        return

    query = f"""
        SELECT j.nome_jogador, c.nome_clube, COUNT(t.id_{tabela.lower()}) AS total
        FROM {tabela} t
        JOIN Jogador j ON t.id_jogador = j.id_jogador
        JOIN Clube c ON j.id_clube = c.id_clube
        {'WHERE t.tipo_cartao = "'+unidade+'"' if tabela == 'Cartao' else ''}
        GROUP BY j.id_jogador
        ORDER BY total DESC
    """
    
    try:
        cursor = conn.cursor()
        cursor.execute(query)
        resultados = cursor.fetchall()
        
        print(f"\n--- {titulo.upper()} ---")
        print(f"{'Pos':<5} {'Nome':<20} {'Time':<20} {'Total':<5}")
        print("-" * 55)
        
        for i, linha in enumerate(resultados, 1):
            print(f"{i:<5} {linha['nome_jogador']:<20} {linha['nome_clube']:<20} {linha['total']:<5}")

    except sqlite3.Error as e:
        print(f"Erro ao consultar o banco de dados: {e}")
    finally:
        if conn:
            conn.close()

def mostrar_artilharia():
    """Mostra o ranking de artilheiros."""
    mostrar_ranking("Gol", "Artilharia", "Gols")

def mostrar_assistencias():
    """Mostra o ranking de assistências."""
    mostrar_ranking("Assistencia", "Assistências", "Assist.")

def mostrar_cartoes_amarelos():
    """Mostra o ranking de cartões amarelos."""
    mostrar_ranking("Cartao", "Cartões Amarelos", "amarelo")

def mostrar_cartoes_vermelhos():
    """Mostra o ranking de cartões vermelhos."""
    mostrar_ranking("Cartao", "Cartões Vermelhos", "vermelho")


def mostrar_classificacao():
    """Calcula e mostra a tabela de classificação do campeonato."""
    conn = conectar_bd()
    if not conn:
        return

    try:
        cursor = conn.cursor()
        
        # Pega todos os clubes
        cursor.execute("SELECT id_clube, nome_clube FROM Clube")
        clubes = cursor.fetchall()
        
        # Pega todas as partidas
        cursor.execute("SELECT * FROM Partida")
        partidas = cursor.fetchall()
        
        # Pega todos os cartões de jogadores
        cursor.execute("""
            SELECT j.id_clube, c.tipo_cartao
            FROM Cartao c
            JOIN Jogador j ON c.id_jogador = j.id_jogador
        """)
        cartoes = cursor.fetchall()

        # Estrutura para armazenar as estatísticas de cada time
        stats = defaultdict(lambda: {
            'P': 0, 'J': 0, 'V': 0, 'E': 0, 'D': 0,
            'GP': 0, 'GC': 0, 'SG': 0, 'CV': 0, 'CA': 0
        })

        # Processa os cartões
        for cartao in cartoes:
            if cartao['tipo_cartao'] == 'amarelo':
                stats[cartao['id_clube']]['CA'] += 1
            elif cartao['tipo_cartao'] == 'vermelho':
                stats[cartao['id_clube']]['CV'] += 1

        # Processa as partidas
        for partida in partidas:
            id_mandante = partida['id_clube_mandante']
            id_visitante = partida['id_clube_visitante']
            placar_m = partida['placar_mandante']
            placar_v = partida['placar_visitante']

            # Jogos
            stats[id_mandante]['J'] += 1
            stats[id_visitante]['J'] += 1
            # Gols Pró/Contra
            stats[id_mandante]['GP'] += placar_m
            stats[id_mandante]['GC'] += placar_v
            stats[id_visitante]['GP'] += placar_v
            stats[id_visitante]['GC'] += placar_m

            # Pontos, Vitórias, Empates, Derrotas
            if placar_m > placar_v:
                stats[id_mandante]['P'] += 3
                stats[id_mandante]['V'] += 1
                stats[id_visitante]['D'] += 1
            elif placar_v > placar_m:
                stats[id_visitante]['P'] += 3
                stats[id_visitante]['V'] += 1
                stats[id_mandante]['D'] += 1
            else:
                stats[id_mandante]['P'] += 1
                stats[id_visitante]['P'] += 1
                stats[id_mandante]['E'] += 1
                stats[id_visitante]['E'] += 1
        
        # Monta a lista final com nome do clube e calcula saldo de gols
        tabela_final = []
        for id_clube, nome_clube in [(c['id_clube'], c['nome_clube']) for c in clubes]:
            s = stats[id_clube]
            s['nome'] = nome_clube
            s['SG'] = s['GP'] - s['GC']
            tabela_final.append(s)

        # Ordena a tabela com base nos critérios de desempate
        # Critérios: Pontos, Vitórias, Saldo de Gols, Gols Pró, Menor nº Cartões Vermelhos, Menor nº Cartões Amarelos
        tabela_ordenada = sorted(tabela_final, key=lambda x: (x['P'], x['V'], x['SG'], x['GP'], -x['CV'], -x['CA']), reverse=True)

        # Imprime a tabela de classificação
        print("\n--- TABELA DE CLASSIFICAÇÃO ---")
        print(f"{'Pos':<4} {'Time':<20} {'P':>3} {'J':>3} {'V':>3} {'E':>3} {'D':>3} {'GP':>4} {'GC':>4} {'SG':>4}")
        print("-" * 65)
        for i, time in enumerate(tabela_ordenada, 1):
            print(f"{i:<4} {time['nome']:<20} {time['P']:>3} {time['J']:>3} {time['V']:>3} {time['E']:>3} {time['D']:>3} {time['GP']:>4} {time['GC']:>4} {time['SG']:>4}")

    except sqlite3.Error as e:
        print(f"Erro ao calcular a classificação: {e}")
    finally:
        if conn:
            conn.close()


def main():
    """Função principal que exibe o menu e gerencia a entrada do usuário."""
    while True:
        print("\n===== MENU - CAMPEONATO DE FUTEBOL 2025 =====")
        print("1) Informações de um time")
        print("2) Artilharia do campeonato")
        print("3) Ranking de assistências")
        print("4) Ranking de cartões amarelos")
        print("5) Ranking de cartões vermelhos")
        print("6) Tabela de classificação")
        print("0) Sair")
        
        escolha = input("Escolha uma opção: ")

        if escolha == '1':
            informacoes_time()
        elif escolha == '2':
            mostrar_artilharia()
        elif escolha == '3':
            mostrar_assistencias()
        elif escolha == '4':
            mostrar_cartoes_amarelos()
        elif escolha == '5':
            mostrar_cartoes_vermelhos()
        elif escolha == '6':
            mostrar_classificacao()
        elif escolha == '0':
            print("Saindo do sistema. Até mais!")
            break
        else:
            print("Opção inválida. Tente novamente.")

if __name__ == "__main__":
    main()