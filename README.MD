# Boletim Plus

Global Solution 2026/2 · CitizenTech
Disciplina: Mastering Relational and Non-Relational Database

## Integrantes

| Nome | RM |
|---|---|
| Gustavo Barrios de Araújo | 563358 |
| Phietro Solon Oliveira | 563842 |

## 1. Problema CitizenTech

Em diversas escolas, o responsável costuma saber da nota baixa ou das faltas do filho só no fim do bimestre, quando o boletim em papel chega. Nessa hora, a recuperação já ficou difícil.

O **Boletim Plus** é um boletim digital. O professor registra notas e presenças, e o sistema:

- calcula a média por aluno e disciplina e classifica a situação (aprovado, recuperação, reprovado);
- calcula a frequência e gera um alerta quando ela fica abaixo de 75%;
- indica quais responsáveis devem ser avisados de cada alerta;
- guarda o histórico das mudanças de status dos usuários, para auditoria.

O cidadão ganha acompanhamento escolar em tempo real, sem depender de reunião presencial ou de papel.

## 2. Estrutura do repositório

```
src/
├── relational_db/
│   ├── 00_drop.sql          remove as tabelas (reexecução limpa)
│   ├── 01_ddl.sql           criação das 19 tabelas
│   ├── 02_dml.sql           dados de teste
│   ├── 03_blocos_plsql.sql  2 blocos anônimos (cursor, decisão, repetição)
│   ├── 04_funcoes.sql       2 funções
│   ├── 05_procedures.sql    2 procedimentos
│   ├── 06_triggers.sql      2 gatilhos (1 de auditoria)
│   ├── 07_pacotes.sql       2 pacotes (specification + body)
│   ├── 08_testes.sql        testes de funções, procedimentos, gatilhos e pacotes
│   └── 09_relatorios.sql    3 relatórios equivalentes aos do MongoDB
└── non_relational/
    ├── 01_setup.js          database, collections e carga de documentos
    └── 02_consultas.js      3 relatórios (2 find + 1 aggregate)
```

## 3. Como executar

### Oracle

1. Conecte-se ao SQL Developer.
2. Execute os scripts na ordem, de `00_drop.sql` a `09_relatorios.sql`. No SQL Developer, use **Run Script (F5)**.

Na primeira execução, o `00_drop.sql` retorna `ORA-00942` porque as tabelas ainda não existem. Esse erro é esperado.

O `08_testes.sql` termina com `ROLLBACK`, e nenhum objeto PL/SQL faz `COMMIT`. Assim, os dados voltam ao estado do `02_dml.sql`, e os relatórios do `09_relatorios.sql` ficam iguais aos do MongoDB.

### MongoDB

1. Abra o `mongosh`. No shell do Compass, rode `use boletim_plus` sozinho antes de colar o resto do script.
2. Execute o `01_setup.js`. Ele seleciona o database `boletim_plus`, recria as collections e insere os documentos.
3. Execute o `02_consultas.js`.

Pelo terminal: `mongosh < src/non_relational/01_setup.js` e depois `mongosh < src/non_relational/02_consultas.js`.

## 4. Regras de negócio no Oracle

| Objeto | Regra |
|---|---|
| Bloco 1 (cursor, `LOOP`, `IF`) | Média por aluno e disciplina: ≥ 60 aprovado, ≥ 50 recuperação, < 50 reprovado |
| Bloco 2 (`FOR`, cursor aninhado) | Frequência < 75% gera alerta e lista os responsáveis a avisar |
| `fn_media_aluno` / `fn_frequencia_aluno` | Média e % de presença da matrícula |
| `pr_registrar_nota` | Registra a nota só se a avaliação for da turma do aluno |
| `pr_registrar_presenca` | Registra a presença e alerta se a frequência cair abaixo de 75% |
| `trg_historico_status_usuario` | Auditoria: grava data, operação e status antigo/novo do usuário |
| `trg_valida_data_presenca` | Bloqueia presença em data futura |
| `pkg_notas` / `pkg_frequencia` | Agrupam as funções e procedimentos de notas e de frequência |

## 5. Mapeamento Oracle → MongoDB

| Oracle | MongoDB | Estratégia |
|---|---|---|
| `Aluno` + `Pessoa` | `alunos` | `_id` = `Aluno.cod` |
| `AlunoGuardiao` + `Guardiao` + `Pessoa` + `TipoParentesco` | `alunos.responsaveis[]` | Incorporado |
| `Boletim` + `TurmaAluno` | `notas` | Referência `aluno_id` → `alunos._id` |
| `Avaliacao` + `TipoNota` + `Turma` + `TipoCurso` | `notas.avaliacao`, `notas.curso` | Incorporado |

- **Responsáveis incorporados:** são poucos por aluno e sempre lidos junto com ele.
- **Notas em collection própria:** crescem durante o ano e são agregadas entre alunos; dentro de `alunos`, o documento cresceria sem limite.
- **Avaliação e curso incorporados na nota:** são pequenos e não mudam depois de lançados.
- **Só no Oracle:** usuários, auditoria, escola e presença, que dependem de regras transacionais e gatilhos.

## 6. Relatórios e comparação

Os 3 relatórios estão em `09_relatorios.sql` (Oracle) e `02_consultas.js` (MongoDB) e retornam os mesmos dados.

| Relatório | Oracle | MongoDB | Resultado |
|---|---|---|---|
| 1. Notas do aluno 1 por data | 5 joins | `find` + `sort` | 5 notas do Bart |
| 2. Alunos com Homer Simpson como responsável | 4 joins | `find` no array `responsaveis` | Bart e Lisa |
| 3. Média por aluno e disciplina | `GROUP BY` + `AVG` | `aggregate` com `$group`, `$lookup` | 6 médias, de 40 a 100 |

## 7. Evidências

Os erros `ORA-20001`, `ORA-20002` e `ORA-20003` nos testes são casos negativos, provocados de propósito.

| Oracle | MongoDB |
|---|---|
| [Tabelas e dados](src/evidencias/01_oracle_tabelas.png) | [Carga](src/evidencias/08_mongo_setup.png) |
| [Blocos PL/SQL](src/evidencias/02_oracle_blocos.png) | [Documentos de alunos](src/evidencias/09_mongo_alunos.png) |
| [Objetos compilados](src/evidencias/03_oracle_objetos.png) | [Relatório 1](src/evidencias/10_mongo_relatorio_1.png) |
| Testes [1](src/evidencias/04_oracle_testes_1.png), [2](src/evidencias/04_oracle_testes_2.png), [3](src/evidencias/04_oracle_testes_3.png) | [Relatório 2](src/evidencias/11_mongo_relatorio_2.png) |
| Relatórios [1](src/evidencias/05_oracle_relatorio_1.png), [2](src/evidencias/06_oracle_relatorio_2.png), [3](src/evidencias/07_oracle_relatorio_3.png) | [Relatório 3](src/evidencias/12_mongo_relatorio_3.png) |

## Uso de IA generativa

| Ferramenta | Para quê |
|---|---|
| Claude | Debug e Documentação |
