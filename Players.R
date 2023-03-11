

# Importando os dados -----------------------------------------------------
pacotes <- c("RPostgres","broom","readxl","dplyr","tidyr","ggplot2","ggrepel","corrgram",
             "corrplot","GGally","knitr",'readr','outliers','EnvStats','clipr',"e1071","plotly"
             ,"readr","tidyverse","kableExtra","sjPlot","FactoMineR","amap","ade4","car",'nortest')

if(sum(as.numeric(!pacotes %in% installed.packages())) != 0){
  instalador <- pacotes[!pacotes %in% installed.packages()]
  for(i in 1:length(instalador)) {
    install.packages(instalador, dependencies = T)
    break()}
  sapply(pacotes, require, character = T) 
} else {
  sapply(pacotes, require, character = T) 
}

conn <- DBI::dbConnect(RPostgres::Postgres(), dbname="Tranfermarket", 
                       user = "postgres" ,password = "10354687")


Player = dbGetQuery(conn,
'SELECT
PL.name 																		AS NOME_JOGADOR,
PL.position																		AS POSICAO,
PL.sub_position																	AS SUB_POSICAO,
PL.country_of_birth																AS NACIONALIDADE,
EXTRACT (YEAR FROM AGE(CURRENT_DATE, PL.date_of_birth))							AS IDADE,
PL.market_value_in_eur															AS VALOR_DE_MERCADO,
PL.highest_market_value_in_eur													AS MAIOR_VALOR_DE_MERCADO,
SUM(AP.yellow_cards) 															AS CARTOES_AMARELOS,
SUM(AP.red_cards) 																AS CARTOES_VERMELHOS,
SUM(AP.goals) 																	AS GOLS,
SUM(AP.assists) 																AS ASSISTENCIAS,
SUM(AP.minutes_played) 															AS MINUTOS_JOGADOS
FROM "Tranfermarket_excel".appearances 											AS AP
INNER JOIN "Tranfermarket_excel".player											AS PL
ON PL.player_id = AP.player_id 	
GROUP BY PL.name, PL.position, PL.sub_position,PL.country_of_birth,PL.market_value_in_eur,PL.highest_market_value_in_eur,
PL.date_of_birth'
               )

#View(Player)

summary(Player)

#Retirando os NA's
Player <- Player[!is.na(Player$valor_de_mercado),]
Player <- Player[!is.na(Player$maior_valor_de_mercado),]
Player <- Player[!is.na(Player$idade),]

#estabelecendo que um jogo "normal" tem 90min
Player$numero_de_partidas = round(Player$minutos_jogados / 90,2)


# Anacor ------------------------------------------------------------------
Player <- Player %>% 
  mutate(Vlr_Mercado = case_when(valor_de_mercado <= quantile(valor_de_mercado, 0.25, na.rm = T) ~ "menores_valores",
                                 valor_de_mercado > quantile(valor_de_mercado, 0.25, na.rm = T) & valor_de_mercado <= quantile(valor_de_mercado, 0.75, na.rm = T) ~ "valores_medios",
                                 valor_de_mercado > quantile(valor_de_mercado, 0.75, na.rm = T) ~ "maiores_valores"))

Player <- Player %>% 
  mutate(idade_a = case_when(idade <= quantile(idade, 0.25, na.rm = T) ~ "menores_idades",
                           idade > quantile(idade, 0.25, na.rm = T) & idade <= quantile(idade, 0.75, na.rm = T) ~ "idades_medias",
                           idade > quantile(idade, 0.75, na.rm = T) ~ "maiores_idades"))


anacor_Player <- Player %>% 
  select(Vlr_Mercado, posicao, idade_a)

sjt.xtab(var.row = anacor_Player$Vlr_Mercado,
         var.col = anacor_Player$posicao,
         show.exp = TRUE,
         show.row.prc = TRUE,
         show.col.prc = TRUE, 
         encoding = "UTF-8")

sjt.xtab(var.row = anacor_Player$Vlr_Mercado,
         var.col = anacor_Player$idade_a,
         show.exp = TRUE,
         show.row.prc = TRUE,
         show.col.prc = TRUE, 
         encoding = "UTF-8")

sjt.xtab(var.row = anacor_Player$posicao,
         var.col = anacor_Player$idade_a,
         show.exp = TRUE,
         show.row.prc = TRUE,
         show.col.prc = TRUE, 
         encoding = "UTF-8")

anacor_Player$Vlr_Mercado = as.factor(anacor_Player$Vlr_Mercado)
anacor_Player$posicao = as.factor(anacor_Player$posicao)
anacor_Player$idade_a = as.factor(anacor_Player$idade_a)

ACM <- dudi.acm(anacor_Player, scannf = FALSE)

# Analisando as variâncias de cada dimensão
perc_variancia <- (ACM$eig / sum(ACM$eig)) * 100
paste0(round(perc_variancia,2),"%")

# Quantidade de categorias por variável
quant_categorias <- apply(anacor_Player,
                          MARGIN =  2,
                          FUN = function(x) nlevels(as.factor(x)))

# Consolidando as coordenadas-padrão obtidas por meio da matriz binária
df_ACM <- data.frame(ACM$c1, Variável = rep(names(quant_categorias),
                                            quant_categorias))

# Plotando o mapa perceptual
df_ACM %>%
  rownames_to_column() %>%
  rename(Categoria = 1) %>%
  ggplot(aes(x = CS1, y = CS2, label = Categoria, color = Variável)) +
  geom_point() +
  geom_label_repel() +
  geom_vline(aes(xintercept = 0), linetype = "longdash", color = "grey48") +
  geom_hline(aes(yintercept = 0), linetype = "longdash", color = "grey48") +
  labs(x = paste("Dimensão 1:", paste0(round(perc_variancia[1], 2), "%")),
       y = paste("Dimensão 2:", paste0(round(perc_variancia[2], 2), "%"))) +
  theme_bw()                           



# Método AHP-Gausiano -----------------------------------------------------
Jogador = c(3616,9542,9729,10508,10851,12747,13211,15222,17243,7123)
Teste = AHP[AHP$resultado_percentual >=0.1657972,]

Player[Jogador,]

AHP = Player[Jogador,c(1,2,5,6,10:12)]
AHP = AHP[AHP$posicao == 'Attack              ',]
AHP = AHP[,-2]
View(AHP)




#Determinação de Matriz de decisão

#valores que quanto maior é pior
AHP$valor_de_mercado = 1/AHP$valor_de_mercado
somatorio_vlr_de_mercado = sum(AHP$valor_de_mercado)
AHP$valor_de_mercado = AHP$valor_de_mercado/somatorio_vlr_de_mercado

AHP$idade = 1/AHP$idade
somatorio_idade = sum(AHP$idade)
AHP$idade = AHP$idade/somatorio_idade

#valores que quanto maior melhor


somatorio_gols = sum(AHP$gols)
AHP$gols = AHP$gols/somatorio_gols

somatorio_assistencias = sum(AHP$assistencias)
AHP$assistencias = AHP$assistencias/somatorio_assistencias

somatorio_minutos_jogados = sum(AHP$minutos_jogados)
AHP$minutos_jogados = AHP$minutos_jogados/somatorio_minutos_jogados

#cálculo da média das alternativas em cada critério
media_geral = 1/count(AHP)

dp_idade = sd(AHP$idade)
dp_valor_de_mercado = sd(AHP$valor_de_mercado)
dp_gols = sd(AHP$gols)
dp_assistencias = sd(AHP$assistencias)
dp_minutos_jogados = sd(AHP$minutos_jogados)


#dp = c(dp_idade, dp_valor_de_mercado, dp_gols, dp_assistencias, dp_minutos_jogados)

#fator gausiano
fg_idade =                dp_idade/media_geral
fg_valor_de_mercado =     dp_valor_de_mercado/media_geral
fg_gols =                 dp_gols/media_geral
fg_assistencias =         dp_assistencias/media_geral
fg_minutos_jogados =      dp_minutos_jogados/media_geral

fg_idade = as.numeric(fg_idade)
fg_valor_de_mercado = as.numeric(fg_valor_de_mercado)
fg_gols = as.numeric(fg_gols)
fg_assistencias = as.numeric(fg_assistencias)
fg_minutos_jogados = as.numeric(fg_minutos_jogados)



#fator gausiano normalizado

somatori_fg = fg_idade + fg_valor_de_mercado + fg_gols + fg_assistencias + fg_minutos_jogados

fg_idade_normalizado =              fg_idade/somatori_fg        
fg_valor_de_mercado_normalizado =   fg_valor_de_mercado/somatori_fg  
fg_gols_normalizado =               fg_gols/somatori_fg  
fg_assistencias_normalizado =       fg_assistencias/somatori_fg  
fg_minutos_jogados_normalizado =    fg_minutos_jogados/somatori_fg  


#ponderação da matriz de decisão


fg_idade_normalizado = as.numeric(fg_idade_normalizado)
fg_valor_de_mercado_normalizado = as.numeric(fg_valor_de_mercado_normalizado)
fg_gols_normalizado = as.numeric(fg_gols_normalizado)
fg_assistencias_normalizado = as.numeric(fg_assistencias_normalizado)
fg_minutos_jogados_normalizado = as.numeric(fg_minutos_jogados_normalizado)

AHP$resultado = AHP$idade * fg_idade_normalizado + AHP$valor_de_mercado * fg_valor_de_mercado_normalizado +
  AHP$gols * fg_gols_normalizado + AHP$assistencias * fg_assistencias_normalizado + 
  AHP$minutos_jogados *fg_minutos_jogados_normalizado 

AHP$resultado_percentual = AHP$resultado * 100

View(AHP)

sum(AHP$resultado)




# Regesão -----------------------------------------------------------------
Player_lm = Player[,c(2,5,6,10:12)]
Player_lm = Player_lm[Player_lm$posicao == 'Attack              ' ,]

Player_lm$posicao = NULL

g = rosnerTest(Player_lm$gols)
Player_lm = Player_lm[-g$all.stats$Obs.Num,]

i = rosnerTest(Player_lm$idade)
Player_lm = Player_lm[-i$all.stats$Obs.Num,]

vm = rosnerTest(Player_lm$valor_de_mercado)
Player_lm = Player_lm[-vm$all.stats$Obs.Num,]

a = rosnerTest(Player_lm$assistencias)
Player_lm = Player_lm[-a$all.stats$Obs.Num,]

mj = rosnerTest(Player_lm$minutos_jogados)
Player_lm = Player_lm[,-mj$all.stats$Obs.Num]


count(Player_lm)

f_minmax <- function(x){
  return((x - min(x))/(max(x)-min(x)))
}


Player_lm[,c(1,3:5)] = f_minmax(Player_lm[,c(1,3:5)])

cor_Base = cor(Player_lm)
cor_Base = as.data.frame(cor_Base)
knitr::kable(cor_Base)
ggcorr(Player_lm,label = T)

reg1 = lm(valor_de_mercado ~ ., data = Player_lm)
step_reg1 <- step(reg1, k = 3.841459)
summary(step_reg1)
sftest2(step_reg1$residuals)
plot(step_reg1$residual)

#Inserindo o lambda de Box-Cox na base de dados para a estimação de um novo modelo
lambda_BC_valor_de_mercado <- powerTransform(Player_lm$valor_de_mercado)
Player_lm$bcvalor_de_mercado <- (((Player_lm$valor_de_mercado ^ -0.5) - 1) / 
                                   -0.5)


Player_lm$valor_de_mercado = NULL
ggcorr(Player_lm ,label = T)
reg2 = lm(bcvalor_de_mercado ~ . , data = Player_lm)
step_reg2 <- step(reg2, k = 3.841459)
summary(step_reg2)

Player_lm %>%
  select(bcretorno, gols, assistencias, minutos_jogados,idade) %>%
  kable() %>%
  kable_styling(bootstrap_options = "striped", 
                full_width = F, 
                font_size = 18)



sftest2(step_reg2$residuals)

export_summs(step_reg1, step_reg2,
             model.names = c("Modelo Linear","Modelo Box-Cox"),
             scale = F, digits = 6)

#Plotando os novos resíduos do step_modelo_bc
Player_lm %>%
  mutate(residuos = step_reg2$residuals) %>%
  ggplot(aes(x = residuos)) +
  geom_histogram(aes(y = ..density..),
                 color = "white",
                 fill = "#287D8EFF",
                 bins = 30,
                 alpha = 0.6) +
  stat_function(fun = dnorm, 
                args = list(mean = mean(step_reg2$residuals),
                            sd = sd(step_reg2$residuals)),
                size = 2, color = "grey30") +
  scale_color_manual(values = "grey50") +
  labs(x = "Resíduos",
       y = "Frequência") +
  theme_bw()

plot(step_reg2$fitted.values)



