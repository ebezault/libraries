note
	description: "[
		Objects that represent an EV_DIALOG.
		The original version of this class was generated by EiffelBuild.
		This class is the implementation of an EV_DIALOG generated by EiffelBuild.
		You should not modify this code by hand, as it will be re-generated every time
		 modifications are made to the project.
		 	]"
	status: "See notice at end of class."
	legal: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

deferred class
	RADIO_BUTTON_CREATION_DIALOG_IMP

inherit
	EV_DIALOG
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
			Precursor {EV_DIALOG}
			initialize_constants

				-- Build widget structure.
			extend (l_ev_vertical_box_1)
			l_ev_vertical_box_1.extend (l_ev_horizontal_box_1)
			l_ev_horizontal_box_1.extend (l_ev_vertical_box_2)
			l_ev_vertical_box_2.extend (normal_radio_button)
			l_ev_vertical_box_2.extend (font_radio_button)
			l_ev_vertical_box_2.extend (width_radio_button)
			l_ev_horizontal_box_1.extend (l_ev_vertical_box_3)
			l_ev_vertical_box_3.extend (font_frame)
			font_frame.extend (l_ev_horizontal_box_2)
			l_ev_horizontal_box_2.extend (font_field)
			l_ev_horizontal_box_2.extend (choose_font_button)
			l_ev_vertical_box_3.extend (width_frame)
			width_frame.extend (width_spin_button)
			l_ev_vertical_box_1.extend (l_ev_horizontal_box_3)
			l_ev_horizontal_box_3.extend (l_ev_cell_1)
			l_ev_horizontal_box_3.extend (ok_button)
			l_ev_horizontal_box_3.extend (cancel_button)

			l_ev_vertical_box_1.set_padding (5)
			l_ev_vertical_box_1.disable_item_expand (l_ev_horizontal_box_3)
			l_ev_horizontal_box_1.disable_item_expand (l_ev_vertical_box_2)
			normal_radio_button.set_text ("Normal")
			font_radio_button.set_text ("Font")
			width_radio_button.set_text ("Width")
			l_ev_vertical_box_3.disable_item_expand (font_frame)
			l_ev_vertical_box_3.disable_item_expand (width_frame)
			font_frame.set_text ("Font")
			l_ev_horizontal_box_2.disable_item_expand (choose_font_button)
			font_field.set_background_color (create {EV_COLOR}.make_with_8_bit_rgb (212, 208, 200))
			font_field.disable_sensitive
			choose_font_button.set_text ("Choose ...")
			width_frame.set_text ("Max Width")
			width_spin_button.set_text ("50")
			width_spin_button.set_value (50)
			l_ev_horizontal_box_3.set_padding (15)
			l_ev_horizontal_box_3.set_border_width (10)
			l_ev_horizontal_box_3.disable_item_expand (ok_button)
			l_ev_horizontal_box_3.disable_item_expand (cancel_button)
			ok_button.set_text ("Ok")
			ok_button.set_minimum_width (100)
			cancel_button.set_text ("Cancel")
			cancel_button.set_minimum_width (100)
			set_title ("Create Radio Button")

			set_all_attributes_using_constants

				-- Connect events.
			normal_radio_button.select_actions.extend (agent on_normal_radio_button_selected)
			font_radio_button.select_actions.extend (agent on_font_radio_button_selected)
			width_radio_button.select_actions.extend (agent on_width_radio_button_selected)
			choose_font_button.select_actions.extend (agent on_choose_font_button_selected)
			ok_button.select_actions.extend (agent on_ok_button_selected)
			cancel_button.select_actions.extend (agent on_cancel_button_selected)

				-- Call `user_initialization'.
			user_initialization
		end


feature -- Access

	width_spin_button: EV_SPIN_BUTTON
	choose_font_button, ok_button, cancel_button: EV_BUTTON
	normal_radio_button,
	font_radio_button, width_radio_button: EV_RADIO_BUTTON
	font_field: EV_TEXT_FIELD
	font_frame, width_frame: EV_FRAME

feature {NONE} -- Implementation

	l_ev_cell_1: EV_CELL
	l_ev_horizontal_box_1, l_ev_horizontal_box_2, l_ev_horizontal_box_3: EV_HORIZONTAL_BOX
	l_ev_vertical_box_1,
	l_ev_vertical_box_2, l_ev_vertical_box_3: EV_VERTICAL_BOX

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

	on_normal_radio_button_selected
			-- Called by `select_actions' of `normal_radio_button'.
		deferred
		end

	on_font_radio_button_selected
			-- Called by `select_actions' of `font_radio_button'.
		deferred
		end

	on_width_radio_button_selected
			-- Called by `select_actions' of `width_radio_button'.
		deferred
		end

	on_choose_font_button_selected
			-- Called by `select_actions' of `choose_font_button'.
		deferred
		end

	on_ok_button_selected
			-- Called by `select_actions' of `ok_button'.
		deferred
		end

	on_cancel_button_selected
			-- Called by `select_actions' of `cancel_button'.
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
