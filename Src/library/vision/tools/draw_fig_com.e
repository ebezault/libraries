--|---------------------------------------------------------------
--|   Copyright (C) Interactive Software Engineering, Inc.      --
--|    270 Storke Road, Suite 7 Goleta, California 93117        --
--|                   (805) 685-1006                            --
--| All rights reserved. Duplication or distribution prohibited --
--|---------------------------------------------------------------

-- Command to refresh a figure or a world.

class DRAW_FIG_COM 

inherit

	COMMAND
		redefine
			context_data_useful
		end

feature 

	context_data_useful: BOOLEAN is true;
			-- This command need a context data

	execute (argument: ANY) is
			-- Draw a figure.
		local
			figure: FIGURE;
			world: WORLD;
			expose_data: EXPOSE_DATA;
			drawing: DRAWING;
			drawing_area: DRAWING_AREA;
			draw_b: DRAW_B
		do
			expose_data ?= context_data;
			drawing_area ?= expose_data.widget;
			if (drawing_area = Void) then
				draw_b ?= expose_data.widget;
				drawing := draw_b
			else
				drawing := drawing_area
			end;
			check
				not (drawing = Void)
			end;
			drawing.set_clip (expose_data.clip);
			world ?= argument;
			if (world = Void) then
				figure ?= argument;
				figure.draw
			else
				world.draw
			end;
			drawing.set_no_clip
		end;

end
