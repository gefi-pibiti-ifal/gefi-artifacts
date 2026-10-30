# GeFi: corpus e avaliação de satisfação

Material complementar do artigo sobre o **GeFi**, sistema de apoio a fiscais e
gestores de contratos da CGFC/IFAL. O repositório reúne:

- a lista dos documentos normativos públicos que compõem o corpus usado pelo GeFi;
- as respostas anonimizadas da segunda avaliação de satisfação com os usuários (agosto de 2026);
- a modelagem do banco de dados do backend;
- os requisitos funcionais do sistema.

## Estrutura

```
.
├── README.md
├── banco-de-dados/
│   ├── README.md                       # DER, visão geral e dicionário de dados
│   ├── schema.sql                      # DDL PostgreSQL gerado do schema Prisma
│   └── schema.png                      # Diagrama entidade-relacionamento
├── corpus/
│   └── README.md                       # Normas federais do corpus, com links oficiais
├── requisitos/
│   └── README.md                       # Requisitos funcionais (RF01 a RF09)
└── avaliacao/
    └── avaliacao-II-respostas.md       # Perguntas, respostas e síntese
```

## Corpus

Quatro normas federais de acesso público: a Lei n.º 14.133/2021, a IN SEGES/MP n.º 5/2017,
o Decreto n.º 12.174/2024 e a IN SEGES/MGI n.º 147/2026. Os links oficiais estão em
[`corpus/README.md`](corpus/README.md). Os textos das normas não são redistribuídos aqui.

## Banco de dados

Modelo relacional do backend (PostgreSQL + pgvector) com 7 tabelas, derivado do schema
Prisma. Detalhes, diagrama e dicionário de dados em
[`banco-de-dados/README.md`](banco-de-dados/README.md).

## Requisitos funcionais

Os nove requisitos funcionais do GeFi (RF01 a RF09) estão em
[`requisitos/README.md`](requisitos/README.md).

## Avaliação II de satisfação

Formulário aplicado ao fim da segunda reunião de avaliação, com 2 respondentes.

| Pergunta | Respondente 1 | Respondente 2 |
|---|---|---|
| 1. Satisfação com o projeto (1 a 5) | 4 | 4 |
| 2. O sistema pode auxiliar no dia a dia (1 a 5) | 5 | 5 |
| 3. Melhorias desde a última reunião (1 a 5) | 4 | 4 |

As respostas abertas (perguntas 4 e 5) e a síntese estão em
[`avaliacao/avaliacao-II-respostas.md`](avaliacao/avaliacao-II-respostas.md).

### Anonimização

O formulário não coletou nome nem e-mail, e o carimbo de data/hora foi removido.
