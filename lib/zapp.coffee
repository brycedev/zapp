import { UserSession } from 'blockstack'

class Zapp
  @boot: (options = {}) -> window.zapp = appId: options.appId
  @guard: ->
    throw 'please boot zapp' unless window.zapp?.appId?
    @session = new UserSession()
  @login: ->
    @guard()
    @session.redirectToSignIn()
  @logout: ->
    @guard()
    @session.signUserOut() if !@user()
  @user: ->
    @guard()
    user = false
    user = @session.loadUserData() if @session.isUserSignedIn()
    user

export default Zapp
