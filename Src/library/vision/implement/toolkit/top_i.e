-- Eiffel class generated by the 2.3 to 3 translator.

--|---------------------------------------------------------------
--|   Copyright (C) Interactive Software Engineering, Inc.      --
--|    270 Storke Road, Suite 7 Goleta, California 93117        --
--|                   (805) 685-1006                            --
--| All rights reserved. Duplication or distribution prohibited --
--|---------------------------------------------------------------

-- 

indexing

	date: "$Date$";
	revision: "$Revision$"

deferred class TOP_I 

inherit

	SHELL_I



	
feature 

	set_icon_name (a_name: STRING) is
			-- Set `icon_name' to `a_name'.
		require
			not_a_name_void: not (a_name = Void)
		deferred
		end; -- set_icon_name

	icon_name: STRING is
			-- Short form of application name to be displayed
			-- by the window manager when application is iconified
		deferred
		end; -- icon_name

	set_iconic_state is
			-- Set start state of the application to be iconic.
		deferred
		end; -- set_iconic_state

	set_normal_state is
			-- Set start state of the application to be normal.
		deferred
		end; -- set_normal_state

	is_iconic_state: BOOLEAN is
			-- Does application start in iconic state?
		deferred
		end -- is_iconic_state

end -- TOP_I
