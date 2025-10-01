CREATE TABLE Usuario (
    id_usuario INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    data_nascimento DATE
);

CREATE TABLE CartaoTransporte (
    id_cartao INT AUTO_INCREMENT PRIMARY KEY,
    saldo DECIMAL(10,2) DEFAULT 0.00,
    tipo_cartao ENUM('Comum', 'Estudante', 'Idoso', 'Especial') NOT NULL,
    id_usuario INT,
    FOREIGN KEY (id_usuario) REFERENCES Usuario(id_usuario)
);

CREATE TABLE ModalTransporte (
    id_modal INT AUTO_INCREMENT PRIMARY KEY,
    tipo ENUM('Ônibus', 'Metrô', 'Bicicleta', 'VLT') NOT NULL,
    capacidade INT
);

CREATE TABLE Rota (
    id_rota INT AUTO_INCREMENT PRIMARY KEY,
    nome_rota VARCHAR(100) NOT NULL,
    id_modal INT,
    FOREIGN KEY (id_modal) REFERENCES ModalTransporte(id_modal)
);

CREATE TABLE PontoParada (
    id_ponto INT AUTO_INCREMENT PRIMARY KEY,
    nome_ponto VARCHAR(100) NOT NULL,
    localizacao VARCHAR(255)
);
--asociação entre parada e rota--
CREATE TABLE Rota_Ponto (
    id_rota INT,
    id_ponto INT,
    ordem INT,
    PRIMARY KEY (id_rota, id_ponto),
    FOREIGN KEY (id_rota) REFERENCES Rota(id_rota),
    FOREIGN KEY (id_ponto) REFERENCES PontoParada(id_ponto)
);

CREATE TABLE Viagem (
    id_viagem INT AUTO_INCREMENT PRIMARY KEY,
    data_hora DATETIME NOT NULL,
    id_cartao INT,
    id_rota INT,
    id_modal INT,
    FOREIGN KEY (id_cartao) REFERENCES CartaoTransporte(id_cartao),
    FOREIGN KEY (id_rota) REFERENCES Rota(id_rota),
    FOREIGN KEY (id_modal) REFERENCES ModalTransporte(id_modal)
);
