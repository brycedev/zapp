import * as blockstack from 'blockstack'

class Model
  constructor: (data) ->
    @attrs = {}
    @attrs[k] = v for k,v of data
    @index = false
    @timestamps = true
  destroy: () ->
  save: (encrypt = false) ->
    @attrs.id = blockstack.makeUUID4().replace('-', '').toString(10) || @attrs.id
    @attrs.createdAt = Date.now() || @attrs.createdAt if @timestamps
    @attrs.updatedAt = Date.now() if @timestamps
    await blockstack.putFile "#{@path()}/#{@attrs.id}.json", JSON.stringify(@attrs),  encrypt: encrypt
  @all: (options = {}) =>
    session = new blockstack.UserSession()
    throw 'unauthenticated' unless session.isUserSignedIn() is true
    collection = []
    models = JSON.parse await session.getFile "#{@path()}.json", options
    for i in models
      model = JSON.parse await session.getFile "#{@path()}/#{i}.json", options
      collection.push new @ model
    collection
  @find: (id, options = {}) =>
    session = new blockstack.UserSession()
    throw 'unauthenticated' unless session.isUserSignedIn() is true
    model = JSON.parse await session.getFile "#{@path()}/#{id}.json", options
    new @ model
  @findOther: (username, id, options = {}) ->
    session = new blockstack.UserSession()
    opts =
      username: username
      decrypt: false
    opts[k] = options[k] for k,v of options
    model = JSON.parse await session.getFile "#{@path()}/#{id}.json", opts
    new @ model
  @findOthers: (username, options = {}) =>
    session = new blockstack.UserSession()
    collection = []
    opts =
      username: username
      decrypt: false
    opts[k] = options[k] for k,v of options
    models = JSON.parse await session.getFile "shared/#{@path()}/#{id}.json", options
    for i in models
      model = JSON.parse await session.getFile "#{@path()}/#{id}.json", opts
      collection.push new @ model
    collection
  @path: ->
    name = @constructor.name.toLowerCase()
    console.log name
    name
export default Model