indexing
	description: "Receives and dispatch the Windows messages to the Eiffel objects."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

deferred class
	WEL_ABSTRACT_DISPATCHER

inherit
	WEL_WINDOW_MANAGER
		export
			{NONE} all
		end

	WEL_DATA_TYPE
		export
			{NONE} all
		end
		
	WEL_WM_CONSTANTS
		export
			{NONE} all
		end

	WEL_EN_CONSTANTS	
		-- debug

feature -- Settings

	set_exception_callback (an_action: like exception_callback) is
			-- Set `exception_callback' with `an_action'.
		do
			exception_callback := an_action
		ensure
			excetption_callback_set: exception_callback = an_action
		end

feature {NONE} -- Implementation: Access

	exception_callback: PROCEDURE [ANY, TUPLE [EXCEPTION]]
			-- Action being executed when an exception occurs during

feature {NONE} -- Implementation

	frozen window_procedure (hwnd: POINTER; msg: INTEGER; wparam, lparam: POINTER): POINTER is
			-- Window messages dispatcher routine
		local
			window: WEL_WINDOW
			returned_value: POINTER
			has_return_value: BOOLEAN
			need_decrement: BOOLEAN
			retried: BOOLEAN
		do
			if not retried then
				window := window_of_item (hwnd)
				if window /= Void then
					if window.exists then
						debug ("win_dispatcher")
							print ("After look at windows table ")
							print (window.generating_type)
							io.put_new_line
						end
						window.increment_level
						need_decrement := True
		
						Result := window.process_message (hwnd, msg, wparam, lparam)
							--| Store `message_return_value' and `has_return_value' for later
							--| use, since `call_default_window_procedure' can reset their value.
						if
							window.has_return_value
						then
							returned_value := window.message_return_value
							has_return_value := window.has_return_value
						end
		
						if window.default_processing then
							Result := window.call_default_window_procedure (hwnd, msg, wparam, lparam)
						end
		
						if has_return_value then
							Result := returned_value
						end
		
						window.decrement_level
						need_decrement := False
					else
						Result := window.call_default_window_procedure (hwnd, msg, wparam, lparam)
					end
				else
					Result := cwin_def_window_proc (hwnd, msg, wparam, lparam)
				end
			else
					-- Something wrong occurred here, perform default action
				Result := cwin_def_window_proc (hwnd, msg, wparam, lparam)
					-- And call `exception_callback' if it is set
				if exception_callback /= Void then
					exception_callback.call ([new_exception])
				end
			end
		rescue
			if window /= Void and then need_decrement then
				window.decrement_level
			end
			retried := True
			retry
		end

	frozen dialog_procedure (hwnd: POINTER; msg: INTEGER; wparam, lparam: POINTER): POINTER is
			-- Dialog box messages dispatcher routine
		local
			window: WEL_WINDOW
			last_result: POINTER
			need_decrement: BOOLEAN
			retried: BOOLEAN
		do
			if not retried then
				debug ("dlg_dispatcher")
					io.put_string ("in dlg_proc ")
					io.put_string (hwnd.out)
					io.put_character (' ')
					io.put_integer (msg)
					io.put_character (' ')
					io.put_boolean (msg = Wm_initdialog)
					io.put_new_line
				end
				if msg = Wm_initdialog then
					window := new_dialog
					if window /= Void then
						new_dialog_cell.put (Void)
						window.increment_level
						need_decrement := True
		
						-- Special case for the message
						-- Wm_initdialog. We set the hwnd value
						-- to the object because this value
						-- was unknown until now.
						--| Since it is not possible to check
						--| if `set_focus' from WEL_WINDOW has been
						--| called, Result is set to `1'.
						--| As a result, any call to `set_focus' in
						--| `setup_dialog' from WEL_DIALOG is useless.
						window.set_item (hwnd)
						register_window (window)
						Result := window.process_message (hwnd, msg, wparam, lparam)
						window.decrement_level
						need_decrement := False
					end
					Result := to_lresult (1)
				else
					window := window_of_item (hwnd)
					if window /= Void and window.exists then
						window.increment_level
						need_decrement := True
						last_result := window.process_message (hwnd, msg, wparam, lparam)
						if window.has_return_value then
							Result := window.message_return_value
						else
							if not window.default_processing then
								Result := to_lresult (1)
							else
								Result := to_lresult (0)
							end
						end
						window.decrement_level
						need_decrement := False
					end
				end
			else
					-- Something wrong occurred here, perform default action
				Result := to_lresult (0)
					-- And call `exception_callback' if it is set
				if exception_callback /= Void then
					exception_callback.call ([new_exception])
				end
			end
		rescue
			if window /= Void and then need_decrement then
				window.decrement_level
			end
			retried := True
			retry
		end

	new_exception: EXCEPTION is
			-- New exception object representating the last exception caught in Current
		local
			l_exceptions: EXCEPTIONS
			l_tag: STRING
			l_trace: STRING
		do
			create l_exceptions
			l_tag := l_exceptions.tag_name
			l_trace := l_exceptions.exception_trace
			if l_tag = Void and l_trace = Void then
				create Result.make_with_tag_and_trace ("No tag", "No trace")
			elseif l_tag = Void then
				create Result.make_with_tag_and_trace ("No tag", l_trace)
			elseif l_trace = Void then
				create Result.make_with_tag_and_trace (l_tag, "No trace")
			else
				create Result.make_with_tag_and_trace (l_tag, l_trace)
			end
		ensure
			new_exception_not_void: Result /= Void
		end

feature {NONE} -- Externals

	cwin_def_window_proc (hwnd: POINTER; msg: INTEGER; wparam, lparam: POINTER): POINTER is
			-- SDK DefWindowProc
		external
			"C [macro <windows.h>] (HWND, UINT, WPARAM, LPARAM): LRESULT"
		alias
			"DefWindowProc"
		end

end -- class WEL_ABSTRACT_DISPATCHER

--|----------------------------------------------------------------
--| Windows Eiffel Library: library of reusable components for ISE Eiffel.
--| Copyright (C) 1985-2004 Eiffel Software. All rights reserved.
--| Duplication and distribution prohibited.  May be used only with
--| ISE Eiffel, under terms of user license.
--| Contact Eiffel Software for any other use.
--|
--| Interactive Software Engineering Inc.
--| dba Eiffel Software
--| 356 Storke Road, Goleta, CA 93117 USA
--| Telephone 805-685-1006, Fax 805-685-6869
--| Contact us at: http://www.eiffel.com/general/email.html
--| Customer support: http://support.eiffel.com
--| For latest info on our award winning products, visit:
--|	http://www.eiffel.com
--|----------------------------------------------------------------

