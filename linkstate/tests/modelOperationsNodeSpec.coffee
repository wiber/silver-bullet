{AByMomentum, listByMomentum} = require('../imports/api/strings')
{setOptions, setValue} = require('../imports/api/ModelOperations')
chai = require('chai')
expect = chai.expect
assert = chai.assert
R = require 'ramda'
Lo = require 'lodash'
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
  'to': 'Linkstate.youiest.com'
  'lastTitle': 'Icon Button - Material-UI'
  'user':
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
  'type': 'to'
  'newHere': false
user =
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


describe 'Options', ->
  options = setOptions(props)
  it 'should return right sized array', ->
    expect(Array.isArray options).to.equal true
    expect(options.length).to.equal(4)
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

# why does it sometimes not work when coming from a place? need to stub methods..

describe 'Momentum', ->
  it 'should return an array of two length', ->
    Momentum = AByMomentum realData
    expect(Momentum.length).to.equal(3)
  it 'should return correct array', ->
    Momentum = AByMomentum urlData
    expect(Momentum).to.deep.equal(['url3','url2','url1'])

describe 'listMomentum', ->
  inOutMomentum = listByMomentum(AByMomentum(urlData),AByMomentum(realData))
  it 'should return an array of 5 length', ->
    expect(inOutMomentum.length).to.equal(5)
  it 'should return correct array', ->
    expect(inOutMomentum).to.deep.equal [
      'url3',
      'url2',
      'url1',
      # due to uniq filtering forward to back, url1 keeps it's [3] position correctly.
      # url1 has more momentum going it, but doesn't help in this example
      'https%3A%2F%2Fwww%2Efacebook%2Ecom%2Fapp_scoped_user_id%2F10154232419354595%2F',
      'http%3A%2F%2Fwww%2Ematerial-ui%2Ecom%2Fv0%2E15%2E0%2F%23%2F'
      ]
  it 'should return even if a list is undefined', ->
    expect(listByMomentum(undefined,AByMomentum(realData)).length).to.equal(3)
  it 'should even if no momentum', ->
    expect(listByMomentum(AByMomentum(realNode.in),AByMomentum(realNode.out)).length).to.equal(13)

describe 'backlinks algebra', ->
  it 'should return 6', ->
    expect(listByMomentum(AByMomentum(inout.in), AByMomentum(inout.out)).length).to.equal(6)
  it 'order should affect length', ->
    expect(listByMomentum(AByMomentum(inout.in), AByMomentum(inout.out)).length)
    .to
    .equal(listByMomentum(AByMomentum(inout.out),AByMomentum(inout.in)).length)
