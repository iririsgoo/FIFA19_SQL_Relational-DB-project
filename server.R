function(input, output, session) {
  
#############################################
# Home tab
#############################################
  
  # render image showing Fenway Park
  output$homeImg <- renderImage(
    {
      list(src = 'fifa19.jpg', contentType = 'image/jpg')
    }, 
    deleteFile = FALSE # the file will be deleted if deleteFile = TRUE
  ) 
  }


##########################################
# best player_rating
##########################################

# render plot showing home run leaders
output$plotB <- renderPlot(
  # sets height of plot to 1/2 of width; otherwise height stays at 480px
  height = function() {session$clientData$output_plotB_width/2},
  {
    sq <- paste0(
      "select * from player_rating as pr 
      natural join (select player_id, player_name from player_info)as a
      natural join (select player_id, preferred_position from player_position) as b
      order by potential DESC
      limit 20;")
      
      h <- dbGetQuery(con, sq)
})
      


#############################################
# Batting tab
#############################################

# render plot showing home run leaders
output$plotB <- renderPlot(
  # sets height of plot to 1/2 of width; otherwise height stays at 480px
    height = function() {session$clientData$output_plotB_width/2},
  {
    sq <- paste0(
      "SELECT name_first || ' ' || name_last AS player, 
      year_id, SUM(hr) AS home_runs 
      FROM players NATURAL JOIN batting
      WHERE year_id = ", input$yrB,
      "GROUP BY 2, 1 ORDER BY 2, 3 DESC LIMIT 15;")
    
    h <- dbGetQuery(con, sq)
    
    h %>% 
      mutate(player = fct_reorder(player, home_runs)) %>% 
      ggplot(aes(x = player, y = home_runs, fill = home_runs, label = home_runs)) +
      geom_bar(stat = 'identity') +
      geom_text(hjust = -1) +
      coord_flip() +
      ylim(0, 80) +
      labs(x = '', y = 'Home Runs') +
      theme_grey(base_size = 20) +
      ggtitle(paste0('Top 15 Home Run Hitters for ', input$yrB)) +
      theme(legend.position = 'none',
            axis.text.y = element_text(face = 'bold')) 
    
  }
    )


#############################################
# Ballparks tab
#############################################

# render map showing ballparks
output$parkMap <- renderLeaflet(
  {
    leaflet(p) %>%    # p is dataframe generated in the global file
      addTiles() %>%  # images of map as tiles
      addAwesomeMarkers(
        lng = ~lng, 
        lat = ~lat,
        label = paste0(p$park, ' | ', p$team_name),
        icon = awesomeIcons(icon = ~icon, 
                            markerColor = ~color,
                            lib = 'glyphicon')
      ) %>% 
      addLegend(values = ~color, 
                title = 'League',
                position = 'topright',
                labels = c('American', 'National'),
                colors = c('#d53e2a','#38a9dc'), # shades of red and blue
                opacity = 1) %>% 
      # coordinates for center of mainland USA
      setView(lat = 39.0972997, lng = -94.5799392, zoom = 5)
    # zoom can be 1 to 16 (1 shows world, 16 shows street detail)
  }
)

























