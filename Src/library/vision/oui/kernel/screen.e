--|---------------------------------------------------------------
--|   Copyright (C) Interactive Software Engineering, Inc.      --
--|    270 Storke Road, Suite 7 Goleta, California 93117        --
--|                   (805) 685-1006                            --
--| All rights reserved. Duplication or distribution prohibited --
--|---------------------------------------------------------------

-- Screen. An object of this class must be created before any other
-- operation of this screen. It will parent of TOP_SHELL or BASE.
-- The screen is also a drawing and thus can be used for a world.
-- Warning: used screen as a drawing can be non-portable. It will work
-- fin one X window version but the other platforms may not accept it.

indexing

	date: "$Date$";
	revision: "$Revision$"

class SCREEN 

inherit

	G_ANY
		export
			{NONE} all
		end;

	DRAWING

creation

	make

feature 

	buttons: BUTTONS is
			-- Current state of the mouse buttons
		do
			Result := implementation.buttons
		ensure
			not (Result = Void)
		end; -- buttons

	make (a_screen_name: STRING) is
			-- Create a screen specified by `a_screen_name'.
		require
			screen_name_exists: not (a_screen_name = Void)
		do
			screen_name := a_screen_name.duplicate;
			implementation := toolkit.screen (current)
		end; -- Create

	height: INTEGER is
			-- Height of screen (in pixel)
		do
			Result := implementation.height
		ensure
			height_large_enough: Result >= 0
		end; -- height

	implementation: SCREEN_I;
			-- Implementation of current screen

	same (other: like Current): BOOLEAN is
			-- Does the current screen and `other' representing the
			-- same screen ?
		require else
			other_exists: not (other = Void)
		do
			Result := other.implementation = implementation
		end; -- same

	screen_name: STRING;
			-- Screen name

	widget_pointed: WIDGET is
			-- Widget currently pointed by the pointer
		do
			Result := implementation.widget_pointed
		end; -- widget_pointed

	width: INTEGER is
			-- Width of screen (in pixel)
		do
			Result := implementation.width
		ensure
			width_large_enough: Result >= 0
		end; -- width

	x: INTEGER is
			-- Current absolute horizontal coordinate of the mouse
		do
			Result := implementation.x
		ensure
			position_positive: Result >= 0;
			position_small_enough: Result < width
		end; -- x

	y: INTEGER is
			-- Current absolute vertical coordinate of the mouse
		do
			Result := implementation.y
		ensure
			position_positive: Result >= 0;
			position_small_enough: Result < height
		end -- y

end
