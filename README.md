
<!-- README.md is generated from README.Rmd. Please edit that file -->

# \[PT-BR\] Cálculos de conectividade usando Omniscape.jl

<!-- badges: start -->
<!-- badges: end -->

## Métodos

1.  Instalar Julia no computador local
2.  Declarar no terminal quantos núcleos serão usados quando usar julia

``` bash
export JULIA_NUM_THREADS=12
```

3.  Instalar Omniscape desde Julia

``` julia
using Pkg; Pkg.add("Omniscape")
```

4.  Adicionar a camada de resistência na pasta onde será rodado
    Omniscape (no exemplo aqui `test_area.tif`)
5.  Criar um arquivo .INI com os parâmetros para rodar. Aqui: Um exemplo
    (`test.INI`) com parâmetros default. Ver a documentação!

``` bash
[Required]
resistance_file = test_area.tif
radius = 100
block_size = 5
project_name = output/example

[General options]
source_from_resistance = true
r_cutoff = 50
calc_normalized_current = true

parallelize = true
parallel_batch_size = 12

[Output options]
write_raw_currmap = true
```

6.  Rodar Omniscape desde Julia

``` julia
using Omniscape
run_omniscape("test.INI")
```

## Referências

- Repo de Omniscape: <https://github.com/Circuitscape/Omniscape.jl>

- Citação de Omniscape:

> Landau, V.A., V.B. Shah, R. Anantharaman, and K.R. Hall. 2021.
> Omniscape.jl: Software to compute omnidirectional landscape
> connectivity. Journal of Open Source Software, 6(57), 2829.
>
> McRae, B. H., K. Popper, A. Jones, M. Schindel, S. Buttrick, K. R.
> Hall, R. S. Unnasch, and J. Platt. 2016. Conserving Nature’s Stage:
> Mapping Omnidirectional Connectivity for Resilient Terrestrial
> Landscapes in the Pacific Northwest. The Nature Conservancy, Portland,
> Oregon.
