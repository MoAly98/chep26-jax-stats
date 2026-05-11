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

#show heading.where(level: 2): set align(center)

// poster content, function from `template.typ`
#poster[
  #section[
    #align(left)[#heading("Statistical Analysis in HEP", level: 1)]
    #v(0.5em)
    #align(center)[
      #image("assets/infographs/hepstats.pdf", width: 60%)   // was 92%
    ]
  ]

  #section[
    #align(left)[#heading("Why JAX?", level: 1)]
    #v(0.5em)

    #align(center)[
      #grid(
        columns: (35%, 62.5%),
        gutter: 1em,
        align: horizon,
        align(center)[#image("assets/infographs/ecosys.pdf", width: 100%)], align(center)[#image("assets/infographs/transforms_color.pdf", width: 100%)],
      )
    ]
  ]

  #section[
    #heading("Quickstart: unbinned fit", level: 1)
    #v(0.5em)

    #block(
      //fill: princeton-orange.transparentize(95%),
      //stroke: princeton-orange.transparentize(60%) + 0.8pt,
      //radius: 6pt,
      //inset: 1.2em,
      //width: 100%,
      grid(
        columns: (32%, 30%, 33%),
        column-gutter: 1em,
        [
          == #box(image("assets/logos/evermore.png", height: 1.5em), baseline: 20%)
          #v(0.25em)

          #codly(
            display-name: false,
            zebra-fill: princeton-zebra-fill,
            // highlights: (
            //   (line: 6, start: 3, end: 4, fill: princeton-orange),
            //   (line: 7, start: 3, end: 6, fill: princeton-orange),
            // ),
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
        ],
        [
          == #box(image("assets/logos/paramore.png", height: 1.5em), baseline: 20%)
          #v(0.25em)

          #text(size: 31pt)[
            #codly(
              display-name: false,
              zebra-fill: princeton-zebra-fill,
            )
            ```python
            import paramore as pm

            lower, upper = 100.0, 180.0

            sig = pm.Gaussian(
                mu=125.0, sigma=2.0,
                lower=lower, upper=upper
            )
            bkg = pm.Exponential(
                lambd=0.05,
                lower=lower, upper=upper
            )

            model = pm.SumPDF(
                pdfs=[sig, bkg],
                extended_vals=[500.0, 5000.0],
                lower=lower, upper=upper,
            )
            ```
          ]
        ],
        [
          == #box(image("assets/logos/everwillow.svg", height: 1.5em), baseline: 20%)
          #v(0.25em)

          #text(size: 31pt)[
            #codly(
              display-name: false,
              zebra-fill: princeton-zebra-fill,
            )
            ```python
            from jax.random import normal, key
            import everwillow as ew
            import everwillow.statelib as sl

            # observed unbinned masses
            data = normal(key(0), (10_000,)) * 2 + 125

            # extended NLL from params + model
            nll = lambda p, d:
                pm.create_extended_nll(p, model, d)
            state = sl.State.from_pytree(params)
            obs = {"data": data}

            # fit & parameter uncertainties
            result = ew.fit(nll, state, obs)
            unc = ew.uncertainties(
                nll, result.params, obs
            )
            ```
          ]
        ],
      ),
    )
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
