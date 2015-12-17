note
	description: "[
		Objects that represent an EV_TITLED_WINDOW.
		The original version of this class was generated by EiffelBuild.
		This class is the implementation of an EV_TITLED_WINDOW generated by EiffelBuild.
		You should not modify this code by hand, as it will be re-generated every time
		 modifications are made to the project.
		 	]"
	status: "See notice at end of class."
	legal: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

deferred class
	GENERAL_SETTING_PANEL_IMP

inherit
	EV_VERTICAL_BOX
		redefine
			initialize, is_in_default_state
		end

	CONSTANTS
		undefine
			is_equal, default_create, copy
		end

feature {NONE}-- Initialization

	initialize
			-- Initialize `Current'.
		do
			Precursor {EV_VERTICAL_BOX}
			initialize_constants

				-- Build widget structure.
			extend (l_ev_frame_1)
			l_ev_frame_1.extend (l_ev_vertical_box_1)
			l_ev_vertical_box_1.extend (l_ev_horizontal_box_1)
			l_ev_horizontal_box_1.extend (l_ev_button_1)
			l_ev_horizontal_box_1.extend (l_ev_vertical_separator_1)
			l_ev_horizontal_box_1.extend (l_ev_button_2)
			extend (l_ev_frame_2)
			l_ev_frame_2.extend (l_ev_horizontal_box_2)
			l_ev_horizontal_box_2.extend (close_place_holder_button)
			extend (l_ev_frame_3)
			l_ev_frame_3.extend (l_ev_vertical_box_2)
			l_ev_vertical_box_2.extend (l_ev_horizontal_box_3)
			l_ev_horizontal_box_3.extend (l_ev_vertical_box_3)
			l_ev_vertical_box_3.extend (show_all_indicators_check_button)
			l_ev_vertical_box_3.extend (show_tab_stub_text_check_button)
			l_ev_horizontal_box_3.extend (l_ev_vertical_box_4)
			l_ev_vertical_box_4.extend (l_ev_horizontal_box_4)
			l_ev_horizontal_box_4.extend (l_ev_label_1)
			l_ev_horizontal_box_4.extend (sliding_speed_spin_button)
			l_ev_vertical_box_2.extend (l_ev_frame_4)
			l_ev_frame_4.extend (l_ev_horizontal_box_5)
			l_ev_horizontal_box_5.extend (l_ev_label_2)
			l_ev_horizontal_box_5.extend (key_field)
			l_ev_horizontal_box_5.extend (l_ev_cell_1)
			l_ev_horizontal_box_5.extend (ctrl_check_button)
			l_ev_horizontal_box_5.extend (alt_check_button)
			l_ev_horizontal_box_5.extend (shift_check_button)
			l_ev_vertical_box_2.extend (l_ev_frame_5)
			l_ev_frame_5.extend (l_ev_horizontal_box_6)
			l_ev_horizontal_box_6.extend (lock_editors_check_button)
			l_ev_horizontal_box_6.extend (lock_tools_check_button)
			l_ev_horizontal_box_6.extend (lock_tool_bars_check_button)
			l_ev_vertical_box_2.extend (l_ev_frame_6)
			l_ev_frame_6.extend (l_ev_horizontal_box_7)
			l_ev_horizontal_box_7.extend (background_color_drawer)
			l_ev_horizontal_box_7.extend (l_ev_cell_2)
			l_ev_horizontal_box_7.extend (chose_color_button)
			l_ev_vertical_box_2.extend (l_ev_frame_7)
			l_ev_frame_7.extend (l_ev_horizontal_box_8)
			l_ev_horizontal_box_8.extend (l_ev_vertical_box_5)
			l_ev_vertical_box_5.extend (save_layout_button)
			l_ev_vertical_box_5.extend (open_layout_button)
			l_ev_horizontal_box_8.extend (l_ev_vertical_box_6)
			l_ev_vertical_box_6.extend (save_tool_layout_button)
			l_ev_vertical_box_6.extend (open_tool_layout_button)
			l_ev_horizontal_box_8.extend (l_ev_vertical_box_7)
			l_ev_vertical_box_7.extend (save_editor_layout_button)
			l_ev_vertical_box_7.extend (open_editor_layout_button)

			l_ev_frame_1.set_text ("Creation")
			l_ev_vertical_box_1.disable_item_expand (l_ev_horizontal_box_1)
			l_ev_horizontal_box_1.disable_item_expand (l_ev_button_1)
			l_ev_horizontal_box_1.disable_item_expand (l_ev_vertical_separator_1)
			l_ev_horizontal_box_1.disable_item_expand (l_ev_button_2)
			l_ev_button_1.set_text ("Create Tool Content")
			l_ev_button_2.set_text ("Create Editor Content")
			l_ev_frame_2.set_text ("Place Holder")
			l_ev_horizontal_box_2.disable_item_expand (close_place_holder_button)
			close_place_holder_button.set_text ("Close")
			l_ev_frame_3.set_text ("Settings")
			l_ev_vertical_box_2.disable_item_expand (l_ev_horizontal_box_3)
			l_ev_vertical_box_2.disable_item_expand (l_ev_frame_4)
			l_ev_vertical_box_2.disable_item_expand (l_ev_frame_5)
			l_ev_vertical_box_2.disable_item_expand (l_ev_frame_7)
			l_ev_vertical_box_3.disable_item_expand (show_all_indicators_check_button)
			l_ev_vertical_box_3.disable_item_expand (show_tab_stub_text_check_button)
			show_all_indicators_check_button.set_text ("Show All Indicators")
			show_all_indicators_check_button.set_tooltip ("Show all indicators?")
			show_tab_stub_text_check_button.set_text ("Show Tab Stub Text")
			show_tab_stub_text_check_button.set_tooltip ("Show tab stub text of auto-hide contents?")
			l_ev_vertical_box_4.disable_item_expand (l_ev_horizontal_box_4)
			l_ev_horizontal_box_4.disable_item_expand (l_ev_label_1)
			l_ev_horizontal_box_4.disable_item_expand (sliding_speed_spin_button)
			l_ev_label_1.set_text ("Sliding Speed: ")
			l_ev_label_1.set_tooltip ("The larger the slower.")
			sliding_speed_spin_button.set_minimum_width (80)
			l_ev_frame_4.set_text ("Navigating Dialog Shortcut")
			l_ev_horizontal_box_5.disable_item_expand (l_ev_label_2)
			l_ev_horizontal_box_5.disable_item_expand (key_field)
			l_ev_horizontal_box_5.disable_item_expand (l_ev_cell_1)
			l_ev_horizontal_box_5.disable_item_expand (ctrl_check_button)
			l_ev_horizontal_box_5.disable_item_expand (alt_check_button)
			l_ev_horizontal_box_5.disable_item_expand (shift_check_button)
			l_ev_label_2.set_text ("Key: ")
			key_field.set_tooltip ("Enter a key string.")
			key_field.set_minimum_width (50)
			l_ev_cell_1.set_minimum_width (5)
			ctrl_check_button.set_text ("Ctrl")
			alt_check_button.set_text ("Alt")
			shift_check_button.set_text ("Shift")
			l_ev_frame_5.set_text ("Lock")
			l_ev_horizontal_box_6.disable_item_expand (lock_editors_check_button)
			l_ev_horizontal_box_6.disable_item_expand (lock_tools_check_button)
			l_ev_horizontal_box_6.disable_item_expand (lock_tool_bars_check_button)
			lock_editors_check_button.set_text ("Lock Editors")
			lock_tools_check_button.set_text ("Lock Tools")
			lock_tool_bars_check_button.set_text ("Lock Tool Bars")
			l_ev_frame_6.set_text ("Main Background Color")
			l_ev_horizontal_box_7.disable_item_expand (l_ev_cell_2)
			l_ev_horizontal_box_7.disable_item_expand (chose_color_button)
			background_color_drawer.set_minimum_width (50)
			l_ev_cell_2.set_minimum_width (5)
			chose_color_button.set_text ("Choose Color...")
			l_ev_frame_7.set_text ("Save Layout")
			save_layout_button.set_text ("Save Layout...")
			open_layout_button.set_text ("Open Layout...")
			save_tool_layout_button.set_text ("Save Tool Layout...")
			open_tool_layout_button.set_text ("Open Tool Layout...")
			save_editor_layout_button.set_text ("Save Editor Layout...")
			open_editor_layout_button.set_text ("Open Editor Layout...")
			disable_item_expand (l_ev_frame_1)
			disable_item_expand (l_ev_frame_2)
			disable_item_expand (l_ev_frame_3)

			set_all_attributes_using_constants

				-- Connect events.
			l_ev_button_1.select_actions.extend (agent on_create_tool_content)
			l_ev_button_2.select_actions.extend (agent on_create_editor_content)
			close_place_holder_button.select_actions.extend (agent on_close_place_holder_button_selected)
			show_all_indicators_check_button.select_actions.extend (agent on_show_all_indicators_check_button_selected)
			show_tab_stub_text_check_button.select_actions.extend (agent on_show_tab_stub_text_check_button_selected)
			sliding_speed_spin_button.change_actions.extend (agent on_sliding_speed_spin_button_changed (?))
			key_field.change_actions.extend (agent on_key_field_changed)
			ctrl_check_button.select_actions.extend (agent on_ctrl_button_selected)
			alt_check_button.select_actions.extend (agent on_alt_button_selected)
			shift_check_button.select_actions.extend (agent on_shift_button_selected)
			lock_editors_check_button.select_actions.extend (agent on_lock_editors_button_selected)
			lock_tools_check_button.select_actions.extend (agent on_lock_tools_button_selected)
			lock_tool_bars_check_button.select_actions.extend (agent on_lock_tool_bars_button_selected)
			background_color_drawer.expose_actions.extend (agent on_background_color_drawer_exposed (?, ?, ?, ?))
			chose_color_button.select_actions.extend (agent on_choose_color_button_selected)
			save_layout_button.select_actions.extend (agent on_save_layout_button_selected)
			open_layout_button.select_actions.extend (agent on_open_layout_button_selected)
			save_tool_layout_button.select_actions.extend (agent on_save_tool_layout_button_selected)
			open_tool_layout_button.select_actions.extend (agent on_open_tool_layout_button_selected)
			save_editor_layout_button.select_actions.extend (agent on_save_editor_layout_button_selected)
			open_editor_layout_button.select_actions.extend (agent on_open_editor_layout_button_selected)

				-- Call `user_initialization'.
			user_initialization
		end


feature -- Access

	background_color_drawer: EV_DRAWING_AREA
	sliding_speed_spin_button: EV_SPIN_BUTTON
	close_place_holder_button, chose_color_button,
	save_layout_button, open_layout_button, save_tool_layout_button, open_tool_layout_button,
	save_editor_layout_button, open_editor_layout_button: EV_BUTTON
	show_all_indicators_check_button,
	show_tab_stub_text_check_button, ctrl_check_button, alt_check_button, shift_check_button,
	lock_editors_check_button, lock_tools_check_button, lock_tool_bars_check_button: EV_CHECK_BUTTON
	key_field: EV_TEXT_FIELD

feature {NONE} -- Implementation

	l_ev_cell_1, l_ev_cell_2: EV_CELL
	l_ev_button_1, l_ev_button_2: EV_BUTTON
	l_ev_vertical_separator_1: EV_VERTICAL_SEPARATOR
	l_ev_horizontal_box_1,
	l_ev_horizontal_box_2, l_ev_horizontal_box_3, l_ev_horizontal_box_4, l_ev_horizontal_box_5,
	l_ev_horizontal_box_6, l_ev_horizontal_box_7, l_ev_horizontal_box_8: EV_HORIZONTAL_BOX
	l_ev_vertical_box_1,
	l_ev_vertical_box_2, l_ev_vertical_box_3, l_ev_vertical_box_4, l_ev_vertical_box_5,
	l_ev_vertical_box_6, l_ev_vertical_box_7: EV_VERTICAL_BOX
	l_ev_label_1, l_ev_label_2: EV_LABEL
	l_ev_frame_1,
	l_ev_frame_2, l_ev_frame_3, l_ev_frame_4, l_ev_frame_5, l_ev_frame_6, l_ev_frame_7: EV_FRAME

feature {NONE} -- Implementation

	is_in_default_state: BOOLEAN
			-- Is `Current' in its default state?
		do
			-- Re-implement if you wish to enable checking
			-- for `Current'.
			Result := True
		end

	user_initialization
			-- Feature for custom initialization, called at end of `initialize'.
		deferred
		end

	on_create_tool_content
			-- Called by `select_actions' of `l_ev_button_1'.
		deferred
		end

	on_create_editor_content
			-- Called by `select_actions' of `l_ev_button_2'.
		deferred
		end

	on_close_place_holder_button_selected
			-- Called by `select_actions' of `close_place_holder_button'.
		deferred
		end

	on_show_all_indicators_check_button_selected
			-- Called by `select_actions' of `show_all_indicators_check_button'.
		deferred
		end

	on_show_tab_stub_text_check_button_selected
			-- Called by `select_actions' of `show_tab_stub_text_check_button'.
		deferred
		end

	on_sliding_speed_spin_button_changed (a_value: INTEGER)
			-- Called by `change_actions' of `sliding_speed_spin_button'.
		deferred
		end

	on_key_field_changed
			-- Called by `change_actions' of `key_field'.
		deferred
		end

	on_ctrl_button_selected
			-- Called by `select_actions' of `ctrl_check_button'.
		deferred
		end

	on_alt_button_selected
			-- Called by `select_actions' of `alt_check_button'.
		deferred
		end

	on_shift_button_selected
			-- Called by `select_actions' of `shift_check_button'.
		deferred
		end

	on_lock_editors_button_selected
			-- Called by `select_actions' of `lock_editors_check_button'.
		deferred
		end

	on_lock_tools_button_selected
			-- Called by `select_actions' of `lock_tools_check_button'.
		deferred
		end

	on_lock_tool_bars_button_selected
			-- Called by `select_actions' of `lock_tool_bars_check_button'.
		deferred
		end

	on_background_color_drawer_exposed (a_x, a_y, a_width, a_height: INTEGER)
			-- Called by `expose_actions' of `background_color_drawer'.
		deferred
		end

	on_choose_color_button_selected
			-- Called by `select_actions' of `chose_color_button'.
		deferred
		end

	on_save_layout_button_selected
			-- Called by `select_actions' of `save_layout_button'.
		deferred
		end

	on_open_layout_button_selected
			-- Called by `select_actions' of `open_layout_button'.
		deferred
		end

	on_save_tool_layout_button_selected
			-- Called by `select_actions' of `save_tool_layout_button'.
		deferred
		end

	on_open_tool_layout_button_selected
			-- Called by `select_actions' of `open_tool_layout_button'.
		deferred
		end

	on_save_editor_layout_button_selected
			-- Called by `select_actions' of `save_editor_layout_button'.
		deferred
		end

	on_open_editor_layout_button_selected
			-- Called by `select_actions' of `open_editor_layout_button'.
		deferred
		end


feature {NONE} -- Constant setting

	set_attributes_using_string_constants
			-- Set all attributes relying on string constants to the current
			-- value of the associated constant.
		local
			s: detachable STRING_GENERAL
		do
			from
				string_constant_set_procedures.start
			until
				string_constant_set_procedures.off
			loop
				string_constant_retrieval_functions.i_th (string_constant_set_procedures.index).call (Void)
				s := string_constant_retrieval_functions.i_th (string_constant_set_procedures.index).last_result
				check s /= Void end -- Implied by design of EiffelBuild
				string_constant_set_procedures.item.call ([s])
				string_constant_set_procedures.forth
			end
		end

	set_attributes_using_integer_constants
			-- Set all attributes relying on integer constants to the current
			-- value of the associated constant.
		local
			i: INTEGER
			arg1, arg2: INTEGER
			int: INTEGER_INTERVAL
		do
			from
				integer_constant_set_procedures.start
			until
				integer_constant_set_procedures.off
			loop
				integer_constant_retrieval_functions.i_th (integer_constant_set_procedures.index).call (Void)
				i := integer_constant_retrieval_functions.i_th (integer_constant_set_procedures.index).last_result
				integer_constant_set_procedures.item.call ([i])
				integer_constant_set_procedures.forth
			end
			from
				integer_interval_constant_retrieval_functions.start
				integer_interval_constant_set_procedures.start
			until
				integer_interval_constant_retrieval_functions.off
			loop
				integer_interval_constant_retrieval_functions.item.call (Void)
				arg1 := integer_interval_constant_retrieval_functions.item.last_result
				integer_interval_constant_retrieval_functions.forth
				integer_interval_constant_retrieval_functions.item.call (Void)
				arg2 := integer_interval_constant_retrieval_functions.item.last_result
				create int.make (arg1, arg2)
				integer_interval_constant_set_procedures.item.call ([int])
				integer_interval_constant_retrieval_functions.forth
				integer_interval_constant_set_procedures.forth
			end
		end

	set_attributes_using_pixmap_constants
			-- Set all attributes relying on pixmap constants to the current
			-- value of the associated constant.
		local
			p: detachable EV_PIXMAP
		do
			from
				pixmap_constant_set_procedures.start
			until
				pixmap_constant_set_procedures.off
			loop
				pixmap_constant_retrieval_functions.i_th (pixmap_constant_set_procedures.index).call (Void)
				p := pixmap_constant_retrieval_functions.i_th (pixmap_constant_set_procedures.index).last_result
				check p /= Void end -- Implied by design of EiffelBuild
				pixmap_constant_set_procedures.item.call ([p])
				pixmap_constant_set_procedures.forth
			end
		end

	set_attributes_using_font_constants
			-- Set all attributes relying on font constants to the current
			-- value of the associated constant.
		local
			f: detachable EV_FONT
		do
			from
				font_constant_set_procedures.start
			until
				font_constant_set_procedures.off
			loop
				font_constant_retrieval_functions.i_th (font_constant_set_procedures.index).call (Void)
				f := font_constant_retrieval_functions.i_th (font_constant_set_procedures.index).last_result
				check f /= Void end -- Implied by design of EiffelBuild
				font_constant_set_procedures.item.call ([f])
				font_constant_set_procedures.forth
			end
		end

	set_attributes_using_color_constants
			-- Set all attributes relying on color constants to the current
			-- value of the associated constant.
		local
			c: detachable EV_COLOR
		do
			from
				color_constant_set_procedures.start
			until
				color_constant_set_procedures.off
			loop
				color_constant_retrieval_functions.i_th (color_constant_set_procedures.index).call (Void)
				c := color_constant_retrieval_functions.i_th (color_constant_set_procedures.index).last_result
				check c /= Void end -- Implied by design of EiffelBuild
				color_constant_set_procedures.item.call ([c])
				color_constant_set_procedures.forth
			end
		end

	set_all_attributes_using_constants
			-- Set all attributes relying on constants to the current
			-- calue of the associated constant.
		do
			set_attributes_using_string_constants
			set_attributes_using_integer_constants
			set_attributes_using_pixmap_constants
			set_attributes_using_font_constants
			set_attributes_using_color_constants
		end

	string_constant_set_procedures: ARRAYED_LIST [PROCEDURE [STRING_GENERAL]]
	string_constant_retrieval_functions: ARRAYED_LIST [FUNCTION [STRING_GENERAL]]
	integer_constant_set_procedures: ARRAYED_LIST [PROCEDURE [INTEGER]]
	integer_constant_retrieval_functions: ARRAYED_LIST [FUNCTION [INTEGER]]
	pixmap_constant_set_procedures: ARRAYED_LIST [PROCEDURE [EV_PIXMAP]]
	pixmap_constant_retrieval_functions: ARRAYED_LIST [FUNCTION [EV_PIXMAP]]
	integer_interval_constant_retrieval_functions: ARRAYED_LIST [FUNCTION [INTEGER]]
	integer_interval_constant_set_procedures: ARRAYED_LIST [PROCEDURE [INTEGER_INTERVAL]]
	font_constant_set_procedures: ARRAYED_LIST [PROCEDURE [EV_FONT]]
	font_constant_retrieval_functions: ARRAYED_LIST [FUNCTION [EV_FONT]]
	color_constant_set_procedures: ARRAYED_LIST [PROCEDURE [EV_COLOR]]
	color_constant_retrieval_functions: ARRAYED_LIST [FUNCTION [EV_COLOR]]

	integer_from_integer (an_integer: INTEGER): INTEGER
			-- Return `an_integer', used for creation of
			-- an agent that returns a fixed integer value.
		do
			Result := an_integer
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

end
