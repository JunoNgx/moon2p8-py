class Entity
  new: (_name) =>
    @name = _name
    @compoList = {}
    @id = ''
    addCompo(Position())
  addCompo: (_c) =>
    _c.hostEntity = self
    add(@compoList, _c)
  rmCompo: (_compoName) =>
    for c in all(@compoList)
      if c.name == _compoName then del(@compoList, c.name)
  getCompo: (_compoName) =>
    for c in all(@compoList)
      if c.name == _compoName then return c
  update: =>
    for c in all(@compoList)
      c\update!
  draw: =>
    for c in all(@compoList)
      c\draw!
