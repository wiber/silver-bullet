{AByMomentum, listByMomentum} = require('../imports/api/strings')
#{AByMomentum} = require('../imports/strings')
chai = require('chai')
expect = chai.expect
assert = chai.assert
R = require 'ramda'
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
        'face': 'https://graph.facebook.com/v2.7/10154232419354595/picture?type=square'
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
        'face': 'https://graph.facebook.com/v2.7/10154232419354595/picture?type=square'
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
        'face': 'https://graph.facebook.com/v2.7/10154232419354595/picture?type=square'
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
        'face': 'https://graph.facebook.com/v2.7/10154232419354595/picture?type=square'
        'profileLink': 'https://www.facebook.com/app_scoped_user_id/10154232419354595/'
        'FromLink': 'https://www.material-ui.com/v0.15.0/#/'
        'ToLink': 'Bookmarks'
        'ScreenshotUrl': 'https://api.thumbalizr.com/?url=https://www.material-ui.com/v0.15.0/#/&width=250&api_key=5VmUR42gc4eGdLjBnZH2BRXa'
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
      'face': 'https://graph.facebook.com/v2.7/10154232419354595/picture?type=square'
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
        'face': 'https://graph.facebook.com/v2.7/10154232419354595/picture?type=square'
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
        'face': 'https://graph.facebook.com/v2.7/10154232419354595/picture?type=square'
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
        'face': 'https://graph.facebook.com/v2.7/10154232419354595/picture?type=square'
        'profileLink': 'https://www.facebook.com/app_scoped_user_id/10154232419354595/'
        'FromLink': 'https://www.material-ui.com/v0.15.0/#/'
        'ToLink': 'Bookmarks'
        'ScreenshotUrl': 'https://api.thumbalizr.com/?url=https://www.material-ui.com/v0.15.0/#/&width=250&api_key=5VmUR42gc4eGdLjBnZH2BRXa'
        'ScreenshotUrlTo': 'https://api.thumbalizr.com/?url=Bookmarks&width=250&api_key=5VmUR42gc4eGdLjBnZH2BRXa'
      'author': 'cqWYJrZCGeWoPc68T'
      'createdAt': 1486799850384
      'title': 'Material-UI'
    'http%3A%2F%2Fwww%2Ematerial-ui%2Ecom%2Fv0%2E15%2E0-alpha%2E2%2F%23%2F': 'Elias Moosman':
      'from': 'http%3A%2F%2Fwww%2Ematerial-ui%2Ecom%2Fv0%2E15%2E0-alpha%2E2%2F%23%2F'
      'to': 'Bookmarks'
      'meta':
        'title': 'Material-UI'
        'face': 'https://graph.facebook.com/v2.7/10154232419354595/picture?type=square'
        'profileLink': 'https://www.facebook.com/app_scoped_user_id/10154232419354595/'
        'FromLink': 'https://www.material-ui.com/v0.15.0-alpha.2/#/'
        'ToLink': 'Bookmarks'
        'ScreenshotUrl': 'https://api.thumbalizr.com/?url=https://www.material-ui.com/v0.15.0-alpha.2/#/&width=250&api_key=5VmUR42gc4eGdLjBnZH2BRXa'
        'ScreenshotUrlTo': 'https://api.thumbalizr.com/?url=Bookmarks&width=250&api_key=5VmUR42gc4eGdLjBnZH2BRXa'
      'author': 'cqWYJrZCGeWoPc68T'
      'createdAt': 1486799938150
      'title': 'Material-UI'
    'http%3A%2F%2Fwww%2Espeedtest%2Enet%2F': 'Elias Moosman':
      'from': 'http%3A%2F%2Fwww%2Espeedtest%2Enet%2F'
      'to': 'Bookmarks'
      'meta':
        'title': 'Speedtest.net by Ookla - The Global Broadband Speed Test'
        'face': 'https://graph.facebook.com/v2.7/10154232419354595/picture?type=square'
        'profileLink': 'https://www.facebook.com/app_scoped_user_id/10154232419354595/'
        'FromLink': 'https://www.speedtest.net/'
        'ToLink': 'Bookmarks'
        'ScreenshotUrl': 'https://api.thumbalizr.com/?url=https://www.speedtest.net/&width=250&api_key=5VmUR42gc4eGdLjBnZH2BRXa'
        'ScreenshotUrlTo': 'https://api.thumbalizr.com/?url=Bookmarks&width=250&api_key=5VmUR42gc4eGdLjBnZH2BRXa'
      'author': 'cqWYJrZCGeWoPc68T'
      'createdAt': 1486992184075
      'title': 'Speedtest.net by Ookla - The Global Broadband Speed Test'
    'https%3A%2F%2Fforums%2Emeteor%2Ecom%2Ft%2Freact-accounts-ui-user-login-components%2F14078%2F5': 'Elias Moosman':
      'from': 'https%3A%2F%2Fforums%2Emeteor%2Ecom%2Ft%2Freact-accounts-ui-user-login-components%2F14078%2F5'
      'to': 'Bookmarks'
      'meta':
        'title': 'React accounts-ui / user / login components? - react - Meteor forums'
        'face': 'https://graph.facebook.com/v2.7/10154232419354595/picture?type=square'
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
        'face': 'https://graph.facebook.com/v2.7/10154232419354595/picture?type=square'
        'profileLink': 'https://www.facebook.com/app_scoped_user_id/10154232419354595/'
        'FromLink': 'https://localhost:3000/about?Bookmarked=true&content=&to=https%3A%2F%2Fwww.facebook.com%2Fapp_scoped_user_id%2F10154232419354595%2F&from=http%3A%2F%2Fwww.material-ui.com%2Fv0.15.0-alpha.2%2F%23%2F'
        'ToLink': 'Bookmarks'
        'ScreenshotUrl': 'https://api.thumbalizr.com/?url=https://localhost:3000/about?Bookmarked=true&content=&to=https%3A%2F%2Fwww.facebook.com%2Fapp_scoped_user_id%2F10154232419354595%2F&from=http%3A%2F%2Fwww.material-ui.com%2Fv0.15.0-alpha.2%2F%23%2F&width=250&api_key=5VmUR42gc4eGdLjBnZH2BRXa'
        'ScreenshotUrlTo': 'https://api.thumbalizr.com/?url=Bookmarks&width=250&api_key=5VmUR42gc4eGdLjBnZH2BRXa'
      'author': 'cqWYJrZCGeWoPc68T'
      'createdAt': 1487164253429
      'title': 'localhost:3000/about?Bookmarked=true&content=&to=https%3A%2F%2Fwww.facebook.com%2Fapp_scoped_user_id%2F10154232419354595%2F&from=http%3A%2F%2Fwww.material-ui.com%2Fv0.15.0-alpha.2%2F%23%2F'
    'http%3A%2F%2Fxixixao%2Egithub%2Eio%2Fprelude-ls%2F%23f-compose': 'Elias Moosman':
      'from': 'http%3A%2F%2Fxixixao%2Egithub%2Eio%2Fprelude-ls%2F%23f-compose'
      'to': 'Bookmarks'
      'meta':
        'title': 'prelude.coffee - a JavaScript functional programming library - for and in CoffeeScript'
        'face': 'https://graph.facebook.com/v2.7/10154232419354595/picture?type=square'
        'profileLink': 'https://www.facebook.com/app_scoped_user_id/10154232419354595/'
        'FromLink': 'https://xixixao.github.io/prelude-ls/#f-compose'
        'ToLink': 'Bookmarks'
        'ScreenshotUrl': 'https://api.thumbalizr.com/?url=https://xixixao.github.io/prelude-ls/#f-compose&width=250&api_key=5VmUR42gc4eGdLjBnZH2BRXa'
        'ScreenshotUrlTo': 'https://api.thumbalizr.com/?url=Bookmarks&width=250&api_key=5VmUR42gc4eGdLjBnZH2BRXa'
      'author': 'cqWYJrZCGeWoPc68T'
      'createdAt': 1487067079661
      'title': 'prelude.coffee - a JavaScript functional programming library - for and in CoffeeScript'
    'http%3A%2F%2Fwww%2Ematerial-ui%2Ecom%2Fv0%2E15%2E0-alpha%2E2%2F%23%2Fcomponents%2Ftoolbar': 'Elias Moosman':
      'from': 'http%3A%2F%2Fwww%2Ematerial-ui%2Ecom%2Fv0%2E15%2E0-alpha%2E2%2F%23%2Fcomponents%2Ftoolbar'
      'to': 'Bookmarks'
      'meta':
        'title': 'Toolbar - Material-UI'
        'face': 'https://graph.facebook.com/v2.7/10154232419354595/picture?type=square'
        'profileLink': 'https://www.facebook.com/app_scoped_user_id/10154232419354595/'
        'FromLink': 'https://www.material-ui.com/v0.15.0-alpha.2/#/components/toolbar'
        'ToLink': 'Bookmarks'
        'ScreenshotUrl': 'https://api.thumbalizr.com/?url=https://www.material-ui.com/v0.15.0-alpha.2/#/components/toolbar&width=250&api_key=5VmUR42gc4eGdLjBnZH2BRXa'
        'ScreenshotUrlTo': 'https://api.thumbalizr.com/?url=Bookmarks&width=250&api_key=5VmUR42gc4eGdLjBnZH2BRXa'
      'author': 'cqWYJrZCGeWoPc68T'
      'createdAt': 1487084924408
      'title': 'Toolbar - Material-UI'
    'https%3A%2F%2Fgithub%2Ecom%2Fjunegunn%2Ffzf': 'Elias Moosman':
      'from': 'https%3A%2F%2Fgithub%2Ecom%2Fjunegunn%2Ffzf'
      'to': 'Bookmarks'
      'meta':
        'title': 'junegunn/fzf: A command-line fuzzy finder written in Go'
        'face': 'https://graph.facebook.com/v2.7/10154232419354595/picture?type=square'
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
        'face': 'https://graph.facebook.com/v2.7/10154232419354595/picture?type=square'
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
        'face': 'https://graph.facebook.com/v2.7/10154232419354595/picture?type=square'
        'profileLink': 'https://www.facebook.com/app_scoped_user_id/10154232419354595/'
        'FromLink': 'https://localhost:3000/about?Bookmarked=true&content=&to=https%3A%2F%2Fwww.facebook.com%2Fapp_scoped_user_id%2F10154232419354595%2F&from=Bookmarks'
        'ToLink': 'Bookmarks'
        'ScreenshotUrl': 'https://api.thumbalizr.com/?url=https://localhost:3000/about?Bookmarked=true&content=&to=https%3A%2F%2Fwww.facebook.com%2Fapp_scoped_user_id%2F10154232419354595%2F&from=Bookmarks&width=250&api_key=5VmUR42gc4eGdLjBnZH2BRXa'
        'ScreenshotUrlTo': 'https://api.thumbalizr.com/?url=Bookmarks&width=250&api_key=5VmUR42gc4eGdLjBnZH2BRXa'
      'author': 'cqWYJrZCGeWoPc68T'
      'createdAt': 1487172340036
      'title': 'localhost:3000/about?Bookmarked=true&content=&to=https%3A%2F%2Fwww.facebook.com%2Fapp_scoped_user_id%2F10154232419354595%2F&from=Bookmarks'
    'https%3A%2F%2Fwww%2Enpmjs%2Ecom%2Fpackage%2Framda': 'Elias Moosman':
      'from': 'https%3A%2F%2Fwww%2Enpmjs%2Ecom%2Fpackage%2Framda'
      'to': 'Bookmarks'
      'meta':
        'title': 'ramda'
        'face': 'https://graph.facebook.com/v2.7/10154232419354595/picture?type=square'
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
        'face': 'https://graph.facebook.com/v2.7/10154232419354595/picture?type=square'
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
        'face': 'https://graph.facebook.com/v2.7/10154232419354595/picture?type=square'
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
        'face': 'https://graph.facebook.com/v2.7/10154232419354595/picture?type=square'
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
        'face': 'https://graph.facebook.com/v2.7/10154232419354595/picture?type=square'
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
        'face': 'https://graph.facebook.com/v2.7/10154232419354595/picture?type=square'
        'profileLink': 'https://www.facebook.com/app_scoped_user_id/10154232419354595/'
        'FromLink': 'https://localhost:3000/about?Bookmarked=true&content=&to=https%3A%2F%2Fwww.facebook.com%2Fapp_scoped_user_id%2F10154232419354595%2F&from=Bookmarks'
        'ToLink': 'https://github.com/junegunn/vim-plug'
        'ScreenshotUrl': 'https://api.thumbalizr.com/?url=https://localhost:3000/about?Bookmarked=true&content=&to=https%3A%2F%2Fwww.facebook.com%2Fapp_scoped_user_id%2F10154232419354595%2F&from=Bookmarks&width=250&api_key=5VmUR42gc4eGdLjBnZH2BRXa'
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
        'face': 'https://graph.facebook.com/v2.7/10154232419354595/picture?type=square'
        'profileLink': 'https://www.facebook.com/app_scoped_user_id/10154232419354595/'
        'FromLink': 'https://localhost:3000/about?Bookmarked=true&content=&to=https%3A%2F%2Fwww.facebook.com%2Fapp_scoped_user_id%2F10154232419354595%2F&from=http%3A%2F%2Fwww.material-ui.com%2Fv0.15.0-alpha.2%2F%23%2F'
        'ToLink': 'https://github.com/junegunn/vim-plug'
        'ScreenshotUrl': 'https://api.thumbalizr.com/?url=https://localhost:3000/about?Bookmarked=true&content=&to=https%3A%2F%2Fwww.facebook.com%2Fapp_scoped_user_id%2F10154232419354595%2F&from=http%3A%2F%2Fwww.material-ui.com%2Fv0.15.0-alpha.2%2F%23%2F&width=250&api_key=5VmUR42gc4eGdLjBnZH2BRXa'
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
        'face': 'https://graph.facebook.com/v2.7/10154232419354595/picture?type=square'
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
        'face': 'https://graph.facebook.com/v2.7/10154232419354595/picture?type=square'
        'profileLink': 'https://www.facebook.com/app_scoped_user_id/10154232419354595/'
        'FromLink': 'https://www.material-ui.com/v0.15.0-alpha.2/#/components/toolbar'
        'ToLink': 'https://github.com/junegunn/vim-plug'
        'ScreenshotUrl': 'https://api.thumbalizr.com/?url=https://www.material-ui.com/v0.15.0-alpha.2/#/components/toolbar&width=250&api_key=5VmUR42gc4eGdLjBnZH2BRXa'
        'ScreenshotUrlTo': 'https://api.thumbalizr.com/?url=https://github.com/junegunn/vim-plug&width=250&api_key=5VmUR42gc4eGdLjBnZH2BRXa'
      'author': 'cqWYJrZCGeWoPc68T'
      'createdAt': 1488001354915
      'title': 'https://github.com/junegunn/vim-plug'

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
