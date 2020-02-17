
navbarPage('Soccor', 
           id='nav',
           inverse = TRUE, # dark color tabs; TRUE makes them white
           collapsible = TRUE, # if viewed on small screen, tabs will collapse
           position = 'fixed-bottom', # tabs on the bottom
           
           #############################################
           # Home tab
           #############################################
           
           tabPanel('Home',
                    div(
                      class = 'outer',
                      # custom CSS for the map tab (in general, not needed)
                      tags$head(includeCSS('styles.CSS')),
                      # container for the map
                      imageOutput(
                        'homeImg', 
                        width = '100%', 
                        height = '100%'
                      )
                    )
           )
)

