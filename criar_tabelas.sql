-- Ativa a verificação de chaves estrangeiras (importante para integridade)
PRAGMA foreign_keys = ON;

-- Tabela Estadio: Criada antes de Clube, pois é referenciada
CREATE TABLE Estadio (
    id_estadio INTEGER PRIMARY KEY,
    nome_estadio TEXT NOT NULL,
    cidade TEXT
);

-- Tabela Clube: Agora com a coluna id_estadio_sede
CREATE TABLE Clube (
    id_clube INTEGER PRIMARY KEY,
    nome_clube TEXT NOT NULL UNIQUE,
    id_estadio_sede INTEGER NOT NULL,
    FOREIGN KEY (id_estadio_sede) REFERENCES Estadio (id_estadio)
);

-- Tabela Treinador: Armazena os treinadores e sua associação com um clube
CREATE TABLE Treinador (
    id_treinador INTEGER PRIMARY KEY,
    nome_treinador TEXT NOT NULL,
    id_clube INTEGER,
    FOREIGN KEY (id_clube) REFERENCES Clube (id_clube)
);

-- Tabela Jogador: Armazena os jogadores, sua posição e clube
CREATE TABLE Jogador (
    id_jogador INTEGER PRIMARY KEY,
    nome_jogador TEXT NOT NULL,
    posicao TEXT,
    id_clube INTEGER,
    FOREIGN KEY (id_clube) REFERENCES Clube (id_clube)
);

-- Tabela Partida: Registra os detalhes de cada partida
CREATE TABLE Partida (
    id_partida INTEGER PRIMARY KEY,
    id_clube_mandante INTEGER NOT NULL,
    id_clube_visitante INTEGER NOT NULL,
    id_estadio INTEGER NOT NULL,
    placar_mandante INTEGER,
    placar_visitante INTEGER,
    data_partida TEXT, -- Formato recomendado: 'AAAA-MM-DD'
    FOREIGN KEY (id_clube_mandante) REFERENCES Clube (id_clube),
    FOREIGN KEY (id_clube_visitante) REFERENCES Clube (id_clube),
    FOREIGN KEY (id_estadio) REFERENCES Estadio (id_estadio)
);

-- Tabela Cartao: Registra os cartões aplicados em uma partida
CREATE TABLE Cartao (
    id_cartao INTEGER PRIMARY KEY,
    id_partida INTEGER NOT NULL,
    id_jogador INTEGER,
    id_treinador INTEGER,
    tipo_cartao TEXT NOT NULL CHECK (tipo_cartao IN ('amarelo', 'vermelho')),
    minuto INTEGER,
    FOREIGN KEY (id_partida) REFERENCES Partida (id_partida),
    FOREIGN KEY (id_jogador) REFERENCES Jogador (id_jogador),
    FOREIGN KEY (id_treinador) REFERENCES Treinador (id_treinador)
);

-- Tabela Gol: Registra os gols de cada partida
CREATE TABLE Gol (
    id_gol INTEGER PRIMARY KEY,
    id_partida INTEGER NOT NULL,
    id_jogador INTEGER NOT NULL,
    minuto INTEGER,
    FOREIGN KEY (id_partida) REFERENCES Partida (id_partida),
    FOREIGN KEY (id_jogador) REFERENCES Jogador (id_jogador)
);

-- Tabela Assistencia: Registra as assistências para gol em cada partida
CREATE TABLE Assistencia (
    id_assistencia INTEGER PRIMARY KEY,
    id_partida INTEGER NOT NULL,
    id_jogador INTEGER NOT NULL,
    minuto INTEGER,
    FOREIGN KEY (id_partida) REFERENCES Partida (id_partida),
    FOREIGN KEY (id_jogador) REFERENCES Jogador (id_jogador)
);