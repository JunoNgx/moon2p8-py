export _has = (e, _c)->
  for c in all(e)
    if not e[_c] then return false
  return true

export System = (components, func) ->
  return (entity_list) ->
    for e in all(entity_list)
      if _has(e, components) then func!
