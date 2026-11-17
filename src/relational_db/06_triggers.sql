
CREATE OR REPLACE TRIGGER trg_historico_status_usuario
AFTER INSERT OR UPDATE OF cod_status OR DELETE ON Usuario
FOR EACH ROW
DECLARE
    v_operacao VARCHAR2(6);
BEGIN
    IF INSERTING THEN
        v_operacao := 'INSERT';
    ELSIF UPDATING THEN
        v_operacao := 'UPDATE';
    ELSE
        v_operacao := 'DELETE';
    END IF;

    INSERT INTO HistoricoStatusUsuario (cod_usuario, operacao, cod_status_antigo, cod_status_novo)
    VALUES (NVL(:NEW.cod, :OLD.cod), v_operacao, :OLD.cod_status, :NEW.cod_status);
END;
/
