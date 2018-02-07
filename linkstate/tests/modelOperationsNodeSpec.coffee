{AByMomentum, listByMomentum, linkstate} = require('../imports/api/strings')
{setOptions, setValue, userSaved, newPlace, ifBodyContentHere} = require('../imports/api/ModelOperations')

chai = require('chai')
expect = chai.expect
assert = chai.assert
R = require 'ramda'
_ = require 'lodash'
urlData =
  url1:
    userOne:
      meta:
        weight: 2
    userTwo:
      meta:
        weight: 3
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
        #weight: 3 # bookmarks don't always have weight so we deal with it..
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
realNode =
  '_id': 'Bookmarks'
  'in': 'Bookmarks': 'Elias Moosman':
    'from': 'Bookmarks'
    'to': 'Bookmarks'
    'meta':
      'title': 'Your Bookmarks'
      'face': 'http://graph.facebook.com/v2.7/10154232419354595/picture?type=square'
      'profileLink': 'https://www.facebook.com/app_scoped_user_id/10154232419354595/'
      'FromLink': 'Bookmarks'
      'ToLink': 'Bookmarks'
      'ScreenshotUrl': 'https://api.thumbalizr.com/?url=Bookmarks&width=250&api_key=5VmUR42gc4eGdLjBnZH2BRXa'
      'ScreenshotUrlTo': 'https://api.thumbalizr.com/?url=Bookmarks&width=250&api_key=5VmUR42gc4eGdLjBnZH2BRXa'
    'author': 'cqWYJrZCGeWoPc68T'
    'createdAt': 1487405461886
    'title': 'Your Bookmarks'
  'title': 'Elias Moosman on Facebook'
  'out':
    'Bookmarks': 'Elias Moosman':
      'from': 'Bookmarks'
      'to': 'Bookmarks'
      'meta':
        'title': 'Your Bookmarks'
        'face': 'http://graph.facebook.com/v2.7/10154232419354595/picture?type=square'
        'profileLink': 'https://www.facebook.com/app_scoped_user_id/10154232419354595/'
        'FromLink': 'Bookmarks'
        'ToLink': 'Bookmarks'
        'ScreenshotUrl': 'https://api.thumbalizr.com/?url=Bookmarks&width=250&api_key=5VmUR42gc4eGdLjBnZH2BRXa'
        'ScreenshotUrlTo': 'https://api.thumbalizr.com/?url=Bookmarks&width=250&api_key=5VmUR42gc4eGdLjBnZH2BRXa'
      'author': 'cqWYJrZCGeWoPc68T'
      'createdAt': 1487405461886
      'title': 'Your Bookmarks'
    'https%3A%2F%2Fwww%2Efacebook%2Ecom%2Fapp_scoped_user_id%2F10154232419354595%2F': 'Elias Moosman':
      'from': 'https%3A%2F%2Fwww%2Efacebook%2Ecom%2Fapp_scoped_user_id%2F10154232419354595%2F'
      'to': 'Bookmarks'
      'meta':
        'title': 'Elias Moosman on Facebook'
        'face': 'http://graph.facebook.com/v2.7/10154232419354595/picture?type=square'
        'profileLink': 'https://www.facebook.com/app_scoped_user_id/10154232419354595/'
        'FromLink': 'https://www.facebook.com/app_scoped_user_id/10154232419354595/'
        'ToLink': 'Bookmarks'
        'ScreenshotUrl': 'https://api.thumbalizr.com/?url=https://www.facebook.com/app_scoped_user_id/10154232419354595/&width=250&api_key=5VmUR42gc4eGdLjBnZH2BRXa'
        'ScreenshotUrlTo': 'https://api.thumbalizr.com/?url=Bookmarks&width=250&api_key=5VmUR42gc4eGdLjBnZH2BRXa'
      'author': 'cqWYJrZCGeWoPc68T'
      'createdAt': 1487405461985
      'title': 'Elias Moosman on Facebook'
    'http%3A%2F%2Fwww%2Ematerial-ui%2Ecom%2Fv0%2E15%2E0%2F%23%2F': 'Elias Moosman':
      'from': 'http%3A%2F%2Fwww%2Ematerial-ui%2Ecom%2Fv0%2E15%2E0%2F%23%2F'
      'to': 'Bookmarks'
      'meta':
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
    'http%3A%2F%2Fwww%2Ematerial-ui%2Ecom%2Fv0%2E15%2E0-alpha%2E2%2F%23%2F': 'Elias Moosman':
      'from': 'http%3A%2F%2Fwww%2Ematerial-ui%2Ecom%2Fv0%2E15%2E0-alpha%2E2%2F%23%2F'
      'to': 'Bookmarks'
      'meta':
        'title': 'Material-UI'
        'face': 'http://graph.facebook.com/v2.7/10154232419354595/picture?type=square'
        'profileLink': 'https://www.facebook.com/app_scoped_user_id/10154232419354595/'
        'FromLink': 'http://www.material-ui.com/v0.15.0-alpha.2/#/'
        'ToLink': 'Bookmarks'
        'ScreenshotUrl': 'https://api.thumbalizr.com/?url=http://www.material-ui.com/v0.15.0-alpha.2/#/&width=250&api_key=5VmUR42gc4eGdLjBnZH2BRXa'
        'ScreenshotUrlTo': 'https://api.thumbalizr.com/?url=Bookmarks&width=250&api_key=5VmUR42gc4eGdLjBnZH2BRXa'
      'author': 'cqWYJrZCGeWoPc68T'
      'createdAt': 1486799938150
      'title': 'Material-UI'
    'http%3A%2F%2Fwww%2Espeedtest%2Enet%2F': 'Elias Moosman':
      'from': 'http%3A%2F%2Fwww%2Espeedtest%2Enet%2F'
      'to': 'Bookmarks'
      'meta':
        'title': 'Speedtest.net by Ookla - The Global Broadband Speed Test'
        'face': 'http://graph.facebook.com/v2.7/10154232419354595/picture?type=square'
        'profileLink': 'https://www.facebook.com/app_scoped_user_id/10154232419354595/'
        'FromLink': 'http://www.speedtest.net/'
        'ToLink': 'Bookmarks'
        'ScreenshotUrl': 'https://api.thumbalizr.com/?url=http://www.speedtest.net/&width=250&api_key=5VmUR42gc4eGdLjBnZH2BRXa'
        'ScreenshotUrlTo': 'https://api.thumbalizr.com/?url=Bookmarks&width=250&api_key=5VmUR42gc4eGdLjBnZH2BRXa'
      'author': 'cqWYJrZCGeWoPc68T'
      'createdAt': 1486992184075
      'title': 'Speedtest.net by Ookla - The Global Broadband Speed Test'
    'https%3A%2F%2Fforums%2Emeteor%2Ecom%2Ft%2Freact-accounts-ui-user-login-components%2F14078%2F5': 'Elias Moosman':
      'from': 'https%3A%2F%2Fforums%2Emeteor%2Ecom%2Ft%2Freact-accounts-ui-user-login-components%2F14078%2F5'
      'to': 'Bookmarks'
      'meta':
        'title': 'React accounts-ui / user / login components? - react - Meteor forums'
        'face': 'http://graph.facebook.com/v2.7/10154232419354595/picture?type=square'
        'profileLink': 'https://www.facebook.com/app_scoped_user_id/10154232419354595/'
        'FromLink': 'https://forums.meteor.com/t/react-accounts-ui-user-login-components/14078/5'
        'ToLink': 'Bookmarks'
        'ScreenshotUrl': 'https://api.thumbalizr.com/?url=https://forums.meteor.com/t/react-accounts-ui-user-login-components/14078/5&width=250&api_key=5VmUR42gc4eGdLjBnZH2BRXa'
        'ScreenshotUrlTo': 'https://api.thumbalizr.com/?url=Bookmarks&width=250&api_key=5VmUR42gc4eGdLjBnZH2BRXa'
      'author': 'cqWYJrZCGeWoPc68T'
      'createdAt': 1486992195023
      'title': 'React accounts-ui / user / login components? - react - Meteor forums'
    'http%3A%2F%2Flocalhost%3A3000%2Fabout%3FBookmarked%3Dtrue%26content%3D%26to%3Dhttps%253A%252F%252Fwww%2Efacebook%2Ecom%252Fapp_scoped_user_id%252F10154232419354595%252F%26from%3Dhttp%253A%252F%252Fwww%2Ematerial-ui%2Ecom%252Fv0%2E15%2E0-alpha%2E2%252F%2523%252F': 'Elias Moosman':
      'from': 'http%3A%2F%2Flocalhost%3A3000%2Fabout%3FBookmarked%3Dtrue%26content%3D%26to%3Dhttps%253A%252F%252Fwww%2Efacebook%2Ecom%252Fapp_scoped_user_id%252F10154232419354595%252F%26from%3Dhttp%253A%252F%252Fwww%2Ematerial-ui%2Ecom%252Fv0%2E15%2E0-alpha%2E2%252F%2523%252F'
      'to': 'Bookmarks'
      'meta':
        'title': 'localhost:3000/about?Bookmarked=true&content=&to=https%3A%2F%2Fwww.facebook.com%2Fapp_scoped_user_id%2F10154232419354595%2F&from=http%3A%2F%2Fwww.material-ui.com%2Fv0.15.0-alpha.2%2F%23%2F'
        'face': 'http://graph.facebook.com/v2.7/10154232419354595/picture?type=square'
        'profileLink': 'https://www.facebook.com/app_scoped_user_id/10154232419354595/'
        'FromLink': 'http://localhost:3000/about?Bookmarked=true&content=&to=https%3A%2F%2Fwww.facebook.com%2Fapp_scoped_user_id%2F10154232419354595%2F&from=http%3A%2F%2Fwww.material-ui.com%2Fv0.15.0-alpha.2%2F%23%2F'
        'ToLink': 'Bookmarks'
        'ScreenshotUrl': 'https://api.thumbalizr.com/?url=http://localhost:3000/about?Bookmarked=true&content=&to=https%3A%2F%2Fwww.facebook.com%2Fapp_scoped_user_id%2F10154232419354595%2F&from=http%3A%2F%2Fwww.material-ui.com%2Fv0.15.0-alpha.2%2F%23%2F&width=250&api_key=5VmUR42gc4eGdLjBnZH2BRXa'
        'ScreenshotUrlTo': 'https://api.thumbalizr.com/?url=Bookmarks&width=250&api_key=5VmUR42gc4eGdLjBnZH2BRXa'
      'author': 'cqWYJrZCGeWoPc68T'
      'createdAt': 1487164253429
      'title': 'localhost:3000/about?Bookmarked=true&content=&to=https%3A%2F%2Fwww.facebook.com%2Fapp_scoped_user_id%2F10154232419354595%2F&from=http%3A%2F%2Fwww.material-ui.com%2Fv0.15.0-alpha.2%2F%23%2F'
    'http%3A%2F%2Fxixixao%2Egithub%2Eio%2Fprelude-ls%2F%23f-compose': 'Elias Moosman':
      'from': 'http%3A%2F%2Fxixixao%2Egithub%2Eio%2Fprelude-ls%2F%23f-compose'
      'to': 'Bookmarks'
      'meta':
        'title': 'prelude.coffee - a JavaScript functional programming library - for and in CoffeeScript'
        'face': 'http://graph.facebook.com/v2.7/10154232419354595/picture?type=square'
        'profileLink': 'https://www.facebook.com/app_scoped_user_id/10154232419354595/'
        'FromLink': 'http://xixixao.github.io/prelude-ls/#f-compose'
        'ToLink': 'Bookmarks'
        'ScreenshotUrl': 'https://api.thumbalizr.com/?url=http://xixixao.github.io/prelude-ls/#f-compose&width=250&api_key=5VmUR42gc4eGdLjBnZH2BRXa'
        'ScreenshotUrlTo': 'https://api.thumbalizr.com/?url=Bookmarks&width=250&api_key=5VmUR42gc4eGdLjBnZH2BRXa'
      'author': 'cqWYJrZCGeWoPc68T'
      'createdAt': 1487067079661
      'title': 'prelude.coffee - a JavaScript functional programming library - for and in CoffeeScript'
    'http%3A%2F%2Fwww%2Ematerial-ui%2Ecom%2Fv0%2E15%2E0-alpha%2E2%2F%23%2Fcomponents%2Ftoolbar': 'Elias Moosman':
      'from': 'http%3A%2F%2Fwww%2Ematerial-ui%2Ecom%2Fv0%2E15%2E0-alpha%2E2%2F%23%2Fcomponents%2Ftoolbar'
      'to': 'Bookmarks'
      'meta':
        'title': 'Toolbar - Material-UI'
        'face': 'http://graph.facebook.com/v2.7/10154232419354595/picture?type=square'
        'profileLink': 'https://www.facebook.com/app_scoped_user_id/10154232419354595/'
        'FromLink': 'http://www.material-ui.com/v0.15.0-alpha.2/#/components/toolbar'
        'ToLink': 'Bookmarks'
        'ScreenshotUrl': 'https://api.thumbalizr.com/?url=http://www.material-ui.com/v0.15.0-alpha.2/#/components/toolbar&width=250&api_key=5VmUR42gc4eGdLjBnZH2BRXa'
        'ScreenshotUrlTo': 'https://api.thumbalizr.com/?url=Bookmarks&width=250&api_key=5VmUR42gc4eGdLjBnZH2BRXa'
      'author': 'cqWYJrZCGeWoPc68T'
      'createdAt': 1487084924408
      'title': 'Toolbar - Material-UI'
    'https%3A%2F%2Fgithub%2Ecom%2Fjunegunn%2Ffzf': 'Elias Moosman':
      'from': 'https%3A%2F%2Fgithub%2Ecom%2Fjunegunn%2Ffzf'
      'to': 'Bookmarks'
      'meta':
        'title': 'junegunn/fzf: A command-line fuzzy finder written in Go'
        'face': 'http://graph.facebook.com/v2.7/10154232419354595/picture?type=square'
        'profileLink': 'https://www.facebook.com/app_scoped_user_id/10154232419354595/'
        'FromLink': 'https://github.com/junegunn/fzf'
        'ToLink': 'Bookmarks'
        'ScreenshotUrl': 'https://api.thumbalizr.com/?url=https://github.com/junegunn/fzf&width=250&api_key=5VmUR42gc4eGdLjBnZH2BRXa'
        'ScreenshotUrlTo': 'https://api.thumbalizr.com/?url=Bookmarks&width=250&api_key=5VmUR42gc4eGdLjBnZH2BRXa'
      'author': 'cqWYJrZCGeWoPc68T'
      'createdAt': 1487085296033
      'title': 'junegunn/fzf: A command-line fuzzy finder written in Go'
    'https%3A%2F%2Fgithub%2Ecom%2Fjunegunn%2Fvim-plug': 'Elias Moosman':
      'from': 'https%3A%2F%2Fgithub%2Ecom%2Fjunegunn%2Fvim-plug'
      'to': 'Bookmarks'
      'meta':
        'title': 'junegunn/vim-plug: Minimalist Vim Plugin Manager'
        'face': 'http://graph.facebook.com/v2.7/10154232419354595/picture?type=square'
        'profileLink': 'https://www.facebook.com/app_scoped_user_id/10154232419354595/'
        'FromLink': 'https://github.com/junegunn/vim-plug'
        'ToLink': 'Bookmarks'
        'ScreenshotUrl': 'https://api.thumbalizr.com/?url=https://github.com/junegunn/vim-plug&width=250&api_key=5VmUR42gc4eGdLjBnZH2BRXa'
        'ScreenshotUrlTo': 'https://api.thumbalizr.com/?url=Bookmarks&width=250&api_key=5VmUR42gc4eGdLjBnZH2BRXa'
      'author': 'cqWYJrZCGeWoPc68T'
      'createdAt': 1487158465591
      'title': 'junegunn/vim-plug: Minimalist Vim Plugin Manager'
    'http%3A%2F%2Flocalhost%3A3000%2Fabout%3FBookmarked%3Dtrue%26content%3D%26to%3Dhttps%253A%252F%252Fwww%2Efacebook%2Ecom%252Fapp_scoped_user_id%252F10154232419354595%252F%26from%3DBookmarks': 'Elias Moosman':
      'from': 'http%3A%2F%2Flocalhost%3A3000%2Fabout%3FBookmarked%3Dtrue%26content%3D%26to%3Dhttps%253A%252F%252Fwww%2Efacebook%2Ecom%252Fapp_scoped_user_id%252F10154232419354595%252F%26from%3DBookmarks'
      'to': 'Bookmarks'
      'meta':
        'title': 'localhost:3000/about?Bookmarked=true&content=&to=https%3A%2F%2Fwww.facebook.com%2Fapp_scoped_user_id%2F10154232419354595%2F&from=Bookmarks'
        'face': 'http://graph.facebook.com/v2.7/10154232419354595/picture?type=square'
        'profileLink': 'https://www.facebook.com/app_scoped_user_id/10154232419354595/'
        'FromLink': 'http://localhost:3000/about?Bookmarked=true&content=&to=https%3A%2F%2Fwww.facebook.com%2Fapp_scoped_user_id%2F10154232419354595%2F&from=Bookmarks'
        'ToLink': 'Bookmarks'
        'ScreenshotUrl': 'https://api.thumbalizr.com/?url=http://localhost:3000/about?Bookmarked=true&content=&to=https%3A%2F%2Fwww.facebook.com%2Fapp_scoped_user_id%2F10154232419354595%2F&from=Bookmarks&width=250&api_key=5VmUR42gc4eGdLjBnZH2BRXa'
        'ScreenshotUrlTo': 'https://api.thumbalizr.com/?url=Bookmarks&width=250&api_key=5VmUR42gc4eGdLjBnZH2BRXa'
      'author': 'cqWYJrZCGeWoPc68T'
      'createdAt': 1487172340036
      'title': 'localhost:3000/about?Bookmarked=true&content=&to=https%3A%2F%2Fwww.facebook.com%2Fapp_scoped_user_id%2F10154232419354595%2F&from=Bookmarks'
    'https%3A%2F%2Fwww%2Enpmjs%2Ecom%2Fpackage%2Framda': 'Elias Moosman':
      'from': 'https%3A%2F%2Fwww%2Enpmjs%2Ecom%2Fpackage%2Framda'
      'to': 'Bookmarks'
      'meta':
        'title': 'ramda'
        'face': 'http://graph.facebook.com/v2.7/10154232419354595/picture?type=square'
        'profileLink': 'https://www.facebook.com/app_scoped_user_id/10154232419354595/'
        'FromLink': 'https://www.npmjs.com/package/ramda'
        'ToLink': 'Bookmarks'
        'ScreenshotUrl': 'https://api.thumbalizr.com/?url=https://www.npmjs.com/package/ramda&width=250&api_key=5VmUR42gc4eGdLjBnZH2BRXa'
        'ScreenshotUrlTo': 'https://api.thumbalizr.com/?url=Bookmarks&width=250&api_key=5VmUR42gc4eGdLjBnZH2BRXa'
      'author': 'cqWYJrZCGeWoPc68T'
      'createdAt': 1487402699730
      'title': 'ramda'
inout =
  '_id': 'https%3A%2F%2Fgithub%2Ecom%2Fjunegunn%2Fvim-plug'
  'in':
    'Bookmarks': 'Elias Moosman':
      'from': 'https%3A%2F%2Fgithub%2Ecom%2Fjunegunn%2Fvim-plug'
      'to': 'Bookmarks'
      'meta':
        'title': 'junegunn/vim-plug: Minimalist Vim Plugin Manager'
        'face': 'http://graph.facebook.com/v2.7/10154232419354595/picture?type=square'
        'profileLink': 'https://www.facebook.com/app_scoped_user_id/10154232419354595/'
        'FromLink': 'https://github.com/junegunn/vim-plug'
        'ToLink': 'Bookmarks'
        'ScreenshotUrl': 'https://api.thumbalizr.com/?url=https://github.com/junegunn/vim-plug&width=250&api_key=5VmUR42gc4eGdLjBnZH2BRXa'
        'ScreenshotUrlTo': 'https://api.thumbalizr.com/?url=Bookmarks&width=250&api_key=5VmUR42gc4eGdLjBnZH2BRXa'
      'author': 'cqWYJrZCGeWoPc68T'
      'createdAt': 1487158465591
      'title': 'junegunn/vim-plug: Minimalist Vim Plugin Manager'
    'https%3A%2F%2Fgithub%2Ecom%2Fjunegunn%2Ffzf': 'Elias Moosman':
      'from': 'https%3A%2F%2Fgithub%2Ecom%2Fjunegunn%2Fvim-plug'
      'to': 'https%3A%2F%2Fgithub%2Ecom%2Fjunegunn%2Ffzf'
      'meta':
        'body': ''
        'weight': 1
        'title': 'https://github.com/junegunn/fzf'
        'face': 'http://graph.facebook.com/v2.7/10154232419354595/picture?type=square'
        'profileLink': 'https://www.facebook.com/app_scoped_user_id/10154232419354595/'
        'FromLink': 'https://github.com/junegunn/vim-plug'
        'ToLink': 'https://github.com/junegunn/fzf'
        'ScreenshotUrl': 'https://api.thumbalizr.com/?url=https://github.com/junegunn/vim-plug&width=250&api_key=5VmUR42gc4eGdLjBnZH2BRXa'
        'ScreenshotUrlTo': 'https://api.thumbalizr.com/?url=https://github.com/junegunn/fzf&width=250&api_key=5VmUR42gc4eGdLjBnZH2BRXa'
      'author': 'cqWYJrZCGeWoPc68T'
      'createdAt': 1487158466911
      'title': 'https://github.com/junegunn/fzf'
    'https%3A%2F%2Fgithub%2Ecom%2Fjunegunn%2Fvim-plug': 'Elias Moosman':
      'from': 'https%3A%2F%2Fgithub%2Ecom%2Fjunegunn%2Fvim-plug'
      'to': 'https%3A%2F%2Fgithub%2Ecom%2Fjunegunn%2Fvim-plug'
      'meta':
        'body': ''
        'weight': 8
        'title': 'https://github.com/junegunn/vim-plug'
        'face': 'http://graph.facebook.com/v2.7/10154232419354595/picture?type=square'
        'profileLink': 'https://www.facebook.com/app_scoped_user_id/10154232419354595/'
        'FromLink': 'https://github.com/junegunn/vim-plug'
        'ToLink': 'https://github.com/junegunn/vim-plug'
        'ScreenshotUrl': 'https://api.thumbalizr.com/?url=https://github.com/junegunn/vim-plug&width=250&api_key=5VmUR42gc4eGdLjBnZH2BRXa'
        'ScreenshotUrlTo': 'https://api.thumbalizr.com/?url=https://github.com/junegunn/vim-plug&width=250&api_key=5VmUR42gc4eGdLjBnZH2BRXa'
      'author': 'cqWYJrZCGeWoPc68T'
      'createdAt': 1487172207151
      'title': 'https://github.com/junegunn/vim-plug'
  'title': 'https://github.com/junegunn/vim-plug'
  'out':
    'https%3A%2F%2Fgithub%2Ecom%2Fjunegunn%2Fvim-plug': 'Elias Moosman':
      'from': 'https%3A%2F%2Fgithub%2Ecom%2Fjunegunn%2Fvim-plug'
      'to': 'https%3A%2F%2Fgithub%2Ecom%2Fjunegunn%2Fvim-plug'
      'meta':
        'body': ''
        'weight': 8
        'title': 'https://github.com/junegunn/vim-plug'
        'face': 'http://graph.facebook.com/v2.7/10154232419354595/picture?type=square'
        'profileLink': 'https://www.facebook.com/app_scoped_user_id/10154232419354595/'
        'FromLink': 'https://github.com/junegunn/vim-plug'
        'ToLink': 'https://github.com/junegunn/vim-plug'
        'ScreenshotUrl': 'https://api.thumbalizr.com/?url=https://github.com/junegunn/vim-plug&width=250&api_key=5VmUR42gc4eGdLjBnZH2BRXa'
        'ScreenshotUrlTo': 'https://api.thumbalizr.com/?url=https://github.com/junegunn/vim-plug&width=250&api_key=5VmUR42gc4eGdLjBnZH2BRXa'
      'author': 'cqWYJrZCGeWoPc68T'
      'createdAt': 1487172207151
      'title': 'https://github.com/junegunn/vim-plug'
    'http%3A%2F%2Flocalhost%3A3000%2Fabout%3FBookmarked%3Dtrue%26content%3D%26to%3Dhttps%253A%252F%252Fwww%2Efacebook%2Ecom%252Fapp_scoped_user_id%252F10154232419354595%252F%26from%3DBookmarks': 'Elias Moosman':
      'from': 'http%3A%2F%2Flocalhost%3A3000%2Fabout%3FBookmarked%3Dtrue%26content%3D%26to%3Dhttps%253A%252F%252Fwww%2Efacebook%2Ecom%252Fapp_scoped_user_id%252F10154232419354595%252F%26from%3DBookmarks'
      'to': 'https%3A%2F%2Fgithub%2Ecom%2Fjunegunn%2Fvim-plug'
      'meta':
        'body': ''
        'weight': 8
        'title': 'https://github.com/junegunn/vim-plug'
        'face': 'http://graph.facebook.com/v2.7/10154232419354595/picture?type=square'
        'profileLink': 'https://www.facebook.com/app_scoped_user_id/10154232419354595/'
        'FromLink': 'http://localhost:3000/about?Bookmarked=true&content=&to=https%3A%2F%2Fwww.facebook.com%2Fapp_scoped_user_id%2F10154232419354595%2F&from=Bookmarks'
        'ToLink': 'https://github.com/junegunn/vim-plug'
        'ScreenshotUrl': 'https://api.thumbalizr.com/?url=http://localhost:3000/about?Bookmarked=true&content=&to=https%3A%2F%2Fwww.facebook.com%2Fapp_scoped_user_id%2F10154232419354595%2F&from=Bookmarks&width=250&api_key=5VmUR42gc4eGdLjBnZH2BRXa'
        'ScreenshotUrlTo': 'https://api.thumbalizr.com/?url=https://github.com/junegunn/vim-plug&width=250&api_key=5VmUR42gc4eGdLjBnZH2BRXa'
      'author': 'cqWYJrZCGeWoPc68T'
      'createdAt': 1487172709833
      'title': 'https://github.com/junegunn/vim-plug'
    'http%3A%2F%2Flocalhost%3A3000%2Fabout%3FBookmarked%3Dtrue%26content%3D%26to%3Dhttps%253A%252F%252Fwww%2Efacebook%2Ecom%252Fapp_scoped_user_id%252F10154232419354595%252F%26from%3Dhttp%253A%252F%252Fwww%2Ematerial-ui%2Ecom%252Fv0%2E15%2E0-alpha%2E2%252F%2523%252F': 'Elias Moosman':
      'from': 'http%3A%2F%2Flocalhost%3A3000%2Fabout%3FBookmarked%3Dtrue%26content%3D%26to%3Dhttps%253A%252F%252Fwww%2Efacebook%2Ecom%252Fapp_scoped_user_id%252F10154232419354595%252F%26from%3Dhttp%253A%252F%252Fwww%2Ematerial-ui%2Ecom%252Fv0%2E15%2E0-alpha%2E2%252F%2523%252F'
      'to': 'https%3A%2F%2Fgithub%2Ecom%2Fjunegunn%2Fvim-plug'
      'meta':
        'body': 'asdaf'
        'weight': 9
        'title': 'https://github.com/junegunn/vim-plug'
        'face': 'http://graph.facebook.com/v2.7/10154232419354595/picture?type=square'
        'profileLink': 'https://www.facebook.com/app_scoped_user_id/10154232419354595/'
        'FromLink': 'http://localhost:3000/about?Bookmarked=true&content=&to=https%3A%2F%2Fwww.facebook.com%2Fapp_scoped_user_id%2F10154232419354595%2F&from=http%3A%2F%2Fwww.material-ui.com%2Fv0.15.0-alpha.2%2F%23%2F'
        'ToLink': 'https://github.com/junegunn/vim-plug'
        'ScreenshotUrl': 'https://api.thumbalizr.com/?url=http://localhost:3000/about?Bookmarked=true&content=&to=https%3A%2F%2Fwww.facebook.com%2Fapp_scoped_user_id%2F10154232419354595%2F&from=http%3A%2F%2Fwww.material-ui.com%2Fv0.15.0-alpha.2%2F%23%2F&width=250&api_key=5VmUR42gc4eGdLjBnZH2BRXa'
        'ScreenshotUrlTo': 'https://api.thumbalizr.com/?url=https://github.com/junegunn/vim-plug&width=250&api_key=5VmUR42gc4eGdLjBnZH2BRXa'
      'author': 'cqWYJrZCGeWoPc68T'
      'createdAt': 1487172726166
      'title': 'https://github.com/junegunn/vim-plug'
    'https%3A%2F%2Fgithub%2Ecom%2Fjunegunn%2Ffzf': 'Elias Moosman':
      'from': 'https%3A%2F%2Fgithub%2Ecom%2Fjunegunn%2Ffzf'
      'to': 'https%3A%2F%2Fgithub%2Ecom%2Fjunegunn%2Fvim-plug'
      'meta':
        'body': 'asdasdasd'
        'weight': 2
        'title': 'https://github.com/junegunn/vim-plug'
        'face': 'http://graph.facebook.com/v2.7/10154232419354595/picture?type=square'
        'profileLink': 'https://www.facebook.com/app_scoped_user_id/10154232419354595/'
        'FromLink': 'https://github.com/junegunn/fzf'
        'ToLink': 'https://github.com/junegunn/vim-plug'
        'ScreenshotUrl': 'https://api.thumbalizr.com/?url=https://github.com/junegunn/fzf&width=250&api_key=5VmUR42gc4eGdLjBnZH2BRXa'
        'ScreenshotUrlTo': 'https://api.thumbalizr.com/?url=https://github.com/junegunn/vim-plug&width=250&api_key=5VmUR42gc4eGdLjBnZH2BRXa'
      'author': 'cqWYJrZCGeWoPc68T'
      'createdAt': 1487424357010
      'title': 'https://github.com/junegunn/vim-plug'
    'http%3A%2F%2Fwww%2Ematerial-ui%2Ecom%2Fv0%2E15%2E0-alpha%2E2%2F%23%2Fcomponents%2Ftoolbar': 'Elias Moosman':
      'from': 'http%3A%2F%2Fwww%2Ematerial-ui%2Ecom%2Fv0%2E15%2E0-alpha%2E2%2F%23%2Fcomponents%2Ftoolbar'
      'to': 'https%3A%2F%2Fgithub%2Ecom%2Fjunegunn%2Fvim-plug'
      'meta':
        'body': 'in from j'
        'weight': 7
        'title': 'https://github.com/junegunn/vim-plug'
        'face': 'http://graph.facebook.com/v2.7/10154232419354595/picture?type=square'
        'profileLink': 'https://www.facebook.com/app_scoped_user_id/10154232419354595/'
        'FromLink': 'http://www.material-ui.com/v0.15.0-alpha.2/#/components/toolbar'
        'ToLink': 'https://github.com/junegunn/vim-plug'
        'ScreenshotUrl': 'https://api.thumbalizr.com/?url=http://www.material-ui.com/v0.15.0-alpha.2/#/components/toolbar&width=250&api_key=5VmUR42gc4eGdLjBnZH2BRXa'
        'ScreenshotUrlTo': 'https://api.thumbalizr.com/?url=https://github.com/junegunn/vim-plug&width=250&api_key=5VmUR42gc4eGdLjBnZH2BRXa'
      'author': 'cqWYJrZCGeWoPc68T'
      'createdAt': 1488001354915
      'title': 'https://github.com/junegunn/vim-plug'
cNode =
  '_id': 'Bookmarks'
  'links':
    'in':
      'Bookmarks': 'Elias Moosman':
        'from': 'Bookmarks'
        'to': 'Bookmarks'
        'meta':
          'title': 'Bookmarks'
          'weight': 9
          'face': 'http://graph.facebook.com/v2.7/10154232419354595/picture?type=square'
          'profileLink': 'https://www.facebook.com/app_scoped_user_id/10154232419354595/'
          'FromLink': 'Bookmarks'
          'ToLink': 'Bookmarks'
          'ScreenshotUrl': 'https://api.thumbalizr.com/?url=Bookmarks&width=250&api_key=UQ6CMod6tIkVLam271a7WdUlutEJJHTE'
          'ScreenshotUrlTo': 'https://api.thumbalizr.com/?url=Bookmarks&width=250&api_key=UQ6CMod6tIkVLam271a7WdUlutEJJHTE'
        'author': 'S54FphiBzL3KueFF4'
        'createdAt': 1515650468881
        'title': 'Bookmarks'
      'https%3A%2F%2Fwww%2Efacebook%2Ecom%2Fapp_scoped_user_id%2F10154232419354595%2F': 'Elias Moosman':
        'from': 'Bookmarks'
        'to': 'https%3A%2F%2Fwww%2Efacebook%2Ecom%2Fapp_scoped_user_id%2F10154232419354595%2F'
        'meta':
          'body': 'hahah'
          'weight': 4
          'title': 'https://www.facebook.com/app_scoped_user_id/10154232419354595/'
          'face': 'http://graph.facebook.com/v2.7/10154232419354595/picture?type=square'
          'profileLink': 'https://www.facebook.com/app_scoped_user_id/10154232419354595/'
          'FromLink': 'Bookmarks'
          'ToLink': 'https://www.facebook.com/app_scoped_user_id/10154232419354595/'
          'ScreenshotUrl': 'https://api.thumbalizr.com/?url=Bookmarks&width=250&api_key=UQ6CMod6tIkVLam271a7WdUlutEJJHTE'
          'ScreenshotUrlTo': 'https://api.thumbalizr.com/?url=https://www.facebook.com/app_scoped_user_id/10154232419354595/&width=250&api_key=UQ6CMod6tIkVLam271a7WdUlutEJJHTE'
        'author': 'S54FphiBzL3KueFF4'
        'createdAt': 1515650260192
        'title': 'https://www.facebook.com/app_scoped_user_id/10154232419354595/'
    'out':
      'Bookmarks': 'Elias Moosman':
        'from': 'Bookmarks'
        'to': 'Bookmarks'
        'meta':
          'title': 'Bookmarks - and other placeholders'
          'weight': 9
          'ScreenshotUrl': 'https://api.urlbox.io/v1/FLMG5BM3XeqMGa42/f9ef8e3b40885a6acde8c71ffdac6aac3365525e/png?url=Bookmarks&thumb_width=320&quality=80'
          'face': 'http://graph.facebook.com/v2.7/10154232419354595/picture?type=square'
          'profileLink': 'https://www.facebook.com/app_scoped_user_id/10154232419354595/'
          'FromLink': 'Bookmarks'
          'ToLink': 'Bookmarks'
          'ScreenshotUrlTo': 'https://api.urlbox.io/v1/FLMG5BM3XeqMGa42/f9ef8e3b40885a6acde8c71ffdac6aac3365525e/png?url=Bookmarks&thumb_width=320&quality=80'
        'author': 'S54FphiBzL3KueFF4'
        'createdAt': 1515676077506
        'title': 'Bookmarks - and other placeholders'
      'Linkstate%2Eyouiest%2Ecom': 'Elias Moosman':
        'from': 'Linkstate%2Eyouiest%2Ecom'
        'to': 'Bookmarks'
        'meta':
          'title': 'Linkstate - Connecting is seeing'
          'weight': 7
          'face': 'http://graph.facebook.com/v2.7/10154232419354595/picture?type=square'
          'profileLink': 'https://www.facebook.com/app_scoped_user_id/10154232419354595/'
          'FromLink': 'Linkstate.youiest.com'
          'ToLink': 'Bookmarks'
          'ScreenshotUrl': 'https://api.urlbox.io/v1/FLMG5BM3XeqMGa42/117475d1c2f4d6fac7710dcc2f841e06b46e06b3/png?url=Linkstate.youiest.com&thumb_width=320&quality=80'
          'ScreenshotUrlTo': 'https://api.urlbox.io/v1/FLMG5BM3XeqMGa42/f9ef8e3b40885a6acde8c71ffdac6aac3365525e/png?url=Bookmarks&thumb_width=320&quality=80'
        'author': 'S54FphiBzL3KueFF4'
        'createdAt': 1515676077565
        'title': 'Linkstate - Connecting is seeing'
      'https%3A%2F%2Fwww%2Efacebook%2Ecom%2Fapp_scoped_user_id%2F10154232419354595%2F': 'Elias Moosman':
        'from': 'https%3A%2F%2Fwww%2Efacebook%2Ecom%2Fapp_scoped_user_id%2F10154232419354595%2F'
        'to': 'Bookmarks'
        'meta':
          'title': 'Elias Moosman on Facebook'
          'weight': 7
          'face': 'http://graph.facebook.com/v2.7/10154232419354595/picture?type=square'
          'profileLink': 'https://www.facebook.com/app_scoped_user_id/10154232419354595/'
          'FromLink': 'https://www.facebook.com/app_scoped_user_id/10154232419354595/'
          'ToLink': 'Bookmarks'
          'ScreenshotUrl': 'https://api.urlbox.io/v1/FLMG5BM3XeqMGa42/9b1a5f128cbac84d2142d3377200235906e5a39e/png?url=https%3A%2F%2Fwww.facebook.com%2Fapp_scoped_user_id%2F10154232419354595%2F&thumb_width=320&quality=80'
          'ScreenshotUrlTo': 'https://api.urlbox.io/v1/FLMG5BM3XeqMGa42/f9ef8e3b40885a6acde8c71ffdac6aac3365525e/png?url=Bookmarks&thumb_width=320&quality=80'
        'author': 'S54FphiBzL3KueFF4'
        'createdAt': 1515676077702
        'title': 'Elias Moosman on Facebook'
      'http%3A%2F%2Flocalhost%3A3000%2Fabout%3Ffrom%3Dhttps%25253A%25252F%25252Fwww%2Efacebook%2Ecom%25252Fapp_scoped_user_id%25252F10154232419354595%25252F%26lastTitle%3DIcon%252520Button%252520-%252520Material-UI%26to%3DBookmarks%26Bookmarked%3Dtrue%26content%3Dhahah%26switched%3D': 'Elias Moosman':
        'from': 'http%3A%2F%2Flocalhost%3A3000%2Fabout%3Ffrom%3Dhttps%25253A%25252F%25252Fwww%2Efacebook%2Ecom%25252Fapp_scoped_user_id%25252F10154232419354595%25252F%26lastTitle%3DIcon%252520Button%252520-%252520Material-UI%26to%3DBookmarks%26Bookmarked%3Dtrue%26content%3Dhahah%26switched%3D'
        'to': 'Bookmarks'
        'meta':
          'weight': 5
          'title': 'Linkstates for Elias Moosman on Facebook - https://www.facebook.com/app_scoped_user_id/10154232419354595/'
          'face': 'http://graph.facebook.com/v2.7/10154232419354595/picture?type=square'
          'profileLink': 'https://www.facebook.com/app_scoped_user_id/10154232419354595/'
          'FromLink': 'http://localhost:3000/about?from=https%253A%252F%252Fwww.facebook.com%252Fapp_scoped_user_id%252F10154232419354595%252F&lastTitle=Icon%2520Button%2520-%2520Material-UI&to=Bookmarks&Bookmarked=true&content=hahah&switched='
          'ToLink': 'Bookmarks'
          'ScreenshotUrl': 'https://api.thumbalizr.com/?url=http://localhost:3000/about?from=https%253A%252F%252Fwww.facebook.com%252Fapp_scoped_user_id%252F10154232419354595%252F&lastTitle=Icon%2520Button%2520-%2520Material-UI&to=Bookmarks&Bookmarked=true&content=hahah&switched=&width=250&api_key=UQ6CMod6tIkVLam271a7WdUlutEJJHTE'
          'ScreenshotUrlTo': 'https://api.thumbalizr.com/?url=Bookmarks&width=250&api_key=UQ6CMod6tIkVLam271a7WdUlutEJJHTE'
        'author': 'S54FphiBzL3KueFF4'
        'createdAt': 1515650383851
        'title': 'Linkstates for Elias Moosman on Facebook - https://www.facebook.com/app_scoped_user_id/10154232419354595/'
      'https%3A%2F%2Fstackoverflow%2Ecom%2Fquestions%2F9529078%2Fhow-do-i-use-git-reset-hard-head-to-revert-to-a-previous-commit': 'Elias Moosman':
        'from': 'https%3A%2F%2Fstackoverflow%2Ecom%2Fquestions%2F9529078%2Fhow-do-i-use-git-reset-hard-head-to-revert-to-a-previous-commit'
        'to': 'Bookmarks'
        'meta':
          'weight': 5
          'title': 'How do I use \'git reset --hard HEAD\' to revert to a previous commit? - Stack Overflow'
          'face': 'http://graph.facebook.com/v2.7/10154232419354595/picture?type=square'
          'profileLink': 'https://www.facebook.com/app_scoped_user_id/10154232419354595/'
          'FromLink': 'https://stackoverflow.com/questions/9529078/how-do-i-use-git-reset-hard-head-to-revert-to-a-previous-commit'
          'ToLink': 'Bookmarks'
          'ScreenshotUrl': 'https://api.thumbalizr.com/?url=https://stackoverflow.com/questions/9529078/how-do-i-use-git-reset-hard-head-to-revert-to-a-previous-commit&width=250&api_key=UQ6CMod6tIkVLam271a7WdUlutEJJHTE'
          'ScreenshotUrlTo': 'https://api.thumbalizr.com/?url=Bookmarks&width=250&api_key=UQ6CMod6tIkVLam271a7WdUlutEJJHTE'
        'author': 'S54FphiBzL3KueFF4'
        'createdAt': 1515650480814
        'title': 'How do I use \'git reset --hard HEAD\' to revert to a previous commit? - Stack Overflow'
      'http%3A%2F%2Flocalhost%3A3000%2Fabout%3Ffrom%3DLinkstate%2Eyouiest%2Ecom%26lastTitle%3DIcon%252520Button%252520-%252520Material-UI%26to%3DBookmarks%26Bookmarked%3Dtrue%26content%3D%26switched%3D': 'Elias Moosman':
        'from': 'http%3A%2F%2Flocalhost%3A3000%2Fabout%3Ffrom%3DLinkstate%2Eyouiest%2Ecom%26lastTitle%3DIcon%252520Button%252520-%252520Material-UI%26to%3DBookmarks%26Bookmarked%3Dtrue%26content%3D%26switched%3D'
        'to': 'Bookmarks'
        'meta':
          'weight': 5
          'title': 'Linkstates for Linkstate - Connecting is seeing - Linkstate.youiest.com'
          'face': 'http://graph.facebook.com/v2.7/10154232419354595/picture?type=square'
          'profileLink': 'https://www.facebook.com/app_scoped_user_id/10154232419354595/'
          'FromLink': 'http://localhost:3000/about?from=Linkstate.youiest.com&lastTitle=Icon%2520Button%2520-%2520Material-UI&to=Bookmarks&Bookmarked=true&content=&switched='
          'ToLink': 'Bookmarks'
          'ScreenshotUrl': 'https://api.urlbox.io/v1/FLMG5BM3XeqMGa42/2a97329fccd9bea5497d209c411e6a54bbd03f76/png?url=http%3A%2F%2Flocalhost%3A3000%2Fabout%3Ffrom%3DLinkstate.youiest.com%26lastTitle%3DIcon%252520Button%252520-%252520Material-UI%26to%3DBookmarks%26Bookmarked%3Dtrue%26content%3D%26switched%3D&thumb_width=320&quality=80'
          'ScreenshotUrlTo': 'https://api.urlbox.io/v1/FLMG5BM3XeqMGa42/f9ef8e3b40885a6acde8c71ffdac6aac3365525e/png?url=Bookmarks&thumb_width=320&quality=80'
        'author': 'S54FphiBzL3KueFF4'
        'createdAt': 1515650897280
        'title': 'Linkstates for Linkstate - Connecting is seeing - Linkstate.youiest.com'
  'title': 'Elias Moosman on Facebook'
props =
  'from': 'Bookmarks'
  'to': 'https://www.facebook.com/app_scoped_user_id/10154232419354595/'
  'lastTitle': 'Icon Button - Material-UI'
  'user':
    '_id': 'S54FphiBzL3KueFF4'
    'profile': 'name': 'Elias Moosman'
    'createdAt': '2018-01-11T05:57:30.482Z'
    'services':
      'facebook':
        'expiresAt': 1520753914953
        'id': '10154232419354595'
        'email': 'eliasmoosman@gmail.com'
        'name': 'Elias Moosman'
        'first_name': 'Elias'
        'last_name': 'Moosman'
        'link': 'https://www.facebook.com/app_scoped_user_id/10154232419354595/'
        'gender': 'male'
        'locale': 'sv_SE'
        'age_range': 'min': 21
      'thumbalizr': null
    'edited': 1517192719821
    'links':
      'in':
        'Bookmarks':
          'Bookmarks':
            'from': 'Bookmarks'
            'to': 'Bookmarks'
            'meta':
              'title': 'Bookmarks - and other placeholders'
              'weight': 9
              'ScreenshotUrl': 'https://api.urlbox.io/v1/FLMG5BM3XeqMGa42/f9ef8e3b40885a6acde8c71ffdac6aac3365525e/png?url=Bookmarks&thumb_width=320&quality=80'
              'face': 'http://graph.facebook.com/v2.7/10154232419354595/picture?type=square'
              'profileLink': 'https://www.facebook.com/app_scoped_user_id/10154232419354595/'
              'FromLink': 'Bookmarks'
              'ToLink': 'Bookmarks'
              'ScreenshotUrlTo': 'https://api.urlbox.io/v1/FLMG5BM3XeqMGa42/f9ef8e3b40885a6acde8c71ffdac6aac3365525e/png?url=Bookmarks&thumb_width=320&quality=80'
            'author': 'S54FphiBzL3KueFF4'
            'createdAt': 1516799499053
            'title': 'Bookmarks - and other placeholders'
          'https%3A%2F%2Fwww%2Efacebook%2Ecom%2Fapp_scoped_user_id%2F10154232419354595%2F':
            'from': 'https%3A%2F%2Fwww%2Efacebook%2Ecom%2Fapp_scoped_user_id%2F10154232419354595%2F'
            'to': 'Bookmarks'
            'meta':
              'body': 'ghfd'
              'weight': 6
              'title': 'Elias Moosman on Facebook'
              'face': 'http://graph.facebook.com/v2.7/10154232419354595/picture?type=square'
              'profileLink': 'https://www.facebook.com/app_scoped_user_id/10154232419354595/'
              'FromLink': 'https://www.facebook.com/app_scoped_user_id/10154232419354595/'
              'ToLink': 'Bookmarks'
              'ScreenshotUrl': 'https://api.urlbox.io/v1/FLMG5BM3XeqMGa42/9b1a5f128cbac84d2142d3377200235906e5a39e/png?url=https%3A%2F%2Fwww.facebook.com%2Fapp_scoped_user_id%2F10154232419354595%2F&thumb_width=320&quality=80'
              'ScreenshotUrlTo': 'https://api.urlbox.io/v1/FLMG5BM3XeqMGa42/f9ef8e3b40885a6acde8c71ffdac6aac3365525e/png?url=Bookmarks&thumb_width=320&quality=80'
            'author': 'S54FphiBzL3KueFF4'
            'createdAt': 1516799737036
            'title': 'Elias Moosman on Facebook'
          'Linkstate%2Eyouiest%2Ecom':
            'from': 'Linkstate%2Eyouiest%2Ecom'
            'to': 'Bookmarks'
            'meta':
              'title': 'Linkstate - Connecting is seeing'
              'weight': 7
              'face': 'http://graph.facebook.com/v2.7/10154232419354595/picture?type=square'
              'profileLink': 'https://www.facebook.com/app_scoped_user_id/10154232419354595/'
              'FromLink': 'Linkstate.youiest.com'
              'ToLink': 'Bookmarks'
              'ScreenshotUrl': 'https://api.urlbox.io/v1/FLMG5BM3XeqMGa42/117475d1c2f4d6fac7710dcc2f841e06b46e06b3/png?url=Linkstate.youiest.com&thumb_width=320&quality=80'
              'ScreenshotUrlTo': 'https://api.urlbox.io/v1/FLMG5BM3XeqMGa42/f9ef8e3b40885a6acde8c71ffdac6aac3365525e/png?url=Bookmarks&thumb_width=320&quality=80'
            'author': 'S54FphiBzL3KueFF4'
            'createdAt': 1515745036583
            'title': 'Linkstate - Connecting is seeing'
          'http%3A%2F%2Flocalhost%3A3000%2Fabout%3Ffrom%3DLinkstate%2Eyouiest%2Ecom%26lastTitle%3DIcon%252520Button%252520-%252520Material-UI%26to%3DBookmarks%26Bookmarked%3Dtrue%26content%3D%26switched%3D':
            'from': 'http%3A%2F%2Flocalhost%3A3000%2Fabout%3Ffrom%3DLinkstate%2Eyouiest%2Ecom%26lastTitle%3DIcon%252520Button%252520-%252520Material-UI%26to%3DBookmarks%26Bookmarked%3Dtrue%26content%3D%26switched%3D'
            'to': 'Bookmarks'
            'meta':
              'weight': 5
              'title': 'Linkstates for Linkstate - Connecting is seeing - Linkstate.youiest.com'
              'face': 'http://graph.facebook.com/v2.7/10154232419354595/picture?type=square'
              'profileLink': 'https://www.facebook.com/app_scoped_user_id/10154232419354595/'
              'FromLink': 'http://localhost:3000/about?from=Linkstate.youiest.com&lastTitle=Icon%2520Button%2520-%2520Material-UI&to=Bookmarks&Bookmarked=true&content=&switched='
              'ToLink': 'Bookmarks'
              'ScreenshotUrl': 'https://api.urlbox.io/v1/FLMG5BM3XeqMGa42/2a97329fccd9bea5497d209c411e6a54bbd03f76/png?url=http%3A%2F%2Flocalhost%3A3000%2Fabout%3Ffrom%3DLinkstate.youiest.com%26lastTitle%3DIcon%252520Button%252520-%252520Material-UI%26to%3DBookmarks%26Bookmarked%3Dtrue%26content%3D%26switched%3D&thumb_width=320&quality=80'
              'ScreenshotUrlTo': 'https://api.urlbox.io/v1/FLMG5BM3XeqMGa42/f9ef8e3b40885a6acde8c71ffdac6aac3365525e/png?url=Bookmarks&thumb_width=320&quality=80'
            'author': 'S54FphiBzL3KueFF4'
            'createdAt': 1515650897280
            'title': 'Linkstates for Linkstate - Connecting is seeing - Linkstate.youiest.com'
          'https%3A%2F%2Fwww%2Efacebook%2Ecom%2FvViber%3Flst%3D532514594%253A532514594%253A1514878343':
            'from': 'https%3A%2F%2Fwww%2Efacebook%2Ecom%2FvViber%3Flst%3D532514594%253A532514594%253A1514878343'
            'to': 'Bookmarks'
            'meta':
              'weight': 5
              'title': '(2) Elias Moosman'
              'face': 'http://graph.facebook.com/v2.7/10154232419354595/picture?type=square'
              'profileLink': 'https://www.facebook.com/app_scoped_user_id/10154232419354595/'
              'FromLink': 'https://www.facebook.com/vViber?lst=532514594%3A532514594%3A1514878343'
              'ToLink': 'Bookmarks'
              'ScreenshotUrl': 'https://api.urlbox.io/v1/FLMG5BM3XeqMGa42/7f5979875238b6c4bc73ccfc7f6ec691414e8c8a/png?url=https%3A%2F%2Fwww.facebook.com%2FvViber%3Flst%3D532514594%253A532514594%253A1514878343&thumb_width=320&quality=80'
              'ScreenshotUrlTo': 'https://api.urlbox.io/v1/FLMG5BM3XeqMGa42/f9ef8e3b40885a6acde8c71ffdac6aac3365525e/png?url=Bookmarks&thumb_width=320&quality=80'
            'author': 'S54FphiBzL3KueFF4'
            'createdAt': 1515728165362
            'title': '(2) Elias Moosman'
          'http%3A%2F%2Flocalhost%3A3000%2Fabout%3Ffrom%3DLinkstate%2Eyouiest%2Ecom%26lastTitle%3DIcon%252520Button%252520-%252520Material-UI%26to%3DLinkstate%2Eyouiest%2Ecom%26Bookmarked%3Dtrue%26content%3D%26switched%3D':
            'from': 'http%3A%2F%2Flocalhost%3A3000%2Fabout%3Ffrom%3DLinkstate%2Eyouiest%2Ecom%26lastTitle%3DIcon%252520Button%252520-%252520Material-UI%26to%3DLinkstate%2Eyouiest%2Ecom%26Bookmarked%3Dtrue%26content%3D%26switched%3D'
            'to': 'Bookmarks'
            'meta':
              'weight': 5
              'title': 'Linkstates for Linkstate - Connecting is seeing - Linkstate.youiest.com'
              'face': 'http://graph.facebook.com/v2.7/10154232419354595/picture?type=square'
              'profileLink': 'https://www.facebook.com/app_scoped_user_id/10154232419354595/'
              'FromLink': 'http://localhost:3000/about?from=Linkstate.youiest.com&lastTitle=Icon%2520Button%2520-%2520Material-UI&to=Linkstate.youiest.com&Bookmarked=true&content=&switched='
              'ToLink': 'Bookmarks'
              'ScreenshotUrl': 'https://api.urlbox.io/v1/FLMG5BM3XeqMGa42/7e9eca309d75b57045a48ca0cda20fa74c9c66b0/png?url=http%3A%2F%2Flocalhost%3A3000%2Fabout%3Ffrom%3DLinkstate.youiest.com%26lastTitle%3DIcon%252520Button%252520-%252520Material-UI%26to%3DLinkstate.youiest.com%26Bookmarked%3Dtrue%26content%3D%26switched%3D&thumb_width=320&quality=80'
              'ScreenshotUrlTo': 'https://api.urlbox.io/v1/FLMG5BM3XeqMGa42/f9ef8e3b40885a6acde8c71ffdac6aac3365525e/png?url=Bookmarks&thumb_width=320&quality=80'
            'author': 'S54FphiBzL3KueFF4'
            'createdAt': 1515728156303
            'title': 'Linkstates for Linkstate - Connecting is seeing - Linkstate.youiest.com'
          'Linkstate%2Eyouiest%2Ecom%2Fabout':
            'from': 'Linkstate%2Eyouiest%2Ecom%2Fabout'
            'to': 'Bookmarks'
            'meta':
              'title': 'Linkstate - Connecting is seeing'
              'weight': 7
              'face': 'http://graph.facebook.com/v2.7/10154232419354595/picture?type=square'
              'profileLink': 'https://www.facebook.com/app_scoped_user_id/10154232419354595/'
              'FromLink': 'Linkstate.youiest.com/about'
              'ToLink': 'Bookmarks'
              'ScreenshotUrl': 'https://api.urlbox.io/v1/FLMG5BM3XeqMGa42/7c81ff8950b76e157e44b1a70cfb81532f9a170c/png?url=Linkstate.youiest.com%2Fabout&thumb_width=320&quality=80'
              'ScreenshotUrlTo': 'https://api.urlbox.io/v1/FLMG5BM3XeqMGa42/f9ef8e3b40885a6acde8c71ffdac6aac3365525e/png?url=Bookmarks&thumb_width=320&quality=80'
            'author': 'S54FphiBzL3KueFF4'
            'createdAt': 1516799499853
            'title': 'Linkstate - Connecting is seeing'
          'https%3A%2F%2Flinkstate%2Eyouiest%2Ecom%2Fabout%3Ffrom%3DBookmarks%26lastTitle%3DGrid%252520List%252520-%252520Material-UI%26Bookmarked%3Dtrue%26to%3Dhttps%25253A%25252F%25252Fmopinion%2Ecom%25252Ftop-10-website-annotation-tools%25252F%26content%3D%26switched%3D':
            'from': 'https%3A%2F%2Flinkstate%2Eyouiest%2Ecom%2Fabout%3Ffrom%3DBookmarks%26lastTitle%3DGrid%252520List%252520-%252520Material-UI%26Bookmarked%3Dtrue%26to%3Dhttps%25253A%25252F%25252Fmopinion%2Ecom%25252Ftop-10-website-annotation-tools%25252F%26content%3D%26switched%3D'
            'to': 'Bookmarks'
            'meta':
              'weight': 5
              'title': 'Linkstates for Bookmarks - and other placeholders - Bookmarks'
              'face': 'http://graph.facebook.com/v2.7/10154232419354595/picture?type=square'
              'profileLink': 'https://www.facebook.com/app_scoped_user_id/10154232419354595/'
              'FromLink': 'https://linkstate.youiest.com/about?from=Bookmarks&lastTitle=Grid%2520List%2520-%2520Material-UI&Bookmarked=true&to=https%253A%252F%252Fmopinion.com%252Ftop-10-website-annotation-tools%252F&content=&switched='
              'ToLink': 'Bookmarks'
              'ScreenshotUrl': 'https://api.urlbox.io/v1/FLMG5BM3XeqMGa42/891c9105bb40fedaf3946178f7ee21f0cf25cb54/png?url=https%3A%2F%2Flinkstate.youiest.com%2Fabout%3Ffrom%3DBookmarks%26lastTitle%3DGrid%252520List%252520-%252520Material-UI%26Bookmarked%3Dtrue%26to%3Dhttps%25253A%25252F%25252Fmopinion.com%25252Ftop-10-website-annotation-tools%25252F%26content%3D%26switched%3D&thumb_width=320&quality=80'
              'ScreenshotUrlTo': 'https://api.urlbox.io/v1/FLMG5BM3XeqMGa42/f9ef8e3b40885a6acde8c71ffdac6aac3365525e/png?url=Bookmarks&thumb_width=320&quality=80'
            'author': 'S54FphiBzL3KueFF4'
            'createdAt': 1515750433476
            'title': 'Linkstates for Bookmarks - and other placeholders - Bookmarks'
          'https%3A%2F%2Fdevelopers%2Efacebook%2Ecom%2Fproducts%2Fsocial-plugins%2Fcomments%2F%3Futm_campaign%3Dsocial_plugins%26utm_medium%3Doffsite_pages%26utm_source%3Dcomments_plugin':
            'from': 'https%3A%2F%2Fdevelopers%2Efacebook%2Ecom%2Fproducts%2Fsocial-plugins%2Fcomments%2F%3Futm_campaign%3Dsocial_plugins%26utm_medium%3Doffsite_pages%26utm_source%3Dcomments_plugin'
            'to': 'Bookmarks'
            'meta':
              'weight': 5
              'title': 'Comments - Facebook for Developers'
              'face': 'http://graph.facebook.com/v2.7/10154232419354595/picture?type=square'
              'profileLink': 'https://www.facebook.com/app_scoped_user_id/10154232419354595/'
              'FromLink': 'https://developers.facebook.com/products/social-plugins/comments/?utm_campaign=social_plugins&utm_medium=offsite_pages&utm_source=comments_plugin'
              'ToLink': 'Bookmarks'
              'ScreenshotUrl': 'https://api.urlbox.io/v1/FLMG5BM3XeqMGa42/07d8c5a90f1c223ccd0f83a8637374368bb68178/png?url=https%3A%2F%2Fdevelopers.facebook.com%2Fproducts%2Fsocial-plugins%2Fcomments%2F%3Futm_campaign%3Dsocial_plugins%26utm_medium%3Doffsite_pages%26utm_source%3Dcomments_plugin&thumb_width=320&quality=80'
              'ScreenshotUrlTo': 'https://api.urlbox.io/v1/FLMG5BM3XeqMGa42/f9ef8e3b40885a6acde8c71ffdac6aac3365525e/png?url=Bookmarks&thumb_width=320&quality=80'
            'author': 'S54FphiBzL3KueFF4'
            'createdAt': 1515893775950
            'title': 'Comments - Facebook for Developers'
          'http%3A%2F%2Fwww%2Ematerial-ui%2Ecom%2Fv0%2E15%2E0%2F%23%2Fcomponents%2Ficon-button':
            'from': 'http%3A%2F%2Fwww%2Ematerial-ui%2Ecom%2Fv0%2E15%2E0%2F%23%2Fcomponents%2Ficon-button'
            'to': 'Bookmarks'
            'meta':
              'weight': 5
              'title': 'Icon Button - Material-UI'
              'face': 'http://graph.facebook.com/v2.7/10154232419354595/picture?type=square'
              'profileLink': 'https://www.facebook.com/app_scoped_user_id/10154232419354595/'
              'FromLink': 'http://www.material-ui.com/v0.15.0/#/components/icon-button'
              'ToLink': 'Bookmarks'
              'ScreenshotUrl': 'https://api.urlbox.io/v1/FLMG5BM3XeqMGa42/bc419c1ffae6d735068eb38564b861249f53af0f/png?url=http%3A%2F%2Fwww.material-ui.com%2Fv0.15.0%2F%23%2Fcomponents%2Ficon-button&thumb_width=320&quality=80'
              'ScreenshotUrlTo': 'https://api.urlbox.io/v1/FLMG5BM3XeqMGa42/f9ef8e3b40885a6acde8c71ffdac6aac3365525e/png?url=Bookmarks&thumb_width=320&quality=80'
            'author': 'S54FphiBzL3KueFF4'
            'createdAt': 1515752736619
            'title': 'Icon Button - Material-UI'
          'https%3A%2F%2Fwww%2Enpmjs%2Ecom%2Fpackage%2Fcopy-to-clipboard':
            'from': 'https%3A%2F%2Fwww%2Enpmjs%2Ecom%2Fpackage%2Fcopy-to-clipboard'
            'to': 'Bookmarks'
            'meta':
              'weight': 5
              'title': 'copy-to-clipboard'
              'face': 'http://graph.facebook.com/v2.7/10154232419354595/picture?type=square'
              'profileLink': 'https://www.facebook.com/app_scoped_user_id/10154232419354595/'
              'FromLink': 'https://www.npmjs.com/package/copy-to-clipboard'
              'ToLink': 'Bookmarks'
              'ScreenshotUrl': 'https://api.urlbox.io/v1/FLMG5BM3XeqMGa42/8be9bf072d4ca4620ea074275282f8e0acc74174/png?url=https%3A%2F%2Fwww.npmjs.com%2Fpackage%2Fcopy-to-clipboard&thumb_width=320&quality=80'
              'ScreenshotUrlTo': 'https://api.urlbox.io/v1/FLMG5BM3XeqMGa42/f9ef8e3b40885a6acde8c71ffdac6aac3365525e/png?url=Bookmarks&thumb_width=320&quality=80'
            'author': 'S54FphiBzL3KueFF4'
            'createdAt': 1515848424123
            'title': 'copy-to-clipboard'
          'http%3A%2F%2Fwww%2Ematerial-ui%2Ecom%2Fv0%2E15%2E0%2F%23%2Fcomponents%2Ffloating-action-button':
            'from': 'http%3A%2F%2Fwww%2Ematerial-ui%2Ecom%2Fv0%2E15%2E0%2F%23%2Fcomponents%2Ffloating-action-button'
            'to': 'Bookmarks'
            'meta':
              'weight': 5
              'title': 'Floating Action Button - Material-UI'
              'face': 'http://graph.facebook.com/v2.7/10154232419354595/picture?type=square'
              'profileLink': 'https://www.facebook.com/app_scoped_user_id/10154232419354595/'
              'FromLink': 'http://www.material-ui.com/v0.15.0/#/components/floating-action-button'
              'ToLink': 'Bookmarks'
              'ScreenshotUrl': 'https://api.urlbox.io/v1/FLMG5BM3XeqMGa42/da1d05c7c97b6a4f5473451ee8905aa7484401dd/png?url=http%3A%2F%2Fwww.material-ui.com%2Fv0.15.0%2F%23%2Fcomponents%2Ffloating-action-button&thumb_width=320&quality=80'
              'ScreenshotUrlTo': 'https://api.urlbox.io/v1/FLMG5BM3XeqMGa42/f9ef8e3b40885a6acde8c71ffdac6aac3365525e/png?url=Bookmarks&thumb_width=320&quality=80'
            'author': 'S54FphiBzL3KueFF4'
            'createdAt': 1515849481404
            'title': 'Floating Action Button - Material-UI'
          'https%3A%2F%2Furlbox%2Eio%2Fdashboard':
            'from': 'https%3A%2F%2Furlbox%2Eio%2Fdashboard'
            'to': 'Bookmarks'
            'meta':
              'weight': 5
              'title': 'User Dashboard | Urlbox'
              'face': 'http://graph.facebook.com/v2.7/10154232419354595/picture?type=square'
              'profileLink': 'https://www.facebook.com/app_scoped_user_id/10154232419354595/'
              'FromLink': 'https://urlbox.io/dashboard'
              'ToLink': 'Bookmarks'
              'ScreenshotUrl': 'https://api.urlbox.io/v1/FLMG5BM3XeqMGa42/470f97a39f9047b5aedc6918697e66578003b17c/png?url=https%3A%2F%2Furlbox.io%2Fdashboard&thumb_width=320&quality=80'
              'ScreenshotUrlTo': 'https://api.urlbox.io/v1/FLMG5BM3XeqMGa42/f9ef8e3b40885a6acde8c71ffdac6aac3365525e/png?url=Bookmarks&thumb_width=320&quality=80'
            'author': 'S54FphiBzL3KueFF4'
            'createdAt': 1515852668465
            'title': 'User Dashboard | Urlbox'
          'http%3A%2F%2Fwww%2Ematerial-ui%2Ecom%2Fv0%2E15%2E0%2F%23%2Fcomponents%2Fdivider':
            'from': 'http%3A%2F%2Fwww%2Ematerial-ui%2Ecom%2Fv0%2E15%2E0%2F%23%2Fcomponents%2Fdivider'
            'to': 'Bookmarks'
            'meta':
              'weight': 5
              'title': 'Material-UI'
              'face': 'http://graph.facebook.com/v2.7/10154232419354595/picture?type=square'
              'profileLink': 'https://www.facebook.com/app_scoped_user_id/10154232419354595/'
              'FromLink': 'http://www.material-ui.com/v0.15.0/#/components/divider'
              'ToLink': 'Bookmarks'
              'ScreenshotUrl': 'https://api.urlbox.io/v1/FLMG5BM3XeqMGa42/e01735992a16b0765be9dfff99a1e69c62c39d76/png?url=http%3A%2F%2Fwww.material-ui.com%2Fv0.15.0%2F%23%2Fcomponents%2Fdivider&thumb_width=320&quality=80'
              'ScreenshotUrlTo': 'https://api.urlbox.io/v1/FLMG5BM3XeqMGa42/f9ef8e3b40885a6acde8c71ffdac6aac3365525e/png?url=Bookmarks&thumb_width=320&quality=80'
            'author': 'S54FphiBzL3KueFF4'
            'createdAt': 1515893133244
            'title': 'Material-UI'
          'http%3A%2F%2Fwww%2Ematerial-ui%2Ecom%2Fv0%2E15%2E0%2F%23%2Fcomponents%2Fdrawer':
            'from': 'http%3A%2F%2Fwww%2Ematerial-ui%2Ecom%2Fv0%2E15%2E0%2F%23%2Fcomponents%2Fdrawer'
            'to': 'Bookmarks'
            'meta':
              'weight': 5
              'title': 'Drawer - Material-UI'
              'face': 'http://graph.facebook.com/v2.7/10154232419354595/picture?type=square'
              'profileLink': 'https://www.facebook.com/app_scoped_user_id/10154232419354595/'
              'FromLink': 'http://www.material-ui.com/v0.15.0/#/components/drawer'
              'ToLink': 'Bookmarks'
              'ScreenshotUrl': 'https://api.urlbox.io/v1/FLMG5BM3XeqMGa42/d99ca99ca087fe2a9d1b01035322b66bd9d3530d/png?url=http%3A%2F%2Fwww.material-ui.com%2Fv0.15.0%2F%23%2Fcomponents%2Fdrawer&thumb_width=320&quality=80'
              'ScreenshotUrlTo': 'https://api.urlbox.io/v1/FLMG5BM3XeqMGa42/f9ef8e3b40885a6acde8c71ffdac6aac3365525e/png?url=Bookmarks&thumb_width=320&quality=80'
            'author': 'S54FphiBzL3KueFF4'
            'createdAt': 1515896611045
            'title': 'Drawer - Material-UI'
          'http%3A%2F%2Fwww%2Ematerial-ui%2Ecom%2Fv0%2E15%2E0%2F%23%2Fcomponents%2Fcard':
            'from': 'http%3A%2F%2Fwww%2Ematerial-ui%2Ecom%2Fv0%2E15%2E0%2F%23%2Fcomponents%2Fcard'
            'to': 'Bookmarks'
            'meta':
              'weight': 5
              'title': 'Card - Material-UI'
              'face': 'http://graph.facebook.com/v2.7/10154232419354595/picture?type=square'
              'profileLink': 'https://www.facebook.com/app_scoped_user_id/10154232419354595/'
              'FromLink': 'http://www.material-ui.com/v0.15.0/#/components/card'
              'ToLink': 'Bookmarks'
              'ScreenshotUrl': 'https://api.urlbox.io/v1/FLMG5BM3XeqMGa42/3d5dae2cc3f8f78c54d0d14861cabdfaa6a219d1/png?url=http%3A%2F%2Fwww.material-ui.com%2Fv0.15.0%2F%23%2Fcomponents%2Fcard&thumb_width=320&quality=80'
              'ScreenshotUrlTo': 'https://api.urlbox.io/v1/FLMG5BM3XeqMGa42/f9ef8e3b40885a6acde8c71ffdac6aac3365525e/png?url=Bookmarks&thumb_width=320&quality=80'
            'author': 'S54FphiBzL3KueFF4'
            'createdAt': 1516602708478
            'title': 'Card - Material-UI'
          'http%3A%2F%2Fwww%2Ematerial-ui%2Ecom%2Fv0%2E15%2E0%2F%23%2Fcomponents%2Fgrid-list':
            'from': 'http%3A%2F%2Fwww%2Ematerial-ui%2Ecom%2Fv0%2E15%2E0%2F%23%2Fcomponents%2Fgrid-list'
            'to': 'Bookmarks'
            'meta':
              'weight': 5
              'title': 'Grid List - Material-UI'
              'face': 'http://graph.facebook.com/v2.7/10154232419354595/picture?type=square'
              'profileLink': 'https://www.facebook.com/app_scoped_user_id/10154232419354595/'
              'FromLink': 'http://www.material-ui.com/v0.15.0/#/components/grid-list'
              'ToLink': 'Bookmarks'
              'ScreenshotUrl': 'https://api.urlbox.io/v1/FLMG5BM3XeqMGa42/40553ece4a58fa64935a61307604420279d5a1db/png?url=http%3A%2F%2Fwww.material-ui.com%2Fv0.15.0%2F%23%2Fcomponents%2Fgrid-list&thumb_width=320&quality=80'
              'ScreenshotUrlTo': 'https://api.urlbox.io/v1/FLMG5BM3XeqMGa42/f9ef8e3b40885a6acde8c71ffdac6aac3365525e/png?url=Bookmarks&thumb_width=320&quality=80'
            'author': 'S54FphiBzL3KueFF4'
            'createdAt': 1516602730435
            'title': 'Grid List - Material-UI'
          'http%3A%2F%2Fwww%2Ematerial-ui%2Ecom%2Fv0%2E15%2E0%2F%23%2Fcomponents%2Ffont-icon':
            'from': 'http%3A%2F%2Fwww%2Ematerial-ui%2Ecom%2Fv0%2E15%2E0%2F%23%2Fcomponents%2Ffont-icon'
            'to': 'Bookmarks'
            'meta':
              'weight': 5
              'title': 'Font Icon - Material-UI'
              'face': 'http://graph.facebook.com/v2.7/10154232419354595/picture?type=square'
              'profileLink': 'https://www.facebook.com/app_scoped_user_id/10154232419354595/'
              'FromLink': 'http://www.material-ui.com/v0.15.0/#/components/font-icon'
              'ToLink': 'Bookmarks'
              'ScreenshotUrl': 'https://api.urlbox.io/v1/FLMG5BM3XeqMGa42/840d657b0c17ef752fc7a3a346c946823481644c/png?url=http%3A%2F%2Fwww.material-ui.com%2Fv0.15.0%2F%23%2Fcomponents%2Ffont-icon&thumb_width=320&quality=80'
              'ScreenshotUrlTo': 'https://api.urlbox.io/v1/FLMG5BM3XeqMGa42/f9ef8e3b40885a6acde8c71ffdac6aac3365525e/png?url=Bookmarks&thumb_width=320&quality=80'
            'author': 'S54FphiBzL3KueFF4'
            'createdAt': 1516799519649
            'title': 'Font Icon - Material-UI'
        'Linkstate%2Eyouiest%2Ecom': 'Bookmarks':
          'from': 'Bookmarks'
          'to': 'Linkstate%2Eyouiest%2Ecom'
          'meta':
            'body': 'hjkkwer'
            'weight': 4
            'title': 'Bookmarks - and other placeholders'
            'face': 'http://graph.facebook.com/v2.7/10154232419354595/picture?type=square'
            'profileLink': 'https://www.facebook.com/app_scoped_user_id/10154232419354595/'
            'FromLink': 'Bookmarks'
            'ToLink': 'Linkstate.youiest.com'
            'ScreenshotUrl': 'https://api.urlbox.io/v1/FLMG5BM3XeqMGa42/f9ef8e3b40885a6acde8c71ffdac6aac3365525e/png?url=Bookmarks&thumb_width=320&quality=80'
            'ScreenshotUrlTo': 'https://api.urlbox.io/v1/FLMG5BM3XeqMGa42/117475d1c2f4d6fac7710dcc2f841e06b46e06b3/png?url=Linkstate.youiest.com&thumb_width=320&quality=80'
          'author': 'S54FphiBzL3KueFF4'
          'createdAt': 1515675012528
          'title': 'Bookmarks - and other placeholders'
        'https%3A%2F%2Fwww%2Efacebook%2Ecom%2Fapp_scoped_user_id%2F10154232419354595%2F':
          'Bookmarks':
            'from': 'Bookmarks'
            'to': 'https%3A%2F%2Fwww%2Efacebook%2Ecom%2Fapp_scoped_user_id%2F10154232419354595%2F'
            'meta':
              'body': ''
              'weight': 4
              'title': 'Bookmarks - and other placeholders'
              'face': 'http://graph.facebook.com/v2.7/10154232419354595/picture?type=square'
              'profileLink': 'https://www.facebook.com/app_scoped_user_id/10154232419354595/'
              'FromLink': 'Bookmarks'
              'ToLink': 'https://www.facebook.com/app_scoped_user_id/10154232419354595/'
              'ScreenshotUrl': 'https://api.urlbox.io/v1/FLMG5BM3XeqMGa42/f9ef8e3b40885a6acde8c71ffdac6aac3365525e/png?url=Bookmarks&thumb_width=320&quality=80'
              'ScreenshotUrlTo': 'https://api.urlbox.io/v1/FLMG5BM3XeqMGa42/9b1a5f128cbac84d2142d3377200235906e5a39e/png?url=https%3A%2F%2Fwww.facebook.com%2Fapp_scoped_user_id%2F10154232419354595%2F&thumb_width=320&quality=80'
            'author': 'S54FphiBzL3KueFF4'
            'createdAt': 1516866021850
            'title': 'Bookmarks - and other placeholders'
          'https%3A%2F%2Fwww%2Efacebook%2Ecom%2Fapp_scoped_user_id%2F10154232419354595%2F':
            'from': 'https%3A%2F%2Fwww%2Efacebook%2Ecom%2Fapp_scoped_user_id%2F10154232419354595%2F'
            'to': 'https%3A%2F%2Fwww%2Efacebook%2Ecom%2Fapp_scoped_user_id%2F10154232419354595%2F'
            'meta':
              'body': 'ghfded'
              'weight': 8
              'title': 'Elias Moosman on Facebook'
              'face': 'http://graph.facebook.com/v2.7/10154232419354595/picture?type=square'
              'profileLink': 'https://www.facebook.com/app_scoped_user_id/10154232419354595/'
              'FromLink': 'https://www.facebook.com/app_scoped_user_id/10154232419354595/'
              'ToLink': 'https://www.facebook.com/app_scoped_user_id/10154232419354595/'
              'ScreenshotUrl': 'https://api.urlbox.io/v1/FLMG5BM3XeqMGa42/9b1a5f128cbac84d2142d3377200235906e5a39e/png?url=https%3A%2F%2Fwww.facebook.com%2Fapp_scoped_user_id%2F10154232419354595%2F&thumb_width=320&quality=80'
              'ScreenshotUrlTo': 'https://api.urlbox.io/v1/FLMG5BM3XeqMGa42/9b1a5f128cbac84d2142d3377200235906e5a39e/png?url=https%3A%2F%2Fwww.facebook.com%2Fapp_scoped_user_id%2F10154232419354595%2F&thumb_width=320&quality=80'
            'author': 'S54FphiBzL3KueFF4'
            'createdAt': 1516866008784
            'title': 'Elias Moosman on Facebook'
        'http%3A%2F%2Flocalhost%3A3000%2Fabout%3Ffrom%3Dhttps%25253A%25252F%25252Fwww%2Efacebook%2Ecom%25252Fapp_scoped_user_id%25252F10154232419354595%25252F%26lastTitle%3DIcon%252520Button%252520-%252520Material-UI%26to%3DBookmarks%26Bookmarked%3Dtrue%26content%3Dhahah%26switched%3D': 'Bookmarks':
          'from': 'http%3A%2F%2Flocalhost%3A3000%2Fabout%3Ffrom%3Dhttps%25253A%25252F%25252Fwww%2Efacebook%2Ecom%25252Fapp_scoped_user_id%25252F10154232419354595%25252F%26lastTitle%3DIcon%252520Button%252520-%252520Material-UI%26to%3DBookmarks%26Bookmarked%3Dtrue%26content%3Dhahah%26switched%3D'
          'to': 'Bookmarks'
          'meta':
            'weight': 5
            'title': 'Linkstates for Elias Moosman on Facebook - https://www.facebook.com/app_scoped_user_id/10154232419354595/'
            'face': 'http://graph.facebook.com/v2.7/10154232419354595/picture?type=square'
            'profileLink': 'https://www.facebook.com/app_scoped_user_id/10154232419354595/'
            'FromLink': 'http://localhost:3000/about?from=https%253A%252F%252Fwww.facebook.com%252Fapp_scoped_user_id%252F10154232419354595%252F&lastTitle=Icon%2520Button%2520-%2520Material-UI&to=Bookmarks&Bookmarked=true&content=hahah&switched='
            'ToLink': 'Bookmarks'
            'ScreenshotUrl': 'https://api.thumbalizr.com/?url=http://localhost:3000/about?from=https%253A%252F%252Fwww.facebook.com%252Fapp_scoped_user_id%252F10154232419354595%252F&lastTitle=Icon%2520Button%2520-%2520Material-UI&to=Bookmarks&Bookmarked=true&content=hahah&switched=&width=250&api_key=UQ6CMod6tIkVLam271a7WdUlutEJJHTE'
            'ScreenshotUrlTo': 'https://api.thumbalizr.com/?url=Bookmarks&width=250&api_key=UQ6CMod6tIkVLam271a7WdUlutEJJHTE'
          'author': 'S54FphiBzL3KueFF4'
          'createdAt': 1515650383851
          'title': 'Linkstates for Elias Moosman on Facebook - https://www.facebook.com/app_scoped_user_id/10154232419354595/'
        'https%3A%2F%2Fstackoverflow%2Ecom%2Fquestions%2F9529078%2Fhow-do-i-use-git-reset-hard-head-to-revert-to-a-previous-commit': 'Bookmarks':
          'from': 'https%3A%2F%2Fstackoverflow%2Ecom%2Fquestions%2F9529078%2Fhow-do-i-use-git-reset-hard-head-to-revert-to-a-previous-commit'
          'to': 'Bookmarks'
          'meta':
            'weight': 5
            'title': 'How do I use \'git reset --hard HEAD\' to revert to a previous commit? - Stack Overflow'
            'face': 'http://graph.facebook.com/v2.7/10154232419354595/picture?type=square'
            'profileLink': 'https://www.facebook.com/app_scoped_user_id/10154232419354595/'
            'FromLink': 'https://stackoverflow.com/questions/9529078/how-do-i-use-git-reset-hard-head-to-revert-to-a-previous-commit'
            'ToLink': 'Bookmarks'
            'ScreenshotUrl': 'https://api.thumbalizr.com/?url=https://stackoverflow.com/questions/9529078/how-do-i-use-git-reset-hard-head-to-revert-to-a-previous-commit&width=250&api_key=UQ6CMod6tIkVLam271a7WdUlutEJJHTE'
            'ScreenshotUrlTo': 'https://api.thumbalizr.com/?url=Bookmarks&width=250&api_key=UQ6CMod6tIkVLam271a7WdUlutEJJHTE'
          'author': 'S54FphiBzL3KueFF4'
          'createdAt': 1515650480814
          'title': 'How do I use \'git reset --hard HEAD\' to revert to a previous commit? - Stack Overflow'
        'Linkstate%2Eyouiest%2Ecom%2Fabout':
          'Linkstate%2Eyouiest%2Ecom':
            'from': 'Linkstate%2Eyouiest%2Ecom'
            'to': 'Linkstate%2Eyouiest%2Ecom%2Fabout'
            'meta':
              'title': 'Linkstate - Connecting is seeing'
              'weight': 8
              'body': 'The fate of bookmarks can tell us a lot about Linkstate'
              'face': 'http://graph.facebook.com/v2.7/10154232419354595/picture?type=square'
              'profileLink': 'https://www.facebook.com/app_scoped_user_id/10154232419354595/'
              'FromLink': 'Linkstate.youiest.com'
              'ToLink': 'Linkstate.youiest.com/about'
              'ScreenshotUrl': 'https://api.urlbox.io/v1/FLMG5BM3XeqMGa42/117475d1c2f4d6fac7710dcc2f841e06b46e06b3/png?url=Linkstate.youiest.com&thumb_width=320&quality=80'
              'ScreenshotUrlTo': 'https://api.urlbox.io/v1/FLMG5BM3XeqMGa42/7c81ff8950b76e157e44b1a70cfb81532f9a170c/png?url=Linkstate.youiest.com%2Fabout&thumb_width=320&quality=80'
            'author': 'S54FphiBzL3KueFF4'
            'createdAt': 1515744706613
            'title': 'Linkstate - Connecting is seeing'
          'Linkstate%2Eyouiest%2Ecom%2Fabout':
            'from': 'Linkstate%2Eyouiest%2Ecom%2Fabout'
            'to': 'Linkstate%2Eyouiest%2Ecom%2Fabout'
            'meta':
              'title': 'Linkstate - Connecting is seeing'
              'weight': 8
              'body': 'The fate of bookmarks can tell us a lot about Linkstate'
              'face': 'http://graph.facebook.com/v2.7/10154232419354595/picture?type=square'
              'profileLink': 'https://www.facebook.com/app_scoped_user_id/10154232419354595/'
              'FromLink': 'Linkstate.youiest.com/about'
              'ToLink': 'Linkstate.youiest.com/about'
              'ScreenshotUrl': 'https://api.urlbox.io/v1/FLMG5BM3XeqMGa42/7c81ff8950b76e157e44b1a70cfb81532f9a170c/png?url=Linkstate.youiest.com%2Fabout&thumb_width=320&quality=80'
              'ScreenshotUrlTo': 'https://api.urlbox.io/v1/FLMG5BM3XeqMGa42/7c81ff8950b76e157e44b1a70cfb81532f9a170c/png?url=Linkstate.youiest.com%2Fabout&thumb_width=320&quality=80'
            'author': 'S54FphiBzL3KueFF4'
            'createdAt': 1517192719673
            'title': 'Linkstate - Connecting is seeing'
          'https%3A%2F%2Fdevelopers%2Efacebook%2Ecom%2Fproducts%2Fsocial-plugins%2Fcomments%2F%3Futm_campaign%3Dsocial_plugins%26utm_medium%3Doffsite_pages%26utm_source%3Dcomments_plugin':
            'from': 'https%3A%2F%2Fdevelopers%2Efacebook%2Ecom%2Fproducts%2Fsocial-plugins%2Fcomments%2F%3Futm_campaign%3Dsocial_plugins%26utm_medium%3Doffsite_pages%26utm_source%3Dcomments_plugin'
            'to': 'Linkstate%2Eyouiest%2Ecom%2Fabout'
            'meta':
              'body': 'hihi'
              'weight': 8
              'title': 'Comments - Facebook for Developers'
              'face': 'http://graph.facebook.com/v2.7/10154232419354595/picture?type=square'
              'profileLink': 'https://www.facebook.com/app_scoped_user_id/10154232419354595/'
              'FromLink': 'https://developers.facebook.com/products/social-plugins/comments/?utm_campaign=social_plugins&utm_medium=offsite_pages&utm_source=comments_plugin'
              'ToLink': 'Linkstate.youiest.com/about'
              'ScreenshotUrl': 'https://api.urlbox.io/v1/FLMG5BM3XeqMGa42/07d8c5a90f1c223ccd0f83a8637374368bb68178/png?url=https%3A%2F%2Fdevelopers.facebook.com%2Fproducts%2Fsocial-plugins%2Fcomments%2F%3Futm_campaign%3Dsocial_plugins%26utm_medium%3Doffsite_pages%26utm_source%3Dcomments_plugin&thumb_width=320&quality=80'
              'ScreenshotUrlTo': 'https://api.urlbox.io/v1/FLMG5BM3XeqMGa42/7c81ff8950b76e157e44b1a70cfb81532f9a170c/png?url=Linkstate.youiest.com%2Fabout&thumb_width=320&quality=80'
            'author': 'S54FphiBzL3KueFF4'
            'createdAt': 1516799506419
            'title': 'Comments - Facebook for Developers'
          'http%3A%2F%2Fwww%2Ematerial-ui%2Ecom%2Fv0%2E15%2E0%2F%23%2Fcomponents%2Ficon-button':
            'from': 'http%3A%2F%2Fwww%2Ematerial-ui%2Ecom%2Fv0%2E15%2E0%2F%23%2Fcomponents%2Ficon-button'
            'to': 'Linkstate%2Eyouiest%2Ecom%2Fabout'
            'meta':
              'body': ''
              'weight': 7
              'title': 'Icon Button - Material-UI'
              'face': 'http://graph.facebook.com/v2.7/10154232419354595/picture?type=square'
              'profileLink': 'https://www.facebook.com/app_scoped_user_id/10154232419354595/'
              'FromLink': 'http://www.material-ui.com/v0.15.0/#/components/icon-button'
              'ToLink': 'Linkstate.youiest.com/about'
              'ScreenshotUrl': 'https://api.urlbox.io/v1/FLMG5BM3XeqMGa42/bc419c1ffae6d735068eb38564b861249f53af0f/png?url=http%3A%2F%2Fwww.material-ui.com%2Fv0.15.0%2F%23%2Fcomponents%2Ficon-button&thumb_width=320&quality=80'
              'ScreenshotUrlTo': 'https://api.urlbox.io/v1/FLMG5BM3XeqMGa42/7c81ff8950b76e157e44b1a70cfb81532f9a170c/png?url=Linkstate.youiest.com%2Fabout&thumb_width=320&quality=80'
            'author': 'S54FphiBzL3KueFF4'
            'createdAt': 1515848417835
            'title': 'Icon Button - Material-UI'
          'https%3A%2F%2Fwww%2Enpmjs%2Ecom%2Fpackage%2Fcopy-to-clipboard':
            'from': 'https%3A%2F%2Fwww%2Enpmjs%2Ecom%2Fpackage%2Fcopy-to-clipboard'
            'to': 'Linkstate%2Eyouiest%2Ecom%2Fabout'
            'meta':
              'body': 'haha'
              'weight': 6
              'title': 'copy-to-clipboard'
              'face': 'http://graph.facebook.com/v2.7/10154232419354595/picture?type=square'
              'profileLink': 'https://www.facebook.com/app_scoped_user_id/10154232419354595/'
              'FromLink': 'https://www.npmjs.com/package/copy-to-clipboard'
              'ToLink': 'Linkstate.youiest.com/about'
              'ScreenshotUrl': 'https://api.urlbox.io/v1/FLMG5BM3XeqMGa42/8be9bf072d4ca4620ea074275282f8e0acc74174/png?url=https%3A%2F%2Fwww.npmjs.com%2Fpackage%2Fcopy-to-clipboard&thumb_width=320&quality=80'
              'ScreenshotUrlTo': 'https://api.urlbox.io/v1/FLMG5BM3XeqMGa42/7c81ff8950b76e157e44b1a70cfb81532f9a170c/png?url=Linkstate.youiest.com%2Fabout&thumb_width=320&quality=80'
            'author': 'S54FphiBzL3KueFF4'
            'createdAt': 1515852726942
            'title': 'copy-to-clipboard'
          'http%3A%2F%2Fwww%2Ematerial-ui%2Ecom%2Fv0%2E15%2E0%2F%23%2Fcomponents%2Ffloating-action-button':
            'from': 'http%3A%2F%2Fwww%2Ematerial-ui%2Ecom%2Fv0%2E15%2E0%2F%23%2Fcomponents%2Ffloating-action-button'
            'to': 'Linkstate%2Eyouiest%2Ecom%2Fabout'
            'meta':
              'body': 'haha'
              'weight': 7
              'title': 'Floating Action Button - Material-UI'
              'face': 'http://graph.facebook.com/v2.7/10154232419354595/picture?type=square'
              'profileLink': 'https://www.facebook.com/app_scoped_user_id/10154232419354595/'
              'FromLink': 'http://www.material-ui.com/v0.15.0/#/components/floating-action-button'
              'ToLink': 'Linkstate.youiest.com/about'
              'ScreenshotUrl': 'https://api.urlbox.io/v1/FLMG5BM3XeqMGa42/da1d05c7c97b6a4f5473451ee8905aa7484401dd/png?url=http%3A%2F%2Fwww.material-ui.com%2Fv0.15.0%2F%23%2Fcomponents%2Ffloating-action-button&thumb_width=320&quality=80'
              'ScreenshotUrlTo': 'https://api.urlbox.io/v1/FLMG5BM3XeqMGa42/7c81ff8950b76e157e44b1a70cfb81532f9a170c/png?url=Linkstate.youiest.com%2Fabout&thumb_width=320&quality=80'
            'author': 'S54FphiBzL3KueFF4'
            'createdAt': 1515852807096
            'title': 'Floating Action Button - Material-UI'
          'http%3A%2F%2Fwww%2Ematerial-ui%2Ecom%2Fv0%2E15%2E0%2F%23%2Fcomponents%2Fgrid-list':
            'from': 'http%3A%2F%2Fwww%2Ematerial-ui%2Ecom%2Fv0%2E15%2E0%2F%23%2Fcomponents%2Fgrid-list'
            'to': 'Linkstate%2Eyouiest%2Ecom%2Fabout'
            'meta':
              'body': 'haha'
              'weight': 7
              'title': 'Grid List - Material-UI'
              'face': 'http://graph.facebook.com/v2.7/10154232419354595/picture?type=square'
              'profileLink': 'https://www.facebook.com/app_scoped_user_id/10154232419354595/'
              'FromLink': 'http://www.material-ui.com/v0.15.0/#/components/grid-list'
              'ToLink': 'Linkstate.youiest.com/about'
              'ScreenshotUrl': 'https://api.urlbox.io/v1/FLMG5BM3XeqMGa42/40553ece4a58fa64935a61307604420279d5a1db/png?url=http%3A%2F%2Fwww.material-ui.com%2Fv0.15.0%2F%23%2Fcomponents%2Fgrid-list&thumb_width=320&quality=80'
              'ScreenshotUrlTo': 'https://api.urlbox.io/v1/FLMG5BM3XeqMGa42/7c81ff8950b76e157e44b1a70cfb81532f9a170c/png?url=Linkstate.youiest.com%2Fabout&thumb_width=320&quality=80'
            'author': 'S54FphiBzL3KueFF4'
            'createdAt': 1516602773161
            'title': 'Grid List - Material-UI'
        'http%3A%2F%2Fwww%2Ematerial-ui%2Ecom%2Fv0%2E15%2E0%2F%23%2Fcomponents%2Ficon-button': 'Linkstate%2Eyouiest%2Ecom%2Fabout':
          'from': 'Linkstate%2Eyouiest%2Ecom%2Fabout'
          'to': 'http%3A%2F%2Fwww%2Ematerial-ui%2Ecom%2Fv0%2E15%2E0%2F%23%2Fcomponents%2Ficon-button'
          'meta':
            'body': 'hi'
            'weight': 1
            'title': 'Linkstate - Connecting is seeing'
            'face': 'http://graph.facebook.com/v2.7/10154232419354595/picture?type=square'
            'profileLink': 'https://www.facebook.com/app_scoped_user_id/10154232419354595/'
            'FromLink': 'Linkstate.youiest.com/about'
            'ToLink': 'http://www.material-ui.com/v0.15.0/#/components/icon-button'
            'ScreenshotUrl': 'https://api.urlbox.io/v1/FLMG5BM3XeqMGa42/7c81ff8950b76e157e44b1a70cfb81532f9a170c/png?url=Linkstate.youiest.com%2Fabout&thumb_width=320&quality=80'
            'ScreenshotUrlTo': 'https://api.urlbox.io/v1/FLMG5BM3XeqMGa42/bc419c1ffae6d735068eb38564b861249f53af0f/png?url=http%3A%2F%2Fwww.material-ui.com%2Fv0.15.0%2F%23%2Fcomponents%2Ficon-button&thumb_width=320&quality=80'
          'author': 'S54FphiBzL3KueFF4'
          'createdAt': 1515765825514
          'title': 'Linkstate - Connecting is seeing'
        'http%3A%2F%2Fwww%2Ematerial-ui%2Ecom%2Fv0%2E15%2E0%2F%23%2Fcomponents%2Ffloating-action-button': 'https%3A%2F%2Fdevelopers%2Efacebook%2Ecom%2Fproducts%2Fsocial-plugins%2Fcomments%2F%3Futm_campaign%3Dsocial_plugins%26utm_medium%3Doffsite_pages%26utm_source%3Dcomments_plugin':
          'from': 'https%3A%2F%2Fdevelopers%2Efacebook%2Ecom%2Fproducts%2Fsocial-plugins%2Fcomments%2F%3Futm_campaign%3Dsocial_plugins%26utm_medium%3Doffsite_pages%26utm_source%3Dcomments_plugin'
          'to': 'http%3A%2F%2Fwww%2Ematerial-ui%2Ecom%2Fv0%2E15%2E0%2F%23%2Fcomponents%2Ffloating-action-button'
          'meta':
            'body': 'floating was last '
            'weight': 7
            'title': 'Comments - Facebook for Developers'
            'face': 'http://graph.facebook.com/v2.7/10154232419354595/picture?type=square'
            'profileLink': 'https://www.facebook.com/app_scoped_user_id/10154232419354595/'
            'FromLink': 'https://developers.facebook.com/products/social-plugins/comments/?utm_campaign=social_plugins&utm_medium=offsite_pages&utm_source=comments_plugin'
            'ToLink': 'http://www.material-ui.com/v0.15.0/#/components/floating-action-button'
            'ScreenshotUrl': 'https://api.urlbox.io/v1/FLMG5BM3XeqMGa42/07d8c5a90f1c223ccd0f83a8637374368bb68178/png?url=https%3A%2F%2Fdevelopers.facebook.com%2Fproducts%2Fsocial-plugins%2Fcomments%2F%3Futm_campaign%3Dsocial_plugins%26utm_medium%3Doffsite_pages%26utm_source%3Dcomments_plugin&thumb_width=320&quality=80'
            'ScreenshotUrlTo': 'https://api.urlbox.io/v1/FLMG5BM3XeqMGa42/da1d05c7c97b6a4f5473451ee8905aa7484401dd/png?url=http%3A%2F%2Fwww.material-ui.com%2Fv0.15.0%2F%23%2Fcomponents%2Ffloating-action-button&thumb_width=320&quality=80'
          'author': 'S54FphiBzL3KueFF4'
          'createdAt': 1515853396214
          'title': 'Comments - Facebook for Developers'
        'en%2Ewikipedia%2Eorg%2Fwiki%2Fbookmark':
          'en%2Ewikipedia%2Eorg%2Fwiki%2Fbookmark':
            'from': 'en%2Ewikipedia%2Eorg%2Fwiki%2Fbookmark'
            'to': 'en%2Ewikipedia%2Eorg%2Fwiki%2Fbookmark'
            'meta':
              'title': 'Bookmarks - and other placeholders'
              'weight': 9
              'ScreenshotUrl': 'https://api.urlbox.io/v1/FLMG5BM3XeqMGa42/dfa731789ad019f3a532fe83b20d20f05f11de38/png?url=en.wikipedia.org%2Fwiki%2Fbookmark&thumb_width=320&quality=80'
              'face': 'http://graph.facebook.com/v2.7/10154232419354595/picture?type=square'
              'profileLink': 'https://www.facebook.com/app_scoped_user_id/10154232419354595/'
              'FromLink': 'en.wikipedia.org/wiki/bookmark'
              'ToLink': 'en.wikipedia.org/wiki/bookmark'
              'ScreenshotUrlTo': 'https://api.urlbox.io/v1/FLMG5BM3XeqMGa42/dfa731789ad019f3a532fe83b20d20f05f11de38/png?url=en.wikipedia.org%2Fwiki%2Fbookmark&thumb_width=320&quality=80'
            'author': 'S54FphiBzL3KueFF4'
            'createdAt': 1517192719349
            'title': 'Bookmarks - and other placeholders'
          'Linkstate%2Eyouiest%2Ecom%2Fabout':
            'from': 'Linkstate%2Eyouiest%2Ecom%2Fabout'
            'to': 'en%2Ewikipedia%2Eorg%2Fwiki%2Fbookmark'
            'meta':
              'title': 'Linkstate - Connecting is seeing'
              'weight': 7
              'face': 'http://graph.facebook.com/v2.7/10154232419354595/picture?type=square'
              'profileLink': 'https://www.facebook.com/app_scoped_user_id/10154232419354595/'
              'FromLink': 'Linkstate.youiest.com/about'
              'ToLink': 'en.wikipedia.org/wiki/bookmark'
              'ScreenshotUrl': 'https://api.urlbox.io/v1/FLMG5BM3XeqMGa42/7c81ff8950b76e157e44b1a70cfb81532f9a170c/png?url=Linkstate.youiest.com%2Fabout&thumb_width=320&quality=80'
              'ScreenshotUrlTo': 'https://api.urlbox.io/v1/FLMG5BM3XeqMGa42/dfa731789ad019f3a532fe83b20d20f05f11de38/png?url=en.wikipedia.org%2Fwiki%2Fbookmark&thumb_width=320&quality=80'
            'author': 'S54FphiBzL3KueFF4'
            'createdAt': 1517192719520
            'title': 'Linkstate - Connecting is seeing'
          'https%3A%2F%2Fwww%2Efacebook%2Ecom%2Fapp_scoped_user_id%2F10154232419354595%2F':
            'from': 'https%3A%2F%2Fwww%2Efacebook%2Ecom%2Fapp_scoped_user_id%2F10154232419354595%2F'
            'to': 'en%2Ewikipedia%2Eorg%2Fwiki%2Fbookmark'
            'meta':
              'title': 'Elias Moosman on Facebook'
              'weight': 7
              'face': 'http://graph.facebook.com/v2.7/10154232419354595/picture?type=square'
              'profileLink': 'https://www.facebook.com/app_scoped_user_id/10154232419354595/'
              'FromLink': 'https://www.facebook.com/app_scoped_user_id/10154232419354595/'
              'ToLink': 'en.wikipedia.org/wiki/bookmark'
              'ScreenshotUrl': 'https://api.urlbox.io/v1/FLMG5BM3XeqMGa42/9b1a5f128cbac84d2142d3377200235906e5a39e/png?url=https%3A%2F%2Fwww.facebook.com%2Fapp_scoped_user_id%2F10154232419354595%2F&thumb_width=320&quality=80'
              'ScreenshotUrlTo': 'https://api.urlbox.io/v1/FLMG5BM3XeqMGa42/dfa731789ad019f3a532fe83b20d20f05f11de38/png?url=en.wikipedia.org%2Fwiki%2Fbookmark&thumb_width=320&quality=80'
            'author': 'S54FphiBzL3KueFF4'
            'createdAt': 1517192719821
            'title': 'Elias Moosman on Facebook'
      'out':
        'Bookmarks':
          'Bookmarks':
            'from': 'Bookmarks'
            'to': 'Bookmarks'
            'meta':
              'title': 'Bookmarks - and other placeholders'
              'weight': 9
              'ScreenshotUrl': 'https://api.urlbox.io/v1/FLMG5BM3XeqMGa42/f9ef8e3b40885a6acde8c71ffdac6aac3365525e/png?url=Bookmarks&thumb_width=320&quality=80'
              'face': 'http://graph.facebook.com/v2.7/10154232419354595/picture?type=square'
              'profileLink': 'https://www.facebook.com/app_scoped_user_id/10154232419354595/'
              'FromLink': 'Bookmarks'
              'ToLink': 'Bookmarks'
              'ScreenshotUrlTo': 'https://api.urlbox.io/v1/FLMG5BM3XeqMGa42/f9ef8e3b40885a6acde8c71ffdac6aac3365525e/png?url=Bookmarks&thumb_width=320&quality=80'
            'author': 'S54FphiBzL3KueFF4'
            'createdAt': 1516799499053
            'title': 'Bookmarks - and other placeholders'
          'Linkstate%2Eyouiest%2Ecom':
            'from': 'Bookmarks'
            'to': 'Linkstate%2Eyouiest%2Ecom'
            'meta':
              'body': 'hjkkwer'
              'weight': 4
              'title': 'Bookmarks - and other placeholders'
              'face': 'http://graph.facebook.com/v2.7/10154232419354595/picture?type=square'
              'profileLink': 'https://www.facebook.com/app_scoped_user_id/10154232419354595/'
              'FromLink': 'Bookmarks'
              'ToLink': 'Linkstate.youiest.com'
              'ScreenshotUrl': 'https://api.urlbox.io/v1/FLMG5BM3XeqMGa42/f9ef8e3b40885a6acde8c71ffdac6aac3365525e/png?url=Bookmarks&thumb_width=320&quality=80'
              'ScreenshotUrlTo': 'https://api.urlbox.io/v1/FLMG5BM3XeqMGa42/117475d1c2f4d6fac7710dcc2f841e06b46e06b3/png?url=Linkstate.youiest.com&thumb_width=320&quality=80'
            'author': 'S54FphiBzL3KueFF4'
            'createdAt': 1515675012528
            'title': 'Bookmarks - and other placeholders'
          'https%3A%2F%2Fwww%2Efacebook%2Ecom%2Fapp_scoped_user_id%2F10154232419354595%2F':
            'from': 'Bookmarks'
            'to': 'https%3A%2F%2Fwww%2Efacebook%2Ecom%2Fapp_scoped_user_id%2F10154232419354595%2F'
            'meta':
              'body': ''
              'weight': 4
              'title': 'Bookmarks - and other placeholders'
              'face': 'http://graph.facebook.com/v2.7/10154232419354595/picture?type=square'
              'profileLink': 'https://www.facebook.com/app_scoped_user_id/10154232419354595/'
              'FromLink': 'Bookmarks'
              'ToLink': 'https://www.facebook.com/app_scoped_user_id/10154232419354595/'
              'ScreenshotUrl': 'https://api.urlbox.io/v1/FLMG5BM3XeqMGa42/f9ef8e3b40885a6acde8c71ffdac6aac3365525e/png?url=Bookmarks&thumb_width=320&quality=80'
              'ScreenshotUrlTo': 'https://api.urlbox.io/v1/FLMG5BM3XeqMGa42/9b1a5f128cbac84d2142d3377200235906e5a39e/png?url=https%3A%2F%2Fwww.facebook.com%2Fapp_scoped_user_id%2F10154232419354595%2F&thumb_width=320&quality=80'
            'author': 'S54FphiBzL3KueFF4'
            'createdAt': 1516866021850
            'title': 'Bookmarks - and other placeholders'
          'http%3A%2F%2Flocalhost%3A3000%2Fabout%3Ffrom%3Dhttps%25253A%25252F%25252Fwww%2Efacebook%2Ecom%25252Fapp_scoped_user_id%25252F10154232419354595%25252F%26lastTitle%3DIcon%252520Button%252520-%252520Material-UI%26to%3DBookmarks%26Bookmarked%3Dtrue%26content%3Dhahah%26switched%3D':
            'from': 'http%3A%2F%2Flocalhost%3A3000%2Fabout%3Ffrom%3Dhttps%25253A%25252F%25252Fwww%2Efacebook%2Ecom%25252Fapp_scoped_user_id%25252F10154232419354595%25252F%26lastTitle%3DIcon%252520Button%252520-%252520Material-UI%26to%3DBookmarks%26Bookmarked%3Dtrue%26content%3Dhahah%26switched%3D'
            'to': 'Bookmarks'
            'meta':
              'weight': 5
              'title': 'Linkstates for Elias Moosman on Facebook - https://www.facebook.com/app_scoped_user_id/10154232419354595/'
              'face': 'http://graph.facebook.com/v2.7/10154232419354595/picture?type=square'
              'profileLink': 'https://www.facebook.com/app_scoped_user_id/10154232419354595/'
              'FromLink': 'http://localhost:3000/about?from=https%253A%252F%252Fwww.facebook.com%252Fapp_scoped_user_id%252F10154232419354595%252F&lastTitle=Icon%2520Button%2520-%2520Material-UI&to=Bookmarks&Bookmarked=true&content=hahah&switched='
              'ToLink': 'Bookmarks'
              'ScreenshotUrl': 'https://api.thumbalizr.com/?url=http://localhost:3000/about?from=https%253A%252F%252Fwww.facebook.com%252Fapp_scoped_user_id%252F10154232419354595%252F&lastTitle=Icon%2520Button%2520-%2520Material-UI&to=Bookmarks&Bookmarked=true&content=hahah&switched=&width=250&api_key=UQ6CMod6tIkVLam271a7WdUlutEJJHTE'
              'ScreenshotUrlTo': 'https://api.thumbalizr.com/?url=Bookmarks&width=250&api_key=UQ6CMod6tIkVLam271a7WdUlutEJJHTE'
            'author': 'S54FphiBzL3KueFF4'
            'createdAt': 1515650383851
            'title': 'Linkstates for Elias Moosman on Facebook - https://www.facebook.com/app_scoped_user_id/10154232419354595/'
          'https%3A%2F%2Fstackoverflow%2Ecom%2Fquestions%2F9529078%2Fhow-do-i-use-git-reset-hard-head-to-revert-to-a-previous-commit':
            'from': 'https%3A%2F%2Fstackoverflow%2Ecom%2Fquestions%2F9529078%2Fhow-do-i-use-git-reset-hard-head-to-revert-to-a-previous-commit'
            'to': 'Bookmarks'
            'meta':
              'weight': 5
              'title': 'How do I use \'git reset --hard HEAD\' to revert to a previous commit? - Stack Overflow'
              'face': 'http://graph.facebook.com/v2.7/10154232419354595/picture?type=square'
              'profileLink': 'https://www.facebook.com/app_scoped_user_id/10154232419354595/'
              'FromLink': 'https://stackoverflow.com/questions/9529078/how-do-i-use-git-reset-hard-head-to-revert-to-a-previous-commit'
              'ToLink': 'Bookmarks'
              'ScreenshotUrl': 'https://api.thumbalizr.com/?url=https://stackoverflow.com/questions/9529078/how-do-i-use-git-reset-hard-head-to-revert-to-a-previous-commit&width=250&api_key=UQ6CMod6tIkVLam271a7WdUlutEJJHTE'
              'ScreenshotUrlTo': 'https://api.thumbalizr.com/?url=Bookmarks&width=250&api_key=UQ6CMod6tIkVLam271a7WdUlutEJJHTE'
            'author': 'S54FphiBzL3KueFF4'
            'createdAt': 1515650480814
            'title': 'How do I use \'git reset --hard HEAD\' to revert to a previous commit? - Stack Overflow'
        'https%3A%2F%2Fwww%2Efacebook%2Ecom%2Fapp_scoped_user_id%2F10154232419354595%2F':
          'Bookmarks':
            'from': 'https%3A%2F%2Fwww%2Efacebook%2Ecom%2Fapp_scoped_user_id%2F10154232419354595%2F'
            'to': 'Bookmarks'
            'meta':
              'body': 'ghfd'
              'weight': 6
              'title': 'Elias Moosman on Facebook'
              'face': 'http://graph.facebook.com/v2.7/10154232419354595/picture?type=square'
              'profileLink': 'https://www.facebook.com/app_scoped_user_id/10154232419354595/'
              'FromLink': 'https://www.facebook.com/app_scoped_user_id/10154232419354595/'
              'ToLink': 'Bookmarks'
              'ScreenshotUrl': 'https://api.urlbox.io/v1/FLMG5BM3XeqMGa42/9b1a5f128cbac84d2142d3377200235906e5a39e/png?url=https%3A%2F%2Fwww.facebook.com%2Fapp_scoped_user_id%2F10154232419354595%2F&thumb_width=320&quality=80'
              'ScreenshotUrlTo': 'https://api.urlbox.io/v1/FLMG5BM3XeqMGa42/f9ef8e3b40885a6acde8c71ffdac6aac3365525e/png?url=Bookmarks&thumb_width=320&quality=80'
            'author': 'S54FphiBzL3KueFF4'
            'createdAt': 1516799737036
            'title': 'Elias Moosman on Facebook'
          'https%3A%2F%2Fwww%2Efacebook%2Ecom%2Fapp_scoped_user_id%2F10154232419354595%2F':
            'from': 'https%3A%2F%2Fwww%2Efacebook%2Ecom%2Fapp_scoped_user_id%2F10154232419354595%2F'
            'to': 'https%3A%2F%2Fwww%2Efacebook%2Ecom%2Fapp_scoped_user_id%2F10154232419354595%2F'
            'meta':
              'body': 'ghfded'
              'weight': 8
              'title': 'Elias Moosman on Facebook'
              'face': 'http://graph.facebook.com/v2.7/10154232419354595/picture?type=square'
              'profileLink': 'https://www.facebook.com/app_scoped_user_id/10154232419354595/'
              'FromLink': 'https://www.facebook.com/app_scoped_user_id/10154232419354595/'
              'ToLink': 'https://www.facebook.com/app_scoped_user_id/10154232419354595/'
              'ScreenshotUrl': 'https://api.urlbox.io/v1/FLMG5BM3XeqMGa42/9b1a5f128cbac84d2142d3377200235906e5a39e/png?url=https%3A%2F%2Fwww.facebook.com%2Fapp_scoped_user_id%2F10154232419354595%2F&thumb_width=320&quality=80'
              'ScreenshotUrlTo': 'https://api.urlbox.io/v1/FLMG5BM3XeqMGa42/9b1a5f128cbac84d2142d3377200235906e5a39e/png?url=https%3A%2F%2Fwww.facebook.com%2Fapp_scoped_user_id%2F10154232419354595%2F&thumb_width=320&quality=80'
            'author': 'S54FphiBzL3KueFF4'
            'createdAt': 1516866008784
            'title': 'Elias Moosman on Facebook'
          'en%2Ewikipedia%2Eorg%2Fwiki%2Fbookmark':
            'from': 'https%3A%2F%2Fwww%2Efacebook%2Ecom%2Fapp_scoped_user_id%2F10154232419354595%2F'
            'to': 'en%2Ewikipedia%2Eorg%2Fwiki%2Fbookmark'
            'meta':
              'title': 'Elias Moosman on Facebook'
              'weight': 7
              'face': 'http://graph.facebook.com/v2.7/10154232419354595/picture?type=square'
              'profileLink': 'https://www.facebook.com/app_scoped_user_id/10154232419354595/'
              'FromLink': 'https://www.facebook.com/app_scoped_user_id/10154232419354595/'
              'ToLink': 'en.wikipedia.org/wiki/bookmark'
              'ScreenshotUrl': 'https://api.urlbox.io/v1/FLMG5BM3XeqMGa42/9b1a5f128cbac84d2142d3377200235906e5a39e/png?url=https%3A%2F%2Fwww.facebook.com%2Fapp_scoped_user_id%2F10154232419354595%2F&thumb_width=320&quality=80'
              'ScreenshotUrlTo': 'https://api.urlbox.io/v1/FLMG5BM3XeqMGa42/dfa731789ad019f3a532fe83b20d20f05f11de38/png?url=en.wikipedia.org%2Fwiki%2Fbookmark&thumb_width=320&quality=80'
            'author': 'S54FphiBzL3KueFF4'
            'createdAt': 1517192719821
            'title': 'Elias Moosman on Facebook'
        'Linkstate%2Eyouiest%2Ecom':
          'Bookmarks':
            'from': 'Linkstate%2Eyouiest%2Ecom'
            'to': 'Bookmarks'
            'meta':
              'title': 'Linkstate - Connecting is seeing'
              'weight': 7
              'face': 'http://graph.facebook.com/v2.7/10154232419354595/picture?type=square'
              'profileLink': 'https://www.facebook.com/app_scoped_user_id/10154232419354595/'
              'FromLink': 'Linkstate.youiest.com'
              'ToLink': 'Bookmarks'
              'ScreenshotUrl': 'https://api.urlbox.io/v1/FLMG5BM3XeqMGa42/117475d1c2f4d6fac7710dcc2f841e06b46e06b3/png?url=Linkstate.youiest.com&thumb_width=320&quality=80'
              'ScreenshotUrlTo': 'https://api.urlbox.io/v1/FLMG5BM3XeqMGa42/f9ef8e3b40885a6acde8c71ffdac6aac3365525e/png?url=Bookmarks&thumb_width=320&quality=80'
            'author': 'S54FphiBzL3KueFF4'
            'createdAt': 1515745036583
            'title': 'Linkstate - Connecting is seeing'
          'Linkstate%2Eyouiest%2Ecom%2Fabout':
            'from': 'Linkstate%2Eyouiest%2Ecom'
            'to': 'Linkstate%2Eyouiest%2Ecom%2Fabout'
            'meta':
              'title': 'Linkstate - Connecting is seeing'
              'weight': 8
              'body': 'The fate of bookmarks can tell us a lot about Linkstate'
              'face': 'http://graph.facebook.com/v2.7/10154232419354595/picture?type=square'
              'profileLink': 'https://www.facebook.com/app_scoped_user_id/10154232419354595/'
              'FromLink': 'Linkstate.youiest.com'
              'ToLink': 'Linkstate.youiest.com/about'
              'ScreenshotUrl': 'https://api.urlbox.io/v1/FLMG5BM3XeqMGa42/117475d1c2f4d6fac7710dcc2f841e06b46e06b3/png?url=Linkstate.youiest.com&thumb_width=320&quality=80'
              'ScreenshotUrlTo': 'https://api.urlbox.io/v1/FLMG5BM3XeqMGa42/7c81ff8950b76e157e44b1a70cfb81532f9a170c/png?url=Linkstate.youiest.com%2Fabout&thumb_width=320&quality=80'
            'author': 'S54FphiBzL3KueFF4'
            'createdAt': 1515744706613
            'title': 'Linkstate - Connecting is seeing'
        'http%3A%2F%2Flocalhost%3A3000%2Fabout%3Ffrom%3DLinkstate%2Eyouiest%2Ecom%26lastTitle%3DIcon%252520Button%252520-%252520Material-UI%26to%3DBookmarks%26Bookmarked%3Dtrue%26content%3D%26switched%3D': 'Bookmarks':
          'from': 'http%3A%2F%2Flocalhost%3A3000%2Fabout%3Ffrom%3DLinkstate%2Eyouiest%2Ecom%26lastTitle%3DIcon%252520Button%252520-%252520Material-UI%26to%3DBookmarks%26Bookmarked%3Dtrue%26content%3D%26switched%3D'
          'to': 'Bookmarks'
          'meta':
            'weight': 5
            'title': 'Linkstates for Linkstate - Connecting is seeing - Linkstate.youiest.com'
            'face': 'http://graph.facebook.com/v2.7/10154232419354595/picture?type=square'
            'profileLink': 'https://www.facebook.com/app_scoped_user_id/10154232419354595/'
            'FromLink': 'http://localhost:3000/about?from=Linkstate.youiest.com&lastTitle=Icon%2520Button%2520-%2520Material-UI&to=Bookmarks&Bookmarked=true&content=&switched='
            'ToLink': 'Bookmarks'
            'ScreenshotUrl': 'https://api.urlbox.io/v1/FLMG5BM3XeqMGa42/2a97329fccd9bea5497d209c411e6a54bbd03f76/png?url=http%3A%2F%2Flocalhost%3A3000%2Fabout%3Ffrom%3DLinkstate.youiest.com%26lastTitle%3DIcon%252520Button%252520-%252520Material-UI%26to%3DBookmarks%26Bookmarked%3Dtrue%26content%3D%26switched%3D&thumb_width=320&quality=80'
            'ScreenshotUrlTo': 'https://api.urlbox.io/v1/FLMG5BM3XeqMGa42/f9ef8e3b40885a6acde8c71ffdac6aac3365525e/png?url=Bookmarks&thumb_width=320&quality=80'
          'author': 'S54FphiBzL3KueFF4'
          'createdAt': 1515650897280
          'title': 'Linkstates for Linkstate - Connecting is seeing - Linkstate.youiest.com'
        'https%3A%2F%2Fwww%2Efacebook%2Ecom%2FvViber%3Flst%3D532514594%253A532514594%253A1514878343': 'Bookmarks':
          'from': 'https%3A%2F%2Fwww%2Efacebook%2Ecom%2FvViber%3Flst%3D532514594%253A532514594%253A1514878343'
          'to': 'Bookmarks'
          'meta':
            'weight': 5
            'title': '(2) Elias Moosman'
            'face': 'http://graph.facebook.com/v2.7/10154232419354595/picture?type=square'
            'profileLink': 'https://www.facebook.com/app_scoped_user_id/10154232419354595/'
            'FromLink': 'https://www.facebook.com/vViber?lst=532514594%3A532514594%3A1514878343'
            'ToLink': 'Bookmarks'
            'ScreenshotUrl': 'https://api.urlbox.io/v1/FLMG5BM3XeqMGa42/7f5979875238b6c4bc73ccfc7f6ec691414e8c8a/png?url=https%3A%2F%2Fwww.facebook.com%2FvViber%3Flst%3D532514594%253A532514594%253A1514878343&thumb_width=320&quality=80'
            'ScreenshotUrlTo': 'https://api.urlbox.io/v1/FLMG5BM3XeqMGa42/f9ef8e3b40885a6acde8c71ffdac6aac3365525e/png?url=Bookmarks&thumb_width=320&quality=80'
          'author': 'S54FphiBzL3KueFF4'
          'createdAt': 1515728165362
          'title': '(2) Elias Moosman'
        'http%3A%2F%2Flocalhost%3A3000%2Fabout%3Ffrom%3DLinkstate%2Eyouiest%2Ecom%26lastTitle%3DIcon%252520Button%252520-%252520Material-UI%26to%3DLinkstate%2Eyouiest%2Ecom%26Bookmarked%3Dtrue%26content%3D%26switched%3D': 'Bookmarks':
          'from': 'http%3A%2F%2Flocalhost%3A3000%2Fabout%3Ffrom%3DLinkstate%2Eyouiest%2Ecom%26lastTitle%3DIcon%252520Button%252520-%252520Material-UI%26to%3DLinkstate%2Eyouiest%2Ecom%26Bookmarked%3Dtrue%26content%3D%26switched%3D'
          'to': 'Bookmarks'
          'meta':
            'weight': 5
            'title': 'Linkstates for Linkstate - Connecting is seeing - Linkstate.youiest.com'
            'face': 'http://graph.facebook.com/v2.7/10154232419354595/picture?type=square'
            'profileLink': 'https://www.facebook.com/app_scoped_user_id/10154232419354595/'
            'FromLink': 'http://localhost:3000/about?from=Linkstate.youiest.com&lastTitle=Icon%2520Button%2520-%2520Material-UI&to=Linkstate.youiest.com&Bookmarked=true&content=&switched='
            'ToLink': 'Bookmarks'
            'ScreenshotUrl': 'https://api.urlbox.io/v1/FLMG5BM3XeqMGa42/7e9eca309d75b57045a48ca0cda20fa74c9c66b0/png?url=http%3A%2F%2Flocalhost%3A3000%2Fabout%3Ffrom%3DLinkstate.youiest.com%26lastTitle%3DIcon%252520Button%252520-%252520Material-UI%26to%3DLinkstate.youiest.com%26Bookmarked%3Dtrue%26content%3D%26switched%3D&thumb_width=320&quality=80'
            'ScreenshotUrlTo': 'https://api.urlbox.io/v1/FLMG5BM3XeqMGa42/f9ef8e3b40885a6acde8c71ffdac6aac3365525e/png?url=Bookmarks&thumb_width=320&quality=80'
          'author': 'S54FphiBzL3KueFF4'
          'createdAt': 1515728156303
          'title': 'Linkstates for Linkstate - Connecting is seeing - Linkstate.youiest.com'
        'Linkstate%2Eyouiest%2Ecom%2Fabout':
          'Linkstate%2Eyouiest%2Ecom%2Fabout':
            'from': 'Linkstate%2Eyouiest%2Ecom%2Fabout'
            'to': 'Linkstate%2Eyouiest%2Ecom%2Fabout'
            'meta':
              'title': 'Linkstate - Connecting is seeing'
              'weight': 8
              'body': 'The fate of bookmarks can tell us a lot about Linkstate'
              'face': 'http://graph.facebook.com/v2.7/10154232419354595/picture?type=square'
              'profileLink': 'https://www.facebook.com/app_scoped_user_id/10154232419354595/'
              'FromLink': 'Linkstate.youiest.com/about'
              'ToLink': 'Linkstate.youiest.com/about'
              'ScreenshotUrl': 'https://api.urlbox.io/v1/FLMG5BM3XeqMGa42/7c81ff8950b76e157e44b1a70cfb81532f9a170c/png?url=Linkstate.youiest.com%2Fabout&thumb_width=320&quality=80'
              'ScreenshotUrlTo': 'https://api.urlbox.io/v1/FLMG5BM3XeqMGa42/7c81ff8950b76e157e44b1a70cfb81532f9a170c/png?url=Linkstate.youiest.com%2Fabout&thumb_width=320&quality=80'
            'author': 'S54FphiBzL3KueFF4'
            'createdAt': 1517192719673
            'title': 'Linkstate - Connecting is seeing'
          'Bookmarks':
            'from': 'Linkstate%2Eyouiest%2Ecom%2Fabout'
            'to': 'Bookmarks'
            'meta':
              'title': 'Linkstate - Connecting is seeing'
              'weight': 7
              'face': 'http://graph.facebook.com/v2.7/10154232419354595/picture?type=square'
              'profileLink': 'https://www.facebook.com/app_scoped_user_id/10154232419354595/'
              'FromLink': 'Linkstate.youiest.com/about'
              'ToLink': 'Bookmarks'
              'ScreenshotUrl': 'https://api.urlbox.io/v1/FLMG5BM3XeqMGa42/7c81ff8950b76e157e44b1a70cfb81532f9a170c/png?url=Linkstate.youiest.com%2Fabout&thumb_width=320&quality=80'
              'ScreenshotUrlTo': 'https://api.urlbox.io/v1/FLMG5BM3XeqMGa42/f9ef8e3b40885a6acde8c71ffdac6aac3365525e/png?url=Bookmarks&thumb_width=320&quality=80'
            'author': 'S54FphiBzL3KueFF4'
            'createdAt': 1516799499853
            'title': 'Linkstate - Connecting is seeing'
          'http%3A%2F%2Fwww%2Ematerial-ui%2Ecom%2Fv0%2E15%2E0%2F%23%2Fcomponents%2Ficon-button':
            'from': 'Linkstate%2Eyouiest%2Ecom%2Fabout'
            'to': 'http%3A%2F%2Fwww%2Ematerial-ui%2Ecom%2Fv0%2E15%2E0%2F%23%2Fcomponents%2Ficon-button'
            'meta':
              'body': 'hi'
              'weight': 1
              'title': 'Linkstate - Connecting is seeing'
              'face': 'http://graph.facebook.com/v2.7/10154232419354595/picture?type=square'
              'profileLink': 'https://www.facebook.com/app_scoped_user_id/10154232419354595/'
              'FromLink': 'Linkstate.youiest.com/about'
              'ToLink': 'http://www.material-ui.com/v0.15.0/#/components/icon-button'
              'ScreenshotUrl': 'https://api.urlbox.io/v1/FLMG5BM3XeqMGa42/7c81ff8950b76e157e44b1a70cfb81532f9a170c/png?url=Linkstate.youiest.com%2Fabout&thumb_width=320&quality=80'
              'ScreenshotUrlTo': 'https://api.urlbox.io/v1/FLMG5BM3XeqMGa42/bc419c1ffae6d735068eb38564b861249f53af0f/png?url=http%3A%2F%2Fwww.material-ui.com%2Fv0.15.0%2F%23%2Fcomponents%2Ficon-button&thumb_width=320&quality=80'
            'author': 'S54FphiBzL3KueFF4'
            'createdAt': 1515765825514
            'title': 'Linkstate - Connecting is seeing'
          'en%2Ewikipedia%2Eorg%2Fwiki%2Fbookmark':
            'from': 'Linkstate%2Eyouiest%2Ecom%2Fabout'
            'to': 'en%2Ewikipedia%2Eorg%2Fwiki%2Fbookmark'
            'meta':
              'title': 'Linkstate - Connecting is seeing'
              'weight': 7
              'face': 'http://graph.facebook.com/v2.7/10154232419354595/picture?type=square'
              'profileLink': 'https://www.facebook.com/app_scoped_user_id/10154232419354595/'
              'FromLink': 'Linkstate.youiest.com/about'
              'ToLink': 'en.wikipedia.org/wiki/bookmark'
              'ScreenshotUrl': 'https://api.urlbox.io/v1/FLMG5BM3XeqMGa42/7c81ff8950b76e157e44b1a70cfb81532f9a170c/png?url=Linkstate.youiest.com%2Fabout&thumb_width=320&quality=80'
              'ScreenshotUrlTo': 'https://api.urlbox.io/v1/FLMG5BM3XeqMGa42/dfa731789ad019f3a532fe83b20d20f05f11de38/png?url=en.wikipedia.org%2Fwiki%2Fbookmark&thumb_width=320&quality=80'
            'author': 'S54FphiBzL3KueFF4'
            'createdAt': 1517192719520
            'title': 'Linkstate - Connecting is seeing'
        'https%3A%2F%2Flinkstate%2Eyouiest%2Ecom%2Fabout%3Ffrom%3DBookmarks%26lastTitle%3DGrid%252520List%252520-%252520Material-UI%26Bookmarked%3Dtrue%26to%3Dhttps%25253A%25252F%25252Fmopinion%2Ecom%25252Ftop-10-website-annotation-tools%25252F%26content%3D%26switched%3D': 'Bookmarks':
          'from': 'https%3A%2F%2Flinkstate%2Eyouiest%2Ecom%2Fabout%3Ffrom%3DBookmarks%26lastTitle%3DGrid%252520List%252520-%252520Material-UI%26Bookmarked%3Dtrue%26to%3Dhttps%25253A%25252F%25252Fmopinion%2Ecom%25252Ftop-10-website-annotation-tools%25252F%26content%3D%26switched%3D'
          'to': 'Bookmarks'
          'meta':
            'weight': 5
            'title': 'Linkstates for Bookmarks - and other placeholders - Bookmarks'
            'face': 'http://graph.facebook.com/v2.7/10154232419354595/picture?type=square'
            'profileLink': 'https://www.facebook.com/app_scoped_user_id/10154232419354595/'
            'FromLink': 'https://linkstate.youiest.com/about?from=Bookmarks&lastTitle=Grid%2520List%2520-%2520Material-UI&Bookmarked=true&to=https%253A%252F%252Fmopinion.com%252Ftop-10-website-annotation-tools%252F&content=&switched='
            'ToLink': 'Bookmarks'
            'ScreenshotUrl': 'https://api.urlbox.io/v1/FLMG5BM3XeqMGa42/891c9105bb40fedaf3946178f7ee21f0cf25cb54/png?url=https%3A%2F%2Flinkstate.youiest.com%2Fabout%3Ffrom%3DBookmarks%26lastTitle%3DGrid%252520List%252520-%252520Material-UI%26Bookmarked%3Dtrue%26to%3Dhttps%25253A%25252F%25252Fmopinion.com%25252Ftop-10-website-annotation-tools%25252F%26content%3D%26switched%3D&thumb_width=320&quality=80'
            'ScreenshotUrlTo': 'https://api.urlbox.io/v1/FLMG5BM3XeqMGa42/f9ef8e3b40885a6acde8c71ffdac6aac3365525e/png?url=Bookmarks&thumb_width=320&quality=80'
          'author': 'S54FphiBzL3KueFF4'
          'createdAt': 1515750433476
          'title': 'Linkstates for Bookmarks - and other placeholders - Bookmarks'
        'https%3A%2F%2Fdevelopers%2Efacebook%2Ecom%2Fproducts%2Fsocial-plugins%2Fcomments%2F%3Futm_campaign%3Dsocial_plugins%26utm_medium%3Doffsite_pages%26utm_source%3Dcomments_plugin':
          'Bookmarks':
            'from': 'https%3A%2F%2Fdevelopers%2Efacebook%2Ecom%2Fproducts%2Fsocial-plugins%2Fcomments%2F%3Futm_campaign%3Dsocial_plugins%26utm_medium%3Doffsite_pages%26utm_source%3Dcomments_plugin'
            'to': 'Bookmarks'
            'meta':
              'weight': 5
              'title': 'Comments - Facebook for Developers'
              'face': 'http://graph.facebook.com/v2.7/10154232419354595/picture?type=square'
              'profileLink': 'https://www.facebook.com/app_scoped_user_id/10154232419354595/'
              'FromLink': 'https://developers.facebook.com/products/social-plugins/comments/?utm_campaign=social_plugins&utm_medium=offsite_pages&utm_source=comments_plugin'
              'ToLink': 'Bookmarks'
              'ScreenshotUrl': 'https://api.urlbox.io/v1/FLMG5BM3XeqMGa42/07d8c5a90f1c223ccd0f83a8637374368bb68178/png?url=https%3A%2F%2Fdevelopers.facebook.com%2Fproducts%2Fsocial-plugins%2Fcomments%2F%3Futm_campaign%3Dsocial_plugins%26utm_medium%3Doffsite_pages%26utm_source%3Dcomments_plugin&thumb_width=320&quality=80'
              'ScreenshotUrlTo': 'https://api.urlbox.io/v1/FLMG5BM3XeqMGa42/f9ef8e3b40885a6acde8c71ffdac6aac3365525e/png?url=Bookmarks&thumb_width=320&quality=80'
            'author': 'S54FphiBzL3KueFF4'
            'createdAt': 1515893775950
            'title': 'Comments - Facebook for Developers'
          'Linkstate%2Eyouiest%2Ecom%2Fabout':
            'from': 'https%3A%2F%2Fdevelopers%2Efacebook%2Ecom%2Fproducts%2Fsocial-plugins%2Fcomments%2F%3Futm_campaign%3Dsocial_plugins%26utm_medium%3Doffsite_pages%26utm_source%3Dcomments_plugin'
            'to': 'Linkstate%2Eyouiest%2Ecom%2Fabout'
            'meta':
              'body': 'hihi'
              'weight': 8
              'title': 'Comments - Facebook for Developers'
              'face': 'http://graph.facebook.com/v2.7/10154232419354595/picture?type=square'
              'profileLink': 'https://www.facebook.com/app_scoped_user_id/10154232419354595/'
              'FromLink': 'https://developers.facebook.com/products/social-plugins/comments/?utm_campaign=social_plugins&utm_medium=offsite_pages&utm_source=comments_plugin'
              'ToLink': 'Linkstate.youiest.com/about'
              'ScreenshotUrl': 'https://api.urlbox.io/v1/FLMG5BM3XeqMGa42/07d8c5a90f1c223ccd0f83a8637374368bb68178/png?url=https%3A%2F%2Fdevelopers.facebook.com%2Fproducts%2Fsocial-plugins%2Fcomments%2F%3Futm_campaign%3Dsocial_plugins%26utm_medium%3Doffsite_pages%26utm_source%3Dcomments_plugin&thumb_width=320&quality=80'
              'ScreenshotUrlTo': 'https://api.urlbox.io/v1/FLMG5BM3XeqMGa42/7c81ff8950b76e157e44b1a70cfb81532f9a170c/png?url=Linkstate.youiest.com%2Fabout&thumb_width=320&quality=80'
            'author': 'S54FphiBzL3KueFF4'
            'createdAt': 1516799506419
            'title': 'Comments - Facebook for Developers'
          'http%3A%2F%2Fwww%2Ematerial-ui%2Ecom%2Fv0%2E15%2E0%2F%23%2Fcomponents%2Ffloating-action-button':
            'from': 'https%3A%2F%2Fdevelopers%2Efacebook%2Ecom%2Fproducts%2Fsocial-plugins%2Fcomments%2F%3Futm_campaign%3Dsocial_plugins%26utm_medium%3Doffsite_pages%26utm_source%3Dcomments_plugin'
            'to': 'http%3A%2F%2Fwww%2Ematerial-ui%2Ecom%2Fv0%2E15%2E0%2F%23%2Fcomponents%2Ffloating-action-button'
            'meta':
              'body': 'floating was last '
              'weight': 7
              'title': 'Comments - Facebook for Developers'
              'face': 'http://graph.facebook.com/v2.7/10154232419354595/picture?type=square'
              'profileLink': 'https://www.facebook.com/app_scoped_user_id/10154232419354595/'
              'FromLink': 'https://developers.facebook.com/products/social-plugins/comments/?utm_campaign=social_plugins&utm_medium=offsite_pages&utm_source=comments_plugin'
              'ToLink': 'http://www.material-ui.com/v0.15.0/#/components/floating-action-button'
              'ScreenshotUrl': 'https://api.urlbox.io/v1/FLMG5BM3XeqMGa42/07d8c5a90f1c223ccd0f83a8637374368bb68178/png?url=https%3A%2F%2Fdevelopers.facebook.com%2Fproducts%2Fsocial-plugins%2Fcomments%2F%3Futm_campaign%3Dsocial_plugins%26utm_medium%3Doffsite_pages%26utm_source%3Dcomments_plugin&thumb_width=320&quality=80'
              'ScreenshotUrlTo': 'https://api.urlbox.io/v1/FLMG5BM3XeqMGa42/da1d05c7c97b6a4f5473451ee8905aa7484401dd/png?url=http%3A%2F%2Fwww.material-ui.com%2Fv0.15.0%2F%23%2Fcomponents%2Ffloating-action-button&thumb_width=320&quality=80'
            'author': 'S54FphiBzL3KueFF4'
            'createdAt': 1515853396214
            'title': 'Comments - Facebook for Developers'
        'http%3A%2F%2Fwww%2Ematerial-ui%2Ecom%2Fv0%2E15%2E0%2F%23%2Fcomponents%2Ficon-button':
          'Bookmarks':
            'from': 'http%3A%2F%2Fwww%2Ematerial-ui%2Ecom%2Fv0%2E15%2E0%2F%23%2Fcomponents%2Ficon-button'
            'to': 'Bookmarks'
            'meta':
              'weight': 5
              'title': 'Icon Button - Material-UI'
              'face': 'http://graph.facebook.com/v2.7/10154232419354595/picture?type=square'
              'profileLink': 'https://www.facebook.com/app_scoped_user_id/10154232419354595/'
              'FromLink': 'http://www.material-ui.com/v0.15.0/#/components/icon-button'
              'ToLink': 'Bookmarks'
              'ScreenshotUrl': 'https://api.urlbox.io/v1/FLMG5BM3XeqMGa42/bc419c1ffae6d735068eb38564b861249f53af0f/png?url=http%3A%2F%2Fwww.material-ui.com%2Fv0.15.0%2F%23%2Fcomponents%2Ficon-button&thumb_width=320&quality=80'
              'ScreenshotUrlTo': 'https://api.urlbox.io/v1/FLMG5BM3XeqMGa42/f9ef8e3b40885a6acde8c71ffdac6aac3365525e/png?url=Bookmarks&thumb_width=320&quality=80'
            'author': 'S54FphiBzL3KueFF4'
            'createdAt': 1515752736619
            'title': 'Icon Button - Material-UI'
          'Linkstate%2Eyouiest%2Ecom%2Fabout':
            'from': 'http%3A%2F%2Fwww%2Ematerial-ui%2Ecom%2Fv0%2E15%2E0%2F%23%2Fcomponents%2Ficon-button'
            'to': 'Linkstate%2Eyouiest%2Ecom%2Fabout'
            'meta':
              'body': ''
              'weight': 7
              'title': 'Icon Button - Material-UI'
              'face': 'http://graph.facebook.com/v2.7/10154232419354595/picture?type=square'
              'profileLink': 'https://www.facebook.com/app_scoped_user_id/10154232419354595/'
              'FromLink': 'http://www.material-ui.com/v0.15.0/#/components/icon-button'
              'ToLink': 'Linkstate.youiest.com/about'
              'ScreenshotUrl': 'https://api.urlbox.io/v1/FLMG5BM3XeqMGa42/bc419c1ffae6d735068eb38564b861249f53af0f/png?url=http%3A%2F%2Fwww.material-ui.com%2Fv0.15.0%2F%23%2Fcomponents%2Ficon-button&thumb_width=320&quality=80'
              'ScreenshotUrlTo': 'https://api.urlbox.io/v1/FLMG5BM3XeqMGa42/7c81ff8950b76e157e44b1a70cfb81532f9a170c/png?url=Linkstate.youiest.com%2Fabout&thumb_width=320&quality=80'
            'author': 'S54FphiBzL3KueFF4'
            'createdAt': 1515848417835
            'title': 'Icon Button - Material-UI'
        'https%3A%2F%2Fwww%2Enpmjs%2Ecom%2Fpackage%2Fcopy-to-clipboard':
          'Bookmarks':
            'from': 'https%3A%2F%2Fwww%2Enpmjs%2Ecom%2Fpackage%2Fcopy-to-clipboard'
            'to': 'Bookmarks'
            'meta':
              'weight': 5
              'title': 'copy-to-clipboard'
              'face': 'http://graph.facebook.com/v2.7/10154232419354595/picture?type=square'
              'profileLink': 'https://www.facebook.com/app_scoped_user_id/10154232419354595/'
              'FromLink': 'https://www.npmjs.com/package/copy-to-clipboard'
              'ToLink': 'Bookmarks'
              'ScreenshotUrl': 'https://api.urlbox.io/v1/FLMG5BM3XeqMGa42/8be9bf072d4ca4620ea074275282f8e0acc74174/png?url=https%3A%2F%2Fwww.npmjs.com%2Fpackage%2Fcopy-to-clipboard&thumb_width=320&quality=80'
              'ScreenshotUrlTo': 'https://api.urlbox.io/v1/FLMG5BM3XeqMGa42/f9ef8e3b40885a6acde8c71ffdac6aac3365525e/png?url=Bookmarks&thumb_width=320&quality=80'
            'author': 'S54FphiBzL3KueFF4'
            'createdAt': 1515848424123
            'title': 'copy-to-clipboard'
          'Linkstate%2Eyouiest%2Ecom%2Fabout':
            'from': 'https%3A%2F%2Fwww%2Enpmjs%2Ecom%2Fpackage%2Fcopy-to-clipboard'
            'to': 'Linkstate%2Eyouiest%2Ecom%2Fabout'
            'meta':
              'body': 'haha'
              'weight': 6
              'title': 'copy-to-clipboard'
              'face': 'http://graph.facebook.com/v2.7/10154232419354595/picture?type=square'
              'profileLink': 'https://www.facebook.com/app_scoped_user_id/10154232419354595/'
              'FromLink': 'https://www.npmjs.com/package/copy-to-clipboard'
              'ToLink': 'Linkstate.youiest.com/about'
              'ScreenshotUrl': 'https://api.urlbox.io/v1/FLMG5BM3XeqMGa42/8be9bf072d4ca4620ea074275282f8e0acc74174/png?url=https%3A%2F%2Fwww.npmjs.com%2Fpackage%2Fcopy-to-clipboard&thumb_width=320&quality=80'
              'ScreenshotUrlTo': 'https://api.urlbox.io/v1/FLMG5BM3XeqMGa42/7c81ff8950b76e157e44b1a70cfb81532f9a170c/png?url=Linkstate.youiest.com%2Fabout&thumb_width=320&quality=80'
            'author': 'S54FphiBzL3KueFF4'
            'createdAt': 1515852726942
            'title': 'copy-to-clipboard'
        'http%3A%2F%2Fwww%2Ematerial-ui%2Ecom%2Fv0%2E15%2E0%2F%23%2Fcomponents%2Ffloating-action-button':
          'Bookmarks':
            'from': 'http%3A%2F%2Fwww%2Ematerial-ui%2Ecom%2Fv0%2E15%2E0%2F%23%2Fcomponents%2Ffloating-action-button'
            'to': 'Bookmarks'
            'meta':
              'weight': 5
              'title': 'Floating Action Button - Material-UI'
              'face': 'http://graph.facebook.com/v2.7/10154232419354595/picture?type=square'
              'profileLink': 'https://www.facebook.com/app_scoped_user_id/10154232419354595/'
              'FromLink': 'http://www.material-ui.com/v0.15.0/#/components/floating-action-button'
              'ToLink': 'Bookmarks'
              'ScreenshotUrl': 'https://api.urlbox.io/v1/FLMG5BM3XeqMGa42/da1d05c7c97b6a4f5473451ee8905aa7484401dd/png?url=http%3A%2F%2Fwww.material-ui.com%2Fv0.15.0%2F%23%2Fcomponents%2Ffloating-action-button&thumb_width=320&quality=80'
              'ScreenshotUrlTo': 'https://api.urlbox.io/v1/FLMG5BM3XeqMGa42/f9ef8e3b40885a6acde8c71ffdac6aac3365525e/png?url=Bookmarks&thumb_width=320&quality=80'
            'author': 'S54FphiBzL3KueFF4'
            'createdAt': 1515849481404
            'title': 'Floating Action Button - Material-UI'
          'Linkstate%2Eyouiest%2Ecom%2Fabout':
            'from': 'http%3A%2F%2Fwww%2Ematerial-ui%2Ecom%2Fv0%2E15%2E0%2F%23%2Fcomponents%2Ffloating-action-button'
            'to': 'Linkstate%2Eyouiest%2Ecom%2Fabout'
            'meta':
              'body': 'haha'
              'weight': 7
              'title': 'Floating Action Button - Material-UI'
              'face': 'http://graph.facebook.com/v2.7/10154232419354595/picture?type=square'
              'profileLink': 'https://www.facebook.com/app_scoped_user_id/10154232419354595/'
              'FromLink': 'http://www.material-ui.com/v0.15.0/#/components/floating-action-button'
              'ToLink': 'Linkstate.youiest.com/about'
              'ScreenshotUrl': 'https://api.urlbox.io/v1/FLMG5BM3XeqMGa42/da1d05c7c97b6a4f5473451ee8905aa7484401dd/png?url=http%3A%2F%2Fwww.material-ui.com%2Fv0.15.0%2F%23%2Fcomponents%2Ffloating-action-button&thumb_width=320&quality=80'
              'ScreenshotUrlTo': 'https://api.urlbox.io/v1/FLMG5BM3XeqMGa42/7c81ff8950b76e157e44b1a70cfb81532f9a170c/png?url=Linkstate.youiest.com%2Fabout&thumb_width=320&quality=80'
            'author': 'S54FphiBzL3KueFF4'
            'createdAt': 1515852807096
            'title': 'Floating Action Button - Material-UI'
        'https%3A%2F%2Furlbox%2Eio%2Fdashboard': 'Bookmarks':
          'from': 'https%3A%2F%2Furlbox%2Eio%2Fdashboard'
          'to': 'Bookmarks'
          'meta':
            'weight': 5
            'title': 'User Dashboard | Urlbox'
            'face': 'http://graph.facebook.com/v2.7/10154232419354595/picture?type=square'
            'profileLink': 'https://www.facebook.com/app_scoped_user_id/10154232419354595/'
            'FromLink': 'https://urlbox.io/dashboard'
            'ToLink': 'Bookmarks'
            'ScreenshotUrl': 'https://api.urlbox.io/v1/FLMG5BM3XeqMGa42/470f97a39f9047b5aedc6918697e66578003b17c/png?url=https%3A%2F%2Furlbox.io%2Fdashboard&thumb_width=320&quality=80'
            'ScreenshotUrlTo': 'https://api.urlbox.io/v1/FLMG5BM3XeqMGa42/f9ef8e3b40885a6acde8c71ffdac6aac3365525e/png?url=Bookmarks&thumb_width=320&quality=80'
          'author': 'S54FphiBzL3KueFF4'
          'createdAt': 1515852668465
          'title': 'User Dashboard | Urlbox'
        'http%3A%2F%2Fwww%2Ematerial-ui%2Ecom%2Fv0%2E15%2E0%2F%23%2Fcomponents%2Fdivider': 'Bookmarks':
          'from': 'http%3A%2F%2Fwww%2Ematerial-ui%2Ecom%2Fv0%2E15%2E0%2F%23%2Fcomponents%2Fdivider'
          'to': 'Bookmarks'
          'meta':
            'weight': 5
            'title': 'Material-UI'
            'face': 'http://graph.facebook.com/v2.7/10154232419354595/picture?type=square'
            'profileLink': 'https://www.facebook.com/app_scoped_user_id/10154232419354595/'
            'FromLink': 'http://www.material-ui.com/v0.15.0/#/components/divider'
            'ToLink': 'Bookmarks'
            'ScreenshotUrl': 'https://api.urlbox.io/v1/FLMG5BM3XeqMGa42/e01735992a16b0765be9dfff99a1e69c62c39d76/png?url=http%3A%2F%2Fwww.material-ui.com%2Fv0.15.0%2F%23%2Fcomponents%2Fdivider&thumb_width=320&quality=80'
            'ScreenshotUrlTo': 'https://api.urlbox.io/v1/FLMG5BM3XeqMGa42/f9ef8e3b40885a6acde8c71ffdac6aac3365525e/png?url=Bookmarks&thumb_width=320&quality=80'
          'author': 'S54FphiBzL3KueFF4'
          'createdAt': 1515893133244
          'title': 'Material-UI'
        'http%3A%2F%2Fwww%2Ematerial-ui%2Ecom%2Fv0%2E15%2E0%2F%23%2Fcomponents%2Fdrawer': 'Bookmarks':
          'from': 'http%3A%2F%2Fwww%2Ematerial-ui%2Ecom%2Fv0%2E15%2E0%2F%23%2Fcomponents%2Fdrawer'
          'to': 'Bookmarks'
          'meta':
            'weight': 5
            'title': 'Drawer - Material-UI'
            'face': 'http://graph.facebook.com/v2.7/10154232419354595/picture?type=square'
            'profileLink': 'https://www.facebook.com/app_scoped_user_id/10154232419354595/'
            'FromLink': 'http://www.material-ui.com/v0.15.0/#/components/drawer'
            'ToLink': 'Bookmarks'
            'ScreenshotUrl': 'https://api.urlbox.io/v1/FLMG5BM3XeqMGa42/d99ca99ca087fe2a9d1b01035322b66bd9d3530d/png?url=http%3A%2F%2Fwww.material-ui.com%2Fv0.15.0%2F%23%2Fcomponents%2Fdrawer&thumb_width=320&quality=80'
            'ScreenshotUrlTo': 'https://api.urlbox.io/v1/FLMG5BM3XeqMGa42/f9ef8e3b40885a6acde8c71ffdac6aac3365525e/png?url=Bookmarks&thumb_width=320&quality=80'
          'author': 'S54FphiBzL3KueFF4'
          'createdAt': 1515896611045
          'title': 'Drawer - Material-UI'
        'http%3A%2F%2Fwww%2Ematerial-ui%2Ecom%2Fv0%2E15%2E0%2F%23%2Fcomponents%2Fcard': 'Bookmarks':
          'from': 'http%3A%2F%2Fwww%2Ematerial-ui%2Ecom%2Fv0%2E15%2E0%2F%23%2Fcomponents%2Fcard'
          'to': 'Bookmarks'
          'meta':
            'weight': 5
            'title': 'Card - Material-UI'
            'face': 'http://graph.facebook.com/v2.7/10154232419354595/picture?type=square'
            'profileLink': 'https://www.facebook.com/app_scoped_user_id/10154232419354595/'
            'FromLink': 'http://www.material-ui.com/v0.15.0/#/components/card'
            'ToLink': 'Bookmarks'
            'ScreenshotUrl': 'https://api.urlbox.io/v1/FLMG5BM3XeqMGa42/3d5dae2cc3f8f78c54d0d14861cabdfaa6a219d1/png?url=http%3A%2F%2Fwww.material-ui.com%2Fv0.15.0%2F%23%2Fcomponents%2Fcard&thumb_width=320&quality=80'
            'ScreenshotUrlTo': 'https://api.urlbox.io/v1/FLMG5BM3XeqMGa42/f9ef8e3b40885a6acde8c71ffdac6aac3365525e/png?url=Bookmarks&thumb_width=320&quality=80'
          'author': 'S54FphiBzL3KueFF4'
          'createdAt': 1516602708478
          'title': 'Card - Material-UI'
        'http%3A%2F%2Fwww%2Ematerial-ui%2Ecom%2Fv0%2E15%2E0%2F%23%2Fcomponents%2Fgrid-list':
          'Bookmarks':
            'from': 'http%3A%2F%2Fwww%2Ematerial-ui%2Ecom%2Fv0%2E15%2E0%2F%23%2Fcomponents%2Fgrid-list'
            'to': 'Bookmarks'
            'meta':
              'weight': 5
              'title': 'Grid List - Material-UI'
              'face': 'http://graph.facebook.com/v2.7/10154232419354595/picture?type=square'
              'profileLink': 'https://www.facebook.com/app_scoped_user_id/10154232419354595/'
              'FromLink': 'http://www.material-ui.com/v0.15.0/#/components/grid-list'
              'ToLink': 'Bookmarks'
              'ScreenshotUrl': 'https://api.urlbox.io/v1/FLMG5BM3XeqMGa42/40553ece4a58fa64935a61307604420279d5a1db/png?url=http%3A%2F%2Fwww.material-ui.com%2Fv0.15.0%2F%23%2Fcomponents%2Fgrid-list&thumb_width=320&quality=80'
              'ScreenshotUrlTo': 'https://api.urlbox.io/v1/FLMG5BM3XeqMGa42/f9ef8e3b40885a6acde8c71ffdac6aac3365525e/png?url=Bookmarks&thumb_width=320&quality=80'
            'author': 'S54FphiBzL3KueFF4'
            'createdAt': 1516602730435
            'title': 'Grid List - Material-UI'
          'Linkstate%2Eyouiest%2Ecom%2Fabout':
            'from': 'http%3A%2F%2Fwww%2Ematerial-ui%2Ecom%2Fv0%2E15%2E0%2F%23%2Fcomponents%2Fgrid-list'
            'to': 'Linkstate%2Eyouiest%2Ecom%2Fabout'
            'meta':
              'body': 'haha'
              'weight': 7
              'title': 'Grid List - Material-UI'
              'face': 'http://graph.facebook.com/v2.7/10154232419354595/picture?type=square'
              'profileLink': 'https://www.facebook.com/app_scoped_user_id/10154232419354595/'
              'FromLink': 'http://www.material-ui.com/v0.15.0/#/components/grid-list'
              'ToLink': 'Linkstate.youiest.com/about'
              'ScreenshotUrl': 'https://api.urlbox.io/v1/FLMG5BM3XeqMGa42/40553ece4a58fa64935a61307604420279d5a1db/png?url=http%3A%2F%2Fwww.material-ui.com%2Fv0.15.0%2F%23%2Fcomponents%2Fgrid-list&thumb_width=320&quality=80'
              'ScreenshotUrlTo': 'https://api.urlbox.io/v1/FLMG5BM3XeqMGa42/7c81ff8950b76e157e44b1a70cfb81532f9a170c/png?url=Linkstate.youiest.com%2Fabout&thumb_width=320&quality=80'
            'author': 'S54FphiBzL3KueFF4'
            'createdAt': 1516602773161
            'title': 'Grid List - Material-UI'
        'http%3A%2F%2Fwww%2Ematerial-ui%2Ecom%2Fv0%2E15%2E0%2F%23%2Fcomponents%2Ffont-icon': 'Bookmarks':
          'from': 'http%3A%2F%2Fwww%2Ematerial-ui%2Ecom%2Fv0%2E15%2E0%2F%23%2Fcomponents%2Ffont-icon'
          'to': 'Bookmarks'
          'meta':
            'weight': 5
            'title': 'Font Icon - Material-UI'
            'face': 'http://graph.facebook.com/v2.7/10154232419354595/picture?type=square'
            'profileLink': 'https://www.facebook.com/app_scoped_user_id/10154232419354595/'
            'FromLink': 'http://www.material-ui.com/v0.15.0/#/components/font-icon'
            'ToLink': 'Bookmarks'
            'ScreenshotUrl': 'https://api.urlbox.io/v1/FLMG5BM3XeqMGa42/840d657b0c17ef752fc7a3a346c946823481644c/png?url=http%3A%2F%2Fwww.material-ui.com%2Fv0.15.0%2F%23%2Fcomponents%2Ffont-icon&thumb_width=320&quality=80'
            'ScreenshotUrlTo': 'https://api.urlbox.io/v1/FLMG5BM3XeqMGa42/f9ef8e3b40885a6acde8c71ffdac6aac3365525e/png?url=Bookmarks&thumb_width=320&quality=80'
          'author': 'S54FphiBzL3KueFF4'
          'createdAt': 1516799519649
          'title': 'Font Icon - Material-UI'
        'en%2Ewikipedia%2Eorg%2Fwiki%2Fbookmark': 'en%2Ewikipedia%2Eorg%2Fwiki%2Fbookmark':
          'from': 'en%2Ewikipedia%2Eorg%2Fwiki%2Fbookmark'
          'to': 'en%2Ewikipedia%2Eorg%2Fwiki%2Fbookmark'
          'meta':
            'title': 'Bookmarks - and other placeholders'
            'weight': 9
            'ScreenshotUrl': 'https://api.urlbox.io/v1/FLMG5BM3XeqMGa42/dfa731789ad019f3a532fe83b20d20f05f11de38/png?url=en.wikipedia.org%2Fwiki%2Fbookmark&thumb_width=320&quality=80'
            'face': 'http://graph.facebook.com/v2.7/10154232419354595/picture?type=square'
            'profileLink': 'https://www.facebook.com/app_scoped_user_id/10154232419354595/'
            'FromLink': 'en.wikipedia.org/wiki/bookmark'
            'ToLink': 'en.wikipedia.org/wiki/bookmark'
            'ScreenshotUrlTo': 'https://api.urlbox.io/v1/FLMG5BM3XeqMGa42/dfa731789ad019f3a532fe83b20d20f05f11de38/png?url=en.wikipedia.org%2Fwiki%2Fbookmark&thumb_width=320&quality=80'
          'author': 'S54FphiBzL3KueFF4'
          'createdAt': 1517192719349
          'title': 'Bookmarks - and other placeholders'
    'hits': 884
    'fromLast': 'https://www.facebook.com/app_scoped_user_id/10154232419354595/'
    'toLast': 'en.wikipedia.org/wiki/bookmark'
  'type': 'from'
  'word':
    'HeaderTitle': 'Linkstates for '
    'MainCardTitle': 'About '
    'MainCardSubtitle': 'Link it to something, find it there later'
    'TextAboutfloatingLabelText': 'TAB here to say something memorable. '
    'TextAboutHintText': 'Send with a 9 for dead on, 5 neutral, 1 oppose or 0 irrelevant.'
    'digitAlert': 'You send by entering a digit from 0 to 9 where 9 means dead on, 5 neutral and 1 opposite. The 0 means irrelevant.'
    'MyCardTitle': 'Your links to: '
    'MyCardSubtitle': 'Go to Bookmarks or your project page and your resources appear here'
    'MyCardStepsSubheader': 'You have connected from here recently'
    'AboutCardTitle': 'What\'s the word on this?'
    'AboutCardSubTitle': 'Connections talk. Yay sayers weigh in on the right.'
    'to': 'to '
    'defaultProject': 'Your last project was '
    'defaultStart': 'Last on '
    'ToTooltipText': 'TO - Point TO it to something about it.'
    'FromTooltipText': 'FROM - The place we\'re on now. Below are your bookmarks about this place.'
userOld =
  '_id': 'S54FphiBzL3KueFF4'
  'profile': 'name': 'Elias Moosman'
  'createdAt': '2018-01-11T05:57:30.482Z'
  'services': 'facebook':
    'expiresAt': 1520753914953
    'id': '10154232419354595'
    'email': 'eliasmoosman@gmail.com'
    'name': 'Elias Moosman'
    'first_name': 'Elias'
    'last_name': 'Moosman'
    'link': 'https://www.facebook.com/app_scoped_user_id/10154232419354595/'
    'gender': 'male'
    'locale': 'sv_SE'
    'age_range': 'min': 21
  'edited': 1515684523168
  'links':
    'in':
      'Bookmarks':
        'Bookmarks':
          'from': 'Bookmarks'
          'to': 'Bookmarks'
          'meta':
            'title': 'Bookmarks - and other placeholders'
            'weight': 9
            'ScreenshotUrl': 'https://api.urlbox.io/v1/FLMG5BM3XeqMGa42/png?url=Bookmarks&thumb_width=320&quality=80'
            'face': 'http://graph.facebook.com/v2.7/10154232419354595/picture?type=square'
            'profileLink': 'https://www.facebook.com/app_scoped_user_id/10154232419354595/'
            'FromLink': 'Bookmarks'
            'ToLink': 'Bookmarks'
            'ScreenshotUrlTo': 'https://api.urlbox.io/v1/FLMG5BM3XeqMGa42/png?url=Bookmarks&thumb_width=320&quality=80'
          'author': 'S54FphiBzL3KueFF4'
          'createdAt': 1515684523150
          'title': 'Bookmarks - and other placeholders'
        'https%3A%2F%2Fwww%2Efacebook%2Ecom%2Fapp_scoped_user_id%2F10154232419354595%2F':
          'from': 'https%3A%2F%2Fwww%2Efacebook%2Ecom%2Fapp_scoped_user_id%2F10154232419354595%2F'
          'to': 'Bookmarks'
          'meta':
            'title': 'Elias Moosman on Facebook'
            'weight': 7
            'face': 'http://graph.facebook.com/v2.7/10154232419354595/picture?type=square'
            'profileLink': 'https://www.facebook.com/app_scoped_user_id/10154232419354595/'
            'FromLink': 'https://www.facebook.com/app_scoped_user_id/10154232419354595/'
            'ToLink': 'Bookmarks'
            'ScreenshotUrl': 'https://api.urlbox.io/v1/FLMG5BM3XeqMGa42/png?url=https%3A%2F%2Fwww.facebook.com%2Fapp_scoped_user_id%2F10154232419354595%2F&thumb_width=320&quality=80'
            'ScreenshotUrlTo': 'https://api.urlbox.io/v1/FLMG5BM3XeqMGa42/png?url=Bookmarks&thumb_width=320&quality=80'
          'author': 'S54FphiBzL3KueFF4'
          'createdAt': 1515684523168
          'title': 'Elias Moosman on Facebook'
        'Linkstate%2Eyouiest%2Ecom':
          'from': 'Linkstate%2Eyouiest%2Ecom'
          'to': 'Bookmarks'
          'meta':
            'title': 'Linkstate - Connecting is seeing'
            'weight': 7
            'face': 'http://graph.facebook.com/v2.7/10154232419354595/picture?type=square'
            'profileLink': 'https://www.facebook.com/app_scoped_user_id/10154232419354595/'
            'FromLink': 'Linkstate.youiest.com'
            'ToLink': 'Bookmarks'
            'ScreenshotUrl': 'https://api.urlbox.io/v1/FLMG5BM3XeqMGa42/png?url=Linkstate.youiest.com&thumb_width=320&quality=80'
            'ScreenshotUrlTo': 'https://api.urlbox.io/v1/FLMG5BM3XeqMGa42/png?url=Bookmarks&thumb_width=320&quality=80'
          'author': 'S54FphiBzL3KueFF4'
          'createdAt': 1515684523158
          'title': 'Linkstate - Connecting is seeing'
        'http%3A%2F%2Flocalhost%3A3000%2Fabout%3Ffrom%3DLinkstate%2Eyouiest%2Ecom%26lastTitle%3DIcon%252520Button%252520-%252520Material-UI%26to%3DBookmarks%26Bookmarked%3Dtrue%26content%3D%26switched%3D':
          'from': 'http%3A%2F%2Flocalhost%3A3000%2Fabout%3Ffrom%3DLinkstate%2Eyouiest%2Ecom%26lastTitle%3DIcon%252520Button%252520-%252520Material-UI%26to%3DBookmarks%26Bookmarked%3Dtrue%26content%3D%26switched%3D'
          'to': 'Bookmarks'
          'meta':
            'weight': 5
            'title': 'Linkstates for Linkstate - Connecting is seeing - Linkstate.youiest.com'
            'face': 'http://graph.facebook.com/v2.7/10154232419354595/picture?type=square'
            'profileLink': 'https://www.facebook.com/app_scoped_user_id/10154232419354595/'
            'FromLink': 'http://localhost:3000/about?from=Linkstate.youiest.com&lastTitle=Icon%2520Button%2520-%2520Material-UI&to=Bookmarks&Bookmarked=true&content=&switched='
            'ToLink': 'Bookmarks'
            'ScreenshotUrl': 'https://api.urlbox.io/v1/FLMG5BM3XeqMGa42/2a97329fccd9bea5497d209c411e6a54bbd03f76/png?url=http%3A%2F%2Flocalhost%3A3000%2Fabout%3Ffrom%3DLinkstate.youiest.com%26lastTitle%3DIcon%252520Button%252520-%252520Material-UI%26to%3DBookmarks%26Bookmarked%3Dtrue%26content%3D%26switched%3D&thumb_width=320&quality=80'
            'ScreenshotUrlTo': 'https://api.urlbox.io/v1/FLMG5BM3XeqMGa42/f9ef8e3b40885a6acde8c71ffdac6aac3365525e/png?url=Bookmarks&thumb_width=320&quality=80'
          'author': 'S54FphiBzL3KueFF4'
          'createdAt': 1515650897280
          'title': 'Linkstates for Linkstate - Connecting is seeing - Linkstate.youiest.com'
      'Linkstate%2Eyouiest%2Ecom': 'Bookmarks':
        'from': 'Bookmarks'
        'to': 'Linkstate%2Eyouiest%2Ecom'
        'meta':
          'body': 'hjkkwer'
          'weight': 4
          'title': 'Bookmarks - and other placeholders'
          'face': 'http://graph.facebook.com/v2.7/10154232419354595/picture?type=square'
          'profileLink': 'https://www.facebook.com/app_scoped_user_id/10154232419354595/'
          'FromLink': 'Bookmarks'
          'ToLink': 'Linkstate.youiest.com'
          'ScreenshotUrl': 'https://api.urlbox.io/v1/FLMG5BM3XeqMGa42/f9ef8e3b40885a6acde8c71ffdac6aac3365525e/png?url=Bookmarks&thumb_width=320&quality=80'
          'ScreenshotUrlTo': 'https://api.urlbox.io/v1/FLMG5BM3XeqMGa42/117475d1c2f4d6fac7710dcc2f841e06b46e06b3/png?url=Linkstate.youiest.com&thumb_width=320&quality=80'
        'author': 'S54FphiBzL3KueFF4'
        'createdAt': 1515675012528
        'title': 'Bookmarks - and other placeholders'
      'https%3A%2F%2Fwww%2Efacebook%2Ecom%2Fapp_scoped_user_id%2F10154232419354595%2F': 'Bookmarks':
        'from': 'https%3A%2F%2Fwww%2Efacebook%2Ecom%2Fapp_scoped_user_id%2F10154232419354595%2F'
        'to': 'Bookmarks'
        'meta':
          'title': 'Elias Moosman on Facebook'
          'weight': 7
          'face': 'http://graph.facebook.com/v2.7/10154232419354595/picture?type=square'
          'profileLink': 'https://www.facebook.com/app_scoped_user_id/10154232419354595/'
          'FromLink': 'https://www.facebook.com/app_scoped_user_id/10154232419354595/'
          'ToLink': 'Bookmarks'
          'ScreenshotUrl': 'https://api.thumbalizr.com/?url=https://www.facebook.com/app_scoped_user_id/10154232419354595/&width=250&api_key=UQ6CMod6tIkVLam271a7WdUlutEJJHTE'
          'ScreenshotUrlTo': 'https://api.thumbalizr.com/?url=Bookmarks&width=250&api_key=UQ6CMod6tIkVLam271a7WdUlutEJJHTE'
        'author': 'S54FphiBzL3KueFF4'
        'createdAt': 1515650468975
        'title': 'Elias Moosman on Facebook'
      'http%3A%2F%2Flocalhost%3A3000%2Fabout%3Ffrom%3Dhttps%25253A%25252F%25252Fwww%2Efacebook%2Ecom%25252Fapp_scoped_user_id%25252F10154232419354595%25252F%26lastTitle%3DIcon%252520Button%252520-%252520Material-UI%26to%3DBookmarks%26Bookmarked%3Dtrue%26content%3Dhahah%26switched%3D': 'Bookmarks':
        'from': 'http%3A%2F%2Flocalhost%3A3000%2Fabout%3Ffrom%3Dhttps%25253A%25252F%25252Fwww%2Efacebook%2Ecom%25252Fapp_scoped_user_id%25252F10154232419354595%25252F%26lastTitle%3DIcon%252520Button%252520-%252520Material-UI%26to%3DBookmarks%26Bookmarked%3Dtrue%26content%3Dhahah%26switched%3D'
        'to': 'Bookmarks'
        'meta':
          'weight': 5
          'title': 'Linkstates for Elias Moosman on Facebook - https://www.facebook.com/app_scoped_user_id/10154232419354595/'
          'face': 'http://graph.facebook.com/v2.7/10154232419354595/picture?type=square'
          'profileLink': 'https://www.facebook.com/app_scoped_user_id/10154232419354595/'
          'FromLink': 'http://localhost:3000/about?from=https%253A%252F%252Fwww.facebook.com%252Fapp_scoped_user_id%252F10154232419354595%252F&lastTitle=Icon%2520Button%2520-%2520Material-UI&to=Bookmarks&Bookmarked=true&content=hahah&switched='
          'ToLink': 'Bookmarks'
          'ScreenshotUrl': 'https://api.thumbalizr.com/?url=http://localhost:3000/about?from=https%253A%252F%252Fwww.facebook.com%252Fapp_scoped_user_id%252F10154232419354595%252F&lastTitle=Icon%2520Button%2520-%2520Material-UI&to=Bookmarks&Bookmarked=true&content=hahah&switched=&width=250&api_key=UQ6CMod6tIkVLam271a7WdUlutEJJHTE'
          'ScreenshotUrlTo': 'https://api.thumbalizr.com/?url=Bookmarks&width=250&api_key=UQ6CMod6tIkVLam271a7WdUlutEJJHTE'
        'author': 'S54FphiBzL3KueFF4'
        'createdAt': 1515650383851
        'title': 'Linkstates for Elias Moosman on Facebook - https://www.facebook.com/app_scoped_user_id/10154232419354595/'
      'https%3A%2F%2Fstackoverflow%2Ecom%2Fquestions%2F9529078%2Fhow-do-i-use-git-reset-hard-head-to-revert-to-a-previous-commit': 'Bookmarks':
        'from': 'https%3A%2F%2Fstackoverflow%2Ecom%2Fquestions%2F9529078%2Fhow-do-i-use-git-reset-hard-head-to-revert-to-a-previous-commit'
        'to': 'Bookmarks'
        'meta':
          'weight': 5
          'title': 'How do I use \'git reset --hard HEAD\' to revert to a previous commit? - Stack Overflow'
          'face': 'http://graph.facebook.com/v2.7/10154232419354595/picture?type=square'
          'profileLink': 'https://www.facebook.com/app_scoped_user_id/10154232419354595/'
          'FromLink': 'https://stackoverflow.com/questions/9529078/how-do-i-use-git-reset-hard-head-to-revert-to-a-previous-commit'
          'ToLink': 'Bookmarks'
          'ScreenshotUrl': 'https://api.thumbalizr.com/?url=https://stackoverflow.com/questions/9529078/how-do-i-use-git-reset-hard-head-to-revert-to-a-previous-commit&width=250&api_key=UQ6CMod6tIkVLam271a7WdUlutEJJHTE'
          'ScreenshotUrlTo': 'https://api.thumbalizr.com/?url=Bookmarks&width=250&api_key=UQ6CMod6tIkVLam271a7WdUlutEJJHTE'
        'author': 'S54FphiBzL3KueFF4'
        'createdAt': 1515650480814
        'title': 'How do I use \'git reset --hard HEAD\' to revert to a previous commit? - Stack Overflow'
      'Linkstate%2Eyouiest%2Ecom%2Fabout': 'Linkstate%2Eyouiest%2Ecom':
        'from': 'Linkstate%2Eyouiest%2Ecom'
        'to': 'Linkstate%2Eyouiest%2Ecom%2Fabout'
        'meta':
          'title': 'Linkstate - Connecting is seeing'
          'weight': 8
          'body': 'The fate of bookmarks can tell us a lot about Linkstate'
          'face': 'http://graph.facebook.com/v2.7/10154232419354595/picture?type=square'
          'profileLink': 'https://www.facebook.com/app_scoped_user_id/10154232419354595/'
          'FromLink': 'Linkstate.youiest.com'
          'ToLink': 'Linkstate.youiest.com/about'
          'ScreenshotUrl': 'https://api.urlbox.io/v1/FLMG5BM3XeqMGa42/png?url=Linkstate.youiest.com&thumb_width=320&quality=80'
          'ScreenshotUrlTo': 'https://api.urlbox.io/v1/FLMG5BM3XeqMGa42/png?url=Linkstate.youiest.com%2Fabout&thumb_width=320&quality=80'
        'author': 'S54FphiBzL3KueFF4'
        'createdAt': 1515684523163
        'title': 'Linkstate - Connecting is seeing'
    'out':
      'Bookmarks':
        'Bookmarks':
          'from': 'Bookmarks'
          'to': 'Bookmarks'
          'meta':
            'title': 'Bookmarks - and other placeholders'
            'weight': 9
            'ScreenshotUrl': 'https://api.urlbox.io/v1/FLMG5BM3XeqMGa42/png?url=Bookmarks&thumb_width=320&quality=80'
            'face': 'http://graph.facebook.com/v2.7/10154232419354595/picture?type=square'
            'profileLink': 'https://www.facebook.com/app_scoped_user_id/10154232419354595/'
            'FromLink': 'Bookmarks'
            'ToLink': 'Bookmarks'
            'ScreenshotUrlTo': 'https://api.urlbox.io/v1/FLMG5BM3XeqMGa42/png?url=Bookmarks&thumb_width=320&quality=80'
          'author': 'S54FphiBzL3KueFF4'
          'createdAt': 1515684523150
          'title': 'Bookmarks - and other placeholders'
        'Linkstate%2Eyouiest%2Ecom':
          'from': 'Bookmarks'
          'to': 'Linkstate%2Eyouiest%2Ecom'
          'meta':
            'body': 'hjkkwer'
            'weight': 4
            'title': 'Bookmarks - and other placeholders'
            'face': 'http://graph.facebook.com/v2.7/10154232419354595/picture?type=square'
            'profileLink': 'https://www.facebook.com/app_scoped_user_id/10154232419354595/'
            'FromLink': 'Bookmarks'
            'ToLink': 'Linkstate.youiest.com'
            'ScreenshotUrl': 'https://api.urlbox.io/v1/FLMG5BM3XeqMGa42/f9ef8e3b40885a6acde8c71ffdac6aac3365525e/png?url=Bookmarks&thumb_width=320&quality=80'
            'ScreenshotUrlTo': 'https://api.urlbox.io/v1/FLMG5BM3XeqMGa42/117475d1c2f4d6fac7710dcc2f841e06b46e06b3/png?url=Linkstate.youiest.com&thumb_width=320&quality=80'
          'author': 'S54FphiBzL3KueFF4'
          'createdAt': 1515675012528
          'title': 'Bookmarks - and other placeholders'
        'https%3A%2F%2Fwww%2Efacebook%2Ecom%2Fapp_scoped_user_id%2F10154232419354595%2F':
          'from': 'https%3A%2F%2Fwww%2Efacebook%2Ecom%2Fapp_scoped_user_id%2F10154232419354595%2F'
          'to': 'Bookmarks'
          'meta':
            'title': 'Elias Moosman on Facebook'
            'weight': 7
            'face': 'http://graph.facebook.com/v2.7/10154232419354595/picture?type=square'
            'profileLink': 'https://www.facebook.com/app_scoped_user_id/10154232419354595/'
            'FromLink': 'https://www.facebook.com/app_scoped_user_id/10154232419354595/'
            'ToLink': 'Bookmarks'
            'ScreenshotUrl': 'https://api.thumbalizr.com/?url=https://www.facebook.com/app_scoped_user_id/10154232419354595/&width=250&api_key=UQ6CMod6tIkVLam271a7WdUlutEJJHTE'
            'ScreenshotUrlTo': 'https://api.thumbalizr.com/?url=Bookmarks&width=250&api_key=UQ6CMod6tIkVLam271a7WdUlutEJJHTE'
          'author': 'S54FphiBzL3KueFF4'
          'createdAt': 1515650468975
          'title': 'Elias Moosman on Facebook'
        'http%3A%2F%2Flocalhost%3A3000%2Fabout%3Ffrom%3Dhttps%25253A%25252F%25252Fwww%2Efacebook%2Ecom%25252Fapp_scoped_user_id%25252F10154232419354595%25252F%26lastTitle%3DIcon%252520Button%252520-%252520Material-UI%26to%3DBookmarks%26Bookmarked%3Dtrue%26content%3Dhahah%26switched%3D':
          'from': 'http%3A%2F%2Flocalhost%3A3000%2Fabout%3Ffrom%3Dhttps%25253A%25252F%25252Fwww%2Efacebook%2Ecom%25252Fapp_scoped_user_id%25252F10154232419354595%25252F%26lastTitle%3DIcon%252520Button%252520-%252520Material-UI%26to%3DBookmarks%26Bookmarked%3Dtrue%26content%3Dhahah%26switched%3D'
          'to': 'Bookmarks'
          'meta':
            'weight': 5
            'title': 'Linkstates for Elias Moosman on Facebook - https://www.facebook.com/app_scoped_user_id/10154232419354595/'
            'face': 'http://graph.facebook.com/v2.7/10154232419354595/picture?type=square'
            'profileLink': 'https://www.facebook.com/app_scoped_user_id/10154232419354595/'
            'FromLink': 'http://localhost:3000/about?from=https%253A%252F%252Fwww.facebook.com%252Fapp_scoped_user_id%252F10154232419354595%252F&lastTitle=Icon%2520Button%2520-%2520Material-UI&to=Bookmarks&Bookmarked=true&content=hahah&switched='
            'ToLink': 'Bookmarks'
            'ScreenshotUrl': 'https://api.thumbalizr.com/?url=http://localhost:3000/about?from=https%253A%252F%252Fwww.facebook.com%252Fapp_scoped_user_id%252F10154232419354595%252F&lastTitle=Icon%2520Button%2520-%2520Material-UI&to=Bookmarks&Bookmarked=true&content=hahah&switched=&width=250&api_key=UQ6CMod6tIkVLam271a7WdUlutEJJHTE'
            'ScreenshotUrlTo': 'https://api.thumbalizr.com/?url=Bookmarks&width=250&api_key=UQ6CMod6tIkVLam271a7WdUlutEJJHTE'
          'author': 'S54FphiBzL3KueFF4'
          'createdAt': 1515650383851
          'title': 'Linkstates for Elias Moosman on Facebook - https://www.facebook.com/app_scoped_user_id/10154232419354595/'
        'https%3A%2F%2Fstackoverflow%2Ecom%2Fquestions%2F9529078%2Fhow-do-i-use-git-reset-hard-head-to-revert-to-a-previous-commit':
          'from': 'https%3A%2F%2Fstackoverflow%2Ecom%2Fquestions%2F9529078%2Fhow-do-i-use-git-reset-hard-head-to-revert-to-a-previous-commit'
          'to': 'Bookmarks'
          'meta':
            'weight': 5
            'title': 'How do I use \'git reset --hard HEAD\' to revert to a previous commit? - Stack Overflow'
            'face': 'http://graph.facebook.com/v2.7/10154232419354595/picture?type=square'
            'profileLink': 'https://www.facebook.com/app_scoped_user_id/10154232419354595/'
            'FromLink': 'https://stackoverflow.com/questions/9529078/how-do-i-use-git-reset-hard-head-to-revert-to-a-previous-commit'
            'ToLink': 'Bookmarks'
            'ScreenshotUrl': 'https://api.thumbalizr.com/?url=https://stackoverflow.com/questions/9529078/how-do-i-use-git-reset-hard-head-to-revert-to-a-previous-commit&width=250&api_key=UQ6CMod6tIkVLam271a7WdUlutEJJHTE'
            'ScreenshotUrlTo': 'https://api.thumbalizr.com/?url=Bookmarks&width=250&api_key=UQ6CMod6tIkVLam271a7WdUlutEJJHTE'
          'author': 'S54FphiBzL3KueFF4'
          'createdAt': 1515650480814
          'title': 'How do I use \'git reset --hard HEAD\' to revert to a previous commit? - Stack Overflow'
      'https%3A%2F%2Fwww%2Efacebook%2Ecom%2Fapp_scoped_user_id%2F10154232419354595%2F': 'Bookmarks':
        'from': 'https%3A%2F%2Fwww%2Efacebook%2Ecom%2Fapp_scoped_user_id%2F10154232419354595%2F'
        'to': 'Bookmarks'
        'meta':
          'title': 'Elias Moosman on Facebook'
          'weight': 7
          'face': 'http://graph.facebook.com/v2.7/10154232419354595/picture?type=square'
          'profileLink': 'https://www.facebook.com/app_scoped_user_id/10154232419354595/'
          'FromLink': 'https://www.facebook.com/app_scoped_user_id/10154232419354595/'
          'ToLink': 'Bookmarks'
          'ScreenshotUrl': 'https://api.urlbox.io/v1/FLMG5BM3XeqMGa42/png?url=https%3A%2F%2Fwww.facebook.com%2Fapp_scoped_user_id%2F10154232419354595%2F&thumb_width=320&quality=80'
          'ScreenshotUrlTo': 'https://api.urlbox.io/v1/FLMG5BM3XeqMGa42/png?url=Bookmarks&thumb_width=320&quality=80'
        'author': 'S54FphiBzL3KueFF4'
        'createdAt': 1515684523168
        'title': 'Elias Moosman on Facebook'
      'Linkstate%2Eyouiest%2Ecom':
        'Bookmarks':
          'from': 'Linkstate%2Eyouiest%2Ecom'
          'to': 'Bookmarks'
          'meta':
            'title': 'Linkstate - Connecting is seeing'
            'weight': 7
            'face': 'http://graph.facebook.com/v2.7/10154232419354595/picture?type=square'
            'profileLink': 'https://www.facebook.com/app_scoped_user_id/10154232419354595/'
            'FromLink': 'Linkstate.youiest.com'
            'ToLink': 'Bookmarks'
            'ScreenshotUrl': 'https://api.urlbox.io/v1/FLMG5BM3XeqMGa42/png?url=Linkstate.youiest.com&thumb_width=320&quality=80'
            'ScreenshotUrlTo': 'https://api.urlbox.io/v1/FLMG5BM3XeqMGa42/png?url=Bookmarks&thumb_width=320&quality=80'
          'author': 'S54FphiBzL3KueFF4'
          'createdAt': 1515684523158
          'title': 'Linkstate - Connecting is seeing'
        'Linkstate%2Eyouiest%2Ecom%2Fabout':
          'from': 'Linkstate%2Eyouiest%2Ecom'
          'to': 'Linkstate%2Eyouiest%2Ecom%2Fabout'
          'meta':
            'title': 'Linkstate - Connecting is seeing'
            'weight': 8
            'body': 'The fate of bookmarks can tell us a lot about Linkstate'
            'face': 'http://graph.facebook.com/v2.7/10154232419354595/picture?type=square'
            'profileLink': 'https://www.facebook.com/app_scoped_user_id/10154232419354595/'
            'FromLink': 'Linkstate.youiest.com'
            'ToLink': 'Linkstate.youiest.com/about'
            'ScreenshotUrl': 'https://api.urlbox.io/v1/FLMG5BM3XeqMGa42/png?url=Linkstate.youiest.com&thumb_width=320&quality=80'
            'ScreenshotUrlTo': 'https://api.urlbox.io/v1/FLMG5BM3XeqMGa42/png?url=Linkstate.youiest.com%2Fabout&thumb_width=320&quality=80'
          'author': 'S54FphiBzL3KueFF4'
          'createdAt': 1515684523163
          'title': 'Linkstate - Connecting is seeing'
      'http%3A%2F%2Flocalhost%3A3000%2Fabout%3Ffrom%3DLinkstate%2Eyouiest%2Ecom%26lastTitle%3DIcon%252520Button%252520-%252520Material-UI%26to%3DBookmarks%26Bookmarked%3Dtrue%26content%3D%26switched%3D': 'Bookmarks':
        'from': 'http%3A%2F%2Flocalhost%3A3000%2Fabout%3Ffrom%3DLinkstate%2Eyouiest%2Ecom%26lastTitle%3DIcon%252520Button%252520-%252520Material-UI%26to%3DBookmarks%26Bookmarked%3Dtrue%26content%3D%26switched%3D'
        'to': 'Bookmarks'
        'meta':
          'weight': 5
          'title': 'Linkstates for Linkstate - Connecting is seeing - Linkstate.youiest.com'
          'face': 'http://graph.facebook.com/v2.7/10154232419354595/picture?type=square'
          'profileLink': 'https://www.facebook.com/app_scoped_user_id/10154232419354595/'
          'FromLink': 'http://localhost:3000/about?from=Linkstate.youiest.com&lastTitle=Icon%2520Button%2520-%2520Material-UI&to=Bookmarks&Bookmarked=true&content=&switched='
          'ToLink': 'Bookmarks'
          'ScreenshotUrl': 'https://api.urlbox.io/v1/FLMG5BM3XeqMGa42/2a97329fccd9bea5497d209c411e6a54bbd03f76/png?url=http%3A%2F%2Flocalhost%3A3000%2Fabout%3Ffrom%3DLinkstate.youiest.com%26lastTitle%3DIcon%252520Button%252520-%252520Material-UI%26to%3DBookmarks%26Bookmarked%3Dtrue%26content%3D%26switched%3D&thumb_width=320&quality=80'
          'ScreenshotUrlTo': 'https://api.urlbox.io/v1/FLMG5BM3XeqMGa42/f9ef8e3b40885a6acde8c71ffdac6aac3365525e/png?url=Bookmarks&thumb_width=320&quality=80'
        'author': 'S54FphiBzL3KueFF4'
        'createdAt': 1515650897280
        'title': 'Linkstates for Linkstate - Connecting is seeing - Linkstate.youiest.com'
  'hits': 680
  'fromLast': 'https://www.facebook.com/app_scoped_user_id/10154232419354595/'
  'toLast': 'Linkstate.youiest.com/about'
user =
  '_id': 'S54FphiBzL3KueFF4'
  'profile': 'name': 'Elias Moosman'
  'createdAt': '2018-01-11T05:57:30.482Z'
  'services':
    'facebook':
      'expiresAt': 1520753914953
      'id': '10154232419354595'
      'email': 'eliasmoosman@gmail.com'
      'name': 'Elias Moosman'
      'first_name': 'Elias'
      'last_name': 'Moosman'
      'link': 'https://www.facebook.com/app_scoped_user_id/10154232419354595/'
      'gender': 'male'
      'locale': 'sv_SE'
      'age_range': 'min': 21
    'thumbalizr': null
  'edited': 1515745059357
  'links':
    'in':
      'Bookmarks':
        'Bookmarks':
          'from': 'Bookmarks'
          'to': 'Bookmarks'
          'meta':
            'title': 'Bookmarks - and other placeholders'
            'weight': 9
            'ScreenshotUrl': 'https://api.urlbox.io/v1/FLMG5BM3XeqMGa42/f9ef8e3b40885a6acde8c71ffdac6aac3365525e/png?url=Bookmarks&thumb_width=320&quality=80'
            'face': 'http://graph.facebook.com/v2.7/10154232419354595/picture?type=square'
            'profileLink': 'https://www.facebook.com/app_scoped_user_id/10154232419354595/'
            'FromLink': 'Bookmarks'
            'ToLink': 'Bookmarks'
            'ScreenshotUrlTo': 'https://api.urlbox.io/v1/FLMG5BM3XeqMGa42/f9ef8e3b40885a6acde8c71ffdac6aac3365525e/png?url=Bookmarks&thumb_width=320&quality=80'
          'author': 'S54FphiBzL3KueFF4'
          'createdAt': 1515745059109
          'title': 'Bookmarks - and other placeholders'
        'https%3A%2F%2Fwww%2Efacebook%2Ecom%2Fapp_scoped_user_id%2F10154232419354595%2F':
          'from': 'https%3A%2F%2Fwww%2Efacebook%2Ecom%2Fapp_scoped_user_id%2F10154232419354595%2F'
          'to': 'Bookmarks'
          'meta':
            'title': 'Elias Moosman on Facebook'
            'weight': 7
            'face': 'http://graph.facebook.com/v2.7/10154232419354595/picture?type=square'
            'profileLink': 'https://www.facebook.com/app_scoped_user_id/10154232419354595/'
            'FromLink': 'https://www.facebook.com/app_scoped_user_id/10154232419354595/'
            'ToLink': 'Bookmarks'
            'ScreenshotUrl': 'https://api.urlbox.io/v1/FLMG5BM3XeqMGa42/9b1a5f128cbac84d2142d3377200235906e5a39e/png?url=https%3A%2F%2Fwww.facebook.com%2Fapp_scoped_user_id%2F10154232419354595%2F&thumb_width=320&quality=80'
            'ScreenshotUrlTo': 'https://api.urlbox.io/v1/FLMG5BM3XeqMGa42/f9ef8e3b40885a6acde8c71ffdac6aac3365525e/png?url=Bookmarks&thumb_width=320&quality=80'
          'author': 'S54FphiBzL3KueFF4'
          'createdAt': 1515745059357
          'title': 'Elias Moosman on Facebook'
        'Linkstate%2Eyouiest%2Ecom':
          'from': 'Linkstate%2Eyouiest%2Ecom'
          'to': 'Bookmarks'
          'meta':
            'title': 'Linkstate - Connecting is seeing'
            'weight': 7
            'face': 'http://graph.facebook.com/v2.7/10154232419354595/picture?type=square'
            'profileLink': 'https://www.facebook.com/app_scoped_user_id/10154232419354595/'
            'FromLink': 'Linkstate.youiest.com'
            'ToLink': 'Bookmarks'
            'ScreenshotUrl': 'https://api.urlbox.io/v1/FLMG5BM3XeqMGa42/117475d1c2f4d6fac7710dcc2f841e06b46e06b3/png?url=Linkstate.youiest.com&thumb_width=320&quality=80'
            'ScreenshotUrlTo': 'https://api.urlbox.io/v1/FLMG5BM3XeqMGa42/f9ef8e3b40885a6acde8c71ffdac6aac3365525e/png?url=Bookmarks&thumb_width=320&quality=80'
          'author': 'S54FphiBzL3KueFF4'
          'createdAt': 1515745036583
          'title': 'Linkstate - Connecting is seeing'
        'http%3A%2F%2Flocalhost%3A3000%2Fabout%3Ffrom%3DLinkstate%2Eyouiest%2Ecom%26lastTitle%3DIcon%252520Button%252520-%252520Material-UI%26to%3DBookmarks%26Bookmarked%3Dtrue%26content%3D%26switched%3D':
          'from': 'http%3A%2F%2Flocalhost%3A3000%2Fabout%3Ffrom%3DLinkstate%2Eyouiest%2Ecom%26lastTitle%3DIcon%252520Button%252520-%252520Material-UI%26to%3DBookmarks%26Bookmarked%3Dtrue%26content%3D%26switched%3D'
          'to': 'Bookmarks'
          'meta':
            'weight': 5
            'title': 'Linkstates for Linkstate - Connecting is seeing - Linkstate.youiest.com'
            'face': 'http://graph.facebook.com/v2.7/10154232419354595/picture?type=square'
            'profileLink': 'https://www.facebook.com/app_scoped_user_id/10154232419354595/'
            'FromLink': 'http://localhost:3000/about?from=Linkstate.youiest.com&lastTitle=Icon%2520Button%2520-%2520Material-UI&to=Bookmarks&Bookmarked=true&content=&switched='
            'ToLink': 'Bookmarks'
            'ScreenshotUrl': 'https://api.urlbox.io/v1/FLMG5BM3XeqMGa42/2a97329fccd9bea5497d209c411e6a54bbd03f76/png?url=http%3A%2F%2Flocalhost%3A3000%2Fabout%3Ffrom%3DLinkstate.youiest.com%26lastTitle%3DIcon%252520Button%252520-%252520Material-UI%26to%3DBookmarks%26Bookmarked%3Dtrue%26content%3D%26switched%3D&thumb_width=320&quality=80'
            'ScreenshotUrlTo': 'https://api.urlbox.io/v1/FLMG5BM3XeqMGa42/f9ef8e3b40885a6acde8c71ffdac6aac3365525e/png?url=Bookmarks&thumb_width=320&quality=80'
          'author': 'S54FphiBzL3KueFF4'
          'createdAt': 1515650897280
          'title': 'Linkstates for Linkstate - Connecting is seeing - Linkstate.youiest.com'
        'https%3A%2F%2Fwww%2Efacebook%2Ecom%2FvViber%3Flst%3D532514594%253A532514594%253A1514878343':
          'from': 'https%3A%2F%2Fwww%2Efacebook%2Ecom%2FvViber%3Flst%3D532514594%253A532514594%253A1514878343'
          'to': 'Bookmarks'
          'meta':
            'weight': 5
            'title': '(2) Elias Moosman'
            'face': 'http://graph.facebook.com/v2.7/10154232419354595/picture?type=square'
            'profileLink': 'https://www.facebook.com/app_scoped_user_id/10154232419354595/'
            'FromLink': 'https://www.facebook.com/vViber?lst=532514594%3A532514594%3A1514878343'
            'ToLink': 'Bookmarks'
            'ScreenshotUrl': 'https://api.urlbox.io/v1/FLMG5BM3XeqMGa42/7f5979875238b6c4bc73ccfc7f6ec691414e8c8a/png?url=https%3A%2F%2Fwww.facebook.com%2FvViber%3Flst%3D532514594%253A532514594%253A1514878343&thumb_width=320&quality=80'
            'ScreenshotUrlTo': 'https://api.urlbox.io/v1/FLMG5BM3XeqMGa42/f9ef8e3b40885a6acde8c71ffdac6aac3365525e/png?url=Bookmarks&thumb_width=320&quality=80'
          'author': 'S54FphiBzL3KueFF4'
          'createdAt': 1515728165362
          'title': '(2) Elias Moosman'
        'http%3A%2F%2Flocalhost%3A3000%2Fabout%3Ffrom%3DLinkstate%2Eyouiest%2Ecom%26lastTitle%3DIcon%252520Button%252520-%252520Material-UI%26to%3DLinkstate%2Eyouiest%2Ecom%26Bookmarked%3Dtrue%26content%3D%26switched%3D':
          'from': 'http%3A%2F%2Flocalhost%3A3000%2Fabout%3Ffrom%3DLinkstate%2Eyouiest%2Ecom%26lastTitle%3DIcon%252520Button%252520-%252520Material-UI%26to%3DLinkstate%2Eyouiest%2Ecom%26Bookmarked%3Dtrue%26content%3D%26switched%3D'
          'to': 'Bookmarks'
          'meta':
            'weight': 5
            'title': 'Linkstates for Linkstate - Connecting is seeing - Linkstate.youiest.com'
            'face': 'http://graph.facebook.com/v2.7/10154232419354595/picture?type=square'
            'profileLink': 'https://www.facebook.com/app_scoped_user_id/10154232419354595/'
            'FromLink': 'http://localhost:3000/about?from=Linkstate.youiest.com&lastTitle=Icon%2520Button%2520-%2520Material-UI&to=Linkstate.youiest.com&Bookmarked=true&content=&switched='
            'ToLink': 'Bookmarks'
            'ScreenshotUrl': 'https://api.urlbox.io/v1/FLMG5BM3XeqMGa42/7e9eca309d75b57045a48ca0cda20fa74c9c66b0/png?url=http%3A%2F%2Flocalhost%3A3000%2Fabout%3Ffrom%3DLinkstate.youiest.com%26lastTitle%3DIcon%252520Button%252520-%252520Material-UI%26to%3DLinkstate.youiest.com%26Bookmarked%3Dtrue%26content%3D%26switched%3D&thumb_width=320&quality=80'
            'ScreenshotUrlTo': 'https://api.urlbox.io/v1/FLMG5BM3XeqMGa42/f9ef8e3b40885a6acde8c71ffdac6aac3365525e/png?url=Bookmarks&thumb_width=320&quality=80'
          'author': 'S54FphiBzL3KueFF4'
          'createdAt': 1515728156303
          'title': 'Linkstates for Linkstate - Connecting is seeing - Linkstate.youiest.com'
        'Linkstate%2Eyouiest%2Ecom%2Fabout':
          'from': 'Linkstate%2Eyouiest%2Ecom%2Fabout'
          'to': 'Bookmarks'
          'meta':
            'title': 'Linkstate - Connecting is seeing'
            'weight': 7
            'face': 'http://graph.facebook.com/v2.7/10154232419354595/picture?type=square'
            'profileLink': 'https://www.facebook.com/app_scoped_user_id/10154232419354595/'
            'FromLink': 'Linkstate.youiest.com/about'
            'ToLink': 'Bookmarks'
            'ScreenshotUrl': 'https://api.urlbox.io/v1/FLMG5BM3XeqMGa42/7c81ff8950b76e157e44b1a70cfb81532f9a170c/png?url=Linkstate.youiest.com%2Fabout&thumb_width=320&quality=80'
            'ScreenshotUrlTo': 'https://api.urlbox.io/v1/FLMG5BM3XeqMGa42/f9ef8e3b40885a6acde8c71ffdac6aac3365525e/png?url=Bookmarks&thumb_width=320&quality=80'
          'author': 'S54FphiBzL3KueFF4'
          'createdAt': 1515745059202
          'title': 'Linkstate - Connecting is seeing'
      'Linkstate%2Eyouiest%2Ecom': 'Bookmarks':
        'from': 'Bookmarks'
        'to': 'Linkstate%2Eyouiest%2Ecom'
        'meta':
          'body': 'hjkkwer'
          'weight': 4
          'title': 'Bookmarks - and other placeholders'
          'face': 'http://graph.facebook.com/v2.7/10154232419354595/picture?type=square'
          'profileLink': 'https://www.facebook.com/app_scoped_user_id/10154232419354595/'
          'FromLink': 'Bookmarks'
          'ToLink': 'Linkstate.youiest.com'
          'ScreenshotUrl': 'https://api.urlbox.io/v1/FLMG5BM3XeqMGa42/f9ef8e3b40885a6acde8c71ffdac6aac3365525e/png?url=Bookmarks&thumb_width=320&quality=80'
          'ScreenshotUrlTo': 'https://api.urlbox.io/v1/FLMG5BM3XeqMGa42/117475d1c2f4d6fac7710dcc2f841e06b46e06b3/png?url=Linkstate.youiest.com&thumb_width=320&quality=80'
        'author': 'S54FphiBzL3KueFF4'
        'createdAt': 1515675012528
        'title': 'Bookmarks - and other placeholders'
      'https%3A%2F%2Fwww%2Efacebook%2Ecom%2Fapp_scoped_user_id%2F10154232419354595%2F': 'Bookmarks':
        'from': 'https%3A%2F%2Fwww%2Efacebook%2Ecom%2Fapp_scoped_user_id%2F10154232419354595%2F'
        'to': 'Bookmarks'
        'meta':
          'title': 'Elias Moosman on Facebook'
          'weight': 7
          'face': 'http://graph.facebook.com/v2.7/10154232419354595/picture?type=square'
          'profileLink': 'https://www.facebook.com/app_scoped_user_id/10154232419354595/'
          'FromLink': 'https://www.facebook.com/app_scoped_user_id/10154232419354595/'
          'ToLink': 'Bookmarks'
          'ScreenshotUrl': 'https://api.thumbalizr.com/?url=https://www.facebook.com/app_scoped_user_id/10154232419354595/&width=250&api_key=UQ6CMod6tIkVLam271a7WdUlutEJJHTE'
          'ScreenshotUrlTo': 'https://api.thumbalizr.com/?url=Bookmarks&width=250&api_key=UQ6CMod6tIkVLam271a7WdUlutEJJHTE'
        'author': 'S54FphiBzL3KueFF4'
        'createdAt': 1515650468975
        'title': 'Elias Moosman on Facebook'
      'http%3A%2F%2Flocalhost%3A3000%2Fabout%3Ffrom%3Dhttps%25253A%25252F%25252Fwww%2Efacebook%2Ecom%25252Fapp_scoped_user_id%25252F10154232419354595%25252F%26lastTitle%3DIcon%252520Button%252520-%252520Material-UI%26to%3DBookmarks%26Bookmarked%3Dtrue%26content%3Dhahah%26switched%3D': 'Bookmarks':
        'from': 'http%3A%2F%2Flocalhost%3A3000%2Fabout%3Ffrom%3Dhttps%25253A%25252F%25252Fwww%2Efacebook%2Ecom%25252Fapp_scoped_user_id%25252F10154232419354595%25252F%26lastTitle%3DIcon%252520Button%252520-%252520Material-UI%26to%3DBookmarks%26Bookmarked%3Dtrue%26content%3Dhahah%26switched%3D'
        'to': 'Bookmarks'
        'meta':
          'weight': 5
          'title': 'Linkstates for Elias Moosman on Facebook - https://www.facebook.com/app_scoped_user_id/10154232419354595/'
          'face': 'http://graph.facebook.com/v2.7/10154232419354595/picture?type=square'
          'profileLink': 'https://www.facebook.com/app_scoped_user_id/10154232419354595/'
          'FromLink': 'http://localhost:3000/about?from=https%253A%252F%252Fwww.facebook.com%252Fapp_scoped_user_id%252F10154232419354595%252F&lastTitle=Icon%2520Button%2520-%2520Material-UI&to=Bookmarks&Bookmarked=true&content=hahah&switched='
          'ToLink': 'Bookmarks'
          'ScreenshotUrl': 'https://api.thumbalizr.com/?url=http://localhost:3000/about?from=https%253A%252F%252Fwww.facebook.com%252Fapp_scoped_user_id%252F10154232419354595%252F&lastTitle=Icon%2520Button%2520-%2520Material-UI&to=Bookmarks&Bookmarked=true&content=hahah&switched=&width=250&api_key=UQ6CMod6tIkVLam271a7WdUlutEJJHTE'
          'ScreenshotUrlTo': 'https://api.thumbalizr.com/?url=Bookmarks&width=250&api_key=UQ6CMod6tIkVLam271a7WdUlutEJJHTE'
        'author': 'S54FphiBzL3KueFF4'
        'createdAt': 1515650383851
        'title': 'Linkstates for Elias Moosman on Facebook - https://www.facebook.com/app_scoped_user_id/10154232419354595/'
      'https%3A%2F%2Fstackoverflow%2Ecom%2Fquestions%2F9529078%2Fhow-do-i-use-git-reset-hard-head-to-revert-to-a-previous-commit': 'Bookmarks':
        'from': 'https%3A%2F%2Fstackoverflow%2Ecom%2Fquestions%2F9529078%2Fhow-do-i-use-git-reset-hard-head-to-revert-to-a-previous-commit'
        'to': 'Bookmarks'
        'meta':
          'weight': 5
          'title': 'How do I use \'git reset --hard HEAD\' to revert to a previous commit? - Stack Overflow'
          'face': 'http://graph.facebook.com/v2.7/10154232419354595/picture?type=square'
          'profileLink': 'https://www.facebook.com/app_scoped_user_id/10154232419354595/'
          'FromLink': 'https://stackoverflow.com/questions/9529078/how-do-i-use-git-reset-hard-head-to-revert-to-a-previous-commit'
          'ToLink': 'Bookmarks'
          'ScreenshotUrl': 'https://api.thumbalizr.com/?url=https://stackoverflow.com/questions/9529078/how-do-i-use-git-reset-hard-head-to-revert-to-a-previous-commit&width=250&api_key=UQ6CMod6tIkVLam271a7WdUlutEJJHTE'
          'ScreenshotUrlTo': 'https://api.thumbalizr.com/?url=Bookmarks&width=250&api_key=UQ6CMod6tIkVLam271a7WdUlutEJJHTE'
        'author': 'S54FphiBzL3KueFF4'
        'createdAt': 1515650480814
        'title': 'How do I use \'git reset --hard HEAD\' to revert to a previous commit? - Stack Overflow'
      'Linkstate%2Eyouiest%2Ecom%2Fabout':
        'Linkstate%2Eyouiest%2Ecom':
          'from': 'Linkstate%2Eyouiest%2Ecom'
          'to': 'Linkstate%2Eyouiest%2Ecom%2Fabout'
          'meta':
            'title': 'Linkstate - Connecting is seeing'
            'weight': 8
            'body': 'The fate of bookmarks can tell us a lot about Linkstate'
            'face': 'http://graph.facebook.com/v2.7/10154232419354595/picture?type=square'
            'profileLink': 'https://www.facebook.com/app_scoped_user_id/10154232419354595/'
            'FromLink': 'Linkstate.youiest.com'
            'ToLink': 'Linkstate.youiest.com/about'
            'ScreenshotUrl': 'https://api.urlbox.io/v1/FLMG5BM3XeqMGa42/117475d1c2f4d6fac7710dcc2f841e06b46e06b3/png?url=Linkstate.youiest.com&thumb_width=320&quality=80'
            'ScreenshotUrlTo': 'https://api.urlbox.io/v1/FLMG5BM3XeqMGa42/7c81ff8950b76e157e44b1a70cfb81532f9a170c/png?url=Linkstate.youiest.com%2Fabout&thumb_width=320&quality=80'
          'author': 'S54FphiBzL3KueFF4'
          'createdAt': 1515744706613
          'title': 'Linkstate - Connecting is seeing'
        'Linkstate%2Eyouiest%2Ecom%2Fabout':
          'from': 'Linkstate%2Eyouiest%2Ecom%2Fabout'
          'to': 'Linkstate%2Eyouiest%2Ecom%2Fabout'
          'meta':
            'title': 'Linkstate - Connecting is seeing'
            'weight': 8
            'body': 'The fate of bookmarks can tell us a lot about Linkstate'
            'face': 'http://graph.facebook.com/v2.7/10154232419354595/picture?type=square'
            'profileLink': 'https://www.facebook.com/app_scoped_user_id/10154232419354595/'
            'FromLink': 'Linkstate.youiest.com/about'
            'ToLink': 'Linkstate.youiest.com/about'
            'ScreenshotUrl': 'https://api.urlbox.io/v1/FLMG5BM3XeqMGa42/7c81ff8950b76e157e44b1a70cfb81532f9a170c/png?url=Linkstate.youiest.com%2Fabout&thumb_width=320&quality=80'
            'ScreenshotUrlTo': 'https://api.urlbox.io/v1/FLMG5BM3XeqMGa42/7c81ff8950b76e157e44b1a70cfb81532f9a170c/png?url=Linkstate.youiest.com%2Fabout&thumb_width=320&quality=80'
          'author': 'S54FphiBzL3KueFF4'
          'createdAt': 1515745059277
          'title': 'Linkstate - Connecting is seeing'
    'out':
      'Bookmarks':
        'Bookmarks':
          'from': 'Bookmarks'
          'to': 'Bookmarks'
          'meta':
            'title': 'Bookmarks - and other placeholders'
            'weight': 9
            'ScreenshotUrl': 'https://api.urlbox.io/v1/FLMG5BM3XeqMGa42/f9ef8e3b40885a6acde8c71ffdac6aac3365525e/png?url=Bookmarks&thumb_width=320&quality=80'
            'face': 'http://graph.facebook.com/v2.7/10154232419354595/picture?type=square'
            'profileLink': 'https://www.facebook.com/app_scoped_user_id/10154232419354595/'
            'FromLink': 'Bookmarks'
            'ToLink': 'Bookmarks'
            'ScreenshotUrlTo': 'https://api.urlbox.io/v1/FLMG5BM3XeqMGa42/f9ef8e3b40885a6acde8c71ffdac6aac3365525e/png?url=Bookmarks&thumb_width=320&quality=80'
          'author': 'S54FphiBzL3KueFF4'
          'createdAt': 1515745059109
          'title': 'Bookmarks - and other placeholders'
        'Linkstate%2Eyouiest%2Ecom':
          'from': 'Bookmarks'
          'to': 'Linkstate%2Eyouiest%2Ecom'
          'meta':
            'body': 'hjkkwer'
            'weight': 4
            'title': 'Bookmarks - and other placeholders'
            'face': 'http://graph.facebook.com/v2.7/10154232419354595/picture?type=square'
            'profileLink': 'https://www.facebook.com/app_scoped_user_id/10154232419354595/'
            'FromLink': 'Bookmarks'
            'ToLink': 'Linkstate.youiest.com'
            'ScreenshotUrl': 'https://api.urlbox.io/v1/FLMG5BM3XeqMGa42/f9ef8e3b40885a6acde8c71ffdac6aac3365525e/png?url=Bookmarks&thumb_width=320&quality=80'
            'ScreenshotUrlTo': 'https://api.urlbox.io/v1/FLMG5BM3XeqMGa42/117475d1c2f4d6fac7710dcc2f841e06b46e06b3/png?url=Linkstate.youiest.com&thumb_width=320&quality=80'
          'author': 'S54FphiBzL3KueFF4'
          'createdAt': 1515675012528
          'title': 'Bookmarks - and other placeholders'
        'https%3A%2F%2Fwww%2Efacebook%2Ecom%2Fapp_scoped_user_id%2F10154232419354595%2F':
          'from': 'https%3A%2F%2Fwww%2Efacebook%2Ecom%2Fapp_scoped_user_id%2F10154232419354595%2F'
          'to': 'Bookmarks'
          'meta':
            'title': 'Elias Moosman on Facebook'
            'weight': 7
            'face': 'http://graph.facebook.com/v2.7/10154232419354595/picture?type=square'
            'profileLink': 'https://www.facebook.com/app_scoped_user_id/10154232419354595/'
            'FromLink': 'https://www.facebook.com/app_scoped_user_id/10154232419354595/'
            'ToLink': 'Bookmarks'
            'ScreenshotUrl': 'https://api.thumbalizr.com/?url=https://www.facebook.com/app_scoped_user_id/10154232419354595/&width=250&api_key=UQ6CMod6tIkVLam271a7WdUlutEJJHTE'
            'ScreenshotUrlTo': 'https://api.thumbalizr.com/?url=Bookmarks&width=250&api_key=UQ6CMod6tIkVLam271a7WdUlutEJJHTE'
          'author': 'S54FphiBzL3KueFF4'
          'createdAt': 1515650468975
          'title': 'Elias Moosman on Facebook'
        'http%3A%2F%2Flocalhost%3A3000%2Fabout%3Ffrom%3Dhttps%25253A%25252F%25252Fwww%2Efacebook%2Ecom%25252Fapp_scoped_user_id%25252F10154232419354595%25252F%26lastTitle%3DIcon%252520Button%252520-%252520Material-UI%26to%3DBookmarks%26Bookmarked%3Dtrue%26content%3Dhahah%26switched%3D':
          'from': 'http%3A%2F%2Flocalhost%3A3000%2Fabout%3Ffrom%3Dhttps%25253A%25252F%25252Fwww%2Efacebook%2Ecom%25252Fapp_scoped_user_id%25252F10154232419354595%25252F%26lastTitle%3DIcon%252520Button%252520-%252520Material-UI%26to%3DBookmarks%26Bookmarked%3Dtrue%26content%3Dhahah%26switched%3D'
          'to': 'Bookmarks'
          'meta':
            'weight': 5
            'title': 'Linkstates for Elias Moosman on Facebook - https://www.facebook.com/app_scoped_user_id/10154232419354595/'
            'face': 'http://graph.facebook.com/v2.7/10154232419354595/picture?type=square'
            'profileLink': 'https://www.facebook.com/app_scoped_user_id/10154232419354595/'
            'FromLink': 'http://localhost:3000/about?from=https%253A%252F%252Fwww.facebook.com%252Fapp_scoped_user_id%252F10154232419354595%252F&lastTitle=Icon%2520Button%2520-%2520Material-UI&to=Bookmarks&Bookmarked=true&content=hahah&switched='
            'ToLink': 'Bookmarks'
            'ScreenshotUrl': 'https://api.thumbalizr.com/?url=http://localhost:3000/about?from=https%253A%252F%252Fwww.facebook.com%252Fapp_scoped_user_id%252F10154232419354595%252F&lastTitle=Icon%2520Button%2520-%2520Material-UI&to=Bookmarks&Bookmarked=true&content=hahah&switched=&width=250&api_key=UQ6CMod6tIkVLam271a7WdUlutEJJHTE'
            'ScreenshotUrlTo': 'https://api.thumbalizr.com/?url=Bookmarks&width=250&api_key=UQ6CMod6tIkVLam271a7WdUlutEJJHTE'
          'author': 'S54FphiBzL3KueFF4'
          'createdAt': 1515650383851
          'title': 'Linkstates for Elias Moosman on Facebook - https://www.facebook.com/app_scoped_user_id/10154232419354595/'
        'https%3A%2F%2Fstackoverflow%2Ecom%2Fquestions%2F9529078%2Fhow-do-i-use-git-reset-hard-head-to-revert-to-a-previous-commit':
          'from': 'https%3A%2F%2Fstackoverflow%2Ecom%2Fquestions%2F9529078%2Fhow-do-i-use-git-reset-hard-head-to-revert-to-a-previous-commit'
          'to': 'Bookmarks'
          'meta':
            'weight': 5
            'title': 'How do I use \'git reset --hard HEAD\' to revert to a previous commit? - Stack Overflow'
            'face': 'http://graph.facebook.com/v2.7/10154232419354595/picture?type=square'
            'profileLink': 'https://www.facebook.com/app_scoped_user_id/10154232419354595/'
            'FromLink': 'https://stackoverflow.com/questions/9529078/how-do-i-use-git-reset-hard-head-to-revert-to-a-previous-commit'
            'ToLink': 'Bookmarks'
            'ScreenshotUrl': 'https://api.thumbalizr.com/?url=https://stackoverflow.com/questions/9529078/how-do-i-use-git-reset-hard-head-to-revert-to-a-previous-commit&width=250&api_key=UQ6CMod6tIkVLam271a7WdUlutEJJHTE'
            'ScreenshotUrlTo': 'https://api.thumbalizr.com/?url=Bookmarks&width=250&api_key=UQ6CMod6tIkVLam271a7WdUlutEJJHTE'
          'author': 'S54FphiBzL3KueFF4'
          'createdAt': 1515650480814
          'title': 'How do I use \'git reset --hard HEAD\' to revert to a previous commit? - Stack Overflow'
      'https%3A%2F%2Fwww%2Efacebook%2Ecom%2Fapp_scoped_user_id%2F10154232419354595%2F': 'Bookmarks':
        'from': 'https%3A%2F%2Fwww%2Efacebook%2Ecom%2Fapp_scoped_user_id%2F10154232419354595%2F'
        'to': 'Bookmarks'
        'meta':
          'title': 'Elias Moosman on Facebook'
          'weight': 7
          'face': 'http://graph.facebook.com/v2.7/10154232419354595/picture?type=square'
          'profileLink': 'https://www.facebook.com/app_scoped_user_id/10154232419354595/'
          'FromLink': 'https://www.facebook.com/app_scoped_user_id/10154232419354595/'
          'ToLink': 'Bookmarks'
          'ScreenshotUrl': 'https://api.urlbox.io/v1/FLMG5BM3XeqMGa42/9b1a5f128cbac84d2142d3377200235906e5a39e/png?url=https%3A%2F%2Fwww.facebook.com%2Fapp_scoped_user_id%2F10154232419354595%2F&thumb_width=320&quality=80'
          'ScreenshotUrlTo': 'https://api.urlbox.io/v1/FLMG5BM3XeqMGa42/f9ef8e3b40885a6acde8c71ffdac6aac3365525e/png?url=Bookmarks&thumb_width=320&quality=80'
        'author': 'S54FphiBzL3KueFF4'
        'createdAt': 1515745059357
        'title': 'Elias Moosman on Facebook'
      'Linkstate%2Eyouiest%2Ecom':
        'Bookmarks':
          'from': 'Linkstate%2Eyouiest%2Ecom'
          'to': 'Bookmarks'
          'meta':
            'title': 'Linkstate - Connecting is seeing'
            'weight': 7
            'face': 'http://graph.facebook.com/v2.7/10154232419354595/picture?type=square'
            'profileLink': 'https://www.facebook.com/app_scoped_user_id/10154232419354595/'
            'FromLink': 'Linkstate.youiest.com'
            'ToLink': 'Bookmarks'
            'ScreenshotUrl': 'https://api.urlbox.io/v1/FLMG5BM3XeqMGa42/117475d1c2f4d6fac7710dcc2f841e06b46e06b3/png?url=Linkstate.youiest.com&thumb_width=320&quality=80'
            'ScreenshotUrlTo': 'https://api.urlbox.io/v1/FLMG5BM3XeqMGa42/f9ef8e3b40885a6acde8c71ffdac6aac3365525e/png?url=Bookmarks&thumb_width=320&quality=80'
          'author': 'S54FphiBzL3KueFF4'
          'createdAt': 1515745036583
          'title': 'Linkstate - Connecting is seeing'
        'Linkstate%2Eyouiest%2Ecom%2Fabout':
          'from': 'Linkstate%2Eyouiest%2Ecom'
          'to': 'Linkstate%2Eyouiest%2Ecom%2Fabout'
          'meta':
            'title': 'Linkstate - Connecting is seeing'
            'weight': 8
            'body': 'The fate of bookmarks can tell us a lot about Linkstate'
            'face': 'http://graph.facebook.com/v2.7/10154232419354595/picture?type=square'
            'profileLink': 'https://www.facebook.com/app_scoped_user_id/10154232419354595/'
            'FromLink': 'Linkstate.youiest.com'
            'ToLink': 'Linkstate.youiest.com/about'
            'ScreenshotUrl': 'https://api.urlbox.io/v1/FLMG5BM3XeqMGa42/117475d1c2f4d6fac7710dcc2f841e06b46e06b3/png?url=Linkstate.youiest.com&thumb_width=320&quality=80'
            'ScreenshotUrlTo': 'https://api.urlbox.io/v1/FLMG5BM3XeqMGa42/7c81ff8950b76e157e44b1a70cfb81532f9a170c/png?url=Linkstate.youiest.com%2Fabout&thumb_width=320&quality=80'
          'author': 'S54FphiBzL3KueFF4'
          'createdAt': 1515744706613
          'title': 'Linkstate - Connecting is seeing'
      'http%3A%2F%2Flocalhost%3A3000%2Fabout%3Ffrom%3DLinkstate%2Eyouiest%2Ecom%26lastTitle%3DIcon%252520Button%252520-%252520Material-UI%26to%3DBookmarks%26Bookmarked%3Dtrue%26content%3D%26switched%3D': 'Bookmarks':
        'from': 'http%3A%2F%2Flocalhost%3A3000%2Fabout%3Ffrom%3DLinkstate%2Eyouiest%2Ecom%26lastTitle%3DIcon%252520Button%252520-%252520Material-UI%26to%3DBookmarks%26Bookmarked%3Dtrue%26content%3D%26switched%3D'
        'to': 'Bookmarks'
        'meta':
          'weight': 5
          'title': 'Linkstates for Linkstate - Connecting is seeing - Linkstate.youiest.com'
          'face': 'http://graph.facebook.com/v2.7/10154232419354595/picture?type=square'
          'profileLink': 'https://www.facebook.com/app_scoped_user_id/10154232419354595/'
          'FromLink': 'http://localhost:3000/about?from=Linkstate.youiest.com&lastTitle=Icon%2520Button%2520-%2520Material-UI&to=Bookmarks&Bookmarked=true&content=&switched='
          'ToLink': 'Bookmarks'
          'ScreenshotUrl': 'https://api.urlbox.io/v1/FLMG5BM3XeqMGa42/2a97329fccd9bea5497d209c411e6a54bbd03f76/png?url=http%3A%2F%2Flocalhost%3A3000%2Fabout%3Ffrom%3DLinkstate.youiest.com%26lastTitle%3DIcon%252520Button%252520-%252520Material-UI%26to%3DBookmarks%26Bookmarked%3Dtrue%26content%3D%26switched%3D&thumb_width=320&quality=80'
          'ScreenshotUrlTo': 'https://api.urlbox.io/v1/FLMG5BM3XeqMGa42/f9ef8e3b40885a6acde8c71ffdac6aac3365525e/png?url=Bookmarks&thumb_width=320&quality=80'
        'author': 'S54FphiBzL3KueFF4'
        'createdAt': 1515650897280
        'title': 'Linkstates for Linkstate - Connecting is seeing - Linkstate.youiest.com'
      'https%3A%2F%2Fwww%2Efacebook%2Ecom%2FvViber%3Flst%3D532514594%253A532514594%253A1514878343': 'Bookmarks':
        'from': 'https%3A%2F%2Fwww%2Efacebook%2Ecom%2FvViber%3Flst%3D532514594%253A532514594%253A1514878343'
        'to': 'Bookmarks'
        'meta':
          'weight': 5
          'title': '(2) Elias Moosman'
          'face': 'http://graph.facebook.com/v2.7/10154232419354595/picture?type=square'
          'profileLink': 'https://www.facebook.com/app_scoped_user_id/10154232419354595/'
          'FromLink': 'https://www.facebook.com/vViber?lst=532514594%3A532514594%3A1514878343'
          'ToLink': 'Bookmarks'
          'ScreenshotUrl': 'https://api.urlbox.io/v1/FLMG5BM3XeqMGa42/7f5979875238b6c4bc73ccfc7f6ec691414e8c8a/png?url=https%3A%2F%2Fwww.facebook.com%2FvViber%3Flst%3D532514594%253A532514594%253A1514878343&thumb_width=320&quality=80'
          'ScreenshotUrlTo': 'https://api.urlbox.io/v1/FLMG5BM3XeqMGa42/f9ef8e3b40885a6acde8c71ffdac6aac3365525e/png?url=Bookmarks&thumb_width=320&quality=80'
        'author': 'S54FphiBzL3KueFF4'
        'createdAt': 1515728165362
        'title': '(2) Elias Moosman'
      'http%3A%2F%2Flocalhost%3A3000%2Fabout%3Ffrom%3DLinkstate%2Eyouiest%2Ecom%26lastTitle%3DIcon%252520Button%252520-%252520Material-UI%26to%3DLinkstate%2Eyouiest%2Ecom%26Bookmarked%3Dtrue%26content%3D%26switched%3D': 'Bookmarks':
        'from': 'http%3A%2F%2Flocalhost%3A3000%2Fabout%3Ffrom%3DLinkstate%2Eyouiest%2Ecom%26lastTitle%3DIcon%252520Button%252520-%252520Material-UI%26to%3DLinkstate%2Eyouiest%2Ecom%26Bookmarked%3Dtrue%26content%3D%26switched%3D'
        'to': 'Bookmarks'
        'meta':
          'weight': 5
          'title': 'Linkstates for Linkstate - Connecting is seeing - Linkstate.youiest.com'
          'face': 'http://graph.facebook.com/v2.7/10154232419354595/picture?type=square'
          'profileLink': 'https://www.facebook.com/app_scoped_user_id/10154232419354595/'
          'FromLink': 'http://localhost:3000/about?from=Linkstate.youiest.com&lastTitle=Icon%2520Button%2520-%2520Material-UI&to=Linkstate.youiest.com&Bookmarked=true&content=&switched='
          'ToLink': 'Bookmarks'
          'ScreenshotUrl': 'https://api.urlbox.io/v1/FLMG5BM3XeqMGa42/7e9eca309d75b57045a48ca0cda20fa74c9c66b0/png?url=http%3A%2F%2Flocalhost%3A3000%2Fabout%3Ffrom%3DLinkstate.youiest.com%26lastTitle%3DIcon%252520Button%252520-%252520Material-UI%26to%3DLinkstate.youiest.com%26Bookmarked%3Dtrue%26content%3D%26switched%3D&thumb_width=320&quality=80'
          'ScreenshotUrlTo': 'https://api.urlbox.io/v1/FLMG5BM3XeqMGa42/f9ef8e3b40885a6acde8c71ffdac6aac3365525e/png?url=Bookmarks&thumb_width=320&quality=80'
        'author': 'S54FphiBzL3KueFF4'
        'createdAt': 1515728156303
        'title': 'Linkstates for Linkstate - Connecting is seeing - Linkstate.youiest.com'
      'Linkstate%2Eyouiest%2Ecom%2Fabout':
        'Linkstate%2Eyouiest%2Ecom%2Fabout':
          'from': 'Linkstate%2Eyouiest%2Ecom%2Fabout'
          'to': 'Linkstate%2Eyouiest%2Ecom%2Fabout'
          'meta':
            'title': 'Linkstate - Connecting is seeing'
            'weight': 8
            'body': 'The fate of bookmarks can tell us a lot about Linkstate'
            'face': 'http://graph.facebook.com/v2.7/10154232419354595/picture?type=square'
            'profileLink': 'https://www.facebook.com/app_scoped_user_id/10154232419354595/'
            'FromLink': 'Linkstate.youiest.com/about'
            'ToLink': 'Linkstate.youiest.com/about'
            'ScreenshotUrl': 'https://api.urlbox.io/v1/FLMG5BM3XeqMGa42/7c81ff8950b76e157e44b1a70cfb81532f9a170c/png?url=Linkstate.youiest.com%2Fabout&thumb_width=320&quality=80'
            'ScreenshotUrlTo': 'https://api.urlbox.io/v1/FLMG5BM3XeqMGa42/7c81ff8950b76e157e44b1a70cfb81532f9a170c/png?url=Linkstate.youiest.com%2Fabout&thumb_width=320&quality=80'
          'author': 'S54FphiBzL3KueFF4'
          'createdAt': 1515745059277
          'title': 'Linkstate - Connecting is seeing'
        'Bookmarks':
          'from': 'Linkstate%2Eyouiest%2Ecom%2Fabout'
          'to': 'Bookmarks'
          'meta':
            'title': 'Linkstate - Connecting is seeing'
            'weight': 7
            'face': 'http://graph.facebook.com/v2.7/10154232419354595/picture?type=square'
            'profileLink': 'https://www.facebook.com/app_scoped_user_id/10154232419354595/'
            'FromLink': 'Linkstate.youiest.com/about'
            'ToLink': 'Bookmarks'
            'ScreenshotUrl': 'https://api.urlbox.io/v1/FLMG5BM3XeqMGa42/7c81ff8950b76e157e44b1a70cfb81532f9a170c/png?url=Linkstate.youiest.com%2Fabout&thumb_width=320&quality=80'
            'ScreenshotUrlTo': 'https://api.urlbox.io/v1/FLMG5BM3XeqMGa42/f9ef8e3b40885a6acde8c71ffdac6aac3365525e/png?url=Bookmarks&thumb_width=320&quality=80'
          'author': 'S54FphiBzL3KueFF4'
          'createdAt': 1515745059202
          'title': 'Linkstate - Connecting is seeing'
  'hits': 747
  'fromLast': 'https://www.facebook.com/app_scoped_user_id/10154232419354595/'
  'toLast': 'Linkstate.youiest.com/about'
badstate =
  'user':
    '_id': 'S54FphiBzL3KueFF4'
    'profile': 'name': 'Elias Moosman'
    'createdAt': '2018-01-11T05:57:30.482Z'
    'services':
      'facebook':
        'expiresAt': 1520753914953
        'id': '10154232419354595'
        'email': 'eliasmoosman@gmail.com'
        'name': 'Elias Moosman'
        'first_name': 'Elias'
        'last_name': 'Moosman'
        'link': 'https://www.facebook.com/app_scoped_user_id/10154232419354595/'
        'gender': 'male'
        'locale': 'sv_SE'
        'age_range': 'min': 21
      'thumbalizr': null
    'edited': 1515849482047
    'links':
      'in':
        'Bookmarks':
          'Bookmarks':
            'from': 'Bookmarks'
            'to': 'Bookmarks'
            'meta':
              'title': 'Bookmarks - and other placeholders'
              'weight': 9
              'ScreenshotUrl': 'https://api.urlbox.io/v1/FLMG5BM3XeqMGa42/f9ef8e3b40885a6acde8c71ffdac6aac3365525e/png?url=Bookmarks&thumb_width=320&quality=80'
              'face': 'http://graph.facebook.com/v2.7/10154232419354595/picture?type=square'
              'profileLink': 'https://www.facebook.com/app_scoped_user_id/10154232419354595/'
              'FromLink': 'Bookmarks'
              'ToLink': 'Bookmarks'
              'ScreenshotUrlTo': 'https://api.urlbox.io/v1/FLMG5BM3XeqMGa42/f9ef8e3b40885a6acde8c71ffdac6aac3365525e/png?url=Bookmarks&thumb_width=320&quality=80'
            'author': 'S54FphiBzL3KueFF4'
            'createdAt': 1515849481638
            'title': 'Bookmarks - and other placeholders'
          'https%3A%2F%2Fwww%2Efacebook%2Ecom%2Fapp_scoped_user_id%2F10154232419354595%2F':
            'from': 'https%3A%2F%2Fwww%2Efacebook%2Ecom%2Fapp_scoped_user_id%2F10154232419354595%2F'
            'to': 'Bookmarks'
            'meta':
              'title': 'Elias Moosman on Facebook'
              'weight': 7
              'face': 'http://graph.facebook.com/v2.7/10154232419354595/picture?type=square'
              'profileLink': 'https://www.facebook.com/app_scoped_user_id/10154232419354595/'
              'FromLink': 'https://www.facebook.com/app_scoped_user_id/10154232419354595/'
              'ToLink': 'Bookmarks'
              'ScreenshotUrl': 'https://api.urlbox.io/v1/FLMG5BM3XeqMGa42/9b1a5f128cbac84d2142d3377200235906e5a39e/png?url=https%3A%2F%2Fwww.facebook.com%2Fapp_scoped_user_id%2F10154232419354595%2F&thumb_width=320&quality=80'
              'ScreenshotUrlTo': 'https://api.urlbox.io/v1/FLMG5BM3XeqMGa42/f9ef8e3b40885a6acde8c71ffdac6aac3365525e/png?url=Bookmarks&thumb_width=320&quality=80'
            'author': 'S54FphiBzL3KueFF4'
            'createdAt': 1515849482047
            'title': 'Elias Moosman on Facebook'
          'Linkstate%2Eyouiest%2Ecom':
            'from': 'Linkstate%2Eyouiest%2Ecom'
            'to': 'Bookmarks'
            'meta':
              'title': 'Linkstate - Connecting is seeing'
              'weight': 7
              'face': 'http://graph.facebook.com/v2.7/10154232419354595/picture?type=square'
              'profileLink': 'https://www.facebook.com/app_scoped_user_id/10154232419354595/'
              'FromLink': 'Linkstate.youiest.com'
              'ToLink': 'Bookmarks'
              'ScreenshotUrl': 'https://api.urlbox.io/v1/FLMG5BM3XeqMGa42/117475d1c2f4d6fac7710dcc2f841e06b46e06b3/png?url=Linkstate.youiest.com&thumb_width=320&quality=80'
              'ScreenshotUrlTo': 'https://api.urlbox.io/v1/FLMG5BM3XeqMGa42/f9ef8e3b40885a6acde8c71ffdac6aac3365525e/png?url=Bookmarks&thumb_width=320&quality=80'
            'author': 'S54FphiBzL3KueFF4'
            'createdAt': 1515745036583
            'title': 'Linkstate - Connecting is seeing'
          'http%3A%2F%2Flocalhost%3A3000%2Fabout%3Ffrom%3DLinkstate%2Eyouiest%2Ecom%26lastTitle%3DIcon%252520Button%252520-%252520Material-UI%26to%3DBookmarks%26Bookmarked%3Dtrue%26content%3D%26switched%3D':
            'from': 'http%3A%2F%2Flocalhost%3A3000%2Fabout%3Ffrom%3DLinkstate%2Eyouiest%2Ecom%26lastTitle%3DIcon%252520Button%252520-%252520Material-UI%26to%3DBookmarks%26Bookmarked%3Dtrue%26content%3D%26switched%3D'
            'to': 'Bookmarks'
            'meta':
              'weight': 5
              'title': 'Linkstates for Linkstate - Connecting is seeing - Linkstate.youiest.com'
              'face': 'http://graph.facebook.com/v2.7/10154232419354595/picture?type=square'
              'profileLink': 'https://www.facebook.com/app_scoped_user_id/10154232419354595/'
              'FromLink': 'http://localhost:3000/about?from=Linkstate.youiest.com&lastTitle=Icon%2520Button%2520-%2520Material-UI&to=Bookmarks&Bookmarked=true&content=&switched='
              'ToLink': 'Bookmarks'
              'ScreenshotUrl': 'https://api.urlbox.io/v1/FLMG5BM3XeqMGa42/2a97329fccd9bea5497d209c411e6a54bbd03f76/png?url=http%3A%2F%2Flocalhost%3A3000%2Fabout%3Ffrom%3DLinkstate.youiest.com%26lastTitle%3DIcon%252520Button%252520-%252520Material-UI%26to%3DBookmarks%26Bookmarked%3Dtrue%26content%3D%26switched%3D&thumb_width=320&quality=80'
              'ScreenshotUrlTo': 'https://api.urlbox.io/v1/FLMG5BM3XeqMGa42/f9ef8e3b40885a6acde8c71ffdac6aac3365525e/png?url=Bookmarks&thumb_width=320&quality=80'
            'author': 'S54FphiBzL3KueFF4'
            'createdAt': 1515650897280
            'title': 'Linkstates for Linkstate - Connecting is seeing - Linkstate.youiest.com'
          'https%3A%2F%2Fwww%2Efacebook%2Ecom%2FvViber%3Flst%3D532514594%253A532514594%253A1514878343':
            'from': 'https%3A%2F%2Fwww%2Efacebook%2Ecom%2FvViber%3Flst%3D532514594%253A532514594%253A1514878343'
            'to': 'Bookmarks'
            'meta':
              'weight': 5
              'title': '(2) Elias Moosman'
              'face': 'http://graph.facebook.com/v2.7/10154232419354595/picture?type=square'
              'profileLink': 'https://www.facebook.com/app_scoped_user_id/10154232419354595/'
              'FromLink': 'https://www.facebook.com/vViber?lst=532514594%3A532514594%3A1514878343'
              'ToLink': 'Bookmarks'
              'ScreenshotUrl': 'https://api.urlbox.io/v1/FLMG5BM3XeqMGa42/7f5979875238b6c4bc73ccfc7f6ec691414e8c8a/png?url=https%3A%2F%2Fwww.facebook.com%2FvViber%3Flst%3D532514594%253A532514594%253A1514878343&thumb_width=320&quality=80'
              'ScreenshotUrlTo': 'https://api.urlbox.io/v1/FLMG5BM3XeqMGa42/f9ef8e3b40885a6acde8c71ffdac6aac3365525e/png?url=Bookmarks&thumb_width=320&quality=80'
            'author': 'S54FphiBzL3KueFF4'
            'createdAt': 1515728165362
            'title': '(2) Elias Moosman'
          'http%3A%2F%2Flocalhost%3A3000%2Fabout%3Ffrom%3DLinkstate%2Eyouiest%2Ecom%26lastTitle%3DIcon%252520Button%252520-%252520Material-UI%26to%3DLinkstate%2Eyouiest%2Ecom%26Bookmarked%3Dtrue%26content%3D%26switched%3D':
            'from': 'http%3A%2F%2Flocalhost%3A3000%2Fabout%3Ffrom%3DLinkstate%2Eyouiest%2Ecom%26lastTitle%3DIcon%252520Button%252520-%252520Material-UI%26to%3DLinkstate%2Eyouiest%2Ecom%26Bookmarked%3Dtrue%26content%3D%26switched%3D'
            'to': 'Bookmarks'
            'meta':
              'weight': 5
              'title': 'Linkstates for Linkstate - Connecting is seeing - Linkstate.youiest.com'
              'face': 'http://graph.facebook.com/v2.7/10154232419354595/picture?type=square'
              'profileLink': 'https://www.facebook.com/app_scoped_user_id/10154232419354595/'
              'FromLink': 'http://localhost:3000/about?from=Linkstate.youiest.com&lastTitle=Icon%2520Button%2520-%2520Material-UI&to=Linkstate.youiest.com&Bookmarked=true&content=&switched='
              'ToLink': 'Bookmarks'
              'ScreenshotUrl': 'https://api.urlbox.io/v1/FLMG5BM3XeqMGa42/7e9eca309d75b57045a48ca0cda20fa74c9c66b0/png?url=http%3A%2F%2Flocalhost%3A3000%2Fabout%3Ffrom%3DLinkstate.youiest.com%26lastTitle%3DIcon%252520Button%252520-%252520Material-UI%26to%3DLinkstate.youiest.com%26Bookmarked%3Dtrue%26content%3D%26switched%3D&thumb_width=320&quality=80'
              'ScreenshotUrlTo': 'https://api.urlbox.io/v1/FLMG5BM3XeqMGa42/f9ef8e3b40885a6acde8c71ffdac6aac3365525e/png?url=Bookmarks&thumb_width=320&quality=80'
            'author': 'S54FphiBzL3KueFF4'
            'createdAt': 1515728156303
            'title': 'Linkstates for Linkstate - Connecting is seeing - Linkstate.youiest.com'
          'Linkstate%2Eyouiest%2Ecom%2Fabout':
            'from': 'Linkstate%2Eyouiest%2Ecom%2Fabout'
            'to': 'Bookmarks'
            'meta':
              'title': 'Linkstate - Connecting is seeing'
              'weight': 7
              'face': 'http://graph.facebook.com/v2.7/10154232419354595/picture?type=square'
              'profileLink': 'https://www.facebook.com/app_scoped_user_id/10154232419354595/'
              'FromLink': 'Linkstate.youiest.com/about'
              'ToLink': 'Bookmarks'
              'ScreenshotUrl': 'https://api.urlbox.io/v1/FLMG5BM3XeqMGa42/7c81ff8950b76e157e44b1a70cfb81532f9a170c/png?url=Linkstate.youiest.com%2Fabout&thumb_width=320&quality=80'
              'ScreenshotUrlTo': 'https://api.urlbox.io/v1/FLMG5BM3XeqMGa42/f9ef8e3b40885a6acde8c71ffdac6aac3365525e/png?url=Bookmarks&thumb_width=320&quality=80'
            'author': 'S54FphiBzL3KueFF4'
            'createdAt': 1515849481804
            'title': 'Linkstate - Connecting is seeing'
          'https%3A%2F%2Flinkstate%2Eyouiest%2Ecom%2Fabout%3Ffrom%3DBookmarks%26lastTitle%3DGrid%252520List%252520-%252520Material-UI%26Bookmarked%3Dtrue%26to%3Dhttps%25253A%25252F%25252Fmopinion%2Ecom%25252Ftop-10-website-annotation-tools%25252F%26content%3D%26switched%3D':
            'from': 'https%3A%2F%2Flinkstate%2Eyouiest%2Ecom%2Fabout%3Ffrom%3DBookmarks%26lastTitle%3DGrid%252520List%252520-%252520Material-UI%26Bookmarked%3Dtrue%26to%3Dhttps%25253A%25252F%25252Fmopinion%2Ecom%25252Ftop-10-website-annotation-tools%25252F%26content%3D%26switched%3D'
            'to': 'Bookmarks'
            'meta':
              'weight': 5
              'title': 'Linkstates for Bookmarks - and other placeholders - Bookmarks'
              'face': 'http://graph.facebook.com/v2.7/10154232419354595/picture?type=square'
              'profileLink': 'https://www.facebook.com/app_scoped_user_id/10154232419354595/'
              'FromLink': 'https://linkstate.youiest.com/about?from=Bookmarks&lastTitle=Grid%2520List%2520-%2520Material-UI&Bookmarked=true&to=https%253A%252F%252Fmopinion.com%252Ftop-10-website-annotation-tools%252F&content=&switched='
              'ToLink': 'Bookmarks'
              'ScreenshotUrl': 'https://api.urlbox.io/v1/FLMG5BM3XeqMGa42/891c9105bb40fedaf3946178f7ee21f0cf25cb54/png?url=https%3A%2F%2Flinkstate.youiest.com%2Fabout%3Ffrom%3DBookmarks%26lastTitle%3DGrid%252520List%252520-%252520Material-UI%26Bookmarked%3Dtrue%26to%3Dhttps%25253A%25252F%25252Fmopinion.com%25252Ftop-10-website-annotation-tools%25252F%26content%3D%26switched%3D&thumb_width=320&quality=80'
              'ScreenshotUrlTo': 'https://api.urlbox.io/v1/FLMG5BM3XeqMGa42/f9ef8e3b40885a6acde8c71ffdac6aac3365525e/png?url=Bookmarks&thumb_width=320&quality=80'
            'author': 'S54FphiBzL3KueFF4'
            'createdAt': 1515750433476
            'title': 'Linkstates for Bookmarks - and other placeholders - Bookmarks'
          'https%3A%2F%2Fdevelopers%2Efacebook%2Ecom%2Fproducts%2Fsocial-plugins%2Fcomments%2F%3Futm_campaign%3Dsocial_plugins%26utm_medium%3Doffsite_pages%26utm_source%3Dcomments_plugin':
            'from': 'https%3A%2F%2Fdevelopers%2Efacebook%2Ecom%2Fproducts%2Fsocial-plugins%2Fcomments%2F%3Futm_campaign%3Dsocial_plugins%26utm_medium%3Doffsite_pages%26utm_source%3Dcomments_plugin'
            'to': 'Bookmarks'
            'meta':
              'weight': 5
              'title': 'Comments - Facebook for Developers'
              'face': 'http://graph.facebook.com/v2.7/10154232419354595/picture?type=square'
              'profileLink': 'https://www.facebook.com/app_scoped_user_id/10154232419354595/'
              'FromLink': 'https://developers.facebook.com/products/social-plugins/comments/?utm_campaign=social_plugins&utm_medium=offsite_pages&utm_source=comments_plugin'
              'ToLink': 'Bookmarks'
              'ScreenshotUrl': 'https://api.urlbox.io/v1/FLMG5BM3XeqMGa42/07d8c5a90f1c223ccd0f83a8637374368bb68178/png?url=https%3A%2F%2Fdevelopers.facebook.com%2Fproducts%2Fsocial-plugins%2Fcomments%2F%3Futm_campaign%3Dsocial_plugins%26utm_medium%3Doffsite_pages%26utm_source%3Dcomments_plugin&thumb_width=320&quality=80'
              'ScreenshotUrlTo': 'https://api.urlbox.io/v1/FLMG5BM3XeqMGa42/f9ef8e3b40885a6acde8c71ffdac6aac3365525e/png?url=Bookmarks&thumb_width=320&quality=80'
            'author': 'S54FphiBzL3KueFF4'
            'createdAt': 1515750441208
            'title': 'Comments - Facebook for Developers'
          'http%3A%2F%2Fwww%2Ematerial-ui%2Ecom%2Fv0%2E15%2E0%2F%23%2Fcomponents%2Ficon-button':
            'from': 'http%3A%2F%2Fwww%2Ematerial-ui%2Ecom%2Fv0%2E15%2E0%2F%23%2Fcomponents%2Ficon-button'
            'to': 'Bookmarks'
            'meta':
              'weight': 5
              'title': 'Icon Button - Material-UI'
              'face': 'http://graph.facebook.com/v2.7/10154232419354595/picture?type=square'
              'profileLink': 'https://www.facebook.com/app_scoped_user_id/10154232419354595/'
              'FromLink': 'http://www.material-ui.com/v0.15.0/#/components/icon-button'
              'ToLink': 'Bookmarks'
              'ScreenshotUrl': 'https://api.urlbox.io/v1/FLMG5BM3XeqMGa42/bc419c1ffae6d735068eb38564b861249f53af0f/png?url=http%3A%2F%2Fwww.material-ui.com%2Fv0.15.0%2F%23%2Fcomponents%2Ficon-button&thumb_width=320&quality=80'
              'ScreenshotUrlTo': 'https://api.urlbox.io/v1/FLMG5BM3XeqMGa42/f9ef8e3b40885a6acde8c71ffdac6aac3365525e/png?url=Bookmarks&thumb_width=320&quality=80'
            'author': 'S54FphiBzL3KueFF4'
            'createdAt': 1515752736619
            'title': 'Icon Button - Material-UI'
          'https%3A%2F%2Fwww%2Enpmjs%2Ecom%2Fpackage%2Fcopy-to-clipboard':
            'from': 'https%3A%2F%2Fwww%2Enpmjs%2Ecom%2Fpackage%2Fcopy-to-clipboard'
            'to': 'Bookmarks'
            'meta':
              'weight': 5
              'title': 'copy-to-clipboard'
              'face': 'http://graph.facebook.com/v2.7/10154232419354595/picture?type=square'
              'profileLink': 'https://www.facebook.com/app_scoped_user_id/10154232419354595/'
              'FromLink': 'https://www.npmjs.com/package/copy-to-clipboard'
              'ToLink': 'Bookmarks'
              'ScreenshotUrl': 'https://api.urlbox.io/v1/FLMG5BM3XeqMGa42/8be9bf072d4ca4620ea074275282f8e0acc74174/png?url=https%3A%2F%2Fwww.npmjs.com%2Fpackage%2Fcopy-to-clipboard&thumb_width=320&quality=80'
              'ScreenshotUrlTo': 'https://api.urlbox.io/v1/FLMG5BM3XeqMGa42/f9ef8e3b40885a6acde8c71ffdac6aac3365525e/png?url=Bookmarks&thumb_width=320&quality=80'
            'author': 'S54FphiBzL3KueFF4'
            'createdAt': 1515848424123
            'title': 'copy-to-clipboard'
          'http%3A%2F%2Fwww%2Ematerial-ui%2Ecom%2Fv0%2E15%2E0%2F%23%2Fcomponents%2Ffloating-action-button':
            'from': 'http%3A%2F%2Fwww%2Ematerial-ui%2Ecom%2Fv0%2E15%2E0%2F%23%2Fcomponents%2Ffloating-action-button'
            'to': 'Bookmarks'
            'meta':
              'weight': 5
              'title': 'Floating Action Button - Material-UI'
              'face': 'http://graph.facebook.com/v2.7/10154232419354595/picture?type=square'
              'profileLink': 'https://www.facebook.com/app_scoped_user_id/10154232419354595/'
              'FromLink': 'http://www.material-ui.com/v0.15.0/#/components/floating-action-button'
              'ToLink': 'Bookmarks'
              'ScreenshotUrl': 'https://api.urlbox.io/v1/FLMG5BM3XeqMGa42/da1d05c7c97b6a4f5473451ee8905aa7484401dd/png?url=http%3A%2F%2Fwww.material-ui.com%2Fv0.15.0%2F%23%2Fcomponents%2Ffloating-action-button&thumb_width=320&quality=80'
              'ScreenshotUrlTo': 'https://api.urlbox.io/v1/FLMG5BM3XeqMGa42/f9ef8e3b40885a6acde8c71ffdac6aac3365525e/png?url=Bookmarks&thumb_width=320&quality=80'
            'author': 'S54FphiBzL3KueFF4'
            'createdAt': 1515849481404
            'title': 'Floating Action Button - Material-UI'
        'Linkstate%2Eyouiest%2Ecom': 'Bookmarks':
          'from': 'Bookmarks'
          'to': 'Linkstate%2Eyouiest%2Ecom'
          'meta':
            'body': 'hjkkwer'
            'weight': 4
            'title': 'Bookmarks - and other placeholders'
            'face': 'http://graph.facebook.com/v2.7/10154232419354595/picture?type=square'
            'profileLink': 'https://www.facebook.com/app_scoped_user_id/10154232419354595/'
            'FromLink': 'Bookmarks'
            'ToLink': 'Linkstate.youiest.com'
            'ScreenshotUrl': 'https://api.urlbox.io/v1/FLMG5BM3XeqMGa42/f9ef8e3b40885a6acde8c71ffdac6aac3365525e/png?url=Bookmarks&thumb_width=320&quality=80'
            'ScreenshotUrlTo': 'https://api.urlbox.io/v1/FLMG5BM3XeqMGa42/117475d1c2f4d6fac7710dcc2f841e06b46e06b3/png?url=Linkstate.youiest.com&thumb_width=320&quality=80'
          'author': 'S54FphiBzL3KueFF4'
          'createdAt': 1515675012528
          'title': 'Bookmarks - and other placeholders'
        'https%3A%2F%2Fwww%2Efacebook%2Ecom%2Fapp_scoped_user_id%2F10154232419354595%2F':
          'Bookmarks':
            'from': 'https%3A%2F%2Fwww%2Efacebook%2Ecom%2Fapp_scoped_user_id%2F10154232419354595%2F'
            'to': 'Bookmarks'
            'meta':
              'title': 'Elias Moosman on Facebook'
              'weight': 7
              'face': 'http://graph.facebook.com/v2.7/10154232419354595/picture?type=square'
              'profileLink': 'https://www.facebook.com/app_scoped_user_id/10154232419354595/'
              'FromLink': 'https://www.facebook.com/app_scoped_user_id/10154232419354595/'
              'ToLink': 'Bookmarks'
              'ScreenshotUrl': 'https://api.thumbalizr.com/?url=https://www.facebook.com/app_scoped_user_id/10154232419354595/&width=250&api_key=UQ6CMod6tIkVLam271a7WdUlutEJJHTE'
              'ScreenshotUrlTo': 'https://api.thumbalizr.com/?url=Bookmarks&width=250&api_key=UQ6CMod6tIkVLam271a7WdUlutEJJHTE'
            'author': 'S54FphiBzL3KueFF4'
            'createdAt': 1515650468975
            'title': 'Elias Moosman on Facebook'
          'https%3A%2F%2Fwww%2Efacebook%2Ecom%2Fapp_scoped_user_id%2F10154232419354595%2F':
            'from': 'https%3A%2F%2Fwww%2Efacebook%2Ecom%2Fapp_scoped_user_id%2F10154232419354595%2F'
            'to': 'https%3A%2F%2Fwww%2Efacebook%2Ecom%2Fapp_scoped_user_id%2F10154232419354595%2F'
            'meta':
              'body': ''
              'weight': 6
              'title': 'Elias Moosman on Facebook'
              'face': 'http://graph.facebook.com/v2.7/10154232419354595/picture?type=square'
              'profileLink': 'https://www.facebook.com/app_scoped_user_id/10154232419354595/'
              'FromLink': 'https://www.facebook.com/app_scoped_user_id/10154232419354595/'
              'ToLink': 'https://www.facebook.com/app_scoped_user_id/10154232419354595/'
              'ScreenshotUrl': 'https://api.urlbox.io/v1/FLMG5BM3XeqMGa42/9b1a5f128cbac84d2142d3377200235906e5a39e/png?url=https%3A%2F%2Fwww.facebook.com%2Fapp_scoped_user_id%2F10154232419354595%2F&thumb_width=320&quality=80'
              'ScreenshotUrlTo': 'https://api.urlbox.io/v1/FLMG5BM3XeqMGa42/9b1a5f128cbac84d2142d3377200235906e5a39e/png?url=https%3A%2F%2Fwww.facebook.com%2Fapp_scoped_user_id%2F10154232419354595%2F&thumb_width=320&quality=80'
            'author': 'S54FphiBzL3KueFF4'
            'createdAt': 1515848689254
            'title': 'Elias Moosman on Facebook'
        'http%3A%2F%2Flocalhost%3A3000%2Fabout%3Ffrom%3Dhttps%25253A%25252F%25252Fwww%2Efacebook%2Ecom%25252Fapp_scoped_user_id%25252F10154232419354595%25252F%26lastTitle%3DIcon%252520Button%252520-%252520Material-UI%26to%3DBookmarks%26Bookmarked%3Dtrue%26content%3Dhahah%26switched%3D': 'Bookmarks':
          'from': 'http%3A%2F%2Flocalhost%3A3000%2Fabout%3Ffrom%3Dhttps%25253A%25252F%25252Fwww%2Efacebook%2Ecom%25252Fapp_scoped_user_id%25252F10154232419354595%25252F%26lastTitle%3DIcon%252520Button%252520-%252520Material-UI%26to%3DBookmarks%26Bookmarked%3Dtrue%26content%3Dhahah%26switched%3D'
          'to': 'Bookmarks'
          'meta':
            'weight': 5
            'title': 'Linkstates for Elias Moosman on Facebook - https://www.facebook.com/app_scoped_user_id/10154232419354595/'
            'face': 'http://graph.facebook.com/v2.7/10154232419354595/picture?type=square'
            'profileLink': 'https://www.facebook.com/app_scoped_user_id/10154232419354595/'
            'FromLink': 'http://localhost:3000/about?from=https%253A%252F%252Fwww.facebook.com%252Fapp_scoped_user_id%252F10154232419354595%252F&lastTitle=Icon%2520Button%2520-%2520Material-UI&to=Bookmarks&Bookmarked=true&content=hahah&switched='
            'ToLink': 'Bookmarks'
            'ScreenshotUrl': 'https://api.thumbalizr.com/?url=http://localhost:3000/about?from=https%253A%252F%252Fwww.facebook.com%252Fapp_scoped_user_id%252F10154232419354595%252F&lastTitle=Icon%2520Button%2520-%2520Material-UI&to=Bookmarks&Bookmarked=true&content=hahah&switched=&width=250&api_key=UQ6CMod6tIkVLam271a7WdUlutEJJHTE'
            'ScreenshotUrlTo': 'https://api.thumbalizr.com/?url=Bookmarks&width=250&api_key=UQ6CMod6tIkVLam271a7WdUlutEJJHTE'
          'author': 'S54FphiBzL3KueFF4'
          'createdAt': 1515650383851
          'title': 'Linkstates for Elias Moosman on Facebook - https://www.facebook.com/app_scoped_user_id/10154232419354595/'
        'https%3A%2F%2Fstackoverflow%2Ecom%2Fquestions%2F9529078%2Fhow-do-i-use-git-reset-hard-head-to-revert-to-a-previous-commit': 'Bookmarks':
          'from': 'https%3A%2F%2Fstackoverflow%2Ecom%2Fquestions%2F9529078%2Fhow-do-i-use-git-reset-hard-head-to-revert-to-a-previous-commit'
          'to': 'Bookmarks'
          'meta':
            'weight': 5
            'title': 'How do I use \'git reset --hard HEAD\' to revert to a previous commit? - Stack Overflow'
            'face': 'http://graph.facebook.com/v2.7/10154232419354595/picture?type=square'
            'profileLink': 'https://www.facebook.com/app_scoped_user_id/10154232419354595/'
            'FromLink': 'https://stackoverflow.com/questions/9529078/how-do-i-use-git-reset-hard-head-to-revert-to-a-previous-commit'
            'ToLink': 'Bookmarks'
            'ScreenshotUrl': 'https://api.thumbalizr.com/?url=https://stackoverflow.com/questions/9529078/how-do-i-use-git-reset-hard-head-to-revert-to-a-previous-commit&width=250&api_key=UQ6CMod6tIkVLam271a7WdUlutEJJHTE'
            'ScreenshotUrlTo': 'https://api.thumbalizr.com/?url=Bookmarks&width=250&api_key=UQ6CMod6tIkVLam271a7WdUlutEJJHTE'
          'author': 'S54FphiBzL3KueFF4'
          'createdAt': 1515650480814
          'title': 'How do I use \'git reset --hard HEAD\' to revert to a previous commit? - Stack Overflow'
        'Linkstate%2Eyouiest%2Ecom%2Fabout':
          'Linkstate%2Eyouiest%2Ecom':
            'from': 'Linkstate%2Eyouiest%2Ecom'
            'to': 'Linkstate%2Eyouiest%2Ecom%2Fabout'
            'meta':
              'title': 'Linkstate - Connecting is seeing'
              'weight': 8
              'body': 'The fate of bookmarks can tell us a lot about Linkstate'
              'face': 'http://graph.facebook.com/v2.7/10154232419354595/picture?type=square'
              'profileLink': 'https://www.facebook.com/app_scoped_user_id/10154232419354595/'
              'FromLink': 'Linkstate.youiest.com'
              'ToLink': 'Linkstate.youiest.com/about'
              'ScreenshotUrl': 'https://api.urlbox.io/v1/FLMG5BM3XeqMGa42/117475d1c2f4d6fac7710dcc2f841e06b46e06b3/png?url=Linkstate.youiest.com&thumb_width=320&quality=80'
              'ScreenshotUrlTo': 'https://api.urlbox.io/v1/FLMG5BM3XeqMGa42/7c81ff8950b76e157e44b1a70cfb81532f9a170c/png?url=Linkstate.youiest.com%2Fabout&thumb_width=320&quality=80'
            'author': 'S54FphiBzL3KueFF4'
            'createdAt': 1515744706613
            'title': 'Linkstate - Connecting is seeing'
          'Linkstate%2Eyouiest%2Ecom%2Fabout':
            'from': 'Linkstate%2Eyouiest%2Ecom%2Fabout'
            'to': 'Linkstate%2Eyouiest%2Ecom%2Fabout'
            'meta':
              'title': 'Linkstate - Connecting is seeing'
              'weight': 8
              'body': 'The fate of bookmarks can tell us a lot about Linkstate'
              'face': 'http://graph.facebook.com/v2.7/10154232419354595/picture?type=square'
              'profileLink': 'https://www.facebook.com/app_scoped_user_id/10154232419354595/'
              'FromLink': 'Linkstate.youiest.com/about'
              'ToLink': 'Linkstate.youiest.com/about'
              'ScreenshotUrl': 'https://api.urlbox.io/v1/FLMG5BM3XeqMGa42/7c81ff8950b76e157e44b1a70cfb81532f9a170c/png?url=Linkstate.youiest.com%2Fabout&thumb_width=320&quality=80'
              'ScreenshotUrlTo': 'https://api.urlbox.io/v1/FLMG5BM3XeqMGa42/7c81ff8950b76e157e44b1a70cfb81532f9a170c/png?url=Linkstate.youiest.com%2Fabout&thumb_width=320&quality=80'
            'author': 'S54FphiBzL3KueFF4'
            'createdAt': 1515849481973
            'title': 'Linkstate - Connecting is seeing'
          'https%3A%2F%2Fdevelopers%2Efacebook%2Ecom%2Fproducts%2Fsocial-plugins%2Fcomments%2F%3Futm_campaign%3Dsocial_plugins%26utm_medium%3Doffsite_pages%26utm_source%3Dcomments_plugin':
            'from': 'https%3A%2F%2Fdevelopers%2Efacebook%2Ecom%2Fproducts%2Fsocial-plugins%2Fcomments%2F%3Futm_campaign%3Dsocial_plugins%26utm_medium%3Doffsite_pages%26utm_source%3Dcomments_plugin'
            'to': 'Linkstate%2Eyouiest%2Ecom%2Fabout'
            'meta':
              'body': 'hasd'
              'weight': 5
              'title': 'Comments - Facebook for Developers'
              'face': 'http://graph.facebook.com/v2.7/10154232419354595/picture?type=square'
              'profileLink': 'https://www.facebook.com/app_scoped_user_id/10154232419354595/'
              'FromLink': 'https://developers.facebook.com/products/social-plugins/comments/?utm_campaign=social_plugins&utm_medium=offsite_pages&utm_source=comments_plugin'
              'ToLink': 'Linkstate.youiest.com/about'
              'ScreenshotUrl': 'https://api.urlbox.io/v1/FLMG5BM3XeqMGa42/07d8c5a90f1c223ccd0f83a8637374368bb68178/png?url=https%3A%2F%2Fdevelopers.facebook.com%2Fproducts%2Fsocial-plugins%2Fcomments%2F%3Futm_campaign%3Dsocial_plugins%26utm_medium%3Doffsite_pages%26utm_source%3Dcomments_plugin&thumb_width=320&quality=80'
              'ScreenshotUrlTo': 'https://api.urlbox.io/v1/FLMG5BM3XeqMGa42/7c81ff8950b76e157e44b1a70cfb81532f9a170c/png?url=Linkstate.youiest.com%2Fabout&thumb_width=320&quality=80'
            'author': 'S54FphiBzL3KueFF4'
            'createdAt': 1515752725802
            'title': 'Comments - Facebook for Developers'
          'http%3A%2F%2Fwww%2Ematerial-ui%2Ecom%2Fv0%2E15%2E0%2F%23%2Fcomponents%2Ficon-button':
            'from': 'http%3A%2F%2Fwww%2Ematerial-ui%2Ecom%2Fv0%2E15%2E0%2F%23%2Fcomponents%2Ficon-button'
            'to': 'Linkstate%2Eyouiest%2Ecom%2Fabout'
            'meta':
              'body': ''
              'weight': 7
              'title': 'Icon Button - Material-UI'
              'face': 'http://graph.facebook.com/v2.7/10154232419354595/picture?type=square'
              'profileLink': 'https://www.facebook.com/app_scoped_user_id/10154232419354595/'
              'FromLink': 'http://www.material-ui.com/v0.15.0/#/components/icon-button'
              'ToLink': 'Linkstate.youiest.com/about'
              'ScreenshotUrl': 'https://api.urlbox.io/v1/FLMG5BM3XeqMGa42/bc419c1ffae6d735068eb38564b861249f53af0f/png?url=http%3A%2F%2Fwww.material-ui.com%2Fv0.15.0%2F%23%2Fcomponents%2Ficon-button&thumb_width=320&quality=80'
              'ScreenshotUrlTo': 'https://api.urlbox.io/v1/FLMG5BM3XeqMGa42/7c81ff8950b76e157e44b1a70cfb81532f9a170c/png?url=Linkstate.youiest.com%2Fabout&thumb_width=320&quality=80'
            'author': 'S54FphiBzL3KueFF4'
            'createdAt': 1515848417835
            'title': 'Icon Button - Material-UI'
        'http%3A%2F%2Fwww%2Ematerial-ui%2Ecom%2Fv0%2E15%2E0%2F%23%2Fcomponents%2Ficon-button': 'Linkstate%2Eyouiest%2Ecom%2Fabout':
          'from': 'Linkstate%2Eyouiest%2Ecom%2Fabout'
          'to': 'http%3A%2F%2Fwww%2Ematerial-ui%2Ecom%2Fv0%2E15%2E0%2F%23%2Fcomponents%2Ficon-button'
          'meta':
            'body': 'hi'
            'weight': 1
            'title': 'Linkstate - Connecting is seeing'
            'face': 'http://graph.facebook.com/v2.7/10154232419354595/picture?type=square'
            'profileLink': 'https://www.facebook.com/app_scoped_user_id/10154232419354595/'
            'FromLink': 'Linkstate.youiest.com/about'
            'ToLink': 'http://www.material-ui.com/v0.15.0/#/components/icon-button'
            'ScreenshotUrl': 'https://api.urlbox.io/v1/FLMG5BM3XeqMGa42/7c81ff8950b76e157e44b1a70cfb81532f9a170c/png?url=Linkstate.youiest.com%2Fabout&thumb_width=320&quality=80'
            'ScreenshotUrlTo': 'https://api.urlbox.io/v1/FLMG5BM3XeqMGa42/bc419c1ffae6d735068eb38564b861249f53af0f/png?url=http%3A%2F%2Fwww.material-ui.com%2Fv0.15.0%2F%23%2Fcomponents%2Ficon-button&thumb_width=320&quality=80'
          'author': 'S54FphiBzL3KueFF4'
          'createdAt': 1515765825514
          'title': 'Linkstate - Connecting is seeing'
      'out':
        'Bookmarks':
          'Bookmarks':
            'from': 'Bookmarks'
            'to': 'Bookmarks'
            'meta':
              'title': 'Bookmarks - and other placeholders'
              'weight': 9
              'ScreenshotUrl': 'https://api.urlbox.io/v1/FLMG5BM3XeqMGa42/f9ef8e3b40885a6acde8c71ffdac6aac3365525e/png?url=Bookmarks&thumb_width=320&quality=80'
              'face': 'http://graph.facebook.com/v2.7/10154232419354595/picture?type=square'
              'profileLink': 'https://www.facebook.com/app_scoped_user_id/10154232419354595/'
              'FromLink': 'Bookmarks'
              'ToLink': 'Bookmarks'
              'ScreenshotUrlTo': 'https://api.urlbox.io/v1/FLMG5BM3XeqMGa42/f9ef8e3b40885a6acde8c71ffdac6aac3365525e/png?url=Bookmarks&thumb_width=320&quality=80'
            'author': 'S54FphiBzL3KueFF4'
            'createdAt': 1515849481638
            'title': 'Bookmarks - and other placeholders'
          'Linkstate%2Eyouiest%2Ecom':
            'from': 'Bookmarks'
            'to': 'Linkstate%2Eyouiest%2Ecom'
            'meta':
              'body': 'hjkkwer'
              'weight': 4
              'title': 'Bookmarks - and other placeholders'
              'face': 'http://graph.facebook.com/v2.7/10154232419354595/picture?type=square'
              'profileLink': 'https://www.facebook.com/app_scoped_user_id/10154232419354595/'
              'FromLink': 'Bookmarks'
              'ToLink': 'Linkstate.youiest.com'
              'ScreenshotUrl': 'https://api.urlbox.io/v1/FLMG5BM3XeqMGa42/f9ef8e3b40885a6acde8c71ffdac6aac3365525e/png?url=Bookmarks&thumb_width=320&quality=80'
              'ScreenshotUrlTo': 'https://api.urlbox.io/v1/FLMG5BM3XeqMGa42/117475d1c2f4d6fac7710dcc2f841e06b46e06b3/png?url=Linkstate.youiest.com&thumb_width=320&quality=80'
            'author': 'S54FphiBzL3KueFF4'
            'createdAt': 1515675012528
            'title': 'Bookmarks - and other placeholders'
          'https%3A%2F%2Fwww%2Efacebook%2Ecom%2Fapp_scoped_user_id%2F10154232419354595%2F':
            'from': 'https%3A%2F%2Fwww%2Efacebook%2Ecom%2Fapp_scoped_user_id%2F10154232419354595%2F'
            'to': 'Bookmarks'
            'meta':
              'title': 'Elias Moosman on Facebook'
              'weight': 7
              'face': 'http://graph.facebook.com/v2.7/10154232419354595/picture?type=square'
              'profileLink': 'https://www.facebook.com/app_scoped_user_id/10154232419354595/'
              'FromLink': 'https://www.facebook.com/app_scoped_user_id/10154232419354595/'
              'ToLink': 'Bookmarks'
              'ScreenshotUrl': 'https://api.thumbalizr.com/?url=https://www.facebook.com/app_scoped_user_id/10154232419354595/&width=250&api_key=UQ6CMod6tIkVLam271a7WdUlutEJJHTE'
              'ScreenshotUrlTo': 'https://api.thumbalizr.com/?url=Bookmarks&width=250&api_key=UQ6CMod6tIkVLam271a7WdUlutEJJHTE'
            'author': 'S54FphiBzL3KueFF4'
            'createdAt': 1515650468975
            'title': 'Elias Moosman on Facebook'
          'http%3A%2F%2Flocalhost%3A3000%2Fabout%3Ffrom%3Dhttps%25253A%25252F%25252Fwww%2Efacebook%2Ecom%25252Fapp_scoped_user_id%25252F10154232419354595%25252F%26lastTitle%3DIcon%252520Button%252520-%252520Material-UI%26to%3DBookmarks%26Bookmarked%3Dtrue%26content%3Dhahah%26switched%3D':
            'from': 'http%3A%2F%2Flocalhost%3A3000%2Fabout%3Ffrom%3Dhttps%25253A%25252F%25252Fwww%2Efacebook%2Ecom%25252Fapp_scoped_user_id%25252F10154232419354595%25252F%26lastTitle%3DIcon%252520Button%252520-%252520Material-UI%26to%3DBookmarks%26Bookmarked%3Dtrue%26content%3Dhahah%26switched%3D'
            'to': 'Bookmarks'
            'meta':
              'weight': 5
              'title': 'Linkstates for Elias Moosman on Facebook - https://www.facebook.com/app_scoped_user_id/10154232419354595/'
              'face': 'http://graph.facebook.com/v2.7/10154232419354595/picture?type=square'
              'profileLink': 'https://www.facebook.com/app_scoped_user_id/10154232419354595/'
              'FromLink': 'http://localhost:3000/about?from=https%253A%252F%252Fwww.facebook.com%252Fapp_scoped_user_id%252F10154232419354595%252F&lastTitle=Icon%2520Button%2520-%2520Material-UI&to=Bookmarks&Bookmarked=true&content=hahah&switched='
              'ToLink': 'Bookmarks'
              'ScreenshotUrl': 'https://api.thumbalizr.com/?url=http://localhost:3000/about?from=https%253A%252F%252Fwww.facebook.com%252Fapp_scoped_user_id%252F10154232419354595%252F&lastTitle=Icon%2520Button%2520-%2520Material-UI&to=Bookmarks&Bookmarked=true&content=hahah&switched=&width=250&api_key=UQ6CMod6tIkVLam271a7WdUlutEJJHTE'
              'ScreenshotUrlTo': 'https://api.thumbalizr.com/?url=Bookmarks&width=250&api_key=UQ6CMod6tIkVLam271a7WdUlutEJJHTE'
            'author': 'S54FphiBzL3KueFF4'
            'createdAt': 1515650383851
            'title': 'Linkstates for Elias Moosman on Facebook - https://www.facebook.com/app_scoped_user_id/10154232419354595/'
          'https%3A%2F%2Fstackoverflow%2Ecom%2Fquestions%2F9529078%2Fhow-do-i-use-git-reset-hard-head-to-revert-to-a-previous-commit':
            'from': 'https%3A%2F%2Fstackoverflow%2Ecom%2Fquestions%2F9529078%2Fhow-do-i-use-git-reset-hard-head-to-revert-to-a-previous-commit'
            'to': 'Bookmarks'
            'meta':
              'weight': 5
              'title': 'How do I use \'git reset --hard HEAD\' to revert to a previous commit? - Stack Overflow'
              'face': 'http://graph.facebook.com/v2.7/10154232419354595/picture?type=square'
              'profileLink': 'https://www.facebook.com/app_scoped_user_id/10154232419354595/'
              'FromLink': 'https://stackoverflow.com/questions/9529078/how-do-i-use-git-reset-hard-head-to-revert-to-a-previous-commit'
              'ToLink': 'Bookmarks'
              'ScreenshotUrl': 'https://api.thumbalizr.com/?url=https://stackoverflow.com/questions/9529078/how-do-i-use-git-reset-hard-head-to-revert-to-a-previous-commit&width=250&api_key=UQ6CMod6tIkVLam271a7WdUlutEJJHTE'
              'ScreenshotUrlTo': 'https://api.thumbalizr.com/?url=Bookmarks&width=250&api_key=UQ6CMod6tIkVLam271a7WdUlutEJJHTE'
            'author': 'S54FphiBzL3KueFF4'
            'createdAt': 1515650480814
            'title': 'How do I use \'git reset --hard HEAD\' to revert to a previous commit? - Stack Overflow'
        'https%3A%2F%2Fwww%2Efacebook%2Ecom%2Fapp_scoped_user_id%2F10154232419354595%2F':
          'Bookmarks':
            'from': 'https%3A%2F%2Fwww%2Efacebook%2Ecom%2Fapp_scoped_user_id%2F10154232419354595%2F'
            'to': 'Bookmarks'
            'meta':
              'title': 'Elias Moosman on Facebook'
              'weight': 7
              'face': 'http://graph.facebook.com/v2.7/10154232419354595/picture?type=square'
              'profileLink': 'https://www.facebook.com/app_scoped_user_id/10154232419354595/'
              'FromLink': 'https://www.facebook.com/app_scoped_user_id/10154232419354595/'
              'ToLink': 'Bookmarks'
              'ScreenshotUrl': 'https://api.urlbox.io/v1/FLMG5BM3XeqMGa42/9b1a5f128cbac84d2142d3377200235906e5a39e/png?url=https%3A%2F%2Fwww.facebook.com%2Fapp_scoped_user_id%2F10154232419354595%2F&thumb_width=320&quality=80'
              'ScreenshotUrlTo': 'https://api.urlbox.io/v1/FLMG5BM3XeqMGa42/f9ef8e3b40885a6acde8c71ffdac6aac3365525e/png?url=Bookmarks&thumb_width=320&quality=80'
            'author': 'S54FphiBzL3KueFF4'
            'createdAt': 1515849482047
            'title': 'Elias Moosman on Facebook'
          'https%3A%2F%2Fwww%2Efacebook%2Ecom%2Fapp_scoped_user_id%2F10154232419354595%2F':
            'from': 'https%3A%2F%2Fwww%2Efacebook%2Ecom%2Fapp_scoped_user_id%2F10154232419354595%2F'
            'to': 'https%3A%2F%2Fwww%2Efacebook%2Ecom%2Fapp_scoped_user_id%2F10154232419354595%2F'
            'meta':
              'body': ''
              'weight': 6
              'title': 'Elias Moosman on Facebook'
              'face': 'http://graph.facebook.com/v2.7/10154232419354595/picture?type=square'
              'profileLink': 'https://www.facebook.com/app_scoped_user_id/10154232419354595/'
              'FromLink': 'https://www.facebook.com/app_scoped_user_id/10154232419354595/'
              'ToLink': 'https://www.facebook.com/app_scoped_user_id/10154232419354595/'
              'ScreenshotUrl': 'https://api.urlbox.io/v1/FLMG5BM3XeqMGa42/9b1a5f128cbac84d2142d3377200235906e5a39e/png?url=https%3A%2F%2Fwww.facebook.com%2Fapp_scoped_user_id%2F10154232419354595%2F&thumb_width=320&quality=80'
              'ScreenshotUrlTo': 'https://api.urlbox.io/v1/FLMG5BM3XeqMGa42/9b1a5f128cbac84d2142d3377200235906e5a39e/png?url=https%3A%2F%2Fwww.facebook.com%2Fapp_scoped_user_id%2F10154232419354595%2F&thumb_width=320&quality=80'
            'author': 'S54FphiBzL3KueFF4'
            'createdAt': 1515848689254
            'title': 'Elias Moosman on Facebook'
        'Linkstate%2Eyouiest%2Ecom':
          'Bookmarks':
            'from': 'Linkstate%2Eyouiest%2Ecom'
            'to': 'Bookmarks'
            'meta':
              'title': 'Linkstate - Connecting is seeing'
              'weight': 7
              'face': 'http://graph.facebook.com/v2.7/10154232419354595/picture?type=square'
              'profileLink': 'https://www.facebook.com/app_scoped_user_id/10154232419354595/'
              'FromLink': 'Linkstate.youiest.com'
              'ToLink': 'Bookmarks'
              'ScreenshotUrl': 'https://api.urlbox.io/v1/FLMG5BM3XeqMGa42/117475d1c2f4d6fac7710dcc2f841e06b46e06b3/png?url=Linkstate.youiest.com&thumb_width=320&quality=80'
              'ScreenshotUrlTo': 'https://api.urlbox.io/v1/FLMG5BM3XeqMGa42/f9ef8e3b40885a6acde8c71ffdac6aac3365525e/png?url=Bookmarks&thumb_width=320&quality=80'
            'author': 'S54FphiBzL3KueFF4'
            'createdAt': 1515745036583
            'title': 'Linkstate - Connecting is seeing'
          'Linkstate%2Eyouiest%2Ecom%2Fabout':
            'from': 'Linkstate%2Eyouiest%2Ecom'
            'to': 'Linkstate%2Eyouiest%2Ecom%2Fabout'
            'meta':
              'title': 'Linkstate - Connecting is seeing'
              'weight': 8
              'body': 'The fate of bookmarks can tell us a lot about Linkstate'
              'face': 'http://graph.facebook.com/v2.7/10154232419354595/picture?type=square'
              'profileLink': 'https://www.facebook.com/app_scoped_user_id/10154232419354595/'
              'FromLink': 'Linkstate.youiest.com'
              'ToLink': 'Linkstate.youiest.com/about'
              'ScreenshotUrl': 'https://api.urlbox.io/v1/FLMG5BM3XeqMGa42/117475d1c2f4d6fac7710dcc2f841e06b46e06b3/png?url=Linkstate.youiest.com&thumb_width=320&quality=80'
              'ScreenshotUrlTo': 'https://api.urlbox.io/v1/FLMG5BM3XeqMGa42/7c81ff8950b76e157e44b1a70cfb81532f9a170c/png?url=Linkstate.youiest.com%2Fabout&thumb_width=320&quality=80'
            'author': 'S54FphiBzL3KueFF4'
            'createdAt': 1515744706613
            'title': 'Linkstate - Connecting is seeing'
        'http%3A%2F%2Flocalhost%3A3000%2Fabout%3Ffrom%3DLinkstate%2Eyouiest%2Ecom%26lastTitle%3DIcon%252520Button%252520-%252520Material-UI%26to%3DBookmarks%26Bookmarked%3Dtrue%26content%3D%26switched%3D': 'Bookmarks':
          'from': 'http%3A%2F%2Flocalhost%3A3000%2Fabout%3Ffrom%3DLinkstate%2Eyouiest%2Ecom%26lastTitle%3DIcon%252520Button%252520-%252520Material-UI%26to%3DBookmarks%26Bookmarked%3Dtrue%26content%3D%26switched%3D'
          'to': 'Bookmarks'
          'meta':
            'weight': 5
            'title': 'Linkstates for Linkstate - Connecting is seeing - Linkstate.youiest.com'
            'face': 'http://graph.facebook.com/v2.7/10154232419354595/picture?type=square'
            'profileLink': 'https://www.facebook.com/app_scoped_user_id/10154232419354595/'
            'FromLink': 'http://localhost:3000/about?from=Linkstate.youiest.com&lastTitle=Icon%2520Button%2520-%2520Material-UI&to=Bookmarks&Bookmarked=true&content=&switched='
            'ToLink': 'Bookmarks'
            'ScreenshotUrl': 'https://api.urlbox.io/v1/FLMG5BM3XeqMGa42/2a97329fccd9bea5497d209c411e6a54bbd03f76/png?url=http%3A%2F%2Flocalhost%3A3000%2Fabout%3Ffrom%3DLinkstate.youiest.com%26lastTitle%3DIcon%252520Button%252520-%252520Material-UI%26to%3DBookmarks%26Bookmarked%3Dtrue%26content%3D%26switched%3D&thumb_width=320&quality=80'
            'ScreenshotUrlTo': 'https://api.urlbox.io/v1/FLMG5BM3XeqMGa42/f9ef8e3b40885a6acde8c71ffdac6aac3365525e/png?url=Bookmarks&thumb_width=320&quality=80'
          'author': 'S54FphiBzL3KueFF4'
          'createdAt': 1515650897280
          'title': 'Linkstates for Linkstate - Connecting is seeing - Linkstate.youiest.com'
        'https%3A%2F%2Fwww%2Efacebook%2Ecom%2FvViber%3Flst%3D532514594%253A532514594%253A1514878343': 'Bookmarks':
          'from': 'https%3A%2F%2Fwww%2Efacebook%2Ecom%2FvViber%3Flst%3D532514594%253A532514594%253A1514878343'
          'to': 'Bookmarks'
          'meta':
            'weight': 5
            'title': '(2) Elias Moosman'
            'face': 'http://graph.facebook.com/v2.7/10154232419354595/picture?type=square'
            'profileLink': 'https://www.facebook.com/app_scoped_user_id/10154232419354595/'
            'FromLink': 'https://www.facebook.com/vViber?lst=532514594%3A532514594%3A1514878343'
            'ToLink': 'Bookmarks'
            'ScreenshotUrl': 'https://api.urlbox.io/v1/FLMG5BM3XeqMGa42/7f5979875238b6c4bc73ccfc7f6ec691414e8c8a/png?url=https%3A%2F%2Fwww.facebook.com%2FvViber%3Flst%3D532514594%253A532514594%253A1514878343&thumb_width=320&quality=80'
            'ScreenshotUrlTo': 'https://api.urlbox.io/v1/FLMG5BM3XeqMGa42/f9ef8e3b40885a6acde8c71ffdac6aac3365525e/png?url=Bookmarks&thumb_width=320&quality=80'
          'author': 'S54FphiBzL3KueFF4'
          'createdAt': 1515728165362
          'title': '(2) Elias Moosman'
        'http%3A%2F%2Flocalhost%3A3000%2Fabout%3Ffrom%3DLinkstate%2Eyouiest%2Ecom%26lastTitle%3DIcon%252520Button%252520-%252520Material-UI%26to%3DLinkstate%2Eyouiest%2Ecom%26Bookmarked%3Dtrue%26content%3D%26switched%3D': 'Bookmarks':
          'from': 'http%3A%2F%2Flocalhost%3A3000%2Fabout%3Ffrom%3DLinkstate%2Eyouiest%2Ecom%26lastTitle%3DIcon%252520Button%252520-%252520Material-UI%26to%3DLinkstate%2Eyouiest%2Ecom%26Bookmarked%3Dtrue%26content%3D%26switched%3D'
          'to': 'Bookmarks'
          'meta':
            'weight': 5
            'title': 'Linkstates for Linkstate - Connecting is seeing - Linkstate.youiest.com'
            'face': 'http://graph.facebook.com/v2.7/10154232419354595/picture?type=square'
            'profileLink': 'https://www.facebook.com/app_scoped_user_id/10154232419354595/'
            'FromLink': 'http://localhost:3000/about?from=Linkstate.youiest.com&lastTitle=Icon%2520Button%2520-%2520Material-UI&to=Linkstate.youiest.com&Bookmarked=true&content=&switched='
            'ToLink': 'Bookmarks'
            'ScreenshotUrl': 'https://api.urlbox.io/v1/FLMG5BM3XeqMGa42/7e9eca309d75b57045a48ca0cda20fa74c9c66b0/png?url=http%3A%2F%2Flocalhost%3A3000%2Fabout%3Ffrom%3DLinkstate.youiest.com%26lastTitle%3DIcon%252520Button%252520-%252520Material-UI%26to%3DLinkstate.youiest.com%26Bookmarked%3Dtrue%26content%3D%26switched%3D&thumb_width=320&quality=80'
            'ScreenshotUrlTo': 'https://api.urlbox.io/v1/FLMG5BM3XeqMGa42/f9ef8e3b40885a6acde8c71ffdac6aac3365525e/png?url=Bookmarks&thumb_width=320&quality=80'
          'author': 'S54FphiBzL3KueFF4'
          'createdAt': 1515728156303
          'title': 'Linkstates for Linkstate - Connecting is seeing - Linkstate.youiest.com'
        'Linkstate%2Eyouiest%2Ecom%2Fabout':
          'Linkstate%2Eyouiest%2Ecom%2Fabout':
            'from': 'Linkstate%2Eyouiest%2Ecom%2Fabout'
            'to': 'Linkstate%2Eyouiest%2Ecom%2Fabout'
            'meta':
              'title': 'Linkstate - Connecting is seeing'
              'weight': 8
              'body': 'The fate of bookmarks can tell us a lot about Linkstate'
              'face': 'http://graph.facebook.com/v2.7/10154232419354595/picture?type=square'
              'profileLink': 'https://www.facebook.com/app_scoped_user_id/10154232419354595/'
              'FromLink': 'Linkstate.youiest.com/about'
              'ToLink': 'Linkstate.youiest.com/about'
              'ScreenshotUrl': 'https://api.urlbox.io/v1/FLMG5BM3XeqMGa42/7c81ff8950b76e157e44b1a70cfb81532f9a170c/png?url=Linkstate.youiest.com%2Fabout&thumb_width=320&quality=80'
              'ScreenshotUrlTo': 'https://api.urlbox.io/v1/FLMG5BM3XeqMGa42/7c81ff8950b76e157e44b1a70cfb81532f9a170c/png?url=Linkstate.youiest.com%2Fabout&thumb_width=320&quality=80'
            'author': 'S54FphiBzL3KueFF4'
            'createdAt': 1515849481973
            'title': 'Linkstate - Connecting is seeing'
          'Bookmarks':
            'from': 'Linkstate%2Eyouiest%2Ecom%2Fabout'
            'to': 'Bookmarks'
            'meta':
              'title': 'Linkstate - Connecting is seeing'
              'weight': 7
              'face': 'http://graph.facebook.com/v2.7/10154232419354595/picture?type=square'
              'profileLink': 'https://www.facebook.com/app_scoped_user_id/10154232419354595/'
              'FromLink': 'Linkstate.youiest.com/about'
              'ToLink': 'Bookmarks'
              'ScreenshotUrl': 'https://api.urlbox.io/v1/FLMG5BM3XeqMGa42/7c81ff8950b76e157e44b1a70cfb81532f9a170c/png?url=Linkstate.youiest.com%2Fabout&thumb_width=320&quality=80'
              'ScreenshotUrlTo': 'https://api.urlbox.io/v1/FLMG5BM3XeqMGa42/f9ef8e3b40885a6acde8c71ffdac6aac3365525e/png?url=Bookmarks&thumb_width=320&quality=80'
            'author': 'S54FphiBzL3KueFF4'
            'createdAt': 1515849481804
            'title': 'Linkstate - Connecting is seeing'
          'http%3A%2F%2Fwww%2Ematerial-ui%2Ecom%2Fv0%2E15%2E0%2F%23%2Fcomponents%2Ficon-button':
            'from': 'Linkstate%2Eyouiest%2Ecom%2Fabout'
            'to': 'http%3A%2F%2Fwww%2Ematerial-ui%2Ecom%2Fv0%2E15%2E0%2F%23%2Fcomponents%2Ficon-button'
            'meta':
              'body': 'hi'
              'weight': 1
              'title': 'Linkstate - Connecting is seeing'
              'face': 'http://graph.facebook.com/v2.7/10154232419354595/picture?type=square'
              'profileLink': 'https://www.facebook.com/app_scoped_user_id/10154232419354595/'
              'FromLink': 'Linkstate.youiest.com/about'
              'ToLink': 'http://www.material-ui.com/v0.15.0/#/components/icon-button'
              'ScreenshotUrl': 'https://api.urlbox.io/v1/FLMG5BM3XeqMGa42/7c81ff8950b76e157e44b1a70cfb81532f9a170c/png?url=Linkstate.youiest.com%2Fabout&thumb_width=320&quality=80'
              'ScreenshotUrlTo': 'https://api.urlbox.io/v1/FLMG5BM3XeqMGa42/bc419c1ffae6d735068eb38564b861249f53af0f/png?url=http%3A%2F%2Fwww.material-ui.com%2Fv0.15.0%2F%23%2Fcomponents%2Ficon-button&thumb_width=320&quality=80'
            'author': 'S54FphiBzL3KueFF4'
            'createdAt': 1515765825514
            'title': 'Linkstate - Connecting is seeing'
        'https%3A%2F%2Flinkstate%2Eyouiest%2Ecom%2Fabout%3Ffrom%3DBookmarks%26lastTitle%3DGrid%252520List%252520-%252520Material-UI%26Bookmarked%3Dtrue%26to%3Dhttps%25253A%25252F%25252Fmopinion%2Ecom%25252Ftop-10-website-annotation-tools%25252F%26content%3D%26switched%3D': 'Bookmarks':
          'from': 'https%3A%2F%2Flinkstate%2Eyouiest%2Ecom%2Fabout%3Ffrom%3DBookmarks%26lastTitle%3DGrid%252520List%252520-%252520Material-UI%26Bookmarked%3Dtrue%26to%3Dhttps%25253A%25252F%25252Fmopinion%2Ecom%25252Ftop-10-website-annotation-tools%25252F%26content%3D%26switched%3D'
          'to': 'Bookmarks'
          'meta':
            'weight': 5
            'title': 'Linkstates for Bookmarks - and other placeholders - Bookmarks'
            'face': 'http://graph.facebook.com/v2.7/10154232419354595/picture?type=square'
            'profileLink': 'https://www.facebook.com/app_scoped_user_id/10154232419354595/'
            'FromLink': 'https://linkstate.youiest.com/about?from=Bookmarks&lastTitle=Grid%2520List%2520-%2520Material-UI&Bookmarked=true&to=https%253A%252F%252Fmopinion.com%252Ftop-10-website-annotation-tools%252F&content=&switched='
            'ToLink': 'Bookmarks'
            'ScreenshotUrl': 'https://api.urlbox.io/v1/FLMG5BM3XeqMGa42/891c9105bb40fedaf3946178f7ee21f0cf25cb54/png?url=https%3A%2F%2Flinkstate.youiest.com%2Fabout%3Ffrom%3DBookmarks%26lastTitle%3DGrid%252520List%252520-%252520Material-UI%26Bookmarked%3Dtrue%26to%3Dhttps%25253A%25252F%25252Fmopinion.com%25252Ftop-10-website-annotation-tools%25252F%26content%3D%26switched%3D&thumb_width=320&quality=80'
            'ScreenshotUrlTo': 'https://api.urlbox.io/v1/FLMG5BM3XeqMGa42/f9ef8e3b40885a6acde8c71ffdac6aac3365525e/png?url=Bookmarks&thumb_width=320&quality=80'
          'author': 'S54FphiBzL3KueFF4'
          'createdAt': 1515750433476
          'title': 'Linkstates for Bookmarks - and other placeholders - Bookmarks'
        'https%3A%2F%2Fdevelopers%2Efacebook%2Ecom%2Fproducts%2Fsocial-plugins%2Fcomments%2F%3Futm_campaign%3Dsocial_plugins%26utm_medium%3Doffsite_pages%26utm_source%3Dcomments_plugin':
          'Bookmarks':
            'from': 'https%3A%2F%2Fdevelopers%2Efacebook%2Ecom%2Fproducts%2Fsocial-plugins%2Fcomments%2F%3Futm_campaign%3Dsocial_plugins%26utm_medium%3Doffsite_pages%26utm_source%3Dcomments_plugin'
            'to': 'Bookmarks'
            'meta':
              'weight': 5
              'title': 'Comments - Facebook for Developers'
              'face': 'http://graph.facebook.com/v2.7/10154232419354595/picture?type=square'
              'profileLink': 'https://www.facebook.com/app_scoped_user_id/10154232419354595/'
              'FromLink': 'https://developers.facebook.com/products/social-plugins/comments/?utm_campaign=social_plugins&utm_medium=offsite_pages&utm_source=comments_plugin'
              'ToLink': 'Bookmarks'
              'ScreenshotUrl': 'https://api.urlbox.io/v1/FLMG5BM3XeqMGa42/07d8c5a90f1c223ccd0f83a8637374368bb68178/png?url=https%3A%2F%2Fdevelopers.facebook.com%2Fproducts%2Fsocial-plugins%2Fcomments%2F%3Futm_campaign%3Dsocial_plugins%26utm_medium%3Doffsite_pages%26utm_source%3Dcomments_plugin&thumb_width=320&quality=80'
              'ScreenshotUrlTo': 'https://api.urlbox.io/v1/FLMG5BM3XeqMGa42/f9ef8e3b40885a6acde8c71ffdac6aac3365525e/png?url=Bookmarks&thumb_width=320&quality=80'
            'author': 'S54FphiBzL3KueFF4'
            'createdAt': 1515750441208
            'title': 'Comments - Facebook for Developers'
          'Linkstate%2Eyouiest%2Ecom%2Fabout':
            'from': 'https%3A%2F%2Fdevelopers%2Efacebook%2Ecom%2Fproducts%2Fsocial-plugins%2Fcomments%2F%3Futm_campaign%3Dsocial_plugins%26utm_medium%3Doffsite_pages%26utm_source%3Dcomments_plugin'
            'to': 'Linkstate%2Eyouiest%2Ecom%2Fabout'
            'meta':
              'body': 'hasd'
              'weight': 5
              'title': 'Comments - Facebook for Developers'
              'face': 'http://graph.facebook.com/v2.7/10154232419354595/picture?type=square'
              'profileLink': 'https://www.facebook.com/app_scoped_user_id/10154232419354595/'
              'FromLink': 'https://developers.facebook.com/products/social-plugins/comments/?utm_campaign=social_plugins&utm_medium=offsite_pages&utm_source=comments_plugin'
              'ToLink': 'Linkstate.youiest.com/about'
              'ScreenshotUrl': 'https://api.urlbox.io/v1/FLMG5BM3XeqMGa42/07d8c5a90f1c223ccd0f83a8637374368bb68178/png?url=https%3A%2F%2Fdevelopers.facebook.com%2Fproducts%2Fsocial-plugins%2Fcomments%2F%3Futm_campaign%3Dsocial_plugins%26utm_medium%3Doffsite_pages%26utm_source%3Dcomments_plugin&thumb_width=320&quality=80'
              'ScreenshotUrlTo': 'https://api.urlbox.io/v1/FLMG5BM3XeqMGa42/7c81ff8950b76e157e44b1a70cfb81532f9a170c/png?url=Linkstate.youiest.com%2Fabout&thumb_width=320&quality=80'
            'author': 'S54FphiBzL3KueFF4'
            'createdAt': 1515752725802
            'title': 'Comments - Facebook for Developers'
        'http%3A%2F%2Fwww%2Ematerial-ui%2Ecom%2Fv0%2E15%2E0%2F%23%2Fcomponents%2Ficon-button':
          'Bookmarks':
            'from': 'http%3A%2F%2Fwww%2Ematerial-ui%2Ecom%2Fv0%2E15%2E0%2F%23%2Fcomponents%2Ficon-button'
            'to': 'Bookmarks'
            'meta':
              'weight': 5
              'title': 'Icon Button - Material-UI'
              'face': 'http://graph.facebook.com/v2.7/10154232419354595/picture?type=square'
              'profileLink': 'https://www.facebook.com/app_scoped_user_id/10154232419354595/'
              'FromLink': 'http://www.material-ui.com/v0.15.0/#/components/icon-button'
              'ToLink': 'Bookmarks'
              'ScreenshotUrl': 'https://api.urlbox.io/v1/FLMG5BM3XeqMGa42/bc419c1ffae6d735068eb38564b861249f53af0f/png?url=http%3A%2F%2Fwww.material-ui.com%2Fv0.15.0%2F%23%2Fcomponents%2Ficon-button&thumb_width=320&quality=80'
              'ScreenshotUrlTo': 'https://api.urlbox.io/v1/FLMG5BM3XeqMGa42/f9ef8e3b40885a6acde8c71ffdac6aac3365525e/png?url=Bookmarks&thumb_width=320&quality=80'
            'author': 'S54FphiBzL3KueFF4'
            'createdAt': 1515752736619
            'title': 'Icon Button - Material-UI'
          'Linkstate%2Eyouiest%2Ecom%2Fabout':
            'from': 'http%3A%2F%2Fwww%2Ematerial-ui%2Ecom%2Fv0%2E15%2E0%2F%23%2Fcomponents%2Ficon-button'
            'to': 'Linkstate%2Eyouiest%2Ecom%2Fabout'
            'meta':
              'body': ''
              'weight': 7
              'title': 'Icon Button - Material-UI'
              'face': 'http://graph.facebook.com/v2.7/10154232419354595/picture?type=square'
              'profileLink': 'https://www.facebook.com/app_scoped_user_id/10154232419354595/'
              'FromLink': 'http://www.material-ui.com/v0.15.0/#/components/icon-button'
              'ToLink': 'Linkstate.youiest.com/about'
              'ScreenshotUrl': 'https://api.urlbox.io/v1/FLMG5BM3XeqMGa42/bc419c1ffae6d735068eb38564b861249f53af0f/png?url=http%3A%2F%2Fwww.material-ui.com%2Fv0.15.0%2F%23%2Fcomponents%2Ficon-button&thumb_width=320&quality=80'
              'ScreenshotUrlTo': 'https://api.urlbox.io/v1/FLMG5BM3XeqMGa42/7c81ff8950b76e157e44b1a70cfb81532f9a170c/png?url=Linkstate.youiest.com%2Fabout&thumb_width=320&quality=80'
            'author': 'S54FphiBzL3KueFF4'
            'createdAt': 1515848417835
            'title': 'Icon Button - Material-UI'
        'https%3A%2F%2Fwww%2Enpmjs%2Ecom%2Fpackage%2Fcopy-to-clipboard': 'Bookmarks':
          'from': 'https%3A%2F%2Fwww%2Enpmjs%2Ecom%2Fpackage%2Fcopy-to-clipboard'
          'to': 'Bookmarks'
          'meta':
            'weight': 5
            'title': 'copy-to-clipboard'
            'face': 'http://graph.facebook.com/v2.7/10154232419354595/picture?type=square'
            'profileLink': 'https://www.facebook.com/app_scoped_user_id/10154232419354595/'
            'FromLink': 'https://www.npmjs.com/package/copy-to-clipboard'
            'ToLink': 'Bookmarks'
            'ScreenshotUrl': 'https://api.urlbox.io/v1/FLMG5BM3XeqMGa42/8be9bf072d4ca4620ea074275282f8e0acc74174/png?url=https%3A%2F%2Fwww.npmjs.com%2Fpackage%2Fcopy-to-clipboard&thumb_width=320&quality=80'
            'ScreenshotUrlTo': 'https://api.urlbox.io/v1/FLMG5BM3XeqMGa42/f9ef8e3b40885a6acde8c71ffdac6aac3365525e/png?url=Bookmarks&thumb_width=320&quality=80'
          'author': 'S54FphiBzL3KueFF4'
          'createdAt': 1515848424123
          'title': 'copy-to-clipboard'
        'http%3A%2F%2Fwww%2Ematerial-ui%2Ecom%2Fv0%2E15%2E0%2F%23%2Fcomponents%2Ffloating-action-button': 'Bookmarks':
          'from': 'http%3A%2F%2Fwww%2Ematerial-ui%2Ecom%2Fv0%2E15%2E0%2F%23%2Fcomponents%2Ffloating-action-button'
          'to': 'Bookmarks'
          'meta':
            'weight': 5
            'title': 'Floating Action Button - Material-UI'
            'face': 'http://graph.facebook.com/v2.7/10154232419354595/picture?type=square'
            'profileLink': 'https://www.facebook.com/app_scoped_user_id/10154232419354595/'
            'FromLink': 'http://www.material-ui.com/v0.15.0/#/components/floating-action-button'
            'ToLink': 'Bookmarks'
            'ScreenshotUrl': 'https://api.urlbox.io/v1/FLMG5BM3XeqMGa42/da1d05c7c97b6a4f5473451ee8905aa7484401dd/png?url=http%3A%2F%2Fwww.material-ui.com%2Fv0.15.0%2F%23%2Fcomponents%2Ffloating-action-button&thumb_width=320&quality=80'
            'ScreenshotUrlTo': 'https://api.urlbox.io/v1/FLMG5BM3XeqMGa42/f9ef8e3b40885a6acde8c71ffdac6aac3365525e/png?url=Bookmarks&thumb_width=320&quality=80'
          'author': 'S54FphiBzL3KueFF4'
          'createdAt': 1515849481404
          'title': 'Floating Action Button - Material-UI'
    'hits': 791
    'fromLast': 'https://www.facebook.com/app_scoped_user_id/10154232419354595/'
    'toLast': 'Linkstate.youiest.com/about'
  'from': 'http://www.material-ui.com/v0.15.0/#/components/floating-action-button'
  'to': 'Linkstate.youiest.com/about'
badWindowState =
  'props':
    'from': 'https://www.facebook.com/vViber?lst=532514594:532514594:1514878343'
    'to': 'Linkstate.youiest.com/about'
    'lastTitle': '(2) Elias Moosman'
    'user':
      '_id': 'S54FphiBzL3KueFF4'
      'profile': 'name': 'Elias Moosman'
      'createdAt': '2018-01-11T05:57:30.482Z'
      'services':
        'facebook':
          'expiresAt': 1520753914953
          'id': '10154232419354595'
          'email': 'eliasmoosman@gmail.com'
          'name': 'Elias Moosman'
          'first_name': 'Elias'
          'last_name': 'Moosman'
          'link': 'https://www.facebook.com/app_scoped_user_id/10154232419354595/'
          'gender': 'male'
          'locale': 'sv_SE'
          'age_range': 'min': 21
        'thumbalizr': null
      'edited': 1515896611045
      'links':
        'in':
          'Bookmarks':
            'Bookmarks':
              'from': 'Bookmarks'
              'to': 'Bookmarks'
              'meta':
                'title': 'Bookmarks - and other placeholders'
                'weight': 9
                'ScreenshotUrl': 'https://api.urlbox.io/v1/FLMG5BM3XeqMGa42/f9ef8e3b40885a6acde8c71ffdac6aac3365525e/png?url=Bookmarks&thumb_width=320&quality=80'
                'face': 'http://graph.facebook.com/v2.7/10154232419354595/picture?type=square'
                'profileLink': 'https://www.facebook.com/app_scoped_user_id/10154232419354595/'
                'FromLink': 'Bookmarks'
                'ToLink': 'Bookmarks'
                'ScreenshotUrlTo': 'https://api.urlbox.io/v1/FLMG5BM3XeqMGa42/f9ef8e3b40885a6acde8c71ffdac6aac3365525e/png?url=Bookmarks&thumb_width=320&quality=80'
              'author': 'S54FphiBzL3KueFF4'
              'createdAt': 1515894288198
              'title': 'Bookmarks - and other placeholders'
            'https%3A%2F%2Fwww%2Efacebook%2Ecom%2Fapp_scoped_user_id%2F10154232419354595%2F':
              'from': 'https%3A%2F%2Fwww%2Efacebook%2Ecom%2Fapp_scoped_user_id%2F10154232419354595%2F'
              'to': 'Bookmarks'
              'meta':
                'title': 'Elias Moosman on Facebook'
                'weight': 7
                'face': 'http://graph.facebook.com/v2.7/10154232419354595/picture?type=square'
                'profileLink': 'https://www.facebook.com/app_scoped_user_id/10154232419354595/'
                'FromLink': 'https://www.facebook.com/app_scoped_user_id/10154232419354595/'
                'ToLink': 'Bookmarks'
                'ScreenshotUrl': 'https://api.urlbox.io/v1/FLMG5BM3XeqMGa42/9b1a5f128cbac84d2142d3377200235906e5a39e/png?url=https%3A%2F%2Fwww.facebook.com%2Fapp_scoped_user_id%2F10154232419354595%2F&thumb_width=320&quality=80'
                'ScreenshotUrlTo': 'https://api.urlbox.io/v1/FLMG5BM3XeqMGa42/f9ef8e3b40885a6acde8c71ffdac6aac3365525e/png?url=Bookmarks&thumb_width=320&quality=80'
              'author': 'S54FphiBzL3KueFF4'
              'createdAt': 1515894288763
              'title': 'Elias Moosman on Facebook'
            'Linkstate%2Eyouiest%2Ecom':
              'from': 'Linkstate%2Eyouiest%2Ecom'
              'to': 'Bookmarks'
              'meta':
                'title': 'Linkstate - Connecting is seeing'
                'weight': 7
                'face': 'http://graph.facebook.com/v2.7/10154232419354595/picture?type=square'
                'profileLink': 'https://www.facebook.com/app_scoped_user_id/10154232419354595/'
                'FromLink': 'Linkstate.youiest.com'
                'ToLink': 'Bookmarks'
                'ScreenshotUrl': 'https://api.urlbox.io/v1/FLMG5BM3XeqMGa42/117475d1c2f4d6fac7710dcc2f841e06b46e06b3/png?url=Linkstate.youiest.com&thumb_width=320&quality=80'
                'ScreenshotUrlTo': 'https://api.urlbox.io/v1/FLMG5BM3XeqMGa42/f9ef8e3b40885a6acde8c71ffdac6aac3365525e/png?url=Bookmarks&thumb_width=320&quality=80'
              'author': 'S54FphiBzL3KueFF4'
              'createdAt': 1515745036583
              'title': 'Linkstate - Connecting is seeing'
            'http%3A%2F%2Flocalhost%3A3000%2Fabout%3Ffrom%3DLinkstate%2Eyouiest%2Ecom%26lastTitle%3DIcon%252520Button%252520-%252520Material-UI%26to%3DBookmarks%26Bookmarked%3Dtrue%26content%3D%26switched%3D':
              'from': 'http%3A%2F%2Flocalhost%3A3000%2Fabout%3Ffrom%3DLinkstate%2Eyouiest%2Ecom%26lastTitle%3DIcon%252520Button%252520-%252520Material-UI%26to%3DBookmarks%26Bookmarked%3Dtrue%26content%3D%26switched%3D'
              'to': 'Bookmarks'
              'meta':
                'weight': 5
                'title': 'Linkstates for Linkstate - Connecting is seeing - Linkstate.youiest.com'
                'face': 'http://graph.facebook.com/v2.7/10154232419354595/picture?type=square'
                'profileLink': 'https://www.facebook.com/app_scoped_user_id/10154232419354595/'
                'FromLink': 'http://localhost:3000/about?from=Linkstate.youiest.com&lastTitle=Icon%2520Button%2520-%2520Material-UI&to=Bookmarks&Bookmarked=true&content=&switched='
                'ToLink': 'Bookmarks'
                'ScreenshotUrl': 'https://api.urlbox.io/v1/FLMG5BM3XeqMGa42/2a97329fccd9bea5497d209c411e6a54bbd03f76/png?url=http%3A%2F%2Flocalhost%3A3000%2Fabout%3Ffrom%3DLinkstate.youiest.com%26lastTitle%3DIcon%252520Button%252520-%252520Material-UI%26to%3DBookmarks%26Bookmarked%3Dtrue%26content%3D%26switched%3D&thumb_width=320&quality=80'
                'ScreenshotUrlTo': 'https://api.urlbox.io/v1/FLMG5BM3XeqMGa42/f9ef8e3b40885a6acde8c71ffdac6aac3365525e/png?url=Bookmarks&thumb_width=320&quality=80'
              'author': 'S54FphiBzL3KueFF4'
              'createdAt': 1515650897280
              'title': 'Linkstates for Linkstate - Connecting is seeing - Linkstate.youiest.com'
            'https%3A%2F%2Fwww%2Efacebook%2Ecom%2FvViber%3Flst%3D532514594%253A532514594%253A1514878343':
              'from': 'https%3A%2F%2Fwww%2Efacebook%2Ecom%2FvViber%3Flst%3D532514594%253A532514594%253A1514878343'
              'to': 'Bookmarks'
              'meta':
                'weight': 5
                'title': '(2) Elias Moosman'
                'face': 'http://graph.facebook.com/v2.7/10154232419354595/picture?type=square'
                'profileLink': 'https://www.facebook.com/app_scoped_user_id/10154232419354595/'
                'FromLink': 'https://www.facebook.com/vViber?lst=532514594%3A532514594%3A1514878343'
                'ToLink': 'Bookmarks'
                'ScreenshotUrl': 'https://api.urlbox.io/v1/FLMG5BM3XeqMGa42/7f5979875238b6c4bc73ccfc7f6ec691414e8c8a/png?url=https%3A%2F%2Fwww.facebook.com%2FvViber%3Flst%3D532514594%253A532514594%253A1514878343&thumb_width=320&quality=80'
                'ScreenshotUrlTo': 'https://api.urlbox.io/v1/FLMG5BM3XeqMGa42/f9ef8e3b40885a6acde8c71ffdac6aac3365525e/png?url=Bookmarks&thumb_width=320&quality=80'
              'author': 'S54FphiBzL3KueFF4'
              'createdAt': 1515728165362
              'title': '(2) Elias Moosman'
            'http%3A%2F%2Flocalhost%3A3000%2Fabout%3Ffrom%3DLinkstate%2Eyouiest%2Ecom%26lastTitle%3DIcon%252520Button%252520-%252520Material-UI%26to%3DLinkstate%2Eyouiest%2Ecom%26Bookmarked%3Dtrue%26content%3D%26switched%3D':
              'from': 'http%3A%2F%2Flocalhost%3A3000%2Fabout%3Ffrom%3DLinkstate%2Eyouiest%2Ecom%26lastTitle%3DIcon%252520Button%252520-%252520Material-UI%26to%3DLinkstate%2Eyouiest%2Ecom%26Bookmarked%3Dtrue%26content%3D%26switched%3D'
              'to': 'Bookmarks'
              'meta':
                'weight': 5
                'title': 'Linkstates for Linkstate - Connecting is seeing - Linkstate.youiest.com'
                'face': 'http://graph.facebook.com/v2.7/10154232419354595/picture?type=square'
                'profileLink': 'https://www.facebook.com/app_scoped_user_id/10154232419354595/'
                'FromLink': 'http://localhost:3000/about?from=Linkstate.youiest.com&lastTitle=Icon%2520Button%2520-%2520Material-UI&to=Linkstate.youiest.com&Bookmarked=true&content=&switched='
                'ToLink': 'Bookmarks'
                'ScreenshotUrl': 'https://api.urlbox.io/v1/FLMG5BM3XeqMGa42/7e9eca309d75b57045a48ca0cda20fa74c9c66b0/png?url=http%3A%2F%2Flocalhost%3A3000%2Fabout%3Ffrom%3DLinkstate.youiest.com%26lastTitle%3DIcon%252520Button%252520-%252520Material-UI%26to%3DLinkstate.youiest.com%26Bookmarked%3Dtrue%26content%3D%26switched%3D&thumb_width=320&quality=80'
                'ScreenshotUrlTo': 'https://api.urlbox.io/v1/FLMG5BM3XeqMGa42/f9ef8e3b40885a6acde8c71ffdac6aac3365525e/png?url=Bookmarks&thumb_width=320&quality=80'
              'author': 'S54FphiBzL3KueFF4'
              'createdAt': 1515728156303
              'title': 'Linkstates for Linkstate - Connecting is seeing - Linkstate.youiest.com'
            'Linkstate%2Eyouiest%2Ecom%2Fabout':
              'from': 'Linkstate%2Eyouiest%2Ecom%2Fabout'
              'to': 'Bookmarks'
              'meta':
                'title': 'Linkstate - Connecting is seeing'
                'weight': 7
                'face': 'http://graph.facebook.com/v2.7/10154232419354595/picture?type=square'
                'profileLink': 'https://www.facebook.com/app_scoped_user_id/10154232419354595/'
                'FromLink': 'Linkstate.youiest.com/about'
                'ToLink': 'Bookmarks'
                'ScreenshotUrl': 'https://api.urlbox.io/v1/FLMG5BM3XeqMGa42/7c81ff8950b76e157e44b1a70cfb81532f9a170c/png?url=Linkstate.youiest.com%2Fabout&thumb_width=320&quality=80'
                'ScreenshotUrlTo': 'https://api.urlbox.io/v1/FLMG5BM3XeqMGa42/f9ef8e3b40885a6acde8c71ffdac6aac3365525e/png?url=Bookmarks&thumb_width=320&quality=80'
              'author': 'S54FphiBzL3KueFF4'
              'createdAt': 1515894288449
              'title': 'Linkstate - Connecting is seeing'
            'https%3A%2F%2Flinkstate%2Eyouiest%2Ecom%2Fabout%3Ffrom%3DBookmarks%26lastTitle%3DGrid%252520List%252520-%252520Material-UI%26Bookmarked%3Dtrue%26to%3Dhttps%25253A%25252F%25252Fmopinion%2Ecom%25252Ftop-10-website-annotation-tools%25252F%26content%3D%26switched%3D':
              'from': 'https%3A%2F%2Flinkstate%2Eyouiest%2Ecom%2Fabout%3Ffrom%3DBookmarks%26lastTitle%3DGrid%252520List%252520-%252520Material-UI%26Bookmarked%3Dtrue%26to%3Dhttps%25253A%25252F%25252Fmopinion%2Ecom%25252Ftop-10-website-annotation-tools%25252F%26content%3D%26switched%3D'
              'to': 'Bookmarks'
              'meta':
                'weight': 5
                'title': 'Linkstates for Bookmarks - and other placeholders - Bookmarks'
                'face': 'http://graph.facebook.com/v2.7/10154232419354595/picture?type=square'
                'profileLink': 'https://www.facebook.com/app_scoped_user_id/10154232419354595/'
                'FromLink': 'https://linkstate.youiest.com/about?from=Bookmarks&lastTitle=Grid%2520List%2520-%2520Material-UI&Bookmarked=true&to=https%253A%252F%252Fmopinion.com%252Ftop-10-website-annotation-tools%252F&content=&switched='
                'ToLink': 'Bookmarks'
                'ScreenshotUrl': 'https://api.urlbox.io/v1/FLMG5BM3XeqMGa42/891c9105bb40fedaf3946178f7ee21f0cf25cb54/png?url=https%3A%2F%2Flinkstate.youiest.com%2Fabout%3Ffrom%3DBookmarks%26lastTitle%3DGrid%252520List%252520-%252520Material-UI%26Bookmarked%3Dtrue%26to%3Dhttps%25253A%25252F%25252Fmopinion.com%25252Ftop-10-website-annotation-tools%25252F%26content%3D%26switched%3D&thumb_width=320&quality=80'
                'ScreenshotUrlTo': 'https://api.urlbox.io/v1/FLMG5BM3XeqMGa42/f9ef8e3b40885a6acde8c71ffdac6aac3365525e/png?url=Bookmarks&thumb_width=320&quality=80'
              'author': 'S54FphiBzL3KueFF4'
              'createdAt': 1515750433476
              'title': 'Linkstates for Bookmarks - and other placeholders - Bookmarks'
            'https%3A%2F%2Fdevelopers%2Efacebook%2Ecom%2Fproducts%2Fsocial-plugins%2Fcomments%2F%3Futm_campaign%3Dsocial_plugins%26utm_medium%3Doffsite_pages%26utm_source%3Dcomments_plugin':
              'from': 'https%3A%2F%2Fdevelopers%2Efacebook%2Ecom%2Fproducts%2Fsocial-plugins%2Fcomments%2F%3Futm_campaign%3Dsocial_plugins%26utm_medium%3Doffsite_pages%26utm_source%3Dcomments_plugin'
              'to': 'Bookmarks'
              'meta':
                'weight': 5
                'title': 'Comments - Facebook for Developers'
                'face': 'http://graph.facebook.com/v2.7/10154232419354595/picture?type=square'
                'profileLink': 'https://www.facebook.com/app_scoped_user_id/10154232419354595/'
                'FromLink': 'https://developers.facebook.com/products/social-plugins/comments/?utm_campaign=social_plugins&utm_medium=offsite_pages&utm_source=comments_plugin'
                'ToLink': 'Bookmarks'
                'ScreenshotUrl': 'https://api.urlbox.io/v1/FLMG5BM3XeqMGa42/07d8c5a90f1c223ccd0f83a8637374368bb68178/png?url=https%3A%2F%2Fdevelopers.facebook.com%2Fproducts%2Fsocial-plugins%2Fcomments%2F%3Futm_campaign%3Dsocial_plugins%26utm_medium%3Doffsite_pages%26utm_source%3Dcomments_plugin&thumb_width=320&quality=80'
                'ScreenshotUrlTo': 'https://api.urlbox.io/v1/FLMG5BM3XeqMGa42/f9ef8e3b40885a6acde8c71ffdac6aac3365525e/png?url=Bookmarks&thumb_width=320&quality=80'
              'author': 'S54FphiBzL3KueFF4'
              'createdAt': 1515893775950
              'title': 'Comments - Facebook for Developers'
            'http%3A%2F%2Fwww%2Ematerial-ui%2Ecom%2Fv0%2E15%2E0%2F%23%2Fcomponents%2Ficon-button':
              'from': 'http%3A%2F%2Fwww%2Ematerial-ui%2Ecom%2Fv0%2E15%2E0%2F%23%2Fcomponents%2Ficon-button'
              'to': 'Bookmarks'
              'meta':
                'weight': 5
                'title': 'Icon Button - Material-UI'
                'face': 'http://graph.facebook.com/v2.7/10154232419354595/picture?type=square'
                'profileLink': 'https://www.facebook.com/app_scoped_user_id/10154232419354595/'
                'FromLink': 'http://www.material-ui.com/v0.15.0/#/components/icon-button'
                'ToLink': 'Bookmarks'
                'ScreenshotUrl': 'https://api.urlbox.io/v1/FLMG5BM3XeqMGa42/bc419c1ffae6d735068eb38564b861249f53af0f/png?url=http%3A%2F%2Fwww.material-ui.com%2Fv0.15.0%2F%23%2Fcomponents%2Ficon-button&thumb_width=320&quality=80'
                'ScreenshotUrlTo': 'https://api.urlbox.io/v1/FLMG5BM3XeqMGa42/f9ef8e3b40885a6acde8c71ffdac6aac3365525e/png?url=Bookmarks&thumb_width=320&quality=80'
              'author': 'S54FphiBzL3KueFF4'
              'createdAt': 1515752736619
              'title': 'Icon Button - Material-UI'
            'https%3A%2F%2Fwww%2Enpmjs%2Ecom%2Fpackage%2Fcopy-to-clipboard':
              'from': 'https%3A%2F%2Fwww%2Enpmjs%2Ecom%2Fpackage%2Fcopy-to-clipboard'
              'to': 'Bookmarks'
              'meta':
                'weight': 5
                'title': 'copy-to-clipboard'
                'face': 'http://graph.facebook.com/v2.7/10154232419354595/picture?type=square'
                'profileLink': 'https://www.facebook.com/app_scoped_user_id/10154232419354595/'
                'FromLink': 'https://www.npmjs.com/package/copy-to-clipboard'
                'ToLink': 'Bookmarks'
                'ScreenshotUrl': 'https://api.urlbox.io/v1/FLMG5BM3XeqMGa42/8be9bf072d4ca4620ea074275282f8e0acc74174/png?url=https%3A%2F%2Fwww.npmjs.com%2Fpackage%2Fcopy-to-clipboard&thumb_width=320&quality=80'
                'ScreenshotUrlTo': 'https://api.urlbox.io/v1/FLMG5BM3XeqMGa42/f9ef8e3b40885a6acde8c71ffdac6aac3365525e/png?url=Bookmarks&thumb_width=320&quality=80'
              'author': 'S54FphiBzL3KueFF4'
              'createdAt': 1515848424123
              'title': 'copy-to-clipboard'
            'http%3A%2F%2Fwww%2Ematerial-ui%2Ecom%2Fv0%2E15%2E0%2F%23%2Fcomponents%2Ffloating-action-button':
              'from': 'http%3A%2F%2Fwww%2Ematerial-ui%2Ecom%2Fv0%2E15%2E0%2F%23%2Fcomponents%2Ffloating-action-button'
              'to': 'Bookmarks'
              'meta':
                'weight': 5
                'title': 'Floating Action Button - Material-UI'
                'face': 'http://graph.facebook.com/v2.7/10154232419354595/picture?type=square'
                'profileLink': 'https://www.facebook.com/app_scoped_user_id/10154232419354595/'
                'FromLink': 'http://www.material-ui.com/v0.15.0/#/components/floating-action-button'
                'ToLink': 'Bookmarks'
                'ScreenshotUrl': 'https://api.urlbox.io/v1/FLMG5BM3XeqMGa42/da1d05c7c97b6a4f5473451ee8905aa7484401dd/png?url=http%3A%2F%2Fwww.material-ui.com%2Fv0.15.0%2F%23%2Fcomponents%2Ffloating-action-button&thumb_width=320&quality=80'
                'ScreenshotUrlTo': 'https://api.urlbox.io/v1/FLMG5BM3XeqMGa42/f9ef8e3b40885a6acde8c71ffdac6aac3365525e/png?url=Bookmarks&thumb_width=320&quality=80'
              'author': 'S54FphiBzL3KueFF4'
              'createdAt': 1515849481404
              'title': 'Floating Action Button - Material-UI'
            'https%3A%2F%2Furlbox%2Eio%2Fdashboard':
              'from': 'https%3A%2F%2Furlbox%2Eio%2Fdashboard'
              'to': 'Bookmarks'
              'meta':
                'weight': 5
                'title': 'User Dashboard | Urlbox'
                'face': 'http://graph.facebook.com/v2.7/10154232419354595/picture?type=square'
                'profileLink': 'https://www.facebook.com/app_scoped_user_id/10154232419354595/'
                'FromLink': 'https://urlbox.io/dashboard'
                'ToLink': 'Bookmarks'
                'ScreenshotUrl': 'https://api.urlbox.io/v1/FLMG5BM3XeqMGa42/470f97a39f9047b5aedc6918697e66578003b17c/png?url=https%3A%2F%2Furlbox.io%2Fdashboard&thumb_width=320&quality=80'
                'ScreenshotUrlTo': 'https://api.urlbox.io/v1/FLMG5BM3XeqMGa42/f9ef8e3b40885a6acde8c71ffdac6aac3365525e/png?url=Bookmarks&thumb_width=320&quality=80'
              'author': 'S54FphiBzL3KueFF4'
              'createdAt': 1515852668465
              'title': 'User Dashboard | Urlbox'
            'http%3A%2F%2Fwww%2Ematerial-ui%2Ecom%2Fv0%2E15%2E0%2F%23%2Fcomponents%2Fdivider':
              'from': 'http%3A%2F%2Fwww%2Ematerial-ui%2Ecom%2Fv0%2E15%2E0%2F%23%2Fcomponents%2Fdivider'
              'to': 'Bookmarks'
              'meta':
                'weight': 5
                'title': 'Material-UI'
                'face': 'http://graph.facebook.com/v2.7/10154232419354595/picture?type=square'
                'profileLink': 'https://www.facebook.com/app_scoped_user_id/10154232419354595/'
                'FromLink': 'http://www.material-ui.com/v0.15.0/#/components/divider'
                'ToLink': 'Bookmarks'
                'ScreenshotUrl': 'https://api.urlbox.io/v1/FLMG5BM3XeqMGa42/e01735992a16b0765be9dfff99a1e69c62c39d76/png?url=http%3A%2F%2Fwww.material-ui.com%2Fv0.15.0%2F%23%2Fcomponents%2Fdivider&thumb_width=320&quality=80'
                'ScreenshotUrlTo': 'https://api.urlbox.io/v1/FLMG5BM3XeqMGa42/f9ef8e3b40885a6acde8c71ffdac6aac3365525e/png?url=Bookmarks&thumb_width=320&quality=80'
              'author': 'S54FphiBzL3KueFF4'
              'createdAt': 1515893133244
              'title': 'Material-UI'
            'http%3A%2F%2Fwww%2Ematerial-ui%2Ecom%2Fv0%2E15%2E0%2F%23%2Fcomponents%2Fdrawer':
              'from': 'http%3A%2F%2Fwww%2Ematerial-ui%2Ecom%2Fv0%2E15%2E0%2F%23%2Fcomponents%2Fdrawer'
              'to': 'Bookmarks'
              'meta':
                'weight': 5
                'title': 'Drawer - Material-UI'
                'face': 'http://graph.facebook.com/v2.7/10154232419354595/picture?type=square'
                'profileLink': 'https://www.facebook.com/app_scoped_user_id/10154232419354595/'
                'FromLink': 'http://www.material-ui.com/v0.15.0/#/components/drawer'
                'ToLink': 'Bookmarks'
                'ScreenshotUrl': 'https://api.urlbox.io/v1/FLMG5BM3XeqMGa42/d99ca99ca087fe2a9d1b01035322b66bd9d3530d/png?url=http%3A%2F%2Fwww.material-ui.com%2Fv0.15.0%2F%23%2Fcomponents%2Fdrawer&thumb_width=320&quality=80'
                'ScreenshotUrlTo': 'https://api.urlbox.io/v1/FLMG5BM3XeqMGa42/f9ef8e3b40885a6acde8c71ffdac6aac3365525e/png?url=Bookmarks&thumb_width=320&quality=80'
              'author': 'S54FphiBzL3KueFF4'
              'createdAt': 1515896611045
              'title': 'Drawer - Material-UI'
          'Linkstate%2Eyouiest%2Ecom': 'Bookmarks':
            'from': 'Bookmarks'
            'to': 'Linkstate%2Eyouiest%2Ecom'
            'meta':
              'body': 'hjkkwer'
              'weight': 4
              'title': 'Bookmarks - and other placeholders'
              'face': 'http://graph.facebook.com/v2.7/10154232419354595/picture?type=square'
              'profileLink': 'https://www.facebook.com/app_scoped_user_id/10154232419354595/'
              'FromLink': 'Bookmarks'
              'ToLink': 'Linkstate.youiest.com'
              'ScreenshotUrl': 'https://api.urlbox.io/v1/FLMG5BM3XeqMGa42/f9ef8e3b40885a6acde8c71ffdac6aac3365525e/png?url=Bookmarks&thumb_width=320&quality=80'
              'ScreenshotUrlTo': 'https://api.urlbox.io/v1/FLMG5BM3XeqMGa42/117475d1c2f4d6fac7710dcc2f841e06b46e06b3/png?url=Linkstate.youiest.com&thumb_width=320&quality=80'
            'author': 'S54FphiBzL3KueFF4'
            'createdAt': 1515675012528
            'title': 'Bookmarks - and other placeholders'
          'https%3A%2F%2Fwww%2Efacebook%2Ecom%2Fapp_scoped_user_id%2F10154232419354595%2F':
            'Bookmarks':
              'from': 'https%3A%2F%2Fwww%2Efacebook%2Ecom%2Fapp_scoped_user_id%2F10154232419354595%2F'
              'to': 'Bookmarks'
              'meta':
                'title': 'Elias Moosman on Facebook'
                'weight': 7
                'face': 'http://graph.facebook.com/v2.7/10154232419354595/picture?type=square'
                'profileLink': 'https://www.facebook.com/app_scoped_user_id/10154232419354595/'
                'FromLink': 'https://www.facebook.com/app_scoped_user_id/10154232419354595/'
                'ToLink': 'Bookmarks'
                'ScreenshotUrl': 'https://api.thumbalizr.com/?url=https://www.facebook.com/app_scoped_user_id/10154232419354595/&width=250&api_key=UQ6CMod6tIkVLam271a7WdUlutEJJHTE'
                'ScreenshotUrlTo': 'https://api.thumbalizr.com/?url=Bookmarks&width=250&api_key=UQ6CMod6tIkVLam271a7WdUlutEJJHTE'
              'author': 'S54FphiBzL3KueFF4'
              'createdAt': 1515650468975
              'title': 'Elias Moosman on Facebook'
            'https%3A%2F%2Fwww%2Efacebook%2Ecom%2Fapp_scoped_user_id%2F10154232419354595%2F':
              'from': 'https%3A%2F%2Fwww%2Efacebook%2Ecom%2Fapp_scoped_user_id%2F10154232419354595%2F'
              'to': 'https%3A%2F%2Fwww%2Efacebook%2Ecom%2Fapp_scoped_user_id%2F10154232419354595%2F'
              'meta':
                'body': ''
                'weight': 6
                'title': 'Elias Moosman on Facebook'
                'face': 'http://graph.facebook.com/v2.7/10154232419354595/picture?type=square'
                'profileLink': 'https://www.facebook.com/app_scoped_user_id/10154232419354595/'
                'FromLink': 'https://www.facebook.com/app_scoped_user_id/10154232419354595/'
                'ToLink': 'https://www.facebook.com/app_scoped_user_id/10154232419354595/'
                'ScreenshotUrl': 'https://api.urlbox.io/v1/FLMG5BM3XeqMGa42/9b1a5f128cbac84d2142d3377200235906e5a39e/png?url=https%3A%2F%2Fwww.facebook.com%2Fapp_scoped_user_id%2F10154232419354595%2F&thumb_width=320&quality=80'
                'ScreenshotUrlTo': 'https://api.urlbox.io/v1/FLMG5BM3XeqMGa42/9b1a5f128cbac84d2142d3377200235906e5a39e/png?url=https%3A%2F%2Fwww.facebook.com%2Fapp_scoped_user_id%2F10154232419354595%2F&thumb_width=320&quality=80'
              'author': 'S54FphiBzL3KueFF4'
              'createdAt': 1515848689254
              'title': 'Elias Moosman on Facebook'
          'http%3A%2F%2Flocalhost%3A3000%2Fabout%3Ffrom%3Dhttps%25253A%25252F%25252Fwww%2Efacebook%2Ecom%25252Fapp_scoped_user_id%25252F10154232419354595%25252F%26lastTitle%3DIcon%252520Button%252520-%252520Material-UI%26to%3DBookmarks%26Bookmarked%3Dtrue%26content%3Dhahah%26switched%3D': 'Bookmarks':
            'from': 'http%3A%2F%2Flocalhost%3A3000%2Fabout%3Ffrom%3Dhttps%25253A%25252F%25252Fwww%2Efacebook%2Ecom%25252Fapp_scoped_user_id%25252F10154232419354595%25252F%26lastTitle%3DIcon%252520Button%252520-%252520Material-UI%26to%3DBookmarks%26Bookmarked%3Dtrue%26content%3Dhahah%26switched%3D'
            'to': 'Bookmarks'
            'meta':
              'weight': 5
              'title': 'Linkstates for Elias Moosman on Facebook - https://www.facebook.com/app_scoped_user_id/10154232419354595/'
              'face': 'http://graph.facebook.com/v2.7/10154232419354595/picture?type=square'
              'profileLink': 'https://www.facebook.com/app_scoped_user_id/10154232419354595/'
              'FromLink': 'http://localhost:3000/about?from=https%253A%252F%252Fwww.facebook.com%252Fapp_scoped_user_id%252F10154232419354595%252F&lastTitle=Icon%2520Button%2520-%2520Material-UI&to=Bookmarks&Bookmarked=true&content=hahah&switched='
              'ToLink': 'Bookmarks'
              'ScreenshotUrl': 'https://api.thumbalizr.com/?url=http://localhost:3000/about?from=https%253A%252F%252Fwww.facebook.com%252Fapp_scoped_user_id%252F10154232419354595%252F&lastTitle=Icon%2520Button%2520-%2520Material-UI&to=Bookmarks&Bookmarked=true&content=hahah&switched=&width=250&api_key=UQ6CMod6tIkVLam271a7WdUlutEJJHTE'
              'ScreenshotUrlTo': 'https://api.thumbalizr.com/?url=Bookmarks&width=250&api_key=UQ6CMod6tIkVLam271a7WdUlutEJJHTE'
            'author': 'S54FphiBzL3KueFF4'
            'createdAt': 1515650383851
            'title': 'Linkstates for Elias Moosman on Facebook - https://www.facebook.com/app_scoped_user_id/10154232419354595/'
          'https%3A%2F%2Fstackoverflow%2Ecom%2Fquestions%2F9529078%2Fhow-do-i-use-git-reset-hard-head-to-revert-to-a-previous-commit': 'Bookmarks':
            'from': 'https%3A%2F%2Fstackoverflow%2Ecom%2Fquestions%2F9529078%2Fhow-do-i-use-git-reset-hard-head-to-revert-to-a-previous-commit'
            'to': 'Bookmarks'
            'meta':
              'weight': 5
              'title': 'How do I use \'git reset --hard HEAD\' to revert to a previous commit? - Stack Overflow'
              'face': 'http://graph.facebook.com/v2.7/10154232419354595/picture?type=square'
              'profileLink': 'https://www.facebook.com/app_scoped_user_id/10154232419354595/'
              'FromLink': 'https://stackoverflow.com/questions/9529078/how-do-i-use-git-reset-hard-head-to-revert-to-a-previous-commit'
              'ToLink': 'Bookmarks'
              'ScreenshotUrl': 'https://api.thumbalizr.com/?url=https://stackoverflow.com/questions/9529078/how-do-i-use-git-reset-hard-head-to-revert-to-a-previous-commit&width=250&api_key=UQ6CMod6tIkVLam271a7WdUlutEJJHTE'
              'ScreenshotUrlTo': 'https://api.thumbalizr.com/?url=Bookmarks&width=250&api_key=UQ6CMod6tIkVLam271a7WdUlutEJJHTE'
            'author': 'S54FphiBzL3KueFF4'
            'createdAt': 1515650480814
            'title': 'How do I use \'git reset --hard HEAD\' to revert to a previous commit? - Stack Overflow'
          'Linkstate%2Eyouiest%2Ecom%2Fabout':
            'Linkstate%2Eyouiest%2Ecom':
              'from': 'Linkstate%2Eyouiest%2Ecom'
              'to': 'Linkstate%2Eyouiest%2Ecom%2Fabout'
              'meta':
                'title': 'Linkstate - Connecting is seeing'
                'weight': 8
                'body': 'The fate of bookmarks can tell us a lot about Linkstate'
                'face': 'http://graph.facebook.com/v2.7/10154232419354595/picture?type=square'
                'profileLink': 'https://www.facebook.com/app_scoped_user_id/10154232419354595/'
                'FromLink': 'Linkstate.youiest.com'
                'ToLink': 'Linkstate.youiest.com/about'
                'ScreenshotUrl': 'https://api.urlbox.io/v1/FLMG5BM3XeqMGa42/117475d1c2f4d6fac7710dcc2f841e06b46e06b3/png?url=Linkstate.youiest.com&thumb_width=320&quality=80'
                'ScreenshotUrlTo': 'https://api.urlbox.io/v1/FLMG5BM3XeqMGa42/7c81ff8950b76e157e44b1a70cfb81532f9a170c/png?url=Linkstate.youiest.com%2Fabout&thumb_width=320&quality=80'
              'author': 'S54FphiBzL3KueFF4'
              'createdAt': 1515744706613
              'title': 'Linkstate - Connecting is seeing'
            'Linkstate%2Eyouiest%2Ecom%2Fabout':
              'from': 'Linkstate%2Eyouiest%2Ecom%2Fabout'
              'to': 'Linkstate%2Eyouiest%2Ecom%2Fabout'
              'meta':
                'title': 'Linkstate - Connecting is seeing'
                'weight': 8
                'body': 'The fate of bookmarks can tell us a lot about Linkstate'
                'face': 'http://graph.facebook.com/v2.7/10154232419354595/picture?type=square'
                'profileLink': 'https://www.facebook.com/app_scoped_user_id/10154232419354595/'
                'FromLink': 'Linkstate.youiest.com/about'
                'ToLink': 'Linkstate.youiest.com/about'
                'ScreenshotUrl': 'https://api.urlbox.io/v1/FLMG5BM3XeqMGa42/7c81ff8950b76e157e44b1a70cfb81532f9a170c/png?url=Linkstate.youiest.com%2Fabout&thumb_width=320&quality=80'
                'ScreenshotUrlTo': 'https://api.urlbox.io/v1/FLMG5BM3XeqMGa42/7c81ff8950b76e157e44b1a70cfb81532f9a170c/png?url=Linkstate.youiest.com%2Fabout&thumb_width=320&quality=80'
              'author': 'S54FphiBzL3KueFF4'
              'createdAt': 1515894288582
              'title': 'Linkstate - Connecting is seeing'
            'https%3A%2F%2Fdevelopers%2Efacebook%2Ecom%2Fproducts%2Fsocial-plugins%2Fcomments%2F%3Futm_campaign%3Dsocial_plugins%26utm_medium%3Doffsite_pages%26utm_source%3Dcomments_plugin':
              'from': 'https%3A%2F%2Fdevelopers%2Efacebook%2Ecom%2Fproducts%2Fsocial-plugins%2Fcomments%2F%3Futm_campaign%3Dsocial_plugins%26utm_medium%3Doffsite_pages%26utm_source%3Dcomments_plugin'
              'to': 'Linkstate%2Eyouiest%2Ecom%2Fabout'
              'meta':
                'body': 'hasd'
                'weight': 5
                'title': 'Comments - Facebook for Developers'
                'face': 'http://graph.facebook.com/v2.7/10154232419354595/picture?type=square'
                'profileLink': 'https://www.facebook.com/app_scoped_user_id/10154232419354595/'
                'FromLink': 'https://developers.facebook.com/products/social-plugins/comments/?utm_campaign=social_plugins&utm_medium=offsite_pages&utm_source=comments_plugin'
                'ToLink': 'Linkstate.youiest.com/about'
                'ScreenshotUrl': 'https://api.urlbox.io/v1/FLMG5BM3XeqMGa42/07d8c5a90f1c223ccd0f83a8637374368bb68178/png?url=https%3A%2F%2Fdevelopers.facebook.com%2Fproducts%2Fsocial-plugins%2Fcomments%2F%3Futm_campaign%3Dsocial_plugins%26utm_medium%3Doffsite_pages%26utm_source%3Dcomments_plugin&thumb_width=320&quality=80'
                'ScreenshotUrlTo': 'https://api.urlbox.io/v1/FLMG5BM3XeqMGa42/7c81ff8950b76e157e44b1a70cfb81532f9a170c/png?url=Linkstate.youiest.com%2Fabout&thumb_width=320&quality=80'
              'author': 'S54FphiBzL3KueFF4'
              'createdAt': 1515752725802
              'title': 'Comments - Facebook for Developers'
            'http%3A%2F%2Fwww%2Ematerial-ui%2Ecom%2Fv0%2E15%2E0%2F%23%2Fcomponents%2Ficon-button':
              'from': 'http%3A%2F%2Fwww%2Ematerial-ui%2Ecom%2Fv0%2E15%2E0%2F%23%2Fcomponents%2Ficon-button'
              'to': 'Linkstate%2Eyouiest%2Ecom%2Fabout'
              'meta':
                'body': ''
                'weight': 7
                'title': 'Icon Button - Material-UI'
                'face': 'http://graph.facebook.com/v2.7/10154232419354595/picture?type=square'
                'profileLink': 'https://www.facebook.com/app_scoped_user_id/10154232419354595/'
                'FromLink': 'http://www.material-ui.com/v0.15.0/#/components/icon-button'
                'ToLink': 'Linkstate.youiest.com/about'
                'ScreenshotUrl': 'https://api.urlbox.io/v1/FLMG5BM3XeqMGa42/bc419c1ffae6d735068eb38564b861249f53af0f/png?url=http%3A%2F%2Fwww.material-ui.com%2Fv0.15.0%2F%23%2Fcomponents%2Ficon-button&thumb_width=320&quality=80'
                'ScreenshotUrlTo': 'https://api.urlbox.io/v1/FLMG5BM3XeqMGa42/7c81ff8950b76e157e44b1a70cfb81532f9a170c/png?url=Linkstate.youiest.com%2Fabout&thumb_width=320&quality=80'
              'author': 'S54FphiBzL3KueFF4'
              'createdAt': 1515848417835
              'title': 'Icon Button - Material-UI'
            'https%3A%2F%2Fwww%2Enpmjs%2Ecom%2Fpackage%2Fcopy-to-clipboard':
              'from': 'https%3A%2F%2Fwww%2Enpmjs%2Ecom%2Fpackage%2Fcopy-to-clipboard'
              'to': 'Linkstate%2Eyouiest%2Ecom%2Fabout'
              'meta':
                'body': 'haha'
                'weight': 6
                'title': 'copy-to-clipboard'
                'face': 'http://graph.facebook.com/v2.7/10154232419354595/picture?type=square'
                'profileLink': 'https://www.facebook.com/app_scoped_user_id/10154232419354595/'
                'FromLink': 'https://www.npmjs.com/package/copy-to-clipboard'
                'ToLink': 'Linkstate.youiest.com/about'
                'ScreenshotUrl': 'https://api.urlbox.io/v1/FLMG5BM3XeqMGa42/8be9bf072d4ca4620ea074275282f8e0acc74174/png?url=https%3A%2F%2Fwww.npmjs.com%2Fpackage%2Fcopy-to-clipboard&thumb_width=320&quality=80'
                'ScreenshotUrlTo': 'https://api.urlbox.io/v1/FLMG5BM3XeqMGa42/7c81ff8950b76e157e44b1a70cfb81532f9a170c/png?url=Linkstate.youiest.com%2Fabout&thumb_width=320&quality=80'
              'author': 'S54FphiBzL3KueFF4'
              'createdAt': 1515852726942
              'title': 'copy-to-clipboard'
            'http%3A%2F%2Fwww%2Ematerial-ui%2Ecom%2Fv0%2E15%2E0%2F%23%2Fcomponents%2Ffloating-action-button':
              'from': 'http%3A%2F%2Fwww%2Ematerial-ui%2Ecom%2Fv0%2E15%2E0%2F%23%2Fcomponents%2Ffloating-action-button'
              'to': 'Linkstate%2Eyouiest%2Ecom%2Fabout'
              'meta':
                'body': 'haha'
                'weight': 7
                'title': 'Floating Action Button - Material-UI'
                'face': 'http://graph.facebook.com/v2.7/10154232419354595/picture?type=square'
                'profileLink': 'https://www.facebook.com/app_scoped_user_id/10154232419354595/'
                'FromLink': 'http://www.material-ui.com/v0.15.0/#/components/floating-action-button'
                'ToLink': 'Linkstate.youiest.com/about'
                'ScreenshotUrl': 'https://api.urlbox.io/v1/FLMG5BM3XeqMGa42/da1d05c7c97b6a4f5473451ee8905aa7484401dd/png?url=http%3A%2F%2Fwww.material-ui.com%2Fv0.15.0%2F%23%2Fcomponents%2Ffloating-action-button&thumb_width=320&quality=80'
                'ScreenshotUrlTo': 'https://api.urlbox.io/v1/FLMG5BM3XeqMGa42/7c81ff8950b76e157e44b1a70cfb81532f9a170c/png?url=Linkstate.youiest.com%2Fabout&thumb_width=320&quality=80'
              'author': 'S54FphiBzL3KueFF4'
              'createdAt': 1515852807096
              'title': 'Floating Action Button - Material-UI'
          'http%3A%2F%2Fwww%2Ematerial-ui%2Ecom%2Fv0%2E15%2E0%2F%23%2Fcomponents%2Ficon-button': 'Linkstate%2Eyouiest%2Ecom%2Fabout':
            'from': 'Linkstate%2Eyouiest%2Ecom%2Fabout'
            'to': 'http%3A%2F%2Fwww%2Ematerial-ui%2Ecom%2Fv0%2E15%2E0%2F%23%2Fcomponents%2Ficon-button'
            'meta':
              'body': 'hi'
              'weight': 1
              'title': 'Linkstate - Connecting is seeing'
              'face': 'http://graph.facebook.com/v2.7/10154232419354595/picture?type=square'
              'profileLink': 'https://www.facebook.com/app_scoped_user_id/10154232419354595/'
              'FromLink': 'Linkstate.youiest.com/about'
              'ToLink': 'http://www.material-ui.com/v0.15.0/#/components/icon-button'
              'ScreenshotUrl': 'https://api.urlbox.io/v1/FLMG5BM3XeqMGa42/7c81ff8950b76e157e44b1a70cfb81532f9a170c/png?url=Linkstate.youiest.com%2Fabout&thumb_width=320&quality=80'
              'ScreenshotUrlTo': 'https://api.urlbox.io/v1/FLMG5BM3XeqMGa42/bc419c1ffae6d735068eb38564b861249f53af0f/png?url=http%3A%2F%2Fwww.material-ui.com%2Fv0.15.0%2F%23%2Fcomponents%2Ficon-button&thumb_width=320&quality=80'
            'author': 'S54FphiBzL3KueFF4'
            'createdAt': 1515765825514
            'title': 'Linkstate - Connecting is seeing'
          'http%3A%2F%2Fwww%2Ematerial-ui%2Ecom%2Fv0%2E15%2E0%2F%23%2Fcomponents%2Ffloating-action-button': 'https%3A%2F%2Fdevelopers%2Efacebook%2Ecom%2Fproducts%2Fsocial-plugins%2Fcomments%2F%3Futm_campaign%3Dsocial_plugins%26utm_medium%3Doffsite_pages%26utm_source%3Dcomments_plugin':
            'from': 'https%3A%2F%2Fdevelopers%2Efacebook%2Ecom%2Fproducts%2Fsocial-plugins%2Fcomments%2F%3Futm_campaign%3Dsocial_plugins%26utm_medium%3Doffsite_pages%26utm_source%3Dcomments_plugin'
            'to': 'http%3A%2F%2Fwww%2Ematerial-ui%2Ecom%2Fv0%2E15%2E0%2F%23%2Fcomponents%2Ffloating-action-button'
            'meta':
              'body': 'floating was last '
              'weight': 7
              'title': 'Comments - Facebook for Developers'
              'face': 'http://graph.facebook.com/v2.7/10154232419354595/picture?type=square'
              'profileLink': 'https://www.facebook.com/app_scoped_user_id/10154232419354595/'
              'FromLink': 'https://developers.facebook.com/products/social-plugins/comments/?utm_campaign=social_plugins&utm_medium=offsite_pages&utm_source=comments_plugin'
              'ToLink': 'http://www.material-ui.com/v0.15.0/#/components/floating-action-button'
              'ScreenshotUrl': 'https://api.urlbox.io/v1/FLMG5BM3XeqMGa42/07d8c5a90f1c223ccd0f83a8637374368bb68178/png?url=https%3A%2F%2Fdevelopers.facebook.com%2Fproducts%2Fsocial-plugins%2Fcomments%2F%3Futm_campaign%3Dsocial_plugins%26utm_medium%3Doffsite_pages%26utm_source%3Dcomments_plugin&thumb_width=320&quality=80'
              'ScreenshotUrlTo': 'https://api.urlbox.io/v1/FLMG5BM3XeqMGa42/da1d05c7c97b6a4f5473451ee8905aa7484401dd/png?url=http%3A%2F%2Fwww.material-ui.com%2Fv0.15.0%2F%23%2Fcomponents%2Ffloating-action-button&thumb_width=320&quality=80'
            'author': 'S54FphiBzL3KueFF4'
            'createdAt': 1515853396214
            'title': 'Comments - Facebook for Developers'
        'out':
          'Bookmarks':
            'Bookmarks':
              'from': 'Bookmarks'
              'to': 'Bookmarks'
              'meta':
                'title': 'Bookmarks - and other placeholders'
                'weight': 9
                'ScreenshotUrl': 'https://api.urlbox.io/v1/FLMG5BM3XeqMGa42/f9ef8e3b40885a6acde8c71ffdac6aac3365525e/png?url=Bookmarks&thumb_width=320&quality=80'
                'face': 'http://graph.facebook.com/v2.7/10154232419354595/picture?type=square'
                'profileLink': 'https://www.facebook.com/app_scoped_user_id/10154232419354595/'
                'FromLink': 'Bookmarks'
                'ToLink': 'Bookmarks'
                'ScreenshotUrlTo': 'https://api.urlbox.io/v1/FLMG5BM3XeqMGa42/f9ef8e3b40885a6acde8c71ffdac6aac3365525e/png?url=Bookmarks&thumb_width=320&quality=80'
              'author': 'S54FphiBzL3KueFF4'
              'createdAt': 1515894288198
              'title': 'Bookmarks - and other placeholders'
            'Linkstate%2Eyouiest%2Ecom':
              'from': 'Bookmarks'
              'to': 'Linkstate%2Eyouiest%2Ecom'
              'meta':
                'body': 'hjkkwer'
                'weight': 4
                'title': 'Bookmarks - and other placeholders'
                'face': 'http://graph.facebook.com/v2.7/10154232419354595/picture?type=square'
                'profileLink': 'https://www.facebook.com/app_scoped_user_id/10154232419354595/'
                'FromLink': 'Bookmarks'
                'ToLink': 'Linkstate.youiest.com'
                'ScreenshotUrl': 'https://api.urlbox.io/v1/FLMG5BM3XeqMGa42/f9ef8e3b40885a6acde8c71ffdac6aac3365525e/png?url=Bookmarks&thumb_width=320&quality=80'
                'ScreenshotUrlTo': 'https://api.urlbox.io/v1/FLMG5BM3XeqMGa42/117475d1c2f4d6fac7710dcc2f841e06b46e06b3/png?url=Linkstate.youiest.com&thumb_width=320&quality=80'
              'author': 'S54FphiBzL3KueFF4'
              'createdAt': 1515675012528
              'title': 'Bookmarks - and other placeholders'
            'https%3A%2F%2Fwww%2Efacebook%2Ecom%2Fapp_scoped_user_id%2F10154232419354595%2F':
              'from': 'https%3A%2F%2Fwww%2Efacebook%2Ecom%2Fapp_scoped_user_id%2F10154232419354595%2F'
              'to': 'Bookmarks'
              'meta':
                'title': 'Elias Moosman on Facebook'
                'weight': 7
                'face': 'http://graph.facebook.com/v2.7/10154232419354595/picture?type=square'
                'profileLink': 'https://www.facebook.com/app_scoped_user_id/10154232419354595/'
                'FromLink': 'https://www.facebook.com/app_scoped_user_id/10154232419354595/'
                'ToLink': 'Bookmarks'
                'ScreenshotUrl': 'https://api.thumbalizr.com/?url=https://www.facebook.com/app_scoped_user_id/10154232419354595/&width=250&api_key=UQ6CMod6tIkVLam271a7WdUlutEJJHTE'
                'ScreenshotUrlTo': 'https://api.thumbalizr.com/?url=Bookmarks&width=250&api_key=UQ6CMod6tIkVLam271a7WdUlutEJJHTE'
              'author': 'S54FphiBzL3KueFF4'
              'createdAt': 1515650468975
              'title': 'Elias Moosman on Facebook'
            'http%3A%2F%2Flocalhost%3A3000%2Fabout%3Ffrom%3Dhttps%25253A%25252F%25252Fwww%2Efacebook%2Ecom%25252Fapp_scoped_user_id%25252F10154232419354595%25252F%26lastTitle%3DIcon%252520Button%252520-%252520Material-UI%26to%3DBookmarks%26Bookmarked%3Dtrue%26content%3Dhahah%26switched%3D':
              'from': 'http%3A%2F%2Flocalhost%3A3000%2Fabout%3Ffrom%3Dhttps%25253A%25252F%25252Fwww%2Efacebook%2Ecom%25252Fapp_scoped_user_id%25252F10154232419354595%25252F%26lastTitle%3DIcon%252520Button%252520-%252520Material-UI%26to%3DBookmarks%26Bookmarked%3Dtrue%26content%3Dhahah%26switched%3D'
              'to': 'Bookmarks'
              'meta':
                'weight': 5
                'title': 'Linkstates for Elias Moosman on Facebook - https://www.facebook.com/app_scoped_user_id/10154232419354595/'
                'face': 'http://graph.facebook.com/v2.7/10154232419354595/picture?type=square'
                'profileLink': 'https://www.facebook.com/app_scoped_user_id/10154232419354595/'
                'FromLink': 'http://localhost:3000/about?from=https%253A%252F%252Fwww.facebook.com%252Fapp_scoped_user_id%252F10154232419354595%252F&lastTitle=Icon%2520Button%2520-%2520Material-UI&to=Bookmarks&Bookmarked=true&content=hahah&switched='
                'ToLink': 'Bookmarks'
                'ScreenshotUrl': 'https://api.thumbalizr.com/?url=http://localhost:3000/about?from=https%253A%252F%252Fwww.facebook.com%252Fapp_scoped_user_id%252F10154232419354595%252F&lastTitle=Icon%2520Button%2520-%2520Material-UI&to=Bookmarks&Bookmarked=true&content=hahah&switched=&width=250&api_key=UQ6CMod6tIkVLam271a7WdUlutEJJHTE'
                'ScreenshotUrlTo': 'https://api.thumbalizr.com/?url=Bookmarks&width=250&api_key=UQ6CMod6tIkVLam271a7WdUlutEJJHTE'
              'author': 'S54FphiBzL3KueFF4'
              'createdAt': 1515650383851
              'title': 'Linkstates for Elias Moosman on Facebook - https://www.facebook.com/app_scoped_user_id/10154232419354595/'
            'https%3A%2F%2Fstackoverflow%2Ecom%2Fquestions%2F9529078%2Fhow-do-i-use-git-reset-hard-head-to-revert-to-a-previous-commit':
              'from': 'https%3A%2F%2Fstackoverflow%2Ecom%2Fquestions%2F9529078%2Fhow-do-i-use-git-reset-hard-head-to-revert-to-a-previous-commit'
              'to': 'Bookmarks'
              'meta':
                'weight': 5
                'title': 'How do I use \'git reset --hard HEAD\' to revert to a previous commit? - Stack Overflow'
                'face': 'http://graph.facebook.com/v2.7/10154232419354595/picture?type=square'
                'profileLink': 'https://www.facebook.com/app_scoped_user_id/10154232419354595/'
                'FromLink': 'https://stackoverflow.com/questions/9529078/how-do-i-use-git-reset-hard-head-to-revert-to-a-previous-commit'
                'ToLink': 'Bookmarks'
                'ScreenshotUrl': 'https://api.thumbalizr.com/?url=https://stackoverflow.com/questions/9529078/how-do-i-use-git-reset-hard-head-to-revert-to-a-previous-commit&width=250&api_key=UQ6CMod6tIkVLam271a7WdUlutEJJHTE'
                'ScreenshotUrlTo': 'https://api.thumbalizr.com/?url=Bookmarks&width=250&api_key=UQ6CMod6tIkVLam271a7WdUlutEJJHTE'
              'author': 'S54FphiBzL3KueFF4'
              'createdAt': 1515650480814
              'title': 'How do I use \'git reset --hard HEAD\' to revert to a previous commit? - Stack Overflow'
          'https%3A%2F%2Fwww%2Efacebook%2Ecom%2Fapp_scoped_user_id%2F10154232419354595%2F':
            'Bookmarks':
              'from': 'https%3A%2F%2Fwww%2Efacebook%2Ecom%2Fapp_scoped_user_id%2F10154232419354595%2F'
              'to': 'Bookmarks'
              'meta':
                'title': 'Elias Moosman on Facebook'
                'weight': 7
                'face': 'http://graph.facebook.com/v2.7/10154232419354595/picture?type=square'
                'profileLink': 'https://www.facebook.com/app_scoped_user_id/10154232419354595/'
                'FromLink': 'https://www.facebook.com/app_scoped_user_id/10154232419354595/'
                'ToLink': 'Bookmarks'
                'ScreenshotUrl': 'https://api.urlbox.io/v1/FLMG5BM3XeqMGa42/9b1a5f128cbac84d2142d3377200235906e5a39e/png?url=https%3A%2F%2Fwww.facebook.com%2Fapp_scoped_user_id%2F10154232419354595%2F&thumb_width=320&quality=80'
                'ScreenshotUrlTo': 'https://api.urlbox.io/v1/FLMG5BM3XeqMGa42/f9ef8e3b40885a6acde8c71ffdac6aac3365525e/png?url=Bookmarks&thumb_width=320&quality=80'
              'author': 'S54FphiBzL3KueFF4'
              'createdAt': 1515894288763
              'title': 'Elias Moosman on Facebook'
            'https%3A%2F%2Fwww%2Efacebook%2Ecom%2Fapp_scoped_user_id%2F10154232419354595%2F':
              'from': 'https%3A%2F%2Fwww%2Efacebook%2Ecom%2Fapp_scoped_user_id%2F10154232419354595%2F'
              'to': 'https%3A%2F%2Fwww%2Efacebook%2Ecom%2Fapp_scoped_user_id%2F10154232419354595%2F'
              'meta':
                'body': ''
                'weight': 6
                'title': 'Elias Moosman on Facebook'
                'face': 'http://graph.facebook.com/v2.7/10154232419354595/picture?type=square'
                'profileLink': 'https://www.facebook.com/app_scoped_user_id/10154232419354595/'
                'FromLink': 'https://www.facebook.com/app_scoped_user_id/10154232419354595/'
                'ToLink': 'https://www.facebook.com/app_scoped_user_id/10154232419354595/'
                'ScreenshotUrl': 'https://api.urlbox.io/v1/FLMG5BM3XeqMGa42/9b1a5f128cbac84d2142d3377200235906e5a39e/png?url=https%3A%2F%2Fwww.facebook.com%2Fapp_scoped_user_id%2F10154232419354595%2F&thumb_width=320&quality=80'
                'ScreenshotUrlTo': 'https://api.urlbox.io/v1/FLMG5BM3XeqMGa42/9b1a5f128cbac84d2142d3377200235906e5a39e/png?url=https%3A%2F%2Fwww.facebook.com%2Fapp_scoped_user_id%2F10154232419354595%2F&thumb_width=320&quality=80'
              'author': 'S54FphiBzL3KueFF4'
              'createdAt': 1515848689254
              'title': 'Elias Moosman on Facebook'
          'Linkstate%2Eyouiest%2Ecom':
            'Bookmarks':
              'from': 'Linkstate%2Eyouiest%2Ecom'
              'to': 'Bookmarks'
              'meta':
                'title': 'Linkstate - Connecting is seeing'
                'weight': 7
                'face': 'http://graph.facebook.com/v2.7/10154232419354595/picture?type=square'
                'profileLink': 'https://www.facebook.com/app_scoped_user_id/10154232419354595/'
                'FromLink': 'Linkstate.youiest.com'
                'ToLink': 'Bookmarks'
                'ScreenshotUrl': 'https://api.urlbox.io/v1/FLMG5BM3XeqMGa42/117475d1c2f4d6fac7710dcc2f841e06b46e06b3/png?url=Linkstate.youiest.com&thumb_width=320&quality=80'
                'ScreenshotUrlTo': 'https://api.urlbox.io/v1/FLMG5BM3XeqMGa42/f9ef8e3b40885a6acde8c71ffdac6aac3365525e/png?url=Bookmarks&thumb_width=320&quality=80'
              'author': 'S54FphiBzL3KueFF4'
              'createdAt': 1515745036583
              'title': 'Linkstate - Connecting is seeing'
            'Linkstate%2Eyouiest%2Ecom%2Fabout':
              'from': 'Linkstate%2Eyouiest%2Ecom'
              'to': 'Linkstate%2Eyouiest%2Ecom%2Fabout'
              'meta':
                'title': 'Linkstate - Connecting is seeing'
                'weight': 8
                'body': 'The fate of bookmarks can tell us a lot about Linkstate'
                'face': 'http://graph.facebook.com/v2.7/10154232419354595/picture?type=square'
                'profileLink': 'https://www.facebook.com/app_scoped_user_id/10154232419354595/'
                'FromLink': 'Linkstate.youiest.com'
                'ToLink': 'Linkstate.youiest.com/about'
                'ScreenshotUrl': 'https://api.urlbox.io/v1/FLMG5BM3XeqMGa42/117475d1c2f4d6fac7710dcc2f841e06b46e06b3/png?url=Linkstate.youiest.com&thumb_width=320&quality=80'
                'ScreenshotUrlTo': 'https://api.urlbox.io/v1/FLMG5BM3XeqMGa42/7c81ff8950b76e157e44b1a70cfb81532f9a170c/png?url=Linkstate.youiest.com%2Fabout&thumb_width=320&quality=80'
              'author': 'S54FphiBzL3KueFF4'
              'createdAt': 1515744706613
              'title': 'Linkstate - Connecting is seeing'
          'http%3A%2F%2Flocalhost%3A3000%2Fabout%3Ffrom%3DLinkstate%2Eyouiest%2Ecom%26lastTitle%3DIcon%252520Button%252520-%252520Material-UI%26to%3DBookmarks%26Bookmarked%3Dtrue%26content%3D%26switched%3D': 'Bookmarks':
            'from': 'http%3A%2F%2Flocalhost%3A3000%2Fabout%3Ffrom%3DLinkstate%2Eyouiest%2Ecom%26lastTitle%3DIcon%252520Button%252520-%252520Material-UI%26to%3DBookmarks%26Bookmarked%3Dtrue%26content%3D%26switched%3D'
            'to': 'Bookmarks'
            'meta':
              'weight': 5
              'title': 'Linkstates for Linkstate - Connecting is seeing - Linkstate.youiest.com'
              'face': 'http://graph.facebook.com/v2.7/10154232419354595/picture?type=square'
              'profileLink': 'https://www.facebook.com/app_scoped_user_id/10154232419354595/'
              'FromLink': 'http://localhost:3000/about?from=Linkstate.youiest.com&lastTitle=Icon%2520Button%2520-%2520Material-UI&to=Bookmarks&Bookmarked=true&content=&switched='
              'ToLink': 'Bookmarks'
              'ScreenshotUrl': 'https://api.urlbox.io/v1/FLMG5BM3XeqMGa42/2a97329fccd9bea5497d209c411e6a54bbd03f76/png?url=http%3A%2F%2Flocalhost%3A3000%2Fabout%3Ffrom%3DLinkstate.youiest.com%26lastTitle%3DIcon%252520Button%252520-%252520Material-UI%26to%3DBookmarks%26Bookmarked%3Dtrue%26content%3D%26switched%3D&thumb_width=320&quality=80'
              'ScreenshotUrlTo': 'https://api.urlbox.io/v1/FLMG5BM3XeqMGa42/f9ef8e3b40885a6acde8c71ffdac6aac3365525e/png?url=Bookmarks&thumb_width=320&quality=80'
            'author': 'S54FphiBzL3KueFF4'
            'createdAt': 1515650897280
            'title': 'Linkstates for Linkstate - Connecting is seeing - Linkstate.youiest.com'
          'https%3A%2F%2Fwww%2Efacebook%2Ecom%2FvViber%3Flst%3D532514594%253A532514594%253A1514878343': 'Bookmarks':
            'from': 'https%3A%2F%2Fwww%2Efacebook%2Ecom%2FvViber%3Flst%3D532514594%253A532514594%253A1514878343'
            'to': 'Bookmarks'
            'meta':
              'weight': 5
              'title': '(2) Elias Moosman'
              'face': 'http://graph.facebook.com/v2.7/10154232419354595/picture?type=square'
              'profileLink': 'https://www.facebook.com/app_scoped_user_id/10154232419354595/'
              'FromLink': 'https://www.facebook.com/vViber?lst=532514594%3A532514594%3A1514878343'
              'ToLink': 'Bookmarks'
              'ScreenshotUrl': 'https://api.urlbox.io/v1/FLMG5BM3XeqMGa42/7f5979875238b6c4bc73ccfc7f6ec691414e8c8a/png?url=https%3A%2F%2Fwww.facebook.com%2FvViber%3Flst%3D532514594%253A532514594%253A1514878343&thumb_width=320&quality=80'
              'ScreenshotUrlTo': 'https://api.urlbox.io/v1/FLMG5BM3XeqMGa42/f9ef8e3b40885a6acde8c71ffdac6aac3365525e/png?url=Bookmarks&thumb_width=320&quality=80'
            'author': 'S54FphiBzL3KueFF4'
            'createdAt': 1515728165362
            'title': '(2) Elias Moosman'
          'http%3A%2F%2Flocalhost%3A3000%2Fabout%3Ffrom%3DLinkstate%2Eyouiest%2Ecom%26lastTitle%3DIcon%252520Button%252520-%252520Material-UI%26to%3DLinkstate%2Eyouiest%2Ecom%26Bookmarked%3Dtrue%26content%3D%26switched%3D': 'Bookmarks':
            'from': 'http%3A%2F%2Flocalhost%3A3000%2Fabout%3Ffrom%3DLinkstate%2Eyouiest%2Ecom%26lastTitle%3DIcon%252520Button%252520-%252520Material-UI%26to%3DLinkstate%2Eyouiest%2Ecom%26Bookmarked%3Dtrue%26content%3D%26switched%3D'
            'to': 'Bookmarks'
            'meta':
              'weight': 5
              'title': 'Linkstates for Linkstate - Connecting is seeing - Linkstate.youiest.com'
              'face': 'http://graph.facebook.com/v2.7/10154232419354595/picture?type=square'
              'profileLink': 'https://www.facebook.com/app_scoped_user_id/10154232419354595/'
              'FromLink': 'http://localhost:3000/about?from=Linkstate.youiest.com&lastTitle=Icon%2520Button%2520-%2520Material-UI&to=Linkstate.youiest.com&Bookmarked=true&content=&switched='
              'ToLink': 'Bookmarks'
              'ScreenshotUrl': 'https://api.urlbox.io/v1/FLMG5BM3XeqMGa42/7e9eca309d75b57045a48ca0cda20fa74c9c66b0/png?url=http%3A%2F%2Flocalhost%3A3000%2Fabout%3Ffrom%3DLinkstate.youiest.com%26lastTitle%3DIcon%252520Button%252520-%252520Material-UI%26to%3DLinkstate.youiest.com%26Bookmarked%3Dtrue%26content%3D%26switched%3D&thumb_width=320&quality=80'
              'ScreenshotUrlTo': 'https://api.urlbox.io/v1/FLMG5BM3XeqMGa42/f9ef8e3b40885a6acde8c71ffdac6aac3365525e/png?url=Bookmarks&thumb_width=320&quality=80'
            'author': 'S54FphiBzL3KueFF4'
            'createdAt': 1515728156303
            'title': 'Linkstates for Linkstate - Connecting is seeing - Linkstate.youiest.com'
          'Linkstate%2Eyouiest%2Ecom%2Fabout':
            'Linkstate%2Eyouiest%2Ecom%2Fabout':
              'from': 'Linkstate%2Eyouiest%2Ecom%2Fabout'
              'to': 'Linkstate%2Eyouiest%2Ecom%2Fabout'
              'meta':
                'title': 'Linkstate - Connecting is seeing'
                'weight': 8
                'body': 'The fate of bookmarks can tell us a lot about Linkstate'
                'face': 'http://graph.facebook.com/v2.7/10154232419354595/picture?type=square'
                'profileLink': 'https://www.facebook.com/app_scoped_user_id/10154232419354595/'
                'FromLink': 'Linkstate.youiest.com/about'
                'ToLink': 'Linkstate.youiest.com/about'
                'ScreenshotUrl': 'https://api.urlbox.io/v1/FLMG5BM3XeqMGa42/7c81ff8950b76e157e44b1a70cfb81532f9a170c/png?url=Linkstate.youiest.com%2Fabout&thumb_width=320&quality=80'
                'ScreenshotUrlTo': 'https://api.urlbox.io/v1/FLMG5BM3XeqMGa42/7c81ff8950b76e157e44b1a70cfb81532f9a170c/png?url=Linkstate.youiest.com%2Fabout&thumb_width=320&quality=80'
              'author': 'S54FphiBzL3KueFF4'
              'createdAt': 1515894288582
              'title': 'Linkstate - Connecting is seeing'
            'Bookmarks':
              'from': 'Linkstate%2Eyouiest%2Ecom%2Fabout'
              'to': 'Bookmarks'
              'meta':
                'title': 'Linkstate - Connecting is seeing'
                'weight': 7
                'face': 'http://graph.facebook.com/v2.7/10154232419354595/picture?type=square'
                'profileLink': 'https://www.facebook.com/app_scoped_user_id/10154232419354595/'
                'FromLink': 'Linkstate.youiest.com/about'
                'ToLink': 'Bookmarks'
                'ScreenshotUrl': 'https://api.urlbox.io/v1/FLMG5BM3XeqMGa42/7c81ff8950b76e157e44b1a70cfb81532f9a170c/png?url=Linkstate.youiest.com%2Fabout&thumb_width=320&quality=80'
                'ScreenshotUrlTo': 'https://api.urlbox.io/v1/FLMG5BM3XeqMGa42/f9ef8e3b40885a6acde8c71ffdac6aac3365525e/png?url=Bookmarks&thumb_width=320&quality=80'
              'author': 'S54FphiBzL3KueFF4'
              'createdAt': 1515894288449
              'title': 'Linkstate - Connecting is seeing'
            'http%3A%2F%2Fwww%2Ematerial-ui%2Ecom%2Fv0%2E15%2E0%2F%23%2Fcomponents%2Ficon-button':
              'from': 'Linkstate%2Eyouiest%2Ecom%2Fabout'
              'to': 'http%3A%2F%2Fwww%2Ematerial-ui%2Ecom%2Fv0%2E15%2E0%2F%23%2Fcomponents%2Ficon-button'
              'meta':
                'body': 'hi'
                'weight': 1
                'title': 'Linkstate - Connecting is seeing'
                'face': 'http://graph.facebook.com/v2.7/10154232419354595/picture?type=square'
                'profileLink': 'https://www.facebook.com/app_scoped_user_id/10154232419354595/'
                'FromLink': 'Linkstate.youiest.com/about'
                'ToLink': 'http://www.material-ui.com/v0.15.0/#/components/icon-button'
                'ScreenshotUrl': 'https://api.urlbox.io/v1/FLMG5BM3XeqMGa42/7c81ff8950b76e157e44b1a70cfb81532f9a170c/png?url=Linkstate.youiest.com%2Fabout&thumb_width=320&quality=80'
                'ScreenshotUrlTo': 'https://api.urlbox.io/v1/FLMG5BM3XeqMGa42/bc419c1ffae6d735068eb38564b861249f53af0f/png?url=http%3A%2F%2Fwww.material-ui.com%2Fv0.15.0%2F%23%2Fcomponents%2Ficon-button&thumb_width=320&quality=80'
              'author': 'S54FphiBzL3KueFF4'
              'createdAt': 1515765825514
              'title': 'Linkstate - Connecting is seeing'
          'https%3A%2F%2Flinkstate%2Eyouiest%2Ecom%2Fabout%3Ffrom%3DBookmarks%26lastTitle%3DGrid%252520List%252520-%252520Material-UI%26Bookmarked%3Dtrue%26to%3Dhttps%25253A%25252F%25252Fmopinion%2Ecom%25252Ftop-10-website-annotation-tools%25252F%26content%3D%26switched%3D': 'Bookmarks':
            'from': 'https%3A%2F%2Flinkstate%2Eyouiest%2Ecom%2Fabout%3Ffrom%3DBookmarks%26lastTitle%3DGrid%252520List%252520-%252520Material-UI%26Bookmarked%3Dtrue%26to%3Dhttps%25253A%25252F%25252Fmopinion%2Ecom%25252Ftop-10-website-annotation-tools%25252F%26content%3D%26switched%3D'
            'to': 'Bookmarks'
            'meta':
              'weight': 5
              'title': 'Linkstates for Bookmarks - and other placeholders - Bookmarks'
              'face': 'http://graph.facebook.com/v2.7/10154232419354595/picture?type=square'
              'profileLink': 'https://www.facebook.com/app_scoped_user_id/10154232419354595/'
              'FromLink': 'https://linkstate.youiest.com/about?from=Bookmarks&lastTitle=Grid%2520List%2520-%2520Material-UI&Bookmarked=true&to=https%253A%252F%252Fmopinion.com%252Ftop-10-website-annotation-tools%252F&content=&switched='
              'ToLink': 'Bookmarks'
              'ScreenshotUrl': 'https://api.urlbox.io/v1/FLMG5BM3XeqMGa42/891c9105bb40fedaf3946178f7ee21f0cf25cb54/png?url=https%3A%2F%2Flinkstate.youiest.com%2Fabout%3Ffrom%3DBookmarks%26lastTitle%3DGrid%252520List%252520-%252520Material-UI%26Bookmarked%3Dtrue%26to%3Dhttps%25253A%25252F%25252Fmopinion.com%25252Ftop-10-website-annotation-tools%25252F%26content%3D%26switched%3D&thumb_width=320&quality=80'
              'ScreenshotUrlTo': 'https://api.urlbox.io/v1/FLMG5BM3XeqMGa42/f9ef8e3b40885a6acde8c71ffdac6aac3365525e/png?url=Bookmarks&thumb_width=320&quality=80'
            'author': 'S54FphiBzL3KueFF4'
            'createdAt': 1515750433476
            'title': 'Linkstates for Bookmarks - and other placeholders - Bookmarks'
          'https%3A%2F%2Fdevelopers%2Efacebook%2Ecom%2Fproducts%2Fsocial-plugins%2Fcomments%2F%3Futm_campaign%3Dsocial_plugins%26utm_medium%3Doffsite_pages%26utm_source%3Dcomments_plugin':
            'Bookmarks':
              'from': 'https%3A%2F%2Fdevelopers%2Efacebook%2Ecom%2Fproducts%2Fsocial-plugins%2Fcomments%2F%3Futm_campaign%3Dsocial_plugins%26utm_medium%3Doffsite_pages%26utm_source%3Dcomments_plugin'
              'to': 'Bookmarks'
              'meta':
                'weight': 5
                'title': 'Comments - Facebook for Developers'
                'face': 'http://graph.facebook.com/v2.7/10154232419354595/picture?type=square'
                'profileLink': 'https://www.facebook.com/app_scoped_user_id/10154232419354595/'
                'FromLink': 'https://developers.facebook.com/products/social-plugins/comments/?utm_campaign=social_plugins&utm_medium=offsite_pages&utm_source=comments_plugin'
                'ToLink': 'Bookmarks'
                'ScreenshotUrl': 'https://api.urlbox.io/v1/FLMG5BM3XeqMGa42/07d8c5a90f1c223ccd0f83a8637374368bb68178/png?url=https%3A%2F%2Fdevelopers.facebook.com%2Fproducts%2Fsocial-plugins%2Fcomments%2F%3Futm_campaign%3Dsocial_plugins%26utm_medium%3Doffsite_pages%26utm_source%3Dcomments_plugin&thumb_width=320&quality=80'
                'ScreenshotUrlTo': 'https://api.urlbox.io/v1/FLMG5BM3XeqMGa42/f9ef8e3b40885a6acde8c71ffdac6aac3365525e/png?url=Bookmarks&thumb_width=320&quality=80'
              'author': 'S54FphiBzL3KueFF4'
              'createdAt': 1515893775950
              'title': 'Comments - Facebook for Developers'
            'Linkstate%2Eyouiest%2Ecom%2Fabout':
              'from': 'https%3A%2F%2Fdevelopers%2Efacebook%2Ecom%2Fproducts%2Fsocial-plugins%2Fcomments%2F%3Futm_campaign%3Dsocial_plugins%26utm_medium%3Doffsite_pages%26utm_source%3Dcomments_plugin'
              'to': 'Linkstate%2Eyouiest%2Ecom%2Fabout'
              'meta':
                'body': 'hasd'
                'weight': 5
                'title': 'Comments - Facebook for Developers'
                'face': 'http://graph.facebook.com/v2.7/10154232419354595/picture?type=square'
                'profileLink': 'https://www.facebook.com/app_scoped_user_id/10154232419354595/'
                'FromLink': 'https://developers.facebook.com/products/social-plugins/comments/?utm_campaign=social_plugins&utm_medium=offsite_pages&utm_source=comments_plugin'
                'ToLink': 'Linkstate.youiest.com/about'
                'ScreenshotUrl': 'https://api.urlbox.io/v1/FLMG5BM3XeqMGa42/07d8c5a90f1c223ccd0f83a8637374368bb68178/png?url=https%3A%2F%2Fdevelopers.facebook.com%2Fproducts%2Fsocial-plugins%2Fcomments%2F%3Futm_campaign%3Dsocial_plugins%26utm_medium%3Doffsite_pages%26utm_source%3Dcomments_plugin&thumb_width=320&quality=80'
                'ScreenshotUrlTo': 'https://api.urlbox.io/v1/FLMG5BM3XeqMGa42/7c81ff8950b76e157e44b1a70cfb81532f9a170c/png?url=Linkstate.youiest.com%2Fabout&thumb_width=320&quality=80'
              'author': 'S54FphiBzL3KueFF4'
              'createdAt': 1515752725802
              'title': 'Comments - Facebook for Developers'
            'http%3A%2F%2Fwww%2Ematerial-ui%2Ecom%2Fv0%2E15%2E0%2F%23%2Fcomponents%2Ffloating-action-button':
              'from': 'https%3A%2F%2Fdevelopers%2Efacebook%2Ecom%2Fproducts%2Fsocial-plugins%2Fcomments%2F%3Futm_campaign%3Dsocial_plugins%26utm_medium%3Doffsite_pages%26utm_source%3Dcomments_plugin'
              'to': 'http%3A%2F%2Fwww%2Ematerial-ui%2Ecom%2Fv0%2E15%2E0%2F%23%2Fcomponents%2Ffloating-action-button'
              'meta':
                'body': 'floating was last '
                'weight': 7
                'title': 'Comments - Facebook for Developers'
                'face': 'http://graph.facebook.com/v2.7/10154232419354595/picture?type=square'
                'profileLink': 'https://www.facebook.com/app_scoped_user_id/10154232419354595/'
                'FromLink': 'https://developers.facebook.com/products/social-plugins/comments/?utm_campaign=social_plugins&utm_medium=offsite_pages&utm_source=comments_plugin'
                'ToLink': 'http://www.material-ui.com/v0.15.0/#/components/floating-action-button'
                'ScreenshotUrl': 'https://api.urlbox.io/v1/FLMG5BM3XeqMGa42/07d8c5a90f1c223ccd0f83a8637374368bb68178/png?url=https%3A%2F%2Fdevelopers.facebook.com%2Fproducts%2Fsocial-plugins%2Fcomments%2F%3Futm_campaign%3Dsocial_plugins%26utm_medium%3Doffsite_pages%26utm_source%3Dcomments_plugin&thumb_width=320&quality=80'
                'ScreenshotUrlTo': 'https://api.urlbox.io/v1/FLMG5BM3XeqMGa42/da1d05c7c97b6a4f5473451ee8905aa7484401dd/png?url=http%3A%2F%2Fwww.material-ui.com%2Fv0.15.0%2F%23%2Fcomponents%2Ffloating-action-button&thumb_width=320&quality=80'
              'author': 'S54FphiBzL3KueFF4'
              'createdAt': 1515853396214
              'title': 'Comments - Facebook for Developers'
          'http%3A%2F%2Fwww%2Ematerial-ui%2Ecom%2Fv0%2E15%2E0%2F%23%2Fcomponents%2Ficon-button':
            'Bookmarks':
              'from': 'http%3A%2F%2Fwww%2Ematerial-ui%2Ecom%2Fv0%2E15%2E0%2F%23%2Fcomponents%2Ficon-button'
              'to': 'Bookmarks'
              'meta':
                'weight': 5
                'title': 'Icon Button - Material-UI'
                'face': 'http://graph.facebook.com/v2.7/10154232419354595/picture?type=square'
                'profileLink': 'https://www.facebook.com/app_scoped_user_id/10154232419354595/'
                'FromLink': 'http://www.material-ui.com/v0.15.0/#/components/icon-button'
                'ToLink': 'Bookmarks'
                'ScreenshotUrl': 'https://api.urlbox.io/v1/FLMG5BM3XeqMGa42/bc419c1ffae6d735068eb38564b861249f53af0f/png?url=http%3A%2F%2Fwww.material-ui.com%2Fv0.15.0%2F%23%2Fcomponents%2Ficon-button&thumb_width=320&quality=80'
                'ScreenshotUrlTo': 'https://api.urlbox.io/v1/FLMG5BM3XeqMGa42/f9ef8e3b40885a6acde8c71ffdac6aac3365525e/png?url=Bookmarks&thumb_width=320&quality=80'
              'author': 'S54FphiBzL3KueFF4'
              'createdAt': 1515752736619
              'title': 'Icon Button - Material-UI'
            'Linkstate%2Eyouiest%2Ecom%2Fabout':
              'from': 'http%3A%2F%2Fwww%2Ematerial-ui%2Ecom%2Fv0%2E15%2E0%2F%23%2Fcomponents%2Ficon-button'
              'to': 'Linkstate%2Eyouiest%2Ecom%2Fabout'
              'meta':
                'body': ''
                'weight': 7
                'title': 'Icon Button - Material-UI'
                'face': 'http://graph.facebook.com/v2.7/10154232419354595/picture?type=square'
                'profileLink': 'https://www.facebook.com/app_scoped_user_id/10154232419354595/'
                'FromLink': 'http://www.material-ui.com/v0.15.0/#/components/icon-button'
                'ToLink': 'Linkstate.youiest.com/about'
                'ScreenshotUrl': 'https://api.urlbox.io/v1/FLMG5BM3XeqMGa42/bc419c1ffae6d735068eb38564b861249f53af0f/png?url=http%3A%2F%2Fwww.material-ui.com%2Fv0.15.0%2F%23%2Fcomponents%2Ficon-button&thumb_width=320&quality=80'
                'ScreenshotUrlTo': 'https://api.urlbox.io/v1/FLMG5BM3XeqMGa42/7c81ff8950b76e157e44b1a70cfb81532f9a170c/png?url=Linkstate.youiest.com%2Fabout&thumb_width=320&quality=80'
              'author': 'S54FphiBzL3KueFF4'
              'createdAt': 1515848417835
              'title': 'Icon Button - Material-UI'
          'https%3A%2F%2Fwww%2Enpmjs%2Ecom%2Fpackage%2Fcopy-to-clipboard':
            'Bookmarks':
              'from': 'https%3A%2F%2Fwww%2Enpmjs%2Ecom%2Fpackage%2Fcopy-to-clipboard'
              'to': 'Bookmarks'
              'meta':
                'weight': 5
                'title': 'copy-to-clipboard'
                'face': 'http://graph.facebook.com/v2.7/10154232419354595/picture?type=square'
                'profileLink': 'https://www.facebook.com/app_scoped_user_id/10154232419354595/'
                'FromLink': 'https://www.npmjs.com/package/copy-to-clipboard'
                'ToLink': 'Bookmarks'
                'ScreenshotUrl': 'https://api.urlbox.io/v1/FLMG5BM3XeqMGa42/8be9bf072d4ca4620ea074275282f8e0acc74174/png?url=https%3A%2F%2Fwww.npmjs.com%2Fpackage%2Fcopy-to-clipboard&thumb_width=320&quality=80'
                'ScreenshotUrlTo': 'https://api.urlbox.io/v1/FLMG5BM3XeqMGa42/f9ef8e3b40885a6acde8c71ffdac6aac3365525e/png?url=Bookmarks&thumb_width=320&quality=80'
              'author': 'S54FphiBzL3KueFF4'
              'createdAt': 1515848424123
              'title': 'copy-to-clipboard'
            'Linkstate%2Eyouiest%2Ecom%2Fabout':
              'from': 'https%3A%2F%2Fwww%2Enpmjs%2Ecom%2Fpackage%2Fcopy-to-clipboard'
              'to': 'Linkstate%2Eyouiest%2Ecom%2Fabout'
              'meta':
                'body': 'haha'
                'weight': 6
                'title': 'copy-to-clipboard'
                'face': 'http://graph.facebook.com/v2.7/10154232419354595/picture?type=square'
                'profileLink': 'https://www.facebook.com/app_scoped_user_id/10154232419354595/'
                'FromLink': 'https://www.npmjs.com/package/copy-to-clipboard'
                'ToLink': 'Linkstate.youiest.com/about'
                'ScreenshotUrl': 'https://api.urlbox.io/v1/FLMG5BM3XeqMGa42/8be9bf072d4ca4620ea074275282f8e0acc74174/png?url=https%3A%2F%2Fwww.npmjs.com%2Fpackage%2Fcopy-to-clipboard&thumb_width=320&quality=80'
                'ScreenshotUrlTo': 'https://api.urlbox.io/v1/FLMG5BM3XeqMGa42/7c81ff8950b76e157e44b1a70cfb81532f9a170c/png?url=Linkstate.youiest.com%2Fabout&thumb_width=320&quality=80'
              'author': 'S54FphiBzL3KueFF4'
              'createdAt': 1515852726942
              'title': 'copy-to-clipboard'
          'http%3A%2F%2Fwww%2Ematerial-ui%2Ecom%2Fv0%2E15%2E0%2F%23%2Fcomponents%2Ffloating-action-button':
            'Bookmarks':
              'from': 'http%3A%2F%2Fwww%2Ematerial-ui%2Ecom%2Fv0%2E15%2E0%2F%23%2Fcomponents%2Ffloating-action-button'
              'to': 'Bookmarks'
              'meta':
                'weight': 5
                'title': 'Floating Action Button - Material-UI'
                'face': 'http://graph.facebook.com/v2.7/10154232419354595/picture?type=square'
                'profileLink': 'https://www.facebook.com/app_scoped_user_id/10154232419354595/'
                'FromLink': 'http://www.material-ui.com/v0.15.0/#/components/floating-action-button'
                'ToLink': 'Bookmarks'
                'ScreenshotUrl': 'https://api.urlbox.io/v1/FLMG5BM3XeqMGa42/da1d05c7c97b6a4f5473451ee8905aa7484401dd/png?url=http%3A%2F%2Fwww.material-ui.com%2Fv0.15.0%2F%23%2Fcomponents%2Ffloating-action-button&thumb_width=320&quality=80'
                'ScreenshotUrlTo': 'https://api.urlbox.io/v1/FLMG5BM3XeqMGa42/f9ef8e3b40885a6acde8c71ffdac6aac3365525e/png?url=Bookmarks&thumb_width=320&quality=80'
              'author': 'S54FphiBzL3KueFF4'
              'createdAt': 1515849481404
              'title': 'Floating Action Button - Material-UI'
            'Linkstate%2Eyouiest%2Ecom%2Fabout':
              'from': 'http%3A%2F%2Fwww%2Ematerial-ui%2Ecom%2Fv0%2E15%2E0%2F%23%2Fcomponents%2Ffloating-action-button'
              'to': 'Linkstate%2Eyouiest%2Ecom%2Fabout'
              'meta':
                'body': 'haha'
                'weight': 7
                'title': 'Floating Action Button - Material-UI'
                'face': 'http://graph.facebook.com/v2.7/10154232419354595/picture?type=square'
                'profileLink': 'https://www.facebook.com/app_scoped_user_id/10154232419354595/'
                'FromLink': 'http://www.material-ui.com/v0.15.0/#/components/floating-action-button'
                'ToLink': 'Linkstate.youiest.com/about'
                'ScreenshotUrl': 'https://api.urlbox.io/v1/FLMG5BM3XeqMGa42/da1d05c7c97b6a4f5473451ee8905aa7484401dd/png?url=http%3A%2F%2Fwww.material-ui.com%2Fv0.15.0%2F%23%2Fcomponents%2Ffloating-action-button&thumb_width=320&quality=80'
                'ScreenshotUrlTo': 'https://api.urlbox.io/v1/FLMG5BM3XeqMGa42/7c81ff8950b76e157e44b1a70cfb81532f9a170c/png?url=Linkstate.youiest.com%2Fabout&thumb_width=320&quality=80'
              'author': 'S54FphiBzL3KueFF4'
              'createdAt': 1515852807096
              'title': 'Floating Action Button - Material-UI'
          'https%3A%2F%2Furlbox%2Eio%2Fdashboard': 'Bookmarks':
            'from': 'https%3A%2F%2Furlbox%2Eio%2Fdashboard'
            'to': 'Bookmarks'
            'meta':
              'weight': 5
              'title': 'User Dashboard | Urlbox'
              'face': 'http://graph.facebook.com/v2.7/10154232419354595/picture?type=square'
              'profileLink': 'https://www.facebook.com/app_scoped_user_id/10154232419354595/'
              'FromLink': 'https://urlbox.io/dashboard'
              'ToLink': 'Bookmarks'
              'ScreenshotUrl': 'https://api.urlbox.io/v1/FLMG5BM3XeqMGa42/470f97a39f9047b5aedc6918697e66578003b17c/png?url=https%3A%2F%2Furlbox.io%2Fdashboard&thumb_width=320&quality=80'
              'ScreenshotUrlTo': 'https://api.urlbox.io/v1/FLMG5BM3XeqMGa42/f9ef8e3b40885a6acde8c71ffdac6aac3365525e/png?url=Bookmarks&thumb_width=320&quality=80'
            'author': 'S54FphiBzL3KueFF4'
            'createdAt': 1515852668465
            'title': 'User Dashboard | Urlbox'
          'http%3A%2F%2Fwww%2Ematerial-ui%2Ecom%2Fv0%2E15%2E0%2F%23%2Fcomponents%2Fdivider': 'Bookmarks':
            'from': 'http%3A%2F%2Fwww%2Ematerial-ui%2Ecom%2Fv0%2E15%2E0%2F%23%2Fcomponents%2Fdivider'
            'to': 'Bookmarks'
            'meta':
              'weight': 5
              'title': 'Material-UI'
              'face': 'http://graph.facebook.com/v2.7/10154232419354595/picture?type=square'
              'profileLink': 'https://www.facebook.com/app_scoped_user_id/10154232419354595/'
              'FromLink': 'http://www.material-ui.com/v0.15.0/#/components/divider'
              'ToLink': 'Bookmarks'
              'ScreenshotUrl': 'https://api.urlbox.io/v1/FLMG5BM3XeqMGa42/e01735992a16b0765be9dfff99a1e69c62c39d76/png?url=http%3A%2F%2Fwww.material-ui.com%2Fv0.15.0%2F%23%2Fcomponents%2Fdivider&thumb_width=320&quality=80'
              'ScreenshotUrlTo': 'https://api.urlbox.io/v1/FLMG5BM3XeqMGa42/f9ef8e3b40885a6acde8c71ffdac6aac3365525e/png?url=Bookmarks&thumb_width=320&quality=80'
            'author': 'S54FphiBzL3KueFF4'
            'createdAt': 1515893133244
            'title': 'Material-UI'
          'http%3A%2F%2Fwww%2Ematerial-ui%2Ecom%2Fv0%2E15%2E0%2F%23%2Fcomponents%2Fdrawer': 'Bookmarks':
            'from': 'http%3A%2F%2Fwww%2Ematerial-ui%2Ecom%2Fv0%2E15%2E0%2F%23%2Fcomponents%2Fdrawer'
            'to': 'Bookmarks'
            'meta':
              'weight': 5
              'title': 'Drawer - Material-UI'
              'face': 'http://graph.facebook.com/v2.7/10154232419354595/picture?type=square'
              'profileLink': 'https://www.facebook.com/app_scoped_user_id/10154232419354595/'
              'FromLink': 'http://www.material-ui.com/v0.15.0/#/components/drawer'
              'ToLink': 'Bookmarks'
              'ScreenshotUrl': 'https://api.urlbox.io/v1/FLMG5BM3XeqMGa42/d99ca99ca087fe2a9d1b01035322b66bd9d3530d/png?url=http%3A%2F%2Fwww.material-ui.com%2Fv0.15.0%2F%23%2Fcomponents%2Fdrawer&thumb_width=320&quality=80'
              'ScreenshotUrlTo': 'https://api.urlbox.io/v1/FLMG5BM3XeqMGa42/f9ef8e3b40885a6acde8c71ffdac6aac3365525e/png?url=Bookmarks&thumb_width=320&quality=80'
            'author': 'S54FphiBzL3KueFF4'
            'createdAt': 1515896611045
            'title': 'Drawer - Material-UI'
      'hits': 822
      'fromLast': 'http://www.material-ui.com/v0.15.0/#/components/drawer'
      'toLast': 'Linkstate.youiest.com/about'
    'type': 'from'
    'word':
      'HeaderTitle': 'Linkstates for '
      'MainCardTitle': 'About '
      'MainCardSubtitle': 'Link it to something, find it there later'
      'TextAboutfloatingLabelText': 'TAB here to say something memorable. '
      'TextAboutHintText': 'Send with a 9 for dead on, 5 neutral, 1 oppose or 0 irrelevant.'
      'digitAlert': 'You send by entering a digit from 0 to 9 where 9 means dead on, 5 neutral and 1 opposite. The 0 means irrelevant.'
      'MyCardTitle': 'Your links to: '
      'MyCardSubtitle': 'Go to Bookmarks or your project page and your resources appear here'
      'MyCardStepsSubheader': 'You have connected from here recently'
      'AboutCardTitle': 'What\'s the word on this?'
      'AboutCardSubTitle': 'Connections talk. Yay sayers weigh in on the right.'
      'to': 'to '
      'defaultProject': 'Your last project was '
      'defaultStart': 'Last on '
      'ToTooltipText': 'TO - Point TO it to something about it.'
      'FromTooltipText': 'FROM - The place we\'re on now. Below are your bookmarks about this place.'
  'options': [
    {
      'label': 'Drawer - Material-UI'
      'value':
        'from': 'http%3A%2F%2Fwww%2Ematerial-ui%2Ecom%2Fv0%2E15%2E0%2F%23%2Fcomponents%2Fdrawer'
        'to': 'Bookmarks'
        'meta':
          'weight': 5
          'title': 'Drawer - Material-UI'
          'face': 'http://graph.facebook.com/v2.7/10154232419354595/picture?type=square'
          'profileLink': 'https://www.facebook.com/app_scoped_user_id/10154232419354595/'
          'FromLink': 'http://www.material-ui.com/v0.15.0/#/components/drawer'
          'ToLink': 'Bookmarks'
          'ScreenshotUrl': 'https://api.urlbox.io/v1/FLMG5BM3XeqMGa42/d99ca99ca087fe2a9d1b01035322b66bd9d3530d/png?url=http%3A%2F%2Fwww.material-ui.com%2Fv0.15.0%2F%23%2Fcomponents%2Fdrawer&thumb_width=320&quality=80'
          'ScreenshotUrlTo': 'https://api.urlbox.io/v1/FLMG5BM3XeqMGa42/f9ef8e3b40885a6acde8c71ffdac6aac3365525e/png?url=Bookmarks&thumb_width=320&quality=80'
        'author': 'S54FphiBzL3KueFF4'
        'createdAt': 1515896611045
        'title': 'Drawer - Material-UI'
    }
    {
      'label': 'Elias Moosman on Facebook'
      'value':
        'from': 'https%3A%2F%2Fwww%2Efacebook%2Ecom%2Fapp_scoped_user_id%2F10154232419354595%2F'
        'to': 'Bookmarks'
        'meta':
          'title': 'Elias Moosman on Facebook'
          'weight': 7
          'face': 'http://graph.facebook.com/v2.7/10154232419354595/picture?type=square'
          'profileLink': 'https://www.facebook.com/app_scoped_user_id/10154232419354595/'
          'FromLink': 'https://www.facebook.com/app_scoped_user_id/10154232419354595/'
          'ToLink': 'Bookmarks'
          'ScreenshotUrl': 'https://api.urlbox.io/v1/FLMG5BM3XeqMGa42/9b1a5f128cbac84d2142d3377200235906e5a39e/png?url=https%3A%2F%2Fwww.facebook.com%2Fapp_scoped_user_id%2F10154232419354595%2F&thumb_width=320&quality=80'
          'ScreenshotUrlTo': 'https://api.urlbox.io/v1/FLMG5BM3XeqMGa42/f9ef8e3b40885a6acde8c71ffdac6aac3365525e/png?url=Bookmarks&thumb_width=320&quality=80'
        'author': 'S54FphiBzL3KueFF4'
        'createdAt': 1515894288763
        'title': 'Elias Moosman on Facebook'
    }
    {
      'label': 'Linkstate - Connecting is seeing'
      'value':
        'from': 'Linkstate%2Eyouiest%2Ecom%2Fabout'
        'to': 'Bookmarks'
        'meta':
          'title': 'Linkstate - Connecting is seeing'
          'weight': 7
          'face': 'http://graph.facebook.com/v2.7/10154232419354595/picture?type=square'
          'profileLink': 'https://www.facebook.com/app_scoped_user_id/10154232419354595/'
          'FromLink': 'Linkstate.youiest.com/about'
          'ToLink': 'Bookmarks'
          'ScreenshotUrl': 'https://api.urlbox.io/v1/FLMG5BM3XeqMGa42/7c81ff8950b76e157e44b1a70cfb81532f9a170c/png?url=Linkstate.youiest.com%2Fabout&thumb_width=320&quality=80'
          'ScreenshotUrlTo': 'https://api.urlbox.io/v1/FLMG5BM3XeqMGa42/f9ef8e3b40885a6acde8c71ffdac6aac3365525e/png?url=Bookmarks&thumb_width=320&quality=80'
        'author': 'S54FphiBzL3KueFF4'
        'createdAt': 1515894288449
        'title': 'Linkstate - Connecting is seeing'
    }
    {
      'label': 'Bookmarks - and other placeholders'
      'value':
        'from': 'Bookmarks'
        'to': 'Bookmarks'
        'meta':
          'title': 'Bookmarks - and other placeholders'
          'weight': 9
          'ScreenshotUrl': 'https://api.urlbox.io/v1/FLMG5BM3XeqMGa42/f9ef8e3b40885a6acde8c71ffdac6aac3365525e/png?url=Bookmarks&thumb_width=320&quality=80'
          'face': 'http://graph.facebook.com/v2.7/10154232419354595/picture?type=square'
          'profileLink': 'https://www.facebook.com/app_scoped_user_id/10154232419354595/'
          'FromLink': 'Bookmarks'
          'ToLink': 'Bookmarks'
          'ScreenshotUrlTo': 'https://api.urlbox.io/v1/FLMG5BM3XeqMGa42/f9ef8e3b40885a6acde8c71ffdac6aac3365525e/png?url=Bookmarks&thumb_width=320&quality=80'
        'author': 'S54FphiBzL3KueFF4'
        'createdAt': 1515894288198
        'title': 'Bookmarks - and other placeholders'
    }
    {
      'label': 'Comments - Facebook for Developers'
      'value':
        'from': 'https%3A%2F%2Fdevelopers%2Efacebook%2Ecom%2Fproducts%2Fsocial-plugins%2Fcomments%2F%3Futm_campaign%3Dsocial_plugins%26utm_medium%3Doffsite_pages%26utm_source%3Dcomments_plugin'
        'to': 'Bookmarks'
        'meta':
          'weight': 5
          'title': 'Comments - Facebook for Developers'
          'face': 'http://graph.facebook.com/v2.7/10154232419354595/picture?type=square'
          'profileLink': 'https://www.facebook.com/app_scoped_user_id/10154232419354595/'
          'FromLink': 'https://developers.facebook.com/products/social-plugins/comments/?utm_campaign=social_plugins&utm_medium=offsite_pages&utm_source=comments_plugin'
          'ToLink': 'Bookmarks'
          'ScreenshotUrl': 'https://api.urlbox.io/v1/FLMG5BM3XeqMGa42/07d8c5a90f1c223ccd0f83a8637374368bb68178/png?url=https%3A%2F%2Fdevelopers.facebook.com%2Fproducts%2Fsocial-plugins%2Fcomments%2F%3Futm_campaign%3Dsocial_plugins%26utm_medium%3Doffsite_pages%26utm_source%3Dcomments_plugin&thumb_width=320&quality=80'
          'ScreenshotUrlTo': 'https://api.urlbox.io/v1/FLMG5BM3XeqMGa42/f9ef8e3b40885a6acde8c71ffdac6aac3365525e/png?url=Bookmarks&thumb_width=320&quality=80'
        'author': 'S54FphiBzL3KueFF4'
        'createdAt': 1515893775950
        'title': 'Comments - Facebook for Developers'
    }
    {
      'label': 'Material-UI'
      'value':
        'from': 'http%3A%2F%2Fwww%2Ematerial-ui%2Ecom%2Fv0%2E15%2E0%2F%23%2Fcomponents%2Fdivider'
        'to': 'Bookmarks'
        'meta':
          'weight': 5
          'title': 'Material-UI'
          'face': 'http://graph.facebook.com/v2.7/10154232419354595/picture?type=square'
          'profileLink': 'https://www.facebook.com/app_scoped_user_id/10154232419354595/'
          'FromLink': 'http://www.material-ui.com/v0.15.0/#/components/divider'
          'ToLink': 'Bookmarks'
          'ScreenshotUrl': 'https://api.urlbox.io/v1/FLMG5BM3XeqMGa42/e01735992a16b0765be9dfff99a1e69c62c39d76/png?url=http%3A%2F%2Fwww.material-ui.com%2Fv0.15.0%2F%23%2Fcomponents%2Fdivider&thumb_width=320&quality=80'
          'ScreenshotUrlTo': 'https://api.urlbox.io/v1/FLMG5BM3XeqMGa42/f9ef8e3b40885a6acde8c71ffdac6aac3365525e/png?url=Bookmarks&thumb_width=320&quality=80'
        'author': 'S54FphiBzL3KueFF4'
        'createdAt': 1515893133244
        'title': 'Material-UI'
    }
    {
      'label': 'User Dashboard | Urlbox'
      'value':
        'from': 'https%3A%2F%2Furlbox%2Eio%2Fdashboard'
        'to': 'Bookmarks'
        'meta':
          'weight': 5
          'title': 'User Dashboard | Urlbox'
          'face': 'http://graph.facebook.com/v2.7/10154232419354595/picture?type=square'
          'profileLink': 'https://www.facebook.com/app_scoped_user_id/10154232419354595/'
          'FromLink': 'https://urlbox.io/dashboard'
          'ToLink': 'Bookmarks'
          'ScreenshotUrl': 'https://api.urlbox.io/v1/FLMG5BM3XeqMGa42/470f97a39f9047b5aedc6918697e66578003b17c/png?url=https%3A%2F%2Furlbox.io%2Fdashboard&thumb_width=320&quality=80'
          'ScreenshotUrlTo': 'https://api.urlbox.io/v1/FLMG5BM3XeqMGa42/f9ef8e3b40885a6acde8c71ffdac6aac3365525e/png?url=Bookmarks&thumb_width=320&quality=80'
        'author': 'S54FphiBzL3KueFF4'
        'createdAt': 1515852668465
        'title': 'User Dashboard | Urlbox'
    }
    {
      'label': 'Floating Action Button - Material-UI'
      'value':
        'from': 'http%3A%2F%2Fwww%2Ematerial-ui%2Ecom%2Fv0%2E15%2E0%2F%23%2Fcomponents%2Ffloating-action-button'
        'to': 'Bookmarks'
        'meta':
          'weight': 5
          'title': 'Floating Action Button - Material-UI'
          'face': 'http://graph.facebook.com/v2.7/10154232419354595/picture?type=square'
          'profileLink': 'https://www.facebook.com/app_scoped_user_id/10154232419354595/'
          'FromLink': 'http://www.material-ui.com/v0.15.0/#/components/floating-action-button'
          'ToLink': 'Bookmarks'
          'ScreenshotUrl': 'https://api.urlbox.io/v1/FLMG5BM3XeqMGa42/da1d05c7c97b6a4f5473451ee8905aa7484401dd/png?url=http%3A%2F%2Fwww.material-ui.com%2Fv0.15.0%2F%23%2Fcomponents%2Ffloating-action-button&thumb_width=320&quality=80'
          'ScreenshotUrlTo': 'https://api.urlbox.io/v1/FLMG5BM3XeqMGa42/f9ef8e3b40885a6acde8c71ffdac6aac3365525e/png?url=Bookmarks&thumb_width=320&quality=80'
        'author': 'S54FphiBzL3KueFF4'
        'createdAt': 1515849481404
        'title': 'Floating Action Button - Material-UI'
    }
    {
      'label': 'copy-to-clipboard'
      'value':
        'from': 'https%3A%2F%2Fwww%2Enpmjs%2Ecom%2Fpackage%2Fcopy-to-clipboard'
        'to': 'Bookmarks'
        'meta':
          'weight': 5
          'title': 'copy-to-clipboard'
          'face': 'http://graph.facebook.com/v2.7/10154232419354595/picture?type=square'
          'profileLink': 'https://www.facebook.com/app_scoped_user_id/10154232419354595/'
          'FromLink': 'https://www.npmjs.com/package/copy-to-clipboard'
          'ToLink': 'Bookmarks'
          'ScreenshotUrl': 'https://api.urlbox.io/v1/FLMG5BM3XeqMGa42/8be9bf072d4ca4620ea074275282f8e0acc74174/png?url=https%3A%2F%2Fwww.npmjs.com%2Fpackage%2Fcopy-to-clipboard&thumb_width=320&quality=80'
          'ScreenshotUrlTo': 'https://api.urlbox.io/v1/FLMG5BM3XeqMGa42/f9ef8e3b40885a6acde8c71ffdac6aac3365525e/png?url=Bookmarks&thumb_width=320&quality=80'
        'author': 'S54FphiBzL3KueFF4'
        'createdAt': 1515848424123
        'title': 'copy-to-clipboard'
    }
    {
      'label': 'Icon Button - Material-UI'
      'value':
        'from': 'http%3A%2F%2Fwww%2Ematerial-ui%2Ecom%2Fv0%2E15%2E0%2F%23%2Fcomponents%2Ficon-button'
        'to': 'Bookmarks'
        'meta':
          'weight': 5
          'title': 'Icon Button - Material-UI'
          'face': 'http://graph.facebook.com/v2.7/10154232419354595/picture?type=square'
          'profileLink': 'https://www.facebook.com/app_scoped_user_id/10154232419354595/'
          'FromLink': 'http://www.material-ui.com/v0.15.0/#/components/icon-button'
          'ToLink': 'Bookmarks'
          'ScreenshotUrl': 'https://api.urlbox.io/v1/FLMG5BM3XeqMGa42/bc419c1ffae6d735068eb38564b861249f53af0f/png?url=http%3A%2F%2Fwww.material-ui.com%2Fv0.15.0%2F%23%2Fcomponents%2Ficon-button&thumb_width=320&quality=80'
          'ScreenshotUrlTo': 'https://api.urlbox.io/v1/FLMG5BM3XeqMGa42/f9ef8e3b40885a6acde8c71ffdac6aac3365525e/png?url=Bookmarks&thumb_width=320&quality=80'
        'author': 'S54FphiBzL3KueFF4'
        'createdAt': 1515752736619
        'title': 'Icon Button - Material-UI'
    }
    {
      'label': 'Linkstates for Bookmarks - and other placeholders - Bookmarks'
      'value':
        'from': 'https%3A%2F%2Flinkstate%2Eyouiest%2Ecom%2Fabout%3Ffrom%3DBookmarks%26lastTitle%3DGrid%252520List%252520-%252520Material-UI%26Bookmarked%3Dtrue%26to%3Dhttps%25253A%25252F%25252Fmopinion%2Ecom%25252Ftop-10-website-annotation-tools%25252F%26content%3D%26switched%3D'
        'to': 'Bookmarks'
        'meta':
          'weight': 5
          'title': 'Linkstates for Bookmarks - and other placeholders - Bookmarks'
          'face': 'http://graph.facebook.com/v2.7/10154232419354595/picture?type=square'
          'profileLink': 'https://www.facebook.com/app_scoped_user_id/10154232419354595/'
          'FromLink': 'https://linkstate.youiest.com/about?from=Bookmarks&lastTitle=Grid%2520List%2520-%2520Material-UI&Bookmarked=true&to=https%253A%252F%252Fmopinion.com%252Ftop-10-website-annotation-tools%252F&content=&switched='
          'ToLink': 'Bookmarks'
          'ScreenshotUrl': 'https://api.urlbox.io/v1/FLMG5BM3XeqMGa42/891c9105bb40fedaf3946178f7ee21f0cf25cb54/png?url=https%3A%2F%2Flinkstate.youiest.com%2Fabout%3Ffrom%3DBookmarks%26lastTitle%3DGrid%252520List%252520-%252520Material-UI%26Bookmarked%3Dtrue%26to%3Dhttps%25253A%25252F%25252Fmopinion.com%25252Ftop-10-website-annotation-tools%25252F%26content%3D%26switched%3D&thumb_width=320&quality=80'
          'ScreenshotUrlTo': 'https://api.urlbox.io/v1/FLMG5BM3XeqMGa42/f9ef8e3b40885a6acde8c71ffdac6aac3365525e/png?url=Bookmarks&thumb_width=320&quality=80'
        'author': 'S54FphiBzL3KueFF4'
        'createdAt': 1515750433476
        'title': 'Linkstates for Bookmarks - and other placeholders - Bookmarks'
    }
    {
      'label': 'Linkstate - Connecting is seeing'
      'value':
        'from': 'Linkstate%2Eyouiest%2Ecom'
        'to': 'Bookmarks'
        'meta':
          'title': 'Linkstate - Connecting is seeing'
          'weight': 7
          'face': 'http://graph.facebook.com/v2.7/10154232419354595/picture?type=square'
          'profileLink': 'https://www.facebook.com/app_scoped_user_id/10154232419354595/'
          'FromLink': 'Linkstate.youiest.com'
          'ToLink': 'Bookmarks'
          'ScreenshotUrl': 'https://api.urlbox.io/v1/FLMG5BM3XeqMGa42/117475d1c2f4d6fac7710dcc2f841e06b46e06b3/png?url=Linkstate.youiest.com&thumb_width=320&quality=80'
          'ScreenshotUrlTo': 'https://api.urlbox.io/v1/FLMG5BM3XeqMGa42/f9ef8e3b40885a6acde8c71ffdac6aac3365525e/png?url=Bookmarks&thumb_width=320&quality=80'
        'author': 'S54FphiBzL3KueFF4'
        'createdAt': 1515745036583
        'title': 'Linkstate - Connecting is seeing'
    }
    {
      'label': '(2) Elias Moosman'
      'value':
        'from': 'https%3A%2F%2Fwww%2Efacebook%2Ecom%2FvViber%3Flst%3D532514594%253A532514594%253A1514878343'
        'to': 'Bookmarks'
        'meta':
          'weight': 5
          'title': '(2) Elias Moosman'
          'face': 'http://graph.facebook.com/v2.7/10154232419354595/picture?type=square'
          'profileLink': 'https://www.facebook.com/app_scoped_user_id/10154232419354595/'
          'FromLink': 'https://www.facebook.com/vViber?lst=532514594%3A532514594%3A1514878343'
          'ToLink': 'Bookmarks'
          'ScreenshotUrl': 'https://api.urlbox.io/v1/FLMG5BM3XeqMGa42/7f5979875238b6c4bc73ccfc7f6ec691414e8c8a/png?url=https%3A%2F%2Fwww.facebook.com%2FvViber%3Flst%3D532514594%253A532514594%253A1514878343&thumb_width=320&quality=80'
          'ScreenshotUrlTo': 'https://api.urlbox.io/v1/FLMG5BM3XeqMGa42/f9ef8e3b40885a6acde8c71ffdac6aac3365525e/png?url=Bookmarks&thumb_width=320&quality=80'
        'author': 'S54FphiBzL3KueFF4'
        'createdAt': 1515728165362
        'title': '(2) Elias Moosman'
    }
    {
      'label': 'Linkstates for Linkstate - Connecting is seeing - Linkstate.youiest.com'
      'value':
        'from': 'http%3A%2F%2Flocalhost%3A3000%2Fabout%3Ffrom%3DLinkstate%2Eyouiest%2Ecom%26lastTitle%3DIcon%252520Button%252520-%252520Material-UI%26to%3DLinkstate%2Eyouiest%2Ecom%26Bookmarked%3Dtrue%26content%3D%26switched%3D'
        'to': 'Bookmarks'
        'meta':
          'weight': 5
          'title': 'Linkstates for Linkstate - Connecting is seeing - Linkstate.youiest.com'
          'face': 'http://graph.facebook.com/v2.7/10154232419354595/picture?type=square'
          'profileLink': 'https://www.facebook.com/app_scoped_user_id/10154232419354595/'
          'FromLink': 'http://localhost:3000/about?from=Linkstate.youiest.com&lastTitle=Icon%2520Button%2520-%2520Material-UI&to=Linkstate.youiest.com&Bookmarked=true&content=&switched='
          'ToLink': 'Bookmarks'
          'ScreenshotUrl': 'https://api.urlbox.io/v1/FLMG5BM3XeqMGa42/7e9eca309d75b57045a48ca0cda20fa74c9c66b0/png?url=http%3A%2F%2Flocalhost%3A3000%2Fabout%3Ffrom%3DLinkstate.youiest.com%26lastTitle%3DIcon%252520Button%252520-%252520Material-UI%26to%3DLinkstate.youiest.com%26Bookmarked%3Dtrue%26content%3D%26switched%3D&thumb_width=320&quality=80'
          'ScreenshotUrlTo': 'https://api.urlbox.io/v1/FLMG5BM3XeqMGa42/f9ef8e3b40885a6acde8c71ffdac6aac3365525e/png?url=Bookmarks&thumb_width=320&quality=80'
        'author': 'S54FphiBzL3KueFF4'
        'createdAt': 1515728156303
        'title': 'Linkstates for Linkstate - Connecting is seeing - Linkstate.youiest.com'
    }
    {
      'label': 'Linkstates for Linkstate - Connecting is seeing - Linkstate.youiest.com'
      'value':
        'from': 'http%3A%2F%2Flocalhost%3A3000%2Fabout%3Ffrom%3DLinkstate%2Eyouiest%2Ecom%26lastTitle%3DIcon%252520Button%252520-%252520Material-UI%26to%3DBookmarks%26Bookmarked%3Dtrue%26content%3D%26switched%3D'
        'to': 'Bookmarks'
        'meta':
          'weight': 5
          'title': 'Linkstates for Linkstate - Connecting is seeing - Linkstate.youiest.com'
          'face': 'http://graph.facebook.com/v2.7/10154232419354595/picture?type=square'
          'profileLink': 'https://www.facebook.com/app_scoped_user_id/10154232419354595/'
          'FromLink': 'http://localhost:3000/about?from=Linkstate.youiest.com&lastTitle=Icon%2520Button%2520-%2520Material-UI&to=Bookmarks&Bookmarked=true&content=&switched='
          'ToLink': 'Bookmarks'
          'ScreenshotUrl': 'https://api.urlbox.io/v1/FLMG5BM3XeqMGa42/2a97329fccd9bea5497d209c411e6a54bbd03f76/png?url=http%3A%2F%2Flocalhost%3A3000%2Fabout%3Ffrom%3DLinkstate.youiest.com%26lastTitle%3DIcon%252520Button%252520-%252520Material-UI%26to%3DBookmarks%26Bookmarked%3Dtrue%26content%3D%26switched%3D&thumb_width=320&quality=80'
          'ScreenshotUrlTo': 'https://api.urlbox.io/v1/FLMG5BM3XeqMGa42/f9ef8e3b40885a6acde8c71ffdac6aac3365525e/png?url=Bookmarks&thumb_width=320&quality=80'
        'author': 'S54FphiBzL3KueFF4'
        'createdAt': 1515650897280
        'title': 'Linkstates for Linkstate - Connecting is seeing - Linkstate.youiest.com'
    }
  ]
  'user':
    '_id': 'S54FphiBzL3KueFF4'
    'profile': 'name': 'Elias Moosman'
    'createdAt': '2018-01-11T05:57:30.482Z'
    'services':
      'facebook':
        'expiresAt': 1520753914953
        'id': '10154232419354595'
        'email': 'eliasmoosman@gmail.com'
        'name': 'Elias Moosman'
        'first_name': 'Elias'
        'last_name': 'Moosman'
        'link': 'https://www.facebook.com/app_scoped_user_id/10154232419354595/'
        'gender': 'male'
        'locale': 'sv_SE'
        'age_range': 'min': 21
      'thumbalizr': null
    'edited': 1515896611045
    'links':
      'in':
        'Bookmarks':
          'Bookmarks':
            'from': 'Bookmarks'
            'to': 'Bookmarks'
            'meta':
              'title': 'Bookmarks - and other placeholders'
              'weight': 9
              'ScreenshotUrl': 'https://api.urlbox.io/v1/FLMG5BM3XeqMGa42/f9ef8e3b40885a6acde8c71ffdac6aac3365525e/png?url=Bookmarks&thumb_width=320&quality=80'
              'face': 'http://graph.facebook.com/v2.7/10154232419354595/picture?type=square'
              'profileLink': 'https://www.facebook.com/app_scoped_user_id/10154232419354595/'
              'FromLink': 'Bookmarks'
              'ToLink': 'Bookmarks'
              'ScreenshotUrlTo': 'https://api.urlbox.io/v1/FLMG5BM3XeqMGa42/f9ef8e3b40885a6acde8c71ffdac6aac3365525e/png?url=Bookmarks&thumb_width=320&quality=80'
            'author': 'S54FphiBzL3KueFF4'
            'createdAt': 1515894288198
            'title': 'Bookmarks - and other placeholders'
          'https%3A%2F%2Fwww%2Efacebook%2Ecom%2Fapp_scoped_user_id%2F10154232419354595%2F':
            'from': 'https%3A%2F%2Fwww%2Efacebook%2Ecom%2Fapp_scoped_user_id%2F10154232419354595%2F'
            'to': 'Bookmarks'
            'meta':
              'title': 'Elias Moosman on Facebook'
              'weight': 7
              'face': 'http://graph.facebook.com/v2.7/10154232419354595/picture?type=square'
              'profileLink': 'https://www.facebook.com/app_scoped_user_id/10154232419354595/'
              'FromLink': 'https://www.facebook.com/app_scoped_user_id/10154232419354595/'
              'ToLink': 'Bookmarks'
              'ScreenshotUrl': 'https://api.urlbox.io/v1/FLMG5BM3XeqMGa42/9b1a5f128cbac84d2142d3377200235906e5a39e/png?url=https%3A%2F%2Fwww.facebook.com%2Fapp_scoped_user_id%2F10154232419354595%2F&thumb_width=320&quality=80'
              'ScreenshotUrlTo': 'https://api.urlbox.io/v1/FLMG5BM3XeqMGa42/f9ef8e3b40885a6acde8c71ffdac6aac3365525e/png?url=Bookmarks&thumb_width=320&quality=80'
            'author': 'S54FphiBzL3KueFF4'
            'createdAt': 1515894288763
            'title': 'Elias Moosman on Facebook'
          'Linkstate%2Eyouiest%2Ecom':
            'from': 'Linkstate%2Eyouiest%2Ecom'
            'to': 'Bookmarks'
            'meta':
              'title': 'Linkstate - Connecting is seeing'
              'weight': 7
              'face': 'http://graph.facebook.com/v2.7/10154232419354595/picture?type=square'
              'profileLink': 'https://www.facebook.com/app_scoped_user_id/10154232419354595/'
              'FromLink': 'Linkstate.youiest.com'
              'ToLink': 'Bookmarks'
              'ScreenshotUrl': 'https://api.urlbox.io/v1/FLMG5BM3XeqMGa42/117475d1c2f4d6fac7710dcc2f841e06b46e06b3/png?url=Linkstate.youiest.com&thumb_width=320&quality=80'
              'ScreenshotUrlTo': 'https://api.urlbox.io/v1/FLMG5BM3XeqMGa42/f9ef8e3b40885a6acde8c71ffdac6aac3365525e/png?url=Bookmarks&thumb_width=320&quality=80'
            'author': 'S54FphiBzL3KueFF4'
            'createdAt': 1515745036583
            'title': 'Linkstate - Connecting is seeing'
          'http%3A%2F%2Flocalhost%3A3000%2Fabout%3Ffrom%3DLinkstate%2Eyouiest%2Ecom%26lastTitle%3DIcon%252520Button%252520-%252520Material-UI%26to%3DBookmarks%26Bookmarked%3Dtrue%26content%3D%26switched%3D':
            'from': 'http%3A%2F%2Flocalhost%3A3000%2Fabout%3Ffrom%3DLinkstate%2Eyouiest%2Ecom%26lastTitle%3DIcon%252520Button%252520-%252520Material-UI%26to%3DBookmarks%26Bookmarked%3Dtrue%26content%3D%26switched%3D'
            'to': 'Bookmarks'
            'meta':
              'weight': 5
              'title': 'Linkstates for Linkstate - Connecting is seeing - Linkstate.youiest.com'
              'face': 'http://graph.facebook.com/v2.7/10154232419354595/picture?type=square'
              'profileLink': 'https://www.facebook.com/app_scoped_user_id/10154232419354595/'
              'FromLink': 'http://localhost:3000/about?from=Linkstate.youiest.com&lastTitle=Icon%2520Button%2520-%2520Material-UI&to=Bookmarks&Bookmarked=true&content=&switched='
              'ToLink': 'Bookmarks'
              'ScreenshotUrl': 'https://api.urlbox.io/v1/FLMG5BM3XeqMGa42/2a97329fccd9bea5497d209c411e6a54bbd03f76/png?url=http%3A%2F%2Flocalhost%3A3000%2Fabout%3Ffrom%3DLinkstate.youiest.com%26lastTitle%3DIcon%252520Button%252520-%252520Material-UI%26to%3DBookmarks%26Bookmarked%3Dtrue%26content%3D%26switched%3D&thumb_width=320&quality=80'
              'ScreenshotUrlTo': 'https://api.urlbox.io/v1/FLMG5BM3XeqMGa42/f9ef8e3b40885a6acde8c71ffdac6aac3365525e/png?url=Bookmarks&thumb_width=320&quality=80'
            'author': 'S54FphiBzL3KueFF4'
            'createdAt': 1515650897280
            'title': 'Linkstates for Linkstate - Connecting is seeing - Linkstate.youiest.com'
          'https%3A%2F%2Fwww%2Efacebook%2Ecom%2FvViber%3Flst%3D532514594%253A532514594%253A1514878343':
            'from': 'https%3A%2F%2Fwww%2Efacebook%2Ecom%2FvViber%3Flst%3D532514594%253A532514594%253A1514878343'
            'to': 'Bookmarks'
            'meta':
              'weight': 5
              'title': '(2) Elias Moosman'
              'face': 'http://graph.facebook.com/v2.7/10154232419354595/picture?type=square'
              'profileLink': 'https://www.facebook.com/app_scoped_user_id/10154232419354595/'
              'FromLink': 'https://www.facebook.com/vViber?lst=532514594%3A532514594%3A1514878343'
              'ToLink': 'Bookmarks'
              'ScreenshotUrl': 'https://api.urlbox.io/v1/FLMG5BM3XeqMGa42/7f5979875238b6c4bc73ccfc7f6ec691414e8c8a/png?url=https%3A%2F%2Fwww.facebook.com%2FvViber%3Flst%3D532514594%253A532514594%253A1514878343&thumb_width=320&quality=80'
              'ScreenshotUrlTo': 'https://api.urlbox.io/v1/FLMG5BM3XeqMGa42/f9ef8e3b40885a6acde8c71ffdac6aac3365525e/png?url=Bookmarks&thumb_width=320&quality=80'
            'author': 'S54FphiBzL3KueFF4'
            'createdAt': 1515728165362
            'title': '(2) Elias Moosman'
          'http%3A%2F%2Flocalhost%3A3000%2Fabout%3Ffrom%3DLinkstate%2Eyouiest%2Ecom%26lastTitle%3DIcon%252520Button%252520-%252520Material-UI%26to%3DLinkstate%2Eyouiest%2Ecom%26Bookmarked%3Dtrue%26content%3D%26switched%3D':
            'from': 'http%3A%2F%2Flocalhost%3A3000%2Fabout%3Ffrom%3DLinkstate%2Eyouiest%2Ecom%26lastTitle%3DIcon%252520Button%252520-%252520Material-UI%26to%3DLinkstate%2Eyouiest%2Ecom%26Bookmarked%3Dtrue%26content%3D%26switched%3D'
            'to': 'Bookmarks'
            'meta':
              'weight': 5
              'title': 'Linkstates for Linkstate - Connecting is seeing - Linkstate.youiest.com'
              'face': 'http://graph.facebook.com/v2.7/10154232419354595/picture?type=square'
              'profileLink': 'https://www.facebook.com/app_scoped_user_id/10154232419354595/'
              'FromLink': 'http://localhost:3000/about?from=Linkstate.youiest.com&lastTitle=Icon%2520Button%2520-%2520Material-UI&to=Linkstate.youiest.com&Bookmarked=true&content=&switched='
              'ToLink': 'Bookmarks'
              'ScreenshotUrl': 'https://api.urlbox.io/v1/FLMG5BM3XeqMGa42/7e9eca309d75b57045a48ca0cda20fa74c9c66b0/png?url=http%3A%2F%2Flocalhost%3A3000%2Fabout%3Ffrom%3DLinkstate.youiest.com%26lastTitle%3DIcon%252520Button%252520-%252520Material-UI%26to%3DLinkstate.youiest.com%26Bookmarked%3Dtrue%26content%3D%26switched%3D&thumb_width=320&quality=80'
              'ScreenshotUrlTo': 'https://api.urlbox.io/v1/FLMG5BM3XeqMGa42/f9ef8e3b40885a6acde8c71ffdac6aac3365525e/png?url=Bookmarks&thumb_width=320&quality=80'
            'author': 'S54FphiBzL3KueFF4'
            'createdAt': 1515728156303
            'title': 'Linkstates for Linkstate - Connecting is seeing - Linkstate.youiest.com'
          'Linkstate%2Eyouiest%2Ecom%2Fabout':
            'from': 'Linkstate%2Eyouiest%2Ecom%2Fabout'
            'to': 'Bookmarks'
            'meta':
              'title': 'Linkstate - Connecting is seeing'
              'weight': 7
              'face': 'http://graph.facebook.com/v2.7/10154232419354595/picture?type=square'
              'profileLink': 'https://www.facebook.com/app_scoped_user_id/10154232419354595/'
              'FromLink': 'Linkstate.youiest.com/about'
              'ToLink': 'Bookmarks'
              'ScreenshotUrl': 'https://api.urlbox.io/v1/FLMG5BM3XeqMGa42/7c81ff8950b76e157e44b1a70cfb81532f9a170c/png?url=Linkstate.youiest.com%2Fabout&thumb_width=320&quality=80'
              'ScreenshotUrlTo': 'https://api.urlbox.io/v1/FLMG5BM3XeqMGa42/f9ef8e3b40885a6acde8c71ffdac6aac3365525e/png?url=Bookmarks&thumb_width=320&quality=80'
            'author': 'S54FphiBzL3KueFF4'
            'createdAt': 1515894288449
            'title': 'Linkstate - Connecting is seeing'
          'https%3A%2F%2Flinkstate%2Eyouiest%2Ecom%2Fabout%3Ffrom%3DBookmarks%26lastTitle%3DGrid%252520List%252520-%252520Material-UI%26Bookmarked%3Dtrue%26to%3Dhttps%25253A%25252F%25252Fmopinion%2Ecom%25252Ftop-10-website-annotation-tools%25252F%26content%3D%26switched%3D':
            'from': 'https%3A%2F%2Flinkstate%2Eyouiest%2Ecom%2Fabout%3Ffrom%3DBookmarks%26lastTitle%3DGrid%252520List%252520-%252520Material-UI%26Bookmarked%3Dtrue%26to%3Dhttps%25253A%25252F%25252Fmopinion%2Ecom%25252Ftop-10-website-annotation-tools%25252F%26content%3D%26switched%3D'
            'to': 'Bookmarks'
            'meta':
              'weight': 5
              'title': 'Linkstates for Bookmarks - and other placeholders - Bookmarks'
              'face': 'http://graph.facebook.com/v2.7/10154232419354595/picture?type=square'
              'profileLink': 'https://www.facebook.com/app_scoped_user_id/10154232419354595/'
              'FromLink': 'https://linkstate.youiest.com/about?from=Bookmarks&lastTitle=Grid%2520List%2520-%2520Material-UI&Bookmarked=true&to=https%253A%252F%252Fmopinion.com%252Ftop-10-website-annotation-tools%252F&content=&switched='
              'ToLink': 'Bookmarks'
              'ScreenshotUrl': 'https://api.urlbox.io/v1/FLMG5BM3XeqMGa42/891c9105bb40fedaf3946178f7ee21f0cf25cb54/png?url=https%3A%2F%2Flinkstate.youiest.com%2Fabout%3Ffrom%3DBookmarks%26lastTitle%3DGrid%252520List%252520-%252520Material-UI%26Bookmarked%3Dtrue%26to%3Dhttps%25253A%25252F%25252Fmopinion.com%25252Ftop-10-website-annotation-tools%25252F%26content%3D%26switched%3D&thumb_width=320&quality=80'
              'ScreenshotUrlTo': 'https://api.urlbox.io/v1/FLMG5BM3XeqMGa42/f9ef8e3b40885a6acde8c71ffdac6aac3365525e/png?url=Bookmarks&thumb_width=320&quality=80'
            'author': 'S54FphiBzL3KueFF4'
            'createdAt': 1515750433476
            'title': 'Linkstates for Bookmarks - and other placeholders - Bookmarks'
          'https%3A%2F%2Fdevelopers%2Efacebook%2Ecom%2Fproducts%2Fsocial-plugins%2Fcomments%2F%3Futm_campaign%3Dsocial_plugins%26utm_medium%3Doffsite_pages%26utm_source%3Dcomments_plugin':
            'from': 'https%3A%2F%2Fdevelopers%2Efacebook%2Ecom%2Fproducts%2Fsocial-plugins%2Fcomments%2F%3Futm_campaign%3Dsocial_plugins%26utm_medium%3Doffsite_pages%26utm_source%3Dcomments_plugin'
            'to': 'Bookmarks'
            'meta':
              'weight': 5
              'title': 'Comments - Facebook for Developers'
              'face': 'http://graph.facebook.com/v2.7/10154232419354595/picture?type=square'
              'profileLink': 'https://www.facebook.com/app_scoped_user_id/10154232419354595/'
              'FromLink': 'https://developers.facebook.com/products/social-plugins/comments/?utm_campaign=social_plugins&utm_medium=offsite_pages&utm_source=comments_plugin'
              'ToLink': 'Bookmarks'
              'ScreenshotUrl': 'https://api.urlbox.io/v1/FLMG5BM3XeqMGa42/07d8c5a90f1c223ccd0f83a8637374368bb68178/png?url=https%3A%2F%2Fdevelopers.facebook.com%2Fproducts%2Fsocial-plugins%2Fcomments%2F%3Futm_campaign%3Dsocial_plugins%26utm_medium%3Doffsite_pages%26utm_source%3Dcomments_plugin&thumb_width=320&quality=80'
              'ScreenshotUrlTo': 'https://api.urlbox.io/v1/FLMG5BM3XeqMGa42/f9ef8e3b40885a6acde8c71ffdac6aac3365525e/png?url=Bookmarks&thumb_width=320&quality=80'
            'author': 'S54FphiBzL3KueFF4'
            'createdAt': 1515893775950
            'title': 'Comments - Facebook for Developers'
          'http%3A%2F%2Fwww%2Ematerial-ui%2Ecom%2Fv0%2E15%2E0%2F%23%2Fcomponents%2Ficon-button':
            'from': 'http%3A%2F%2Fwww%2Ematerial-ui%2Ecom%2Fv0%2E15%2E0%2F%23%2Fcomponents%2Ficon-button'
            'to': 'Bookmarks'
            'meta':
              'weight': 5
              'title': 'Icon Button - Material-UI'
              'face': 'http://graph.facebook.com/v2.7/10154232419354595/picture?type=square'
              'profileLink': 'https://www.facebook.com/app_scoped_user_id/10154232419354595/'
              'FromLink': 'http://www.material-ui.com/v0.15.0/#/components/icon-button'
              'ToLink': 'Bookmarks'
              'ScreenshotUrl': 'https://api.urlbox.io/v1/FLMG5BM3XeqMGa42/bc419c1ffae6d735068eb38564b861249f53af0f/png?url=http%3A%2F%2Fwww.material-ui.com%2Fv0.15.0%2F%23%2Fcomponents%2Ficon-button&thumb_width=320&quality=80'
              'ScreenshotUrlTo': 'https://api.urlbox.io/v1/FLMG5BM3XeqMGa42/f9ef8e3b40885a6acde8c71ffdac6aac3365525e/png?url=Bookmarks&thumb_width=320&quality=80'
            'author': 'S54FphiBzL3KueFF4'
            'createdAt': 1515752736619
            'title': 'Icon Button - Material-UI'
          'https%3A%2F%2Fwww%2Enpmjs%2Ecom%2Fpackage%2Fcopy-to-clipboard':
            'from': 'https%3A%2F%2Fwww%2Enpmjs%2Ecom%2Fpackage%2Fcopy-to-clipboard'
            'to': 'Bookmarks'
            'meta':
              'weight': 5
              'title': 'copy-to-clipboard'
              'face': 'http://graph.facebook.com/v2.7/10154232419354595/picture?type=square'
              'profileLink': 'https://www.facebook.com/app_scoped_user_id/10154232419354595/'
              'FromLink': 'https://www.npmjs.com/package/copy-to-clipboard'
              'ToLink': 'Bookmarks'
              'ScreenshotUrl': 'https://api.urlbox.io/v1/FLMG5BM3XeqMGa42/8be9bf072d4ca4620ea074275282f8e0acc74174/png?url=https%3A%2F%2Fwww.npmjs.com%2Fpackage%2Fcopy-to-clipboard&thumb_width=320&quality=80'
              'ScreenshotUrlTo': 'https://api.urlbox.io/v1/FLMG5BM3XeqMGa42/f9ef8e3b40885a6acde8c71ffdac6aac3365525e/png?url=Bookmarks&thumb_width=320&quality=80'
            'author': 'S54FphiBzL3KueFF4'
            'createdAt': 1515848424123
            'title': 'copy-to-clipboard'
          'http%3A%2F%2Fwww%2Ematerial-ui%2Ecom%2Fv0%2E15%2E0%2F%23%2Fcomponents%2Ffloating-action-button':
            'from': 'http%3A%2F%2Fwww%2Ematerial-ui%2Ecom%2Fv0%2E15%2E0%2F%23%2Fcomponents%2Ffloating-action-button'
            'to': 'Bookmarks'
            'meta':
              'weight': 5
              'title': 'Floating Action Button - Material-UI'
              'face': 'http://graph.facebook.com/v2.7/10154232419354595/picture?type=square'
              'profileLink': 'https://www.facebook.com/app_scoped_user_id/10154232419354595/'
              'FromLink': 'http://www.material-ui.com/v0.15.0/#/components/floating-action-button'
              'ToLink': 'Bookmarks'
              'ScreenshotUrl': 'https://api.urlbox.io/v1/FLMG5BM3XeqMGa42/da1d05c7c97b6a4f5473451ee8905aa7484401dd/png?url=http%3A%2F%2Fwww.material-ui.com%2Fv0.15.0%2F%23%2Fcomponents%2Ffloating-action-button&thumb_width=320&quality=80'
              'ScreenshotUrlTo': 'https://api.urlbox.io/v1/FLMG5BM3XeqMGa42/f9ef8e3b40885a6acde8c71ffdac6aac3365525e/png?url=Bookmarks&thumb_width=320&quality=80'
            'author': 'S54FphiBzL3KueFF4'
            'createdAt': 1515849481404
            'title': 'Floating Action Button - Material-UI'
          'https%3A%2F%2Furlbox%2Eio%2Fdashboard':
            'from': 'https%3A%2F%2Furlbox%2Eio%2Fdashboard'
            'to': 'Bookmarks'
            'meta':
              'weight': 5
              'title': 'User Dashboard | Urlbox'
              'face': 'http://graph.facebook.com/v2.7/10154232419354595/picture?type=square'
              'profileLink': 'https://www.facebook.com/app_scoped_user_id/10154232419354595/'
              'FromLink': 'https://urlbox.io/dashboard'
              'ToLink': 'Bookmarks'
              'ScreenshotUrl': 'https://api.urlbox.io/v1/FLMG5BM3XeqMGa42/470f97a39f9047b5aedc6918697e66578003b17c/png?url=https%3A%2F%2Furlbox.io%2Fdashboard&thumb_width=320&quality=80'
              'ScreenshotUrlTo': 'https://api.urlbox.io/v1/FLMG5BM3XeqMGa42/f9ef8e3b40885a6acde8c71ffdac6aac3365525e/png?url=Bookmarks&thumb_width=320&quality=80'
            'author': 'S54FphiBzL3KueFF4'
            'createdAt': 1515852668465
            'title': 'User Dashboard | Urlbox'
          'http%3A%2F%2Fwww%2Ematerial-ui%2Ecom%2Fv0%2E15%2E0%2F%23%2Fcomponents%2Fdivider':
            'from': 'http%3A%2F%2Fwww%2Ematerial-ui%2Ecom%2Fv0%2E15%2E0%2F%23%2Fcomponents%2Fdivider'
            'to': 'Bookmarks'
            'meta':
              'weight': 5
              'title': 'Material-UI'
              'face': 'http://graph.facebook.com/v2.7/10154232419354595/picture?type=square'
              'profileLink': 'https://www.facebook.com/app_scoped_user_id/10154232419354595/'
              'FromLink': 'http://www.material-ui.com/v0.15.0/#/components/divider'
              'ToLink': 'Bookmarks'
              'ScreenshotUrl': 'https://api.urlbox.io/v1/FLMG5BM3XeqMGa42/e01735992a16b0765be9dfff99a1e69c62c39d76/png?url=http%3A%2F%2Fwww.material-ui.com%2Fv0.15.0%2F%23%2Fcomponents%2Fdivider&thumb_width=320&quality=80'
              'ScreenshotUrlTo': 'https://api.urlbox.io/v1/FLMG5BM3XeqMGa42/f9ef8e3b40885a6acde8c71ffdac6aac3365525e/png?url=Bookmarks&thumb_width=320&quality=80'
            'author': 'S54FphiBzL3KueFF4'
            'createdAt': 1515893133244
            'title': 'Material-UI'
          'http%3A%2F%2Fwww%2Ematerial-ui%2Ecom%2Fv0%2E15%2E0%2F%23%2Fcomponents%2Fdrawer':
            'from': 'http%3A%2F%2Fwww%2Ematerial-ui%2Ecom%2Fv0%2E15%2E0%2F%23%2Fcomponents%2Fdrawer'
            'to': 'Bookmarks'
            'meta':
              'weight': 5
              'title': 'Drawer - Material-UI'
              'face': 'http://graph.facebook.com/v2.7/10154232419354595/picture?type=square'
              'profileLink': 'https://www.facebook.com/app_scoped_user_id/10154232419354595/'
              'FromLink': 'http://www.material-ui.com/v0.15.0/#/components/drawer'
              'ToLink': 'Bookmarks'
              'ScreenshotUrl': 'https://api.urlbox.io/v1/FLMG5BM3XeqMGa42/d99ca99ca087fe2a9d1b01035322b66bd9d3530d/png?url=http%3A%2F%2Fwww.material-ui.com%2Fv0.15.0%2F%23%2Fcomponents%2Fdrawer&thumb_width=320&quality=80'
              'ScreenshotUrlTo': 'https://api.urlbox.io/v1/FLMG5BM3XeqMGa42/f9ef8e3b40885a6acde8c71ffdac6aac3365525e/png?url=Bookmarks&thumb_width=320&quality=80'
            'author': 'S54FphiBzL3KueFF4'
            'createdAt': 1515896611045
            'title': 'Drawer - Material-UI'
        'Linkstate%2Eyouiest%2Ecom': 'Bookmarks':
          'from': 'Bookmarks'
          'to': 'Linkstate%2Eyouiest%2Ecom'
          'meta':
            'body': 'hjkkwer'
            'weight': 4
            'title': 'Bookmarks - and other placeholders'
            'face': 'http://graph.facebook.com/v2.7/10154232419354595/picture?type=square'
            'profileLink': 'https://www.facebook.com/app_scoped_user_id/10154232419354595/'
            'FromLink': 'Bookmarks'
            'ToLink': 'Linkstate.youiest.com'
            'ScreenshotUrl': 'https://api.urlbox.io/v1/FLMG5BM3XeqMGa42/f9ef8e3b40885a6acde8c71ffdac6aac3365525e/png?url=Bookmarks&thumb_width=320&quality=80'
            'ScreenshotUrlTo': 'https://api.urlbox.io/v1/FLMG5BM3XeqMGa42/117475d1c2f4d6fac7710dcc2f841e06b46e06b3/png?url=Linkstate.youiest.com&thumb_width=320&quality=80'
          'author': 'S54FphiBzL3KueFF4'
          'createdAt': 1515675012528
          'title': 'Bookmarks - and other placeholders'
        'https%3A%2F%2Fwww%2Efacebook%2Ecom%2Fapp_scoped_user_id%2F10154232419354595%2F':
          'Bookmarks':
            'from': 'https%3A%2F%2Fwww%2Efacebook%2Ecom%2Fapp_scoped_user_id%2F10154232419354595%2F'
            'to': 'Bookmarks'
            'meta':
              'title': 'Elias Moosman on Facebook'
              'weight': 7
              'face': 'http://graph.facebook.com/v2.7/10154232419354595/picture?type=square'
              'profileLink': 'https://www.facebook.com/app_scoped_user_id/10154232419354595/'
              'FromLink': 'https://www.facebook.com/app_scoped_user_id/10154232419354595/'
              'ToLink': 'Bookmarks'
              'ScreenshotUrl': 'https://api.thumbalizr.com/?url=https://www.facebook.com/app_scoped_user_id/10154232419354595/&width=250&api_key=UQ6CMod6tIkVLam271a7WdUlutEJJHTE'
              'ScreenshotUrlTo': 'https://api.thumbalizr.com/?url=Bookmarks&width=250&api_key=UQ6CMod6tIkVLam271a7WdUlutEJJHTE'
            'author': 'S54FphiBzL3KueFF4'
            'createdAt': 1515650468975
            'title': 'Elias Moosman on Facebook'
          'https%3A%2F%2Fwww%2Efacebook%2Ecom%2Fapp_scoped_user_id%2F10154232419354595%2F':
            'from': 'https%3A%2F%2Fwww%2Efacebook%2Ecom%2Fapp_scoped_user_id%2F10154232419354595%2F'
            'to': 'https%3A%2F%2Fwww%2Efacebook%2Ecom%2Fapp_scoped_user_id%2F10154232419354595%2F'
            'meta':
              'body': ''
              'weight': 6
              'title': 'Elias Moosman on Facebook'
              'face': 'http://graph.facebook.com/v2.7/10154232419354595/picture?type=square'
              'profileLink': 'https://www.facebook.com/app_scoped_user_id/10154232419354595/'
              'FromLink': 'https://www.facebook.com/app_scoped_user_id/10154232419354595/'
              'ToLink': 'https://www.facebook.com/app_scoped_user_id/10154232419354595/'
              'ScreenshotUrl': 'https://api.urlbox.io/v1/FLMG5BM3XeqMGa42/9b1a5f128cbac84d2142d3377200235906e5a39e/png?url=https%3A%2F%2Fwww.facebook.com%2Fapp_scoped_user_id%2F10154232419354595%2F&thumb_width=320&quality=80'
              'ScreenshotUrlTo': 'https://api.urlbox.io/v1/FLMG5BM3XeqMGa42/9b1a5f128cbac84d2142d3377200235906e5a39e/png?url=https%3A%2F%2Fwww.facebook.com%2Fapp_scoped_user_id%2F10154232419354595%2F&thumb_width=320&quality=80'
            'author': 'S54FphiBzL3KueFF4'
            'createdAt': 1515848689254
            'title': 'Elias Moosman on Facebook'
        'http%3A%2F%2Flocalhost%3A3000%2Fabout%3Ffrom%3Dhttps%25253A%25252F%25252Fwww%2Efacebook%2Ecom%25252Fapp_scoped_user_id%25252F10154232419354595%25252F%26lastTitle%3DIcon%252520Button%252520-%252520Material-UI%26to%3DBookmarks%26Bookmarked%3Dtrue%26content%3Dhahah%26switched%3D': 'Bookmarks':
          'from': 'http%3A%2F%2Flocalhost%3A3000%2Fabout%3Ffrom%3Dhttps%25253A%25252F%25252Fwww%2Efacebook%2Ecom%25252Fapp_scoped_user_id%25252F10154232419354595%25252F%26lastTitle%3DIcon%252520Button%252520-%252520Material-UI%26to%3DBookmarks%26Bookmarked%3Dtrue%26content%3Dhahah%26switched%3D'
          'to': 'Bookmarks'
          'meta':
            'weight': 5
            'title': 'Linkstates for Elias Moosman on Facebook - https://www.facebook.com/app_scoped_user_id/10154232419354595/'
            'face': 'http://graph.facebook.com/v2.7/10154232419354595/picture?type=square'
            'profileLink': 'https://www.facebook.com/app_scoped_user_id/10154232419354595/'
            'FromLink': 'http://localhost:3000/about?from=https%253A%252F%252Fwww.facebook.com%252Fapp_scoped_user_id%252F10154232419354595%252F&lastTitle=Icon%2520Button%2520-%2520Material-UI&to=Bookmarks&Bookmarked=true&content=hahah&switched='
            'ToLink': 'Bookmarks'
            'ScreenshotUrl': 'https://api.thumbalizr.com/?url=http://localhost:3000/about?from=https%253A%252F%252Fwww.facebook.com%252Fapp_scoped_user_id%252F10154232419354595%252F&lastTitle=Icon%2520Button%2520-%2520Material-UI&to=Bookmarks&Bookmarked=true&content=hahah&switched=&width=250&api_key=UQ6CMod6tIkVLam271a7WdUlutEJJHTE'
            'ScreenshotUrlTo': 'https://api.thumbalizr.com/?url=Bookmarks&width=250&api_key=UQ6CMod6tIkVLam271a7WdUlutEJJHTE'
          'author': 'S54FphiBzL3KueFF4'
          'createdAt': 1515650383851
          'title': 'Linkstates for Elias Moosman on Facebook - https://www.facebook.com/app_scoped_user_id/10154232419354595/'
        'https%3A%2F%2Fstackoverflow%2Ecom%2Fquestions%2F9529078%2Fhow-do-i-use-git-reset-hard-head-to-revert-to-a-previous-commit': 'Bookmarks':
          'from': 'https%3A%2F%2Fstackoverflow%2Ecom%2Fquestions%2F9529078%2Fhow-do-i-use-git-reset-hard-head-to-revert-to-a-previous-commit'
          'to': 'Bookmarks'
          'meta':
            'weight': 5
            'title': 'How do I use \'git reset --hard HEAD\' to revert to a previous commit? - Stack Overflow'
            'face': 'http://graph.facebook.com/v2.7/10154232419354595/picture?type=square'
            'profileLink': 'https://www.facebook.com/app_scoped_user_id/10154232419354595/'
            'FromLink': 'https://stackoverflow.com/questions/9529078/how-do-i-use-git-reset-hard-head-to-revert-to-a-previous-commit'
            'ToLink': 'Bookmarks'
            'ScreenshotUrl': 'https://api.thumbalizr.com/?url=https://stackoverflow.com/questions/9529078/how-do-i-use-git-reset-hard-head-to-revert-to-a-previous-commit&width=250&api_key=UQ6CMod6tIkVLam271a7WdUlutEJJHTE'
            'ScreenshotUrlTo': 'https://api.thumbalizr.com/?url=Bookmarks&width=250&api_key=UQ6CMod6tIkVLam271a7WdUlutEJJHTE'
          'author': 'S54FphiBzL3KueFF4'
          'createdAt': 1515650480814
          'title': 'How do I use \'git reset --hard HEAD\' to revert to a previous commit? - Stack Overflow'
        'Linkstate%2Eyouiest%2Ecom%2Fabout':
          'Linkstate%2Eyouiest%2Ecom':
            'from': 'Linkstate%2Eyouiest%2Ecom'
            'to': 'Linkstate%2Eyouiest%2Ecom%2Fabout'
            'meta':
              'title': 'Linkstate - Connecting is seeing'
              'weight': 8
              'body': 'The fate of bookmarks can tell us a lot about Linkstate'
              'face': 'http://graph.facebook.com/v2.7/10154232419354595/picture?type=square'
              'profileLink': 'https://www.facebook.com/app_scoped_user_id/10154232419354595/'
              'FromLink': 'Linkstate.youiest.com'
              'ToLink': 'Linkstate.youiest.com/about'
              'ScreenshotUrl': 'https://api.urlbox.io/v1/FLMG5BM3XeqMGa42/117475d1c2f4d6fac7710dcc2f841e06b46e06b3/png?url=Linkstate.youiest.com&thumb_width=320&quality=80'
              'ScreenshotUrlTo': 'https://api.urlbox.io/v1/FLMG5BM3XeqMGa42/7c81ff8950b76e157e44b1a70cfb81532f9a170c/png?url=Linkstate.youiest.com%2Fabout&thumb_width=320&quality=80'
            'author': 'S54FphiBzL3KueFF4'
            'createdAt': 1515744706613
            'title': 'Linkstate - Connecting is seeing'
          'Linkstate%2Eyouiest%2Ecom%2Fabout':
            'from': 'Linkstate%2Eyouiest%2Ecom%2Fabout'
            'to': 'Linkstate%2Eyouiest%2Ecom%2Fabout'
            'meta':
              'title': 'Linkstate - Connecting is seeing'
              'weight': 8
              'body': 'The fate of bookmarks can tell us a lot about Linkstate'
              'face': 'http://graph.facebook.com/v2.7/10154232419354595/picture?type=square'
              'profileLink': 'https://www.facebook.com/app_scoped_user_id/10154232419354595/'
              'FromLink': 'Linkstate.youiest.com/about'
              'ToLink': 'Linkstate.youiest.com/about'
              'ScreenshotUrl': 'https://api.urlbox.io/v1/FLMG5BM3XeqMGa42/7c81ff8950b76e157e44b1a70cfb81532f9a170c/png?url=Linkstate.youiest.com%2Fabout&thumb_width=320&quality=80'
              'ScreenshotUrlTo': 'https://api.urlbox.io/v1/FLMG5BM3XeqMGa42/7c81ff8950b76e157e44b1a70cfb81532f9a170c/png?url=Linkstate.youiest.com%2Fabout&thumb_width=320&quality=80'
            'author': 'S54FphiBzL3KueFF4'
            'createdAt': 1515894288582
            'title': 'Linkstate - Connecting is seeing'
          'https%3A%2F%2Fdevelopers%2Efacebook%2Ecom%2Fproducts%2Fsocial-plugins%2Fcomments%2F%3Futm_campaign%3Dsocial_plugins%26utm_medium%3Doffsite_pages%26utm_source%3Dcomments_plugin':
            'from': 'https%3A%2F%2Fdevelopers%2Efacebook%2Ecom%2Fproducts%2Fsocial-plugins%2Fcomments%2F%3Futm_campaign%3Dsocial_plugins%26utm_medium%3Doffsite_pages%26utm_source%3Dcomments_plugin'
            'to': 'Linkstate%2Eyouiest%2Ecom%2Fabout'
            'meta':
              'body': 'hasd'
              'weight': 5
              'title': 'Comments - Facebook for Developers'
              'face': 'http://graph.facebook.com/v2.7/10154232419354595/picture?type=square'
              'profileLink': 'https://www.facebook.com/app_scoped_user_id/10154232419354595/'
              'FromLink': 'https://developers.facebook.com/products/social-plugins/comments/?utm_campaign=social_plugins&utm_medium=offsite_pages&utm_source=comments_plugin'
              'ToLink': 'Linkstate.youiest.com/about'
              'ScreenshotUrl': 'https://api.urlbox.io/v1/FLMG5BM3XeqMGa42/07d8c5a90f1c223ccd0f83a8637374368bb68178/png?url=https%3A%2F%2Fdevelopers.facebook.com%2Fproducts%2Fsocial-plugins%2Fcomments%2F%3Futm_campaign%3Dsocial_plugins%26utm_medium%3Doffsite_pages%26utm_source%3Dcomments_plugin&thumb_width=320&quality=80'
              'ScreenshotUrlTo': 'https://api.urlbox.io/v1/FLMG5BM3XeqMGa42/7c81ff8950b76e157e44b1a70cfb81532f9a170c/png?url=Linkstate.youiest.com%2Fabout&thumb_width=320&quality=80'
            'author': 'S54FphiBzL3KueFF4'
            'createdAt': 1515752725802
            'title': 'Comments - Facebook for Developers'
          'http%3A%2F%2Fwww%2Ematerial-ui%2Ecom%2Fv0%2E15%2E0%2F%23%2Fcomponents%2Ficon-button':
            'from': 'http%3A%2F%2Fwww%2Ematerial-ui%2Ecom%2Fv0%2E15%2E0%2F%23%2Fcomponents%2Ficon-button'
            'to': 'Linkstate%2Eyouiest%2Ecom%2Fabout'
            'meta':
              'body': ''
              'weight': 7
              'title': 'Icon Button - Material-UI'
              'face': 'http://graph.facebook.com/v2.7/10154232419354595/picture?type=square'
              'profileLink': 'https://www.facebook.com/app_scoped_user_id/10154232419354595/'
              'FromLink': 'http://www.material-ui.com/v0.15.0/#/components/icon-button'
              'ToLink': 'Linkstate.youiest.com/about'
              'ScreenshotUrl': 'https://api.urlbox.io/v1/FLMG5BM3XeqMGa42/bc419c1ffae6d735068eb38564b861249f53af0f/png?url=http%3A%2F%2Fwww.material-ui.com%2Fv0.15.0%2F%23%2Fcomponents%2Ficon-button&thumb_width=320&quality=80'
              'ScreenshotUrlTo': 'https://api.urlbox.io/v1/FLMG5BM3XeqMGa42/7c81ff8950b76e157e44b1a70cfb81532f9a170c/png?url=Linkstate.youiest.com%2Fabout&thumb_width=320&quality=80'
            'author': 'S54FphiBzL3KueFF4'
            'createdAt': 1515848417835
            'title': 'Icon Button - Material-UI'
          'https%3A%2F%2Fwww%2Enpmjs%2Ecom%2Fpackage%2Fcopy-to-clipboard':
            'from': 'https%3A%2F%2Fwww%2Enpmjs%2Ecom%2Fpackage%2Fcopy-to-clipboard'
            'to': 'Linkstate%2Eyouiest%2Ecom%2Fabout'
            'meta':
              'body': 'haha'
              'weight': 6
              'title': 'copy-to-clipboard'
              'face': 'http://graph.facebook.com/v2.7/10154232419354595/picture?type=square'
              'profileLink': 'https://www.facebook.com/app_scoped_user_id/10154232419354595/'
              'FromLink': 'https://www.npmjs.com/package/copy-to-clipboard'
              'ToLink': 'Linkstate.youiest.com/about'
              'ScreenshotUrl': 'https://api.urlbox.io/v1/FLMG5BM3XeqMGa42/8be9bf072d4ca4620ea074275282f8e0acc74174/png?url=https%3A%2F%2Fwww.npmjs.com%2Fpackage%2Fcopy-to-clipboard&thumb_width=320&quality=80'
              'ScreenshotUrlTo': 'https://api.urlbox.io/v1/FLMG5BM3XeqMGa42/7c81ff8950b76e157e44b1a70cfb81532f9a170c/png?url=Linkstate.youiest.com%2Fabout&thumb_width=320&quality=80'
            'author': 'S54FphiBzL3KueFF4'
            'createdAt': 1515852726942
            'title': 'copy-to-clipboard'
          'http%3A%2F%2Fwww%2Ematerial-ui%2Ecom%2Fv0%2E15%2E0%2F%23%2Fcomponents%2Ffloating-action-button':
            'from': 'http%3A%2F%2Fwww%2Ematerial-ui%2Ecom%2Fv0%2E15%2E0%2F%23%2Fcomponents%2Ffloating-action-button'
            'to': 'Linkstate%2Eyouiest%2Ecom%2Fabout'
            'meta':
              'body': 'haha'
              'weight': 7
              'title': 'Floating Action Button - Material-UI'
              'face': 'http://graph.facebook.com/v2.7/10154232419354595/picture?type=square'
              'profileLink': 'https://www.facebook.com/app_scoped_user_id/10154232419354595/'
              'FromLink': 'http://www.material-ui.com/v0.15.0/#/components/floating-action-button'
              'ToLink': 'Linkstate.youiest.com/about'
              'ScreenshotUrl': 'https://api.urlbox.io/v1/FLMG5BM3XeqMGa42/da1d05c7c97b6a4f5473451ee8905aa7484401dd/png?url=http%3A%2F%2Fwww.material-ui.com%2Fv0.15.0%2F%23%2Fcomponents%2Ffloating-action-button&thumb_width=320&quality=80'
              'ScreenshotUrlTo': 'https://api.urlbox.io/v1/FLMG5BM3XeqMGa42/7c81ff8950b76e157e44b1a70cfb81532f9a170c/png?url=Linkstate.youiest.com%2Fabout&thumb_width=320&quality=80'
            'author': 'S54FphiBzL3KueFF4'
            'createdAt': 1515852807096
            'title': 'Floating Action Button - Material-UI'
        'http%3A%2F%2Fwww%2Ematerial-ui%2Ecom%2Fv0%2E15%2E0%2F%23%2Fcomponents%2Ficon-button': 'Linkstate%2Eyouiest%2Ecom%2Fabout':
          'from': 'Linkstate%2Eyouiest%2Ecom%2Fabout'
          'to': 'http%3A%2F%2Fwww%2Ematerial-ui%2Ecom%2Fv0%2E15%2E0%2F%23%2Fcomponents%2Ficon-button'
          'meta':
            'body': 'hi'
            'weight': 1
            'title': 'Linkstate - Connecting is seeing'
            'face': 'http://graph.facebook.com/v2.7/10154232419354595/picture?type=square'
            'profileLink': 'https://www.facebook.com/app_scoped_user_id/10154232419354595/'
            'FromLink': 'Linkstate.youiest.com/about'
            'ToLink': 'http://www.material-ui.com/v0.15.0/#/components/icon-button'
            'ScreenshotUrl': 'https://api.urlbox.io/v1/FLMG5BM3XeqMGa42/7c81ff8950b76e157e44b1a70cfb81532f9a170c/png?url=Linkstate.youiest.com%2Fabout&thumb_width=320&quality=80'
            'ScreenshotUrlTo': 'https://api.urlbox.io/v1/FLMG5BM3XeqMGa42/bc419c1ffae6d735068eb38564b861249f53af0f/png?url=http%3A%2F%2Fwww.material-ui.com%2Fv0.15.0%2F%23%2Fcomponents%2Ficon-button&thumb_width=320&quality=80'
          'author': 'S54FphiBzL3KueFF4'
          'createdAt': 1515765825514
          'title': 'Linkstate - Connecting is seeing'
        'http%3A%2F%2Fwww%2Ematerial-ui%2Ecom%2Fv0%2E15%2E0%2F%23%2Fcomponents%2Ffloating-action-button': 'https%3A%2F%2Fdevelopers%2Efacebook%2Ecom%2Fproducts%2Fsocial-plugins%2Fcomments%2F%3Futm_campaign%3Dsocial_plugins%26utm_medium%3Doffsite_pages%26utm_source%3Dcomments_plugin':
          'from': 'https%3A%2F%2Fdevelopers%2Efacebook%2Ecom%2Fproducts%2Fsocial-plugins%2Fcomments%2F%3Futm_campaign%3Dsocial_plugins%26utm_medium%3Doffsite_pages%26utm_source%3Dcomments_plugin'
          'to': 'http%3A%2F%2Fwww%2Ematerial-ui%2Ecom%2Fv0%2E15%2E0%2F%23%2Fcomponents%2Ffloating-action-button'
          'meta':
            'body': 'floating was last '
            'weight': 7
            'title': 'Comments - Facebook for Developers'
            'face': 'http://graph.facebook.com/v2.7/10154232419354595/picture?type=square'
            'profileLink': 'https://www.facebook.com/app_scoped_user_id/10154232419354595/'
            'FromLink': 'https://developers.facebook.com/products/social-plugins/comments/?utm_campaign=social_plugins&utm_medium=offsite_pages&utm_source=comments_plugin'
            'ToLink': 'http://www.material-ui.com/v0.15.0/#/components/floating-action-button'
            'ScreenshotUrl': 'https://api.urlbox.io/v1/FLMG5BM3XeqMGa42/07d8c5a90f1c223ccd0f83a8637374368bb68178/png?url=https%3A%2F%2Fdevelopers.facebook.com%2Fproducts%2Fsocial-plugins%2Fcomments%2F%3Futm_campaign%3Dsocial_plugins%26utm_medium%3Doffsite_pages%26utm_source%3Dcomments_plugin&thumb_width=320&quality=80'
            'ScreenshotUrlTo': 'https://api.urlbox.io/v1/FLMG5BM3XeqMGa42/da1d05c7c97b6a4f5473451ee8905aa7484401dd/png?url=http%3A%2F%2Fwww.material-ui.com%2Fv0.15.0%2F%23%2Fcomponents%2Ffloating-action-button&thumb_width=320&quality=80'
          'author': 'S54FphiBzL3KueFF4'
          'createdAt': 1515853396214
          'title': 'Comments - Facebook for Developers'
      'out':
        'Bookmarks':
          'Bookmarks':
            'from': 'Bookmarks'
            'to': 'Bookmarks'
            'meta':
              'title': 'Bookmarks - and other placeholders'
              'weight': 9
              'ScreenshotUrl': 'https://api.urlbox.io/v1/FLMG5BM3XeqMGa42/f9ef8e3b40885a6acde8c71ffdac6aac3365525e/png?url=Bookmarks&thumb_width=320&quality=80'
              'face': 'http://graph.facebook.com/v2.7/10154232419354595/picture?type=square'
              'profileLink': 'https://www.facebook.com/app_scoped_user_id/10154232419354595/'
              'FromLink': 'Bookmarks'
              'ToLink': 'Bookmarks'
              'ScreenshotUrlTo': 'https://api.urlbox.io/v1/FLMG5BM3XeqMGa42/f9ef8e3b40885a6acde8c71ffdac6aac3365525e/png?url=Bookmarks&thumb_width=320&quality=80'
            'author': 'S54FphiBzL3KueFF4'
            'createdAt': 1515894288198
            'title': 'Bookmarks - and other placeholders'
          'Linkstate%2Eyouiest%2Ecom':
            'from': 'Bookmarks'
            'to': 'Linkstate%2Eyouiest%2Ecom'
            'meta':
              'body': 'hjkkwer'
              'weight': 4
              'title': 'Bookmarks - and other placeholders'
              'face': 'http://graph.facebook.com/v2.7/10154232419354595/picture?type=square'
              'profileLink': 'https://www.facebook.com/app_scoped_user_id/10154232419354595/'
              'FromLink': 'Bookmarks'
              'ToLink': 'Linkstate.youiest.com'
              'ScreenshotUrl': 'https://api.urlbox.io/v1/FLMG5BM3XeqMGa42/f9ef8e3b40885a6acde8c71ffdac6aac3365525e/png?url=Bookmarks&thumb_width=320&quality=80'
              'ScreenshotUrlTo': 'https://api.urlbox.io/v1/FLMG5BM3XeqMGa42/117475d1c2f4d6fac7710dcc2f841e06b46e06b3/png?url=Linkstate.youiest.com&thumb_width=320&quality=80'
            'author': 'S54FphiBzL3KueFF4'
            'createdAt': 1515675012528
            'title': 'Bookmarks - and other placeholders'
          'https%3A%2F%2Fwww%2Efacebook%2Ecom%2Fapp_scoped_user_id%2F10154232419354595%2F':
            'from': 'https%3A%2F%2Fwww%2Efacebook%2Ecom%2Fapp_scoped_user_id%2F10154232419354595%2F'
            'to': 'Bookmarks'
            'meta':
              'title': 'Elias Moosman on Facebook'
              'weight': 7
              'face': 'http://graph.facebook.com/v2.7/10154232419354595/picture?type=square'
              'profileLink': 'https://www.facebook.com/app_scoped_user_id/10154232419354595/'
              'FromLink': 'https://www.facebook.com/app_scoped_user_id/10154232419354595/'
              'ToLink': 'Bookmarks'
              'ScreenshotUrl': 'https://api.thumbalizr.com/?url=https://www.facebook.com/app_scoped_user_id/10154232419354595/&width=250&api_key=UQ6CMod6tIkVLam271a7WdUlutEJJHTE'
              'ScreenshotUrlTo': 'https://api.thumbalizr.com/?url=Bookmarks&width=250&api_key=UQ6CMod6tIkVLam271a7WdUlutEJJHTE'
            'author': 'S54FphiBzL3KueFF4'
            'createdAt': 1515650468975
            'title': 'Elias Moosman on Facebook'
          'http%3A%2F%2Flocalhost%3A3000%2Fabout%3Ffrom%3Dhttps%25253A%25252F%25252Fwww%2Efacebook%2Ecom%25252Fapp_scoped_user_id%25252F10154232419354595%25252F%26lastTitle%3DIcon%252520Button%252520-%252520Material-UI%26to%3DBookmarks%26Bookmarked%3Dtrue%26content%3Dhahah%26switched%3D':
            'from': 'http%3A%2F%2Flocalhost%3A3000%2Fabout%3Ffrom%3Dhttps%25253A%25252F%25252Fwww%2Efacebook%2Ecom%25252Fapp_scoped_user_id%25252F10154232419354595%25252F%26lastTitle%3DIcon%252520Button%252520-%252520Material-UI%26to%3DBookmarks%26Bookmarked%3Dtrue%26content%3Dhahah%26switched%3D'
            'to': 'Bookmarks'
            'meta':
              'weight': 5
              'title': 'Linkstates for Elias Moosman on Facebook - https://www.facebook.com/app_scoped_user_id/10154232419354595/'
              'face': 'http://graph.facebook.com/v2.7/10154232419354595/picture?type=square'
              'profileLink': 'https://www.facebook.com/app_scoped_user_id/10154232419354595/'
              'FromLink': 'http://localhost:3000/about?from=https%253A%252F%252Fwww.facebook.com%252Fapp_scoped_user_id%252F10154232419354595%252F&lastTitle=Icon%2520Button%2520-%2520Material-UI&to=Bookmarks&Bookmarked=true&content=hahah&switched='
              'ToLink': 'Bookmarks'
              'ScreenshotUrl': 'https://api.thumbalizr.com/?url=http://localhost:3000/about?from=https%253A%252F%252Fwww.facebook.com%252Fapp_scoped_user_id%252F10154232419354595%252F&lastTitle=Icon%2520Button%2520-%2520Material-UI&to=Bookmarks&Bookmarked=true&content=hahah&switched=&width=250&api_key=UQ6CMod6tIkVLam271a7WdUlutEJJHTE'
              'ScreenshotUrlTo': 'https://api.thumbalizr.com/?url=Bookmarks&width=250&api_key=UQ6CMod6tIkVLam271a7WdUlutEJJHTE'
            'author': 'S54FphiBzL3KueFF4'
            'createdAt': 1515650383851
            'title': 'Linkstates for Elias Moosman on Facebook - https://www.facebook.com/app_scoped_user_id/10154232419354595/'
          'https%3A%2F%2Fstackoverflow%2Ecom%2Fquestions%2F9529078%2Fhow-do-i-use-git-reset-hard-head-to-revert-to-a-previous-commit':
            'from': 'https%3A%2F%2Fstackoverflow%2Ecom%2Fquestions%2F9529078%2Fhow-do-i-use-git-reset-hard-head-to-revert-to-a-previous-commit'
            'to': 'Bookmarks'
            'meta':
              'weight': 5
              'title': 'How do I use \'git reset --hard HEAD\' to revert to a previous commit? - Stack Overflow'
              'face': 'http://graph.facebook.com/v2.7/10154232419354595/picture?type=square'
              'profileLink': 'https://www.facebook.com/app_scoped_user_id/10154232419354595/'
              'FromLink': 'https://stackoverflow.com/questions/9529078/how-do-i-use-git-reset-hard-head-to-revert-to-a-previous-commit'
              'ToLink': 'Bookmarks'
              'ScreenshotUrl': 'https://api.thumbalizr.com/?url=https://stackoverflow.com/questions/9529078/how-do-i-use-git-reset-hard-head-to-revert-to-a-previous-commit&width=250&api_key=UQ6CMod6tIkVLam271a7WdUlutEJJHTE'
              'ScreenshotUrlTo': 'https://api.thumbalizr.com/?url=Bookmarks&width=250&api_key=UQ6CMod6tIkVLam271a7WdUlutEJJHTE'
            'author': 'S54FphiBzL3KueFF4'
            'createdAt': 1515650480814
            'title': 'How do I use \'git reset --hard HEAD\' to revert to a previous commit? - Stack Overflow'
        'https%3A%2F%2Fwww%2Efacebook%2Ecom%2Fapp_scoped_user_id%2F10154232419354595%2F':
          'Bookmarks':
            'from': 'https%3A%2F%2Fwww%2Efacebook%2Ecom%2Fapp_scoped_user_id%2F10154232419354595%2F'
            'to': 'Bookmarks'
            'meta':
              'title': 'Elias Moosman on Facebook'
              'weight': 7
              'face': 'http://graph.facebook.com/v2.7/10154232419354595/picture?type=square'
              'profileLink': 'https://www.facebook.com/app_scoped_user_id/10154232419354595/'
              'FromLink': 'https://www.facebook.com/app_scoped_user_id/10154232419354595/'
              'ToLink': 'Bookmarks'
              'ScreenshotUrl': 'https://api.urlbox.io/v1/FLMG5BM3XeqMGa42/9b1a5f128cbac84d2142d3377200235906e5a39e/png?url=https%3A%2F%2Fwww.facebook.com%2Fapp_scoped_user_id%2F10154232419354595%2F&thumb_width=320&quality=80'
              'ScreenshotUrlTo': 'https://api.urlbox.io/v1/FLMG5BM3XeqMGa42/f9ef8e3b40885a6acde8c71ffdac6aac3365525e/png?url=Bookmarks&thumb_width=320&quality=80'
            'author': 'S54FphiBzL3KueFF4'
            'createdAt': 1515894288763
            'title': 'Elias Moosman on Facebook'
          'https%3A%2F%2Fwww%2Efacebook%2Ecom%2Fapp_scoped_user_id%2F10154232419354595%2F':
            'from': 'https%3A%2F%2Fwww%2Efacebook%2Ecom%2Fapp_scoped_user_id%2F10154232419354595%2F'
            'to': 'https%3A%2F%2Fwww%2Efacebook%2Ecom%2Fapp_scoped_user_id%2F10154232419354595%2F'
            'meta':
              'body': ''
              'weight': 6
              'title': 'Elias Moosman on Facebook'
              'face': 'http://graph.facebook.com/v2.7/10154232419354595/picture?type=square'
              'profileLink': 'https://www.facebook.com/app_scoped_user_id/10154232419354595/'
              'FromLink': 'https://www.facebook.com/app_scoped_user_id/10154232419354595/'
              'ToLink': 'https://www.facebook.com/app_scoped_user_id/10154232419354595/'
              'ScreenshotUrl': 'https://api.urlbox.io/v1/FLMG5BM3XeqMGa42/9b1a5f128cbac84d2142d3377200235906e5a39e/png?url=https%3A%2F%2Fwww.facebook.com%2Fapp_scoped_user_id%2F10154232419354595%2F&thumb_width=320&quality=80'
              'ScreenshotUrlTo': 'https://api.urlbox.io/v1/FLMG5BM3XeqMGa42/9b1a5f128cbac84d2142d3377200235906e5a39e/png?url=https%3A%2F%2Fwww.facebook.com%2Fapp_scoped_user_id%2F10154232419354595%2F&thumb_width=320&quality=80'
            'author': 'S54FphiBzL3KueFF4'
            'createdAt': 1515848689254
            'title': 'Elias Moosman on Facebook'
        'Linkstate%2Eyouiest%2Ecom':
          'Bookmarks':
            'from': 'Linkstate%2Eyouiest%2Ecom'
            'to': 'Bookmarks'
            'meta':
              'title': 'Linkstate - Connecting is seeing'
              'weight': 7
              'face': 'http://graph.facebook.com/v2.7/10154232419354595/picture?type=square'
              'profileLink': 'https://www.facebook.com/app_scoped_user_id/10154232419354595/'
              'FromLink': 'Linkstate.youiest.com'
              'ToLink': 'Bookmarks'
              'ScreenshotUrl': 'https://api.urlbox.io/v1/FLMG5BM3XeqMGa42/117475d1c2f4d6fac7710dcc2f841e06b46e06b3/png?url=Linkstate.youiest.com&thumb_width=320&quality=80'
              'ScreenshotUrlTo': 'https://api.urlbox.io/v1/FLMG5BM3XeqMGa42/f9ef8e3b40885a6acde8c71ffdac6aac3365525e/png?url=Bookmarks&thumb_width=320&quality=80'
            'author': 'S54FphiBzL3KueFF4'
            'createdAt': 1515745036583
            'title': 'Linkstate - Connecting is seeing'
          'Linkstate%2Eyouiest%2Ecom%2Fabout':
            'from': 'Linkstate%2Eyouiest%2Ecom'
            'to': 'Linkstate%2Eyouiest%2Ecom%2Fabout'
            'meta':
              'title': 'Linkstate - Connecting is seeing'
              'weight': 8
              'body': 'The fate of bookmarks can tell us a lot about Linkstate'
              'face': 'http://graph.facebook.com/v2.7/10154232419354595/picture?type=square'
              'profileLink': 'https://www.facebook.com/app_scoped_user_id/10154232419354595/'
              'FromLink': 'Linkstate.youiest.com'
              'ToLink': 'Linkstate.youiest.com/about'
              'ScreenshotUrl': 'https://api.urlbox.io/v1/FLMG5BM3XeqMGa42/117475d1c2f4d6fac7710dcc2f841e06b46e06b3/png?url=Linkstate.youiest.com&thumb_width=320&quality=80'
              'ScreenshotUrlTo': 'https://api.urlbox.io/v1/FLMG5BM3XeqMGa42/7c81ff8950b76e157e44b1a70cfb81532f9a170c/png?url=Linkstate.youiest.com%2Fabout&thumb_width=320&quality=80'
            'author': 'S54FphiBzL3KueFF4'
            'createdAt': 1515744706613
            'title': 'Linkstate - Connecting is seeing'
        'http%3A%2F%2Flocalhost%3A3000%2Fabout%3Ffrom%3DLinkstate%2Eyouiest%2Ecom%26lastTitle%3DIcon%252520Button%252520-%252520Material-UI%26to%3DBookmarks%26Bookmarked%3Dtrue%26content%3D%26switched%3D': 'Bookmarks':
          'from': 'http%3A%2F%2Flocalhost%3A3000%2Fabout%3Ffrom%3DLinkstate%2Eyouiest%2Ecom%26lastTitle%3DIcon%252520Button%252520-%252520Material-UI%26to%3DBookmarks%26Bookmarked%3Dtrue%26content%3D%26switched%3D'
          'to': 'Bookmarks'
          'meta':
            'weight': 5
            'title': 'Linkstates for Linkstate - Connecting is seeing - Linkstate.youiest.com'
            'face': 'http://graph.facebook.com/v2.7/10154232419354595/picture?type=square'
            'profileLink': 'https://www.facebook.com/app_scoped_user_id/10154232419354595/'
            'FromLink': 'http://localhost:3000/about?from=Linkstate.youiest.com&lastTitle=Icon%2520Button%2520-%2520Material-UI&to=Bookmarks&Bookmarked=true&content=&switched='
            'ToLink': 'Bookmarks'
            'ScreenshotUrl': 'https://api.urlbox.io/v1/FLMG5BM3XeqMGa42/2a97329fccd9bea5497d209c411e6a54bbd03f76/png?url=http%3A%2F%2Flocalhost%3A3000%2Fabout%3Ffrom%3DLinkstate.youiest.com%26lastTitle%3DIcon%252520Button%252520-%252520Material-UI%26to%3DBookmarks%26Bookmarked%3Dtrue%26content%3D%26switched%3D&thumb_width=320&quality=80'
            'ScreenshotUrlTo': 'https://api.urlbox.io/v1/FLMG5BM3XeqMGa42/f9ef8e3b40885a6acde8c71ffdac6aac3365525e/png?url=Bookmarks&thumb_width=320&quality=80'
          'author': 'S54FphiBzL3KueFF4'
          'createdAt': 1515650897280
          'title': 'Linkstates for Linkstate - Connecting is seeing - Linkstate.youiest.com'
        'https%3A%2F%2Fwww%2Efacebook%2Ecom%2FvViber%3Flst%3D532514594%253A532514594%253A1514878343': 'Bookmarks':
          'from': 'https%3A%2F%2Fwww%2Efacebook%2Ecom%2FvViber%3Flst%3D532514594%253A532514594%253A1514878343'
          'to': 'Bookmarks'
          'meta':
            'weight': 5
            'title': '(2) Elias Moosman'
            'face': 'http://graph.facebook.com/v2.7/10154232419354595/picture?type=square'
            'profileLink': 'https://www.facebook.com/app_scoped_user_id/10154232419354595/'
            'FromLink': 'https://www.facebook.com/vViber?lst=532514594%3A532514594%3A1514878343'
            'ToLink': 'Bookmarks'
            'ScreenshotUrl': 'https://api.urlbox.io/v1/FLMG5BM3XeqMGa42/7f5979875238b6c4bc73ccfc7f6ec691414e8c8a/png?url=https%3A%2F%2Fwww.facebook.com%2FvViber%3Flst%3D532514594%253A532514594%253A1514878343&thumb_width=320&quality=80'
            'ScreenshotUrlTo': 'https://api.urlbox.io/v1/FLMG5BM3XeqMGa42/f9ef8e3b40885a6acde8c71ffdac6aac3365525e/png?url=Bookmarks&thumb_width=320&quality=80'
          'author': 'S54FphiBzL3KueFF4'
          'createdAt': 1515728165362
          'title': '(2) Elias Moosman'
        'http%3A%2F%2Flocalhost%3A3000%2Fabout%3Ffrom%3DLinkstate%2Eyouiest%2Ecom%26lastTitle%3DIcon%252520Button%252520-%252520Material-UI%26to%3DLinkstate%2Eyouiest%2Ecom%26Bookmarked%3Dtrue%26content%3D%26switched%3D': 'Bookmarks':
          'from': 'http%3A%2F%2Flocalhost%3A3000%2Fabout%3Ffrom%3DLinkstate%2Eyouiest%2Ecom%26lastTitle%3DIcon%252520Button%252520-%252520Material-UI%26to%3DLinkstate%2Eyouiest%2Ecom%26Bookmarked%3Dtrue%26content%3D%26switched%3D'
          'to': 'Bookmarks'
          'meta':
            'weight': 5
            'title': 'Linkstates for Linkstate - Connecting is seeing - Linkstate.youiest.com'
            'face': 'http://graph.facebook.com/v2.7/10154232419354595/picture?type=square'
            'profileLink': 'https://www.facebook.com/app_scoped_user_id/10154232419354595/'
            'FromLink': 'http://localhost:3000/about?from=Linkstate.youiest.com&lastTitle=Icon%2520Button%2520-%2520Material-UI&to=Linkstate.youiest.com&Bookmarked=true&content=&switched='
            'ToLink': 'Bookmarks'
            'ScreenshotUrl': 'https://api.urlbox.io/v1/FLMG5BM3XeqMGa42/7e9eca309d75b57045a48ca0cda20fa74c9c66b0/png?url=http%3A%2F%2Flocalhost%3A3000%2Fabout%3Ffrom%3DLinkstate.youiest.com%26lastTitle%3DIcon%252520Button%252520-%252520Material-UI%26to%3DLinkstate.youiest.com%26Bookmarked%3Dtrue%26content%3D%26switched%3D&thumb_width=320&quality=80'
            'ScreenshotUrlTo': 'https://api.urlbox.io/v1/FLMG5BM3XeqMGa42/f9ef8e3b40885a6acde8c71ffdac6aac3365525e/png?url=Bookmarks&thumb_width=320&quality=80'
          'author': 'S54FphiBzL3KueFF4'
          'createdAt': 1515728156303
          'title': 'Linkstates for Linkstate - Connecting is seeing - Linkstate.youiest.com'
        'Linkstate%2Eyouiest%2Ecom%2Fabout':
          'Linkstate%2Eyouiest%2Ecom%2Fabout':
            'from': 'Linkstate%2Eyouiest%2Ecom%2Fabout'
            'to': 'Linkstate%2Eyouiest%2Ecom%2Fabout'
            'meta':
              'title': 'Linkstate - Connecting is seeing'
              'weight': 8
              'body': 'The fate of bookmarks can tell us a lot about Linkstate'
              'face': 'http://graph.facebook.com/v2.7/10154232419354595/picture?type=square'
              'profileLink': 'https://www.facebook.com/app_scoped_user_id/10154232419354595/'
              'FromLink': 'Linkstate.youiest.com/about'
              'ToLink': 'Linkstate.youiest.com/about'
              'ScreenshotUrl': 'https://api.urlbox.io/v1/FLMG5BM3XeqMGa42/7c81ff8950b76e157e44b1a70cfb81532f9a170c/png?url=Linkstate.youiest.com%2Fabout&thumb_width=320&quality=80'
              'ScreenshotUrlTo': 'https://api.urlbox.io/v1/FLMG5BM3XeqMGa42/7c81ff8950b76e157e44b1a70cfb81532f9a170c/png?url=Linkstate.youiest.com%2Fabout&thumb_width=320&quality=80'
            'author': 'S54FphiBzL3KueFF4'
            'createdAt': 1515894288582
            'title': 'Linkstate - Connecting is seeing'
          'Bookmarks':
            'from': 'Linkstate%2Eyouiest%2Ecom%2Fabout'
            'to': 'Bookmarks'
            'meta':
              'title': 'Linkstate - Connecting is seeing'
              'weight': 7
              'face': 'http://graph.facebook.com/v2.7/10154232419354595/picture?type=square'
              'profileLink': 'https://www.facebook.com/app_scoped_user_id/10154232419354595/'
              'FromLink': 'Linkstate.youiest.com/about'
              'ToLink': 'Bookmarks'
              'ScreenshotUrl': 'https://api.urlbox.io/v1/FLMG5BM3XeqMGa42/7c81ff8950b76e157e44b1a70cfb81532f9a170c/png?url=Linkstate.youiest.com%2Fabout&thumb_width=320&quality=80'
              'ScreenshotUrlTo': 'https://api.urlbox.io/v1/FLMG5BM3XeqMGa42/f9ef8e3b40885a6acde8c71ffdac6aac3365525e/png?url=Bookmarks&thumb_width=320&quality=80'
            'author': 'S54FphiBzL3KueFF4'
            'createdAt': 1515894288449
            'title': 'Linkstate - Connecting is seeing'
          'http%3A%2F%2Fwww%2Ematerial-ui%2Ecom%2Fv0%2E15%2E0%2F%23%2Fcomponents%2Ficon-button':
            'from': 'Linkstate%2Eyouiest%2Ecom%2Fabout'
            'to': 'http%3A%2F%2Fwww%2Ematerial-ui%2Ecom%2Fv0%2E15%2E0%2F%23%2Fcomponents%2Ficon-button'
            'meta':
              'body': 'hi'
              'weight': 1
              'title': 'Linkstate - Connecting is seeing'
              'face': 'http://graph.facebook.com/v2.7/10154232419354595/picture?type=square'
              'profileLink': 'https://www.facebook.com/app_scoped_user_id/10154232419354595/'
              'FromLink': 'Linkstate.youiest.com/about'
              'ToLink': 'http://www.material-ui.com/v0.15.0/#/components/icon-button'
              'ScreenshotUrl': 'https://api.urlbox.io/v1/FLMG5BM3XeqMGa42/7c81ff8950b76e157e44b1a70cfb81532f9a170c/png?url=Linkstate.youiest.com%2Fabout&thumb_width=320&quality=80'
              'ScreenshotUrlTo': 'https://api.urlbox.io/v1/FLMG5BM3XeqMGa42/bc419c1ffae6d735068eb38564b861249f53af0f/png?url=http%3A%2F%2Fwww.material-ui.com%2Fv0.15.0%2F%23%2Fcomponents%2Ficon-button&thumb_width=320&quality=80'
            'author': 'S54FphiBzL3KueFF4'
            'createdAt': 1515765825514
            'title': 'Linkstate - Connecting is seeing'
        'https%3A%2F%2Flinkstate%2Eyouiest%2Ecom%2Fabout%3Ffrom%3DBookmarks%26lastTitle%3DGrid%252520List%252520-%252520Material-UI%26Bookmarked%3Dtrue%26to%3Dhttps%25253A%25252F%25252Fmopinion%2Ecom%25252Ftop-10-website-annotation-tools%25252F%26content%3D%26switched%3D': 'Bookmarks':
          'from': 'https%3A%2F%2Flinkstate%2Eyouiest%2Ecom%2Fabout%3Ffrom%3DBookmarks%26lastTitle%3DGrid%252520List%252520-%252520Material-UI%26Bookmarked%3Dtrue%26to%3Dhttps%25253A%25252F%25252Fmopinion%2Ecom%25252Ftop-10-website-annotation-tools%25252F%26content%3D%26switched%3D'
          'to': 'Bookmarks'
          'meta':
            'weight': 5
            'title': 'Linkstates for Bookmarks - and other placeholders - Bookmarks'
            'face': 'http://graph.facebook.com/v2.7/10154232419354595/picture?type=square'
            'profileLink': 'https://www.facebook.com/app_scoped_user_id/10154232419354595/'
            'FromLink': 'https://linkstate.youiest.com/about?from=Bookmarks&lastTitle=Grid%2520List%2520-%2520Material-UI&Bookmarked=true&to=https%253A%252F%252Fmopinion.com%252Ftop-10-website-annotation-tools%252F&content=&switched='
            'ToLink': 'Bookmarks'
            'ScreenshotUrl': 'https://api.urlbox.io/v1/FLMG5BM3XeqMGa42/891c9105bb40fedaf3946178f7ee21f0cf25cb54/png?url=https%3A%2F%2Flinkstate.youiest.com%2Fabout%3Ffrom%3DBookmarks%26lastTitle%3DGrid%252520List%252520-%252520Material-UI%26Bookmarked%3Dtrue%26to%3Dhttps%25253A%25252F%25252Fmopinion.com%25252Ftop-10-website-annotation-tools%25252F%26content%3D%26switched%3D&thumb_width=320&quality=80'
            'ScreenshotUrlTo': 'https://api.urlbox.io/v1/FLMG5BM3XeqMGa42/f9ef8e3b40885a6acde8c71ffdac6aac3365525e/png?url=Bookmarks&thumb_width=320&quality=80'
          'author': 'S54FphiBzL3KueFF4'
          'createdAt': 1515750433476
          'title': 'Linkstates for Bookmarks - and other placeholders - Bookmarks'
        'https%3A%2F%2Fdevelopers%2Efacebook%2Ecom%2Fproducts%2Fsocial-plugins%2Fcomments%2F%3Futm_campaign%3Dsocial_plugins%26utm_medium%3Doffsite_pages%26utm_source%3Dcomments_plugin':
          'Bookmarks':
            'from': 'https%3A%2F%2Fdevelopers%2Efacebook%2Ecom%2Fproducts%2Fsocial-plugins%2Fcomments%2F%3Futm_campaign%3Dsocial_plugins%26utm_medium%3Doffsite_pages%26utm_source%3Dcomments_plugin'
            'to': 'Bookmarks'
            'meta':
              'weight': 5
              'title': 'Comments - Facebook for Developers'
              'face': 'http://graph.facebook.com/v2.7/10154232419354595/picture?type=square'
              'profileLink': 'https://www.facebook.com/app_scoped_user_id/10154232419354595/'
              'FromLink': 'https://developers.facebook.com/products/social-plugins/comments/?utm_campaign=social_plugins&utm_medium=offsite_pages&utm_source=comments_plugin'
              'ToLink': 'Bookmarks'
              'ScreenshotUrl': 'https://api.urlbox.io/v1/FLMG5BM3XeqMGa42/07d8c5a90f1c223ccd0f83a8637374368bb68178/png?url=https%3A%2F%2Fdevelopers.facebook.com%2Fproducts%2Fsocial-plugins%2Fcomments%2F%3Futm_campaign%3Dsocial_plugins%26utm_medium%3Doffsite_pages%26utm_source%3Dcomments_plugin&thumb_width=320&quality=80'
              'ScreenshotUrlTo': 'https://api.urlbox.io/v1/FLMG5BM3XeqMGa42/f9ef8e3b40885a6acde8c71ffdac6aac3365525e/png?url=Bookmarks&thumb_width=320&quality=80'
            'author': 'S54FphiBzL3KueFF4'
            'createdAt': 1515893775950
            'title': 'Comments - Facebook for Developers'
          'Linkstate%2Eyouiest%2Ecom%2Fabout':
            'from': 'https%3A%2F%2Fdevelopers%2Efacebook%2Ecom%2Fproducts%2Fsocial-plugins%2Fcomments%2F%3Futm_campaign%3Dsocial_plugins%26utm_medium%3Doffsite_pages%26utm_source%3Dcomments_plugin'
            'to': 'Linkstate%2Eyouiest%2Ecom%2Fabout'
            'meta':
              'body': 'hasd'
              'weight': 5
              'title': 'Comments - Facebook for Developers'
              'face': 'http://graph.facebook.com/v2.7/10154232419354595/picture?type=square'
              'profileLink': 'https://www.facebook.com/app_scoped_user_id/10154232419354595/'
              'FromLink': 'https://developers.facebook.com/products/social-plugins/comments/?utm_campaign=social_plugins&utm_medium=offsite_pages&utm_source=comments_plugin'
              'ToLink': 'Linkstate.youiest.com/about'
              'ScreenshotUrl': 'https://api.urlbox.io/v1/FLMG5BM3XeqMGa42/07d8c5a90f1c223ccd0f83a8637374368bb68178/png?url=https%3A%2F%2Fdevelopers.facebook.com%2Fproducts%2Fsocial-plugins%2Fcomments%2F%3Futm_campaign%3Dsocial_plugins%26utm_medium%3Doffsite_pages%26utm_source%3Dcomments_plugin&thumb_width=320&quality=80'
              'ScreenshotUrlTo': 'https://api.urlbox.io/v1/FLMG5BM3XeqMGa42/7c81ff8950b76e157e44b1a70cfb81532f9a170c/png?url=Linkstate.youiest.com%2Fabout&thumb_width=320&quality=80'
            'author': 'S54FphiBzL3KueFF4'
            'createdAt': 1515752725802
            'title': 'Comments - Facebook for Developers'
          'http%3A%2F%2Fwww%2Ematerial-ui%2Ecom%2Fv0%2E15%2E0%2F%23%2Fcomponents%2Ffloating-action-button':
            'from': 'https%3A%2F%2Fdevelopers%2Efacebook%2Ecom%2Fproducts%2Fsocial-plugins%2Fcomments%2F%3Futm_campaign%3Dsocial_plugins%26utm_medium%3Doffsite_pages%26utm_source%3Dcomments_plugin'
            'to': 'http%3A%2F%2Fwww%2Ematerial-ui%2Ecom%2Fv0%2E15%2E0%2F%23%2Fcomponents%2Ffloating-action-button'
            'meta':
              'body': 'floating was last '
              'weight': 7
              'title': 'Comments - Facebook for Developers'
              'face': 'http://graph.facebook.com/v2.7/10154232419354595/picture?type=square'
              'profileLink': 'https://www.facebook.com/app_scoped_user_id/10154232419354595/'
              'FromLink': 'https://developers.facebook.com/products/social-plugins/comments/?utm_campaign=social_plugins&utm_medium=offsite_pages&utm_source=comments_plugin'
              'ToLink': 'http://www.material-ui.com/v0.15.0/#/components/floating-action-button'
              'ScreenshotUrl': 'https://api.urlbox.io/v1/FLMG5BM3XeqMGa42/07d8c5a90f1c223ccd0f83a8637374368bb68178/png?url=https%3A%2F%2Fdevelopers.facebook.com%2Fproducts%2Fsocial-plugins%2Fcomments%2F%3Futm_campaign%3Dsocial_plugins%26utm_medium%3Doffsite_pages%26utm_source%3Dcomments_plugin&thumb_width=320&quality=80'
              'ScreenshotUrlTo': 'https://api.urlbox.io/v1/FLMG5BM3XeqMGa42/da1d05c7c97b6a4f5473451ee8905aa7484401dd/png?url=http%3A%2F%2Fwww.material-ui.com%2Fv0.15.0%2F%23%2Fcomponents%2Ffloating-action-button&thumb_width=320&quality=80'
            'author': 'S54FphiBzL3KueFF4'
            'createdAt': 1515853396214
            'title': 'Comments - Facebook for Developers'
        'http%3A%2F%2Fwww%2Ematerial-ui%2Ecom%2Fv0%2E15%2E0%2F%23%2Fcomponents%2Ficon-button':
          'Bookmarks':
            'from': 'http%3A%2F%2Fwww%2Ematerial-ui%2Ecom%2Fv0%2E15%2E0%2F%23%2Fcomponents%2Ficon-button'
            'to': 'Bookmarks'
            'meta':
              'weight': 5
              'title': 'Icon Button - Material-UI'
              'face': 'http://graph.facebook.com/v2.7/10154232419354595/picture?type=square'
              'profileLink': 'https://www.facebook.com/app_scoped_user_id/10154232419354595/'
              'FromLink': 'http://www.material-ui.com/v0.15.0/#/components/icon-button'
              'ToLink': 'Bookmarks'
              'ScreenshotUrl': 'https://api.urlbox.io/v1/FLMG5BM3XeqMGa42/bc419c1ffae6d735068eb38564b861249f53af0f/png?url=http%3A%2F%2Fwww.material-ui.com%2Fv0.15.0%2F%23%2Fcomponents%2Ficon-button&thumb_width=320&quality=80'
              'ScreenshotUrlTo': 'https://api.urlbox.io/v1/FLMG5BM3XeqMGa42/f9ef8e3b40885a6acde8c71ffdac6aac3365525e/png?url=Bookmarks&thumb_width=320&quality=80'
            'author': 'S54FphiBzL3KueFF4'
            'createdAt': 1515752736619
            'title': 'Icon Button - Material-UI'
          'Linkstate%2Eyouiest%2Ecom%2Fabout':
            'from': 'http%3A%2F%2Fwww%2Ematerial-ui%2Ecom%2Fv0%2E15%2E0%2F%23%2Fcomponents%2Ficon-button'
            'to': 'Linkstate%2Eyouiest%2Ecom%2Fabout'
            'meta':
              'body': ''
              'weight': 7
              'title': 'Icon Button - Material-UI'
              'face': 'http://graph.facebook.com/v2.7/10154232419354595/picture?type=square'
              'profileLink': 'https://www.facebook.com/app_scoped_user_id/10154232419354595/'
              'FromLink': 'http://www.material-ui.com/v0.15.0/#/components/icon-button'
              'ToLink': 'Linkstate.youiest.com/about'
              'ScreenshotUrl': 'https://api.urlbox.io/v1/FLMG5BM3XeqMGa42/bc419c1ffae6d735068eb38564b861249f53af0f/png?url=http%3A%2F%2Fwww.material-ui.com%2Fv0.15.0%2F%23%2Fcomponents%2Ficon-button&thumb_width=320&quality=80'
              'ScreenshotUrlTo': 'https://api.urlbox.io/v1/FLMG5BM3XeqMGa42/7c81ff8950b76e157e44b1a70cfb81532f9a170c/png?url=Linkstate.youiest.com%2Fabout&thumb_width=320&quality=80'
            'author': 'S54FphiBzL3KueFF4'
            'createdAt': 1515848417835
            'title': 'Icon Button - Material-UI'
        'https%3A%2F%2Fwww%2Enpmjs%2Ecom%2Fpackage%2Fcopy-to-clipboard':
          'Bookmarks':
            'from': 'https%3A%2F%2Fwww%2Enpmjs%2Ecom%2Fpackage%2Fcopy-to-clipboard'
            'to': 'Bookmarks'
            'meta':
              'weight': 5
              'title': 'copy-to-clipboard'
              'face': 'http://graph.facebook.com/v2.7/10154232419354595/picture?type=square'
              'profileLink': 'https://www.facebook.com/app_scoped_user_id/10154232419354595/'
              'FromLink': 'https://www.npmjs.com/package/copy-to-clipboard'
              'ToLink': 'Bookmarks'
              'ScreenshotUrl': 'https://api.urlbox.io/v1/FLMG5BM3XeqMGa42/8be9bf072d4ca4620ea074275282f8e0acc74174/png?url=https%3A%2F%2Fwww.npmjs.com%2Fpackage%2Fcopy-to-clipboard&thumb_width=320&quality=80'
              'ScreenshotUrlTo': 'https://api.urlbox.io/v1/FLMG5BM3XeqMGa42/f9ef8e3b40885a6acde8c71ffdac6aac3365525e/png?url=Bookmarks&thumb_width=320&quality=80'
            'author': 'S54FphiBzL3KueFF4'
            'createdAt': 1515848424123
            'title': 'copy-to-clipboard'
          'Linkstate%2Eyouiest%2Ecom%2Fabout':
            'from': 'https%3A%2F%2Fwww%2Enpmjs%2Ecom%2Fpackage%2Fcopy-to-clipboard'
            'to': 'Linkstate%2Eyouiest%2Ecom%2Fabout'
            'meta':
              'body': 'haha'
              'weight': 6
              'title': 'copy-to-clipboard'
              'face': 'http://graph.facebook.com/v2.7/10154232419354595/picture?type=square'
              'profileLink': 'https://www.facebook.com/app_scoped_user_id/10154232419354595/'
              'FromLink': 'https://www.npmjs.com/package/copy-to-clipboard'
              'ToLink': 'Linkstate.youiest.com/about'
              'ScreenshotUrl': 'https://api.urlbox.io/v1/FLMG5BM3XeqMGa42/8be9bf072d4ca4620ea074275282f8e0acc74174/png?url=https%3A%2F%2Fwww.npmjs.com%2Fpackage%2Fcopy-to-clipboard&thumb_width=320&quality=80'
              'ScreenshotUrlTo': 'https://api.urlbox.io/v1/FLMG5BM3XeqMGa42/7c81ff8950b76e157e44b1a70cfb81532f9a170c/png?url=Linkstate.youiest.com%2Fabout&thumb_width=320&quality=80'
            'author': 'S54FphiBzL3KueFF4'
            'createdAt': 1515852726942
            'title': 'copy-to-clipboard'
        'http%3A%2F%2Fwww%2Ematerial-ui%2Ecom%2Fv0%2E15%2E0%2F%23%2Fcomponents%2Ffloating-action-button':
          'Bookmarks':
            'from': 'http%3A%2F%2Fwww%2Ematerial-ui%2Ecom%2Fv0%2E15%2E0%2F%23%2Fcomponents%2Ffloating-action-button'
            'to': 'Bookmarks'
            'meta':
              'weight': 5
              'title': 'Floating Action Button - Material-UI'
              'face': 'http://graph.facebook.com/v2.7/10154232419354595/picture?type=square'
              'profileLink': 'https://www.facebook.com/app_scoped_user_id/10154232419354595/'
              'FromLink': 'http://www.material-ui.com/v0.15.0/#/components/floating-action-button'
              'ToLink': 'Bookmarks'
              'ScreenshotUrl': 'https://api.urlbox.io/v1/FLMG5BM3XeqMGa42/da1d05c7c97b6a4f5473451ee8905aa7484401dd/png?url=http%3A%2F%2Fwww.material-ui.com%2Fv0.15.0%2F%23%2Fcomponents%2Ffloating-action-button&thumb_width=320&quality=80'
              'ScreenshotUrlTo': 'https://api.urlbox.io/v1/FLMG5BM3XeqMGa42/f9ef8e3b40885a6acde8c71ffdac6aac3365525e/png?url=Bookmarks&thumb_width=320&quality=80'
            'author': 'S54FphiBzL3KueFF4'
            'createdAt': 1515849481404
            'title': 'Floating Action Button - Material-UI'
          'Linkstate%2Eyouiest%2Ecom%2Fabout':
            'from': 'http%3A%2F%2Fwww%2Ematerial-ui%2Ecom%2Fv0%2E15%2E0%2F%23%2Fcomponents%2Ffloating-action-button'
            'to': 'Linkstate%2Eyouiest%2Ecom%2Fabout'
            'meta':
              'body': 'haha'
              'weight': 7
              'title': 'Floating Action Button - Material-UI'
              'face': 'http://graph.facebook.com/v2.7/10154232419354595/picture?type=square'
              'profileLink': 'https://www.facebook.com/app_scoped_user_id/10154232419354595/'
              'FromLink': 'http://www.material-ui.com/v0.15.0/#/components/floating-action-button'
              'ToLink': 'Linkstate.youiest.com/about'
              'ScreenshotUrl': 'https://api.urlbox.io/v1/FLMG5BM3XeqMGa42/da1d05c7c97b6a4f5473451ee8905aa7484401dd/png?url=http%3A%2F%2Fwww.material-ui.com%2Fv0.15.0%2F%23%2Fcomponents%2Ffloating-action-button&thumb_width=320&quality=80'
              'ScreenshotUrlTo': 'https://api.urlbox.io/v1/FLMG5BM3XeqMGa42/7c81ff8950b76e157e44b1a70cfb81532f9a170c/png?url=Linkstate.youiest.com%2Fabout&thumb_width=320&quality=80'
            'author': 'S54FphiBzL3KueFF4'
            'createdAt': 1515852807096
            'title': 'Floating Action Button - Material-UI'
        'https%3A%2F%2Furlbox%2Eio%2Fdashboard': 'Bookmarks':
          'from': 'https%3A%2F%2Furlbox%2Eio%2Fdashboard'
          'to': 'Bookmarks'
          'meta':
            'weight': 5
            'title': 'User Dashboard | Urlbox'
            'face': 'http://graph.facebook.com/v2.7/10154232419354595/picture?type=square'
            'profileLink': 'https://www.facebook.com/app_scoped_user_id/10154232419354595/'
            'FromLink': 'https://urlbox.io/dashboard'
            'ToLink': 'Bookmarks'
            'ScreenshotUrl': 'https://api.urlbox.io/v1/FLMG5BM3XeqMGa42/470f97a39f9047b5aedc6918697e66578003b17c/png?url=https%3A%2F%2Furlbox.io%2Fdashboard&thumb_width=320&quality=80'
            'ScreenshotUrlTo': 'https://api.urlbox.io/v1/FLMG5BM3XeqMGa42/f9ef8e3b40885a6acde8c71ffdac6aac3365525e/png?url=Bookmarks&thumb_width=320&quality=80'
          'author': 'S54FphiBzL3KueFF4'
          'createdAt': 1515852668465
          'title': 'User Dashboard | Urlbox'
        'http%3A%2F%2Fwww%2Ematerial-ui%2Ecom%2Fv0%2E15%2E0%2F%23%2Fcomponents%2Fdivider': 'Bookmarks':
          'from': 'http%3A%2F%2Fwww%2Ematerial-ui%2Ecom%2Fv0%2E15%2E0%2F%23%2Fcomponents%2Fdivider'
          'to': 'Bookmarks'
          'meta':
            'weight': 5
            'title': 'Material-UI'
            'face': 'http://graph.facebook.com/v2.7/10154232419354595/picture?type=square'
            'profileLink': 'https://www.facebook.com/app_scoped_user_id/10154232419354595/'
            'FromLink': 'http://www.material-ui.com/v0.15.0/#/components/divider'
            'ToLink': 'Bookmarks'
            'ScreenshotUrl': 'https://api.urlbox.io/v1/FLMG5BM3XeqMGa42/e01735992a16b0765be9dfff99a1e69c62c39d76/png?url=http%3A%2F%2Fwww.material-ui.com%2Fv0.15.0%2F%23%2Fcomponents%2Fdivider&thumb_width=320&quality=80'
            'ScreenshotUrlTo': 'https://api.urlbox.io/v1/FLMG5BM3XeqMGa42/f9ef8e3b40885a6acde8c71ffdac6aac3365525e/png?url=Bookmarks&thumb_width=320&quality=80'
          'author': 'S54FphiBzL3KueFF4'
          'createdAt': 1515893133244
          'title': 'Material-UI'
        'http%3A%2F%2Fwww%2Ematerial-ui%2Ecom%2Fv0%2E15%2E0%2F%23%2Fcomponents%2Fdrawer': 'Bookmarks':
          'from': 'http%3A%2F%2Fwww%2Ematerial-ui%2Ecom%2Fv0%2E15%2E0%2F%23%2Fcomponents%2Fdrawer'
          'to': 'Bookmarks'
          'meta':
            'weight': 5
            'title': 'Drawer - Material-UI'
            'face': 'http://graph.facebook.com/v2.7/10154232419354595/picture?type=square'
            'profileLink': 'https://www.facebook.com/app_scoped_user_id/10154232419354595/'
            'FromLink': 'http://www.material-ui.com/v0.15.0/#/components/drawer'
            'ToLink': 'Bookmarks'
            'ScreenshotUrl': 'https://api.urlbox.io/v1/FLMG5BM3XeqMGa42/d99ca99ca087fe2a9d1b01035322b66bd9d3530d/png?url=http%3A%2F%2Fwww.material-ui.com%2Fv0.15.0%2F%23%2Fcomponents%2Fdrawer&thumb_width=320&quality=80'
            'ScreenshotUrlTo': 'https://api.urlbox.io/v1/FLMG5BM3XeqMGa42/f9ef8e3b40885a6acde8c71ffdac6aac3365525e/png?url=Bookmarks&thumb_width=320&quality=80'
          'author': 'S54FphiBzL3KueFF4'
          'createdAt': 1515896611045
          'title': 'Drawer - Material-UI'
    'hits': 822
    'fromLast': 'http://www.material-ui.com/v0.15.0/#/components/drawer'
    'toLast': 'Linkstate.youiest.com/about'
selectedProps =
  'from': 'Linkstate.youiest.com/about'
  'to': 'https://www.facebook.com/app_scoped_user_id/10154232419354595/'
  'lastTitle': 'Icon Button - Material-UI'
  'user':
    '_id': 'S54FphiBzL3KueFF4'
    'profile': 'name': 'Elias Moosman'
    'createdAt': '2018-01-11T05:57:30.482Z'
    'services':
      'facebook':
        'expiresAt': 1520753914953
        'id': '10154232419354595'
        'email': 'eliasmoosman@gmail.com'
        'name': 'Elias Moosman'
        'first_name': 'Elias'
        'last_name': 'Moosman'
        'link': 'https://www.facebook.com/app_scoped_user_id/10154232419354595/'
        'gender': 'male'
        'locale': 'sv_SE'
        'age_range': 'min': 21
      'thumbalizr': null
    'edited': 1517868118023
    'commit': '1517817829986':
      'in': null
      'out': null
    'fromLast': 'https://www.facebook.com/app_scoped_user_id/10154232419354595/'
    'toLast': 'en.wikipedia.org/wiki/bookmark'
    'links':
      'out':
        'en%2Ewikipedia%2Eorg%2Fwiki%2Fbookmark': 'en%2Ewikipedia%2Eorg%2Fwiki%2Fbookmark':
          'from': 'en%2Ewikipedia%2Eorg%2Fwiki%2Fbookmark'
          'to': 'en%2Ewikipedia%2Eorg%2Fwiki%2Fbookmark'
          'meta':
            'title': 'Bookmarks - and other placeholders'
            'weight': 9
            'ScreenshotUrl': 'https://api.urlbox.io/v1/FLMG5BM3XeqMGa42/dfa731789ad019f3a532fe83b20d20f05f11de38/png?url=en.wikipedia.org%2Fwiki%2Fbookmark&thumb_width=320&quality=80'
            'face': 'http://graph.facebook.com/v2.7/10154232419354595/picture?type=square'
            'profileLink': 'https://www.facebook.com/app_scoped_user_id/10154232419354595/'
            'FromLink': 'en.wikipedia.org/wiki/bookmark'
            'ToLink': 'en.wikipedia.org/wiki/bookmark'
            'ScreenshotUrlTo': 'https://api.urlbox.io/v1/FLMG5BM3XeqMGa42/dfa731789ad019f3a532fe83b20d20f05f11de38/png?url=en.wikipedia.org%2Fwiki%2Fbookmark&thumb_width=320&quality=80'
          'author': 'S54FphiBzL3KueFF4'
          'createdAt': 1517868117818
          'title': 'Bookmarks - and other placeholders'
        'Linkstate%2Eyouiest%2Ecom%2Fabout':
          'en%2Ewikipedia%2Eorg%2Fwiki%2Fbookmark':
            'from': 'Linkstate%2Eyouiest%2Ecom%2Fabout'
            'to': 'en%2Ewikipedia%2Eorg%2Fwiki%2Fbookmark'
            'meta':
              'title': 'Linkstate - Connecting is seeing'
              'weight': 7
              'face': 'http://graph.facebook.com/v2.7/10154232419354595/picture?type=square'
              'profileLink': 'https://www.facebook.com/app_scoped_user_id/10154232419354595/'
              'FromLink': 'Linkstate.youiest.com/about'
              'ToLink': 'en.wikipedia.org/wiki/bookmark'
              'ScreenshotUrl': 'https://api.urlbox.io/v1/FLMG5BM3XeqMGa42/7c81ff8950b76e157e44b1a70cfb81532f9a170c/png?url=Linkstate.youiest.com%2Fabout&thumb_width=320&quality=80'
              'ScreenshotUrlTo': 'https://api.urlbox.io/v1/FLMG5BM3XeqMGa42/dfa731789ad019f3a532fe83b20d20f05f11de38/png?url=en.wikipedia.org%2Fwiki%2Fbookmark&thumb_width=320&quality=80'
            'author': 'S54FphiBzL3KueFF4'
            'createdAt': 1517868117916
            'title': 'Linkstate - Connecting is seeing'
          'Linkstate%2Eyouiest%2Ecom%2Fabout':
            'from': 'Linkstate%2Eyouiest%2Ecom%2Fabout'
            'to': 'Linkstate%2Eyouiest%2Ecom%2Fabout'
            'meta':
              'title': 'Linkstate - Connecting is seeing'
              'weight': 8
              'body': 'The fate of bookmarks can tell us a lot about Linkstate'
              'face': 'http://graph.facebook.com/v2.7/10154232419354595/picture?type=square'
              'profileLink': 'https://www.facebook.com/app_scoped_user_id/10154232419354595/'
              'FromLink': 'Linkstate.youiest.com/about'
              'ToLink': 'Linkstate.youiest.com/about'
              'ScreenshotUrl': 'https://api.urlbox.io/v1/FLMG5BM3XeqMGa42/7c81ff8950b76e157e44b1a70cfb81532f9a170c/png?url=Linkstate.youiest.com%2Fabout&thumb_width=320&quality=80'
              'ScreenshotUrlTo': 'https://api.urlbox.io/v1/FLMG5BM3XeqMGa42/7c81ff8950b76e157e44b1a70cfb81532f9a170c/png?url=Linkstate.youiest.com%2Fabout&thumb_width=320&quality=80'
            'author': 'S54FphiBzL3KueFF4'
            'createdAt': 1517868117963
            'title': 'Linkstate - Connecting is seeing'
        'https%3A%2F%2Fwww%2Efacebook%2Ecom%2Fapp_scoped_user_id%2F10154232419354595%2F': 'en%2Ewikipedia%2Eorg%2Fwiki%2Fbookmark':
          'from': 'https%3A%2F%2Fwww%2Efacebook%2Ecom%2Fapp_scoped_user_id%2F10154232419354595%2F'
          'to': 'en%2Ewikipedia%2Eorg%2Fwiki%2Fbookmark'
          'meta':
            'title': 'Elias Moosman on Facebook'
            'weight': 7
            'face': 'http://graph.facebook.com/v2.7/10154232419354595/picture?type=square'
            'profileLink': 'https://www.facebook.com/app_scoped_user_id/10154232419354595/'
            'FromLink': 'https://www.facebook.com/app_scoped_user_id/10154232419354595/'
            'ToLink': 'en.wikipedia.org/wiki/bookmark'
            'ScreenshotUrl': 'https://api.urlbox.io/v1/FLMG5BM3XeqMGa42/9b1a5f128cbac84d2142d3377200235906e5a39e/png?url=https%3A%2F%2Fwww.facebook.com%2Fapp_scoped_user_id%2F10154232419354595%2F&thumb_width=320&quality=80'
            'ScreenshotUrlTo': 'https://api.urlbox.io/v1/FLMG5BM3XeqMGa42/dfa731789ad019f3a532fe83b20d20f05f11de38/png?url=en.wikipedia.org%2Fwiki%2Fbookmark&thumb_width=320&quality=80'
          'author': 'S54FphiBzL3KueFF4'
          'createdAt': 1517868118023
          'title': 'Elias Moosman on Facebook'
      'in':
        'en%2Ewikipedia%2Eorg%2Fwiki%2Fbookmark':
          'en%2Ewikipedia%2Eorg%2Fwiki%2Fbookmark':
            'from': 'en%2Ewikipedia%2Eorg%2Fwiki%2Fbookmark'
            'to': 'en%2Ewikipedia%2Eorg%2Fwiki%2Fbookmark'
            'meta':
              'title': 'Bookmarks - and other placeholders'
              'weight': 9
              'ScreenshotUrl': 'https://api.urlbox.io/v1/FLMG5BM3XeqMGa42/dfa731789ad019f3a532fe83b20d20f05f11de38/png?url=en.wikipedia.org%2Fwiki%2Fbookmark&thumb_width=320&quality=80'
              'face': 'http://graph.facebook.com/v2.7/10154232419354595/picture?type=square'
              'profileLink': 'https://www.facebook.com/app_scoped_user_id/10154232419354595/'
              'FromLink': 'en.wikipedia.org/wiki/bookmark'
              'ToLink': 'en.wikipedia.org/wiki/bookmark'
              'ScreenshotUrlTo': 'https://api.urlbox.io/v1/FLMG5BM3XeqMGa42/dfa731789ad019f3a532fe83b20d20f05f11de38/png?url=en.wikipedia.org%2Fwiki%2Fbookmark&thumb_width=320&quality=80'
            'author': 'S54FphiBzL3KueFF4'
            'createdAt': 1517868117818
            'title': 'Bookmarks - and other placeholders'
          'Linkstate%2Eyouiest%2Ecom%2Fabout':
            'from': 'Linkstate%2Eyouiest%2Ecom%2Fabout'
            'to': 'en%2Ewikipedia%2Eorg%2Fwiki%2Fbookmark'
            'meta':
              'title': 'Linkstate - Connecting is seeing'
              'weight': 7
              'face': 'http://graph.facebook.com/v2.7/10154232419354595/picture?type=square'
              'profileLink': 'https://www.facebook.com/app_scoped_user_id/10154232419354595/'
              'FromLink': 'Linkstate.youiest.com/about'
              'ToLink': 'en.wikipedia.org/wiki/bookmark'
              'ScreenshotUrl': 'https://api.urlbox.io/v1/FLMG5BM3XeqMGa42/7c81ff8950b76e157e44b1a70cfb81532f9a170c/png?url=Linkstate.youiest.com%2Fabout&thumb_width=320&quality=80'
              'ScreenshotUrlTo': 'https://api.urlbox.io/v1/FLMG5BM3XeqMGa42/dfa731789ad019f3a532fe83b20d20f05f11de38/png?url=en.wikipedia.org%2Fwiki%2Fbookmark&thumb_width=320&quality=80'
            'author': 'S54FphiBzL3KueFF4'
            'createdAt': 1517868117916
            'title': 'Linkstate - Connecting is seeing'
          'https%3A%2F%2Fwww%2Efacebook%2Ecom%2Fapp_scoped_user_id%2F10154232419354595%2F':
            'from': 'https%3A%2F%2Fwww%2Efacebook%2Ecom%2Fapp_scoped_user_id%2F10154232419354595%2F'
            'to': 'en%2Ewikipedia%2Eorg%2Fwiki%2Fbookmark'
            'meta':
              'title': 'Elias Moosman on Facebook'
              'weight': 7
              'face': 'http://graph.facebook.com/v2.7/10154232419354595/picture?type=square'
              'profileLink': 'https://www.facebook.com/app_scoped_user_id/10154232419354595/'
              'FromLink': 'https://www.facebook.com/app_scoped_user_id/10154232419354595/'
              'ToLink': 'en.wikipedia.org/wiki/bookmark'
              'ScreenshotUrl': 'https://api.urlbox.io/v1/FLMG5BM3XeqMGa42/9b1a5f128cbac84d2142d3377200235906e5a39e/png?url=https%3A%2F%2Fwww.facebook.com%2Fapp_scoped_user_id%2F10154232419354595%2F&thumb_width=320&quality=80'
              'ScreenshotUrlTo': 'https://api.urlbox.io/v1/FLMG5BM3XeqMGa42/dfa731789ad019f3a532fe83b20d20f05f11de38/png?url=en.wikipedia.org%2Fwiki%2Fbookmark&thumb_width=320&quality=80'
            'author': 'S54FphiBzL3KueFF4'
            'createdAt': 1517868118023
            'title': 'Elias Moosman on Facebook'
        'Linkstate%2Eyouiest%2Ecom%2Fabout': 'Linkstate%2Eyouiest%2Ecom%2Fabout':
          'from': 'Linkstate%2Eyouiest%2Ecom%2Fabout'
          'to': 'Linkstate%2Eyouiest%2Ecom%2Fabout'
          'meta':
            'title': 'Linkstate - Connecting is seeing'
            'weight': 8
            'body': 'The fate of bookmarks can tell us a lot about Linkstate'
            'face': 'http://graph.facebook.com/v2.7/10154232419354595/picture?type=square'
            'profileLink': 'https://www.facebook.com/app_scoped_user_id/10154232419354595/'
            'FromLink': 'Linkstate.youiest.com/about'
            'ToLink': 'Linkstate.youiest.com/about'
            'ScreenshotUrl': 'https://api.urlbox.io/v1/FLMG5BM3XeqMGa42/7c81ff8950b76e157e44b1a70cfb81532f9a170c/png?url=Linkstate.youiest.com%2Fabout&thumb_width=320&quality=80'
            'ScreenshotUrlTo': 'https://api.urlbox.io/v1/FLMG5BM3XeqMGa42/7c81ff8950b76e157e44b1a70cfb81532f9a170c/png?url=Linkstate.youiest.com%2Fabout&thumb_width=320&quality=80'
          'author': 'S54FphiBzL3KueFF4'
          'createdAt': 1517868117963
          'title': 'Linkstate - Connecting is seeing'
    'hits': 40
  'type': 'from'
  'word':
    'HeaderTitle': 'Linkstates for '
    'MainCardTitle': 'About '
    'MainCardSubtitle': 'Link it to something, find it there later'
    'TextAboutfloatingLabelText': 'TAB here to say something memorable. '
    'TextAboutHintText': 'Send with a 9 for dead on, 5 neutral, 1 oppose or 0 irrelevant.'
    'digitAlert': 'You send by entering a digit from 0 to 9 where 9 means dead on, 5 neutral and 1 opposite. The 0 means irrelevant.'
    'MyCardTitle': 'Your links to: '
    'MyCardSubtitle': 'Go to Bookmarks or your project page and your resources appear here'
    'MyCardStepsSubheader': 'You have connected from here recently'
    'AboutCardTitle': 'What\'s the word on this?'
    'AboutCardSubTitle': 'Connections talk. Yay sayers weigh in on the right.'
    'to': 'to '
    'defaultProject': 'Your last project was '
    'defaultStart': 'Last on '
    'ToTooltipText': 'TO - Point TO it to something about it.'
    'FromTooltipText': 'FROM - The place we\'re on now. Below are your bookmarks about this place.'

describe 'Options', ->
  options = setOptions(props)
  it 'should return right sized array', ->
    expect(Array.isArray options).to.equal true
    expect(options.length).to.equal(3)
  it 'sorts the options', ->
    p = (x) -> options[x].value.createdAt#.meta.weight
    i = 1
    while i < options.length
        expect(p i-1).to.be.above(p i)
        i++
# why does it sometimes not give the right option? test lastValue, lastFrom etc
describe 'Value', ->
  value = setValue(props, setOptions(props), user)
  it 'returns an object with label', ->
    expect(typeof value).to.equal 'object'
    expect(typeof value.label).to.equal 'string'
  it.only 'returns user.toLast if type is to and queryparm has no to', ->
    user2 = Object.assign {}, user
    props2 = Object.assign {}, props,
      to: null
      type: 'to'
    value = setValue(props2, setOptions(props2), user2)
    userValue = linkstate.store props.user.toLast
    console.log value.value.from
    console.log value.value.from is userValue, userValue
    expect(props2.to).to.equal null
    expect(typeof value.label).to.equal 'string'
    expect(value.value.from).to.equal userValue
  it 'works with worse state', ->
    {props,options,user} = badWindowState
    props.type = 'from'
    bookmarks =  user.links.in.Bookmarks
    fEx = props.from in bookmarks
    console.log fEx
    value3 = setValue props, options, user
    console.log props[props.type]
    # what we want value to reflect
    lab = (l) -> _.get l, 'value'
    values = _.map options, lab
    fr = (v) -> linkstate.see _.get v, 'from'
    fro = _.map values, fr
    console.log _.filter options, (v) -> v.value.FromLink is props[props.type]
    console.log options.length, fro.length
    console.log fro
    console.log linkstate.store(props.to) in fro
    console.log value3, props.type
    expect(!value3.label).to.equal(false)
  it 'fails with selectedProps', ->
    value2 = setValue(selectedProps,setOptions(selectedProps), selectedProps.user)


describe 'savesParam', ->
  it 'returns same object if no localStorage exist', ->
