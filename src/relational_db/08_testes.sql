
SET SERVEROUTPUT ON

PROMPT 1. Funcoes: media e frequencia por matricula
SELECT ta.cod, pa.nome AS aluno, tc.enumerador AS curso,
       fn_media_aluno(ta.cod)      AS media,
       fn_frequencia_aluno(ta.cod) AS frequencia
FROM TurmaAluno ta
JOIN Aluno a      ON a.cod = ta.cod_aluno
JOIN Pessoa pa    ON pa.cod = a.cod_pessoa
JOIN Turma t      ON t.cod = ta.cod_turma
JOIN TipoCurso tc ON tc.cod = t.cod_tipo_curso
ORDER BY ta.cod;

PROMPT 2. Funcao com matricula inexistente
SELECT fn_media_aluno(999) FROM dual;

PROMPT 3. Pacotes: media e frequencia
SELECT pkg_notas.media_aluno(1)           AS media,
       pkg_frequencia.frequencia_aluno(1) AS frequencia
FROM dual;

PROMPT 4. Procedure: registrar nota valida
DECLARE
    v_cod NUMBER;
BEGIN
    INSERT INTO Avaliacao (cod_turma, cod_tipo_nota, nome, data_avaliacao)
    VALUES (2, 2, 'Trabalho 1', DATE '2026-11-10')
    RETURNING cod INTO v_cod;

    pr_registrar_nota(3, v_cod, 90);
END;
/

PROMPT 5. Procedure: nota em avaliacao de outra turma
EXEC pr_registrar_nota(5, 1, 80);

PROMPT 6. Procedure: registrar falta
EXEC pr_registrar_presenca(2, 2, DATE '2026-11-05');

PROMPT 7. Procedure: registrar presenca
EXEC pr_registrar_presenca(5, 1, DATE '2026-11-04');

PROMPT 8. Pacote: nota em avaliacao de outra turma
EXEC pkg_notas.registrar_nota(5, 1, 80);

PROMPT 9. Pacote: registrar presenca
EXEC pkg_frequencia.registrar_presenca(6, 1, DATE '2026-11-04');

PROMPT 10. Trigger: historico de status do usuario
UPDATE Usuario SET cod_status = 3 WHERE cod = 1;
UPDATE Usuario SET cod_status = 1 WHERE cod = 3;

SELECT h.cod_usuario, p.nome, h.operacao,
       sa.enumerador AS status_antigo, sn.enumerador AS status_novo, h.data_evento
FROM HistoricoStatusUsuario h
LEFT JOIN Usuario u        ON u.cod = h.cod_usuario
LEFT JOIN Pessoa p         ON p.cod = u.cod_pessoa
LEFT JOIN StatusUsuario sa ON sa.cod = h.cod_status_antigo
LEFT JOIN StatusUsuario sn ON sn.cod = h.cod_status_novo
ORDER BY h.cod;

PROMPT 11. Trigger: presenca em data futura
INSERT INTO ListaPresenca (cod_turma_aluno, cod_tipo_presenca, data_presenca)
VALUES (5, 1, TRUNC(SYSDATE) + 1);

ROLLBACK;
