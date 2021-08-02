⎕IO ← 0
]box on -s=min -t=tree -f=on
]rows on

]UNew -??

]UNew Quote

]dinput
:Namespace MyCmd
⍝ Custom user command

    ⎕IO←1 ⋄ ⎕ML←1

    ∇ r←List
      r←⎕NS¨1⍴⊂⍬
    ⍝ Name, group, short description and parsing rules
      r.Name←⊂'Quote'
      r.Group←⊂'MyCmds'
      r[1].Desc←'Help text to appear for ] -?? and ]MYCMDS -?'
      r.Parse←⊂'' ⍝ ENTER NUMBER OF ARGS AND OPTIONALLY -modifiers HERE
    ∇

    ∇ r←Run(cmd input)
      :Select cmd
      :Case 'Quote'
          r←'command Quote in construction' ⍝ ENTER COMMAND CODE HERE
      :EndSelect
    ∇

    ∇ r←level Help cmd
      :Select cmd
      :Case 'Quote'
          r←'Help text to appear for ]MYCMDS.Quote -?'
      :EndSelect
    ∇

:EndNamespace

]UReset

]Quote

∇ r←Run(cmd input);hc
  hc←⎕SE.SALT.Load'HttpCommand'
  :Select cmd
  :Case 'Quote'
      r←(_←hc.GetJSON 'GET' 'https://api.kanye.rest/').Data.quote
  :EndSelect
∇

]UReset

]Quote


