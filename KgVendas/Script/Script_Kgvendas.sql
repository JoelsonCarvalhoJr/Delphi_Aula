/*
SETOR RESPONSAVEL.....:
DATA..................: 04/10/2022
AUTOR.................: Joelson Carvalho Junior
PROJETO...............: Sistema de Vendas
Usuário Banco de Dados: root
Senha Banco de Dados..: root
ÚLTIMA ALTERAÇÃO......:
ALTERADO POR..........:
-----------------------------------------------------------------------------------------------------------------------------

--  CAST( '2000000' AS UNSIGNED) --> 2000000
/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;



SET NAMES utf8;
SET CHARACTER_SET_CLIENT=utf8;
SET CHARACTER_SET_RESULTS=utf8;     

CREATE SCHEMA `kgvenda` DEFAULT CHARACTER SET utf8 ;

create table kgvenda.cliente(
   co_cliente   integer     not null AUTO_INCREMENT,   
   no_cliente   varchar(240)    not null,
   no_cidade    varchar(240),  
   no_uf        varchar(2),   

   primary key (co_cliente)
   
);

create table kgvenda.produto(
   co_produto                integer not null AUTO_INCREMENT,
   no_produto                varchar(240),      
   nu_valorvenda             decimal(15,2) null,  -- Valor venda
      
   primary key (co_produto)
   
);

create table kgvenda.dadosgerais(
   nu_pedido        integer not null AUTO_INCREMENT,      
   dt_emissao       datetime   not null,    
   co_cliente       integer,
   nu_valortotal    decimal(15,2) not null DEFAULT 0.0000,        
     
   primary key (nu_pedido),
   foreign key (co_cliente) references cliente(co_cliente)   
);


create table kgvenda.produtodopedido(
   nu_produtodopedido   integer not null AUTO_INCREMENT,      
   nu_pedido            integer not null,         
   co_produto           integer not null,         
   nu_quantidade        decimal(15,2) not null DEFAULT 0.0000,          
   nu_valorunitario     decimal(15,2) not null DEFAULT 0.0000,       
   nu_valortotal        decimal(15,2) not null DEFAULT 0.0000,        
     
   primary key (nu_produtodopedido),
   foreign key (nu_pedido) references dadosgerais(nu_pedido),
   foreign key (co_produto) references produto(co_produto)  
);


INSERT INTO `kgvenda`.`cliente` (`no_cliente`, `no_cidade`, `no_uf`) VALUES ('Amanda de Costa', 'Passa Tempo', 'MG');
INSERT INTO `kgvenda`.`cliente` (`no_cliente`, `no_cidade`, `no_uf`) VALUES ('Reginaldo Rosa', 'Arroio dos Ratos', 'RS');
INSERT INTO `kgvenda`.`cliente` (`no_cliente`, `no_cidade`, `no_uf`) VALUES ('Aeronauta Barata', 'Cidade de Espumoso', 'RS');
INSERT INTO `kgvenda`.`cliente` (`no_cliente`, `no_cidade`, `no_uf`) VALUES ('Agrícola Beterraba Areia', 'Ampére', 'PR');
INSERT INTO `kgvenda`.`cliente` (`no_cliente`, `no_cidade`, `no_uf`) VALUES ('Agrícola da Terra Fonseca', 'Jardim de Piranhas', 'RN');
INSERT INTO `kgvenda`.`cliente` (`no_cliente`, `no_cidade`, `no_uf`) VALUES ('Alce Barbuda', 'Solidão', 'PE');
INSERT INTO `kgvenda`.`cliente` (`no_cliente`, `no_cidade`, `no_uf`) VALUES ('Amado Amoroso', 'Ponto Chique', 'MG');
INSERT INTO `kgvenda`.`cliente` (`no_cliente`, `no_cidade`, `no_uf`) VALUES ('Amazonas Rio do Brasil Pimpão', 'Passa e Fica', 'RN');
INSERT INTO `kgvenda`.`cliente` (`no_cliente`, `no_cidade`, `no_uf`) VALUES ('América do Sul Brasil de Santana', 'São Gotardo', 'MG');
INSERT INTO `kgvenda`.`cliente` (`no_cliente`, `no_cidade`, `no_uf`) VALUES ('Artur Antonio', 'Abadiana', 'GO');
INSERT INTO `kgvenda`.`cliente` (`no_cliente`, `no_cidade`, `no_uf`) VALUES ('Claudio Cassio', 'Rio Verde', 'GO');
INSERT INTO `kgvenda`.`cliente` (`no_cliente`, `no_cidade`, `no_uf`) VALUES ('Pedro Peter', 'Acreuna', 'GO');
INSERT INTO `kgvenda`.`cliente` (`no_cliente`, `no_cidade`, `no_uf`) VALUES ('Valdomiro do Chapeu', 'Mineiros', 'GO');
INSERT INTO `kgvenda`.`cliente` (`no_cliente`, `no_cidade`, `no_uf`) VALUES ('Fagundes Fabio', 'Pau Terra', 'GO');
INSERT INTO `kgvenda`.`cliente` (`no_cliente`, `no_cidade`, `no_uf`) VALUES ('Joarge Malamado', 'Silvania', 'GO');
INSERT INTO `kgvenda`.`cliente` (`no_cliente`, `no_cidade`, `no_uf`) VALUES ('Custorio Custoso', 'Catalão', 'GO');
INSERT INTO `kgvenda`.`cliente` (`no_cliente`, `no_cidade`, `no_uf`) VALUES ('Cladio Clerio', 'Ouvidor', 'GO');
INSERT INTO `kgvenda`.`cliente` (`no_cliente`, `no_cidade`, `no_uf`) VALUES ('Armando Volta', 'Nerópolis', 'GO');
INSERT INTO `kgvenda`.`cliente` (`no_cliente`, `no_cidade`, `no_uf`) VALUES ('Jose Sobreu', 'Goiania', 'GO');
INSERT INTO `kgvenda`.`cliente` (`no_cliente`, `no_cidade`, `no_uf`) VALUES ('Odilon Odilio', 'Santa Rosa', 'GO');


INSERT INTO `kgvenda`.`produto` (`no_produto`, `nu_valorvenda`) VALUES ('Arroz', '18.22');
INSERT INTO `kgvenda`.`produto` (`no_produto`, `nu_valorvenda`) VALUES ('Feijão', '1.38');
INSERT INTO `kgvenda`.`produto` (`no_produto`, `nu_valorvenda`) VALUES ('Macarrão', '0.44');
INSERT INTO `kgvenda`.`produto` (`no_produto`, `nu_valorvenda`) VALUES ('Oleo', '5.13');
INSERT INTO `kgvenda`.`produto` (`no_produto`, `nu_valorvenda`) VALUES ('Detergente em pó', '8.24');
INSERT INTO `kgvenda`.`produto` (`no_produto`, `nu_valorvenda`) VALUES ('Extrato de tomate', '7.35');
INSERT INTO `kgvenda`.`produto` (`no_produto`, `nu_valorvenda`) VALUES ('Vinagre', '4.46');
INSERT INTO `kgvenda`.`produto` (`no_produto`, `nu_valorvenda`) VALUES ('Farinha', '3.57');
INSERT INTO `kgvenda`.`produto` (`no_produto`, `nu_valorvenda`) VALUES ('Açucar', '5.68');
INSERT INTO `kgvenda`.`produto` (`no_produto`, `nu_valorvenda`) VALUES ('Sardinha', '7.79');
INSERT INTO `kgvenda`.`produto` (`no_produto`, `nu_valorvenda`) VALUES ('Leite', '1.16');
INSERT INTO `kgvenda`.`produto` (`no_produto`, `nu_valorvenda`) VALUES ('leite Condesando', '2.27');
INSERT INTO `kgvenda`.`produto` (`no_produto`, `nu_valorvenda`) VALUES ('Iogurte', '3.28');
INSERT INTO `kgvenda`.`produto` (`no_produto`, `nu_valorvenda`) VALUES ('Café', '4.39');
INSERT INTO `kgvenda`.`produto` (`no_produto`, `nu_valorvenda`) VALUES ('Milho', '5.44');
INSERT INTO `kgvenda`.`produto` (`no_produto`, `nu_valorvenda`) VALUES ('Azeitona', '6.13');
INSERT INTO `kgvenda`.`produto` (`no_produto`, `nu_valorvenda`) VALUES ('Sal', '7.22');
INSERT INTO `kgvenda`.`produto` (`no_produto`, `nu_valorvenda`) VALUES ('Sal grosso', '8.31');
INSERT INTO `kgvenda`.`produto` (`no_produto`, `nu_valorvenda`) VALUES ('Açúcar refinado', '9.45');
INSERT INTO `kgvenda`.`produto` (`no_produto`, `nu_valorvenda`) VALUES ('Gengibre', '5.96')







