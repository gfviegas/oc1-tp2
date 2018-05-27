# oc1-tp2
2º Trabalho Prático de OC1 - UFV CAF

# Como rodar
- Compilar -> `iverilog -o output.out main.v`
- Para executar o output -> `vvp output.out`

## GTKWAVE
- Compilar -> `iverilog -o output.test.out main.test.v main.v`
- Executar `vvp output.test.out -lxt2`
- Abrir gtkwave `gtkwave output.vcd &`
