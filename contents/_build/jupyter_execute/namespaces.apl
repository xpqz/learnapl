obj ← ⎕NS⍬

obj.(name cost id)  ← 'widget' 55.0 'widg443'

obj.(name cost id)

obj.sum←+/

obj.sum 1 2 3 4 5

]map obj

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

⎕ ← names ← obj.⎕NL 2

⍴names

obj.⎕NL ¯2

obj⍎'cost'
obj.(⍎¨⎕NL ¯2)

_set←{⍎'⍺⍺.',⍺,'←⍵'⊣⍺⍺}
keys←{⍵.⎕NL ¯2}
vals←{⍵.(⍎¨⎕NL ¯2)}

'hello' (obj _set) 'world'

obj⍎'hello'
keys obj
vals obj

ns ← ⎕NS⍬
ns.key ← 45
ns {⍺.key ← 99 ⋄ ⍵} 'hello' ⍝ Mutation through ⍺...
ns.key

⎕IO←0
nsarray←⎕NS¨6⍴⊂⍬
nsarray.name←'adam' 'bob' 'charlotte' 'dave' 'erica' 'fred'
nsarray.pid←3 7 87 32 32 9
nsarray.items←(1 2 3)(2 3)(9 32 23)(9 8 7 6 5 4)(8 7)(,1)

nsarray[2].name

nsarray.name

nsarray.(≢items)

nsarray.(name pid)

From←{⍵⍎¨⊂⍺}
Has←{×⍺.⎕NC⊂⊂⍵}
In←{⍺∘(∨/⍷)¨⍵}
Where←/⍨

'pid' From nsarray Where 'dave' In nsarray.name

nsarray[2 5].title←'manager' 'pointy-haired boss'

'name' From nsarray Where nsarray Has 'title'

'a'⎕NS⍬
a

'top.middle.bottom'⎕NS⍬

]map top


