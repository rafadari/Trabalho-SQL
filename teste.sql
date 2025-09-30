CREATE DATABASE IF NOT EXISTS MobilidadeUrbana;
USE MobilidadeUrbana;

CREATE TABLE Usuario (
    id_usuario INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    telefone VARCHAR(20),
    email VARCHAR(100)
);

CREATE TABLE Transporte (
    id_transporte INT AUTO_INCREMENT PRIMARY KEY,
    tipo VARCHAR(50) NOT NULL, -- Ônibus, Metrô, Bicicleta
    identificacao VARCHAR(50)  -- Número do ônibus, linha do metrô, id da bike
);

CREATE TABLE Rota (
    id_rota INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    origem VARCHAR(100),
    destino VARCHAR(100)
);

CREATE TABLE Viagem (
    id_viagem INT AUTO_INCREMENT PRIMARY KEY,
    id_usuario INT,
    id_transporte INT,
    id_rota INT,
    data_hora DATETIME NOT NULL,
    status VARCHAR(20) DEFAULT 'Em andamento',
    FOREIGN KEY (id_usuario) REFERENCES Usuario(id_usuario),
    FOREIGN KEY (id_transporte) REFERENCES Transporte(id_transporte),
    FOREIGN KEY (id_rota) REFERENCES Rota(id_rota)
);

CREATE TABLE Pagamento (
    id_pagamento INT AUTO_INCREMENT PRIMARY KEY,
    id_viagem INT,
    valor DECIMAL(10,2) NOT NULL,
    metodo_pagamento VARCHAR(50),
    data_pagamento DATE,
    FOREIGN KEY (id_viagem) REFERENCES Viagem(id_viagem)
);
