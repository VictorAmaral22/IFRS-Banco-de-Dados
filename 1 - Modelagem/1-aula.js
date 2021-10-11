/* 

Aula 1 - Modelagem

    BD - Banco de dados
        É uma coleção de dados interligados com informações sobre um domínio.

        Ex: Clientes, Funcionários

    SGBD - Software gerenciador de Banco de Dados
        Interação com sistemas de arquivos
        Manutenção de integridade, segurança
        Gerenciamento de transações
        Controle de concorrência
        Distribuição de carga e dados em cluster


        Ex: MySQL, PostgreSQL, MongoDb


    Modelo Relacional

        Entidade - Objeto real ou abstrato, como se fosse o molde ou uma classificação de algo
            Ex: Funcionários, Pessoas

        Instância - A concretização de uma entidade
            Ex: Fulaninho Clebito, Juninho Deimos

        Atributo - A propriedade de uma Entidade, tipo de dados
            Ex: Lógico, inteiro, real, letra, texto, data

        Domínio - Os valores possíveis para um atributo
        
        Valor - O valor instantâneo daquele atributo

            EXEMPLO:
                Entidade - Pessoa
                Instância - Pablito Meyer
                Atributo - Gênero
                Domínio - "M", "F"
                Valor - "M"

        DICAS     
            - Sempre armazenar os dados da forma mais simples possível. Em vez de armazenar a duração de uma música em minutos, armazêne ela em segundos.
            - Busque dar preferência à códigos, ao invés de coisas literais na hora que pedir em um formulário. Cep x NomedaRua
        
        Monovalorado e Multivalorado
            - Dê preferência à um único valor, um telefone, um endereço, um email. 
            - Se for necessário adicionar mais, coloque em texto separado por vírgulas porém, isso diminui muito a performance.

        Composto
            - Quando temos por exemplo um endereço, pode se agrupar em um atributo, uma coleção de atributos, onde vamos armazenando separadamente cada coisa.

                Ex: endereco = (tipo="AV", logradouro="SILVA PAES", num="123a", bairro="CENTRO", cep="96203909", cidade="RIO GRANDE", uf="RS")

        Determinante
            - Um valor que identifica um instância, a primaryKey

        RELACIONAMENTO
            Pessoa -> tem -> CPF
            CPF - > Identifica -> Pessoa
            -
            Empresa -> tem -> Funcionárioss
            Funcionário -> trabalha -> Empresa
            -
            Livro -> tem -> Autores
            Autor -> escreve -> Livros

        Obrigatoriedade
            Obrigatório - deve
            Opcional - pode

        Cardinalidade
            1:1
                Um trabalhador deve possuir um CPF   (1->1)
                Um CPF deve ser de um trabalhador    (1->1)
            1:N
                Um funcionário pode possuir vários dependentes  (1->N)
                Um dependente deve ser de um funcionário        (1->1)
            N:N
                Um livro pode ser escrito por vários autores (1->N)
                Um autor pode escrever vários livros         (1->N)

        Chaves
            PrimaryKey - Atributo que identifica uma única entidade
            ForeignKey - Atributo de um entidade que na verdade, é a Pk de outra entidade. é utilizar a chave de uma entidade como atributo de outra
            AlternativeKey - Auxilia no aumento do desempenho das consultas

        Integridade Entidade
            PrimaryKeys não podem ser nulas, pois elas identificam uma entidade

        Integridade Referêncial
            ForeignKeys podem ser nulas, ou iguais aos valores de pks se a empresa oferecer por exemplo planos de saúde. A pessoa tem a sua pk, os planos tem a suas próprias pks, mas quando falamos do plano de saúde da pessoa, temos uma fk = a pk dos planos.


















*/