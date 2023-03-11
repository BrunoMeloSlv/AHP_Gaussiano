# AHP_Gaussiano
AHP Gaussiano Aplicado a Tomada de Decisão para contratar um Atacante de Futebol

# A tomada de Decisão para escolher a contratação de um jogador

Resumo: O futebol é um dos maiores entretenimentos do planeta, milhões de pessoas param todos os dias para assistir o jogo de futebol do seu time ou aquele jogo bonito e que traz consigo um espetáculo a parte do que chamamos de habilidade futebolística. Isso faz com que as pesquisas em volta do esporte aumentem, ainda mais atenuante com o avanço computacional e as aplicações das metodologias de ciência de dados ao tema. Nesse estudo é usado o método analytic Hierarchy Process Gaussiano que está dentro do escopo de análise de processos, nele foi traçado o objetivo de através de dados, (gols, tempo de jogo, valor de mercado, idade e assistências), criar um modelo para tomar a melhor decisão no momento da contratação de um atacante que joga em solo europeu, diante de uma base com mais de 5 mil jogadores foi determinado que com 0,21% o melhor jogador que pode ser contratado dentro dos dados analisados neste experimento é o argentino Lionel Messi.

Palavras-chave: Futebol. Coleta de dados. Ciência de dados. Análise de dados. AHP Gaussiano.

Abstract: Football is one of the greatest entertainment on the planet, millions of people stop every day to watch their team's football game or that beautiful game that brings with it a spectacle apart from what we call football skill. This causes research around sports to increase, even more attenuating with computational advancement and the application of data science methodologies to the subject. In this study, the Gaussian Hierarchy Process analytic method is used, which is within the scope of process analysis. make the best decision when hiring a striker who plays on European soil, against a base of more than 5 thousand players it was determined that with 0.21% the best player that can be hired within the data analyzed in this experiment is the Argentine Lionel Messi.

Keywords: Soccer. Data collect. Data science. Data analysis. Gaussian AHP.

 
## Introdução
O futebol é o esporte que faz o telespectador sentir todos os sentimentos conhecidos pela humanidade em cerca de noventa minutos, o público fica em uma espécie de transe durante aquele momento. Um jogo de futebol é um jogo de passagem para frente e movimento para frente. O ataque é o eterno tema do futebol. Ganhar um gol é a essência de um jogo de futebol (WU, 2022).
Segundo (Leoncini & da Silva, 2005) o futebol mundial movimenta, em média, cerca de 250 bilhões de dólares anuais.Ele faz alusão a um artigo realizado em 2005 que faz relação a um estudo da Confederação Brasileira de Futebol (CBF) em conjunto com a Fundação Getúlio Vargas (FGV).
Em 2019 a CBF lançou um estudo fazendo referência ao ano anterior e junto a EY identificou que 0,72% correspondem ao impacto da cadeia produtiva do futebol brasileiro no PIB, isso significa mais de R$ 52 bilhões e aproximadamente 156 mil empregos gerados naquele ano. (CBF & Ernst & Young, 2019)
A exemplo de clube no futebol brasileiro, o Flamengo bateu recorde em seu balancete com um faturamento maior que R$ 1,2 bilhão de receita em 2022. Mostrando que os clubes de futebol são uma parte importante da sociedade, desde um fator social, psicológico outros diriam analgésico do cotidiano, até um fator econômico.
No cenário mundial esse valor obtido pelo clube é ínfimo, se pensarmos que o Neymar foi vendido pelo Barcelona ao Paris Saint Germain (PSG) por € 222 milhões que na cotação atual é maior que R$ 1,2 bilhão, logo o faturamento do Flamengo em 2022 não seria o suficiente para o que foi pago, lógico que são momentos distintos, mas podemos ter noção da diferença econômica do Brasil em relação aos europeus.
Hoje existe uma gama de estudos em volta do futebol e Observatório de Futebol do Centro Internacional de Estudos de Esporte é especialista em coleta de dados voltado ao futebol e afirma que o jogador mais valioso é o Jude Bellingham, inglês que joga no Borussia Dortmund da Alemanha. Segundo o site ele custa € 250 milhões, R$ 1,3 bilhão na nossa moeda. (CIES, 2023)
Deste modo é perceptível a grandeza da indústria do futebol e por esse motivo cresce o número de pessoas que pesquisam com esse tema. Em 2019 quando o Liverpool se consagrou campeão da Liga dos Campeões o site època Negócios soltou a matéria “Como o Liverpool usou dados e tecnologia para vencer a Champions League” e que contém relatos de como o time usou a inteligência de dados para tentar diminuir a distância financeira dos outros clubes europeus e que deu bons frutos por sinal. (ÉPOCA NEGÓCIOS, 2022)

## Material e Métodos
A Analytic Hierarchy Process (AHP) faz parte da Pesquisa operacional, (Sobrapo, 2023) é a área de conhecimento que estuda, desenvolve e aplica métodos analíticos avançados para auxiliar na tomada de melhores decisões nas mais diversas áreas de atuação humana.
Segundo o (Hillier & Lieberman, 2013) a pesquisa operacional é atribuída aos primórdios da segunda guerra mundial quando se percebeu a necessidade de alocar de forma eficiente os escassos recursos que existiam para as operações militares.
O método AHP, que é o propulsor do método que iremos utilizar aqui, foi visto pela primeira vez na década de 1970 em um artigo publicado por Thomas L. Saaty, em 1980 ele lançou o livro Decision Manking: The Analytic Hierarchy Process.
Esse método consiste em fornecer uma forma de modelar e avaliar um problema de decisão, mensurando as variáveis imputadas em uma hierarquia de critérios ponderados.  O resultado é uma metodologia que permite comparar as alternativas, por isso tornou-se conhecido como um método de decisão, tornando- o uma metodologia para tentar minimizar as falhas do processo.
Para utilizar essa metodologia é necessário que o tomador de decisão atribua pesos comparando os pares de variáveis, introduzindo um conceito subjetivo, podendo ser atribuídos de forma arbitrária. 
O resultado final depende muito da percepção da pessoa que irá atribuir os pesos, imagino que você deva divergir no critério do que é mais importante em um time, alguns dirão que o camisa 10, famoso meio de campo é 3 vezes mais importante que o goleiro, outros dirão que o goleiro é mais importante.
Deste modo um grupo de estudos aqui do Brasil desenvolveu o AHP Gaussiano, publicado no International Journal of the Analytic Hierarchy Process (IJAHP) por Santos, Gomes e Costa (2021),  aonde eles fizeram a proposta de utilizar a normalização dos dados para atribuir pesos tirando o fardo de atribuir peso dos tomador de decisão, como também tirando o fator subjetivo do teste.
Os dados que serão utilizados aqui foram retirados do Kaggle, disponibilizado de forma pública pelo David Cariboo. Ele fez um Web Scrapping no site transfermarket, com os jogadores que atuam no futebol europeu, e fez o upload de várias tabelas segmentadas por competição, jogos, clubes, jogadores e outras. 
As tabelas foram baixadas e imputadas em um SGBD para facilitar a escolha dos dados que seriam utilizados nesse estudo visto que as tabelas estão normalizadas. Selecionados os dados que seriam utilizados que são: nome_jogador, posicao, idade, valor_de_mercado, gols, assistências e minutos_jogados.
Esses dados foram levados para o R-studio, um software estatístico, que irá auxiliar no cálculo necessário do método escolhido. Para fazer esse estudo resolvi utilizar apenas a posição atacante. Para iniciar o estudo devemos desvencilhar as variáveis de custo das de benefício, a primeira significa que quanto maior pior é o resultado, a exemplo de valor_de_mercado visto que quero tomar a decisão de comprar o passe de um jogador, outra variável que determinei como custo foi a idade visto que existe uma correspondência entre menores idades e maiores valores.
Quanto às outras variáveis: gols, assistências e minutos_jogados, foram definidas como benefícios, ou seja, quanto maior melhor. A divisão é necessária para decidirmos qual a fórmula que iremos usar para determinar a matriz de decisão.
Custo:
 ![image](https://user-images.githubusercontent.com/91537585/224507573-d369b5e8-86ca-4679-b97f-d9c39d94ab3a.png)
Benefício:
![image](https://user-images.githubusercontent.com/91537585/224507582-30012c5e-fe6f-4928-a510-fe067dede0ec.png)
Cada coluna somada é igual a 1, porque traçamos o percentual que cada jogador tem dentro de cada variável. Depois disso vamos para o cálculo da média das alternativas em cada critério. Observe, se a soma é igual a 1 e sabemos que a media é a soma de todas as observações dividido pelo número de observações, todas as médias é 1 dividido pela contagem de observações (5499). Nesse mesmo momento vamos encontrar o desvio padrão de cada variável. 
![image](https://user-images.githubusercontent.com/91537585/224507593-728982a4-5cca-4b52-8b41-2892fd5857b7.png)
O próximo passo é encontrar o fator gaussiano e para isso iremos dividir o desvio padrão pela média, encontrando o seguinte resultado.
![image](https://user-images.githubusercontent.com/91537585/224507598-cc43fb79-a1e5-4d2b-a85c-b0fb9ebdc756.png)
A última etapa antes do resultado, tão esperado, é normalizar esses dados visto que cada uma variável está usando a métrica de sua coluna ainda, então vamos somar todas as variáveis e dividir cada uma por esse total, encontrando assim o percentual de importância de cada variável para o cálculo.
![image](https://user-images.githubusercontent.com/91537585/224507605-8e283f74-2fb9-403f-b9ae-353e993f28dd.png)
Encontrando a fórmula final, multiplica cada variável normalizada, que encontramos lá no primeiro passo com a separação custo e benefício, pelos valores encontrados na tabela 3. 
![image](https://user-images.githubusercontent.com/91537585/224507610-3e1e7eb0-1d14-47bb-9c63-bf6a00f0cffd.png)
Assim ficando o nosso formato final de modelo e verificando o resultado identificamos que o melhor atacante para ser contratado com 0,28% é o Messi, pode até parecer um valor pequeno, mas deve lembrar que o 1/5499 é igual a 0,0182% médio para cada jogador visto que a soma do resultado é igual a 1. 
 
## Conclusão
O valor percentual indicado de 0,21% para o primeiro jogador demonstra que o dataset é muito grande para avaliar com mais precisão, mas que se um determinado time tem a famigerada lista de possíveis nomes que podem ser contratados, este método pode funcionar de forma a diminuir os riscos no momento da decisão, auxiliando os responsáveis em decidir utilizando dados e trazendo propriedade no momento de argumentar a decisão tomada.
Em um cenário brasileiro provavelmente limitaria o valor, talvez escolheria um dataset com jogadores nacionais. Acredito piamente que o AHP Gaussiano pode ser uma forma de municiar os clubes e seus representantes nas decisões de contratações.

## Referências
Almeida, M., Coelho, R., Oliveira, D., Camargo, A., & Savioli, P. (2020). Sales-based Brand Equity as a Performance Driver in ‘The Country of Soccer’. Revista de Administração Contemporânea, pp. v. 24, n. 2, art. 2, pp. 134-150.
Barreto, M., Mendonça, M., Farias, G., & Oliveira, R. (Dezembro de 2022). Compreensão Estatística de Professores em Formação Inicial. Bolema, pp. v. 36, n. 74, p. 1115-1134.
Barroso, D. J. (2021). MÉTODO AHP (ANALYTIC HIERARCHY PROCESS - GAUSSIANO) NA DETERMINAÇÃO DE AQUISIÇÃO DE UM APARELHO CELULAR. Revista Eletrônica Ciência & Tecnologia Futura, pp. v2 n1 pg 1-12.
Ribeiro, R. R. (set/dez de 2022). A geopolítica do pós-Segunda Guerra vista a partir do futebol. Varia Historia, Belo Horizonte, pp. vol. 38, n. 78, p. 1007-1012.
Santos, C., & Santos, V. (Abril/Junho de 2022). Competência em Informação (CoInfo) como fator social de compreensão e inclusão ao mundo do trabalho sob as perspectivas de Guy Le Boterf e Christine Bruce: notas introdutórias,reflexões necessárias. Perspectivas em Ciência da Informação, pp. v.27, n. 2, p. 268-296.
Wu, J. (Novembro/Dezembro de 2022). INTERLEAVED TACTICAL TRAINING OF BIG FOOTBALL TEAMS. Revista Brasileira de Medicina do Esporte, pp. Vol. 28, No 6.
Alcoforado, L. F. (2021). Utilizando a Linguagem R. Rio de Janeiro: Alta Books.
analisemacro. (02 de 02 de 2023). analisemacro. Fonte: analisemacro: https://analisemacro.com.br/data-science/controles-de-fluxo-if-else-for-e-while-no-r/
Bruce, A., & Bruce, P. (2019). Estatística Prática. Rio de Janeiro: Alta Books.
CBF, & Ernst & Young. (2019). CBF. Fonte: CBF: https://conteudo.cbf.com.br/cdn/201912/20191213172843_346.pdf
CIES. (02 de 02 de 2023). CIES. Fonte: CIES: https://football-observatory.com/-values-173080
dos Santos, M., Costa, I. P., & Gomes, C. F. (2021). MULTICRITERIA DECISION-MAKING IN THE SELECTION OF WARSHIPS: A NEW APPROACH TO THE AHP METHOD. International Journal of the Analytic Hierarchy Process, pp. Vol. 13 147-169.
Epóca Negócios. (21 de Março de 2022). Fonte: Globo: https://epocanegocios.globo.com/Empresa/noticia/2019/06/como-o-liverpool-usou-dados-e-tecnologia-para-chegar-final-da-champions-league.html
ge, R. d. (02 de 02 de 2022). GE. Fonte: Globo: https://ge.globo.com/futebol/selecoes/franca/noticia/2022/12/19/final-da-copa-do-mundo-entre-argentina-e-franca-tem-a-maior-audiencia-da-historia-da-tv-francesa.ghtml
Hillier, F. S., & Lieberman, G. J. (2013). Introdução à Pesquisa Operacional. Porto Alegre: AMGH Editora Ltda.
Interior, A. F. (02 de 02 de 2023). Futebol Interior. Fonte: Futebol Interior: https://www.futebolinterior.com.br/como-o-futebol-e-servicos-relacionados-ajudam-a-movimentar-a-economia-do-brasil/#:~:text=Um%20estudo%20idealizado%20pela%20CBF,milh%C3%B5es%20s%C3%A3o%20de%20efeitos%20indiretos.
kaggle. (21 de Março de 2022). kaggle. Fonte: kaggle: https://www.kaggle.com/datasets/rczekster/matches-brazilian-football-from-2003-to-2019/metadata
Lance. (02 de 02 de 2023). Futebol Internacional. Fonte: Lance: https://www.lance.com.br/futebol-internacional/qual-e-o-jogador-mais-caro-do-mundo-veja-quais-sao-os-mais-valiosos.html#:~:text=De%20acordo%20com%20o%20Observat%C3%B3rio,cerca%20de%20R%24%201%2C179%20bilh%C3%A3o.
Leoncini, M. P., & da Silva, M. T. (jan.-abr. de 2005). ENTENDENDO O FUTEBOL COMO UM NEGÓCIO: UM ESTUDO EXPLORATÓRIO. Gestão e Produção, pp. v.12, n.1, p.11-23.
Pereira, C. (2001). Análise de Dados Qualitativos Aplicados às Representações Sociais. Psicologia, Vol. XV, pp. 177-204.
psicometriaonline. (22 de 01 de 2023). Blog. Fonte: psicometriaonline: https://psicometriaonline.com.br/analise-de-correspondencia/
Riveira, C. (02 de 02 de 2022). Exame. Fonte: Exame: https://exame.com/economia/a-industria-da-copa-do-mundo-estudo-mostra-os-bilionarios-numeros-do-mundial/
Silva, H. A. (02 de 02 de 2023). RPubs. Fonte: RPubs: https://rpubs.com/henriquealvarenga/350498
Sobrapo. (02 de 02 de 2023). Sobrapo. Fonte: Sobrapo: https://www.sobrapo.org.br/o-que-e-pesquisa-operacional#:~:text=Pesquisa%20Operacional%20(PO)%20%C3%A9%20a,diversas%20%C3%A1reas%20de%20atua%C3%A7%C3%A3o%20humana.
Wickham, H., & Grolemund, G. (2019). R para Data Science. Rio de Janeiro: Alta Books.
R CORE TEAM. R: A language and environment for statistical computing. R Foundation for Statistical Computing, Vienna, Austria. 2013. ISBN 3-900051-07-0, URL http://www.R-project.org/.
