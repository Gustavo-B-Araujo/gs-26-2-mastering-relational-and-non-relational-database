
use boletim_plus

db.notas.find(
    { aluno_id: 1 },
    { _id: 0, curso: 1, avaliacao: 1, nota: 1 }
).sort({ "avaliacao.data": 1 });

db.alunos.find(
    { "responsaveis.nome": "Homer Simpson" },
    { _id: 0, nome: 1 }
).sort({ nome: 1 });

db.notas.aggregate([
    { $group: { _id: { aluno_id: "$aluno_id", curso: "$curso" }, media: { $avg: "$nota" } } },
    { $lookup: { from: "alunos", localField: "_id.aluno_id", foreignField: "_id", as: "aluno" } },
    { $unwind: "$aluno" },
    { $project: { _id: 0, aluno: "$aluno.nome", curso: "$_id.curso", media: { $round: ["$media", 2] } } },
    { $sort: { aluno: 1, curso: 1 } }
]);
