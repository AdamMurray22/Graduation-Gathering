let map;
let tileLayer;
let IDLayersMap = new Map();
// Enum to identify the type of layer
let layerEnum = {
    markerLayer: 'markerLayer',
    geoJsonLayer: 'geoJsonLayer'
};

/*
Map
*/

map = new ol.Map({
    view: new ol.View({
        center: new ol.proj.fromLonLat([1, 1]),
        zoom: 1,
    }),
    target: 'map',
});

// Detects if a marker has been clicked
map.on("click", function (e) {
    let markerFound = false;
    map.forEachFeatureAtPixel(e.pixel, function (feature, layer) {
        if (layer.isClickableMarkerLayer && markerFound == false) {
            markerClicked(feature);
            markerFound = true;
        }
    })
});

// adds a tile layer with the given tile server.
function addOSMTileServer(server)
{
    tileLayer = new ol.layer.Tile({
        source: new ol.source.OSM({
            attributions: [
            server.attribution,
            ol.source.OSM.ATTRIBUTION,
        ],
        url:
            server.url,
        }),
    });
    map.addLayer(tileLayer);
}

// Sets the centre of the map and the zoom
function setCentreZoom(value) {
    map.getView().setZoom(value.zoom);
    map.getView().setCenter(ol.proj.fromLonLat([value.long, value.lat]));
}



// Creates a marker layer
function createMakerLayer(layer)
{
    var markerLayer = new ol.layer.Vector({
        source: new ol.source.Vector(),
        style: new ol.style.Style({
            image: new ol.style.Icon({
                anchor: [layer.anchorX, layer.anchorY],
                anchorXUnits: 'fraction',
                anchorYUnits: 'fraction',
                scale: [layer.markerSize, layer.markerSize],
                src: layer.image,
            }),
        }),
    });
    markerLayer.isClickableMarkerLayer = layer.markersClickable;
    map.addLayer(markerLayer);
    if (IDLayersMap.get(layer.layerId) == null)
    {
        createLayerGroup(layer.layerId);
    }
    var layerGroup = IDLayersMap.get(layer.layerId);
    layerGroup.set(layerEnum.markerLayer, markerLayer);
}

// Creates a geo json layer
function createGeoJsonLayer(layer)
{
    var geoJsonLayer = new ol.layer.VectorImage({
        source: new ol.source.Vector({
            format: new ol.format.GeoJSON(),
        }),
        style: new ol.style.Style({
            stroke: new ol.style.Stroke({
                color: `rgb(${layer.colour.r}, ${layer.colour.g}, ${layer.colour.b})`,
                width: 8,
            }),
            fill: new ol.style.Fill({
                color: `rgba(${layer.colour.r}, ${layer.colour.g}, ${layer.colour.b}, 0.1)`,
            }),
        }),
    });
    map.addLayer(geoJsonLayer);
    if (IDLayersMap.get(layer.layerId) == null)
    {
        createLayerGroup(layer.layerId);
    }
    var layerGroup = IDLayersMap.get(layer.layerId);
    layerGroup.set(layerEnum.geoJsonLayer, geoJsonLayer);
}

// Creates the layer group
function createLayerGroup(id)
{
    IDLayersMap.set(id, new Map());
}



// Adds the markers
function addMarker(markedFeature) {
    const layer = IDLayersMap.get(markedFeature.layerId).get(layerEnum.markerLayer);
    const marker = new ol.Feature(new ol.geom.Point(ol.proj.fromLonLat([markedFeature.longitude, markedFeature.latitude])));
    marker.setId(markedFeature.id);
    layer.getSource().addFeature(marker);
}

// Removes the marker
function removeMarker(markedFeature) {
    const layer = IDLayersMap.get(markedFeature.layerId).get(layerEnum.markerLayer);
    const source = layer.getSource();
    source.removeFeature(source.getFeatureById(markedFeature.id));
}

// Updates the location of a marker
function updateMarker(markedFeature) {
    removeMarker(markedFeature);
    addMarker(markedFeature);
}

// Toggles the visibility of the markers
function toggleShowLayers(visible) {
    const layers = Array.from(IDLayersMap.get(visible.layerId).values());
    layers.forEach(function (layer) {
        layer.setVisible(visible.visible);
    })
}

// Marker interaction
function markerClicked(marker) {
    MarkerClickedDart.postMessage(marker.getId());
}

// Adds a geojson default colour
function addGeoJson(geoJsonFeature) {
    const layer = IDLayersMap.get(geoJsonFeature.layerId).get(layerEnum.geoJsonLayer);
    drawGeoJsonLines(geoJsonFeature, layer);
}

// Adds a geojson with given colour
function addGeoJsonWithColour(geoJsonFeature) {
    const layer = IDLayersMap.get(geoJsonFeature.layerId).get(layerEnum.geoJsonLayer);
    drawGeoJsonLinesWithColour(geoJsonFeature, layer);
}

// Clears a geojson layer
function clearGeoJsonLayer(layerId)
{
    const layer = IDLayersMap.get(layerId.layerId).get(layerEnum.geoJsonLayer);
    layer.getSource().clear();
}

// Add the given GeoJson to the map
function drawGeoJsonLines(geoJson, layer) {
    layer.getSource().addFeatures((new ol.format.GeoJSON({
        featureProjection: 'EPSG:3857',
        dataProjection: 'EPSG:4326'
    })).readFeatures(geoJson.geoJson));
}

// Add the given GeoJson to the map
function drawGeoJsonLinesWithColour(geoJson, layer) {
    var features = (new ol.format.GeoJSON({
        featureProjection: 'EPSG:3857',
        dataProjection: 'EPSG:4326'
    })).readFeatures(geoJson.geoJson);
    features.forEach(function (feature) {
        feature.setStyle(new ol.style.Style({
            stroke: new ol.style.Stroke({
                color: `rgb(${geoJson.colour.r}, ${geoJson.colour.g}, ${geoJson.colour.b})`,
                width: 8,
            }),
            fill: new ol.style.Fill({
                color: `rgba(${geoJson.colour.r}, ${geoJson.colour.g}, ${geoJson.colour.b}, 0.1)`,
            }),
        }));
    });
    layer.getSource().addFeatures(features);
}

function isPointInsidePolygons(point, geojsons) {
    if (geojsons.length == 0)
    {
        return false;
    }
    for (var geoJsonIndex in geojsons) {
        const geoJson = geojsons[geoJsonIndex];
        const polygons = (new ol.format.GeoJSON({
            featureProjection: 'EPSG:3857',
            dataProjection: 'EPSG:4326'
        })).readFeatures(geoJson.geoJson);
        for (var polygonIndex in polygons) {
            if (!polygons[polygonIndex].getGeometry().intersectsCoordinate(new ol.proj.fromLonLat([point.longitude, point.latitude]))) {
                return false;
            }
        }
    };
    return true;
}