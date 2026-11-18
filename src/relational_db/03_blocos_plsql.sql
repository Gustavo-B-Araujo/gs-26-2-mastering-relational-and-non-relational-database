SET SERVEROUTPUT ON;

DECLARE
    CURSOR c_medias IS
        SELECT pa.nome AS aluno, tc.enumerador AS curso, ROUND(AVG(b.nota), 2) AS media
        FROM Boletim b
        JOIN TurmaAluno ta ON ta.cod = b.cod_turma_aluno
        JOIN Aluno a       ON a.cod = ta.cod_aluno
        JOIN Pessoa pa     ON pa.cod = a.cod_pessoa
        JOIN Turma t       ON t.cod = ta.cod_turma
        JOIN TipoCurso tc  ON tc.cod = t.cod_tipo_curso
        GROUP BY pa.nome, tc.enumerador
        ORDER BY pa.nome, tc.enumerador;

    v_reg         c_medias%ROWTYPE;
    v_situacao    VARCHAR2(20);
    v_aprovados   NUMBER := 0;
    v_recuperacao NUMBER := 0;
    v_reprovados  NUMBER := 0;
BEGIN
    OPEN c_medias;
    LOOP
        FETCH c_medias INTO v_reg;
        EXIT WHEN c_medias%NOTFOUND;

        IF v_reg.media >= 60 THEN
            v_situacao  := 'Aprovado';
            v_aprovados := v_aprovados + 1;
        ELSIF v_reg.media >= 50 THEN
            v_situacao    := 'Recuperação';
            v_recuperacao := v_recuperacao + 1;
        ELSE
            v_situacao   := 'Reprovado';
            v_reprovados := v_reprovados + 1;
        END IF;

        DBMS_OUTPUT.PUT_LINE(
            RPAD(v_reg.aluno, 22) || RPAD(v_reg.curso, 12) ||
            LPAD(TO_CHAR(v_reg.media, 'FM990.00'), 7) || '  ' || v_situacao
        );
    END LOOP;
    CLOSE c_medias;

    DBMS_OUTPUT.PUT_LINE('----------------------------------------------');
    DBMS_OUTPUT.PUT_LINE('Aprovados: ' || v_aprovados ||
                         ' | Recuperação: ' || v_recuperacao ||
                         ' | Reprovados: ' || v_reprovados);
END;
/

DECLARE
    c_freq_minima CONSTANT NUMBER := 75;
    v_freq        NUMBER;
    v_alertas     NUMBER := 0;
BEGIN
    FOR r IN (
        SELECT ta.cod_aluno, pa.nome AS aluno, tc.enumerador AS curso,
               COUNT(*) AS aulas,
               SUM(CASE WHEN tp.enumerador = 'Falta' THEN 1 ELSE 0 END) AS faltas
        FROM ListaPresenca lp
        JOIN TipoPresenca tp ON tp.cod = lp.cod_tipo_presenca
        JOIN TurmaAluno ta   ON ta.cod = lp.cod_turma_aluno
        JOIN Aluno a         ON a.cod = ta.cod_aluno
        JOIN Pessoa pa       ON pa.cod = a.cod_pessoa
        JOIN Turma t         ON t.cod = ta.cod_turma
        JOIN TipoCurso tc    ON tc.cod = t.cod_tipo_curso
        GROUP BY ta.cod_aluno, pa.nome, tc.enumerador
        ORDER BY pa.nome, tc.enumerador
    ) LOOP
        v_freq := ROUND((r.aulas - r.faltas) / r.aulas * 100, 2);

        IF v_freq < c_freq_minima THEN
            v_alertas := v_alertas + 1;
            DBMS_OUTPUT.PUT_LINE('ALERTA: ' || r.aluno || ' em ' || r.curso ||
                                 ' com ' || v_freq || '% de frequência');

            FOR g IN (
                SELECT pg.nome AS responsavel, tpar.enumerador AS parentesco
                FROM AlunoGuardiao ag
                JOIN Guardiao gu         ON gu.cod = ag.cod_guardiao
                JOIN Pessoa pg           ON pg.cod = gu.cod_pessoa
                JOIN TipoParentesco tpar ON tpar.cod = ag.cod_tipo_parentesco
                WHERE ag.cod_aluno = r.cod_aluno
            ) LOOP
                DBMS_OUTPUT.PUT_LINE('   -> avisar ' || g.responsavel || ' (' || g.parentesco || ')');
            END LOOP;
        ELSE
            DBMS_OUTPUT.PUT_LINE('OK: ' || r.aluno || ' em ' || r.curso ||
                                 ' com ' || v_freq || '% de frequência');
        END IF;
    END LOOP;

    DBMS_OUTPUT.PUT_LINE('Total de alertas: ' || v_alertas);
END;
/
