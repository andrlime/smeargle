(Flag A4 false)
(Flag GRAD2027 true)
(Flag POSTOFFER2026 true)
(Flag SHOW_OLD_JOB true)

(Output (Typst (If (Flag A4)
        (OPath "./resume_a4.pdf")
        (OPath "./resume_us.pdf"))))

(Config (
    (profile (
        (name (String "John Doe"))
        (website (String "www.example.com"))
        (github (String "abcdef"))
        (phone (String "+1 (202) 555-1234"))
        (email (String "person*@*example.com"))
    ))
    (template (If (Flag A4)
        (IPath "./template-a4.typ")
        (IPath "./template-us-letter.typ")))
    (margin (
        (left (If (Flag A4) (Integer 30) (Integer 30)))
        (right (If (Flag A4) (Integer 30) (Integer 30)))
        (top (If (Flag A4) (Integer 20) (Integer 20)))
        (bottom (If (Flag A4) (Integer 20) (Integer 10)))
    ))
    (justify true)
    (pagesize (If (Flag A4)
        (String "a4")
        (String "us-letter")))
    (font (String "DINOT"))
))


(Section "Education")
(School (
    (name (String "Ohio State University"))
    (start (String "September 2022"))
    (until (String "September 2022 – February 2027"))
    (degrees (
        (Degree
            (title (String "BS"))
            (major (String "*Computer Science*")))
    ))
    (where (String "Columbus, OH"))
    (gpa (String "CS GPA 3.30/4.00"))
))
(List "Courses" (
    (String "Distributed Systems")
    (String "Computer Architecture")
    (String "OS")
    (String "Functional Programming")
    (String "Data Structures and Algorithms")
))

(Section "Experience")
(When (Flag POSTOFFER2026) (Job (
    (company (String "Next Year's Job"))
    (title (String "Incoming Software Engineer"))
    (start (String "August 2025"))
    (until (String "Present"))
    (where (String "Somewhere"))
)))
(Job (
    (company (String "Random Company"))
    (title (String "Software Engineer Intern"))
    (start (String "June 2025"))
    (until (String "August 2025"))
    (where (String "Random Place"))
    (bullets (
        (String "Probably did nothing")
        (String "Probably did nothing also")
    ))
))
(Job (
    (company (String "Random Company 2"))
    (title (String "Software Engineer Intern"))
    (start (String "June 2024"))
    (until (String "August 2024"))
    (where (String "Random Place"))
    (bullets (
        (String "Probably did nothing")
        (String "Probably did nothing also")
    ))
))
(When (Flag SHOW_OLD_JOB) (Job (
    (company (String "Old Job"))
    (title (String "Software Engineer Intern"))
    (start (String "June 2023"))
    (until (String "August 2023"))
    (where (String "Somewhere Else"))
    (bullets (
        (String "Probably did nothing also, but maybe used agile")
    ))
)))

(Section "Projects")
(Project (
    (title (String "React Todo List"))
    (start (String "June 2023"))
    (until (String "June 2023"))
    (bullets (
        (String "Built a todo list using React function components, but I actually just copied it from GitHub")
    ))
))

(Section "Awards and Honours")
(Award (
    (title (String "Most Drunk Fraternity Member"))
    (organisation (String "Ohio State University"))
))

(Section "Skills")
(List "Languages" (
    (String "English")
    (String "Python")
    (String "Java")
))
(List "Interests" (
    (String "Drinking Alcohol")
))
