indexing

	status: "See notice at end of class";
	date: "$Date$";
	revision: "$Revision$"

class MOTIF_1
	
feature

	bar (a_bar: BAR; managed: BOOLEAN): BAR_M is
			-- Motif implementation of `a_bar'
		do
			!! Result.make (a_bar, managed)
		end; -- bar

	bulletin (a_bulletin: BULLETIN; managed: BOOLEAN): BULLETIN_M is
			-- Motif implementation of `a_bulletin'
		do
			!! Result.make (a_bulletin, managed)
		end; -- bulletin

	bulletin_d (a_bulletin_d: BULLETIN_D): BULLETIN_D_M is
			-- Motif implementation of `a_bulletin_d'
		do
			!! Result.make (a_bulletin_d)
		end; -- bulletin_d

	check_box (a_check_box: CHECK_BOX; managed: BOOLEAN): CHECK_BOX_M is
			-- Motif implementation of `a_check_box'
		do
			!! Result.make (a_check_box, managed)
		end; -- check_box

	dialog_shell (a_dialog_shell: DIALOG_SHELL): DIALOG_S_M is
			-- Motif implementation of `a_dialog_shell'
		do
			!! Result.make (a_dialog_shell)
		end; -- dialog_shell

	error_d (an_error_dialog: ERROR_D): ERROR_D_M is
			-- Motif implementation of `an_error_dialog'
		do
			!! Result.make (an_error_dialog)
		end; -- error_d

	file_sel_d (a_file_sel_dialog: FILE_SEL_D): FILE_SEL_D_M is
			-- Motif implementation of `a_file_sel_dialog'
		do
			!! Result.make (a_file_sel_dialog)
		end; -- file_sel_d

	file_selec (a_file_selection: FILE_SELEC; managed: BOOLEAN): FILE_SELEC_M is
			-- Motif implementation of `a_file_selec'
		do
			!! Result.make (a_file_selection, managed)
		end; -- file_selec

	font_list (a_font_list: FONT_LIST): FONT_LIST_X is
			-- Motif implementation of `a_font_list'
		do
			!! Result.make (a_font_list)
		end; -- font_list

	form (a_form: FORM; managed: BOOLEAN): FORM_M is
			-- Motif implementation of `a_form'
		do
			!! Result.make (a_form, managed)
		end; -- form

	form_d (a_form_dialog: FORM_D): FORM_D_M is
			-- Motif implementation of `a_form_dialog'
		do
			!! Result.make (a_form_dialog)
		end; -- form_d

	frame (a_frame: FRAME; managed: BOOLEAN): FRAME_M is
			-- Motif implementation of `a_frame'
		do
			!! Result.make (a_frame, managed)
		end;

	info_d (an_information_dialog: INFO_D): INFO_D_M is
			-- Motif implementation of `an_information_dialog'
		do
			!! Result.make (an_information_dialog)
		end;

	label (a_label: LABEL; managed: BOOLEAN): LABEL_M is
			-- Motif implementation of `a_label'
		do
			!! Result.make (a_label, managed)
		end;

	label_g (a_label_gadget: LABEL_G; managed: BOOLEAN): LABEL_G_M is
			-- Motif implementation of `a_label_gadget'
		do
			!! Result.make (a_label_gadget, managed)
		end; -- label_g

	menu_b (a_menu_b: MENU_B; managed: BOOLEAN): MENU_B_M is
			-- Motif implementation of menu button
		do
			!! Result.make (a_menu_b, managed)
		end; -- menu_b

	message (a_message: MESSAGE; managed: BOOLEAN): MESSAGE_M is
			-- Motif implementation of `a_message'
		do
			!! Result.make (a_message, managed)
		end; -- message

	message_d (a_message_dialog: MESSAGE_D): MESSAGE_D_M is
			-- Motif implementation of `a_message_dialog'
		do
			!! Result.make (a_message_dialog)
		end; -- message_d

	option_b (an_option_button: OPTION_B; managed: BOOLEAN): OPTION_B_M is
			-- Motif implementation of `an_option_button'
		do
			!! Result.make (an_option_button, managed)
		end; -- option_b

	override_s (an_override_s: OVERRIDE_S): OVERRIDE_S_M is
			-- Motif implementation of `an_override_s'
		do
			!! Result.make (an_override_s)
		end; -- override_s

	popup (a_popup: POPUP): POPUP_M is
			-- Motif implementation of `a_popup'
		do
			!! Result.make (a_popup)
		end; -- popup

	prompt (a_prompt: PROMPT; managed: BOOLEAN): PROMPT_M is
			-- Motif implementation of `a_prompt'
		do
			!! Result.make (a_prompt, managed)
		end; -- prompt

	prompt_d (a_prompt_dialog: PROMPT_D): PROMPT_D_M is
			-- Motif implementation of `a_prompt_dialog'
		do
			!! Result.make (a_prompt_dialog)
		end; -- prompt_d

	menu_pull (a_pulldown: MENU_PULL; managed: BOOLEAN): MENU_PULL_M is
			-- Motif implementation of `a_pulldown'
		do
			!! Result.make (a_pulldown, managed)
		end; -- pulldown

	opt_pull (a_pulldown: OPT_PULL; managed: BOOLEAN): OPT_PULL_M is
			-- Motif implementation of `a_pulldown'
		do
			!! Result.make (a_pulldown, managed)
		end; -- pulldown

	push_b (a_push_b: PUSH_B; managed: BOOLEAN): PUSH_B_M is
			-- Motif implementation of push button
		do
			!! Result.make (a_push_b, managed)
		end; -- push_b

	push_bg (a_push_b_gadget: PUSH_BG; managed: BOOLEAN): PUSH_BG_M is
			-- Motif implementation of `a_push_b_gadget'
		do
			!! Result.make (a_push_b_gadget, managed)
		end; -- push_bg

	question_d (a_question_dialog: QUESTION_D): QUESTION_D_M is
			-- Motif implementation of `a_question_dialog'
		do
			!! Result.make (a_question_dialog)
		end; -- question_d

	radio_box (a_radio_box: RADIO_BOX; managed: BOOLEAN): RADIO_BOX_M is
			-- Motif implementation of `a_radio_box'
		do
			!! Result.make (a_radio_box, managed)
		end; -- radio_box

	row_column (a_row_column: ROW_COLUMN; managed: BOOLEAN): ROW_COLUMN_M is
			-- Motif implementation of `a_row_column'
		do
			!! Result.make (a_row_column, managed)
		end; -- row_column

	scale (a_scale: SCALE; managed: BOOLEAN): SCALE_M is
			-- Motif implementation of `a_scale'
		do
			!! Result.make (a_scale, managed)
		end; -- scale

	scroll_list (a_list: SCROLL_LIST; managed, is_fixed: BOOLEAN): SCROLL_L_M is
			-- Motif implementation of `a_list'
		do
			!! Result.make (a_list, managed, is_fixed)
		end; -- scroll_list

	scrollbar (a_scrollbar: SCROLLBAR; managed: BOOLEAN): SCROLLBAR_M is
			-- Motif implementation of `a_scrollbar'
		do
			!! Result.make (a_scrollbar, managed)
		end; -- scrollbar

	scrolled_t (a_scrolled_text: SCROLLED_T; managed: BOOLEAN): SCROLLED_T_M is
			-- Motif implementation of `a_scrolled_text'
		do
			!! Result.make (a_scrolled_text, managed)
		end; -- scrolled_t

	scrolled_t_word_wrapped (a_scrolled_text: SCROLLED_T; managed: BOOLEAN): SCROLLED_T_M is
			-- Motif implementation of `a_scrolled_text'
		do
			!! Result.make_word_wrapped (a_scrolled_text, managed)
		end; -- scrolled_t_word_wrapped

	scrolled_w (a_scrolled_window: SCROLLED_W; managed: BOOLEAN): SCROLLED_W_M is
			-- Motif implementation of `a_scrolled_window'
		do
			!! Result.make (a_scrolled_window, managed)
		end; -- scrolled_w

	separator (a_separator: SEPARATOR; managed: BOOLEAN): SEPARATOR_M is
			-- Motif implementation of `a_separator'
		do
			!! Result.make (a_separator, managed)
		end; -- separator

	separator_g (a_separator_gadget: SEPARATOR_G; managed: BOOLEAN): SEPARATO_G_M is
			-- Motif implementation of `a_separator_gadget'
		do
			!! Result.make (a_separator_gadget, managed)
		end; -- separator_g

	text (a_text: TEXT; managed: BOOLEAN): TEXT_M is
			-- Motif implementation of `a_text'
		do
			!! Result.make (a_text, managed)
		end; -- text

	text_word_wrapped (a_text: TEXT; managed: BOOLEAN): TEXT_M is
			-- Motif implementation of `a_text'
		do
			!! Result.make_word_wrapped (a_text, managed)
		end; -- text_word_wrapped

	text_field (a_text_field: TEXT_FIELD; managed: BOOLEAN): TEXT_FIELD_M is
			-- Motif implementation of `a_text_field'
		do
			!! Result.make (a_text_field, managed)
		end; -- text_field

	toggle_b (a_toggle_b: TOGGLE_B; managed: BOOLEAN): TOGGLE_B_M is
			-- Motif implementation of `a_toggle_b'
		do
			!! Result.make (a_toggle_b, managed)
		end; -- toggle_b

	toggle_bg (a_toggle_b_gadget: TOGGLE_BG; managed: BOOLEAN): TOGGLE_BG_M is
			-- Motif implementation of `a_toggle_b_gadget'
		do
			!! Result.make (a_toggle_b_gadget, managed)
		end; -- toggle_bg

	warning_d (a_warning_dialog: WARNING_D): WARNING_D_M is
			-- Motif implementation of `a_warning_dialog'
		do
			!! Result.make (a_warning_dialog)
		end; -- warning_d

	working_d (a_working_dialog: WORKING_D): WORKING_D_M is
			-- Motif implementation of `a_working_dialog'
		do
			!! result.make (a_working_dialog)
		end -- working_d

end


--|----------------------------------------------------------------
--| EiffelVision: library of reusable components for ISE Eiffel 3.
--| Copyright (C) 1989, 1991, 1993, 1994, Interactive Software
--|   Engineering Inc.
--| All rights reserved. Duplication and distribution prohibited.
--|
--| 270 Storke Road, Suite 7, Goleta, CA 93117 USA
--| Telephone 805-685-1006
--| Fax 805-685-6869
--| Electronic mail <info@eiffel.com>
--| Customer support e-mail <eiffel@eiffel.com>
--|----------------------------------------------------------------
