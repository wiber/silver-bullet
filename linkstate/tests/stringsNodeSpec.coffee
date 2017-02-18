{AByMomentum, listByMomentum} = require('../imports/api/strings')
#{AByMomentum} = require('../imports/strings')
chai = require('chai')
expect = chai.expect
assert = chai.assert
R = require 'ramda'
urlData =
  url1:
    userOne:
      meta:
        weight: undefined
    userTwo:
      meta:
        weight: undefined
  url2:
    userOne:
      meta:
        weight: 3
    userTwo:
      meta:
        weight: 4
  url3:
    userOne:
      meta:
        weight: 7
    userTwo:
      meta:
        weight: 8
realData =
  'url1':
    'Elias Moosman':
      'from': 'Bookmarks'
      'to': 'Bookmarks'
      'meta':
        'weight': 7
        'title': 'Your Bookmarks'
        'face': 'http://graph.facebook.com/v2.7/10154232419354595/picture?type=square'
        'profileLink': 'https://www.facebook.com/app_scoped_user_id/10154232419354595/'
        'FromLink': 'Bookmarks'
        'ToLink': 'Bookmarks'
        'ScreenshotUrl': 'https://api.thumbalizr.com/?url=Bookmarks&width=250&api_key=5VmUR42gc4eGdLjBnZH2BRXa'
        'ScreenshotUrlTo': 'https://api.thumbalizr.com/?url=Bookmarks&width=250&api_key=5VmUR42gc4eGdLjBnZH2BRXa'
      'author': 'cqWYJrZCGeWoPc68T'
      'createdAt': 1487164578054
      'title': 'Your Bookmarks'
    'userTwo':
      'from': 'Bookmarks'
      'to': 'Bookmarks'
      'meta':
        'weight': 9
        'title': 'Your Bookmarks'
        'face': 'http://graph.facebook.com/v2.7/10154232419354595/picture?type=square'
        'profileLink': 'https://www.facebook.com/app_scoped_user_id/10154232419354595/'
        'FromLink': 'Bookmarks'
        'ToLink': 'Bookmarks'
        'ScreenshotUrl': 'https://api.thumbalizr.com/?url=Bookmarks&width=250&api_key=5VmUR42gc4eGdLjBnZH2BRXa'
        'ScreenshotUrlTo': 'https://api.thumbalizr.com/?url=Bookmarks&width=250&api_key=5VmUR42gc4eGdLjBnZH2BRXa'
      'author': 'cqWYJrZCGeWoPc68T'
      'createdAt': 1487164578054
      'title': 'Your Bookmarks'
  'https%3A%2F%2Fwww%2Efacebook%2Ecom%2Fapp_scoped_user_id%2F10154232419354595%2F':
    'Elias Moosman':
      'from': 'https%3A%2F%2Fwww%2Efacebook%2Ecom%2Fapp_scoped_user_id%2F10154232419354595%2F'
      'to': 'Bookmarks'
      'meta':
        weight: 9
        'title': 'Elias Moosman on Facebook'
        'face': 'http://graph.facebook.com/v2.7/10154232419354595/picture?type=square'
        'profileLink': 'https://www.facebook.com/app_scoped_user_id/10154232419354595/'
        'FromLink': 'https://www.facebook.com/app_scoped_user_id/10154232419354595/'
        'ToLink': 'Bookmarks'
        'ScreenshotUrl': 'https://api.thumbalizr.com/?url=https://www.facebook.com/app_scoped_user_id/10154232419354595/&width=250&api_key=5VmUR42gc4eGdLjBnZH2BRXa'
        'ScreenshotUrlTo': 'https://api.thumbalizr.com/?url=Bookmarks&width=250&api_key=5VmUR42gc4eGdLjBnZH2BRXa'
      'author': 'cqWYJrZCGeWoPc68T'
      'createdAt': 1487164578246
      'title': 'Elias Moosman on Facebook'
  'http%3A%2F%2Fwww%2Ematerial-ui%2Ecom%2Fv0%2E15%2E0%2F%23%2F':
    'Elias Moosman':
      'from': 'http%3A%2F%2Fwww%2Ematerial-ui%2Ecom%2Fv0%2E15%2E0%2F%23%2F'
      'to': 'Bookmarks'
      'meta':
        weight: 3
        'title': 'Material-UI'
        'face': 'http://graph.facebook.com/v2.7/10154232419354595/picture?type=square'
        'profileLink': 'https://www.facebook.com/app_scoped_user_id/10154232419354595/'
        'FromLink': 'http://www.material-ui.com/v0.15.0/#/'
        'ToLink': 'Bookmarks'
        'ScreenshotUrl': 'https://api.thumbalizr.com/?url=http://www.material-ui.com/v0.15.0/#/&width=250&api_key=5VmUR42gc4eGdLjBnZH2BRXa'
        'ScreenshotUrlTo': 'https://api.thumbalizr.com/?url=Bookmarks&width=250&api_key=5VmUR42gc4eGdLjBnZH2BRXa'
      'author': 'cqWYJrZCGeWoPc68T'
      'createdAt': 1486799850384
      'title': 'Material-UI'

describe 'Momentum', ->
  it 'should return an array of two length', ->
    Momentum = AByMomentum realData
    expect(Momentum.length).to.equal(3)
  it 'should return correct array', ->
    Momentum = AByMomentum urlData
    expect(Momentum).to.deep.equal(['url3','url2','url1'])

describe 'listMomentum', ->
  inOutMomentum = listByMomentum(AByMomentum(realData), AByMomentum(urlData))
  it 'should return an array of 5 length', ->
    expect(inOutMomentum.length).to.equal(5)
  it 'should return correct array', ->
    expect(inOutMomentum).to.deep.equal [
      'url3',
      'url2',
      'url1',
      # due to uniq filtering forward to back, url1 keeps it's [3] position correctly.
      # url1 has more momentum going it, but doesn't help in this example
      'https%3A%2F%2Fwww%2Efacebook%2Ecom%2Fapp_scoped_user_id%2F10154232419354595%2F',
      'http%3A%2F%2Fwww%2Ematerial-ui%2Ecom%2Fv0%2E15%2E0%2F%23%2F'
      ]
  it 'should return even if a list is undefined', ->
    expect(listByMomentum(undefined,AByMomentum(realData)).length).to.equal(3)
