# Hashrepublic of linkstates

To understand this tool just imagine bookmarks as links between two pages instead of as something you stash in a folder and never look at again. This way when you newtab away from a page we can show you relevant entries and even your recent history. These links are associations with different weights. Think linking a recipy to your friends facebook page as a warm recommendation. Should they perhaps be notified?

At it's heart Hashrepublic seeks to make you smarter by offering you context. See the path behind you to trust your next step. Just like Morpheus said. Bookmarks related to your google document are right there when you newtab. Magic. You'll love context.

All links are public webpages in the beginning. Privacy is coming as a paid feature. Ads will be done tastefully or not at all. The newtab view has great potential for ad space in an app like this one because of the rich context. Ads can target your last page, your last pages, even predict your next step on the journey. Done right they won't have to fight for your attention like traditional ads. They will feel natural like a possible next step when you're already ready to take a step.



### Installation:

If you haven't already:
```
 curl https://install.meteor.com/ | sh

git clone https://github.com/wiber/silver-bullet

touch imports/startup/configs/serviceconfiguration.js
```

##### imports/startup/configs/serviceconfiguration.js looks like this
``` javascript
// imports/startup/configs/serviceconfiguration.js
// changes gitignored
Meteor.startup(function(){
    ServiceConfiguration.configurations.upsert( {
      service: "facebook"
    }, {
      $set: {
        appId: "xxxxxx",
        secret: "xxxxxxx"
      }
    } );
});
```

Next install missing npm modules like react, react-dom, react-selectize. FIXME.


Then load the chrome extension.



#### Todos
- [ ] one-liner installs dependencies. Does this work for you?
- [x] chrome addon scaffolds your attention
    - [x] newtab opens app in iframe with last page you were on in queryparam
- [ ] functional db structure for create and show documents
- [ ] see all my bookmarks visualized
  - [ ] as steps out of the past
  - [ ] as a map

#### Aims
- [x] Fast Prototyping
  - [x] write all code in one language.
  - [x] tidy modules decoupled from meteor.
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

##### Choices
- [ ] business goals
  - [ ] hustle to build seo
    - [ ] legitimately own your about-site
    - [ ] advocate and engage people who sidewiki your stuff
  - [x] pay for privacy
  - [x] relatable ads on my newtab because I'm going places
  - [ ] beatiful photography on my newtab
- [ ] usability goals
  - [9] useful
    - [x] bookmarks
      - [x] for momentum
      - [ ] for sharing
      - [ ] for about me
    - [ ] aboutness
      - [ ] links about me
      - [x] comments about here
      - [x] what are people saying about that page I was just on?
    - [x] scaffold
      - [ ] meta research
        - [x] link articles to my drive document
        - [ ] read tidbits on same page as you type
        - [x] newtab to see related articles closetab to return to document
      - [ ] discipline tool on my newtab
        - [ ] todos on
        - [ ] main focus for this sprint
  - [7] easy
    - [x] keyboard creation of points
    - [ ] google searchable
    - [ ] past url
    - [ ] dali clocks visualized
      - [x] this is effin 730p - bedtime!
- [8] implementation choices
  - [8] qualities
    - [x] seo
    - [6] ssr - not critical - meteor.com ...
    - [ ] what you see is what I see
    - [x] responsive and light
    - [ ] mobile
    - [x] futuristic and idealistic
    - [x] omnipresent
    - [ ] continous implementation
    - [7] network visualisation
  - [5] frameworks
    - [ ] mantra
      - [ ] no ssr on meteor.com
    - [ ] redux maintainability
    - [ ] wallaby
    - [x] silver-bullet
