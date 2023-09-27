

-- Criar esquema se não existir para DBLocal_DIO_Santander
create schema if not exists DBLocal_DIO_Santander;
use DBLocal_DIO_Santander;

-- Selecionar todas as restrições de tabela do esquema 'DBLocal_DIO_Santander'
select * from information_schema.table_constraints
	where constraint_schema = 'DBLocal_DIO_Santander';


-- Criar tabela de funcionários
CREATE TABLE Funcionario(
	Nome varchar(15) not null,
    Inicial char,
    Sobrenome varchar(15) not null,
    Ssn char(9) not null, 
    Data_nascimento date,
    Endereco varchar(30),
    Sexo char,
    Salario decimal(10,2),
    Super_ssn char(9),
    Dno int not null,
    constraint chk_salario_Funcionario check (Salario> 2000.0),
    constraint pk_Funcionario primary key (Ssn)
);

-- Alterar tabela de funcionários
alter table Funcionario 
	add constraint fk_Funcionario 
	foreign key(Super_ssn) references Funcionario(Ssn)
    on delete set null
    on update cascade;

alter table Funcionario modify Dno int not null default 1;

-- Descrever a estrutura da tabela Funcionario
desc Funcionario;

-- Criar tabela de Departamentos
create table Departamento(
	Nome varchar(15) not null,
    Numero int not null,
    Mgr_ssn char(9) not null,
    Data_inicio_mgr date, 
    Data_criacao_dept date,
    constraint chk_data_dept check (Data_criacao_dept < Data_inicio_mgr),
    constraint pk_dept primary key (Numero),
    constraint unique_name_dept unique(Nome),
    foreign key (Mgr_ssn) references Funcionario(Ssn)
);

alter table Departamento 
		add constraint fk_dept foreign key(Mgr_ssn) references Funcionario(Ssn)
        on update cascade;


-- Criar tabela de localizações de Departamento
create table Dept_Localizacoes(
	Numero int not null,
	Localizacao varchar(15) not null,
    constraint pk_Dept_Localizacoes primary key (Numero, Localizacao),
    constraint fk_Dept_Localizacoes foreign key (Numero) references Departamento (Numero)
);



alter table Dept_Localizacoes drop foreign key fk_Dept_Localizacoes;

alter table Dept_Localizacoes 
	add constraint fk_Dept_Localizacoes foreign key (Numero) references Departamento(Numero)
	on delete cascade
    on update cascade;

-- Criar tabela de Projetos
create table Projeto(
	Nome varchar(15) not null,
	Numero int not null,
    Localizacao varchar(15),
    Numero_dept int not null,
    primary key (Numero),
    constraint unique_Projeto unique (Nome),
    constraint fk_Projeto foreign key (Numero_dept) references Departamento(Numero)
);

-- Criar tabela de trabalhos realizados
create table Trabalha_Em(
	Ssn_Funcionario char(9) not null,
    Numero_Projeto int not null,
    Horas decimal(3,1) not null,
    primary key (Ssn_Funcionario, Numero_Projeto),
    constraint fk_Funcionario_Trabalha_Em foreign key (Ssn_Funcionario) references Funcionario(Ssn),
    constraint fk_Projeto_Trabalha_Em foreign key (Numero_Projeto) references Projeto(Numero)
);

create table Dependente(
	Ssn_Funcionario char(9) not null,
    Nome_Dependente varchar(15) not null,
    Sexo char,
    Data_nascimento date,
    Relacionamento varchar(8),
    primary key (Ssn_Funcionario, Nome_Dependente),
    constraint fk_Dependente foreign key (Ssn_Funcionario) references Funcionario(Ssn)
);

-- Mostrar todas as tabelas
show tables;
