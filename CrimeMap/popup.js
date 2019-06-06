function(feature) {
    var properties = feature.properties;
    return "<h6><b>" + new Date(properties.calldatetime).toLocaleString() + "</b></h6><hr><h6>" + properties.calltype + " @ " + properties.addressblock + "</h6>";
}
