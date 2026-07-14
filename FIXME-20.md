# FIXME

Better solutions for https://xpqz.github.io/learnapl/next.html#signals-and-noise

```apl
      {⍵[⊃⍒+⌿⍵∘.=⍵]}¨↓⍉↑data
easter

      {(⊣⌸⍵)[⊃⍒{≢⍵}⌸⍵]}¨↓⍉↑data
easter
```