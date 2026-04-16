# 🔄 Atualizador de Sistemas Delphi

Sistema desenvolvido em **Delphi 13** para gerenciamento e execução de atualizações automáticas de aplicações desktop.

---

## 📌 Sobre o Projeto

O **Atualizador de Sistemas Delphi** é uma aplicação responsável por controlar e aplicar atualizações de executáveis em ambiente corporativo, garantindo que os usuários estejam sempre utilizando a versão mais recente do sistema.

O sistema permite configurar caminhos de origem, validar versões e executar atualizações de forma segura e controlada.

---

## 🖥️ Funcionalidades

✔️ Atualização automática de executáveis
✔️ Controle de versão do sistema
✔️ Configuração de diretórios de origem e destino
✔️ Interface simples para o usuário final
✔️ Opção de atualizar imediatamente ou posteriormente
✔️ Tela de configurações protegida por login
✔️ Registro de logs de atualização

---

## 🧰 Tecnologias Utilizadas

* Delphi 13 (VCL)
* FireDAC (acesso a dados)
* Banco de Dados: Firebird 2.5
* DBeaver
* Arquitetura Desktop

---

## 📷 Telas do Sistema

### 🔹 Tela Principal

* Exibe versão atual
* Permite iniciar atualização
* Interface amigável para o usuário

### 🔹 Configurações

* Definição do executável a ser atualizado
* Caminho de origem dos arquivos
* Controle de versão
* Acesso protegido por login

---

## 🔐 Segurança

O acesso às configurações do sistema é protegido por autenticação, evitando alterações indevidas nos parâmetros críticos da aplicação.

---

## ⚙️ Como Funciona

1. O sistema verifica a versão atual do executável
2. Compara com a versão disponível no diretório configurado
3. Caso exista uma versão mais recente:

   * Permite atualização imediata
   * Ou agendamento para depois
4. Realiza a substituição do executável de forma segura

---

## 📁 Estrutura do Projeto

```bash
/src
  AtualizadorSistema.dpr
  Unit1.pas
  unitDm.pas
  unitFrmConfiguracoes.pas
```

---

## 🚀 Como Executar

1. Clonar o repositório:

```bash
git clone https://github.com/Git-Jocelio/atualizacao-sistema-delphi.git
```

2. Abrir o projeto no Delphi 13

3. Configurar:

* Caminho do executável
* Diretório de atualização
* Banco de dados Firebird

4. Executar a aplicação

---

## 📌 Observações

* O sistema foi desenvolvido com foco em ambiente corporativo
* Pode ser adaptado para diferentes tipos de aplicações desktop
* Ideal para controle de versões em rede local

---

## 👨‍💻 Autor

**Jocelio Gomes da Silva**

---

## 📄 Licença

Este projeto está disponível para fins de estudo e demonstração.
