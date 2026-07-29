#!/bin/bash

ficheiro_dados="dados/vendas_servidor.csv"
pasta_resultados="resultados"
pasta_logs="logs"
ficheiro_relatorio="$pasta_resultados/relatorio_vendas.txt"
ficheiro_log="$pasta_logs/execucao.log"


echo "Gerando relatório..."

# Cria pasta de resultados
mkdir -p $pasta_resultados

# Cria pasta de logs
mkdir -p $pasta_logs

if [ -f "$ficheiro_dados" ]; then
    echo "Ficheiro de dados encontrado."
else
    echo "Ficheiro de dados nao foi encontrado no servidor."
    exit 1
fi 
# numero de linhas do ficheiro de dados
total_linhas=$(wc -l < "$ficheiro_dados")

# numero de registos do ficheiro de dados/ numero de linhas menos o cabeçalho 
if [ $total_linhas -gt 0 ]; then
    total_registos=$((total_linhas - 1))
else
    total_registos=0
fi
#29/07

{
echo "Relatorio de vendas"
echo "===================="
echo "Data de execução: $(date)"
echo "Runner: $(hostname)"
echo "Utilizador: $(whoami)"
echo "Ficheiro de dados: $ficheiro_dados"
echo "total de linhas: $total_linhas"
echo "total de registos: $total_registos"
echo "===================="
echo "Primeiros 5 registos:"
head -n 6 "$ficheiro_dados"
} > "$ficheiro_relatorio"

echo "$(date) - Relatório criado: $ficheiro_relatorio" >> "$ficheiro_log"

echo "Ficheiro relatorio gerado: $ficheiro_relatorio"
