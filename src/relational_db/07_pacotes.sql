
CREATE OR REPLACE PACKAGE pkg_notas AS
    FUNCTION media_aluno (
        p_cod_turma_aluno IN NUMBER
    ) RETURN NUMBER;

    PROCEDURE registrar_nota (
        p_cod_turma_aluno IN NUMBER,
        p_cod_avaliacao   IN NUMBER,
        p_nota            IN NUMBER
    );
END pkg_notas;
/

CREATE OR REPLACE PACKAGE BODY pkg_notas AS
    FUNCTION media_aluno (
        p_cod_turma_aluno IN NUMBER
    ) RETURN NUMBER
    IS
    BEGIN
        RETURN fn_media_aluno(p_cod_turma_aluno);
    END media_aluno;

    PROCEDURE registrar_nota (
        p_cod_turma_aluno IN NUMBER,
        p_cod_avaliacao   IN NUMBER,
        p_nota            IN NUMBER
    )
    IS
    BEGIN
        pr_registrar_nota(p_cod_turma_aluno, p_cod_avaliacao, p_nota);
    END registrar_nota;
END pkg_notas;
/

CREATE OR REPLACE PACKAGE pkg_frequencia AS
    FUNCTION frequencia_aluno (
        p_cod_turma_aluno IN NUMBER
    ) RETURN NUMBER;

    PROCEDURE registrar_presenca (
        p_cod_turma_aluno   IN NUMBER,
        p_cod_tipo_presenca IN NUMBER,
        p_data_presenca     IN DATE
    );
END pkg_frequencia;
/

CREATE OR REPLACE PACKAGE BODY pkg_frequencia AS
    FUNCTION frequencia_aluno (
        p_cod_turma_aluno IN NUMBER
    ) RETURN NUMBER
    IS
    BEGIN
        RETURN fn_frequencia_aluno(p_cod_turma_aluno);
    END frequencia_aluno;

    PROCEDURE registrar_presenca (
        p_cod_turma_aluno   IN NUMBER,
        p_cod_tipo_presenca IN NUMBER,
        p_data_presenca     IN DATE
    )
    IS
    BEGIN
        pr_registrar_presenca(p_cod_turma_aluno, p_cod_tipo_presenca, p_data_presenca);
    END registrar_presenca;
END pkg_frequencia;
/
