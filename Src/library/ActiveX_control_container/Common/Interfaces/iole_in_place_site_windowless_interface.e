note
	description: "Control interfaces. Help file: "
	legal: "See notice at end of class."
	status: "See notice at end of class."
	generator: "Automatically generated by the EiffelCOM Wizard."

deferred class
	IOLE_IN_PLACE_SITE_WINDOWLESS_INTERFACE

inherit
	IOLE_IN_PLACE_SITE_EX_INTERFACE

feature -- Status Report

	can_windowless_activate_user_precondition: BOOLEAN
			-- User-defined preconditions for `can_windowless_activate'.
			-- Redefine in descendants if needed.
		do
			Result := True
		end

	get_capture_user_precondition: BOOLEAN
			-- User-defined preconditions for `get_capture'.
			-- Redefine in descendants if needed.
		do
			Result := True
		end

	set_capture_user_precondition (f_capture: INTEGER): BOOLEAN
			-- User-defined preconditions for `set_capture'.
			-- Redefine in descendants if needed.
		do
			Result := True
		end

	get_focus_user_precondition: BOOLEAN
			-- User-defined preconditions for `get_focus'.
			-- Redefine in descendants if needed.
		do
			Result := True
		end

	set_focus_user_precondition (f_focus: INTEGER): BOOLEAN
			-- User-defined preconditions for `set_focus'.
			-- Redefine in descendants if needed.
		do
			Result := True
		end

	get_dc_user_precondition (p_rect: TAG_RECT_RECORD; grf_flags: INTEGER; ph_dc: CELL [POINTER]): BOOLEAN
			-- User-defined preconditions for `get_dc'.
			-- Redefine in descendants if needed.
		do
			Result := True
		end

	release_dc_user_precondition (h_dc: POINTER): BOOLEAN
			-- User-defined preconditions for `release_dc'.
			-- Redefine in descendants if needed.
		do
			Result := True
		end

	invalidate_rect_user_precondition (p_rect: TAG_RECT_RECORD; f_erase: INTEGER): BOOLEAN
			-- User-defined preconditions for `invalidate_rect'.
			-- Redefine in descendants if needed.
		do
			Result := True
		end

	invalidate_rgn_user_precondition (h_rgn: POINTER; f_erase: INTEGER): BOOLEAN
			-- User-defined preconditions for `invalidate_rgn'.
			-- Redefine in descendants if needed.
		do
			Result := True
		end

	scroll_rect_user_precondition (dx: INTEGER; dy: INTEGER; p_rect_scroll: TAG_RECT_RECORD; p_rect_clip: TAG_RECT_RECORD): BOOLEAN
			-- User-defined preconditions for `scroll_rect'.
			-- Redefine in descendants if needed.
		do
			Result := True
		end

	adjust_rect_user_precondition (prc: TAG_RECT_RECORD): BOOLEAN
			-- User-defined preconditions for `adjust_rect'.
			-- Redefine in descendants if needed.
		do
			Result := True
		end

	on_def_window_message_user_precondition (msg: INTEGER; w_param: INTEGER; l_param: INTEGER; pl_result: INTEGER_REF): BOOLEAN
			-- User-defined preconditions for `on_def_window_message'.
			-- Redefine in descendants if needed.
		do
			Result := True
		end

feature -- Basic Operations

	can_windowless_activate
			-- No description available.
		require
			can_windowless_activate_user_precondition: can_windowless_activate_user_precondition
		deferred

		end

	get_capture
			-- No description available.
		require
			get_capture_user_precondition: get_capture_user_precondition
		deferred

		end

	set_capture (f_capture: INTEGER)
			-- No description available.
			-- `f_capture' [in].  
		require
			set_capture_user_precondition: set_capture_user_precondition (f_capture)
		deferred

		end

	get_focus
			-- No description available.
		require
			get_focus_user_precondition: get_focus_user_precondition
		deferred

		end

	set_focus (f_focus: INTEGER)
			-- No description available.
			-- `f_focus' [in].  
		require
			set_focus_user_precondition: set_focus_user_precondition (f_focus)
		deferred

		end

	get_dc (p_rect: TAG_RECT_RECORD; grf_flags: INTEGER; ph_dc: CELL [POINTER])
			-- No description available.
			-- `p_rect' [in].  
			-- `grf_flags' [in].  
			-- `ph_dc' [out].  
		require
			non_void_p_rect: p_rect /= Void
			valid_p_rect: p_rect.item /= default_pointer
			non_void_ph_dc: ph_dc /= Void
			get_dc_user_precondition: get_dc_user_precondition (p_rect, grf_flags, ph_dc)
		deferred

		ensure
			valid_ph_dc: ph_dc.item /= Void
		end

	release_dc (h_dc: POINTER)
			-- No description available.
			-- `h_dc' [in].  
		require
			release_dc_user_precondition: release_dc_user_precondition (h_dc)
		deferred

		end

	invalidate_rect (p_rect: TAG_RECT_RECORD; f_erase: INTEGER)
			-- No description available.
			-- `p_rect' [in].  
			-- `f_erase' [in].  
		require
			invalidate_rect_user_precondition: invalidate_rect_user_precondition (p_rect, f_erase)
		deferred

		end

	invalidate_rgn (h_rgn: POINTER; f_erase: INTEGER)
			-- No description available.
			-- `h_rgn' [in].  
			-- `f_erase' [in].  
		require
			invalidate_rgn_user_precondition: invalidate_rgn_user_precondition (h_rgn, f_erase)
		deferred

		end

	scroll_rect (dx: INTEGER; dy: INTEGER; p_rect_scroll: TAG_RECT_RECORD; p_rect_clip: TAG_RECT_RECORD)
			-- No description available.
			-- `dx' [in].  
			-- `dy' [in].  
			-- `p_rect_scroll' [in].  
			-- `p_rect_clip' [in].  
		require
			non_void_p_rect_scroll: p_rect_scroll /= Void
			valid_p_rect_scroll: p_rect_scroll.item /= default_pointer
			non_void_p_rect_clip: p_rect_clip /= Void
			valid_p_rect_clip: p_rect_clip.item /= default_pointer
			scroll_rect_user_precondition: scroll_rect_user_precondition (dx, dy, p_rect_scroll, p_rect_clip)
		deferred

		end

	adjust_rect (prc: TAG_RECT_RECORD)
			-- No description available.
			-- `prc' [in, out].  
		require
			non_void_prc: prc /= Void
			valid_prc: prc.item /= default_pointer
			adjust_rect_user_precondition: adjust_rect_user_precondition (prc)
		deferred

		end

	on_def_window_message (msg: INTEGER; w_param: INTEGER; l_param: INTEGER; pl_result: INTEGER_REF)
			-- No description available.
			-- `msg' [in].  
			-- `w_param' [in].  
			-- `l_param' [in].  
			-- `pl_result' [out].  
		require
			non_void_pl_result: pl_result /= Void
			on_def_window_message_user_precondition: on_def_window_message_user_precondition (msg, w_param, l_param, pl_result)
		deferred

		end

note
	copyright:	"Copyright (c) 1984-2006, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"




end -- IOLE_IN_PLACE_SITE_WINDOWLESS_INTERFACE

