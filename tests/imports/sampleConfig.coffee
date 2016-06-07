define [
  'app'
  'jquery'
  'underscore'
], (App, $, _) ->
  describe 'just checking', ->
    it 'works for true', ->
      expect(true).toEqual true
      return
    it 'works for underscore', ->
      # just checking that _ works
      expect(_.size([
        1
        2
        3
      ])).toEqual 3
      return
    return
  return
