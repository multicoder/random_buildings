-- add command so that a trader can be spawned
minetest.register_chatcommand("thaus", {
        params = "",
        description = "Spawns a random building.",
        privs = {},
        func = function(name, param)

                local player = minetest.env:get_player_by_name(name);
                local pos    = player:getpos();

                minetest.chat_send_player(name, "Searching for a position to place a house.");

--                local possible_types = {'birch','spruce','jungletree','fir','beech','apple_tree','oak','sequoia','palm','pine', 'willow','rubber_tree'};
--                local typ = possible_types[ math.random( 1, #possible_types )];

--                random_buildings.build_next_to_tree( {x=pos.x, y=pos.y, z=pos.z, typ = "moretrees:"..typ.."_trunk", name = name } );
                random_buildings.build_trader_clay(  {x=pos.x, y=pos.y, z=pos.z } );
             end
});




random_buildings.build_trader_house = function( pos )

   local building_name = pos.bn;
   local replacements  = pos.rp;
   local typ           = pos.typ;
   local trader_typ    = pos.trader;

   --print( "Trying to build "..tostring( building_name ));
   local mirror = math.random(0,1);
   local rotate = math.random(0,3); 

   mirror = 0; -- TODO

   local result;
   local pos2;

   local i = 0;
   local found = false;
   -- try up to 3 times
   if( pos.last_status == nil ) then

      while( i < 3 and found == false) do

         -- get a random position at least 5 nodes away from the trunk of the tree
         pos2 = random_buildings.get_random_position( pos, 5, 20);

         result = random_buildings.spawn_building( {x=pos2.x,y=pos2.y,z=pos2.z}, building_name, rotate, mirror, replacements, trader_typ, nil);

         i = i + 1;
         -- status "aborted" happens if there is something in the way
         if( result.status ~= "aborted" ) then
            found = true;
         end
      end
   else
      pos2   = {x=pos.x,y=pos.y,z=pos.z};
      result = random_buildings.spawn_building( {x=pos2.x,y=pos2.y,z=pos2.z}, building_name, rotate, mirror, replacements, trader_typ, nil );
   end

 
   if( pos.name ~= nil ) then
      if( result.status == "ok" ) then
         minetest.chat_send_player( pos.name, "Build house at position "..minetest.serialize( result )..
               ". Selected "..( building_name or "?" ).." with mirror = "..tostring( mirror ).." and rotation = "..tostring( rotate )..".");
         print( "[Mod random_buildings] Build house at position "..minetest.serialize( result )..
               ". Selected "..( building_name or "?" ).." with mirror = "..tostring( mirror ).." and rotation = "..tostring( rotate )..".");
      else
         -- pos contains the reason for the failure
         minetest.chat_send_player( pos.name, "FAILED to build house at position "..minetest.serialize( result )..".");
         print( "[Mod random_buildings] FAILED to build house at position "..minetest.serialize( result )..".");
      end
   end

   -- try building again - 20 seconds later
   if( result.status == "need_to_wait" ) then
      minetest.after( 20, random_buildings.build_trader_house, {x=pos2.x,y=pos2.y,z=pos2.z, name=pos.name, last_status = result.status, 
                              bn = building_name, rp = pos.rp, typ = pos.typ, trader = pos.trader } );
      print("[Mod random_buildings] Waiting for 20 seconds for the land to load at "..minetest.serialize( {x=pos2.x,y=pos2.y,z=pos2.z, typ=pos.typ, name=pos.name, last_status = result.status} ));
   end
end

