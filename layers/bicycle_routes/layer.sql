-- etldoc: layer_bicycle_routes[shape=record fillcolor=lightpink, style="rounded,filled",
-- etldoc:     label="<sql> layer_bicycle_routes |<z4> z4 |<z5> z5 |<z6> z6 |<z7> z7 |<z8> z8 |<z9> z9 |<z10> z10 |<z11> z11 |<z12> z12|<z13> z13|<z14_> z14+" ] ;
CREATE OR REPLACE FUNCTION layer_bicycle_routes(bbox geometry, zoom_level int)
RETURNS TABLE(osm_id bigint, geometry geometry, network text, name text) AS $$
    SELECT
        osm_id, geometry, network, name
    FROM (
        -- etldoc: osm_highway_linestring       ->  layer_transportation:z12
        -- etldoc: osm_highway_linestring       ->  layer_transportation:z13
        -- etldoc: osm_highway_linestring       ->  layer_transportation:z14_
        SELECT
            osm_id, geometry, network, name
        FROM osm_highway_linestring
    ) AS zoom_levels
    WHERE geometry && bbox;
$$ LANGUAGE SQL IMMUTABLE;
