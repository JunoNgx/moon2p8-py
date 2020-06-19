class Position extends Component
  new: (_x=0, _y=0, _vx=0, _vy=0) =>
    @.name = "pos"
    @x = _x
    @y = _y
    @vel = {
      x: _vx,
      y: _vy,
    }
  update: =>
    @x += @vel.x
    @y += @vel.y
