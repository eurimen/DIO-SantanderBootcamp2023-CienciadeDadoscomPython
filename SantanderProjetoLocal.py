#### Para a implementação do desafio, não foi utilizado a API do chat GPT, como sugerido foi utilizado um arquivo xlsx
###  onde o mesmo possui as frases de investimento. No algoritmo, a cada execução as frases são geradas de forma randomica
##   A segunda versão do algoritmo será gerado através da implementação com o modelo gpt_2_simple
#   Porém para o treinamento do modelo para frases de investimento, estou com dificuldades quanto ao treinamento com datasets na web.

import pandas as pd
import random


df_investimentos = pd.read_excel('frases_investimento.xlsx')


frases_investimento = df_investimentos['Frase'].tolist()


df_SDW2023 = pd.read_csv('SDW2023.csv', encoding='latin1', delimiter=';')


textos_personalizados = []
for index, row in df_SDW2023.iterrows():
    user_id = row['UserID']  
    user_name = row['Name']  
    texto_usuario = f"Caro {user_name}! "
    
    
    for _ in range(1):  
        frase_aleatoria = random.choice(frases_investimento)
        texto_usuario += f" {frase_aleatoria}\n"
    
    textos_personalizados.append(texto_usuario)


for texto in textos_personalizados:
    print(texto)
