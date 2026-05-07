#import "template.typ": poster, princeton-orange, princeton-zebra-fill, section

#import "@preview/cetz:0.4.0": canvas, draw
#import "@preview/cetz-plot:0.1.2": plot
#import "@preview/gentle-clues:1.2.0": *

#import "@preview/codly:1.3.0": *
#import "@preview/codly-languages:0.1.1": *
#show: codly-init.with()


// poster configuration
#set page(
  paper: "a0",
  margin: 1in,
  columns: 1,
)

// global styling & colors
#set text(size: 36pt)
#show link: set text(fill: blue)
#show link: underline


// poster content, function from `template.typ`
#poster[
  #section[
    // section title
    #heading("Primitives, Model Building, and Inference", level: 1)
    #v(0.5em)

    // content
    #lorem(100)
  ]

  #section[
    // section title
    #heading("Why JAX?", level: 1)
    #v(0.5em)

    // content
    #columns(2)[

      == Transforms
      #v(0.25em)
      - jax.jit: compile your code for lightning-fast performance
      - jax.grad: automatic differentiation for easy gradient-based optimization
      - jax.vmap: vectorize your code for efficient batch processing
      #image("transforms.pdf", width: 92%)

      #colbreak()

      == JAX Ecosystem
      #v(0.25em)
      - optimistix: JAX transform-compatible optimization algorithms
      - orbax: Checkpointing and model management for JAX
      - TensorBoard, mlflow, wandb, etc.: Seamless logging and visualization with JAX
    ]
  ]

  #section[
    // section title
    #heading("Quickstart: Code Example", level: 1)
    #v(0.5em)

    // content
    #columns(3)[

      == Evermore (Binned)
      #v(0.25em)

      #codly(
        languages: codly-languages,
        zebra-fill: princeton-zebra-fill,
        highlights: (
          (line: 6, start: 3, end: 4, fill: princeton-orange),
          (line: 7, start: 3, end: 6, fill: princeton-orange),
        ),
      )
      ```python
      import typing as tp
      import evermore as evm

      # PyTree of evm.Parameters
      class Params(tp.NamedTuple):
        mu: evm.Parameter
        syst: evm.NormalParameter

      params = Params(
        mu=evm.Parameter(1.0),
        syst=evm.NormalParameter(0.0),
      )
      ```

      #colbreak()

      == #box(image("paramore.png", height: 1.5em), baseline: 30%) Paramore (Unbinned)
      #v(0.25em)

      #text(size: 31pt)[
        #codly(
          languages: codly-languages,
          zebra-fill: princeton-zebra-fill,
        )
        ```python
        import paramore as pm

        lower, upper = 100.0, 180.0

        signal = pm.Gaussian(mu=125.0, sigma=2.0, lower=lower, upper=upper)
        background = pm.Exponential(lambd=0.05, lower=lower, upper=upper)

        model = pm.SumPDF(
            pdfs=[signal, background],
            extended_vals=[500.0, 5000.0],
            lower=lower,
            upper=upper
        )
        ```
      ]

      #colbreak()

      == Everwillow (Inference)
      #v(0.25em)
      #lorem(66)
    ]
  ]

  #section[
    // section title
    #heading("Interopability and Likelihood Combination", level: 1)
    #v(0.5em)

    // content
    #columns(3)[

      == Models (pyhf, evermore, ...)
      #v(0.25em)
      #lorem(50)

      #colbreak()

      == Combined Likelihood (statelib)
      #v(0.25em)
      #lorem(50)

      #colbreak()

      == Everwillow (Inference)
      #v(0.25em)
      #lorem(50)
    ]
  ]

  #clue(
    accent-color: princeton-orange,
    title: "Links and Resources",
    icon: emoji.clip,
  )[
    Checkout out the projects on #link("GitHub")[GitHub]:

    - #link("https://github.com/pfackeldey/evermore")[evermore]
    - #link("https://github.com/maxgalli/paramore")[paramore]
    - #link("https://github.com/MoAly98/everwillow")[everwillow]
  ]

]
