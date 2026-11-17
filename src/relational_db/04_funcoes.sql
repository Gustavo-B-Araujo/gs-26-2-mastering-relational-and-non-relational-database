
CREATE OR REPLACE FUNCTION fn_media_aluno (
    p_cod_turma_aluno IN TurmaAluno.cod%TYPE
) RETURN NUMBER
IS
    v_existe NUMBER;
    v_media  NUMBER;
BEGIN
    SELECT COUNT(*) INTO v_existe
    FROM TurmaAluno
    WHERE cod = p_cod_turma_aluno;

    IF v_existe = 0 THEN
        RAISE_APPLICATION_ERROR(-20001, 'Matrícula ' || p_cod_turma_aluno || ' não encontrada');
    END IF;

    SELECT ROUND(AVG(nota), 2) INTO v_media
    FROM Boletim
    WHERE cod_turma_aluno = p_cod_turma_aluno;

    RETURN v_media;
END;
/

CREATE OR REPLACE FUNCTION fn_frequencia_aluno (
    p_cod_turma_aluno IN TurmaAluno.cod%TYPE
) RETURN NUMBER
IS
    v_existe NUMBER;
    v_aulas  NUMBER;
    v_faltas NUMBER;
BEGIN
    SELECT COUNT(*) INTO v_existe
    FROM TurmaAluno
    WHERE cod = p_cod_turma_aluno;

    IF v_existe = 0 THEN
        RAISE_APPLICATION_ERROR(-20001, 'Matrícula ' || p_cod_turma_aluno || ' não encontrada');
    END IF;

    SELECT COUNT(*),
           NVL(SUM(CASE WHEN tp.enumerador = 'Falta' THEN 1 ELSE 0 END), 0)
    INTO v_aulas, v_faltas
    FROM ListaPresenca lp
    JOIN TipoPresenca tp ON tp.cod = lp.cod_tipo_presenca
    WHERE lp.cod_turma_aluno = p_cod_turma_aluno;

    IF v_aulas = 0 THEN
        RETURN NULL;
    END IF;

    RETURN ROUND((v_aulas - v_faltas) / v_aulas * 100, 2);
END;
/
