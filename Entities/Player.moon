class Player extends Entity
  new: (_x=64, _y=64) ->
    pos = @getCompo("pos")
    pos.x = _x
    pos.y = _y

    @addCompo(PlayerControl())
  draw: =>
    pos = @getCompo("pos")
    circfill(pos.x, pos.y, 4, 8)
