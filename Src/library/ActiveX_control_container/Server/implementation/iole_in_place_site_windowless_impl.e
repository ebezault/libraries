indexing
	description: "Implemented `IOleInPlaceSiteWindowless' Interface."
	date: "$Date$"
	revision: "$Revision$"

deferred class
	IOLE_IN_PLACE_SITE_WINDOWLESS_IMPL

inherit
	IOLE_IN_PLACE_SITE_WINDOWLESS_INTERFACE

	OLE_CONTROL_PROXY
	
	ECOM_EXCEPTION
		redefine
			dispose
		end
	
	OLE_CONTROL_PROXY
	
	ECOM_FLAGS
	
	AMBIENT_PROPERTIES

	WEL_WINDOW
		rename
			class_name as wel_class_name,
			exists as wel_exists,
			has_capture as wel_has_capture,
			has_heavy_capture as wel_has_heavy_capture,
			invalidate_rect as wel_invalidate_rect,
			item as wel_item,
			release_capture as wel_release_capture,
			set_capture as wel_set_capture,
			set_focus as wel_set_focus,
			set_item as wel_set_item,
			scroll as wel_scroll
		redefine
			process_message,
			on_size,
			on_set_focus,
			on_kill_focus,
			on_destroy,
			dispose
		end
	
	DVASPECT_ENUM
	
	HIT_RESULT_ENUM
		
feature -- Basic Operations

	get_window (phwnd: CELL [POINTER]) is
			-- Returns the window handle to one of the windows
			-- participating in in-place activation (frame,
			-- document, parent, or in-place object window).
			-- `phwnd' [out].  
		do
			phwnd.put (wel_item)
		end

	context_sensitive_help (f_enter_mode: INTEGER) is
			-- Determines whether context-sensitive help mode
			-- should be entered during an in-place activation
			-- session.
			-- `f_enter_mode' [in].  
		do
			trigger (E_notimpl)
		end

	can_in_place_activate is
			-- Determines whether or not the container can
			-- activate the object in place.
		do
			-- No Implementation.
		end

	on_in_place_activate is
			-- Notifies the container that one of its objects is
			-- being activated in place.
		local
			l_ole_in_place_object: IOLE_IN_PLACE_OBJECT_IMPL_PROXY
		do
			check
				non_void_ole_object: ole_object /= Void
			end
			m_place_active := True
			ole_lock_running (ole_object.item, True, False)
			m_windowless := False
			l_ole_in_place_object := ole_in_place_object
		end

	on_uiactivate is
			-- Notifies the container that the object is about
			-- to be activated in place and that the object is
			-- going to replace the container's main menu with
			-- an in-place composite menu.
		do
			m_ui_active := True
		end

	get_window_context (pp_frame: CELL [IOLE_IN_PLACE_FRAME_INTERFACE]; pp_doc: CELL [IOLE_IN_PLACE_UIWINDOW_INTERFACE]; lprc_pos_rect: TAG_RECT_RECORD; lprc_clip_rect: TAG_RECT_RECORD; lp_frame_info: TAG_OIFI_RECORD) is
			-- Enables the in-place object to retrieve the
			-- window interfaces that form the window object 
			-- hierarchy, and the position in the parent window 
			-- where the object's in-place activation window
			-- should be placed.
			-- `pp_frame' [out].  
			-- `pp_doc' [out].  
			-- `lprc_pos_rect' [out].  
			-- `lprc_clip_rect' [out].  
			-- `lp_frame_info' [in, out].  
		local
			frame_window: FRAME_WINDOW
			ui_window: UI_WINDOW
			
			l_rect: WEL_RECT
			accelerator: WEL_ACCELERATOR
			an_array: WEL_ARRAY [WEL_ACCELERATOR]
			accelerators: WEL_ACCELERATORS
		do
			if m_in_place_frame_proxy = Void then
				create frame_window.make
				frame_window.create_item
				create m_in_place_frame_proxy.make_from_other (frame_window)
			end
			pp_frame.put (m_in_place_frame_proxy)
			
			if m_in_place_uiwindow = Void then
				create ui_window.make
				ui_window.create_item
				create m_in_place_uiwindow.make_from_other (ui_window)
			end
			pp_doc.put (m_in_place_uiwindow)
			
			l_rect := client_rect
			lprc_pos_rect.set_from_rect (l_rect)
			lprc_clip_rect.set_from_rect (l_rect)
			
			create accelerator.make (0, 0, 0)
			create an_array.make (1, accelerator.structure_size)
			an_array.put (accelerator, 0)
			
			create accelerators.make_with_array (an_array)
			
			lp_frame_info.set_cb (lp_frame_info.structure_size)
			lp_frame_info.set_f_mdiapp (0)
			lp_frame_info.set_hwnd_frame (parent_item)
			lp_frame_info.set_h_accel (accelerators.item)
			lp_frame_info.set_c_accel_entries (1)
		end

	scroll (scroll_extant: TAG_SIZE_RECORD) is
			-- Specifies the number of pixels by which 
			-- the container is to scroll the object. 
			-- `scroll_extant' [in].  
		do
			wel_scroll (scroll_extant.cx, scroll_extant.cy)
		end

	on_uideactivate (f_undoable: INTEGER) is
			-- Notifies the container to reinstall its 
			-- user interface and take focus. 
			-- `f_undoable' [in].  
		do
			m_ui_active := False
		end

	on_in_place_deactivate is
			-- Notifies the container that the object 
			-- is no longer active in place. 
		do
			m_place_active := False
			m_ole_in_place_object := Void
		end

	discard_undo_state is
			-- Instructs the container to discard its undo state.
		do
			-- No Implementation.
		end

	deactivate_and_undo is
			-- Deactivate the object and revert to undo state.
		do
			-- No Implementation.
		end

	on_pos_rect_change (lprc_pos_rect: TAG_RECT_RECORD) is
			-- Object's extents have changed.
			-- `lprc_pos_rect' [in].  
		do
			-- No Implementation.
		end

	on_in_place_activate_ex (pf_no_redraw: INTEGER_REF; dw_flags: INTEGER) is
			-- Called by the embedded object to determine if 
			-- it needs to redraw itself upon activation.
			-- `pf_no_redraw' [out].  
			-- `dw_flags' [in].  
		local
			l_ole_in_place_object: IOLE_IN_PLACE_OBJECT_INTERFACE
		do
			check
				non_void_ole_object: ole_object /= Void
			end
			m_place_active := True
			ole_lock_running (ole_object.item, True, False)
			if binary_and (dw_flags, Activate_windowless) /= 0 then
				m_windowless := True
				l_ole_in_place_object := ole_in_place_object_windowless
			end
			if l_ole_in_place_object = Void then
				m_windowless := False
				l_ole_in_place_object := ole_in_place_object
			end
			if l_ole_in_place_object /= Void then
				l_ole_in_place_object.set_object_rects (m_Position, m_position)
			end
		end

	on_in_place_deactivate_ex (f_no_redraw: INTEGER) is
			-- Notifies the container of whether the object 
			-- needs to be redrawn upon deactivation.
			-- `f_no_redraw' [in].  
		do
			-- No Implementation.
		end

	request_uiactivate is
			-- Notifies the container that the object is 
			-- about to enter the UI-active state.
		do
			-- No Implementation.
		end

	can_windowless_activate is
			-- Informs an object if its container can support it 
			-- as a windowless object that can be in-place activated.
		do
			if not m_allow_windowless_activation then
				trigger (S_false)
			end
		end

	get_capture is
			-- Called by an in-place active, windowless object to
			-- determine if it still has the mouse capture or not.
		do
			if not wel_has_capture then
				trigger (S_false)
			end
		end

	set_capture (f_capture: INTEGER) is
			-- Enables an in-place active, windowless object 
			-- to capture all mouse messages.
			-- `f_capture' [in].  
		do
			if f_capture.to_boolean then
				wel_set_capture
				m_capture := True
			else
				wel_release_capture
				m_capture := False
			end
		end

	get_focus is
			-- Called by an in-place active, windowless object 
			-- to determine if it still has the keyboard focus 
			-- or not.
		do
			-- No Implementation.
		end

	set_focus (f_focus: INTEGER) is
			-- Sets the keyboard focus for a UI-active, 
			-- windowless object.
			-- `f_focus' [in].  
		do
			-- No Implementation.
		end

	get_dc (p_rect: TAG_RECT_RECORD; grf_flags: INTEGER; ph_dc: CELL [POINTER]) is
			-- Provides an object with a handle to a device context
			-- for a screen or compatible device from its container.
			-- `p_rect' [in].  
			-- `grf_flags' [in].  
			-- `ph_dc' [out].  
		do
			check
				void_dc: m_client_dc = Void
			end
			create m_client_dc.make (Current)
			m_client_dc.get
			ph_dc.put (m_client_dc.item)
		end

	release_dc (h_dc: POINTER) is
			-- Releases the device context previously obtained 
			-- by a call to IOleInPlaceSiteWindowless::GetDC.
			-- `h_dc' [in].  
		do
			if h_dc = m_client_dc.item then
				m_client_dc.release
				m_client_dc := Void
			end
		end

	invalidate_rect (p_rect: TAG_RECT_RECORD; f_erase: INTEGER) is
			-- Enables an object to invalidate a specified 
			-- rectangle of its in-place image on the screen.
			-- 
			-- `p_rect' [in]. Rectangle to invalidate, in client
			-- coordinates of the containing window. If this 
			-- parameter is Void, the object's full extent is
			-- invalidated. 
			-- `f_erase' [in]. Specifies whether the background 
			-- within the update region is to be erased when the 
			-- region is updated. If this parameter is TRUE, the
			-- background is erased. If this parameter is FALSE, 
			-- the background remains unchanged. 
		do
			wel_invalidate_rect (p_rect.wel_rect, f_erase.to_boolean)
		end

	invalidate_rgn (h_rgn: POINTER; f_erase: INTEGER) is
			-- Enables an object to invalidate a specified 
			-- region of its in-place image on the screen.
			-- `h_rgn' [in].  
			-- `f_erase' [in].  
		local
			wel_region: WEL_REGION
		do
			create wel_region.make_by_pointer (h_rgn)
			invalidate_region (wel_region, f_erase.to_boolean)
		end

	scroll_rect (dx: INTEGER; dy: INTEGER; p_rect_scroll: TAG_RECT_RECORD; p_rect_clip: TAG_RECT_RECORD) is
			-- Enables an object to scroll an area within 
			-- its in-place active image on the screen.
			-- `dx' [in].  
			-- `dy' [in].  
			-- `p_rect_scroll' [in].  
			-- `p_rect_clip' [in].  
		do
			-- No Implementation.
		end

	adjust_rect (prc: TAG_RECT_RECORD) is
			-- Adjusts a specified rectangle if it is entirely 
			-- or partially covered by overlapping, opaque objects.
			-- `prc' [in, out].  
		do
			-- No Implementation.
		end

	on_def_window_message (msg: INTEGER; w_param: INTEGER; l_param: INTEGER; pl_result: INTEGER_REF) is
			-- Invokes the default processing for all messages 
			-- passed to an object.
			-- `msg' [in].  
			-- `w_param' [in].  
			-- `l_param' [in].  
			-- `pl_result' [out].  
		do
			pl_result.set_item (call_default_window_procedure (msg, w_param, l_param))
		end

feature {NONE} -- Messages

	on_size (size_type, a_width, a_height: INTEGER) is
			-- Wm_size message
			-- See class WEL_SIZE_CONSTANTS for `size_type' value
		do
			check 
				non_void_position: m_position /= Void
			end
			m_position.set_right (m_position.left + a_width)
			m_position.set_bottom (m_position.top + a_height)
			
			
		end

	on_set_focus is
			-- Wm_setfocus message
		do
		end

	on_kill_focus is
			-- Wm_killfocus message
		do
		end
		
	on_mouse_message (msg, wparam, lparam: INTEGER): INTEGER is
			-- On mouse message.
		local
			result_ref: INTEGER_REF
		do
			if 
				m_place_active and 
				m_windowless and 
				ole_in_place_object_windowless /= Void 
			then
				create result_ref
				ole_in_place_object_windowless.on_window_message (msg, wparam, lparam, result_ref)
				Result := result_ref.item
			end
		end

	on_destroy is
			-- Wm_destroy message.
			-- The window is about to be destroyed.
		do
		end

	reflect_notifications (msg, wparam, lparam: INTEGER): INTEGER is
			-- 
		require
		local
			child_handle: POINTER
		do
		ensure
		end

	on_wm_paint (wparam: INTEGER) is
			-- Wm_paint message.
			-- A WEL_DC and WEL_PAINT_STRUCT are created and
			-- passed to the `on_paint' routine.
			-- To be more efficient when the windows does not
			-- need to paint something, this routine can be
			-- redefined to do nothing (eg. The object creation are
			-- useless).
		require
			wel_exists: wel_exists
		local
			paint_dc: WEL_PAINT_DC
		do
			create paint_dc.make_by_pointer (Current, cwel_integer_to_pointer(wparam))
			paint_dc.get
			on_paint (paint_dc, paint_dc.paint_struct.rect_paint)
			paint_dc.release
		end

	on_paint (paint_dc: WEL_PAINT_DC; invalid_rect: WEL_RECT) is
			-- Wm_paint message.
			-- May be redefined to paint something on
			-- the `paint_dc'. `invalid_rect' defines
			-- the invalid rectangle of the client area that
			-- needs to be repainted.
		require
			paint_dc_not_void: paint_dc /= Void
			paint_dc_exists: paint_dc.exists
			invalid_rect_not_void: invalid_rect /= Void
		do
		end
	
	on_forward_message (lparam: INTEGER) is
			-- 
		require
			
		do
			
		end
		
feature {WEL_DISPATCHER, WEL_WINDOW} -- Implementation

	process_message (hwnd: POINTER; msg, wparam, lparam: INTEGER): INTEGER is
			-- Call the routine `on_*' corresponding to the
			-- message `msg'.
		local
			point_mouse: TAG_POINT_RECORD
			hit_result: INTEGER
			hit_result_ref: INTEGER_REF
		do
			if m_windowless then
				if m_capture then
					hit_result := Hitresult_hit
				else
					hit_result := Hitresult_outside
				end
				if 
					not m_capture and view_object_ex /= Void 
				then
					create point_mouse.make
					point_mouse.set_x (c_mouse_message_x (lparam))
					point_mouse.set_y (c_mouse_message_y (lparam))
					create hit_result_ref
					view_object_ex.query_hit_point (Dvaspect_content,
										m_position, 
										point_mouse, 
										0, 
										hit_result_ref)
					hit_result := hit_result_ref.item
				end
				if 
					hit_result = Hitresult_hit and
					(msg = Wm_mousemove or
					msg = Wm_setcursor or
					msg = Wm_lbuttonup or
					msg = Wm_rbuttonup or
					msg = Wm_mbuttonup or
					msg = Wm_lbuttondown or
					msg = Wm_rbuttondown or
					msg = Wm_mbuttondown or
					msg = Wm_lbuttondblclk or
					msg = Wm_rbuttondblclk or
					msg = Wm_mbuttondblclk)
				then
					Result := on_mouse_message (msg, wparam, lparam)
				end
				if 
					m_have_focus and
					(msg = Wm_keydown or
					msg = Wm_keyup or
					msg = Wm_char or
					msg = Wm_deadchar or
					msg = Wm_syskeydown or
					msg = Wm_syskeyup or
					msg = Wm_sysdeadchar or
					msg = Wm_help or
					msg = Wm_cancelmode or
					msg = Wm_ime_char or
					msg = Wm_mbuttondblclk or
					(msg >= Wm_ime_setcontext and
					msg <= Wm_ime_keyup ))
				then
					Result := on_mouse_message (msg, wparam, lparam)
				end
			else
				if m_message_reflect then
					Result := reflect_notifications (msg, wparam, lparam)
				end
			end
			inspect msg
			when Wm_paint then
				on_wm_paint (wparam)
			when Wm_forwardmsg then
				on_forward_message (lparam)
			else
				-- Call the `process_message' routine of the
				-- parent class.
				Result := window_process_message (hwnd, msg, wparam, lparam)
			end
		end
	
feature {NONE} -- Implementation

	m_place_active: BOOLEAN
			-- Is control in-place active?
	
	m_windowless: BOOLEAN
			-- Is control windowless?
			
	m_ui_active: BOOLEAN
			-- Is UI active?
			
	m_capture: BOOLEAN
			-- Does windowless object 
			-- capture all mouse messages?
	
	m_have_focus: BOOLEAN
			-- Does control have focus?
			
	m_position: TAG_RECT_RECORD
			-- Client rectangle.
				
	m_client_dc: WEL_CLIENT_DC
			-- Window's client area device context.
			
	m_in_place_frame_proxy: IOLE_IN_PLACE_FRAME_IMPL_PROXY
			-- Frame window.
	
	m_in_place_uiwindow: IOLE_IN_PLACE_UIWINDOW_IMPL_PROXY
			-- Document window.

	dispose is
			-- Destroy window handle and free formatter.
			--
			-- This function should be called by the GC when the
			-- object is collected or by the user if `Current' is
			-- no more usefull. 
		do
			Precursor {WEL_WINDOW}
			Precursor {ECOM_EXCEPTION}
		end
	
feature {NONE} -- Externals
	Wm_forwardmsg: INTEGER is 895

	ole_lock_running (an_ole_object: POINTER; 
		a_lock, a_last_unlock_closes: BOOLEAN) is
			-- Locks an already running object into its running
			-- state or unlocks it from its running state.
		external
			"C macro signature (IUnknown *, BOOL, BOOL) use <ole2.h>"
		alias
			"OleLockRunning"
		end

	
end -- IOLE_IN_PLACE_SITE_WINDOWLESS_IMPL

