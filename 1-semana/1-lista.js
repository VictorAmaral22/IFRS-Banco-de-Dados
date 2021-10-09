/*

------------ A

siteDeRoms (
    nomeconsole1, 
    genero1, genero2,
    console1, romgenero1, romregiao1, romdownloads1, romrating1,
    romconsole2, romgenero2, romregiao2, romdownloads2, romrating2,
)

consoles (
    codigo
    nome
)

generos (
    codigo
    nome
    roms
)

rom (
    codigo
    nome
    generos
    regiao
    downloads
    rating
)

------------ B

x Quem postou um post?
x Quando um post foi postado?
x Quais os assuntos de um post?
x Quais as pessoas citadas em um post?
x Quem comentou um post?
x Quando um comentário em um post foi feito?
x Quem comentou um comentário em um post?
x Quando um comentário em um comentário foi feito?
x Quem reagiu a um post?
x Quando uma reação a um post ocorreu?
x Quem reagiu a um comentário em um post?
x Quando a reação a um comentário ocorreu?
x Quem compartilhou um post?
x Quem são os amigos de uma pessoa?
x Quem são os amigos em comum entre duas pessoas?
x Quais são os grupos de uma pessoa?
x Quem participa de cada grupo?
x Quais páginas uma pessoa curtiu?
Quais os posts mais comentados de um usuário em um intervalo de datas?
Quais os posts com mais reações de um usuário em um intervalo de datas?
Quais os assuntos mais comentados em uma cidade em um intervalo de datas?
Quais os assuntos com mais reações em uma cidade um intervalo de datas?
Quais os assuntos mais comentados em um estado em um intervalo de datas?
Quais os assuntos com mais reações em um estado um intervalo de datas?
Quais os assuntos mais comentados em um país em um intervalo de datas?
Quais os assuntos com mais reações em um país um intervalo de datas?

Perfil (
    nome
    cidade
    UF
    Pais
    amigos
    posts
    grupos
    paginas
)

Post (
    perfil
    data
    assuntos
    citacoes
    comentarios
    reacoes
    compartilhamentos
)

Grupo (
    nome
    perfis
)

Pagina (
    nome
    perfis
)

Comentario (
    perfil
    post
    data
    resposta
    reacao
)

Resposta (
    perfil
    comentario
    data
    reacao
)

ReacaoPost (
    post
    perfil
    data
)

ReacaoComentario (
    post
    comentario
    perfil
    data
)

ReacaoResposta (
    post
    comentario
    resposta
    perfil
    data
)

Compartilhamento (
    post
    perfil
    data
)

------------ C

x Qual o candidato mais votado na última eleição por cargo?
x Qual o candidato mais votado na última eleição por cargo por partido?
x Qual a quantidade de candidatos por partido por cargo na última eleição?
x Qual o percentual de votos brancos na última eleição por cargo?
x Qual o percentual de votos nulos na última eleição por cargo?
x Qual o percentual de votos válidos na última eleição por cargo?
x Quais as zonas de uma cidade?
x Quais as seções de uma zona?
x Quais eleitores não votaram na última eleição por zona?
x Quais eleitores não votaram na última eleição por seção?
X Quantos eleitores justificaram voto na última eleição por zona?
X Quantos eleitores justificaram voto na última eleição por seção?
x Quais eleitores que não votaram nas últimas 3 eleições por zona?
x Quais eleitores que não votaram nas últimas 3 eleições por seção?
x Qual o percentual de eleitores por gênero e por faixa etária de uma seção?

candidato (
    nome
    votos
    cargo
    ano
    partido
)

cargo (
    nome
    ano
    votosvalidos
    votosbrancos
    votosnulos
)

cidade (
    nome
    zonas
    secoes
)

eleitor (
    nome
    genero
    nascimento
    cidade
    zona
    secao
)

votacao (
    data
    nomeEleitor
    votoEleitor
)

justificativa (
    votacao
    nomeEleitor
    justificou
)
*/