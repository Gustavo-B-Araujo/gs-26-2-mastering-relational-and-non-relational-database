CREATE OR REPLACE PROCEDURE pr_registrar_nota (
    p_cod_turma_aluno IN NUMBER,
    p_cod_avaliacao   IN NUMBER,
    p_nota            IN NUMBER
)
IS
    v_qtd NUMBER;
BEGIN
    SELECT COUNT(*) INTO v_qtd
    FROM TurmaAluno ta
    JOIN Avaliacao av ON av.cod_turma = ta.cod_turma
    WHERE ta.cod = p_cod_turma_aluno
      AND av.cod = p_cod_avaliacao;

    IF v_qtd = 0 THEN
        RAISE_APPLICATION_ERROR(-20002, 'Avaliação não pertence à turma do aluno');
    END IF;

    INSERT INTO Boletim (cod_turma_aluno, cod_avaliacao, nota)
    VALUES (p_cod_turma_aluno, p_cod_avaliacao, p_nota);

    DBMS_OUTPUT.PUT_LINE('Nova média: ' || fn_media_aluno(p_cod_turma_aluno));
END;
/

CREATE OR REPLACE PROCEDURE pr_registrar_presenca (
    p_cod_turma_aluno   IN NUMBER,
    p_cod_tipo_presenca IN NUMBER,
    p_data_presenca     IN DATE
)
IS
    v_freq NUMBER;
BEGIN
    INSERT INTO ListaPresenca (cod_turma_aluno, cod_tipo_presenca, data_presenca)
    VALUES (p_cod_turma_aluno, p_cod_tipo_presenca, p_data_presenca);

    v_freq := fn_frequencia_aluno(p_cod_turma_aluno);

    IF v_freq < 75 THEN
        DBMS_OUTPUT.PUT_LINE('ALERTA: frequência em ' || v_freq || '%');
    ELSE
        DBMS_OUTPUT.PUT_LINE('Frequência: ' || v_freq || '%');
    END IF;
END;
/
