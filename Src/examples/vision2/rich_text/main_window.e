indexing
	description: "[
			Main window of EiffelVision2 rich text example.
			Originally generated by EiffelBuild. 
		]"
	date: "$Date$"
	revision: "$Revision$"

class
	MAIN_WINDOW

inherit
	MAIN_WINDOW_IMP


feature {NONE} -- Initialization

	user_initialization is
			-- called by `initialize'.
			-- Any custom user initialization that
			-- could not be performed in `initialize',
			-- (due to regeneration of implementation class)
			-- can be added here.
		local
			environment: EV_ENVIRONMENT
			font_families: LINEAR [STRING]
			list_item: EV_LIST_ITEM
			counter: INTEGER
			font: EV_FONT
			format: EV_CHARACTER_FORMAT
			tab_positioner: EV_RICH_TEXT_TAB_POSITIONER
		do
				-- Initialize color display to black.
			update_color ((create {EV_STOCK_COLORS}).black)

				-- Update toolbar button display.
			format_toolbar.disable_vertical_button_style
			paragraph_toolbar.disable_vertical_button_style
			
				-- Connect events.
			rich_text.caret_move_actions.extend (agent caret_moved)
			rich_text.selection_change_actions.extend (agent selection_changed)
			close_request_actions.extend (agent exit)
			
					-- Now load all available fonts into `font_selection' combo box.
			create environment
			font_families := environment.font_families
			from
				font_families.start
			until
				font_families.off
			loop
				create list_item.make_with_text (font_families.item)
				font_selection.extend (list_item)
				font_families.forth
			end
			
				-- Apply a default font to `rich_edit'.
			create font
			font_families.start
			font.preferred_families.extend (font_families.item)
			font.set_height (10)
			rich_text.set_font (font)
			
				-- Add the rich text tab positioner.
			create tab_positioner.make_with_rich_text (rich_text)
			tab_control_holder.extend (tab_positioner)
			
				-- Add permitted font heights to `size_selection' combo box.
			from
				counter := 6
			until
				counter > 150
			loop
				create list_item.make_with_text (counter.out)
				list_item.set_data (counter)
				size_selection.extend (list_item)
				counter := counter + 2 + (counter // 10)
			end
			
			rich_text.set_caret_position (5)
				-- Add an example of every available font to `rich_text'.
			format := rich_text.character_format (1)
			from
				font_selection.start
			until
				font_selection.off
			loop
				format := rich_text.character_format (1)
				font := format.font
				font.preferred_families.wipe_out
				font.preferred_families.extend (font_selection.item.text)
				font.set_height (16)
				format.set_font (font)
				rich_text.buffered_append (font_selection.item.text, format)
				font_selection.forth
				if not font_selection.off then
					rich_text.buffered_append ("%N", format)
				end
			end
			rich_text.flush_buffer_to (rich_text.text_length + 1, rich_text.text_length + 1)
			
			create accelerator.make_with_key_combination (create {EV_KEY}.make_with_code ((create {EV_KEY_CONSTANTS}).key_s), False, True, False)
			accelerators.extend (accelerator)
			accelerator.actions.extend (agent check_line_positions)
			create accelerator.make_with_key_combination (create {EV_KEY}.make_with_code ((create {EV_KEY_CONSTANTS}).key_d), False, True, False)
			accelerators.extend (accelerator)
			accelerator.actions.extend (agent random_test)
			
				-- Initialize a test that checks teh contents of each line.
			create timer.make_with_interval (2000)
			timer.actions.extend (agent check_line_positions)
			show_actions.extend (agent window_shown)
		end
		
	window_shown is
			-- `Current' has been shown. Perform necessary processing.
		do
			rich_text.set_focus
		end
		
feature {NONE} -- Event handling

	bold_selected is
			-- `bold_button' has been selected.
		local
			format: EV_CHARACTER_FORMAT
			font: EV_FONT
			char_info: EV_CHARACTER_FORMAT_RANGE_INFORMATION
		do
			if rich_text.has_selection then
				format := rich_text.character_format (rich_text.selection_start)
				font := format.font
				if bold_button.is_selected then
					font.set_weight ((create {EV_FONT_CONSTANTS}).weight_bold)
				else
					font.set_weight ((create {EV_FONT_CONSTANTS}).weight_regular)
				end	
				format.set_font (font)
				create char_info.make_with_values (False, True, False, False, False, False, False)
				rich_text.modify_region (rich_text.selection_start, rich_text.selection_end + 1, format, char_info)
			else
				format := rich_text.character_format (rich_text.caret_position)
				font := format.font
				if font.weight.is_equal (feature {EV_FONT_CONSTANTS}.weight_bold) then
					font.set_weight (feature {EV_FONT_CONSTANTS}.weight_regular)
				else	
					font.set_weight (feature {EV_FONT_CONSTANTS}.weight_bold)
				end
				format.set_font (font)
				rich_text.set_current_format (format)
			end
		end
		
	font_selected is
			-- A font has been selected from `font_selection' combo box.
		local
			format: EV_CHARACTER_FORMAT
			font: EV_FONT
			char_info: EV_CHARACTER_FORMAT_RANGE_INFORMATION
		do
			if rich_text.has_selection then
				format := rich_text.character_format (rich_text.selection_start)
				font := format.font
				font.preferred_families.wipe_out
				font.preferred_families.extend (font_selection.selected_item.text)
				format.set_font (font)
				create char_info.make_with_values (True, False, False, False, False, False, False)
				rich_text.modify_region (rich_text.selection_start, rich_text.selection_end + 1, format, char_info)
			else
				format := rich_text.character_format (rich_text.caret_position)
				font := format.font
				font.preferred_families.wipe_out
				font.preferred_families.extend (font_selection.selected_item.text)
				format.set_font (font)
				if rich_text.is_displayed then
					rich_text.set_focus
					rich_text.set_current_format (format)
				end
			end
		end
		
	font_size_selected is
			-- A font has been selected from `size_selection' combo box.
		local
			format: EV_CHARACTER_FORMAT
			size: INTEGER
			font: EV_FONT
			char_info: EV_CHARACTER_FORMAT_RANGE_INFORMATION
		do
			if rich_text.has_selection then
				format := rich_text.character_format (rich_text.selection_start)
				if size_selection.text.is_integer then
					size := size_selection.text.to_integer
					if size >= 1 and size <= 200 then
						font := format.font
						font.set_height (size)
						format.set_font (font)
						create char_info.make_with_values (False, False, False, True, False, False, False)
						rich_text.modify_region (rich_text.selection_start, rich_text.selection_end + 1, format, char_info)
					end
				end
			else
				format := rich_text.character_format (rich_text.caret_position)
				if size_selection.text.is_integer then
					size := size_selection.text.to_integer
					if size >= 1 and size <= 200 then
						font :=format.font
						font.set_height (size)
						format.set_font (font)
						if rich_text.is_displayed then
							rich_text.set_focus
							rich_text.set_current_format (format)
						end
					end
				end			
			end
		end
	
	italic_selected is
			-- `italic_button' has been selected.
		local
			format: EV_CHARACTER_FORMAT
			font: EV_FONT
			char_info: EV_CHARACTER_FORMAT_RANGE_INFORMATION
		do
			if rich_text.has_selection then
				format := rich_text.character_format (rich_text.selection_start)
				font := format.font
				if italic_button.is_selected then
					font.set_shape (feature {EV_FONT_CONSTANTS}.shape_italic)
				else	
					font.set_shape (feature {EV_FONT_CONSTANTS}.shape_regular)
				end
				format.set_font (font)
				create char_info.make_with_values (False, False, True, False, False, False, False)
				rich_text.modify_region (rich_text.selection_start, rich_text.selection_end + 1, format, char_info)
			else
				format := rich_text.character_format (rich_text.caret_position)
				font := format.font
				if font.shape.is_equal (feature {EV_FONT_CONSTANTS}.shape_italic) then
					font.set_shape (feature {EV_FONT_CONSTANTS}.shape_regular)
				else	
					font.set_shape (feature {EV_FONT_CONSTANTS}.shape_italic)
				end
				format.set_font (font)
				rich_text.set_current_format (format)
			end
		end
		
		
	color_selected is
			-- `color_button' has been selected.
		local
			color_dialog: EV_COLOR_DIALOG
			format: EV_CHARACTER_FORMAT
			char_info: EV_CHARACTER_FORMAT_RANGE_INFORMATION
		do
			create color_dialog
			color_dialog.show_modal_to_window (Current)
			if color_dialog.color /= Void then
				update_color (color_dialog.color)
			end
			if rich_text.has_selection then
				format := rich_text.character_format (rich_text.selection_start)
				if color_dialog.selected_button.is_equal ("OK") then
					format.set_color (color_dialog.color)
					create char_info.make_with_values (False, False, False, False, True, False, False)
					rich_text.modify_region (rich_text.selection_start, rich_text.selection_end + 1, format, char_info)
				end
			else
				format := rich_text.character_format (rich_text.caret_position)
				if color_dialog.selected_button.is_equal ("OK") then
					format.set_color (color_dialog.color)
					rich_text.set_current_format (format)
				end
			end
		end
		
	underline_selected is
			-- Called by `select_actions' of `underlined_button'.
		local
			format: EV_CHARACTER_FORMAT
			char_info: EV_CHARACTER_FORMAT_RANGE_INFORMATION
			underlined: BOOLEAN
			effects: EV_CHARACTER_FORMAT_EFFECTS
		do
			if rich_text.has_selection then
				format := rich_text.character_format (rich_text.selection_start)
				effects := format.effects
				underlined := effects.is_underlined
				if underlined_button.is_selected then
					effects.enable_underlined
				else	
					effects.disable_underlined
				end
				format.set_effects (effects)
				create char_info.make_with_values (False, False, False, False, False, False, True)
				rich_text.modify_region (rich_text.selection_start, rich_text.selection_end + 1, format, char_info)
			else
				format := rich_text.character_format (rich_text.caret_position)
				effects := format.effects
				if underlined_button.is_selected then
					effects.enable_underlined
				else
					effects.disable_underlined
				end
				format.set_effects (effects)
				rich_text.set_current_format (format)
			end
		end
	
	strike_through_selected is
			-- Called by `select_actions' of `striked_through_button'.
		local
			format: EV_CHARACTER_FORMAT
			char_info: EV_CHARACTER_FORMAT_RANGE_INFORMATION
			strike_through: BOOLEAN
			effects: EV_CHARACTER_FORMAT_EFFECTS
		do
			if rich_text.has_selection then
				format := rich_text.character_format (rich_text.selection_start)
				effects := format.effects
				strike_through := effects.is_striked_out
				if striked_through_button.is_selected then
					effects.enable_striked_out
				else	
					effects.disable_striked_out
				end
				format.set_effects (effects)
				create char_info.make_with_values (False, False, False, False, False, True, False)
				rich_text.modify_region (rich_text.selection_start, rich_text.selection_end + 1, format, char_info)
			else
				format := rich_text.character_format (rich_text.caret_position)
				effects := format.effects
				if striked_through_button.is_selected then
					effects.enable_striked_out
				else
					effects.disable_striked_out
				end
				format.set_effects (effects)
				rich_text.set_current_format (format)
			end
		end
		
	word_wrapping_toggled is
			-- Called by `select_actions' of `word_wrapping_menu_item'.
			-- Enable/disable word wrapping in `rich_text' based
			-- on state of `word_wrapping_menu_item'.
		do
			lock_update
			if word_wrapping_menu_item.is_selected then
				rich_text.enable_word_wrapping
			else
				rich_text.disable_word_wrapping
			end
			unlock_update
		end
		
	show_tab_control_toggled is
			-- Called by `select_actions' of `show_tab_control_menu_item'.
			-- Hide/show `tab_control' holder based on state of
			-- `show_tab_control_menu_item'.
		do
			if show_tab_control_menu_item.is_selected then
				tab_control_holder.show
			else
				tab_control_holder.hide
			end
		end
		
	left_alignment_selected is
			-- Called by `select_actions' of `left_alignment_button'.
		local
			paragraph: EV_PARAGRAPH_FORMAT
			paragraph_info: EV_PARAGRAPH_FORMAT_RANGE_INFORMATION
		do
			if not left_alignment_button.is_selected then
				left_alignment_button.select_actions.block
				left_alignment_button.enable_select
				left_alignment_button.select_actions.resume
			else
				unselect_all_buttons_except (left_alignment_button)
			end
			paragraph := rich_text.paragraph_format (rich_text.caret_position)
			paragraph.enable_left_alignment
			if rich_text.has_selection then
				create paragraph_info.make_with_values (True, False, False, False, False)
				rich_text.modify_paragraph (rich_text.line_number_from_position (rich_text.selection_start),
					rich_text.line_number_from_position (rich_text.selection_end),
					paragraph,
					paragraph_info)
			else
				rich_text.format_paragraph (rich_text.current_line_number, rich_text.current_line_number, paragraph)
			end
		end
	
	center_alignment_selected is
			-- Called by `select_actions' of `center_alignment_button'.
		local
			paragraph: EV_PARAGRAPH_FORMAT
			paragraph_info: EV_PARAGRAPH_FORMAT_RANGE_INFORMATION
		do
			if not center_alignment_button.is_selected then
				center_alignment_button.select_actions.block
				center_alignment_button.enable_select
				center_alignment_button.select_actions.resume
			else
				unselect_all_buttons_except (center_alignment_button)
			end
			paragraph := rich_text.paragraph_format (rich_text.caret_position)
			paragraph.enable_center_alignment
			if rich_text.has_selection then
				create paragraph_info.make_with_values (True, False, False, False, False)
				rich_text.modify_paragraph (rich_text.line_number_from_position (rich_text.selection_start),
					rich_text.line_number_from_position (rich_text.selection_end),
					paragraph,
					paragraph_info)
			else
				rich_text.format_paragraph (rich_text.current_line_number, rich_text.current_line_number, paragraph)
			end
		end
	
	right_alignment_selected is
			-- Called by `select_actions' of `right_alignment_button'.
		local
			paragraph: EV_PARAGRAPH_FORMAT
			paragraph_info: EV_PARAGRAPH_FORMAT_RANGE_INFORMATION
		do
			if not right_alignment_button.is_selected then
				right_alignment_button.select_actions.block
				right_alignment_button.enable_select
				right_alignment_button.select_actions.resume
			else
				unselect_all_buttons_except (right_alignment_button)
			end
			paragraph := rich_text.paragraph_format (rich_text.caret_position)
			paragraph.enable_right_alignment
			if rich_text.has_selection then
				create paragraph_info.make_with_values (True, False, False, False, False)
				rich_text.modify_paragraph (rich_text.line_number_from_position (rich_text.selection_start),
					rich_text.line_number_from_position (rich_text.selection_end),
					paragraph,
					paragraph_info)
			else
				rich_text.format_paragraph (rich_text.current_line_number, rich_text.current_line_number, paragraph)
			end
		end
		
	justified_selected is
			-- Called by `select_actions' of `justified_button'.
		local
			paragraph: EV_PARAGRAPH_FORMAT
			paragraph_info: EV_PARAGRAPH_FORMAT_RANGE_INFORMATION
		do
			if not justified_button.is_selected then
				justified_button.select_actions.block
				justified_button.enable_select
				justified_button.select_actions.resume
			else
				unselect_all_buttons_except (justified_button)
			end
			paragraph := rich_text.paragraph_format (rich_text.caret_position)
			paragraph.enable_justification
			if rich_text.has_selection then
				create paragraph_info.make_with_values (True, False, False, False, False)
				rich_text.modify_paragraph (rich_text.line_number_from_position (rich_text.selection_start),
					rich_text.line_number_from_position (rich_text.selection_end),
					paragraph,
					paragraph_info)
			else
				rich_text.format_paragraph (rich_text.current_line_number, rich_text.current_line_number, paragraph)
			end
		end

feature {NONE} -- Implementation

		caret_moved (new_position: INTEGER) is
				-- Caret of `rich_text' has moved to position `new_position'.
			local
				current_line_number: INTEGER
				format: EV_CHARACTER_FORMAT
				paragraph_format: EV_PARAGRAPH_FORMAT
				x, y: INTEGER
			do
				current_line_number := rich_text.current_line_number
				y := current_line_number
				x := rich_text.first_position_from_line_number (y)
				x := new_position - x + 1
					
					-- Display caret position in status bar.
				caret_position_label.set_text (x.out + " " + y.out)
				
					-- Update display corresponding to character formatting at
					-- new caret position.
				format := rich_text.character_format (new_position)
				display_format (format)
				
	 			paragraph_format := rich_text.paragraph_format (new_position)
				display_paragraph_format (paragraph_format)
			end
			
		display_format (format: EV_CHARACTER_FORMAT) is
				-- Udpate formatting toolbars to reflect formatting in `format'.
			require
				format_not_void: format /= Void
			local
				font: EV_FONT
				name_matched: BOOLEAN
				effects: EV_CHARACTER_FORMAT_EFFECTS
			do
				font := format.font
				effects := format.effects
				
					-- Updated Displayed font weight
				bold_button.select_actions.block
				if font.weight = feature {EV_FONT_CONSTANTS}.weight_bold then					
					bold_button.enable_select
				else
					bold_button.disable_select
				end
				bold_button.select_actions.resume
				
					-- Update displayed font shape.
				italic_button.select_actions.block
				if font.shape = feature {EV_FONT_CONSTANTS}.shape_italic then					
					italic_button.enable_select
				else
					italic_button.disable_select
				end
				italic_button.select_actions.resume
				
					-- Update displayed font underline.
				underlined_button.select_actions.block
				if effects.is_underlined then					
					underlined_button.enable_select
				else
					underlined_button.disable_select
				end
				underlined_button.select_actions.resume
				
					-- Update displayed font strike through.
				striked_through_button.select_actions.block
				if effects.is_striked_out then					
					striked_through_button.enable_select
				else
					striked_through_button.disable_select
				end
				striked_through_button.select_actions.resume
				
				
					-- Udpate displayed font size.
				size_selection.set_text (font.height.out)
				
					-- Update displayed font name.
				from
					font_selection.start
				until
					font_selection.off or name_matched
				loop
					if font_selection.item.text.is_equal (font.name) then
						font_selection.item.enable_select
						name_matched := True
					end
					font_selection.forth
				end
				
					-- Updated displayed font color.
				if not last_displayed_color.is_equal (format.color) then
					update_color (format.color)
				end
			end
			
		display_paragraph_format (paragraph_format: EV_PARAGRAPH_FORMAT) is
				-- Update display to reflect paragraph formatting in `paragraph_format'.
			do
				if paragraph_format.is_left_aligned then
					left_alignment_button.select_actions.block
					unselect_all_buttons_except (left_alignment_button)
					general_label.set_text ("Paragraph formatting left aligned")
					left_alignment_button.select_actions.resume
				elseif paragraph_format.is_center_aligned then
					center_alignment_button.select_actions.block
					unselect_all_buttons_except (center_alignment_button)
					general_label.set_text ("Paragraph formatting center aligned")
					center_alignment_button.select_actions.resume
				elseif paragraph_format.is_right_aligned then
					right_alignment_button.select_actions.block
					unselect_all_buttons_except (right_alignment_button)
					general_label.set_text ("Paragraph formatting right aligned")
					right_alignment_button.select_actions.resume
				elseif paragraph_format.is_justified then
					right_alignment_button.select_actions.resume
					unselect_all_buttons_except (justified_button)
					general_label.set_text ("Paragraph formatting justified")
					right_alignment_button.select_actions.resume
				end
				left_margin.change_actions.block
				left_margin.set_value (paragraph_format.left_margin)
				left_margin.change_actions.resume
				
				right_margin.change_actions.block
				right_margin.set_value (paragraph_format.right_margin)
				right_margin.change_actions.resume
				
				top_spacing.change_actions.block
				top_spacing.set_value (paragraph_format.top_spacing)
				top_spacing.change_actions.resume
				
				bottom_spacing.change_actions.block
				bottom_spacing.set_value (paragraph_format.bottom_spacing)
				bottom_spacing.change_actions.resume
			end

		selection_changed is
				-- The selection in `rich_text' has changed, so update
				-- formatting displayed in toolbar.
			local
				format: EV_CHARACTER_FORMAT
				formatting: EV_CHARACTER_FORMAT_RANGE_INFORMATION
				paragraph_formatting: EV_PARAGRAPH_FORMAT_RANGE_INFORMATION
				paragraph: EV_PARAGRAPH_FORMAT
				current_value: STRING
			do

				if rich_text.has_selection then
						-- Retrieve the format at the end of the selection.
					format := rich_text.selected_character_format
					
						-- Retrieve information regarding the consistency of formatting within selected range.
					formatting := rich_text.character_format_range_information (rich_text.selection_start, rich_text.selection_end + 1)

					if formatting.font_height then
							-- Font height is consistent throughout complete selection so display this size.
						current_value := format.font.height.out
						if not size_selection.text.is_equal (current_value) then
							from
								size_selection.start
							until
								size_selection.off or current_value = Void
							loop
								if size_selection.item.text.is_equal (current_value) then
									size_selection.select_actions.block
									size_selection.item.enable_select
									size_selection.select_actions.resume
									current_value := Void
								end
								size_selection.forth
							end
							if current_value /= Void then
								size_selection.set_text (current_value)
							end
						end
					else
							-- Font height is not consistent throughout complete selection so hide the size.
						size_selection.remove_text
						size_selection.remove_selection
					end
					
					if formatting.font_family then
							-- Font family is consistent throughout compelete selection so display the family.
						current_value := format.font.name.out
						if not font_selection.text.is_equal (current_value) then
							from
								font_selection.start
							until
								font_selection.off or current_value = Void
							loop
								if font_selection.item.text.is_equal (current_value) then
									font_selection.select_actions.block
									font_selection.item.enable_select
									font_selection.select_actions.resume
									current_value := Void
								end
								font_selection.forth
							end
						end
					else
							-- Font family is not consistent throughout complete selection so hide family.
						font_selection.remove_text
						font_Selection.remove_selection
					end

					if formatting.color then
							-- Color is consistent throughout selection so update color display if not
							-- already equivalent to the color.
						if not format.color.is_equal (last_displayed_color) or color_undefined then
							update_color (format.color)
						end
					elseif not color_undefined then
							-- Color is not consistent throughout complete selection so display color as 
						update_color_as_undefined
					end
					
						-- Update bold display so that it is only displayed as bold if the formatting is
						-- consistently bold.
					bold_button.select_actions.block
					if formatting.font_weight and format.font.weight = (create {EV_FONT_CONSTANTS}).weight_bold then
						bold_button.select_actions.resume
					else
						bold_button.select_actions.block
					end
					bold_button.select_actions.resume
					
						-- Update italic display so that it is only displayed as italic if the formatting is
						-- consistently italic.
					italic_button.select_actions.block
					if formatting.font_shape and format.font.shape = (create {EV_FONT_CONSTANTS}).shape_italic then
						italic_button.enable_select
					else
						italic_button.disable_select						
					end
					italic_button.select_actions.resume
					
						-- Now handle information regarding paragraphs.
					paragraph := rich_text.selected_paragraph_format
					paragraph_formatting := rich_text.paragraph_format_range_information (rich_text.line_number_from_position (rich_text.selection_start),
						rich_text.line_number_from_position (rich_text.selection_end))

					if paragraph_formatting.alignment then
						if paragraph.is_left_aligned then
							unselect_all_buttons_except (left_alignment_button)
						elseif paragraph.is_center_aligned then
							unselect_all_buttons_except (center_alignment_button)
						elseif paragraph.is_right_aligned then
							unselect_all_buttons_except (right_alignment_button)
						elseif paragraph.is_justified then
							unselect_all_buttons_except (justified_button)
						else
							check
								invalid_alignment: False
							end
						end	
					else
						unselect_all_buttons (paragraph_toolbar)
					end
					if paragraph_formatting.left_margin then
						left_margin.change_actions.block
						left_margin.set_text (paragraph.left_margin.out)
						left_margin.change_actions.resume
					else
						left_margin.remove_text
					end
					if paragraph_formatting.right_margin then
						right_margin.change_actions.block
						right_margin.set_text (paragraph.right_margin.out)
						right_margin.change_actions.resume
					else
						right_margin.remove_text
					end
					if paragraph_formatting.top_spacing then
						top_spacing.change_actions.block
						top_spacing.set_text (paragraph.top_spacing.out)
						top_spacing.change_actions.resume
					else
						top_spacing.remove_text
					end
					if paragraph_formatting.bottom_spacing then
						bottom_spacing.change_actions.block
						bottom_spacing.set_text (paragraph.bottom_spacing.out)
						bottom_spacing.change_actions.resume
					else
						bottom_spacing.remove_text
					end
				else
						-- `selection_changed_actions' is fired once when the selection is removed,
						-- so in this case, we treat the update identically to when the caret has moved
						-- by calling `display_format'.
					format := rich_text.character_format (rich_text.caret_position)
					display_format (format)
					paragraph := rich_text.paragraph_format (rich_text.caret_position)
					display_paragraph_format (paragraph)
				end
			end
		
	update_color (a_color: EV_COLOR) is
			-- Update color displayed in color tool bar button based on `a_color'.
		require
			color_not_void: a_color /= Void
		local
			pixmap: EV_PIXMAP
			text_size: TUPLE [INTEGER, INTEGER]
			text_width, text_height: INTEGER
		do
			create pixmap
			text_size := pixmap.font.string_size ("Color")
			text_width := text_size.integer_32_item (1)
			text_height := text_size.integer_32_item (2)
			pixmap.set_size (text_width + text_height + 2, 16)
			pixmap.set_background_color (format_toolbar.background_color)
			pixmap.clear
			pixmap.draw_text_top_left (text_height + 2, ((16 - text_height) // 2), "Color")
			pixmap.set_foreground_color (a_color)
			pixmap.fill_rectangle (1, 1 + ((16 - text_height) // 2), text_height - 2, text_height - 2)
			color_button.set_pixmap (pixmap)
			last_displayed_color := a_color
			color_undefined := False
		end
		
	update_color_as_undefined is
			-- Update color to display in color tool bar button as undefined
		local
			pixmap: EV_PIXMAP
			text_size: TUPLE [INTEGER, INTEGER]
			text_width, text_height: INTEGER
		do
			create pixmap
			text_size := pixmap.font.string_size ("Color")
			text_width := text_size.integer_32_item (1)
			text_height := text_size.integer_32_item (2)
			pixmap.set_size (text_width + text_height + 2, 16)
			pixmap.set_background_color (format_toolbar.background_color)
			pixmap.clear
			pixmap.draw_text_top_left (text_height + 2, ((16 - text_height) // 2), "Color")
			pixmap.set_foreground_color ((create {EV_STOCK_COLORS}).black)
			pixmap.draw_rectangle (1, 1 + ((16 - text_height) // 2), text_height - 2, text_height - 2)
			color_button.set_pixmap (pixmap)
			color_undefined := True
		end
		
	unselect_all_buttons_except (a_button: EV_TOOL_BAR_TOGGLE_BUTTON) is
			-- Unselect all toggle buttons in `parent' of `a_button', excluding `a_button', ensuring
			-- `a_button' is slected..
			-- Do not fire `select_actions' of any buttons.
		require
			a_button_not_void: a_button /= Void
			a_button_parented: a_button.parent /= Void
		local
			tool_bar: EV_TOOL_BAR
			toggle_button: EV_TOOL_BAR_TOGGLE_BUTTON
			was_already_blocked: BOOLEAN
		do
			tool_bar := a_button.parent
			from
				tool_bar.start
			until
				tool_bar.off
			loop
				if tool_bar.item /= a_button then
					toggle_button ?= tool_bar.item
					if toggle_button /= Void then
						was_already_blocked := False
						if toggle_button.select_actions.state /= toggle_button.select_actions.blocked_state then
							toggle_button.select_actions.block
						else
							was_already_blocked := True
						end
						toggle_button.disable_select
						if not was_already_blocked then
							toggle_button.select_actions.resume
						end
					end
				else
						-- Now ensure `a_button' is selected.
					was_already_blocked := False
					if a_button.select_actions.state /= a_button.select_actions.blocked_state then
						a_button.select_actions.block
					else
						was_already_blocked := True
					end
					a_button.enable_select
					if not was_already_blocked then
						a_button.select_actions.resume
					end
				end
				tool_bar.forth
			end
		end
		
	unselect_all_buttons (tool_bar: EV_TOOL_BAR) is
			-- Unselect all toggle buttons in `tool_bar'.
		require
			tool_bar_not_void: tool_bar /= Void
		local
			toggle_button: EV_TOOL_BAR_TOGGLE_BUTTON
		do
			from
				tool_bar.start
			until
				tool_bar.off
			loop
				toggle_button ?= tool_bar.item
				if toggle_button /= Void then
					toggle_button.select_actions.block
					toggle_button.disable_select
					toggle_button.select_actions.resume
				end
				tool_bar.forth
			end
		end
		
	show_paragraph_toolbar_selected is
			-- Called by `select_actions' of `show_paragraph_toolbar'.
		do
			if show_paragraph_toolbar.is_selected then
				paragraph_toolbar_holder.show
			else
				paragraph_toolbar_holder.hide
			end
		end
		
	left_margin_changed (a_value: INTEGER) is
			-- Called by `change_actions' of `left_margin'.
		local
			paragraph: EV_PARAGRAPH_FORMAT
			paragraph_info: EV_PARAGRAPH_FORMAT_RANGE_INFORMATION
			line_number: INTEGER
		do
			if rich_text.has_selection then
				create paragraph
				paragraph.set_left_margin (a_value)
				create paragraph_info.make_with_values (False, True, False, False, False)
				rich_text.modify_paragraph (rich_text.line_number_from_position (rich_text.selection_start),
						rich_text.line_number_from_position (rich_text.selection_end),
						paragraph,
						paragraph_info)
						
			else
				paragraph := rich_text.paragraph_format (rich_text.caret_position)
				paragraph.set_left_margin (a_value)
				line_number := rich_text.line_number_from_position (rich_text.caret_position)
				rich_text.format_paragraph (line_number, line_number, paragraph)
			end
		end
	
	right_margin_changed (a_value: INTEGER) is
			-- Called by `change_actions' of `right_margin'.
		local
			paragraph: EV_PARAGRAPH_FORMAT
			paragraph_info: EV_PARAGRAPH_FORMAT_RANGE_INFORMATION
			line_number: INTEGER
		do
			if rich_text.has_selection then
				create paragraph
				paragraph.set_right_margin (a_value)
				create paragraph_info.make_with_values (False, False, True, False, False)
				rich_text.modify_paragraph (rich_text.line_number_from_position (rich_text.selection_start),
						rich_text.line_number_from_position (rich_text.selection_end),
						paragraph,
						paragraph_info)
			else
				paragraph := rich_text.paragraph_format (rich_text.caret_position)
				paragraph.set_right_margin (a_value)
				line_number := rich_text.line_number_from_position (rich_text.caret_position)
				rich_text.format_paragraph (line_number, line_number, paragraph)
			end
		end
	
	top_spacing_changed (a_value: INTEGER) is
			-- Called by `change_actions' of `top_spacing'.
		local
			paragraph: EV_PARAGRAPH_FORMAT
			paragraph_info: EV_PARAGRAPH_FORMAT_RANGE_INFORMATION
			line_number: INTEGER
		do
			if rich_text.has_selection then
				create paragraph
				paragraph.set_top_spacing (a_value)
				create paragraph_info.make_with_values (False, False, False, True, False)
				rich_text.modify_paragraph (rich_text.line_number_from_position (rich_text.selection_start),
						rich_text.line_number_from_position (rich_text.selection_end),
						paragraph,
						paragraph_info)
			else
				paragraph := rich_text.paragraph_format (rich_text.caret_position)
				paragraph.set_top_spacing (a_value)
				line_number := rich_text.line_number_from_position (rich_text.caret_position)
				rich_text.format_paragraph (line_number, line_number, paragraph)
			end
		end
	
	bottom_spacing_changed (a_value: INTEGER) is
			-- Called by `change_actions' of `bottom_spacing'.
		local
			paragraph: EV_PARAGRAPH_FORMAT
			paragraph_info: EV_PARAGRAPH_FORMAT_RANGE_INFORMATION
			line_number: INTEGER
		do
			if rich_text.has_selection then
				create paragraph
				paragraph.set_top_spacing (a_value)
				create paragraph_info.make_with_values (False, False, False, False, True)
				rich_text.modify_paragraph (rich_text.line_number_from_position (rich_text.selection_start),
						rich_text.line_number_from_position (rich_text.selection_end),
						paragraph,
						paragraph_info)
			else
				paragraph := rich_text.paragraph_format (rich_text.caret_position)
				paragraph.set_bottom_spacing (a_value)
				line_number := rich_text.line_number_from_position (rich_text.caret_position)
				rich_text.format_paragraph (line_number, line_number, paragraph)
			end
		end
		
feature {NONE} -- Implementation

	exit is
			-- Exit the application
		do
			((create {EV_ENVIRONMENT}).application).destroy
		end

	last_displayed_color: EV_COLOR
			-- Last color displayed, stored to prevent unecessary updating of displayed color.
			
	color_undefined: BOOLEAN
			-- Is the color currently displayed undefined?
			
feature {NONE} -- To be removed

	--| FIXME all of the routines in this feature clause are only for
	--| testing purposes, and should be removed.

	check_line_positions is
			-- Check that querying all lines of text in `Current' appended together are equivalent to
			-- `text'.
		local
			counter: INTEGER
			current_line: STRING
			start_index, end_index: INTEGER
			a_text: STRING
			substring: STRING
			color: EV_COLOR
			current_text: STRING
		do
			a_text := rich_text.text
			current_text := ""
			from
				counter := 1
			until
				counter > rich_text.line_count
			loop
				current_line := rich_text.line (counter)
				start_index := rich_text.first_position_from_line_number (counter)
				end_index := rich_text.last_position_from_line_number (counter)
				substring := a_text.substring (start_index, end_index)
				if not substring.is_equal (current_line) then
					check
						False
					end
						-- A check for anybody that has checking turned off.
					print (color.red.out)
				end
				current_text.append (current_line)
				counter := counter + 1
			end
			if not current_text.is_equal (a_text) then
				check
					False
				end
					-- A check for anybody that has checking turned off.
				print (color.red.out)
			end
		end
		
	timer: EV_TIMEOUT
		-- Timer used for testing purposes.

	random_test is
			-- A feature connected to an accelerator for testing purposes.
		local
			char: EV_CHARACTER_FORMAT
			format: EV_PARAGRAPH_FORMAT
			counter: INTEGER
		do
			--| FIXME remove this.
			--rich_text.select_region (5, 8)
			--char := rich_text.character_format (1)
--			from
--				counter := 1
--			until
--				counter > 100
--			loop
--				create format
--				if counter \\ 2 = 1 then
--					format.enable_left_alignment
--				else
--					format.enable_center_alignment
--				end
--				rich_text.format_paragraph (rich_text.line_number_from_position (rich_text.selection_start), rich_text.line_number_from_position (rich_text.selection_end), format)
--				(create {EV_ENVIRONMENT}).application.process_events
--				counter := counter + 1
--			end
			format := rich_text.paragraph_format (10)
		end
		
	accelerator: EV_ACCELERATOR

end -- class MAIN_WINDOW

