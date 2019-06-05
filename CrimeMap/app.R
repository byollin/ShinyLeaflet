library(shiny)
library(shinythemes)
library(leaflet)
library(leaflet.esri)

ui = navbarPage(title = 'Crime Map', windowTitle = 'Crime Map', selected = 'Interactive Map',
                theme = shinytheme('yeti'),
                # some extra CSS
                tags$head(tags$style(HTML("
                    div.outer {
                        position: fixed;
                        top: 45px;
                        left: 0;
                        right: 0;
                        bottom: 0;
                        overflow: hidden;
                        padding: 0;
                    }"
                ))),
                tabPanel(title = 'Interactive Map',
                    # map panel
                    div(class = 'outer',
                        leafletOutput('map', width = '100%', height = '100%')
                    )
                ),
                tabPanel(title = 'Other page',
                    h1("There's nothing here!", style = 'text-align: center;')         
                )
)

server = function(input, output) {
    
    map_service_url = 'https://gisrevprxy.seattle.gov/arcgis/rest/services/SPD_EXT/911IncidentResponses/MapServer/0'

    output$map = renderLeaflet({
        leaflet(options = leafletOptions(minZoom = 4, maxZoom = 18, zoomControl = FALSE)) %>%
            addProviderTiles(providers$CartoDB.Positron) %>%
            setView(lng = -122.330412, lat = 47.609056, zoom = 15) %>%
            addEsriFeatureLayer(map_service_url, markerType = 'circleMarker',
                                markerOptions = markerOptions(fillColor = 'red', color = 'red',
                                                              fillOpacity = 1, opacity = 1, radius = 3))
    })
}

shinyApp(ui = ui, server = server)