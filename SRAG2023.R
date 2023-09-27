#analíse dos casos de COVID-19 na base de dados SRAG 2023



rm(list=ls()) ## Limpar a memória do programa
setwd("D:/Downloads")
getwd()

dados = read.csv(file = "INFLUD23-18-09-2023.csv", head = TRUE, sep =";")

dim(dados)

attach(dados)  

names(dados)


## Categorização
#install.packages("ggplot2")
library(ggplot2)
casos <- dados
casos <- casos[!(is.na(casos$CLASSI_FIN)), ]
casos <- casos[!(is.na(casos$VACINA_COV)), ]
casos <- casos[!(is.na(casos$EVOLUCAO)), ]


dim(casos)
casos$CLASSI_FIN
#espaço amostral: 28855 casos de hospitalização por COVID19

vacinados <- casos[casos$VACINA_COV == 1, ]

dim(vacinados)
#88839 pelo menos uma dose

booster2 <- casos[!casos$DOSE_2REF == "", ]
dim(booster2)
#29263 4 doses

booster1 <- casos[!casos$DOSE_REF == "", ]
dim(booster1)
#51531 3 doses ou mais

doses2 <- casos[!casos$DOSE_2_COV == "", ]
dim(doses2)
#77023 2 doses ou mais

doses1 <- casos[!casos$DOSE_1_COV == "",]
dim(doses1) 
#84957 1 dose ou mais

nao_vac <- casos[casos$VACINA_COV == 2, ]
dim(nao_vac)
#86336 0 doses

obitos <- casos[casos$EVOLUCAO == 2, ]
dim(obitos)
#16262 óbitos

dim(booster2[booster2$EVOLUCAO == 2, ])
#5756 óbitos 4 doses

dim(booster1[booster1$EVOLUCAO == 2, ])
#9673 3+ doses

dim(doses2[doses2$EVOLUCAO == 2, ])
#12390 2+ doses

dim(doses1[doses1$EVOLUCAO == 2, ]) 
#12843 1+ doses

dim(nao_vac[nao_vac$EVOLUCAO == 2, ])
#2554 nao vacinados

#15397
data_obitos <- data.frame(
  group = c("4 doses","3 doses","2 doses","1 dose","0 doses"),
  value = c(5756,3917,2717,453,2554)
)

ggplot(data_obitos, aes(x="", y=value, fill=group))+
  geom_bar(stat="identity", width=1, color="white") +
  coord_polar("y", start=0) +
  theme_void() +
  scale_fill_brewer() +
  geom_text(aes(label = value),
            position = position_stack(vjust=0.5))
#15397
data_obitos <- data.frame(
  group = c("3+ doses: 62.82%","2 doses: 17.64% ","1 dose: 2.94%","0 doses: 16.58%"),
  value = c(9673,2717,453,2554)
)



ggplot(data_obitos, aes(x="", y=value, fill=group))+
  geom_bar(stat="identity", width=1, color="white") +
  coord_polar("y", start=0) +
  theme_void() +
  ggtitle("Number of SARS deaths by covid vaccination status 2023 (Brazil 01/01 - 01/09)") +
  theme(plot.title = element_text(hjust = 0.5, size = 13)) +
  scale_fill_brewer() +
  labs(caption = "source: OpenDataSUS, SRAG 2023 - 18-09, https://opendatasus.saude.gov.br/dataset/srag-2021-a-2023") +
  labs(subtitle = "total deaths = 15397") +
  theme(plot.subtitle = element_text(hjust = 0.5, size = 10)) +
  theme(plot.caption = element_text(hjust = 0.5, size = 10)) 
=

