# Fonts
Fonts to be used here

Downloaded from multiples sources, see below

## Fira Code
Great Monospaced Font with amazing ligatures by tonsky see [tonsky/FiraCode](https://github.com/tonsky/FiraCode) @ [v6.2](https://github.com/tonsky/FiraCode/commit/eee6db993696aba61ff4eef03698e2987d79910c)

[Fira_Code_v6.2](./Fira_Code_v6.2.zip)

## Nerd Font Symbols
"Iconic font aggregator, collection, and patcher". Downloaded from [ryanoasis/nerd-fonts](https://github.com/ryanoasis/nerd-fonts)
@ [v3.2.1](https://github.com/ryanoasis/nerd-fonts/commit/b6c7639200240f2608e751a3aafe1720125895b3)

[NerdFontsSymbolsOnly](./NerdFontsSymbolsOnly.tar.xz)

I choose to download only the symbols font, using an unpatched main font and
letting unfound icons fall back to the NerdFontSymbol

## Testing
Since not using a patched font some icons were not being correclty found, and this
setup may differ for each system and for other terminals, but on [Kitty](../kitty)
was necessary to some icons force NerdFont coice using the `symbol_map` [config](../kitty/kitty.conf)

The [font-example](./font-example.txt) file may be used to validate if the
terminal is finding the symbol from the correct font. For Kitty use `kitty --debug-font-fallback`

