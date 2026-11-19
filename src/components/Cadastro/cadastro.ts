// Regras do cadastro: funções puras, sem React, fáceis de testar e reaproveitar.

export type DadosCadastro = {
    nome: string;
    email: string;
    cpf: string;
    senha: string;
    confirmacao: string;
};

export type CampoCadastro = keyof DadosCadastro;
export type ErrosCadastro = Partial<Record<CampoCadastro, string>>;

export const SENHA_MINIMA = 8;

export const CADASTRO_VAZIO: DadosCadastro = {
    nome: "",
    email: "",
    cpf: "",
    senha: "",
    confirmacao: "",
};

function apenasDigitos(valor: string): string {
    return valor.replace(/\D/g, "");
}

/** Formata enquanto a pessoa digita: 12345678909 → 123.456.789-09 */
export function mascararCpf(valor: string): string {
    const d = apenasDigitos(valor).slice(0, 11);
    let resultado = d.slice(0, 3);
    if (d.length > 3) resultado += "." + d.slice(3, 6);
    if (d.length > 6) resultado += "." + d.slice(6, 9);
    if (d.length > 9) resultado += "-" + d.slice(9);
    return resultado;
}

/** Confere os dois dígitos verificadores do CPF (aceita com ou sem máscara). */
export function validarCpf(cpf: string): boolean {
    const d = apenasDigitos(cpf);
    // Sequências repetidas (111.111.111-11) passam na conta, mas não são CPFs válidos.
    if (d.length !== 11 || /^(\d)\1{10}$/.test(d)) return false;

    // Dígito n: soma dos n-1 primeiros com pesos decrescentes a partir de n, depois módulo 11.
    const digito = (quantidade: number) => {
        let soma = 0;
        for (let i = 0; i < quantidade; i++) {
            soma += Number(d[i]) * (quantidade + 1 - i);
        }
        const resto = (soma * 10) % 11;
        return resto === 10 ? 0 : resto;
    };

    return digito(9) === Number(d[9]) && digito(10) === Number(d[10]);
}

const EMAIL_REGEX = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;

/** Devolve um erro por campo; objeto vazio significa que está tudo certo. */
export function validarCadastro(dados: DadosCadastro): ErrosCadastro {
    const erros: ErrosCadastro = {};

    if (dados.nome.trim().length < 2) {
        erros.nome = "Informe seu nome.";
    }
    if (!EMAIL_REGEX.test(dados.email.trim())) {
        erros.email = "Informe um e-mail válido.";
    }
    if (!validarCpf(dados.cpf)) {
        erros.cpf = "CPF inválido.";
    }
    if (dados.senha.length < SENHA_MINIMA) {
        erros.senha = `A senha precisa ter pelo menos ${SENHA_MINIMA} caracteres.`;
    }
    if (dados.confirmacao !== dados.senha || dados.confirmacao === "") {
        erros.confirmacao = "As senhas não conferem.";
    }

    return erros;
}

// ---------- Login ----------

export type DadosLogin = {
    email: string;
    senha: string;
};

export type ErrosLogin = Partial<Record<keyof DadosLogin, string>>;

/** No login só conferimos o formato do e-mail e se a senha foi preenchida (sem tamanho mínimo). */
export function validarLogin(dados: DadosLogin): ErrosLogin {
    const erros: ErrosLogin = {};

    if (!EMAIL_REGEX.test(dados.email.trim())) {
        erros.email = "Informe um e-mail válido.";
    }
    if (dados.senha === "") {
        erros.senha = "Informe sua senha.";
    }

    return erros;
}

/**
 * Ponto único de envio do login.
 * Por enquanto só simula sucesso depois de ~500 ms.
 * A chamada ao servidor (POST /api/login) entra aqui depois, sem precisar
 * mexer no modal. Nunca registrar a senha em log.
 */
export async function enviarLogin(dados: DadosLogin): Promise<void> {
    void dados; // ainda sem servidor: os dados serão o corpo da requisição
    await new Promise((resolve) => setTimeout(resolve, 500));
}

// ---------- Envio do cadastro ----------

/**
 * Ponto único de envio do cadastro.
 * Por enquanto só simula sucesso depois de ~500 ms.
 * A chamada ao servidor entra aqui depois (ex.: fetch POST com os dados no corpo),
 * sem precisar mexer no modal. Nunca registrar a senha em log.
 */
export async function enviarCadastro(dados: DadosCadastro): Promise<void> {
    void dados; // ainda sem servidor: os dados serão o corpo da requisição
    await new Promise((resolve) => setTimeout(resolve, 500));
}
