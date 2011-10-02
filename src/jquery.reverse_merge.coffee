###*
Merges properties from objects into target without overiding.
First come, first served.

@name reverseMerge
@methodOf jQuery#

@param {Object} target the object to merge the given properties onto
@param {Object} objects... one or more objects whose properties are merged onto target

@return {Object} target
###
jQuery.extend
  reverseMerge: (target, objects...) ->
    for object in objects
      for name of object
        unless target.hasOwnProperty(name)
          target[name] = object[name]

    return target

