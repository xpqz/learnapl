]dinput
Append←{⎕IO←0
    ⍝ Given a vector of keys and a vector of vals append vals
    ⍺∘{
        k←0⌷⍵ ⋄ v←1⌷⍵
        i←⍺.Keys⍳k
        i=≢⍺.Keys:1⊣⍺.Keys,←k⊣⍺.Vals,←v  ⍝ New key
        ⍺.Vals[i],←v                     ⍝ Append to existing
        0
    }¨↓⍉↑⍵
}

]dinput
Create←{
    keys←(1500⌶),⍺
    vals←,⍵
    {⍵⊣⍵.(Vals Keys Default)←vals keys ⍬}⎕NS''
}

]dinput
Get←{
    ~⍵ In ⍺:⍺.Default
    ⍺.Vals[⍺.Keys⍳⍵]
}

In←{⍺∊⍵.Keys}

]dinput
Set←{⎕IO←0
    ⍝ Upsert ht ⍺ given a vector of keys and a vector of vals
    ⍺∘{
        k←0⌷⍵ ⋄ v←1⌷⍵
        i←⍺.Keys⍳k
        i=≢⍺.Keys:1⊣⍺.Keys,←k⊣⍺.Vals,←v ⍝ New key
        ⍺.Vals[i]←v                     ⍝ Replace existing
        0
    }¨↓⍉↑⍵
}


