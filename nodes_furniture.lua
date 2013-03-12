---------------------------------------------------------------------------------------
-- furniture
---------------------------------------------------------------------------------------
-- contains:
--  * a bed seperated into foot and head reagion so that it can be placed manually; it has
--    no other functionality than decoration!
--  * a sleeping mat - mostly for NPC that cannot afford a bet yet
--  * bench - if you don't have 3dforniture:chair, then this is the next best thing
--  * table - very simple one
--  * shelf - for stroring things; this one is 3d
--  * stovepipe - so that the smoke from the furnace can get away
--  * washing place - put it over a water source and you can 'wash' yourshelf
---------------------------------------------------------------------------------------
-- TODO: change and copy the textures of the bed (make the clothing white, foot path not entirely covered with cloth)

-- a bed without functionality - just decoration
minetest.register_node("random_buildings:bed_foot", {
	description = "Bed (foot region)",
	drawtype = "nodebox",
	tiles = {"beds_bed_top_bottom.png", "default_wood.png",  "beds_bed_side.png",  "beds_bed_side.png",  "beds_bed_side.png",  "beds_bed_side.png"},
	paramtype = "light",
	paramtype2 = "facedir",
	groups = {snappy=1,choppy=2,oddly_breakable_by_hand=2,flammable=3},
	sounds = default.node_sound_wood_defaults(),
	node_box = {
		type = "fixed",
		fixed = {
					-- bed
					{-0.5, 0.0, -0.5, 0.5, 0.3, 0.5},
					
					-- stützen
					{-0.5, -0.5, -0.5, -0.4, 0.5, -0.4},
					{0.4, 0.5, -0.4, 0.5, -0.5, -0.5},
                               
                                        -- Querstrebe
					{-0.5,  0.3, -0.5, 0.5, 0.5, -0.4}
				}
	},
	selection_box = {
		type = "fixed",
		fixed = {
					{-0.5, -0.5, -0.5, 0.5, 0.3, 0.5},
				}
	},
})

-- the bed is split up in two parts to avoid destruction of blocks on placement
minetest.register_node("random_buildings:bed_head", {
	description = "Bed (head region)",
	drawtype = "nodebox",
	tiles = {"beds_bed_top_top.png", "default_wood.png",  "beds_bed_side_top_r.png",  "beds_bed_side_top_l.png",  "default_wood.png",  "beds_bed_side.png"},
	paramtype = "light",
	paramtype2 = "facedir",
	groups = {snappy=1,choppy=2,oddly_breakable_by_hand=2,flammable=3},
	sounds = default.node_sound_wood_defaults(),
	node_box = {
		type = "fixed",
		fixed = {
					-- bed
					{-0.5, 0.0, -0.5, 0.5, 0.3, 0.5},
					
					-- stützen
					{-0.4, 0.5, 0.4, -0.5, -0.5, 0.5},
					{0.5, -0.5, 0.5, 0.4, 0.5, 0.4},

                                        -- Querstrebe
					{-0.5,  0.3,  0.5, 0.5, 0.5,  0.4}
				}
	},
	selection_box = {
		type = "fixed",
		fixed = {
					{-0.5, -0.5, -0.5, 0.5, 0.3, 0.5},
				}
	},
})


-- the basic version of a bed - a sleeping mat
-- to facilitate upgrade path straw mat -> sleeping mat -> bed, this uses a nodebox
minetest.register_node("random_buildings:sleeping_mat", {
        description = "sleeping matg",
        drawtype = 'nodebox',
        tiles = { 'sleepingmat.png' }, -- done by VanessaE
        wield_image = 'sleepingmat.png',
        inventory_image = 'sleepingmat.png',
        sunlight_propagates = true,
        paramtype = 'light',
        paramtype2 = "facedir",
        is_ground_content = true,
        walkable = false,
        groups = { snappy = 3 },
        sounds = default.node_sound_leaves_defaults(),
        selection_box = {
                        type = "wallmounted",
                        },
        node_box = {
                type = "fixed",
                fixed = {
                                        {-0.48, -0.5,-0.48,  0.48, -0.45, 0.48},
                        }
        },
        selection_box = {
                type = "fixed",
                fixed = {
                                        {-0.48, -0.5,-0.48,  0.48, -0.25, 0.48},
                        }
        }
})



-- furniture; possible replacement: 3dforniture:chair
minetest.register_node("random_buildings:bench", {
	drawtype = "nodebox",
	description = "simple wooden bench",
	tiles = {"default_wood.png", "default_wood.png",  "default_wood.png",  "default_wood.png",  "default_wood.png",  "default_wood.png"},
	paramtype = "light",
	paramtype2 = "facedir",
	groups = {snappy=1,choppy=2,oddly_breakable_by_hand=2,flammable=3},
	sounds = default.node_sound_wood_defaults(),
	node_box = {
		type = "fixed",
		fixed = {
					-- sitting area
					{-0.5, -0.15, 0.5,  0.5,  -0.05, 0.1},
					
					-- stützen
					{-0.4, -0.5,  0.4, -0.3, -0.15, 0.2},
					{ 0.4, -0.5,  0.4,  0.3, -0.15, 0.2},
				}
	},
	selection_box = {
		type = "fixed",
		fixed = {
					{-0.5, -0.5, 0, 0.5, 0, 0.5},
				}
	},
})


-- a simple table; possible replacement: 3dforniture:table
minetest.register_node("random_buildings:table", {
		description = "table",
		drawtype = "nodebox",
                -- top, bottom, side1, side2, inner, outer
		tiles = {"default_wood.png"},
		paramtype = "light",
		paramtype2 = "facedir",
		is_ground_content = true,
		groups = {snappy=2,choppy=2,oddly_breakable_by_hand=2},
		node_box = {
			type = "fixed",
			fixed = {
				{ -0.1, -0.5, -0.1,  0.1, 0.3,  0.1},
				{ -0.5,  0.3, -0.5,  0.5, 0.4,  0.5},
			},
		},
		selection_box = {
			type = "fixed",
			fixed = {
				{ -0.5, -0.5, -0.5,  0.5, 0.4,  0.5},
			},
		},
})


-- looks better than two slabs impersonating a shelf; also more 3d than a bookshelf 
-- the infotext shows if it's empty or not
minetest.register_node("random_buildings:shelf", {
		description = "open storage shelf",
		drawtype = "nodebox",
                -- top, bottom, side1, side2, inner, outer
		tiles = {"default_wood.png"},
		paramtype = "light",
		paramtype2 = "facedir",
		is_ground_content = true,
		groups = {snappy=2,choppy=2,oddly_breakable_by_hand=2},
		node_box = {
			type = "fixed",
			fixed = {

 				{ -0.5, -0.5, -0.3, -0.4,  0.5,  0.5},
 				{  0.5, -0.5, -0.3,  0.4,  0.5,  0.5},

				{ -0.5, -0.2, -0.3,  0.5, -0.1,  0.5},
				{ -0.5,  0.3, -0.3,  0.5,  0.4,  0.5},
			},
		},
		selection_box = {
			type = "fixed",
			fixed = {
				{ -0.5, -0.5, -0.5,  0.5, 0.5,  0.5},
			},
		},

		on_construct = function(pos)

                	local meta = minetest.env:get_meta(pos);

	                meta:set_string("formspec",
                                "size[8,8]"..
                                "list[current_name;main;0,0;8,3;]"..
                                "list[current_player;main;0,4;8,4;]")
                	meta:set_string("infotext", "open storage shelf")
                	local inv = meta:get_inventory();
                	inv:set_size("main", 24);
        	end,

	        can_dig = function( pos,player )
	                local  meta = minetest.env:get_meta( pos );
	                local  inv = meta:get_inventory();
	                return inv:is_empty("main");
	        end,

                on_metadata_inventory_put  = function(pos, listname, index, stack, player)
	                local  meta = minetest.env:get_meta( pos );
                        meta:set_string('infotext','open storage shelf (in use)');
                end,
                on_metadata_inventory_take = function(pos, listname, index, stack, player)
	                local  meta = minetest.env:get_meta( pos );
	                local  inv = meta:get_inventory();
	                if( inv:is_empty("main")) then
                           meta:set_string('infotext','open storage shelf (empty)');
                        end
                end,


})

-- so that the smoke from a furnace can get out of a building
minetest.register_node("random_buildings:stovepipe", {
		description = "stovepipe",
		drawtype = "nodebox",
		tiles = {"default_steel_block.png"},
		paramtype = "light",
		paramtype2 = "facedir",
		is_ground_content = true,
		groups = {snappy=2,choppy=2,oddly_breakable_by_hand=2},
		node_box = {
			type = "fixed",
			fixed = {
				{  0.20, -0.5, 0.20,  0.45, 0.5,  0.45},
			},
		},
		selection_box = {
			type = "fixed",
			fixed = {
				{  0.20, -0.5, 0.20,  0.45, 0.5,  0.45},
			},
		},
})


-- this washing place can be put over a water source (it is open at the bottom)
minetest.register_node("random_buildings:washing", {
		description = "washing place",
		drawtype = "nodebox",
                -- top, bottom, side1, side2, inner, outer
		tiles = {"default_clay.png"},
		paramtype = "light",
		paramtype2 = "facedir",
		is_ground_content = true,
		groups = {snappy=2,choppy=2,oddly_breakable_by_hand=2},
		node_box = {
			type = "fixed",
			fixed = {
				{ -0.5, -0.5, -0.5,  0.5, -0.2, -0.2},

				{ -0.5, -0.5, -0.2, -0.4, 0.2,  0.5},
				{  0.5, -0.5, -0.2,  0.4, 0.2,  0.5},

				{ -0.4, -0.5,  0.4,  0.4, 0.2,  0.5},
				{ -0.4, -0.5, -0.2,  0.4, 0.2, -0.1},

			},
		},
		selection_box = {
			type = "fixed",
			fixed = {
				{ -0.5, -0.5, -0.5,  0.5, 0.2,  0.5},
			},
		},
                on_rightclick = function(pos, node, player)
                   -- works only with water beneath
                   local node_under = minetest.env:get_node( {x=pos.x, y=(pos.y-1), z=pos.z} );
		   if( not( node_under ) or node_under.name == "ignore" or (node_under.name ~= 'default:water_source' and node_under.name ~= 'default:water_flowing')) then
                      minetest.chat_send_player( player:get_player_name(), "Sorry. This washing place is out of water. Please place it above water!");
		   else
                      minetest.chat_send_player( player:get_player_name(), "You feel much cleaner after some washing.");
		   end
                end,

})



---------------------------------------------------------------------------------------
-- crafting receipes
---------------------------------------------------------------------------------------
minetest.register_craft({
	output = "random_buildings:bed_foot",
	recipe = {
		{"wool:white",    "", "", },
		{"default:wood",  "", "", },
		{"default:stick", "", "", }
	}
})

minetest.register_craft({
	output = "random_buildings:bed_head",
	recipe = {
		{"", "",              "wool:white", },
		{"", "default:stick", "default:wood", },
		{"", "",              "default:stick", }
	}
})

minetest.register_craft({
	output = "random_buildings:sleeping_mat",
	recipe = {
		{"wool:white", "random_buildings:straw_mat","random_buildings:straw_mat" }
	}
})


minetest.register_craft({
	output = "random_buildings:table",
	recipe = {
		{"", "stairs:slab_wood", "", },
		{"", "default:stick", "" }
	}
})

minetest.register_craft({
	output = "random_buildings:bench",
	recipe = {
		{"",              "default:wood", "", },
		{"default:stick", "",             "default:stick", }
	}
})


minetest.register_craft({
	output = "random_buildings:shelf",
	recipe = {
		{"default:stick",  "default:wood", "default:stick", },
		{"default:stick", "default:wood", "default:stick", },
		{"default:stick", "",             "default:stick"}
	}
})

minetest.register_craft({
	output = "random_buildings:washing 2",
	recipe = {
		{"default:stick", },
		{"default:clay",  },
	}
})
