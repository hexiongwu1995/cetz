#import "@preview/povrayst:0.1.0": highlight, pov, render
#show: highlight
#show raw.where(lang: "povray"): pov

// Or load from a file:
#render(read("csg.pov"))

