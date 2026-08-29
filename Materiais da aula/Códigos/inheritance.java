/*
    ATENÇÃO: ESTE NÃO É UM CÓDIGO FUNCIONAL
    Coloquei a extensão .java apenas para ativar o syntax highlighting da IDE!
    Também, nem todos os métodos estão implementados. O objetivo é conseguir visualizar 
    a estrutura geral do programa.

    AUTOR: André Felipe Wonsik Alves em 29/08/2026.
*/ 


abstract class Imagem {
    private int pixels;
    private int largura;
    private int altura;

    public void redimiensionar(){
        // redimensionando...
    }
    
    public void inverterVertical(){
        // invertendo...
    }

    public abstract void salvar(); 
    public abstract void carregar(); 
}

class PngImagem : Imagem{
    private string caminho;

    public PngImagem(string caminho){
        // construtor...
    }

    public void salvar(){
        PngEncoder encoder = new PngEnconder();

        // salvando
        encoder.encode(this);
    }

    public carregar(){
        PngDecoder decoder = new PngDecoder();

        // carregando
        decoder.decode(this);
    }
}

class DesenhoImagem: Imagem {
    private Pincel pincel;

    public DesenhoImagem(){
        // construtor...
    }

    public void drawLine(int inicioX, int inicioY, int finalX, int finalY){
        // ...
    } 

    public void drawPoint(int x, int y){
        // ...
    }

    public void salvar(){
        Exception("Salvar não pode ser implementado nessa classe!");
    }

    public void carregar(){
        Exception("Carregar não pode ser implementado nessa classe!");
    }
}

public main()

{
    // como poderíamos usar esses métodos para carregar e exibir uma imagem a partir de um .png?
}



