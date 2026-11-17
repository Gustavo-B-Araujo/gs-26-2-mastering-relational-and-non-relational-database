
use boletim_plus

db.alunos.drop();
db.notas.drop();

db.createCollection("alunos");
db.createCollection("notas");

db.alunos.insertMany([
    {
        _id: 1,
        nome: "Bart Simpson",
        documento: "12345678904",
        responsaveis: [
            { nome: "Homer Simpson", parentesco: "Pai" },
            { nome: "Marge Simpson", parentesco: "Mãe" }
        ]
    },
    {
        _id: 2,
        nome: "Lisa Simpson",
        documento: "12345678905",
        responsaveis: [
            { nome: "Homer Simpson", parentesco: "Pai" },
            { nome: "Marge Simpson", parentesco: "Mãe" }
        ]
    },
    {
        _id: 3,
        nome: "Milhouse Van Houten",
        documento: "12345678906",
        responsaveis: [
            { nome: "Kirk Van Houten", parentesco: "Pai" }
        ]
    }
]);

db.notas.insertMany([
    { _id: 1,  aluno_id: 1, curso: "Português",  avaliacao: { nome: "Prova 1",    tipo: "Prova",    data: new Date("2026-09-15") }, nota: 45 },
    { _id: 2,  aluno_id: 1, curso: "Português",  avaliacao: { nome: "Trabalho 1", tipo: "Trabalho", data: new Date("2026-10-10") }, nota: 60 },
    { _id: 3,  aluno_id: 3, curso: "Português",  avaliacao: { nome: "Prova 1",    tipo: "Prova",    data: new Date("2026-09-15") }, nota: 70 },
    { _id: 4,  aluno_id: 3, curso: "Português",  avaliacao: { nome: "Trabalho 1", tipo: "Trabalho", data: new Date("2026-10-10") }, nota: 75.5 },
    { _id: 5,  aluno_id: 1, curso: "Matemática", avaliacao: { nome: "Prova 1",    tipo: "Prova",    data: new Date("2026-09-16") }, nota: 30 },
    { _id: 6,  aluno_id: 1, curso: "Matemática", avaliacao: { nome: "Caderno",    tipo: "Caderno",  data: new Date("2026-11-05") }, nota: 55 },
    { _id: 7,  aluno_id: 3, curso: "Matemática", avaliacao: { nome: "Prova 1",    tipo: "Prova",    data: new Date("2026-09-16") }, nota: 68 },
    { _id: 8,  aluno_id: 3, curso: "Matemática", avaliacao: { nome: "Caderno",    tipo: "Caderno",  data: new Date("2026-11-05") }, nota: 80 },
    { _id: 9,  aluno_id: 2, curso: "História",   avaliacao: { nome: "Prova 1",    tipo: "Prova",    data: new Date("2026-09-17") }, nota: 100 },
    { _id: 10, aluno_id: 1, curso: "História",   avaliacao: { nome: "Prova 1",    tipo: "Prova",    data: new Date("2026-09-17") }, nota: 40 }
]);

db.alunos.countDocuments();
db.notas.countDocuments();
