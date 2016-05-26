# Silver-Bullet -> the art of espresso

I'm told the silver bullet is a coffee variant engineered with ~4 shots of expresso, butter and coconut oil. It also goes great with cacao and kills wearwolves. I'll understand if it's not your thing.

It's also an awesome boilerplate for meteor.

## Installation:

If you haven't already:

 curl https://install.meteor.com/ | sh

git clone https://github.com/wiber/silver-bullet && cd silver-bullet && meteor npm install && meteor

Aims
- [x] Fast Prototyping
  - [x] write all code in one language.
  - [x] tidy modules independant from meteor.
  - [ ] one-liner to clone, run and open in vim
- [ ] Code, UI and Styles in Coffeescript.
  - [x] material-ui
  - [x] react-kup because otherwise this is not that.
  - [x] meteorJS
  - [x] instead of css do _.extend {}, style.h1
  - [ ] wallaby.js runs tests continously
  - [ ] meteor -test--fullApp
- [x] Serverside Rendering by kadira:flowrouter-ssr
- [ ] App-State on the queryParam
  - [x] Expanded Sections
  - [x] react-selectise defaultValue
  - [ ] Scroll Position on queryparam
- [ ] chrome addon scaffolds your attention
  - [ ] newtab is about the last page you were on
