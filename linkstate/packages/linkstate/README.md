# Hashrepublic: linkstates of the web
## Youiest - Make Connections
You, agent of change, from life, moving to the future, react!


searchers hunger for wisdom
dissatisfied with the tyranny of a flat world
looking to lead new trails and explore breadcrumbs
see every move make a mark
aboutness powers the content within

let's talk Aboutness....

Opening a newtab in your browser suggests movement and action. By default tapping tab tab enter connects the the last place you were on to the last thing you connected to. This is like a bookmark organized in relation to your project page, public profile or whatever you choose in the dropdown.

### On the newtab you want to see
- [ ] Backlinks and Outlinks for both urls presently selected in dropdowns
  - [ ] These are your bookmarks relating to lastPage
  - [ ] Also other people's bookmarks are here
- [ ] buzz social media data about the page you were just on
- [ ] ads regarding the page you were just on.
  - [ ] Because it's relevant to where you're going next
  - [ ] Because you need to trust that we'll be around later
  - [ ] You can choose your next step. the ad isn't a sideline, you are going somewhere.

### When you enter a link you want to see a modal popup where:
- [ ] What time of day does it relate to? Choose Timely.
    - [ ] Is it really high noon? That's when you get your lunch into your belly.
    - [ ] Is it more 3pm? That's when you put on your presentation.
    - [ ] Is it more like 6pm? When you push the world away and be with your kin.
    - [ ] It it more like 9am? When you ready yourself before you enter the world.
- [ ] What season does it relate to? Date.
- [ ] Chance to change the data you're entering


Bookmarks become useful when they're in your face at the right time. A timely ctrl t from the wiki shows connected bookmarks and connects it to your private profile.



# Axioms you MUST accept should you choose to contribute

  0. You start at zero. Not one like this silly bullet list.
  1. Aboutness is more interesting and differentiating than the contents of a NODE.
  2. Everything is open on the web and authentic by Facebook or equivalent.
  3. Privacy is a premium feature and can wait.
  4. Verbs are things so walking FROM an article TO a linkedin page is a NODE, should it be useful?
  5. Optimization can wait while we push the limits of the DB. Waste is still criminal.
  6. You probably have ten fingers so ten is more human than two for counting options.
  7. Networks are more human graphs and exposes solutions to hard and messy problems.
  8. You can easily tell time on an analogue watch. Let's brand that for commercial reasons.
  9. Time is relevance to things. Position is meaning to things. Value is it to things.
    - [ ] At noon you PULL IN your lunch to your heart.
    - [ ] At three you PUSH IN a truthy presentation into their heads.
    - [ ] At six you PULL OUT and back to your beloveds.
    - [ ] At nine you PUSH OUT the world and get to work. Or to the PRIVACY of your bed if in the PM.


# State of projects in the form of tests
- Testing Dev Workflow
  - [x] sh test.sh > logs in packageTest.log.
  - [x] packageTest.log to see testing messages truncated on restart
- Core package Edges and pulls up link nodes
  - [x] Meteor.call('Linking', FROM, TO, META) Edges
  - [x] Meteor.insecureUserLogin for congruent data
  - linkstate api showb by tests - the core package for node and edge creation
    - [x] Linking FROM to TO inserts new LINK with META
    - [x] out-links: Linking FROM and TO upserts FROM.out.TO = {LINK}
    - [x] in-links: Linking FROM and TO upserts TO.in.FROM = {LINK}
- noderoutes - Web Publishing Package
  - Open and Authentic
    - [ ] Test that All FROM and TO are accessible at /nodes/:id
    - [x] Creating requires Facebook logged in status
    - [ ] Claim ownership of a FROM or TWO by
  - Semantic
    - [ ] Generate html tags FROM.out.TOn.META.FROM for ui, search
    - [ ] Structure Object.in.FROM.userId keeps attributes unique for upserts
  - Website
    - [ ] Edges/FROM shows META , FROM.in.FROMn (n number of url_id attributes) , FROM.out.TOn
  - Chrome Addon
    - [x] newtab tab tab enter calls Linking(lastPage, lastConnectedTo, "")
    - [ ] helpful text as alternative to input section
    - [ ] futureproof modularized elements on page
    - [ ] useful display of related bookmarks
    - [ ] material js only ui elements
    - [ ] timely: on submit, lightbox asks for date / time relevance
    - [ ] subscribe to .in .out from select urls in select boxes
      - [ ] if not logged in show data about
        - [ ] lastPage on the left half
        - [ ] youiest.com frontpage on right side as .in / .out to youiest
    - [ ] load user object from localStorage and input controls from there
    - [ ] subs manager
    - [ ] each edit/update of a link creates a new insert, later after done update FROM.out and TO.in .
    - [ ] delete is a function, enter to create
    - [ ] newtab subscribes .in/.out of lastPage AND my profile
    - [ ] newatab tab tab 'regarding our conversation on culture' tab 4 (4th .TO on my profile happens to be your linkedin)
    - [ ] newtab has bookmarks about lastPage, and myProfile, so i can feel in control of my  jumps
    - [ ] resolve to create on enter, smart pre populate select boxes, last page, last to
 .call('Linking TO
    - [ ] send cmd+shift+s , "we spoke about this earlier" , shift+tab, 1, ENTER => .call('Linking FROM last thing you .call('Linking FROM, TO currentPage
        - [ ] send cmd+shift+o opens /Edges/currentPage with .call('From',currentPage)
  - Visual
    - [ ] in and out-links make visual connections
    - []
  - Mobile
  - Notifications
  - DATA Tests show we can get the data back to client and it's right
    - [ ] visualize .in .out on a clock..date?
    - [ ] Route pub/subs nodes created by Meteor.call('Linking', FROM, TO, META)
    - When on a .call('FROM necessary data to show in and out Edges exist with meta
      - [ ] FROM.out.TO.meta === META when .call('Linking .call('From
    - dummy user data exist as attributes
      - [ ] FROM.out.TO.META.fbUSErId == userID == FROM.META.userId when calling Linking + From
    - .call('linking','subscribe','FROM')
