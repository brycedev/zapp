import { getFile, putFile } from 'blockstack'
# import { uuid } from './utils'

class Model
  constructor: (data) -> @attrs[k] = v for k,v of data
  filePathForId: (id) -> "#{@path}/#{id}.json"
  save: (encrypt = false) ->
    new Promise(resolve, reject) =>
      @attrs.createdAt = Date.now() || @attrs.createdAt
      @attrs.updatedAt = Date.now()
      await putFile @filePathForId(@attrs.id), JSON.stringify(@attrs),  encrypt: encrypt
      resolve()
  @all: (id, options = {}) =>
    collection = []
    models = JSON.parse await getFile "#{@path}.json", options
    for i in models
      model = JSON.parse await getFile @filePathForId(id), options
      collection.push new @ model
    collection
  @find: (id, options = {}) =>
    model = JSON.parse await getFile @filePathForId(id), options
    new @ model
  @findOther: (username, id, options = {}) =>
    opts =
      app: window.location.host
      username: username
    opts[k] = options[k] for k,v of options
    model = JSON.parse await getFile @filePathForId(id), opts
    new @ model
  @findOthers: (username, options = {}) =>
    collection = []
    opts =
      app: window.location.host
      username: username
    opts[k] = options[k] for k,v of options
    models = JSON.parse await getFile "shared/#{@path}.json", options
    for i in models
      model = JSON.parse await getFile @filePathForId(id), opts
      collection.push new @ model
    collection

export default Model