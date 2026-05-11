// some predefined colors & block kwargs for styling consistency
#let princeton-zebra-fill = rgb("#a0a0a01a")
#let princeton-orange = rgb("#E77500")
#let princeton-stroke = (paint: black, thickness: 4pt, cap: "round")

#let poster(body) = {
  grid(
    columns: 1,
    rows: (10%, 1%, 87%, 1%, 1%),

    // Top = title row
    [
      #box(
        stroke: none,
        fill: white,
        height: 100%,
        width: 100%,
        inset: 1%,

        grid(
          columns: (10%, 78%, 10%),
          rows: 100%,
          stroke: none,

          // Left
          [
            #place(horizon + left, figure(image("assets/logos/princeton-logo.svg", width: auto, height: 200pt)))
          ],
          // Center
          [
            #place(horizon + center)[
              #text(size: 65pt, fill: black)[
                *A JAX Ecosystem for Likelihood-Based Inference in HEP*
                #v(15%, weak: true)
              ]
              #text(size: 42pt)[
                *Mohamed Aly#super[1]*,
                Peter Fackeldey#super[1],
                Massimiliano Galli#super[1]
                \
                Princeton University#super[1]
              ]
            ]
          ],
          [
            #place(horizon + right, figure(image(
              "assets/logos/Iris-hep-5-just-graphic.svg",
              width: auto,
              height: 200pt,
            )))
          ],
        ),
      )
    ],

    // Second row = horizontal line
    [
      #box(
        stroke: none,
        fill: white,
        height: 100%,
        width: 100%,
        inset: 1%,

        line(length: 100%, stroke: princeton-stroke),
      )
    ],

    // Middle = body
    [
      #box(
        height: 100%,
        inset: 1%,
        fill: white,

        body,
      )
    ],

    // Fourth row = horizontal line
    [
      #box(
        stroke: none,
        fill: white,
        height: 100%,
        width: 100%,
        inset: 1%,

        line(length: 100%, stroke: princeton-stroke),
      )
    ],

    // Bottom = footer
    [
      #box(
        stroke: none,
        fill: white,
        height: 100%,
        width: 100%,
        inset: 1%,

        grid(
          columns: (60%, 40%),
          rows: 100%,
          stroke: none,

          // Left
          [
            #place(horizon + left)[
              #text(size: 28pt)[
                *Acknowledgements:* This work was supported by the National Science Foundation under Cooperative Agreement PHY-2323298 and grant OAC-2103945
              ]
            ]
          ],
          // Right
          [
            #place(horizon + right)[
              #text(size: 28pt)[
                *Contact:*\ #link("mohamed.aly@cern.ch")[mohamed.aly\@cern.ch]
              ]
            ]
          ],
        ),
      )
    ],
  )
}


#let section(content) = {
  block(
    // block settings
    fill: none,
    inset: (y: 30pt),
    width: 100%,
    // enable the following two for a more "boxed" look
    // radius: 8pt,
    // stroke: princeton-stroke,

    content,
  )
}
