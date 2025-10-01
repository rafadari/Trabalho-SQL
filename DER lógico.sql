CREATE DATABASE IF NOT EXISTS MobilidadeUrbana;
USE MobilidadeUrbana;

CREATE TABLE Usuario (
    id_usuario INT PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    cpf VARCHAR(20) UNIQUE NOT NULL,
    data_nasc DATE
);

CREATE TABLE Bilhete (
    id_bilhete INT PRIMARY KEY,
    saldo DECIMAL(10,2) DEFAULT 0,
    validade DATE
);

CREATE TABLE Veiculo (
    id_veiculo INT PRIMARY KEY,
    placa VARCHAR(20) UNIQUE NOT NULL,
    tipo VARCHAR(50),
    capacidade INT
);

CREATE TABLE Autoridade (
    id_autoridade INT PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    setor VARCHAR(100)
);

CREATE TABLE Rota (
    id_rota INT PRIMARY KEY,
    origem VARCHAR(100),
    destino VARCHAR(100),
    distancia DECIMAL(10,2)
);

CREATE TABLE Parada (
    id_parada INT PRIMARY KEY,
    nome VARCHAR(100),
    localizacao VARCHAR(150)
);

CREATE TABLE Utiliza (
    id_utiliza INT PRIMARY KEY,
    id_usuario INT NOT NULL,
    id_bilhete INT NOT NULL,
    id_veiculo INT NOT NULL,
    horario DATETIME,
    forma_pagamento VARCHAR(50),
    FOREIGN KEY (id_usuario) REFERENCES Usuario(id_usuario),
    FOREIGN KEY (id_bilhete) REFERENCES Bilhete(id_bilhete),
    FOREIGN KEY (id_veiculo) REFERENCES Veiculo(id_veiculo)
);

CREATE TABLE Opera_em (
    id_opera INT PRIMARY KEY,
    id_veiculo INT NOT NULL,
    id_rota INT NOT NULL,
    FOREIGN KEY (id_veiculo) REFERENCES Veiculo(id_veiculo),
    FOREIGN KEY (id_rota) REFERENCES Rota(id_rota)
);

CREATE TABLE Passa_por (
    id_passa INT PRIMARY KEY,
    id_rota INT NOT NULL,
    id_parada INT NOT NULL,
    FOREIGN KEY (id_rota) REFERENCES Rota(id_rota),
    FOREIGN KEY (id_parada) REFERENCES Parada(id_parada)
);

CREATE TABLE Gerencia (
    id_gerencia INT PRIMARY KEY,
    id_autoridade INT NOT NULL,
    id_veiculo INT NOT NULL,
    FOREIGN KEY (id_autoridade) REFERENCES Autoridade(id_autoridade),
    FOREIGN KEY (id_veiculo) REFERENCES Veiculo(id_veiculo)
);
