# # Place all the behaviors and hooks related to the matching controller here.
# # All this logic will automatically be available in application.js.
# # You can use CoffeeScript in this file: http://coffeescript.org/
#
#
#
# # get JSON object
# # on success, parse it and
# # hand it over to MapBox for mapping
# $.ajax
#   dataType: 'text'
#   url: '/explore.json'
#   success: (data) ->
#     geojson = $.parseJSON(data)
#     map.featureLayer.setGeoJSON(geojson)
#
#     # add custom popups to each marker
#     map.featureLayer.on 'layeradd', (e) ->
#       marker = e.layer
#       properties = marker.feature.properties
#
#       # create custom popup
#       popupContent =  '<div class="popup">' +
#                         '<h3>' + properties.name + '</h3>' +
#                         '<p>' + properties.address + '</p>' +
#                       '</div>'
#
#       # http://leafletjs.com/reference.html#popup
#       marker.bindPopup popupContent,
#         closeButton: false
#         minWidth: 320
#
#     # handles a sidebar happy hour click
#     $('article li').click (e) ->
#       current = $(this)
#       currentlyClickedName = current.find('h2').text()
#
#       # opens/closes popup for currently clicked happy hour
#       map.featureLayer.eachLayer (marker) ->
#         if marker.feature.properties.name is currentlyClickedName
#           id = layer._leaflet_id
#           map._layers[id].openPopup()