do -> return unless window? and window.location? and window.localStorage?

import Model from './model'
import zapp from './zapp'

export default { Model, zapp }