
INSERT INTO StatusUsuario (enumerador) VALUES ('Ativo');
INSERT INTO StatusUsuario (enumerador) VALUES ('Inativo');
INSERT INTO StatusUsuario (enumerador) VALUES ('Bloqueado');

INSERT INTO TipoParentesco (enumerador) VALUES ('Pai');
INSERT INTO TipoParentesco (enumerador) VALUES ('Mãe');
INSERT INTO TipoParentesco (enumerador) VALUES ('Representante Legal');

INSERT INTO TipoCurso (enumerador) VALUES ('Português');
INSERT INTO TipoCurso (enumerador) VALUES ('Matemática');
INSERT INTO TipoCurso (enumerador) VALUES ('História');

INSERT INTO TipoNota (enumerador) VALUES ('Prova');
INSERT INTO TipoNota (enumerador) VALUES ('Trabalho');
INSERT INTO TipoNota (enumerador) VALUES ('Caderno');

INSERT INTO TipoPresenca (enumerador) VALUES ('Presente');
INSERT INTO TipoPresenca (enumerador) VALUES ('Falta');
INSERT INTO TipoPresenca (enumerador) VALUES ('Falta Justificada');

INSERT INTO Pessoa (nome, num_documento) VALUES ('Seymour Skinner', '12345678900');    
INSERT INTO Pessoa (nome, num_documento) VALUES ('Edna Krabappel', '12345678901');     
INSERT INTO Pessoa (nome, num_documento) VALUES ('Homer Simpson', '12345678902');      
INSERT INTO Pessoa (nome, num_documento) VALUES ('Marge Simpson', '12345678903');      
INSERT INTO Pessoa (nome, num_documento) VALUES ('Bart Simpson', '12345678904');       
INSERT INTO Pessoa (nome, num_documento) VALUES ('Lisa Simpson', '12345678905');       
INSERT INTO Pessoa (nome, num_documento) VALUES ('Milhouse Van Houten', '12345678906');
INSERT INTO Pessoa (nome, num_documento) VALUES ('Kirk Van Houten', '12345678907');    
INSERT INTO Pessoa (nome, num_documento) VALUES ('Elizabeth Hoover', '12345678908');   

INSERT INTO Usuario (cod_status, cod_pessoa, senha_hash) VALUES (1, 1, '$2b$10$vnXLOAR1ZtqgOcH/Ij8lrOD.FXwavtzO2jvHqsX79BeADaV/GC1xu');
INSERT INTO Usuario (cod_status, cod_pessoa, senha_hash) VALUES (1, 2, '$2b$10$S3aNYj2CTwLmusx3rQjSnerMZyXwIzKTMMGl.WsBZsl6MyVmkZobu');
INSERT INTO Usuario (cod_status, cod_pessoa, senha_hash) VALUES (3, 3, '$2b$10$AfWZxOBNYCJ3pSBPvX0yVuTdoQ5vWgCxjoCoPkkPU3bvflOR.E4zi');
INSERT INTO Usuario (cod_status, cod_pessoa, senha_hash) VALUES (1, 4, '$2b$10$aiX5V0Quqk/jGJYUw0JrJ.n1I.QPMAUK/apIPKewHG.WZl2KU2UNG');
INSERT INTO Usuario (cod_status, cod_pessoa, senha_hash) VALUES (1, 5, '$2b$10$MTIZSRf1GNOGhMrqY6DSmuJlwNW3cNV3UfusXq7bFMDPmXYp1pVzK');

INSERT INTO Diretor (cod_pessoa) VALUES (1);

INSERT INTO Professor (cod_pessoa) VALUES (2);
INSERT INTO Professor (cod_pessoa) VALUES (9);

INSERT INTO Guardiao (cod_pessoa) VALUES (3);
INSERT INTO Guardiao (cod_pessoa) VALUES (4);
INSERT INTO Guardiao (cod_pessoa) VALUES (8);

INSERT INTO Aluno (cod_pessoa) VALUES (5);
INSERT INTO Aluno (cod_pessoa) VALUES (6);
INSERT INTO Aluno (cod_pessoa) VALUES (7);

INSERT INTO AlunoGuardiao (cod_guardiao, cod_aluno, cod_tipo_parentesco) VALUES (1, 1, 1);
INSERT INTO AlunoGuardiao (cod_guardiao, cod_aluno, cod_tipo_parentesco) VALUES (2, 1, 2);
INSERT INTO AlunoGuardiao (cod_guardiao, cod_aluno, cod_tipo_parentesco) VALUES (1, 2, 1);
INSERT INTO AlunoGuardiao (cod_guardiao, cod_aluno, cod_tipo_parentesco) VALUES (2, 2, 2);
INSERT INTO AlunoGuardiao (cod_guardiao, cod_aluno, cod_tipo_parentesco) VALUES (3, 3, 1);

INSERT INTO Escola (cod_diretor, nome) VALUES (1, 'Escola Primária de Springfield');

INSERT INTO Turma (cod_escola, cod_tipo_curso, cod_professor, semestre_referencia, ano_referencia) VALUES (1, 1, 1, 2, 2026);
INSERT INTO Turma (cod_escola, cod_tipo_curso, cod_professor, semestre_referencia, ano_referencia) VALUES (1, 2, 1, 2, 2026);
INSERT INTO Turma (cod_escola, cod_tipo_curso, cod_professor, semestre_referencia, ano_referencia) VALUES (1, 3, 2, 2, 2026);

INSERT INTO TurmaAluno (cod_turma, cod_aluno) VALUES (1, 1);
INSERT INTO TurmaAluno (cod_turma, cod_aluno) VALUES (1, 3);
INSERT INTO TurmaAluno (cod_turma, cod_aluno) VALUES (2, 1);
INSERT INTO TurmaAluno (cod_turma, cod_aluno) VALUES (2, 3);
INSERT INTO TurmaAluno (cod_turma, cod_aluno) VALUES (3, 2);
INSERT INTO TurmaAluno (cod_turma, cod_aluno) VALUES (3, 1);

INSERT INTO Avaliacao (cod_turma, cod_tipo_nota, nome, data_avaliacao) VALUES (1, 1, 'Prova 1', DATE '2026-09-15');   
INSERT INTO Avaliacao (cod_turma, cod_tipo_nota, nome, data_avaliacao) VALUES (1, 2, 'Trabalho 1', DATE '2026-10-10');
INSERT INTO Avaliacao (cod_turma, cod_tipo_nota, nome, data_avaliacao) VALUES (2, 1, 'Prova 1', DATE '2026-09-16');   
INSERT INTO Avaliacao (cod_turma, cod_tipo_nota, nome, data_avaliacao) VALUES (2, 3, 'Caderno', DATE '2026-11-05');   
INSERT INTO Avaliacao (cod_turma, cod_tipo_nota, nome, data_avaliacao) VALUES (3, 1, 'Prova 1', DATE '2026-09-17');   

INSERT INTO Boletim (cod_turma_aluno, cod_avaliacao, nota) VALUES (1, 1, 45.00);
INSERT INTO Boletim (cod_turma_aluno, cod_avaliacao, nota) VALUES (1, 2, 60.00);
INSERT INTO Boletim (cod_turma_aluno, cod_avaliacao, nota) VALUES (2, 1, 70.00);
INSERT INTO Boletim (cod_turma_aluno, cod_avaliacao, nota) VALUES (2, 2, 75.50);
INSERT INTO Boletim (cod_turma_aluno, cod_avaliacao, nota) VALUES (3, 3, 30.00);
INSERT INTO Boletim (cod_turma_aluno, cod_avaliacao, nota) VALUES (3, 4, 55.00);
INSERT INTO Boletim (cod_turma_aluno, cod_avaliacao, nota) VALUES (4, 3, 68.00);
INSERT INTO Boletim (cod_turma_aluno, cod_avaliacao, nota) VALUES (4, 4, 80.00);
INSERT INTO Boletim (cod_turma_aluno, cod_avaliacao, nota) VALUES (5, 5, 100.00);
INSERT INTO Boletim (cod_turma_aluno, cod_avaliacao, nota) VALUES (6, 5, 40.00);

INSERT INTO ListaPresenca (cod_turma_aluno, cod_tipo_presenca, observacao, data_presenca) VALUES (1, 1, NULL, DATE '2026-11-03');
INSERT INTO ListaPresenca (cod_turma_aluno, cod_tipo_presenca, observacao, data_presenca) VALUES (1, 2, NULL, DATE '2026-11-04');
INSERT INTO ListaPresenca (cod_turma_aluno, cod_tipo_presenca, observacao, data_presenca) VALUES (1, 3, 'Atestado médico', DATE '2026-11-05');
INSERT INTO ListaPresenca (cod_turma_aluno, cod_tipo_presenca, observacao, data_presenca) VALUES (2, 1, NULL, DATE '2026-11-03');
INSERT INTO ListaPresenca (cod_turma_aluno, cod_tipo_presenca, observacao, data_presenca) VALUES (2, 1, NULL, DATE '2026-11-04');
INSERT INTO ListaPresenca (cod_turma_aluno, cod_tipo_presenca, observacao, data_presenca) VALUES (5, 1, NULL, DATE '2026-11-03');
INSERT INTO ListaPresenca (cod_turma_aluno, cod_tipo_presenca, observacao, data_presenca) VALUES (6, 2, NULL, DATE '2026-11-03');

COMMIT;
