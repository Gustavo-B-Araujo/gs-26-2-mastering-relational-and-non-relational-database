
PROMPT Relatorio 1. Notas do aluno 1 por data da avaliacao
SELECT tc.enumerador     AS curso,
       av.nome           AS avaliacao,
       tn.enumerador     AS tipo,
       av.data_avaliacao AS data,
       b.nota
FROM Boletim b
JOIN TurmaAluno ta ON ta.cod = b.cod_turma_aluno
JOIN Avaliacao av  ON av.cod = b.cod_avaliacao
JOIN TipoNota tn   ON tn.cod = av.cod_tipo_nota
JOIN Turma t       ON t.cod = ta.cod_turma
JOIN TipoCurso tc  ON tc.cod = t.cod_tipo_curso
WHERE ta.cod_aluno = 1
ORDER BY av.data_avaliacao;

PROMPT Relatorio 2. Alunos com Homer Simpson como responsavel
SELECT pa.nome
FROM AlunoGuardiao ag
JOIN Aluno a     ON a.cod = ag.cod_aluno
JOIN Pessoa pa   ON pa.cod = a.cod_pessoa
JOIN Guardiao g  ON g.cod = ag.cod_guardiao
JOIN Pessoa pg   ON pg.cod = g.cod_pessoa
WHERE pg.nome = 'Homer Simpson'
ORDER BY pa.nome;

PROMPT Relatorio 3. Media por aluno e curso
SELECT pa.nome            AS aluno,
       tc.enumerador      AS curso,
       ROUND(AVG(b.nota), 2) AS media
FROM Boletim b
JOIN TurmaAluno ta ON ta.cod = b.cod_turma_aluno
JOIN Aluno a       ON a.cod = ta.cod_aluno
JOIN Pessoa pa     ON pa.cod = a.cod_pessoa
JOIN Turma t       ON t.cod = ta.cod_turma
JOIN TipoCurso tc  ON tc.cod = t.cod_tipo_curso
GROUP BY pa.nome, tc.enumerador
ORDER BY pa.nome, tc.enumerador;
