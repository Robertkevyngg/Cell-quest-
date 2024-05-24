-- Criação do banco de dados e uso do mesmo
CREATE DATABASE IF NOT EXISTS quiz_citologia;
USE quiz_citologia;

-- Criação das tabelas
CREATE TABLE IF NOT EXISTS questoes (
    questao_id INT AUTO_INCREMENT PRIMARY KEY,
    texto TEXT NOT NULL,
    categoria VARCHAR(255) DEFAULT 'Citologia'
);

CREATE TABLE IF NOT EXISTS opcoes_resposta (
    opcao_id INT AUTO_INCREMENT PRIMARY KEY,
    questao_id INT,
    texto_opcao VARCHAR(255) NOT NULL,
    letra_opcao CHAR(1),
    FOREIGN KEY (questao_id) REFERENCES questoes(questao_id)
);

CREATE TABLE IF NOT EXISTS respostas_corretas (
    questao_id INT,
    opcao_id INT,
    FOREIGN KEY (questao_id) REFERENCES questoes(questao_id),
    FOREIGN KEY (opcao_id) REFERENCES opcoes_resposta(opcao_id),
    PRIMARY KEY (questao_id, opcao_id)
);

CREATE TABLE IF NOT EXISTS jogadores (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    login VARCHAR(50) UNIQUE NOT NULL,
    senha VARCHAR(100) NOT NULL
);

-- Criação da tabela para armazenar pontuações
CREATE TABLE IF NOT EXISTS pontuacoes (
    pontuacao_id INT AUTO_INCREMENT PRIMARY KEY,
    jogador_id INT,
    pontuacao INT NOT NULL,
    data_hora TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (jogador_id) REFERENCES jogadores(id)
);

-- Inserção de um usuário exemplo usando INSERT IGNORE
INSERT IGNORE INTO jogadores (nome, login, senha) VALUES ('Usuário Teste', 'teste', 'senha123');
ALTER TABLE jogadores MODIFY nome VARCHAR(255) NULL;
ALTER TABLE jogadores MODIFY nome VARCHAR(255) DEFAULT 'Nome Padrão';

-- Inserção das questões
INSERT INTO questoes (texto, categoria) VALUES
('Os chamados radicais livres, que resultam de reações de oxidação no interior das células eucariontes, podem produzir mutações gênicas, contribuindo, por exemplo, para o envelhecimento dos tecidos ao longo do tempo. Esses radicais são degradados pela enzima superóxido dismutase, processo que gera uma substância tóxica. Essa substância, por sua vez, é decomposta pela catalase no interior de uma estrutura celular específica. Qual é essa estrutura?', 'Citologia'),
('Em uma espermátide, todas as membranas do complexo golgiense foram marcadas com um elemento químico fluorescente. Depois de alguns minutos, a espermátide sofreu diferenciação celular e a célula resultante foi analisada ao microscópio. A marcação fluorescente ocorria onde?', 'Citologia'),
('É correto afirmar que uma célula eucarionte é formada basicamente por:', 'Citologia'),
('Em um sistema hipotético mantido sob iluminação, estão presentes uma célula autotrófica e uma célula heterotrófica. Quais os componentes desse sistema?', 'Citologia'),
('Um dos fármacos usados como quimioterápico contra o câncer é a colchicina. Como ela age no tratamento do câncer?', 'Citologia'),
('Trypanosomatidae é a família de protozoários que apresentam apenas um flagelo. Qual das organelas abaixo é destaque por ser única em cada parasita e por ser considerada alvo de diversos medicamentos?', 'Citologia'),
('Uma importante característica da meiose é que ela promove variabilidade genética. Qual é a maior fonte dessa variabilidade?', 'Citologia'),
('Células animais, quando privadas de alimento, passam a degradar partes de si mesmas como fonte de matéria-prima para sobreviver. Qual organela é responsável por essa degradação?', 'Citologia'),
('O que são organelas?', 'Citologia'),
('Qual é a principal característica das células procariontes?', 'Citologia'),
('O que define uma célula como eucarionte?', 'Citologia'),
('O que é um vacúolo e qual sua função?', 'Citologia'),
('Como as células mantêm sua homeostase?', 'Citologia'),
('Qual é a função do retículo endoplasmático rugoso?', 'Citologia'),
('Qual é a estrutura e função dos microtúbulos?', 'Citologia'),
('Como os ribossomos contribuem para a função celular?', 'Citologia'),
('Qual é a importância das mitocôndrias nas células eucarióticas?', 'Citologia'),
('Descreva a função e a importância do citoesqueleto.', 'Citologia'),
('Qual papel os lisossomos desempenham na célula?', 'Citologia'),
('O que são os centrossomos e qual sua função?', 'Citologia'),
('Como ocorre o transporte através da membrana plasmática?', 'Citologia'),
('Qual é a função do complexo de Golgi nas células?', 'Citologia'),
('O que define as células como procariontes ou eucariontes?', 'Citologia'),
('Como é o processo de divisão celular em eucariontes?', 'Citologia'),
('Qual é o papel do DNA na célula?', 'Citologia'),
('Como as células regulam os processos de sinalização?', 'Citologia'),
('Qual é a importância da apoptose para os organismos multicelulares?', 'Citologia'),
('Descreva a função das células do sistema imunológico.', 'Citologia'),
('Como as células respondem a estresses ambientais?', 'Citologia'),
('Qual é o papel dos peroxissomos na célula?', 'Citologia'),
('Como as células vegetais diferem das células animais?', 'Citologia'),
('Qual é a função dos vacúolos nas células vegetais?', 'Citologia'),
('Como funciona a fotossíntese nas células vegetais?', 'Citologia'),
('Qual é a importância dos plasmodesmos em plantas?', 'Citologia'),
('O que são os cromossomos e qual sua função?', 'Citologia'),
('Descreva a estrutura e função do núcleo celular.', 'Citologia'),
('Como a mitose difere da meiose?', 'Citologia'),
('O que é a transcrição e como ela é importante para a célula?', 'Citologia'),
('Qual é a função dos ribossomos no processo de tradução?', 'Citologia'),
('Como ocorre a replicação do DNA?', 'Citologia'),
('O que são as junções gap e qual sua função?', 'Citologia'),
('Como as células regulam o ciclo celular?', 'Citologia'),
('O que é a endocitose e quais são seus tipos?', 'Citologia'),
('Como a exocitose é regulada nas células?', 'Citologia'),
('Qual é a importância dos receptores celulares?', 'Citologia'),
('Como os hormônios afetam a função celular?', 'Citologia'),
('O que é o retículo endoplasmático e suas funções?', 'Citologia'),
('Qual é a função da membrana plasmática?', 'Citologia'),
('Como ocorre o processo de sinalização celular?', 'Citologia'),
('Qual é o impacto dos radicais livres nas células?', 'Citologia');

-- Inserção das opções de resposta
INSERT INTO opcoes_resposta (questao_id, texto_opcao, letra_opcao) VALUES
(1, 'peroxissomos', 'A'),
(1, 'fagossomos', 'B'),
(1, 'ribossomos', 'C'),
(1, 'lisossomos', 'D'),
(2, 'no flagelo', 'A'),
(2, 'no acrossomo', 'B'),
(2, 'no fagossomo', 'C'),
(2, 'nos centríolos', 'D'),
(2, 'nas mitocôndrias', 'E'),
(3, 'parede celular, ribossomos e citoplasma', 'A'),
(3, 'citoplasma, material genético e parede celular', 'B'),
(3, 'membrana plasmática, citoplasma e núcleo definido', 'C'),
(3, 'cápsula, membrana plasmática e DNA', 'D'),
(4, 'água produzida na respiração', 'A'),
(4, 'piruvato produzido na glicólise', 'B'),
(4, 'etanol produzido na fermentação', 'C'),
(4, 'glicose produzida na fotossíntese', 'D'),
(4, 'gás carbônico produzido no ciclo de Krebs', 'E'),
(5, 'inibe a atividade das mitocôndrias, diminuindo a produção de ATP', 'A'),
(5, 'bloqueia a síntese proteica, o que impede a polimerização dos microtúbulos', 'B'),
(5, 'impede a polimerização do fuso, que promove a condensação da cromatina nuclear', 'C'),
(5, 'causa a despolimerização de proteínas do fuso, impedindo a separação das células-filhas no final da mitose', 'D'),
(5, 'promove a despolimerização das fibras do fuso, impossibilitando a separação dos cromossomos na divisão', 'E'),
(6, 'Complexo de Golgi', 'A'),
(6, 'Mitocôndria', 'B'),
(6, 'Retículo Endoplasmático', 'C'),
(6, 'Hidrogenossomos', 'D'),
(6, 'Peroxissom', 'E'),
(7, 'A maior causa dessa variabilidade genética é a permutação (crossing-over)', 'A'),
(7, 'A variabilidade genética vai depender do número de células filhas produzidas', 'B'),
(7, 'A variabilidade genética vai depender da fase em que a permutação (crossing-over) ocorrer', 'C'),
(7, 'O pareamento de cromossomos homólogos na prófase I da meiose é fundamental para que ocorra variabilidade genética', 'D'),
(7, 'A maior fonte de variabilidade genética é a distribuição aleatória de cromossomos paternos e maternos nas células filhas', 'E'),
(8, 'o aparelho de Golgi', 'A'),
(8, 'o centríolo', 'B'),
(8, 'o lisossomo', 'C'),
(8, 'a mitocôndria', 'D'),
(9, 'Partes funcionais de uma célula', 'A'),
(9, 'Tipo de célula', 'B'),
(9, 'Membranas celulares', 'C'),
(9, 'Núcleos celulares', 'D'),
(9, 'Tipos de DNA', 'E'),
(10, 'Não possuem núcleo definido', 'A'),
(10, 'Possuem múltiplos cromossomos', 'B'),
(10, 'Incluem organelas membranosas', 'C'),
(10, 'São tipicamente multicelulares', 'D'),
(10, 'Têm paredes celulares de peptidoglicano', 'E'),
(11, 'Possuem núcleo delimitado por membrana', 'A'),
(11, 'São menores que as procariontes', 'B'),
(11, 'Não possuem DNA', 'C'),
(11, 'Possuem ribossomos menores', 'D'),
(11, 'São todas unicelulares', 'E'),
(12, 'Organela de armazenamento de água', 'A'),
(12, 'Organela de síntese proteica', 'B'),
(12, 'Componente da membrana celular', 'C'),
(12, 'Tipo de célula', 'D'),
(12, 'Parte do citoesqueleto', 'E'),
(13, 'Através de canais iônicos', 'A'),
(13, 'Por meio de vesículas', 'B'),
(13, 'Utilizando enzimas específicas', 'C'),
(13, 'Produção de ATP', 'D'),
(13, 'Secreção hormonal', 'E'),
(14, 'Síntese de proteínas ligadas à membrana', 'A'),
(14, 'Produção de lipídios', 'B'),
(14, 'Secreção de hormônios', 'C'),
(14, 'Fotossíntese', 'D'),
(14, 'Degradar RNA mensageiro', 'E'),
(15, 'Componente estrutural', 'A'),
(15, 'Componente energético', 'B'),
(15, 'Componente de armazenamento', 'C'),
(15, 'Componente de transporte', 'D'),
(15, 'Componente de replicação', 'E'),
(16, 'Local de síntese de proteínas', 'A'),
(16, 'Local de degradação de proteínas', 'B'),
(16, 'Local de armazenamento de proteínas', 'C'),
(16, 'Local de modificação de proteínas', 'D'),
(16, 'Local de transporte de proteínas', 'E'),
(17, 'Produzem energia na forma de ATP', 'A'),
(17, 'Produzem energia na forma de glicose', 'B'),
(17, 'Produzem energia na forma de lipídios', 'C'),
(17, 'Produzem energia na forma de RNA', 'D'),
(17, 'Produzem energia na forma de DNA', 'E'),
(18, 'Fornecem suporte estrutural', 'A'),
(18, 'Fornecem suporte energético', 'B'),
(18, 'Fornecem suporte genético', 'C'),
(18, 'Fornecem suporte enzimático', 'D'),
(18, 'Fornecem suporte lipídico', 'E'),
(19, 'Degradam materiais celulares', 'A'),
(19, 'Degradam materiais extracelulares', 'B'),
(19, 'Degradam materiais nucleares', 'C'),
(19, 'Degradam materiais ribossomais', 'D'),
(19, 'Degradam materiais mitocondriais', 'E'),
(20, 'Organização do citoesqueleto', 'A'),
(20, 'Organização da membrana plasmática', 'B'),
(20, 'Organização do núcleo', 'C'),
(20, 'Organização dos ribossomos', 'D'),
(20, 'Organização das mitocôndrias', 'E'),
(21, 'Transporte passivo e ativo', 'A'),
(21, 'Transporte osmótico e difusivo', 'B'),
(21, 'Transporte nuclear e ribossomal', 'C'),
(21, 'Transporte mitocondrial e lisossomal', 'D'),
(21, 'Transporte citoplasmático e membranar', 'E'),
(22, 'Modificação de proteínas e lipídios', 'A'),
(22, 'Modificação de DNA e RNA', 'B'),
(22, 'Modificação de carboidratos e lipídios', 'C'),
(22, 'Modificação de ribossomos e mitocôndrias', 'D'),
(22, 'Modificação de cromossomos e centríolos', 'E'),
(23, 'Presença ou ausência de núcleo', 'A'),
(23, 'Presença ou ausência de ribossomos', 'B'),
(23, 'Presença ou ausência de mitocôndrias', 'C'),
(23, 'Presença ou ausência de retículo endoplasmático', 'D'),
(23, 'Presença ou ausência de citoesqueleto', 'E'),
(24, 'Mitose e meiose', 'A'),
(24, 'Mitose e apoptose', 'B'),
(24, 'Mitose e necrose', 'C'),
(24, 'Mitose e autofagia', 'D'),
(24, 'Mitose e endocitose', 'E'),
(25, 'Armazenamento de informações genéticas', 'A'),
(25, 'Armazenamento de informações lipídicas', 'B'),
(25, 'Armazenamento de informações proteicas', 'C'),
(25, 'Armazenamento de informações ribossomais', 'D'),
(25, 'Armazenamento de informações mitocondriais', 'E'),
(26, 'Regulação de sinalização intracelular', 'A'),
(26, 'Regulação de sinalização extracelular', 'B'),
(26, 'Regulação de sinalização nuclear', 'C'),
(26, 'Regulação de sinalização ribossomal', 'D'),
(26, 'Regulação de sinalização mitocondrial', 'E'),
(27, 'Programação da morte celular', 'A'),
(27, 'Programação da divisão celular', 'B'),
(27, 'Programação da diferenciação celular', 'C'),
(27, 'Programação da proliferação celular', 'D'),
(27, 'Programação da migração celular', 'E'),
(28, 'Defesa contra patógenos', 'A'),
(28, 'Defesa contra toxinas', 'B'),
(28, 'Defesa contra radicais livres', 'C'),
(28, 'Defesa contra apoptose', 'D'),
(28, 'Defesa contra necrose', 'E'),
(29, 'Adaptam-se a mudanças ambientais', 'A'),
(29, 'Adaptam-se a mudanças genéticas', 'B'),
(29, 'Adaptam-se a mudanças lipídicas', 'C'),
(29, 'Adaptam-se a mudanças proteicas', 'D'),
(29, 'Adaptam-se a mudanças nucleares', 'E'),
(30, 'Detoxificação celular', 'A'),
(30, 'Detoxificação nuclear', 'B'),
(30, 'Detoxificação mitocondrial', 'C'),
(30, 'Detoxificação ribossomal', 'D'),
(30, 'Detoxificação membranar', 'E'),
(31, 'Presença de cloroplastos', 'A'),
(31, 'Presença de vacúolos', 'B'),
(31, 'Presença de parede celular', 'C'),
(31, 'Presença de plasmodesmos', 'D'),
(31, 'Presença de lisossomos', 'E'),
(32, 'Armazenamento de substâncias', 'A'),
(32, 'Armazenamento de informações genéticas', 'B'),
(32, 'Armazenamento de lipídios', 'C'),
(32, 'Armazenamento de proteínas', 'D'),
(32, 'Armazenamento de água', 'E'),
(33, 'Produção de glicose', 'A'),
(33, 'Produção de lipídios', 'B'),
(33, 'Produção de proteínas', 'C'),
(33, 'Produção de DNA', 'D'),
(33, 'Produção de RNA', 'E'),
(34, 'Transporte de substâncias entre células', 'A'),
(34, 'Transporte de substâncias dentro da célula', 'B'),
(34, 'Transporte de substâncias fora da célula', 'C'),
(34, 'Transporte de substâncias para o núcleo', 'D'),
(34, 'Transporte de substâncias para a mitocôndria', 'E'),
(35, 'Armazenamento de informações genéticas', 'A'),
(35, 'Armazenamento de informações lipídicas', 'B'),
(35, 'Armazenamento de informações proteicas', 'C'),
(35, 'Armazenamento de informações ribossomais', 'D'),
(35, 'Armazenamento de informações mitocondriais', 'E'),
(36, 'Síntese de RNA', 'A'),
(36, 'Síntese de DNA', 'B'),
(36, 'Síntese de proteínas', 'C'),
(36, 'Síntese de lipídios', 'D'),
(36, 'Síntese de carboidratos', 'E'),
(37, 'Produção de proteínas', 'A'),
(37, 'Produção de lipídios', 'B'),
(37, 'Produção de DNA', 'C'),
(37, 'Produção de RNA', 'D'),
(37, 'Produção de carboidratos', 'E'),
(38, 'Replicação do DNA', 'A'),
(38, 'Replicação do RNA', 'B'),
(38, 'Replicação de proteínas', 'C'),
(38, 'Replicação de lipídios', 'D'),
(38, 'Replicação de carboidratos', 'E'),
(39, 'Comunicação entre células', 'A'),
(39, 'Comunicação dentro da célula', 'B'),
(39, 'Comunicação fora da célula', 'C'),
(39, 'Comunicação para o núcleo', 'D'),
(39, 'Comunicação para a mitocôndria', 'E'),
(40, 'Regulação do ciclo celular', 'A'),
(40, 'Regulação do ciclo mitocondrial', 'B'),
(40, 'Regulação do ciclo ribossomal', 'C'),
(40, 'Regulação do ciclo nuclear', 'D'),
(40, 'Regulação do ciclo lisossomal', 'E'),
(41, 'Transporte de substâncias para dentro da célula', 'A'),
(41, 'Transporte de substâncias para fora da célula', 'B'),
(41, 'Transporte de substâncias para o núcleo', 'C'),
(41, 'Transporte de substâncias para a mitocôndria', 'D'),
(41, 'Transporte de substâncias para o retículo endoplasmático', 'E'),
(42, 'Secreção de substâncias para fora da célula', 'A'),
(42, 'Secreção de substâncias para dentro da célula', 'B'),
(42, 'Secreção de substâncias para o núcleo', 'C'),
(42, 'Secreção de substâncias para a mitocôndria', 'D'),
(42, 'Secreção de substâncias para o retículo endoplasmático', 'E'),
(43, 'Detecção de sinais externos', 'A'),
(43, 'Detecção de sinais internos', 'B'),
(43, 'Detecção de sinais nucleares', 'C'),
(43, 'Detecção de sinais ribossomais', 'D'),
(43, 'Detecção de sinais mitocondriais', 'E'),
(44, 'Regulação de funções celulares', 'A'),
(44, 'Regulação de funções nucleares', 'B'),
(44, 'Regulação de funções ribossomais', 'C'),
(44, 'Regulação de funções mitocondriais', 'D'),
(44, 'Regulação de funções lisossomais', 'E'),
(45, 'Produção de lipídios', 'A'),
(45, 'Produção de proteínas', 'B'),
(45, 'Produção de carboidratos', 'C'),
(45, 'Produção de DNA', 'D'),
(45, 'Produção de RNA', 'E'),
(46, 'Proteção da célula', 'A'),
(46, 'Transporte de substâncias', 'B'),
(46, 'Comunicação celular', 'C'),
(46, 'Síntese de proteínas', 'D'),
(46, 'Armazenamento de substâncias', 'E'),
(47, 'Transmissão de sinais', 'A'),
(47, 'Recepção de sinais', 'B'),
(47, 'Amplificação de sinais', 'C'),
(47, 'Modificação de sinais', 'D'),
(47, 'Degradação de sinais', 'E'),
(48, 'Dano celular', 'A'),
(48, 'Estresse oxidativo', 'B'),
(48, 'Estresse térmico', 'C'),
(48, 'Estresse osmótico', 'D'),
(48, 'Estresse mecânico', 'E'),
(49, 'Dano ao DNA', 'A'),
(49, 'Dano às proteínas', 'B'),
(49, 'Dano aos lipídios', 'C'),
(49, 'Dano aos carboidratos', 'D'),
(49, 'Dano aos ribossomos', 'E'),
(50, 'Dano mitocondrial', 'A'),
(50, 'Dano nuclear', 'B'),
(50, 'Dano ribossomal', 'C'),
(50, 'Dano lisossomal', 'D'),
(50, 'Dano citoplasmático', 'E');

-- Inserção das respostas corretas
INSERT INTO respostas_corretas (questao_id, opcao_id) VALUES
(1, (SELECT opcao_id FROM opcoes_resposta WHERE questao_id = 1 AND letra_opcao = 'A')),
(2, (SELECT opcao_id FROM opcoes_resposta WHERE questao_id = 2 AND letra_opcao = 'B')),
(3, (SELECT opcao_id FROM opcoes_resposta WHERE questao_id = 3 AND letra_opcao = 'C')),
(4, (SELECT opcao_id FROM opcoes_resposta WHERE questao_id = 4 AND letra_opcao = 'D')),
(5, (SELECT opcao_id FROM opcoes_resposta WHERE questao_id = 5 AND letra_opcao = 'E')),
(6, (SELECT opcao_id FROM opcoes_resposta WHERE questao_id = 6 AND letra_opcao = 'A')),
(7, (SELECT opcao_id FROM opcoes_resposta WHERE questao_id = 7 AND letra_opcao = 'B')),
(8, (SELECT opcao_id FROM opcoes_resposta WHERE questao_id = 8 AND letra_opcao = 'C')),
(9, (SELECT opcao_id FROM opcoes_resposta WHERE questao_id = 9 AND letra_opcao = 'A')),
(10, (SELECT opcao_id FROM opcoes_resposta WHERE questao_id = 10 AND letra_opcao = 'A')),
(11, (SELECT opcao_id FROM opcoes_resposta WHERE questao_id = 11 AND letra_opcao = 'A')),
(12, (SELECT opcao_id FROM opcoes_resposta WHERE questao_id = 12 AND letra_opcao = 'A')),
(13, (SELECT opcao_id FROM opcoes_resposta WHERE questao_id = 13 AND letra_opcao = 'E')),
(14, (SELECT opcao_id FROM opcoes_resposta WHERE questao_id = 14 AND letra_opcao = 'A')),
(15, (SELECT opcao_id FROM opcoes_resposta WHERE questao_id = 15 AND letra_opcao = 'A')),
(16, (SELECT opcao_id FROM opcoes_resposta WHERE questao_id = 16 AND letra_opcao = 'A')),
(17, (SELECT opcao_id FROM opcoes_resposta WHERE questao_id = 17 AND letra_opcao = 'A')),
(18, (SELECT opcao_id FROM opcoes_resposta WHERE questao_id = 18 AND letra_opcao = 'A')),
(19, (SELECT opcao_id FROM opcoes_resposta WHERE questao_id = 19 AND letra_opcao = 'A')),
(20, (SELECT opcao_id FROM opcoes_resposta WHERE questao_id = 20 AND letra_opcao = 'A')),
(21, (SELECT opcao_id FROM opcoes_resposta WHERE questao_id = 21 AND letra_opcao = 'A')),
(22, (SELECT opcao_id FROM opcoes_resposta WHERE questao_id = 22 AND letra_opcao = 'A')),
(23, (SELECT opcao_id FROM opcoes_resposta WHERE questao_id = 23 AND letra_opcao = 'A')),
(24, (SELECT opcao_id FROM opcoes_resposta WHERE questao_id = 24 AND letra_opcao = 'A')),
(25, (SELECT opcao_id FROM opcoes_resposta WHERE questao_id = 25 AND letra_opcao = 'A')),
(26, (SELECT opcao_id FROM opcoes_resposta WHERE questao_id = 26 AND letra_opcao = 'A')),
(27, (SELECT opcao_id FROM opcoes_resposta WHERE questao_id = 27 AND letra_opcao = 'A')),
(28, (SELECT opcao_id FROM opcoes_resposta WHERE questao_id = 28 AND letra_opcao = 'A')),
(29, (SELECT opcao_id FROM opcoes_resposta WHERE questao_id = 29 AND letra_opcao = 'A')),
(30, (SELECT opcao_id FROM opcoes_resposta WHERE questao_id = 30 AND letra_opcao = 'A')),
(31, (SELECT opcao_id FROM opcoes_resposta WHERE questao_id = 31 AND letra_opcao = 'A')),
(32, (SELECT opcao_id FROM opcoes_resposta WHERE questao_id = 32 AND letra_opcao = 'A')),
(33, (SELECT opcao_id FROM opcoes_resposta WHERE questao_id = 33 AND letra_opcao = 'A')),
(34, (SELECT opcao_id FROM opcoes_resposta WHERE questao_id = 34 AND letra_opcao = 'A')),
(35, (SELECT opcao_id FROM opcoes_resposta WHERE questao_id = 35 AND letra_opcao = 'A')),
(36, (SELECT opcao_id FROM opcoes_resposta WHERE questao_id = 36 AND letra_opcao = 'A')),
(37, (SELECT opcao_id FROM opcoes_resposta WHERE questao_id = 37 AND letra_opcao = 'A')),
(38, (SELECT opcao_id FROM opcoes_resposta WHERE questao_id = 38 AND letra_opcao = 'A')),
(39, (SELECT opcao_id FROM opcoes_resposta WHERE questao_id = 39 AND letra_opcao = 'A')),
(40, (SELECT opcao_id FROM opcoes_resposta WHERE questao_id = 40 AND letra_opcao = 'A')),
(41, (SELECT opcao_id FROM opcoes_resposta WHERE questao_id = 41 AND letra_opcao = 'A')),
(42, (SELECT opcao_id FROM opcoes_resposta WHERE questao_id = 42 AND letra_opcao = 'A')),
(43, (SELECT opcao_id FROM opcoes_resposta WHERE questao_id = 43 AND letra_opcao = 'A')),
(44, (SELECT opcao_id FROM opcoes_resposta WHERE questao_id = 44 AND letra_opcao = 'A')),
(45, (SELECT opcao_id FROM opcoes_resposta WHERE questao_id = 45 AND letra_opcao = 'A')),
(46, (SELECT opcao_id FROM opcoes_resposta WHERE questao_id = 46 AND letra_opcao = 'A')),
(47, (SELECT opcao_id FROM opcoes_resposta WHERE questao_id = 47 AND letra_opcao = 'A')),
(48, (SELECT opcao_id FROM opcoes_resposta WHERE questao_id = 48 AND letra_opcao = 'A')),
(49, (SELECT opcao_id FROM opcoes_resposta WHERE questao_id = 49 AND letra_opcao = 'A')),
(50, (SELECT opcao_id FROM opcoes_resposta WHERE questao_id = 50 AND letra_opcao = 'A'));