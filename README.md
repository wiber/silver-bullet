# Silver-Bullet -> the art of espresso

I'm told the silver bullet is a coffee variant engineered with ~4 shots of expresso, butter and coconut oil. It also goes great with cacao and kills wearwolves. I'll understand if it's not your thing.

It's also an awesome boilerplate for meteor.

### Installation:

If you haven't already:

 curl https://install.meteor.com/ | sh

git clone https://github.com/wiber/silver-bullet && cd silver-bullet && meteor npm install && meteor
- [x] means commited, [0-9] is a weight


#### Todos
- [x] chrome addon scaffolds your attention
    - [x] newtab opens app in iframe with last page you were on in queryparam
- [ ] functional db structure for create and show documents
- [ ] see all my bookmarks visualized
  - [ ] as steps out of the past
  - [ ] as a map

#### Aims
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
