note
	description: "Various helpers to avoid heavy code on the Eiffel side"
	date: "$Date$"
	revision: "$Revision$"

class
	GDK_HELPERS

feature -- Window

	window_at (a_x, a_y: TYPED_POINTER [INTEGER_32]): POINTER
			-- Obtain the window under the `default_device' and store its location in `a_x' and `a_y'.
		external
			"C inline use <ev_gtk.h>"
		alias
			"return (GdkWindow*) gdk_device_get_window_at_position((GdkDevice*) gdk_seat_get_pointer((GdkSeat*) gdk_display_get_default_seat ((GdkDisplay*) gdk_display_get_default())), (gint*) $a_x, (gint*) $a_y);"
		end

	device_get_position (device: POINTER; a_x, a_y: TYPED_POINTER [INTEGER_32])
		external
			"C inline use <ev_gtk.h>"
		alias
			"return gdk_device_get_position ((GdkDevice*) $device, NULL, (gint*) $a_x, (gint*) $a_y);"
		end

feature -- Quik access

	default_display: POINTER
			-- Default display.
		external
			"C inline use <ev_gtk.h>"
		alias
			"return (GdkDisplay*) gdk_display_get_default();"
		end

	default_seat: POINTER
			-- Seat associated to the `default_display'.
		external
			"C inline use <ev_gtk.h>"
		alias
			"return (GdkSeat*) gdk_display_get_default_seat ((GdkDisplay*) gdk_display_get_default());"
		end

	default_device: POINTER
			-- Device associated to the `default_seat'.
		external
			"C inline use <ev_gtk.h>"
		alias
			"return (GdkDevice*) gdk_seat_get_pointer((GdkSeat*) gdk_display_get_default_seat ((GdkDisplay*) gdk_display_get_default()));"
		end

	default_screen: POINTER
			-- Screen associated to the `default_display'.
		external
			"C inline use <ev_gtk.h>"
		alias
			"return (GdkScreen*) gdk_display_get_default_screen ((GdkDisplay*) gdk_display_get_default());"
		end

	default_cursor_size: INTEGER_32
			-- Size of cursors associated to the `default_display'.
		external
			"C inline use <ev_gtk.h>"
		alias
			"return gdk_display_get_default_cursor_size ((GdkDisplay*) gdk_display_get_default());"
		end

note
	copyright: "Copyright (c) 1984-2021, Eiffel Software and others"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"
end
