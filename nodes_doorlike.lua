
-----------------------------------------------------------------------------------------------------------
-- These nodes are all like doors in a way:
--  * window shutters (they open on right-click and when it turns day; they close at night)
--  * a half-door where the top part can be opened seperately from the bottom part
--  * a gate that drops to the floor when opened
--
-----------------------------------------------------------------------------------------------------------
-- IMPORTANT NOTICE: If you have a very slow computer, it might be wise to increase the rate at which the
--                   abm that opens/closes the window shutters is called. Anything less than 10 minutes
--                   (600 seconds) ought to be ok.
-----------------------------------------------------------------------------------------------------------


-----------------------------------------------------------------------------------------------------------
-- small window shutters for single-node-windows; they open at day and close at night if the abm is working
-----------------------------------------------------------------------------------------------------------

-- window shutters - they cover half a node to each side
minetest.register_node("random_buildings:window_shutter_open", {
		description = "opened window shutters",
		drawtype = "nodebox",
                -- top, bottom, side1, side2, inner, outer
		tiles = {"default_wood.png"},
		paramtype = "light",
		paramtype2 = "facedir",
		is_ground_content = true,
		groups = {snappy=2,choppy=2,oddly_breakable_by_hand=2},
                -- larger than one node but slightly smaller than a half node so that wallmounted torches pose no problem
		node_box = {
			type = "fixed",
			fixed = {
				{-0.45, -0.5,  0.4, -0.9, 0.5,  0.5},
				{ 0.45, -0.5,  0.4,  0.9, 0.5,  0.5},
			},
		},
		selection_box = {
			type = "fixed",
			fixed = {
				{-0.9, -0.5,  0.4,  0.9, 0.5,  0.5},
			},
		},
		drop = "random_buildings:window_shutter_closed",
                on_rightclick = function(pos, node, puncher)
                    minetest.env:add_node(pos, {name = "random_buildings:window_shutter_closed", param2 = node.param2})
                end,
})

minetest.register_node("random_buildings:window_shutter_closed", {
		description = "closed window shutters",
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
				{-0.5, -0.5,  0.4, -0.05, 0.5,  0.5},
				{ 0.5, -0.5,  0.4,  0.05, 0.5,  0.5},
			},
		},
		selection_box = {
			type = "fixed",
			fixed = {
				{-0.5, -0.5,  0.4,  0.5, 0.5,  0.5},
			},
		},
                on_rightclick = function(pos, node, puncher)
                    minetest.env:add_node(pos, {name = "random_buildings:window_shutter_open", param2 = node.param2})
                end,
})


-- open shutters in the morning
minetest.register_abm({
   nodenames = {"random_buildings:window_shutter_closed"},
   interval = 20, -- change this to 600 if your machine is too slow
   chance = 3, -- not all people wake up at the same time!
   action = function(pos)

        -- at this time, sleeping in a bed is not possible
        if( not(minetest.env:get_timeofday() < 0.2 or minetest.env:get_timeofday() > 0.805)) then
           local old_node = minetest.env:get_node( pos );
           minetest.env:add_node(pos, {name = "random_buildings:window_shutter_open", param2 = old_node.param2})
       end
   end
})


-- close them at night
minetest.register_abm({
   nodenames = {"random_buildings:window_shutter_open"},
   interval = 20, -- change this to 600 if your machine is too slow
   chance = 2,
   action = function(pos)

        -- same time at which sleeping is allowed in beds
        if( minetest.env:get_timeofday() < 0.2 or minetest.env:get_timeofday() > 0.805) then
           local old_node = minetest.env:get_node( pos );
           minetest.env:add_node(pos, {name = "random_buildings:window_shutter_closed", param2 = old_node.param2})
        end
   end
})


------------------------------------------------------------------------------------------------------------------------------
-- a half door; can be combined to a full door where the upper part can be operated seperately; usually found in barns/stables
------------------------------------------------------------------------------------------------------------------------------
minetest.register_node("random_buildings:half_door", {
		description = "half door",
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
				{-0.5, -0.5,  0.4,  0.48, 0.5,  0.5},
			},
		},
		selection_box = {
			type = "fixed",
			fixed = {
				{-0.5, -0.5,  0.4,  0.48, 0.5,  0.5},
			},
		},
                on_rightclick = function(pos, node, puncher)
                    local node2 = minetest.env:get_node( {x=pos.x,y=(pos.y+1),z=pos.z});

                    local param2 = node.param2;
                    if(     param2 == 1) then param2 = 2;
                    elseif( param2 == 2) then param2 = 1;
                    elseif( param2 == 3) then param2 = 0;
                    elseif( param2 == 0) then param2 = 3;
                    end;
                    minetest.env:add_node(pos, {name = "random_buildings:half_door", param2 = param2})
                    -- if the node above consists of a door of the same type, open it as well
                    -- Note: doors beneath this one are not opened! It is a special feature of these doors that they can be opend partly
                    if( node2 ~= nil and node2.name == node.name and node2.param2==node.param2) then
                       minetest.env:add_node( {x=pos.x,y=(pos.y+1),z=pos.z}, {name = "random_buildings:half_door", param2 = param2})
                    end
                end,
})



minetest.register_node("random_buildings:half_door_inverted", {
		description = "half door",
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
				{-0.5, -0.5, -0.5,  0.48, 0.5, -0.4},
			},
		},
		selection_box = {
			type = "fixed",
			fixed = {
				{-0.5, -0.5, -0.5,  0.48, 0.5, -0.4},
			},
		},
                on_rightclick = function(pos, node, puncher)
                    local node2 = minetest.env:get_node( {x=pos.x,y=(pos.y+1),z=pos.z});

                    local param2 = node.param2;
                    if(     param2 == 1) then param2 = 0;
                    elseif( param2 == 0) then param2 = 1;
                    elseif( param2 == 2) then param2 = 3;
                    elseif( param2 == 3) then param2 = 2;
                    end;
                    minetest.env:add_node(pos, {name = "random_buildings:half_door_inverted", param2 = param2})
                    -- open upper parts of this door (if there are any)
                    if( node2 ~= nil and node2.name == node.name and node2.param2==node.param2) then
                       minetest.env:add_node( {x=pos.x,y=(pos.y+1),z=pos.z}, {name = "random_buildings:half_door_inverted", param2 = param2})
                    end
                end,
})




------------------------------------------------------------------------------------------------------------------------------
-- this gate for fences solves the "where to store the opened gate" problem by dropping it to the floor in optened state
------------------------------------------------------------------------------------------------------------------------------
minetest.register_node("random_buildings:gate_closed", {
		description = "closed fence gate",
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
				{ -0.85, -0.25, -0.02,  0.85, -0.05,  0.02},
				{ -0.85,  0.15, -0.02,  0.85,  0.35,  0.02},

				{ -0.80, -0.05, -0.02, -0.60,  0.15,  0.02},
				{  0.60, -0.05, -0.02,  0.80,  0.15,  0.02},
				{ -0.15, -0.05, -0.02,  0.15,  0.15,  0.02},
			},
		},
		selection_box = {
			type = "fixed",
			fixed = {
				{ -0.85, -0.25, -0.1,  0.85,  0.35,  0.1},
			},
		},
                on_rightclick = function(pos, node, puncher)
                    minetest.env:add_node(pos, {name = "random_buildings:gate_open", param2 = node.param2})
                end,
})


minetest.register_node("random_buildings:gate_open", {
		description = "opened fence gate",
		drawtype = "nodebox",
                -- top, bottom, side1, side2, inner, outer
		tiles = {"default_wood.png"},
		paramtype = "light",
		paramtype2 = "facedir",
		is_ground_content = true,
		drop = "random_buildings:gate_closed",
		groups = {snappy=2,choppy=2,oddly_breakable_by_hand=2},
		node_box = {
			type = "fixed",
			fixed = {
				{ -0.85, -0.5, -0.25,  0.85, -0.46, -0.05},
				{ -0.85, -0.5,  0.15,  0.85, -0.46,  0.35},

				{ -0.80, -0.5, -0.05, -0.60, -0.46,  0.15},
				{  0.60, -0.5, -0.05,  0.80, -0.46,  0.15},
				{ -0.15, -0.5, -0.05,  0.15, -0.46,  0.15},

			},
		},
		selection_box = {
			type = "fixed",
			fixed = {
				{ -0.85, -0.5, -0.25, 0.85, -0.3, 0.35},
			},
		},
                on_rightclick = function(pos, node, puncher)
                    minetest.env:add_node(pos, {name = "random_buildings:gate_closed", param2 = node.param2})
                end,
})


-----------------------------------------------------------------------------------------------------------
-- and now the crafting receipes:
-----------------------------------------------------------------------------------------------------------

-- transform opend and closed shutters into each other for convenience
minetest.register_craft({
	output = "random_buildings:window_shutter_open",
	recipe = {
		{"random_buildings:window_shutter_closed" },
	}
})

minetest.register_craft({
	output = "random_buildings:window_shutter_closed",
	recipe = {
		{"random_buildings:window_shutter_open" },
	}
})

minetest.register_craft({
	output = "random_buildings:window_shutter_open",
	recipe = {
		{"default:wood", "", "default:wood" },
	}
})

-- transform one half door into another
minetest.register_craft({
	output = "random_buildings:half_door",
	recipe = {
		{"random_buildings:half_door_inverted" },
	}
})

minetest.register_craft({
	output = "random_buildings:half_door_inverted",
	recipe = {
		{"random_buildings:half_door" },
	}
})

minetest.register_craft({
	output = "random_buildings:half_door 2",
	recipe = {
		{"", "default:wood", "" },
		{"", "door:door_wood", "" },
	}
})


-- transform open and closed versions into into another for convenience
minetest.register_craft({
	output = "random_buildings:gate_closed",
	recipe = {
		{"random_buildings:gate_open" },
	}
})

minetest.register_craft({
	output = "random_buildings:gate_open",
	recipe = {
		{"random_buildings:gate_closed"},
	}
})

minetest.register_craft({
	output = "random_buildings:gate_closed",
	recipe = {
		{"default:stick", "default:stick", "default:wood" },
	}
})
