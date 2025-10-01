-- Criação do Banco de Dados
CREATE DATABASE IF NOT EXISTS MobilidadeUrbana;
USE MobilidadeUrbana;

-- Tabelas
CREATE TABLE IF NOT EXISTS Usuario (
    id_usuario INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    cpf VARCHAR(20) UNIQUE NOT NULL,
    data_nasc DATE
);

CREATE TABLE IF NOT EXISTS Bilhete (
    id_bilhete INT AUTO_INCREMENT PRIMARY KEY,
    saldo DECIMAL(10,2) DEFAULT 0,
    validade DATE
);

CREATE TABLE IF NOT EXISTS Veiculo (
    id_veiculo INT AUTO_INCREMENT PRIMARY KEY,
    placa VARCHAR(20) UNIQUE NOT NULL,
    tipo VARCHAR(50),
    capacidade INT
);

CREATE TABLE IF NOT EXISTS Autoridade (
    id_autoridade INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    setor VARCHAR(100)
);

CREATE TABLE IF NOT EXISTS Rota (
    id_rota INT AUTO_INCREMENT PRIMARY KEY,
    origem VARCHAR(100),
    destino VARCHAR(100),
    distancia DECIMAL(10,2)
);

CREATE TABLE IF NOT EXISTS Parada (
    id_parada INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(100),
    localizacao VARCHAR(150)
);

CREATE TABLE IF NOT EXISTS Utiliza (
    id_utiliza INT AUTO_INCREMENT PRIMARY KEY,
    id_usuario INT NOT NULL,
    id_bilhete INT NOT NULL,
    id_veiculo INT NOT NULL,
    horario DATETIME,
    forma_pagamento VARCHAR(50),
    FOREIGN KEY (id_usuario) REFERENCES Usuario(id_usuario),
    FOREIGN KEY (id_bilhete) REFERENCES Bilhete(id_bilhete),
    FOREIGN KEY (id_veiculo) REFERENCES Veiculo(id_veiculo)
);

CREATE TABLE IF NOT EXISTS Opera_em (
    id_opera INT AUTO_INCREMENT PRIMARY KEY,
    id_veiculo INT NOT NULL,
    id_rota INT NOT NULL,
    FOREIGN KEY (id_veiculo) REFERENCES Veiculo(id_veiculo),
    FOREIGN KEY (id_rota) REFERENCES Rota(id_rota)
);

CREATE TABLE IF NOT EXISTS Passa_por (
    id_passa INT AUTO_INCREMENT PRIMARY KEY,
    id_rota INT NOT NULL,
    id_parada INT NOT NULL,
    FOREIGN KEY (id_rota) REFERENCES Rota(id_rota),
    FOREIGN KEY (id_parada) REFERENCES Parada(id_parada)
);

CREATE TABLE IF NOT EXISTS Gerencia (
    id_gerencia INT AUTO_INCREMENT PRIMARY KEY,
    id_autoridade INT NOT NULL,
    id_veiculo INT NOT NULL,
    FOREIGN KEY (id_autoridade) REFERENCES Autoridade(id_autoridade),
    FOREIGN KEY (id_veiculo) REFERENCES Veiculo(id_veiculo)
);

-- PROCEDIMENTOS ARMAZENADOS PARA SELECT E UPDATE

-- PROCEDIMENTO PARA SELECT: USUARIO
DELIMITER $$

CREATE PROCEDURE SelectUsuario (IN usuario_id INT)
BEGIN
    SELECT * FROM Usuario WHERE id_usuario = usuario_id;
END $$

-- PROCEDIMENTO PARA UPDATE: USUARIO
CREATE PROCEDURE UpdateUsuario (IN usuario_id INT, IN novo_nome VARCHAR(100), IN novo_cpf VARCHAR(20), IN nova_data_nasc DATE)
BEGIN
    UPDATE Usuario
    SET nome = novo_nome, cpf = novo_cpf, data_nasc = nova_data_nasc
    WHERE id_usuario = usuario_id;
END $$

-- PROCEDIMENTO PARA SELECT: BILHETE
CREATE PROCEDURE SelectBilhete (IN bilhete_id INT)
BEGIN
    SELECT * FROM Bilhete WHERE id_bilhete = bilhete_id;
END $$

-- PROCEDIMENTO PARA UPDATE: BILHETE
CREATE PROCEDURE UpdateBilhete (IN bilhete_id INT, IN novo_saldo DECIMAL(10,2), IN nova_validade DATE)
BEGIN
    UPDATE Bilhete
    SET saldo = novo_saldo, validade = nova_validade
    WHERE id_bilhete = bilhete_id;
END $$

-- PROCEDIMENTO PARA SELECT: VEICULO
CREATE PROCEDURE SelectVeiculo (IN veiculo_id INT)
BEGIN
    SELECT * FROM Veiculo WHERE id_veiculo = veiculo_id;
END $$

-- PROCEDIMENTO PARA UPDATE: VEICULO
CREATE PROCEDURE UpdateVeiculo (IN veiculo_id INT, IN nova_placa VARCHAR(20), IN novo_tipo VARCHAR(50), IN nova_capacidade INT)
BEGIN
    UPDATE Veiculo
    SET placa = nova_placa, tipo = novo_tipo, capacidade = nova_capacidade
    WHERE id_veiculo = veiculo_id;
END $$

-- PROCEDIMENTO PARA SELECT: AUTORIDADE
CREATE PROCEDURE SelectAutoridade (IN autoridade_id INT)
BEGIN
    SELECT * FROM Autoridade WHERE id_autoridade = autoridade_id;
END $$

-- PROCEDIMENTO PARA UPDATE: AUTORIDADE
CREATE PROCEDURE UpdateAutoridade (IN autoridade_id INT, IN novo_nome VARCHAR(100), IN novo_setor VARCHAR(100))
BEGIN
    UPDATE Autoridade
    SET nome = novo_nome, setor = novo_setor
    WHERE id_autoridade = autoridade_id;
END $$

-- PROCEDIMENTO PARA SELECT: ROTA
CREATE PROCEDURE SelectRota (IN rota_id INT)
BEGIN
    SELECT * FROM Rota WHERE id_rota = rota_id;
END $$

-- PROCEDIMENTO PARA UPDATE: ROTA
CREATE PROCEDURE UpdateRota (IN rota_id INT, IN nova_origem VARCHAR(100), IN novo_destino VARCHAR(100), IN nova_distancia DECIMAL(10,2))
BEGIN
    UPDATE Rota
    SET origem = nova_origem, destino = novo_destino, distancia = nova_distancia
    WHERE id_rota = rota_id;
END $$

-- PROCEDIMENTO PARA SELECT: PARADA
CREATE PROCEDURE SelectParada (IN parada_id INT)
BEGIN
    SELECT * FROM Parada WHERE id_parada = parada_id;
END $$

-- PROCEDIMENTO PARA UPDATE: PARADA
CREATE PROCEDURE UpdateParada (IN parada_id INT, IN novo_nome VARCHAR(100), IN nova_localizacao VARCHAR(150))
BEGIN
    UPDATE Parada
    SET nome = novo_nome, localizacao = nova_localizacao
    WHERE id_parada = parada_id;
END $$

-- PROCEDIMENTO PARA SELECT: UTILIZA
CREATE PROCEDURE SelectUtiliza (IN utiliza_id INT)
BEGIN
    SELECT * FROM Utiliza WHERE id_utiliza = utiliza_id;
END $$

-- PROCEDIMENTO PARA UPDATE: UTILIZA
CREATE PROCEDURE UpdateUtiliza (IN utiliza_id INT, IN id_usuario INT, IN id_bilhete INT, IN id_veiculo INT, IN novo_horario DATETIME, IN nova_forma_pagamento VARCHAR(50))
BEGIN
    UPDATE Utiliza
    SET id_usuario = id_usuario, id_bilhete = id_bilhete, id_veiculo = id_veiculo, horario = novo_horario, forma_pagamento = nova_forma_pagamento
    WHERE id_utiliza = utiliza_id;
END $$

-- PROCEDIMENTO PARA SELECT: OPERA_EM
CREATE PROCEDURE SelectOperaEm (IN opera_id INT)
BEGIN
    SELECT * FROM Opera_em WHERE id_opera = opera_id;
END $$

-- PROCEDIMENTO PARA UPDATE: OPERA_EM
CREATE PROCEDURE UpdateOperaEm (IN opera_id INT, IN id_veiculo INT, IN id_rota INT)
BEGIN
    UPDATE Opera_em
    SET id_veiculo = id_veiculo, id_rota = id_rota
    WHERE id_opera = opera_id;
END $$

-- PROCEDIMENTO PARA SELECT: PASSA_POR
CREATE PROCEDURE SelectPassaPor (IN passa_id INT)
BEGIN
    SELECT * FROM Passa_por WHERE id_passa = passa_id;
END $$

-- PROCEDIMENTO PARA UPDATE: PASSA_POR
CREATE PROCEDURE UpdatePassaPor (IN passa_id INT, IN id_rota INT, IN id_parada INT)
BEGIN
    UPDATE Passa_por
    SET id_rota = id_rota, id_parada = id_parada
    WHERE id_passa = passa_id;
END $$

-- PROCEDIMENTO PARA SELECT: GERENCIA
CREATE PROCEDURE SelectGerencia (IN gerencia_id INT)
BEGIN
    SELECT * FROM Gerencia WHERE id_gerencia = gerencia_id;
END $$

-- PROCEDIMENTO PARA UPDATE: GERENCIA
CREATE PROCEDURE UpdateGerencia (IN gerencia_id INT, IN id_autoridade INT, IN id_veiculo INT)
BEGIN
    UPDATE Gerencia
    SET id_autoridade = id_autoridade, id_veiculo = id_veiculo
    WHERE id_gerencia = gerencia_id;
END $$

DELIMITER ;
