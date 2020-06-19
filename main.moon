#include("Libs/Ecs.moon")

#include("Entities/Entity.moon")
#include("Entities/Player.moon")

#include("Components/Component.moon")
#include("Components/Position.moon")
#include("Components/PlayerControl.moon")

#inclUDe("Entities/Player.moon")

export _init = ->
  print("hallo")
  export world = {}
  add(world, Player())

export _update = ->
  for e in all(world) do
    e\update!

export _draw = ->
  cls!
  print("Hallo")
  for e in all(world) do
    e\draw!
