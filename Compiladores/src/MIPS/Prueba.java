package MIPS;
import java.io.FileNotFoundException;
import java.io.FileReader;

/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

/**
 *
 * @author Javier Argente Micó
 */
public class Prueba {

    public static void main(String[] argv) {
        java_cup.runtime.Symbol s;
        try {
            LexicalAnalyzerMIPS lexicalAnalyzer = new LexicalAnalyzerMIPS(new FileReader(argv[0]));
            do {
                s = lexicalAnalyzer.next_token();
                System.out.println("Símbolo de tipo " + s.sym + ": " + s.value);
            } while (s.sym != sym.EOF);
        } catch (FileNotFoundException ex) {
            System.out.println("El archivo " + argv[0] + " no existe");
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

}
