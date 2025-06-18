-- Garante que as restrições de chave estrangeira estejam ativas
PRAGMA foreign_keys = ON;

-- ========== 1. CLUBES E ESTÁDIOS ==========

-- Estádios
INSERT INTO Estadio (id_estadio, nome_estadio, cidade) VALUES
(1, 'Maracanã', 'Rio de Janeiro'),
(2, 'Allianz Parque', 'São Paulo'),
(3, 'Neo Química Arena', 'São Paulo'),
(4, 'MorumBIS', 'São Paulo'),
(5, 'Arena do Grêmio', 'Porto Alegre'),
(6, 'Beira-Rio', 'Porto Alegre'),
(7, 'Arena MRV', 'Belo Horizonte'),
(8, 'Estádio Nilton Santos', 'Rio de Janeiro'),
(9, 'Ligga Arena', 'Curitiba');

-- Clubes
INSERT INTO Clube (id_clube, nome_clube, id_estadio_sede) VALUES
(1, 'Flamengo', 1),         -- Sede: Maracanã
(2, 'Palmeiras', 2),        -- Sede: Allianz Parque
(3, 'Corinthians', 3),      -- Sede: Neo Química Arena
(4, 'São Paulo', 4),        -- Sede: MorumBIS
(5, 'Grêmio', 5),           -- Sede: Arena do Grêmio
(6, 'Internacional', 6),    -- Sede: Beira-Rio
(7, 'Atlético Mineiro', 7), -- Sede: Arena MRV
(8, 'Fluminense', 1),       -- Sede: Maracanã
(9, 'Botafogo', 8),         -- Sede: Estádio Nilton Santos
(10, 'Athletico-PR', 9);    -- Sede: Ligga Arena

-- ========== 2. TREINADORES E JOGADORES ==========

-- Treinadores (Associados a cada clube)
INSERT INTO Treinador (id_treinador, nome_treinador, id_clube) VALUES
(1, 'Tite', 1),
(2, 'Abel Ferreira', 2),
(3, 'António Oliveira', 3),
(4, 'Luis Zubeldía', 4),
(5, 'Renato Portaluppi', 5),
(6, 'Eduardo Coudet', 6),
(7, 'Gabriel Milito', 7),
(8, 'Fernando Diniz', 8),
(9, 'Artur Jorge', 9),
(10, 'Cuca', 10);

-- Jogadores (4 jogadores por time)
-- Flamengo
INSERT INTO Jogador (nome_jogador, posicao, id_clube) VALUES
('Agustín Rossi', 'Goleiro', 1),
('Léo Pereira', 'Zagueiro', 1),
('De Arrascaeta', 'Meia', 1),
('Pedro', 'Atacante', 1);
-- Palmeiras
INSERT INTO Jogador (nome_jogador, posicao, id_clube) VALUES
('Weverton', 'Goleiro', 2),
('Gustavo Gómez', 'Zagueiro', 2),
('Raphael Veiga', 'Meia', 2),
('Endrick', 'Atacante', 2);
-- Corinthians
INSERT INTO Jogador (nome_jogador, posicao, id_clube) VALUES
('Cássio', 'Goleiro', 3),
('Félix Torres', 'Zagueiro', 3),
('Rodrigo Garro', 'Meia', 3),
('Yuri Alberto', 'Atacante', 3);
-- São Paulo
INSERT INTO Jogador (nome_jogador, posicao, id_clube) VALUES
('Rafael', 'Goleiro', 4),
('Arboleda', 'Zagueiro', 4),
('Lucas Moura', 'Meia', 4),
('Jonathan Calleri', 'Atacante', 4);
-- Grêmio
INSERT INTO Jogador (nome_jogador, posicao, id_clube) VALUES
('Agustín Marchesín', 'Goleiro', 5),
('Walter Kannemann', 'Zagueiro', 5),
('Franco Cristaldo', 'Meia', 5),
('Diego Costa', 'Atacante', 5);
-- Internacional
INSERT INTO Jogador (nome_jogador, posicao, id_clube) VALUES
('Sergio Rochet', 'Goleiro', 6),
('Vitão', 'Zagueiro', 6),
('Alan Patrick', 'Meia', 6),
('Enner Valencia', 'Atacante', 6);
-- Atlético Mineiro
INSERT INTO Jogador (nome_jogador, posicao, id_clube) VALUES
('Everson', 'Goleiro', 7),
('Jemerson', 'Zagueiro', 7),
('Gustavo Scarpa', 'Meia', 7),
('Hulk', 'Atacante', 7);
-- Fluminense
INSERT INTO Jogador (nome_jogador, posicao, id_clube) VALUES
('Fábio', 'Goleiro', 8),
('Felipe Melo', 'Zagueiro', 8),
('Ganso', 'Meia', 8),
('Germán Cano', 'Atacante', 8);
-- Botafogo
INSERT INTO Jogador (nome_jogador, posicao, id_clube) VALUES
('John', 'Goleiro', 9),
('Bastos', 'Zagueiro', 9),
('Eduardo', 'Meia', 9),
('Tiquinho Soares', 'Atacante', 9);
-- Athletico-PR
INSERT INTO Jogador (nome_jogador, posicao, id_clube) VALUES
('Bento', 'Goleiro', 10),
('Thiago Heleno', 'Zagueiro', 10),
('Fernandinho', 'Meia', 10),
('Pablo', 'Atacante', 10);


-- ========== 3. PARTIDAS ==========
INSERT INTO Partida (id_partida, id_clube_mandante, id_clube_visitante, id_estadio, placar_mandante, placar_visitante, data_partida) VALUES
(1, 1, 5, 1, 2, 1, '2024-05-10'),   -- Flamengo 2x1 Grêmio
(2, 2, 4, 2, 1, 1, '2024-05-11'),   -- Palmeiras 1x1 São Paulo
(3, 3, 7, 3, 0, 2, '2024-05-12'),   -- Corinthians 0x2 Atlético-MG
(4, 9, 8, 8, 3, 0, '2024-05-18'),   -- Botafogo 3x0 Fluminense
(5, 10, 6, 9, 2, 2, '2024-05-19'),  -- Athletico-PR 2x2 Internacional
(6, 5, 3, 5, 1, 0, '2024-05-25'),   -- Grêmio 1x0 Corinthians
(7, 4, 9, 4, 2, 2, '2024-05-26'),   -- São Paulo 2x2 Botafogo
(8, 6, 1, 6, 0, 1, '2024-06-01'),   -- Internacional 0x1 Flamengo
(9, 7, 2, 7, 3, 1, '2024-06-02'),   -- Atlético-MG 3x1 Palmeiras
(10, 8, 10, 1, 2, 0, '2024-06-08'), -- Fluminense 2x0 Athletico-PR (no Maracanã)
(11, 1, 3, 1, 1, 0, '2024-06-12'),  -- Flamengo 1x0 Corinthians
(12, 2, 5, 2, 3, 0, '2024-06-15'),  -- Palmeiras 3x0 Grêmio
(13, 4, 6, 4, 0, 0, '2024-06-16'),  -- São Paulo 0x0 Internacional
(14, 9, 7, 8, 1, 2, '2024-06-22'),  -- Botafogo 1x2 Atlético-MG
(15, 10, 1, 9, 2, 2, '2024-06-23'), -- Athletico-PR 2x2 Flamengo
(16, 3, 2, 3, 2, 1, '2024-06-29'),  -- Corinthians 2x1 Palmeiras
(17, 5, 6, 5, 2, 1, '2024-06-30'),  -- Grêmio 2x1 Internacional (Grenal)
(18, 8, 4, 1, 1, 3, '2024-07-06');  -- Fluminense 1x3 São Paulo


-- ========== 4. EVENTOS DAS PARTIDAS ==========

-- Partida 1: Flamengo 2x1 Grêmio
INSERT INTO Gol (id_partida, id_jogador, minuto) VALUES (1, 4, 32), (1, 3, 67), (1, 20, 85);
INSERT INTO Assistencia (id_partida, id_jogador, minuto) VALUES (1, 2, 32);
INSERT INTO Cartao (id_partida, id_jogador, tipo_cartao, minuto) VALUES (1, 18, 'amarelo', 55);
INSERT INTO Cartao (id_partida, id_treinador, tipo_cartao, minuto) VALUES (1, 1, 'amarelo', 70);

-- Partida 2: Palmeiras 1x1 São Paulo
INSERT INTO Gol (id_partida, id_jogador, minuto) VALUES (2, 7, 50), (2, 16, 78);
INSERT INTO Cartao (id_partida, id_jogador, tipo_cartao, minuto) VALUES (2, 6, 'amarelo', 40), (2, 14, 'amarelo', 60);

-- Partida 3: Corinthians 0x2 Atlético-MG
INSERT INTO Gol (id_partida, id_jogador, minuto) VALUES (3, 28, 44), (3, 28, 73);
INSERT INTO Assistencia (id_partida, id_jogador, minuto) VALUES (3, 27, 73);
INSERT INTO Cartao (id_partida, id_jogador, tipo_cartao, minuto) VALUES (3, 28, 'amarelo', 74);

-- Partida 4: Botafogo 3x0 Fluminense
INSERT INTO Gol (id_partida, id_jogador, minuto) VALUES (4, 36, 15), (4, 36, 51), (4, 35, 88);
INSERT INTO Cartao (id_partida, id_jogador, tipo_cartao, minuto) VALUES (4, 30, 'vermelho', 65);

-- Partida 5: Athletico-PR 2x2 Internacional
INSERT INTO Gol (id_partida, id_jogador, minuto) VALUES (5, 40, 22), (5, 24, 29), (5, 39, 66), (5, 23, 90);

-- Partida 6: Grêmio 1x0 Corinthians
INSERT INTO Gol (id_partida, id_jogador, minuto) VALUES (6, 19, 75);
INSERT INTO Cartao (id_partida, id_jogador, tipo_cartao, minuto) VALUES (6, 11, 'amarelo', 80);

-- Partida 7: São Paulo 2x2 Botafogo
INSERT INTO Gol (id_partida, id_jogador, minuto) VALUES (7, 15, 10), (7, 16, 45), (7, 36, 60), (7, 35, 82);
INSERT INTO Assistencia (id_partida, id_jogador, minuto) VALUES (7, 15, 45);

-- Partida 8: Internacional 0x1 Flamengo
INSERT INTO Gol (id_partida, id_jogador, minuto) VALUES (8, 4, 88);
INSERT INTO Cartao (id_partida, id_jogador, tipo_cartao, minuto) VALUES (8, 22, 'amarelo', 50), (8, 2, 'amarelo', 70);

-- Partida 9: Atlético-MG 3x1 Palmeiras
INSERT INTO Gol (id_partida, id_jogador, minuto) VALUES (9, 28, 25), (9, 28, 40), (9, 27, 68), (9, 7, 85);
INSERT INTO Cartao (id_partida, id_jogador, tipo_cartao, minuto) VALUES (9, 6, 'vermelho', 55);
INSERT INTO Cartao (id_partida, id_treinador, tipo_cartao, minuto) VALUES (9, 2, 'amarelo', 56);

-- Partida 10: Fluminense 2x0 Athletico-PR
INSERT INTO Gol (id_partida, id_jogador, minuto) VALUES (10, 32, 33), (10, 32, 58);
INSERT INTO Assistencia (id_partida, id_jogador, minuto) VALUES (10, 31, 58);
INSERT INTO Cartao (id_partida, id_jogador, tipo_cartao, minuto) VALUES (10, 38, 'amarelo', 77);

-- Partida 11: Flamengo 1x0 Corinthians
INSERT INTO Gol (id_partida, id_jogador, minuto) VALUES (11, 3, 9);
INSERT INTO Cartao (id_partida, id_jogador, tipo_cartao, minuto) VALUES (11, 10, 'amarelo', 25), (11, 12, 'amarelo', 85);

-- Partida 12: Palmeiras 3x0 Grêmio
INSERT INTO Gol (id_partida, id_jogador, minuto) VALUES (12, 7, 20), (12, 8, 48), (12, 8, 70);
INSERT INTO Assistencia (id_partida, id_jogador, minuto) VALUES (12, 7, 48);
INSERT INTO Cartao (id_partida, id_jogador, tipo_cartao, minuto) VALUES (12, 18, 'amarelo', 60);

-- Partida 13: São Paulo 0x0 Internacional
INSERT INTO Cartao (id_partida, id_jogador, tipo_cartao, minuto) VALUES (13, 23, 'amarelo', 30), (13, 14, 'amarelo', 35);
INSERT INTO Cartao (id_partida, id_treinador, tipo_cartao, minuto) VALUES (13, 6, 'amarelo', 90);

-- Partida 14: Botafogo 1x2 Atlético-MG
INSERT INTO Gol (id_partida, id_jogador, minuto) VALUES (14, 36, 12), (14, 28, 50), (14, 27, 89);
INSERT INTO Cartao (id_partida, id_jogador, tipo_cartao, minuto) VALUES (14, 34, 'amarelo', 63), (14, 26, 'amarelo', 78);

-- Partida 15: Athletico-PR 2x2 Flamengo
INSERT INTO Gol (id_partida, id_jogador, minuto) VALUES (15, 40, 5), (15, 4, 30), (15, 3, 65), (15, 39, 92);
INSERT INTO Cartao (id_partida, id_treinador, tipo_cartao, minuto) VALUES (15, 1, 'vermelho', 93);

-- Partida 16: Corinthians 2x1 Palmeiras
INSERT INTO Gol (id_partida, id_jogador, minuto) VALUES (16, 12, 44), (16, 11, 77), (16, 7, 91);
INSERT INTO Cartao (id_partida, id_jogador, tipo_cartao, minuto) VALUES (16, 6, 'amarelo', 50), (16, 12, 'amarelo', 78);

-- Partida 17: Grêmio 2x1 Internacional
INSERT INTO Gol (id_partida, id_jogador, minuto) VALUES (17, 20, 22), (17, 24, 45), (17, 19, 88);
INSERT INTO Cartao (id_partida, id_jogador, tipo_cartao, minuto) VALUES (17, 18, 'vermelho', 90), (17, 22, 'amarelo', 91);

-- Partida 18: Fluminense 1x3 São Paulo
INSERT INTO Gol (id_partida, id_jogador, minuto) VALUES (18, 32, 15), (18, 16, 30), (18, 16, 55), (18, 15, 80);
INSERT INTO Assistencia (id_partida, id_jogador, minuto) VALUES (18, 15, 55);
INSERT INTO Cartao (id_partida, id_jogador, tipo_cartao, minuto) VALUES (18, 30, 'amarelo', 60);
