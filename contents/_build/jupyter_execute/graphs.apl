⎕IO ← 0
{}⎕SE.UCMD'box on -s=min -t=tree -f=on'
{}⎕SE.UCMD'rows on'
'span' 'stpath'⎕CY'dfns'

:Namespace graph
    ⎕io←0
    ⍝ https://www.dcode.fr/maze-generator
    N←{(⍸⍺)∩(⊂⍵)(+,-)(0 1)(1 0)}

    _solve←{
        (n g)←{f({{f⍳⊂⍵}¨⍵}¨m∘N¨f←⍸m←~'#'=⍵)}⍺⍺
        n[(g ##.span ⍺) ##.stpath ⍵]
    }

    showpath←{
        '⎕'@⍺⊢⍵
    }

:EndNamespace

maze←↑⊃⎕NGET'/Users/stefan/work/dyalog/learnapl/maze-big.txt'1

p ← 0 (maze graph._solve) 5004

⍝p graph.showpath maze

moves←{{⌽@zero ⍵⊢state}¨(,⍳⍴state)∩(0 1)(1 0)(0 ¯1)(¯1 0)+⊂zero←⊃⍸0=state←⍵}

⊢state←4 4⍴?⍨16 ⍝ A random puzzle state. Note: not all states have solutions!
moves state

⌽@4 6⊢⎕←⍳8   ⍝ Swap positions 4 and 6
