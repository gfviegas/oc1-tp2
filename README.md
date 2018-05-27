# oc1-tp2
2º Trabalho Prático de OC1 - UFV CAF

# Como rodar
- Compilar -> `iverilog -o output.vvp main.v`
- Para executar o output -> `vvp output.vvp`

## GTKWAVE
- Compilar -> `iverilog -o output.test.vvp main.test.v main.v`
- Executar `vvp output.test.vvp -lxt2`
- Abrir gtkwave `gtkwave output.vcd &`
