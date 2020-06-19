class PlayerControl extends Component
  new: () =>
    @name = "player-control"
  update: =>
    pos = @hostEntity.getCompo("pos")
    if (btn(0)) then pos.vel.x = 1
    if (btn(1)) then pos.vel.x = -1
    if (btn(2)) then pos.vel.y = 1
    if (btn(3)) then pos.vel.y = -1
