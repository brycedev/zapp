import * as blockstack from 'blockstack'

class Model
  constructor: (data) -> @attrs[k] = v for k,v of data
  save: (encrypt = false) ->
    new Promise(resolve, reject) =>
      @attrs.createdAt = Date.now() || @attrs.createdAt
      @attrs.updatedAt = Date.now()
      await blockstack.putFile "#{@path()}/#{@attrs.id}.json", JSON.stringify(@attrs),  encrypt: encrypt
      resolve()
  @all: (options = {}) =>
    session = new blockstack.UserSession()
    throw 'unauthenticated' unless session.isUserSignedIn() is true
    collection = []
    models = JSON.parse await blockstack.getFile "#{@path()}.json", options
    for i in models
      model = JSON.parse await blockstack.getFile "#{@path()}/#{i}.json", options
      collection.push new @ model
    collection
  @find: (id, options = {}) =>
    session = new blockstack.UserSession()
    throw 'unauthenticated' unless session.isUserSignedIn() is true
    model = JSON.parse await blockstack.getFile "#{@path()}/#{id}.json", options
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
  @index: -> false
  @path: -> 'models'
  @timestamp: -> true

export default Model