{see, store} = require '../../imports/api/strings.coffee'
describe 'see', ->
  it 'should return a string', ->
    seen = see 'asdasd%2520asdd'
    real = 'asdasd asdd'
    expect(seen).toBe(real)
