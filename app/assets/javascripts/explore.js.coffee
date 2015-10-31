$(document).ready ->
  L.mapbox.accessToken = 'pk.eyJ1IjoiY2FwdHByb3RvbiIsImEiOiI3cDFLWWRnIn0.guU68dUaxKCX_MPrZHAesQ'
  queryString = window.location.search
  map = L.mapbox.map('map', 'mapbox.streets').setView([
      28.391
      -81.55
      ], 13)
  myLayer = L.mapbox.featureLayer().addTo(map)
  myLayer.on 'layeradd', (e) ->
    marker = undefined
    popupContent = undefined
    properties = undefined
    marker = e.layer
    properties = marker.feature.properties
    popupContent = '<div class="popup"><h3><a href="/explore/' + properties.id + '" data-toggle="modal" data-target = "#tallModal">' + properties.name + '</a></h3><p class="popup-num">Marker No. ' + properties.name + '</p><p>' + properties.name + '</p></div>'
    marker.bindPopup popupContent,
      closeButton: false
      minWidth: 300
  $.ajax
    dataType: 'text'
    url: '/explore.json' + queryString
    success: (data) ->
      geojson = undefined
      geojson = $.parseJSON(data)
      myLayer.setGeoJSON geojson
  return
