SELECT
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
PL.date_of_birth

