library(shiny)
library(shinythemes)
library(readr)
library(leaflet)
library(leaflet.esri)

map_service_url = 'https://gisrevprxy.seattle.gov/arcgis/rest/services/SPD_EXT/911IncidentResponses/MapServer/0'

icons = iconList(
    Assault = makeIcon('assault.png'),
    DriveBy = makeIcon('driveby.png'),
    Homicide = makeIcon('homicide.png'),
    Robbery = makeIcon('robbery.png'),
    Threats = makeIcon('threats.png'),
    Crisis = makeIcon('crisis.png'),
    Injury = makeIcon('injury.png'),
    Lost = makeIcon('lost.png'),
    Liquor = makeIcon('liquor.png'),
    Narcotics = makeIcon('narcotics.png'),
    OtherVice = makeIcon('othervice.png'),
    Prostitution = makeIcon('prostitution.png'),
    Bike = makeIcon('bike.png'),
    Burglary = makeIcon('burglary.png'),
    CarProwl = makeIcon('carprowl.png'),
    Fraud = makeIcon('fraud.png'),
    OtherProp = makeIcon('otherprop.png'),
    PropDamage = makeIcon('propdamage.png'),
    Shoplifting = makeIcon('shoplifting.png'),
    VehicleTheft = makeIcon('vehicletheft.png'),
    Collision = makeIcon('collision.png'),
    DUI = makeIcon('dui.png'),
    Harbor = makeIcon('harbor.png'),
    Traffic = makeIcon('traffic.png'),
    Animal = makeIcon('animal.png'),
    Arrest = makeIcon('arrest.png'),
    Disorderly = makeIcon('disorderly.png'),
    Disturbance = makeIcon('disturbance.png'),
    FalseAlarm = makeIcon('falsealarm.png'),
    Misc = makeIcon('misc.png'),
    Suspicious = makeIcon('suspicious.png'),
    Trespass = makeIcon('trespass.png'),
    Unsafe = makeIcon('unsafe.png'),
    Weapon = makeIcon('weapon.png')
)

html_legend = "<img src='assault.png' width=22px height=22px>Assault<br/>
               <img src='driveby.png' width=22px height=22px>Drive By<br/>
               <img src='homicide.png' width=22px height=22px>Homicide<br/>
               <img src='robbery.png' width=22px height=22px>Robbery<br/>
               <img src='threats.png' width=22px height=22px>Threats<br/>
               <img src='crisis.png' width=22px height=22px>Crisis<br/>
               <img src='injury.png' width=22px height=22px>Injury<br/>
               <img src='lost.png' width=22px height=22px>Lost<br/>
               <img src='liquor.png' width=22px height=22px>Liquor<br/>
               <img src='narcotics.png' width=22px height=22px>Narcotics<br/>
               <img src='othervice.png' width=22px height=22px>Other Vice<br/>
               <img src='prostitution.png' width=22px height=22px>Prostitution<br/>
               <img src='bike.png' width=22px height=22px>Bike<br/>
               <img src='burglary.png' width=22px height=22px>Burglary<br/>
               <img src='carprowl.png' width=22px height=22px>Car Prowl<br/>
               <img src='fraud.png' width=22px height=22px>Fraud<br/>
               <img src='otherprop.png' width=22px height=22px>Other Property Crime<br/>
               <img src='propdamage.png' width=22px height=22px>Property Damage<br/>
               <img src='shoplifting.png' width=22px height=22px>Shoplifting<br/>
               <img src='vehicletheft.png' width=22px height=22px>Vehicle Theft<br/>
               <img src='collision.png' width=22px height=22px>Collision<br/>
               <img src='dui.png' width=22px height=22px>DUI<br/>
               <img src='harbor.png' width=22px height=22px>Harbor<br/>
               <img src='traffic.png' width=22px height=22px>Traffic<br/>
               <img src='animal.png' width=22px height=22px>Animal<br/>
               <img src='arrest.png' width=22px height=22px>Arrest<br/>
               <img src='disorderly.png' width=22px height=22px>Disorderly<br/>
               <img src='disturbance.png' width=22px height=22px>Disturbance<br/>
               <img src='falsealarm.png' width=22px height=22px>False Alarm<br/>
               <img src='misc.png' width=22px height=22px>Miscellaneous<br/>
               <img src='suspicious.png' width=22px height=22px>Suspicious<br/>
               <img src='trespass.png' width=22px height=22px>Trespass<br/>
               <img src='unsafe.png' width=22px height=22px>Unsafe<br/>
               <img src='weapon.png' width=22px height=22px>Weapon<br/>"

ui = navbarPage(title = 'Police Reports | Past 24 Hours', windowTitle = 'Police Reports',
                selected = 'Interactive Map', theme = shinytheme('yeti'),
                # some extra CSS
                tags$head(tags$link(rel = 'stylesheet', type = 'text/css',
                                    href = 'custom.css')),
                tabPanel(title = 'Interactive Map',
                    div(class = 'outer',
                        leafletOutput('map', width = '100%', height = '100%')
                    )
                )
)

server = function(input, output) {
    popup_js = JS(read_file('popup.js'))
    output$map = renderLeaflet({
        leaflet() %>%
            addProviderTiles(providers$CartoDB.Positron) %>%
            setView(lng = -122.330412, lat = 47.609056, zoom = 15) %>% 
            addEsriFeatureLayer(map_service_url, markerIcons = icons,
                                markerIconProperty = 'mapcategory',
                                popupProperty = popup_js) %>% 
            addControl(html = html_legend, position = 'bottomleft')
    })
}

shinyApp(ui = ui, server = server)
