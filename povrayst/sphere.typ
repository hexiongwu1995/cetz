#import "@preview/povrayst:0.1.0": highlight, pov, render
#show: highlight
#show raw.where(lang: "povray"): pov


```povray
camera { location <0, 2, -5> look_at 0 }
light_source { <4, 6, -4> rgb 1.2 }
sphere { 0, 1 pigment { rgb <1, 0.4, 0.15> } }
```


