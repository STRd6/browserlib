###*
Merges properties from objects into target without overiding.
First come, first served.

@return {Object} target
###
jQuery.extend
  reverseMerge: (target, objects...) ->
    for object in objects
      for name of object
        unless target.hasOwnProperty(name)
          target[name] = object[name]

    return target

