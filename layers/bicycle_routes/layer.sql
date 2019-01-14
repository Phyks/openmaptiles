-- etldoc: layer_bicycle_routes[shape=record fillcolor=lightpink, style="rounded,filled",
-- etldoc:     label="<sql> layer_bicycle_routes |<z4> z4 |<z5> z5 |<z6> z6 |<z7> z7 |<z8> z8 |<z9> z9 |<z10> z10 |<z11> z11 |<z12> z12|<z13> z13|<z14_> z14+" ] ;
CREATE OR REPLACE FUNCTION layer_bicycle_routes(bbox geometry, zoom_level int)
RETURNS TABLE(osm_id bigint, geometry geometry, network text) AS $$
    SELECT
        osm_id, geometry, network
    FROM (
	-- TODO[Phyks] Simplified geometries
        SELECT
            osm_bicycle_route_member.osm_id AS osm_id,
	    osm_bicycle_route_member.geometry AS geometry,
	    osm_bicycle_route_metadata.network AS network
        FROM osm_bicycle_route_member
	INNER JOIN osm_bicycle_route_metadata ON osm_bicycle_route_member.osm_id=osm_bicycle_route_metadata.osm_id
    ) AS zoom_levels
    WHERE geometry && bbox;
$$ LANGUAGE SQL IMMUTABLE;
