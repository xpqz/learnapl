⎕IO ← 0
{}⎕SE.UCMD'box on -s=min -t=tree -f=on'
{}⎕SE.UCMD'rows on'

⊃⎕NGET'/Users/stefan/work/dyalog/file.txt'1

⎕NGET'/Users/stefan/work/dyalog/file.txt'1

⎕NGET'/Users/stefan/work/dyalog/file.txt'

⍴⊃⎕NGET'/Users/stefan/work/dyalog/file.txt'

⍎⍤1⊢↑⊃⎕NGET'/Users/stefan/work/dyalog/file.txt'1 ⍝ Note health warning below!

⍎ '1 8 6 7 5 9 5 9'

data←'3-6 s: ssdsssss' '17-19 f: cnffsfffzhfnsffttms' '8-11 c: tzvtwncnwvwttp' '8-10 r: rwrrtrvttrrrr' '1-2 p: zhpjph' '4-6 l: pldnxv'

⎕CSV('\W+'⎕R','⊢data)''4

json ← '{"key": 1, "list": [1, 2, 3, {"colour": "red", "shape": "oblong", "number": 5}, [98, 43, 77]]}'

⊢data ← ⎕JSON json

data.key
data.list
data.list[3].shape

data.⎕NL¯2

data.(⍎¨⎕NL¯2)

]dinput
Values←{
    keys ← ⍵.⎕NL¯2
    values ← keys {0=≢⍺:⍬⋄⍵.(⍎¨⍺)} ⍵ 
    0=≢⍵.⎕NL¯9:values       ⍝ No nested namespaces: done
    values,∊∇¨⍵.(⍎¨⎕NL¯9)   ⍝ Also expand any namespaces we found as values
}

]dinput
JSONSum ← {
    {(1=2|⎕DR)⍵}⍵:⍵                    ⍝ Are we a number?
    (⍕≡⊢)⍵:0                           ⍝ Are we a string?
    {(326=⎕DR⍵)∧(0=≡)⍵} ⍵:+/∇Values ⍵  ⍝ Are we an object?
    +/∊∇¨⍵                             ⍝ We're a list
}

JSONSum data


