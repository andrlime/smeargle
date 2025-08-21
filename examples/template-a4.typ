#let big_header(body, primary_color) = {
    show heading.where(
        level: 1
    ): it => text(
        fill: primary_color,
        size: 24pt,
        [
            #upper({it.body})
            #v(-12pt)
        ]
    )
    heading(level: 1, body)
}

#let section_header(body, primary_color) = {
    show heading.where(
        level: 2
    ): it => text(
        fill: primary_color,
        size: 13pt,
        [
            #{it.body}
            #v(-9pt)
            #line(length: 100%, stroke: 0.25pt + primary_color)
        ]
    )
    upper(strong(heading(level: 2, body)))
}

#let section(header) = {
    section_header(header, rgb("#3478aa"))
}

#let icon(name, label, shift: 1.5pt) = {
  /*box(
    baseline: shift,
    height: 9.5pt,
    image("./icons/" + name + ".svg")
  )
  h(3pt)*/
  label
}

#let tabulate(list, separator) = {
    for elem in list {
        if elem == list.last() {
            elem
        } else {
            elem + separator + " "
        }
    }
}

#let profile(
    name,
    website,
    github,
    phone,
    email1
) = {
    set align(center)
    big_header(name, rgb("#3478aa"))
    v(-6pt)
    text(9.5pt)[
        #tabulate((
            icon("phone", phone),
            icon("email", email1),
            link("https://github.com/" + github)[
                #icon("github", "www.github.com/" + github)
            ],
            link("https://" + website)[
                #icon("github", website)
            ],
        ), h(1.5em))
    ]
    v(-10pt)
}

#let school(
    name,
    year,
    degree,
    location,
    gpa
) = {
    text(9.5pt)[
        #strong(name)
        #h(1fr)
        #emph(location)
        #h(0.4em)
        #text(year)
    ]
    linebreak()
    text(9.5pt)[
        #degree #h(1fr) #gpa
    ]
    linebreak()
}

#let tags(
    label,
    list
) = {
    text(9.5pt, hyphenate: false)[
        #strong(label): 
        #tabulate(list, ",")
    ]
    v(-5pt)
}

#let position(
    company, position, time_period, location, bullets
) = {
    text(9.5pt)[
        #strong(position)
        #h(0.4em)
        #text(company)
        #h(1fr)
        #emph(location)
        #h(0.4em)
        #text(time_period)
    ]
    linebreak()
    text(9.5pt)[
        #list(
            tight: true,
            ..bullets
        )
    ]
    v(-2pt)
}

#let futureposition(
    company, position, time_period, location
) = {
    text(9.5pt)[
        #strong(position)
        #h(0.4em)
        #text(company)
        #h(1fr)
        #emph(location)
        #h(0.4em)
        #text(time_period)
    ]
    v(-2pt)
}

#let job(
    company, positions
) = {
    for p in positions {
        position(company, p.at(0), p.at(1), p.at(2), p.at(3))
    }
}

#let futurejob(
    company, positions
) = {
    for p in positions {
        futureposition(company, p.at(0), p.at(1), p.at(2))
    }
}

#let project(
    title, client, date, bullets
) = {
    text(9.5pt)[
        #strong(title)#if client != "" [#h(0.4em)]
        #text(client) #h(1fr) #text(date)
    ]
    linebreak()
    text(9.5pt)[
        #list(
            tight: true,
            ..bullets
        )
    ]
    v(-2pt)
}

#let award(
    title, who
) = {
    text(9.5pt)[
        #strong(title) #h(1fr) #text(who)
    ]
    v(-2pt)
}
