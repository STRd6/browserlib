module "Xstats"

test "exists", ->
  Engine.Stats()

# Clear out the module
module()
