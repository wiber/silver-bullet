# Hashrepublic of linkstates

Think of linkstates as your superpower. Copmare it to the alien language in the movie arrival but instead of seeing the future it opens other doors. We call this ability wibing and it's both a very simple yet open ended activity. It occuppies the intersection of information overload, many-to-many communication and why you never return to look through your bookmarks. Think the structure that makes catching up on a reply-all chain a pain.

To use try this out in the wild you'll need the chrome extension: https://drive.google.com/open?id=0BxESHlfBQRFGazlwYzVYaThRczA

So what do you do with this visual-language-superpower? Well it's really up to you. Linkstates is an activity primarily for students, research teams and project managers. Since nobody uses bookmarking anymore Linkstates makes it easy to organizes web things in the context related to other web things.

once you learn it reshapes the way you and your group make sense.

What if ... making sense of the world got you in the zone. Youiest believes that the right kind of context makes the difference.

Imagine all those loose ends in your fragmented world articles, videos, white papers and factiods were collaboratively combined. This idea isn't new but linkstates goes all in on a new angle. Call it texture. What to pay attention to is easier when a known face weighs in or suggests other points of interest. If something looks too good to be true a newtab from that page may have a better informed user referencing a credible opposing view.

A student collects organizes sources and quotes while doing online research. An organisation brands itself by endorsing articles, press releases or other things that share it's values. That same organisation tells the world what it's not about by distancing itself from an aspect of an event, organisation or article. As others weigh in on these sources or stories context emerges.

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
### Run

meteor --settings settings.json

### Deploy

DEPLOY_HOSTNAME=us-east-1.galaxy-deploy
.meteor.com meteor deploy linkstate.youiest.com --settings Gsettings.json
#### Todos
- [ ] Uppgrade deps from https://v0.material-ui.com/v0.15.0-alpha.2/#/components/app-bar
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
  - [ ] beatiful photography on my newtab vs snapshot of prior tab
  - [ ] store that odd page as a pdf for later, just in case
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


my current npm list output:
    silver-bullet@0.1.0
    ├─┬ @babel/runtime@7.3.1
    │ └── regenerator-runtime@0.12.1
    ├─┬ @material-ui/core@3.9.2
    │ ├── @babel/runtime@7.3.1 deduped
    │ ├─┬ @material-ui/system@3.0.0-alpha.2
    │ │ ├── @babel/runtime@7.3.1 deduped
    │ │ ├── deepmerge@3.2.0 deduped
    │ │ ├── prop-types@15.6.0 deduped
    │ │ └─┬ warning@4.0.3
    │ │   └── loose-envify@1.3.1 deduped
    │ ├─┬ @material-ui/utils@3.0.0-alpha.3
    │ │ ├── @babel/runtime@7.3.1 deduped
    │ │ ├── prop-types@15.6.0 deduped
    │ │ └── react-is@16.8.3 deduped
    │ ├─┬ @types/jss@9.5.7
    │ │ ├── csstype@2.6.2 deduped
    │ │ └─┬ indefinite-observable@1.0.2
    │ │   └── symbol-observable@1.2.0 deduped
    │ ├─┬ @types/react-transition-group@2.0.16
    │ │ └─┬ @types/react@16.8.5
    │ │   ├── @types/prop-types@15.5.9
    │ │   └── csstype@2.6.2 deduped
    │ ├── brcast@3.0.1
    │ ├── classnames@2.2.6
    │ ├── csstype@2.6.2
    │ ├── debounce@1.2.0
    │ ├── deepmerge@3.2.0
    │ ├── dom-helpers@3.2.1
    │ ├─┬ hoist-non-react-statics@3.3.0
    │ │ └── react-is@16.8.3
    │ ├─┬ is-plain-object@2.0.4
    │ │ └── isobject@3.0.1
    │ ├─┬ jss@9.8.7
    │ │ ├── is-in-browser@1.1.3
    │ │ ├── symbol-observable@1.2.0 deduped
    │ │ └── warning@3.0.0 deduped
    │ ├─┬ jss-camel-case@6.1.0
    │ │ └── hyphenate-style-name@1.0.2 deduped
    │ ├── jss-default-unit@8.0.2
    │ ├── jss-global@3.0.0
    │ ├─┬ jss-nested@6.0.1
    │ │ └── warning@3.0.0 deduped
    │ ├── jss-props-sort@6.0.0
    │ ├─┬ jss-vendor-prefixer@7.0.0
    │ │ └─┬ css-vendor@0.3.8
    │ │   └── is-in-browser@1.1.3 deduped
    │ ├── normalize-scroll-left@0.1.2
    │ ├── popper.js@1.14.7
    │ ├─┬ prop-types@15.6.0
    │ │ ├─┬ fbjs@0.8.16
    │ │ │ ├── core-js@1.2.7 deduped
    │ │ │ ├── isomorphic-fetch@2.2.1 deduped
    │ │ │ ├── loose-envify@1.3.1 deduped
    │ │ │ ├── object-assign@4.1.1 deduped
    │ │ │ ├── promise@7.3.1 deduped
    │ │ │ ├── setimmediate@1.0.5 deduped
    │ │ │ └── ua-parser-js@0.7.17 deduped
    │ │ ├── loose-envify@1.3.1 deduped
    │ │ └── object-assign@4.1.1 deduped
    │ ├─┬ react-event-listener@0.6.6
    │ │ ├── @babel/runtime@7.3.1 deduped
    │ │ ├── prop-types@15.6.0 deduped
    │ │ └── warning@4.0.3 deduped
    │ ├─┬ react-transition-group@2.6.0
    │ │ ├─┬ dom-helpers@3.4.0
    │ │ │ └── @babel/runtime@7.3.1 deduped
    │ │ ├─┬ loose-envify@1.4.0
    │ │ │ └── js-tokens@3.0.2 deduped
    │ │ ├─┬ prop-types@15.7.2
    │ │ │ ├── loose-envify@1.4.0 deduped
    │ │ │ ├── object-assign@4.1.1 deduped
    │ │ │ └── react-is@16.8.3 deduped
    │ │ └── react-lifecycles-compat@3.0.4
    │ ├─┬ recompose@0.30.0
    │ │ ├── @babel/runtime@7.3.1 deduped
    │ │ ├── change-emitter@0.1.6
    │ │ ├── fbjs@0.8.16 deduped
    │ │ ├── hoist-non-react-statics@2.5.5
    │ │ ├── react-lifecycles-compat@3.0.4 deduped
    │ │ └── symbol-observable@1.2.0
    │ └─┬ warning@4.0.3
    │   └── loose-envify@1.3.1 deduped
    ├─┬ chai@3.5.0
    │ ├── assertion-error@1.1.0
    │ ├─┬ deep-eql@0.1.3
    │ │ └── type-detect@0.1.1
    │ └── type-detect@1.0.0
    ├─┬ copy-to-clipboard@3.0.8
    │ └── toggle-selection@1.0.6
    ├─┬ create-react-class@15.6.2
    │ ├── fbjs@0.8.16 deduped
    │ ├─┬ loose-envify@1.3.1
    │ │ └── js-tokens@3.0.2
    │ └── object-assign@4.1.1
    ├─┬ fbjs@0.8.16
    │ ├── core-js@1.2.7
    │ ├─┬ isomorphic-fetch@2.2.1
    │ │ ├─┬ node-fetch@1.7.3
    │ │ │ ├─┬ encoding@0.1.12
    │ │ │ │ └── iconv-lite@0.4.19
    │ │ │ └── is-stream@1.1.0
    │ │ └── whatwg-fetch@2.0.3
    │ ├── loose-envify@1.3.1 deduped
    │ ├── object-assign@4.1.1 deduped
    │ ├─┬ promise@7.3.1
    │ │ └── asap@2.0.6
    │ ├── setimmediate@1.0.5
    │ └── ua-parser-js@0.7.17
    ├── graceful-fs@4.1.11
    ├── hyphenate-style-name@1.0.2
    ├─┬ invariant@2.2.4
    │ └── loose-envify@1.3.1 deduped
    ├── lodash@4.17.11
    ├─┬ material-ui@0.15.0-alpha.2
    │ ├─┬ inline-style-prefixer@1.0.4
    │ │ ├── bowser@1.9.4
    │ │ └── inline-style-prefix-all@2.0.2
    │ ├── keycode@2.2.0
    │ ├── lodash.flowright@3.5.0
    │ ├── lodash.merge@4.6.1
    │ ├── lodash.throttle@4.1.1
    │ ├── UNMET PEER DEPENDENCY react@^0.14.8
    │ ├── react-addons-create-fragment@0.14.8
    │ ├── react-addons-pure-render-mixin@0.14.8
    │ ├── react-addons-transition-group@0.14.8
    │ ├── react-addons-update@0.14.8
    │ ├── react-event-listener@0.1.2
    │ ├─┬ recompose@0.15.1
    │ │ ├── hoist-non-react-statics@1.2.0
    │ │ └── lodash@4.17.11 deduped
    │ ├── simple-assign@0.1.0
    │ └─┬ warning@2.1.0
    │   └── loose-envify@1.3.1 deduped
    ├─┬ material-ui-build@0.20.2 (git+https://github.com/mui-org/material-ui.git#1b1c1fce216b5b2f5ecd52d21f8ec6a326c00cd5)
    │ ├─┬ babel-runtime@6.26.0
    │ │ ├── core-js@2.5.1
    │ │ └── regenerator-runtime@0.11.0
    │ ├─┬ inline-style-prefixer@3.0.8
    │ │ ├── bowser@1.9.4 deduped
    │ │ └─┬ css-in-js-utils@2.0.1
    │ │   ├── hyphenate-style-name@1.0.2 deduped
    │ │   └── isobject@3.0.1 deduped
    │ ├── keycode@2.2.0 deduped
    │ ├── lodash.merge@4.6.1 deduped
    │ ├── lodash.throttle@4.1.1 deduped
    │ ├── prop-types@15.6.0 deduped
    │ ├─┬ react-event-listener@0.6.6
    │ │ ├── @babel/runtime@7.3.1 deduped
    │ │ ├── prop-types@15.6.0 deduped
    │ │ └─┬ warning@4.0.3
    │ │   └── loose-envify@1.3.1 deduped
    │ ├─┬ react-transition-group@1.2.1
    │ │ ├── chain-function@1.0.0
    │ │ ├── dom-helpers@3.2.1 deduped
    │ │ ├── loose-envify@1.3.1 deduped
    │ │ ├── prop-types@15.6.0 deduped
    │ │ └── warning@3.0.0 deduped
    │ ├─┬ recompose@0.26.0
    │ │ ├── change-emitter@0.1.6 deduped
    │ │ ├── fbjs@0.8.16 deduped
    │ │ ├── hoist-non-react-statics@2.5.5
    │ │ └── symbol-observable@1.2.0 deduped
    │ ├── simple-assign@0.1.0 deduped
    │ └─┬ warning@3.0.0
    │   └── loose-envify@1.3.1 deduped
    ├─┬ meteor-node-stubs@0.2.11
    │ ├─┬ assert@1.4.1
    │ │ └── util@0.10.3 deduped
    │ ├─┬ browserify-zlib@0.1.4
    │ │ └── pako@0.2.9
    │ ├─┬ buffer@4.9.1
    │ │ ├── base64-js@1.2.0
    │ │ ├── ieee754@1.1.8
    │ │ └── isarray@1.0.0
    │ ├─┬ console-browserify@1.1.0
    │ │ └── date-now@0.1.4
    │ ├── constants-browserify@1.0.0
    │ ├─┬ crypto-browserify@3.11.0
    │ │ ├─┬ browserify-cipher@1.0.0
    │ │ │ ├─┬ browserify-aes@1.0.6
    │ │ │ │ ├── buffer-xor@1.0.3
    │ │ │ │ ├── cipher-base@1.0.3 deduped
    │ │ │ │ ├── create-hash@1.1.2 deduped
    │ │ │ │ ├── evp_bytestokey@1.0.0 deduped
    │ │ │ │ └── inherits@2.0.1 deduped
    │ │ │ ├─┬ browserify-des@1.0.0
    │ │ │ │ ├── cipher-base@1.0.3 deduped
    │ │ │ │ ├─┬ des.js@1.0.0
    │ │ │ │ │ ├── inherits@2.0.1 deduped
    │ │ │ │ │ └── minimalistic-assert@1.0.0
    │ │ │ │ └── inherits@2.0.1 deduped
    │ │ │ └─┬ evp_bytestokey@1.0.0
    │ │ │   └── create-hash@1.1.2 deduped
    │ │ ├─┬ browserify-sign@4.0.0
    │ │ │ ├── bn.js@4.11.6
    │ │ │ ├─┬ browserify-rsa@4.0.1
    │ │ │ │ ├── bn.js@4.11.6 deduped
    │ │ │ │ └── randombytes@2.0.3 deduped
    │ │ │ ├── create-hash@1.1.2 deduped
    │ │ │ ├── create-hmac@1.1.4 deduped
    │ │ │ ├─┬ elliptic@6.3.2
    │ │ │ │ ├── bn.js@4.11.6 deduped
    │ │ │ │ ├── brorand@1.0.6
    │ │ │ │ ├─┬ hash.js@1.0.3
    │ │ │ │ │ └── inherits@2.0.1 deduped
    │ │ │ │ └── inherits@2.0.1 deduped
    │ │ │ ├── inherits@2.0.1 deduped
    │ │ │ └─┬ parse-asn1@5.0.0
    │ │ │   ├─┬ asn1.js@4.9.0
    │ │ │   │ ├── bn.js@4.11.6 deduped
    │ │ │   │ ├── inherits@2.0.1 deduped
    │ │ │   │ └── minimalistic-assert@1.0.0 deduped
    │ │ │   ├── browserify-aes@1.0.6 deduped
    │ │ │   ├── create-hash@1.1.2 deduped
    │ │ │   ├── evp_bytestokey@1.0.0 deduped
    │ │ │   └── pbkdf2@3.0.9 deduped
    │ │ ├─┬ create-ecdh@4.0.0
    │ │ │ ├── bn.js@4.11.6 deduped
    │ │ │ └── elliptic@6.3.2 deduped
    │ │ ├─┬ create-hash@1.1.2
    │ │ │ ├─┬ cipher-base@1.0.3
    │ │ │ │ └── inherits@2.0.1 deduped
    │ │ │ ├── inherits@2.0.1 deduped
    │ │ │ ├── ripemd160@1.0.1
    │ │ │ └─┬ sha.js@2.4.8
    │ │ │   └── inherits@2.0.1 deduped
    │ │ ├─┬ create-hmac@1.1.4
    │ │ │ ├── create-hash@1.1.2 deduped
    │ │ │ └── inherits@2.0.1 deduped
    │ │ ├─┬ diffie-hellman@5.0.2
    │ │ │ ├── bn.js@4.11.6 deduped
    │ │ │ ├─┬ miller-rabin@4.0.0
    │ │ │ │ ├── bn.js@4.11.6 deduped
    │ │ │ │ └── brorand@1.0.6 deduped
    │ │ │ └── randombytes@2.0.3 deduped
    │ │ ├── inherits@2.0.1
    │ │ ├─┬ pbkdf2@3.0.9
    │ │ │ └── create-hmac@1.1.4 deduped
    │ │ ├─┬ public-encrypt@4.0.0
    │ │ │ ├── bn.js@4.11.6 deduped
    │ │ │ ├── browserify-rsa@4.0.1 deduped
    │ │ │ ├── create-hash@1.1.2 deduped
    │ │ │ ├── parse-asn1@5.0.0 deduped
    │ │ │ └── randombytes@2.0.3 deduped
    │ │ └── randombytes@2.0.3
    │ ├── domain-browser@1.1.7
    │ ├── events@1.1.1
    │ ├─┬ http-browserify@1.7.0
    │ │ ├── Base64@0.2.1
    │ │ └── inherits@2.0.1 deduped
    │ ├── https-browserify@0.0.1
    │ ├── os-browserify@0.2.1
    │ ├── path-browserify@0.0.0
    │ ├── process@0.11.9
    │ ├── process-nextick-args@1.0.7 extraneous
    │ ├── punycode@1.4.1
    │ ├── querystring-es3@0.2.1
    │ ├─┬ readable-stream@2.3.5 (git+https://github.com/meteor/readable-stream.git#2e9112d7d31a2af6e0682db0e18679b1e5fd4694)
    │ │ ├── inherits@2.0.4
    │ │ ├── isarray@1.0.0 deduped
    │ │ ├── process-nextick-args@2.0.1
    │ │ ├── safe-buffer@5.1.2
    │ │ ├─┬ string_decoder@1.1.1
    │ │ │ └── safe-buffer@5.1.2 deduped
    │ │ └── util-deprecate@1.0.2
    │ ├── rimraf@2.6.1 extraneous
    │ ├─┬ stream-browserify@2.0.1
    │ │ ├── inherits@2.0.1 deduped
    │ │ └── readable-stream@2.3.5 deduped (git+https://github.com/meteor/readable-stream.git#2e9112d7d31a2af6e0682db0e18679b1e5fd4694)
    │ ├─┬ string_decoder@1.0.1
    │ │ └── safe-buffer@5.0.1
    │ ├─┬ timers-browserify@1.4.2
    │ │ └── process@0.11.9 deduped
    │ ├── tty-browserify@0.0.0
    │ ├─┬ url@0.11.0
    │ │ ├── punycode@1.3.2
    │ │ └── querystring@0.2.0
    │ ├─┬ util@0.10.3
    │ │ └── inherits@2.0.1 deduped
    │ └─┬ vm-browserify@0.0.4
    │   └── indexof@0.0.1
    ├─┬ nuka-carousel@2.3.0
    │ ├── exenv@1.2.2
    │ ├─┬ kw-react-tween-state@0.1.5
    │ │ ├─┬ raf@3.4.0
    │ │ │ └── performance-now@2.1.0
    │ │ └── tween-functions@1.2.0
    │ ├── object-assign@4.1.1 deduped
    │ ├── UNMET PEER DEPENDENCY react@^0.14.8 || ^15.0.1
    │ └── UNMET PEER DEPENDENCY react-dom@^0.14.8 || ^15.0.1
    ├── ramda@0.23.0
    ├─┬ UNMET DEPENDENCY react@16.10.2
    │ ├── loose-envify@1.3.1 deduped
    │ ├── object-assign@4.1.1 deduped
    │ └─┬ UNMET DEPENDENCY prop-types@15.7.2
    │   ├─┬ UNMET DEPENDENCY loose-envify@1.4.0
    │   │ └── js-tokens@3.0.2 deduped
    │   ├── object-assign@4.1.1 deduped
    │   └── react-is@16.8.3 deduped
    ├─┬ react-addons-css-transition-group@15.6.2
    │ └── react-transition-group@1.2.1 deduped
    ├─┬ react-addons-pure-render-mixin@15.6.2
    │ ├── fbjs@0.8.16 deduped
    │ └── object-assign@4.1.1 deduped
    ├─┬ react-addons-shallow-compare@15.6.2
    │ ├─┬ fbjs@0.8.16
    │ │ ├── core-js@1.2.7 deduped
    │ │ ├── isomorphic-fetch@2.2.1 deduped
    │ │ ├── loose-envify@1.3.1 deduped
    │ │ ├── object-assign@4.1.1 deduped
    │ │ ├── promise@7.3.1 deduped
    │ │ ├── setimmediate@1.0.5 deduped
    │ │ └── ua-parser-js@0.7.17 deduped
    │ └── object-assign@4.1.1 deduped
    ├─┬ react-cookie-consent@1.7.0
    │ ├── js-cookie@2.2.0
    │ └─┬ react@16.4.2
    │   ├── fbjs@0.8.16 deduped
    │   ├─┬ loose-envify@1.4.0
    │   │ └── js-tokens@4.0.0
    │   ├── object-assign@4.1.1
    │   └─┬ prop-types@15.6.2
    │     ├── loose-envify@1.4.0 deduped
    │     └── object-assign@4.1.1 deduped
    ├─┬ react-copy-to-clipboard@5.0.1
    │ ├── copy-to-clipboard@3.0.8 deduped
    │ └── prop-types@15.6.0 deduped
    ├─┬ UNMET DEPENDENCY react-dom@16.3.0
    │ ├── fbjs@0.8.16 deduped
    │ ├── loose-envify@1.3.1 deduped
    │ ├── object-assign@4.1.1 deduped
    │ └── prop-types@15.6.0 deduped
    ├─┬ react-mounter@1.2.0
    │ ├── babel-runtime@6.26.0 deduped
    │ └── domready@1.0.8
    ├─┬ react-selectize@2.1.0
    │ ├─┬ prelude-extension@0.0.13
    │ │ └── prelude-ls@1.1.2 deduped
    │ ├── prelude-ls@1.1.2
    │ └── tether@1.4.5
    ├─┬ react-share@2.3.1
    │ ├── babel-runtime@6.26.0 deduped
    │ ├── classnames@2.2.6 deduped
    │ ├─┬ jsonp@0.2.1
    │ │ └─┬ debug@2.6.9
    │ │   └── ms@2.0.0
    │ └─┬ prop-types@15.6.2
    │   ├─┬ loose-envify@1.4.0
    │   │ └── js-tokens@4.0.0
    │   └── object-assign@4.1.1
    ├─┬ UNMET PEER DEPENDENCY react-tap-event-plugin@1.0.0
    │ └─┬ fbjs@0.2.1
    │   ├── core-js@1.2.7 deduped
    │   ├── promise@7.3.1 deduped
    │   └── whatwg-fetch@0.9.0
    ├─┬ reify@0.3.8
    │ ├── acorn@3.3.0
    │ ├── acorn-es7-plugin@1.0.18
    │ ├── ast-types@0.9.14
    │ └─┬ magic-string@0.16.0
    │   └── vlq@0.2.3
    ├─┬ source-map-support@0.5.6
    │ ├── buffer-from@1.1.1
    │ └── source-map@0.6.1
    ├─┬ sshpk@1.13.1
    │ ├── asn1@0.2.3
    │ ├── assert-plus@1.0.0
    │ ├─┬ bcrypt-pbkdf@1.0.1
    │ │ └── tweetnacl@0.14.5 deduped
    │ ├─┬ dashdash@1.14.1
    │ │ └── assert-plus@1.0.0 deduped
    │ ├─┬ ecc-jsbn@0.1.1
    │ │ └── jsbn@0.1.1 deduped
    │ ├─┬ getpass@0.1.7
    │ │ └── assert-plus@1.0.0 deduped
    │ ├── jsbn@0.1.1
    │ └── tweetnacl@0.14.5
    ├── typeface-roboto@0.0.54
    ├─┬ uri-js@3.0.2
    │ └── punycode@2.1.0
    ├── urijs@1.19.1
    ├─┬ urlbox@1.3.3
    │ ├── crypto-js@3.1.9-1
    │ ├── lodash@4.17.11 deduped
    │ ├── lodash.includes@4.3.0
    │ └── qs@6.6.0
    ├── utf8@3.0.0
    └── uuid@3.1.0
