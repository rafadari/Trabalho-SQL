-- Criação do Banco de Dados
CREATE DATABASE IF NOT EXISTS MobilidadeUrbana;
USE MobilidadeUrbana;

-- Tabelas
CREATE TABLE Usuario (
    id_usuario INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    cpf VARCHAR(11) UNIQUE NOT NULL,
    data_nasc DATE NOT NULL
);

CREATE TABLE Bilhete (
    id_bilhete INT AUTO_INCREMENT PRIMARY KEY,
    saldo DECIMAL(10,2) DEFAULT 0,
    validade DATE NOT NULL
);

CREATE TABLE Veiculo (
    id_veiculo INT AUTO_INCREMENT PRIMARY KEY,
    placa VARCHAR(20) UNIQUE NOT NULL,
    tipo VARCHAR(50) NOT NULL,
    capacidade INT NOT NULL
);

CREATE TABLE Autoridade (
    id_autoridade INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    setor VARCHAR(100) NOT NULL
);

CREATE TABLE Rota (
    id_rota INT AUTO_INCREMENT PRIMARY KEY,
    origem VARCHAR(100) NOT NULL,
    destino VARCHAR(100) NOT NULL,
    distancia DECIMAL(10,2) NOT NULL
);

CREATE TABLE Parada (
    id_parada INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    localizacao VARCHAR(150) NOT NULL
);

CREATE TABLE Utiliza (
    id_utiliza INT AUTO_INCREMENT PRIMARY KEY,
    id_usuario INT NOT NULL,
    id_bilhete INT NOT NULL,
    id_veiculo INT NOT NULL,
    horario DATETIME NOT NULL,
    forma_pagamento VARCHAR(50),
    FOREIGN KEY (id_usuario) REFERENCES Usuario(id_usuario),
    FOREIGN KEY (id_bilhete) REFERENCES Bilhete(id_bilhete),
    FOREIGN KEY (id_veiculo) REFERENCES Veiculo(id_veiculo)
);

CREATE TABLE Opera_em (
    id_opera INT AUTO_INCREMENT PRIMARY KEY,
    id_veiculo INT NOT NULL,
    id_rota INT NOT NULL,
    FOREIGN KEY (id_veiculo) REFERENCES Veiculo(id_veiculo),
    FOREIGN KEY (id_rota) REFERENCES Rota(id_rota)
);

CREATE TABLE Passa_por (
    id_passa INT AUTO_INCREMENT PRIMARY KEY,
    id_rota INT NOT NULL,
    id_parada INT NOT NULL,
    FOREIGN KEY (id_rota) REFERENCES Rota(id_rota),
    FOREIGN KEY (id_parada) REFERENCES Parada(id_parada)
);

CREATE TABLE Gerencia (
    id_gerencia INT AUTO_INCREMENT PRIMARY KEY,
    id_autoridade INT NOT NULL,
    id_veiculo INT NOT NULL,
    FOREIGN KEY (id_autoridade) REFERENCES Autoridade(id_autoridade),
    FOREIGN KEY (id_veiculo) REFERENCES Veiculo(id_veiculo)
);


INSERT INTO Usuario (nome, cpf, data_nasc) VALUES
('João Silva', '12345678901', '1990-05-10'),
('Maria Souza', '98765432100', '1985-11-22'),
('Pedro Oliveira', '11122233344', '2000-03-15'),
('Ana Costa', '55566677788', '1995-07-29');

-- Bilhetes
INSERT INTO Bilhete (saldo, validade) VALUES
(50.00, '2025-12-31'),
(30.00, '2025-06-30'),
(15.50, '2025-03-15'),
(100.00, '2026-01-10');

-- Veículos
INSERT INTO Veiculo (placa, tipo, capacidade) VALUES
('ABC1234', 'Ônibus', 50),
('XYZ9876', 'Metrô', 200),
('JKL4321', 'VLT', 120),
('DEF5678', 'Ônibus', 45);

-- Autoridades
INSERT INTO Autoridade (nome, setor) VALUES
('Carlos Andrade', 'Fiscalização'),
('Ana Lima', 'Administração'),
('Roberto Nunes', 'Segurança'),
('Fernanda Alves', 'Planejamento');

-- Rotas
INSERT INTO Rota (origem, destino, distancia) VALUES
('Estação Central', 'Bairro Novo', 12.5),
('Rodoviária', 'Aeroporto', 8.7),
('Praça da Sé', 'Universidade', 5.3),
('Shopping Norte', 'Estação Sul', 15.2);

-- Paradas
INSERT INTO Parada (nome, localizacao) VALUES
('Estação Central', 'Centro da Cidade'),
('Bairro Novo', 'Zona Norte'),
('Rodoviária', 'Zona Oeste'),
('Aeroporto', 'Zona Leste'),
('Praça da Sé', 'Centro Histórico'),
('Universidade', 'Zona Universitária'),
('Shopping Norte', 'Zona Norte'),
('Estação Sul', 'Zona Sul');

INSERT INTO Utiliza (id_usuario, id_bilhete, id_veiculo, horario, forma_pagamento) VALUES
(1, 1, 1, '2025-01-10 08:15:00', 'cartao'),
(2, 2, 2, '2025-02-20 09:00:00', 'dinheiro'),
(3, 3, 3, '2025-03-15 17:30:00', 'app'),
(1, 2, 1, '2025-04-01 12:00:00', 'cartao');

INSERT INTO Opera_em (id_veiculo, id_rota) VALUES
(1, 1),
(2, 2),
(3, 3),
(4, 1);

INSERT INTO Passa_por (id_rota, id_parada) VALUES
(1, 1),
(1, 2),
(2, 3),
(2, 4),
(3, 5),
(3, 6),
(4, 7),
(4, 8);

INSERT INTO Gerencia (id_autoridade, id_veiculo) VALUES
(1, 1),
(1, 2),
(2, 3),
(3, 4);

-- PROCEDIMENTOS ARMAZENADOS PARA SELECT E UPDATE

-- PROCEDIMENTO PARA SELECT: USUARIO
DELIMITER //

CREATE PROCEDURE SelectUsuario (IN p_usuario_id INT)
BEGIN
    SELECT * FROM Usuario WHERE id_usuario = p_usuario_id;
END //
DELIMITER ;

-- PROCEDIMENTO PARA UPDATE: USUARIO
DELIMITER //
CREATE PROCEDURE UpdateUsuario (IN p_usuario_id INT, IN p_novo_nome VARCHAR(100), IN p_novo_cpf VARCHAR(20), IN p_nova_data_nasc DATE)
BEGIN
    UPDATE Usuario
    SET nome = p_novo_nome, cpf = p_novo_cpf, data_nasc = p_nova_data_nasc
    WHERE id_usuario = p_usuario_id;
END //
DELIMITER ;

-- PROCEDIMENTO PARA SELECT: BILHETE
DELIMITER //
CREATE PROCEDURE SelectBilhete (IN p_bilhete_id INT)
BEGIN
    SELECT * FROM Bilhete WHERE id_bilhete = p_bilhete_id;
END //
DELIMITER ;

-- PROCEDIMENTO PARA UPDATE: BILHETE
DELIMITER //
CREATE PROCEDURE UpdateBilhete (IN p_bilhete_id INT, IN p_novo_saldo DECIMAL(10,2), IN p_nova_validade DATE)
BEGIN
    UPDATE Bilhete
    SET saldo = p_novo_saldo, validade = p_nova_validade
    WHERE id_bilhete = p_bilhete_id;
END //
DELIMITER ;

-- PROCEDIMENTO PARA SELECT: VEICULO
DELIMITER //
CREATE PROCEDURE SelectVeiculo (IN p_veiculo_id INT)
BEGIN
    SELECT * FROM Veiculo WHERE id_veiculo = p_veiculo_id;
END //
DELIMITER ;

-- PROCEDIMENTO PARA UPDATE: VEICULO
DELIMITER //
CREATE PROCEDURE UpdateVeiculo (IN p_veiculo_id INT, IN p_nova_placa VARCHAR(20), IN p_novo_tipo VARCHAR(50), IN p_nova_capacidade INT)
BEGIN
    UPDATE Veiculo
    SET placa = p_nova_placa, tipo = p_novo_tipo, capacidade = p_nova_capacidade
    WHERE id_veiculo = p_veiculo_id;
END //
DELIMITER ;

-- PROCEDIMENTO PARA SELECT: AUTORIDADE
DELIMITER //
CREATE PROCEDURE SelectAutoridade (IN p_autoridade_id INT)
BEGIN
    SELECT * FROM Autoridade WHERE id_autoridade = p_autoridade_id;
END //
DELIMITER ;

-- PROCEDIMENTO PARA UPDATE: AUTORIDADE
DELIMITER //
CREATE PROCEDURE UpdateAutoridade (IN p_autoridade_id INT, IN p_novo_nome VARCHAR(100), IN p_novo_setor VARCHAR(100))
BEGIN
    UPDATE Autoridade
    SET nome = p_novo_nome, setor = p_novo_setor
    WHERE id_autoridade = p_autoridade_id;
END //
DELIMITER ;

-- PROCEDIMENTO PARA SELECT: ROTA
DELIMITER //
CREATE PROCEDURE SelectRota (IN p_rota_id INT)
BEGIN
    SELECT * FROM Rota WHERE id_rota = p_rota_id;
END //
DELIMITER ;

-- PROCEDIMENTO PARA UPDATE: ROTA
DELIMITER //
CREATE PROCEDURE UpdateRota (IN p_rota_id INT, IN p_nova_origem VARCHAR(100), IN p_novo_destino VARCHAR(100), IN p_nova_distancia DECIMAL(10,2))
BEGIN
    UPDATE Rota
    SET origem = p_nova_origem, destino = p_novo_destino, distancia = p_nova_distancia
    WHERE id_rota = p_rota_id;
END //
DELIMITER ;

-- PROCEDIMENTO PARA SELECT: PARADA
DELIMITER //
CREATE PROCEDURE SelectParada (IN p_parada_id INT)
BEGIN
    SELECT * FROM Parada WHERE id_parada = p_parada_id;
END //
DELIMITER ;

-- PROCEDIMENTO PARA UPDATE: PARADA
DELIMITER //
CREATE PROCEDURE UpdateParada (IN p_parada_id INT, IN p_novo_nome VARCHAR(100), IN p_nova_localizacao VARCHAR(150))
BEGIN
    UPDATE Parada
    SET nome = p_novo_nome, localizacao = p_nova_localizacao
    WHERE id_parada = p_parada_id;
END //
DELIMITER ;

-- PROCEDIMENTO PARA SELECT: UTILIZA
DELIMITER //
CREATE PROCEDURE SelectUtiliza (IN p_utiliza_id INT)
BEGIN
    SELECT * FROM Utiliza WHERE id_utiliza = p_utiliza_id;
END //
DELIMITER ;

-- PROCEDIMENTO PARA UPDATE: UTILIZA
DELIMITER //
CREATE PROCEDURE UpdateUtiliza (IN p_utiliza_id INT, IN p_id_usuario INT, IN p_id_bilhete INT, IN p_id_veiculo INT, IN p_novo_horario DATETIME, IN p_nova_forma_pagamento VARCHAR(50))
BEGIN
    UPDATE Utiliza
    SET id_usuario = p_id_usuario, id_bilhete = p_id_bilhete, id_veiculo = p_id_veiculo, horario = p_novo_horario, forma_pagamento = p_nova_forma_pagamento
    WHERE id_utiliza = p_utiliza_id;
END //
DELIMITER ;

-- PROCEDIMENTO PARA SELECT: OPERA_EM
DELIMITER //
CREATE PROCEDURE SelectOperaEm (IN p_opera_id INT)
BEGIN
    SELECT * FROM Opera_em WHERE id_opera = p_opera_id;
END //
DELIMITER ;

-- PROCEDIMENTO PARA UPDATE: OPERA_EM
DELIMITER //
CREATE PROCEDURE UpdateOperaEm (IN p_opera_id INT, IN p_id_veiculo INT, IN p_id_rota INT)
BEGIN
    UPDATE Opera_em
    SET id_veiculo = p_id_veiculo, id_rota = p_id_rota
    WHERE id_opera = p_opera_id;
END //
DELIMITER ;

-- PROCEDIMENTO PARA SELECT: PASSA_POR
DELIMITER //
CREATE PROCEDURE SelectPassaPor (IN p_passa_id INT)
BEGIN
    SELECT * FROM Passa_por WHERE id_passa = p_passa_id;
END //
DELIMITER ;

-- PROCEDIMENTO PARA UPDATE: PASSA_POR
DELIMITER //
CREATE PROCEDURE UpdatePassaPor (IN p_passa_id INT, IN p_id_rota INT, IN p_id_parada INT)
BEGIN
    UPDATE Passa_por
    SET id_rota = p_id_rota, id_parada = p_id_parada
    WHERE id_passa = p_passa_id;
END //
DELIMITER ;

-- PROCEDIMENTO PARA SELECT: GERENCIA
DELIMITER //
CREATE PROCEDURE SelectGerencia (IN p_gerencia_id INT)
BEGIN
    SELECT * FROM Gerencia WHERE id_gerencia = p_gerencia_id;
END //
DELIMITER ;

-- PROCEDIMENTO PARA UPDATE: GERENCIA
DELIMITER //
CREATE PROCEDURE UpdateGerencia (IN p_gerencia_id INT, IN p_id_autoridade INT, IN p_id_veiculo INT)
BEGIN
    UPDATE Gerencia
    SET id_autoridade = p_id_autoridade, p_id_veiculo = id_veiculo
    WHERE id_gerencia = p_gerencia_id;
END //
DELIMITER ;

-- Buscar rotas por origem
DELIMITER //
CREATE PROCEDURE BuscarRotasPorOrigem(IN p_origem VARCHAR(100))
BEGIN
    SELECT * FROM Rota
    WHERE origem = p_origem;
END //
DELIMITER ;

-- Listar veículos por tipo
DELIMITER //
CREATE PROCEDURE ListarVeiculosPorTipo(IN p_tipo VARCHAR(50))
BEGIN
    SELECT * FROM Veiculo
    WHERE tipo = p_tipo;
END //
DELIMITER ;
