# Containers Docker
## Definições
Gerador de containers docker para agilidade e testes em desenvolvimento.

Containers disponíveis neste projeto:

- MSSQL 2017
- MSSQL 2019
- ORACLE 11g EXPRESS
- ORACLE 12c ENTERPRISE
- ORACLE 19c ENTERPRISE
- RabbitMQ

## Requisitos
Requisitos necessários para utilizar a solução de containers docker:

- [Docker Desktop](https://www.docker.com/products/docker-desktop) >= 19.03.0+ (Windows/macOS/Linux)
- Docker Compose (Instalado juntamente com o Docker no Windows e macOS)

>Para uso de containers **Oracle** é necessário primeiramente gerar as imagens oficiais através do projeto oficial da Oracle disponível no [GitHub](https://github.com/oracle/docker-images)

## Teste
O arquivo __docker-compose.yml__ localizado na raíz do projeto serve como orquestrador dos containers docker. Nele estão as configurações e variáveis de ambiente de cada container.

Para executar um determinado container, execute o seguinte comando na raíz do projeto, utilizando um terminal:

```Shell
docker-compose up --build -d < service >
```

>onde, < service >:
>- mssql2017
>- mssql2019
>- oracle11
>- oracle12
>- oracle19
>- rabbitmq
