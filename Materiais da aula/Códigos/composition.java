/*
    ATENÇÃO: ESTE NÃO É UM CÓDIGO FUNCIONAL
    Coloquei a extensão .java apenas para ativar o syntax highlighting da IDE!
    Também, nem todos os métodos estão implementados. O objetivo é conseguir visualizar 
    a estrutura geral do programa.

    AUTOR: André Felipe Wonsik Alves em 29/08/2026.
*/ 

// Representa uma imagem na memória
class Imagem {
    private int pixels;
    private int largura;
    private int altura;

    public void redimiensionar(){
        // redimensionando...
    }
    
    public void inverterVertical(){
        // invertendo...
    }
}

// Representa um tipo de imagem específico
class PngImagem {
    private string caminho;

    public PngImagem(string caminho){
        // construtor...
    }

    public void salvar(Imagem src){
        PngEncoder encoder = new PngEnconder();

        // salvando
        encoder.encode(src);
    }

    public carregar(Imagem src){
        PngDecoder decoder = new PngDecoder();

        // carregando
        decoder.decode(src);
    }
}

class DesenhoImagem {
    private Imagem imagem;
    private Pincel pincel;

    public DesenhoImagem(Imagem imagem){
        // construtor...
    }

    public void drawLine(int inicioX, int inicioY, int finalX, int finalY){
        // ...
    } 

    public void drawPoint(int x, int y){
        // ...
    }
}


public main()

{
    Imagem imagem = new Imagem();

    PngImagem png = new PngImagem("imagem.png");
    png.carregar();

    DesenhoImagem desenho = new DesenhoImagem(imagem);
    desenho.desenharLinha(10,10,20,20);
    desenho.desenharPonto(10,20);

    png.salvar(imagem)
}