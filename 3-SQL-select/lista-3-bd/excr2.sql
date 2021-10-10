-- 2) Descreva e justifique as adequações/alterações que foram realizadas nas tabelas criadas para uma rede social nas listas de exercícios anteriores para que o exercício 1 acima pudesse ser resolvido.

-- estado: agora essa table tem como pk a sua uf e o pais, já que o que estes dois atributos tornam cada estado único.

-- cidade: agora a cidade tem como fk a uf e o pais do estado. Estas tuas fks também compõem a pk da cidade, já que estes 3 atributos tornam uma cidade, única.

-- perfil: agora, o perfil referencia a cidade, estado e pais da cidade. Já que ele mora em uma cidade específica que tem valores para o estado e pais específicos dela.

-- amigo: agora, cada amizade de uma pessoa é armazenada. Então, ficaria assim
--      João é amigo de Claudio
--      Claudio é amigo de João
-- Isso para ajudar na resolução das questões i e j.

-- post e coment_compart: desta vez, desfiz a table coment_compart e criei dois atributos novos no post: postComentado e postCompart. Neles será armazenado o valor do post que está sendo comentado ou compartilhado. Caso um post seja somente post, estes campos serão nulos. No post, é referenciado uma cidade, estado e pais ONDE FOI REALIZADO o post. Visto que qualquer usuário pode postar em lugares diferentes de onde cadastraram seus perfis.
-- ex: Fulaninho é de Rio Grande, mas viajou para Londres e fez um post lá.