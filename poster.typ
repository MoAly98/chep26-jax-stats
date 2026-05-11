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
    #align(center)[#image("assets/infographs/hepstats_2.pdf", width: 100%)]
  ]
  #v(-1.5em)
  #section[
    // #grid(
    //   columns: (auto, 1fr),
    //   column-gutter: 1.5em,
    //   align: horizon,
    //   heading(level: 1)[
    //     The case for #box(image("assets/logos/jax-logo.webp", height: 1em))
    //   ],
    //   align(right)[#image("assets/infographs/whyjax_2.pdf", width: 84%)],
    // )
    #align(center)[#heading[The case for #box(image("assets/logos/jax-logo.webp", height: 1em))]]
    #v(1.5em)
    #align(center)[#image("assets/infographs/whyjax_2.pdf", width: 96%)]
  ]
  #v(-1.5em)
  #section[
    #align(center)[#heading("A JAX ecosystem for HEP statistics", level: 1)]
    #v(1.5em)
    #let logo-height = 60pt
    #let logo-height-ew = 80pt
    #let code-size = 22pt
    #let label-size = 32pt
    #let cell-width = 92%

    #let code-col = 900pt          // tune to your slide width

    #grid(
      columns: (200pt, code-col, code-col),
      column-gutter: 0.5em,
      align: (left + horizon, top, top),

      // ─── ROW 1: Primitives ────────────────────────────────

      text(size: label-size, weight: "bold")[Primitives],

      [
        #align(center)[#block(width: cell-width)[
          #place(
            top + right,
            dx: -0.4em,
            dy: 0.3em,
            image("assets/logos/evermore.png", height: logo-height),
          )
          #text(size: code-size)[
            #codly(display-name: false, zebra-fill: princeton-zebra-fill)
            ```python
            import jax.numpy as jnp
            import evermore as evm
            hist = jnp.array([...])
            syst = evm.NormalParameter(name="syst")
            # lnN +/- 10% on the yield
            modifier = syst.scale_log_asymmetric(
                up=jnp.array([1.1]),
                down=jnp.array([0.9]),
            )
            modified_hist = modifier(hist)
            ```
          ]
          #v(-0.3em)
          #align(right)[#text(size: 26pt, fill: rgb("#64748B"), style: "italic")[(parameters + constraints)]]
        ]]
      ],
      [
        #align(center)[#block(width: cell-width)[
          #place(
            top + right,
            dx: -0.4em,
            dy: 0.3em,
            image("assets/logos/paramore.png", height: logo-height),
          )
          #text(size: code-size)[
            #codly(display-name: false, zebra-fill: princeton-zebra-fill)
            ```python
            import paramore as pm
            lower, upper = 100.0, 180.0
            sig = pm.Gaussian(mu=125.0, sigma=2.0,
                            lower=lower, upper=upper)
            bkg = pm.Exponential(lambd=0.05,
                                lower=lower, upper=upper)
            model = pm.SumPDF(
                pdfs=[sig, bkg],
                extended_vals=[500.0, 5000.0],
                lower=lower, upper=upper,
            )
            ```
          ]
          #v(-0.3em)
          #align(right)[#text(size: 26pt, fill: rgb("#64748B"), style: "italic")[(distributions)]]
        ]]
      ],
    )
    #v(0.4em)

    // ─── ROW 2: Unbinned fit example ──────────────────────
    #grid(
      columns: (200pt, code-col, code-col),
      column-gutter: 0.5em,
      align: (left + horizon, top, top),

      text(size: label-size, weight: "bold")[Quickstart],

      [
        #align(center)[#block(width: cell-width)[
          #place(
            top + right,
            dx: -0.4em,
            dy: 0.3em,
            image("assets/logos/paramore.png", height: logo-height),
          )
          #text(size: code-size)[
            #codly(display-name: false, zebra-fill: princeton-zebra-fill)
            ```python
            import paramore as pm
            import evermore as evm
            # parameters (a PyTree)
            params = {
                "sig_n": evm.Parameter(500.0),
                "bkg_n": evm.Parameter(5000.0),
                "mu":    evm.Parameter(125.0),
            }
            # extended NLL from params + model
            def nll(p, data):
                return pm.create_extended_nll(p, model, data)
            ```
          ]
          #v(-0.3em)
          #align(right)[#text(size: 26pt, fill: rgb("#64748B"), style: "italic")[(unbinned)]]
        ]]
      ],
      [
        #align(center)[#block(width: cell-width)[
          #place(
            top + right,
            dx: -0.4em,
            dy: 0.3em,
            image("assets/logos/everwillow.svg", height: logo-height-ew),
          )
          #text(size: code-size)[
            #codly(display-name: false, zebra-fill: princeton-zebra-fill)
            ```python
            from jax.random import normal, key
            import everwillow as ew
            import everwillow.statelib as sl
            # observed unbinned masses
            data = normal(key(0), (10_000,)) * 2 + 125
            # fit & parameter uncertainties
            state  = sl.State.from_pytree(params)
            obs    = {"data": data}
            result = ew.fit(nll, state, obs)
            unc    = ew.uncertainties(nll, result.params, obs)
            ```
          ]
          #v(-0.3em)
          #align(right)[#text(size: 26pt, fill: rgb("#64748B"), style: "italic")[(nll-agnostic)]]
        ]]
      ],
    )
  ]
  #v(-1.0em)
  #section[
    #align(center)[#heading("Interoperability and likelihood combination", level: 1)]
    #v(1.0em)
    #align(center)[#image("assets/infographs/interop_2.pdf", width: 62%)]
  ]

  // #clue(
  //   accent-color: princeton-orange,
  //   title: "Interested to learn more?",
  //   icon: emoji.clip,
  // )[
  //   Checkout out the projects on #link("GitHub")[GitHub]: #link("https://github.com/pfackeldey/evermore")[evermore], #link("https://github.com/maxgalli/paramore")[paramore], #link("https://github.com/MoAly98/everwillow")[everwillow]
  // ]

]
