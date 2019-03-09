# zapp ⚡️

zapp is a client library for rapid blockstack dapp development

## what is this?

this is a lightweight, opinionated tool for building decentralized applications. it relies on the use of blockstack.js for authentication and ipfs for distribution. zapp is heavily inspired by radiks, but differs in a few ways

- no servers required
  - in conjunction with a static host like netlify or github pages, you can build a complex application on top of gaia, without requiring the use of any additional servers. this means that your gaia hub is always the source of truth

## how to install

in your dapp's project folder :

~~~bash
npm install @brycedev/zapp
## or
yarn add @brycedev/zapp
~~~

## getting started

~~~javascript
import { Zapp } from '@brycedev/zapp'

// boot zapp
Zapp.boot({ appId: 'fooId' })

// authenticate the user w/ blockstack
Zapp.login()

// return the currently logged-in user
Zapp.user()

~~~

## using models

~~~javascript
import { Model } from '@brycedev/zapp'

// extend the zapp model and override the configuration
class Book extends Model {
  static index() { return true }
  static path() { return 'books' }
  static timestamps() { return true }
}

// fetch all objects for the current user
Book.all()

// fetch all objects for the current user w/ some options
Book.all({ decrypt: true })

// find a specific object for the current user
Book.find('fooId')

// find a specfic object for some other user
Book.findOther('john.id', 'fooId')

// save a new model to gaia storage
book = new Book({ title: 'My New Book', pages: 42 })
book.save()

~~~