# zapp ⚡️

zapp is a client library for rapid dapp development

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
import { zapp } from '@brycedev/zapp'

zapp({ appId: '', index: true })
~~~