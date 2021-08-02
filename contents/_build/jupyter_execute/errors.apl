vec ← ⍳10
50⊃vec      ⍝ INDEX ERROR

]dinput
pick50 ← {
    3::'out of range' ⍝ Error guard, catching INDEX ERROR
    50⊃⍵
}

pick50 ⍳10

]dinput
f ← {
    nums←1 ⍺
    0=⍵:nums
    nums×÷⍵
}

4 f 0
4 f 2

]dinput
fbug ← { ⍝ Can you spot the bug?
    11::nums
    nums←1 ⍺
    nums×÷⍵
}

4 fbug 0

]dinput
fnew ← { ⍝ Now correct
    nums←1 ⍺
    11::nums
    nums×÷⍵
}

4 fnew 0

]dinput
g ← { 
    3::'out of range' ⍝ Error guard, catching INDEX ERROR
    h ⍺⊃⍵ ⍝ No longer a tail call, due to precense of error guard
}

]dinput
g ← { 
    val ← ⍺ {3::'out of range' ⋄ ⍺⊃⍵} ⍵
    h val ⍝ Tail call
}

⎕EM⍳10 ⍝ ...and the rest

]dinput
g ← { 
    3::'handle index error'
    4::'handle rank error'
    11::'handle domain error'
    ⍝ error-prone function body here
}

]dinput
g ← { 
    3 4 11::'it all went pear-shaped in some way'
    ⍝ error-prone function body here
}

assert ← {⍺←'assertion failure' ⋄ 0∊⍵:⍺ ⎕SIGNAL 8 ⋄ shy←0}

assert 0=1

⎕SIGNAL 1

⎕SIGNAL 8


