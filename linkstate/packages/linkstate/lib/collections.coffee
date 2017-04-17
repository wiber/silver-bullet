


Edges = new (Mongo.Collection)('Edges')
Edges.allow
  insert: ->
    true
  update: ->
    false
  remove: ->
    false
Nodes = new (Mongo.Collection)('Nodes')
Nodes.allow
  insert: ->
    true
  update: ->
    true
  remove: ->
    false
