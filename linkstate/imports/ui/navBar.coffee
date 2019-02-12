React = require('react')
reactKup = require('react-kup')

{div,nav, a, ul, li} = React.DOM

Nav = React.createClass
 render: ->
  nav
     id: "nav_f"
     className: ""
     role: "navigation"
     style : {
         color : "#00bcd4"
     }
     div
       className: 'container'
       div
        className: 'nav-wrapper'
        a
          href: '#'
          id: 'logo-container'
          className: 'brand-logo'
          ul
            className: 'right hide-on-med-and-down'
            li
              className: 'xyz'
              a
                className: 'a'
                target: '_blank'
                href : props.from
                title = props.word.HeaderTitle
            # li
            #   className: 'xyz'
            #   a
            #     className: 'a'
            #     target: '_blank'
            #     href:'https://drive.google.com/open?id=0BxESHlfBQRFGazlwYzVYaThRczA'
            #     "Download"
          ul
            id: 'nav-mobile',
            className: "side-nav"
            li
              className: 'xyz'
              a
                className: 'a'
                target: '_blank'
                href : props.from
                title = props.word.HeaderTitle
            # li
            #   className: 'xyz'
            #   a
            #     className: 'a'
            #     target: '_blank'
            #     href:'https://drive.google.com/open?id=0BxESHlfBQRFGazlwYzVYaThRczA'
            #     "Download"
            li
              className: 'xyz'
              a
                className: 'a'
                href:'#'
                "Close"
        a
          href: '#',
          'data-activates': 'nav-mobile'
          className: 'button-collapse'



exports.NavBar = React.createClass
  componentDidMount: ->
    # @view = Blaze.render Template.loginButtons, document.getElementById 'loginContainer'

  #componentWillUnmount: ->
  #  Blaze.remove @view
  render: ->
    
    that = this
    reactKup (k) -> 
      k.build Nav 