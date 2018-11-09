# An Experiment Using Elm

This is my first real attempt at using Elm. If you would like to play around with any of this, here are some 
great resources


## Recommended Resources
- [Elm Official Docs](https://elm-lang.org/docs)
- [Elm Official Guide](https://guide.elm-lang.org/) *which I highly recommend going through (don't skip around)*
- [Package Docs](https://package.elm-lang.org/) *Good for referencing the standard lib and other packages. **Learn your type annotations and you will be able to quickly pick up new functions with ease***
- [Unofficial Tutorial](https://www.elm-tutorial.org/en/) *It uses one version older of elm but is still good (the issue is functions that have been moved to different modules or are gone and replaced all together)*
- [Online REPL](https://ellie-app.com) *Good for testing the language without having to set anything up*

## Dice Roller

To run this using the styles and index found in the **DiceRoller** folder you will need to recompile the **elm.js** file using `elm make ./src/DiceRoller.elm --output ./DiceRoller/elm.js`

## Notable Areas of the Repo

The best thing I have going so far is the **DiceRoller.elm** file. Check it out using the `elm reactor` tool to get a quick look or paste it into the repl mentioned in the resources.

Originally I intended to create a very rudimentary PokeDex using the [PokeAPI](https://pokeapi.co/) but that has yet to pan out. There are a lot of pieces to setup to make this work.
The difficult portions include [JSON](https://package.elm-lang.org/packages/elm/json/latest/) decoding things and making [HTTP](https://package.elm-lang.org/packages/elm/http/latest/) requests which heavily depends on
[Commands](https://package.elm-lang.org/packages/elm/core/latest/Platform-Cmd) to the elm runtime.

### Examples of Elm Runtime
![](https://onstuimig-infi.s3.amazonaws.com/files/content/_inline/elm-update-loop.png)

![elm runtime workflow](https://cdn-images-1.medium.com/max/800/1*dZFJ9fnMH-2c3B8byqrDmw.gif)
