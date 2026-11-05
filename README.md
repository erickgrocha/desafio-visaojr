# 🎮 Mayk Games

Loja de games com catálogo de jogos, consoles e ofertas por plataforma, em visual retrô 8-bit. Projeto em grupo (4 devs), feito com React e TypeScript.


**🔗 Demo:** https://desafio-visaojr.vercel.app  
**📦 Repositório original:** https://github.com/rTanure/desafio-visaojr


> Fork do repositório do grupo, mantido como registro da minha participação.

## 🧑‍💻 Minha contribuição

Trabalho organizado por issues e pull requests. Entreguei 5 blocos da home:

- **Carrossel reutilizável + seção de Depoimentos** ([PR #25](https://github.com/rTanure/desafio-visaojr/pull/25)): componente `Carousel` genérico em React + TypeScript, com props para quantidade de slides visíveis, posição dos controles e autoplay. Mede a largura com `ResizeObserver`, mostra 1,2 cards e esconde as setas abaixo de 768px, navega em loop com scroll suave e sincroniza o índice ao arrastar.
- **Jogos em destaque** ([PR #26](https://github.com/rTanure/desafio-visaojr/pull/26)): grade de cards com preço calculado a partir do desconto, links para a rota de detalhe (React Router) e cards de benefícios da loja.
- **Save Point** ([PR #27](https://github.com/rTanure/desafio-visaojr/pull/27)): seção de cards com versões desktop e mobile das imagens, alternadas por CSS.
- **Footer** ([PR #20](https://github.com/rTanure/desafio-visaojr/pull/20)): rodapé responsivo com navegação, contato por WhatsApp, redes sociais e formulário.
- **Banner CTA** ([PR #28](https://github.com/rTanure/desafio-visaojr/pull/28)): chamada para ação com botões de WhatsApp e Instagram.

## 👥 Equipe

Desenvolvido por [@rTanure](https://github.com/rTanure), [@erickgrocha](https://github.com/erickgrocha), [@Arthurffv](https://github.com/Arthurffv) e [@DiasCode1](https://github.com/DiasCode1). Detalhes no repositório original.

## 🛠️ Tecnologias

React, TypeScript, Vite, React Router e CSS.

## ▶️ Como rodar

```bash
npm install
npm run dev
```

## 🚧 Próximos passos

Backend com banco de dados relacional (Node.js, TypeScript, Express e PostgreSQL) para substituir os dados mockados. [link do repositório quando existir]
