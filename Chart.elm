module Chart (Options, default, bar, vertical, horizontal) where

{-| Create simple charts

#Charts
@docs bar

#Options
@docs Options, default

#Direction
vertical, horizontal

-}


type Options =
    { width : Int
    , height : Int
    , barColor : Color
    , direction : Direction
    }

data Direction
    = Vertical
    | Horizontal

vertical : Direction
vertical = Vertical

horizontal : Direction
horizontal = Horizontal

{-| Default bar options-}
default : Options
default =
    { width = 200
    , height = 200
    , barColor = blue
    , direction = horizontal
    }

{-| Create a bar chart
    bar Chart.default [1.0, 2.0, 5.0, 2.0]

-}
bar : Options -> [Float] -> Element
bar options values =
  let m = maximum values
      l = length values
      (dir, pos, el) =
         case options.direction of
            Vertical -> (right, above, flip spacer)
            Horizontal -> (down, flip beside, spacer)
  in
    map (\v ->
        let h = v / m * toFloat options.height |> round
            w = toFloat options.width / toFloat l |> round
        in el (options.height - h) w
           `pos`
           (el h w |> color options.barColor))
        values
      |> flow dir
