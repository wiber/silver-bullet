{AByMomentum} = require('../imports/api/strings')
#{AByMomentum} = require('../imports/strings')
chai = require('chai')
expect = chai.expect
assert = chai.assert
R = require 'ramda'
urlData =
  url1:
    userOne:
      meta:
        weight: 3
    userTwo:
      meta:
        weight: 7
  url2:
    userOne:
      meta:
        weight: 9
    userTwo:
      meta:
        weight: 7

describe 'Momentum', ->
  it 'should return an array of two length', ->
    Momentum = AByMomentum urlData
    expect(Momentum.length).to.equal(2)
  it 'should return correct array', ->
    Momentum = AByMomentum urlData
    assert.deepEqual(Momentum,['url2','url1'])
