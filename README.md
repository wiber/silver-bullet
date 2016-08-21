# Hashrepublic of linkstates

To understand this tool just imagine bookmarks as links between two pages instead of as something you stash in a folder and never look at again. When you newtab away from a page we can show you relevant information such as related bookmarks, recent pages and critically what other users associate with the page. These Bookmarks are links or associations and have weights to indicate their relevance. Imagine linking articles to your friends facebook page.

At it's heart Hashrepublic seeks to make your life easier, less scattered and more in the zone by giving you context. Trust the journey by trusting your past. This is easier when you see clearly the path behind you. It's the path behind you just like Morpheus said. Bookmarks related to your google document are right there when you newtab. Magic. You'll love context because it gets you the right things at the right time.

All links are public webpages in the beginning. Privacy is coming as a paid feature. Ads will be done tastefully or not at all. The newtab view has great potential for effective ad space in an app such as this one because of the rich context. Ads can target your last page, your last pages, even predict your next step on the journey. Done right they won't have to fight for your attention like traditional ads. They will feel natural like a possible next step when you're already ready to take a step.

# Why you could care
If this tool is useful for one person because of how it allows one to keep things relevant it's infinitely more useful when working together. When used socially this becomes a whole new thing entirely. Associations tell you about what others think of this place and where it fits in.

# A scenario for you
Being the learned web researcher that you are you come across some extrordinary claims that just might be the thing to help make a project great. Is it too good to be true? Perhaps. With a simple ctrl T in your browser you jump through time and space to this page. A page about the page you were on. A page just created. A page yet to be. From this place you see that you're not the first person to have thoughts about this place. A previous traveller has connected this place with a scientific paper on the subject. The really interesting thing is how the traveller weighed in on the association. The traveller states in his message that the paper strongly, with weight 2 or that is 5-3=2, argues against the articles on page five and that he finds this point salient. The travellers profile confirms that he's competent in the field. Bummer... Perhaps it was too good to be true. But wait! This wasn't the only user here. Perhaps there is hope yet...

In this scenario a user examines associations to an article. In a simple and structured way arguments are evaluated for and against a thing. When this game is played with known authorities it gets really interesting.

What's really interesting about this link is that


This tool is useful for one person as a way to keep things relevant because of

this author has taken the time to think

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


Then load the extension into chrome.



#### Todos
- [ ] one-liner installs dependencies. Does this work for you?
- [x] chrome addon scaffolds your attention
    - [x] newtab opens app in iframe with last page you were on in queryparam
    - [ ] faster and thus more reliable remembering of last tab.
- [ ] see all your bookmarks visualized
  - [ ] as links from the last tab you were on before newtab
  - [ ] as last tabs your were on before you made a newtab
  - [ ] as steps out of the past
  - [ ] as a map

#### Aims
- [x] Fast Prototyping
  - [x] write all code in one language.
  - [x] tidy modules decoupled from meteor.
  - [ ] one-liner to clone and run
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
