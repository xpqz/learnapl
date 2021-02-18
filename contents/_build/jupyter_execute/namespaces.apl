obj ← ⎕NS⍬

obj.(name cost id)  ← 'widget' 55.0 'widg443'

obj.(name cost id)

obj.sum←+/

obj.sum 1 2 3 4 5

]dinput
:Namespace myns
    f ← {
        ⍺+⍵
    }

    g ← {
        ⍝ g fun
        ⍺⍵
    }

    h ← {
        s ← '\d+'⎕R'D'⊢⍵
        ⍺ g s
    }
:EndNamespace

'nodigits' myns.h 'abd556jashgd8879'

⊢names ← obj.⎕NL 2

⍴names

obj.⎕NL ¯2

obj⍎'cost'
obj.(⍎¨⎕NL ¯2)

_set←{⍎'⍺⍺.',⍺,'←⍵'⊣⍺⍺}
keyz←{⍵.⎕NL ¯2}
vals←{⍵.(⍎¨⎕NL ¯2)}

'hello' (obj _set) 'world'

obj⍎'hello'
keyz obj
vals obj

ns ← ⎕NS⍬
ns.key ← 45
ns {⍺.key ← 99 ⋄ ⍵} 'hello' ⍝ Mutation through ⍺...
ns.key


