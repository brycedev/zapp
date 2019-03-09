import { UserSession } from 'blockstack'

class Zapp
  @boot: (options = {}) ->
    { appId } = options
    @appId = appId
    window.zappboot = true
  @login: ->
    throw 'please boot zapp, first' unless window.zappboot is true
    session = new UserSession()
    session.redirectToSignIn()
  @logout: ->
    throw 'please boot zapp, first' unless window.zappboot is true
    session = new UserSession()
    session.signUserOut() if @user() isnt false
  @user: ->
    throw 'please boot zapp, first' unless window.zappboot is true
    session = new UserSession()
    user = false
    user = session.loadUserData() if session.isUserSignedIn()
    user

export default Zapp
