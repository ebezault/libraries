﻿note
	description	: "Objects that represent the cursor of a text viewer"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	author: "Christophe Bonnard [ bonnard@bigfoot.com ] / Arnaud PICHERY [ aranud@mail.dotcom.fr ]"
	revised_by: "Alexander Kogtenkov"
	date: "$Date$"
	revision: "$Revision$"

class
	VIEWER_CURSOR

inherit
	CURSOR
		redefine
			is_equal
		end

	COMPARABLE
		redefine
			is_equal
		end

create
	make_from_absolute_pos, make_from_relative_pos,
	make_from_character_pos, make_from_integer

feature -- Initialization

	make_from_absolute_pos (x, y : INTEGER; a_text: like whole_text)
			-- Create a cursor in `a_text', at position given by
			-- `x' (in pixels) and `y' (in lines).
		require
			a_text_valid: a_text /= Void
			x_valid: x >= 0
			y_valid: y >= 1
		do
			whole_text := a_text
			set_y_in_lines (y)
			set_x_in_pixels (x)
		end

	make_from_relative_pos (a_line: VIEWER_LINE; a_token: EDITOR_TOKEN;
				pos: INTEGER; a_text: like whole_text)
			-- Create a cursor in `a_text', at position given by
			-- `a_line', `a_token' and `pos'.
		require
			a_text_valid: a_text /= Void
			a_line_valid: a_line /= Void
			a_line_valid: a_line.is_valid
			a_token_valid: a_token /= Void
			pos_valid: pos >= 1
		do
			whole_text := a_text
			set_line (a_line)
			set_current_char (a_token, pos)
		end

	make_from_character_pos (ch_num, y: INTEGER; a_text: like whole_text)
			-- Create a cursor in `a_text', at the `ch_num'th
			-- character in line `y'.
		require
			a_text_valid: a_text /= Void
			ch_num_valid: ch_num >= 1
			y_valid: y >= 1
		do
			whole_text := a_text
			set_y_in_lines (y)
			set_x_in_characters (ch_num)
		end

	make_from_integer (ch_num: INTEGER; a_text: like whole_text)
			-- Create a cursor in `a_text', at the `ch_num'th
			-- character of the whole text.
		require
			a_text_valid: a_text /= Void
			ch_num_valid: ch_num >= 1
		local
			pos: INTEGER
			cline: detachable VIEWER_LINE
			t: detachable EDITOR_TOKEN
		do
			whole_text := a_text
			from
				pos := ch_num
				cline := whole_text.first_line
				check cline /= Void end -- Not possible, otherwise a bug.
				t := cline.first_token
				check t /= Void end -- Never, otherwise a bug.
			until
				pos <= t.length
			loop
				pos := pos - t.length
				t := t.next
				if t = Void and then attached cline.next as l_next then
						--| No next token? go to next line, if possible.
					cline := l_next
					t := cline.first_token
				end
				check t /= Void end -- Never, otherwise a bug.
			end
			make_from_relative_pos (cline, t, pos, a_text)
		end

feature -- Access

		--| Relative position

	token: EDITOR_TOKEN
			-- Token where Current is

	pos_in_token: INTEGER
			-- Character (in `token') Current points on

	line: VIEWER_LINE
			-- Line where Current is

		--| Absolute position

	x_in_pixels: INTEGER
			-- Theoric horizontal position of Current, in pixels
			--| (Caution! Unlike all others, this attribute is 0-based.)

	y_in_lines: INTEGER
			-- Line number of Current in the whole text

		--| Character-based position

	x_in_characters: INTEGER
			-- Horizontal position of Current, in characters.
		local
			current_token : detachable EDITOR_TOKEN
		do
			Result := pos_in_token
			from
				current_token := token.previous
			until
				current_token = Void
			loop
				Result := Result + current_token.length
				current_token := current_token.previous
			end
		end

		--| Other functions

	item: CHARACTER
			-- Character current points on
		obsolete
			"Use wide_item instead [2017-05-31]"
		do
			Result := wide_item.to_character_8
		end

	wide_item: CHARACTER_32
			-- Character current points on
		do
			if token = line.eol_token then
				Result := '%N'
			else
				Result := token.wide_image [pos_in_token]
			end
		end

	pos_in_characters: INTEGER
			-- Position of Current, in characters from the start of the text.
		local
			a_line: detachable VIEWER_LINE
		do
				--| First, we add the EOL characters
			Result := y_in_lines -1
				--| then we sum the lines
			from
				a_line := whole_text.first_line
			until
				a_line = line
			loop
				check a_line /= Void end -- Never, otherwise a bug.
				Result := Result + a_line.wide_image.count
				a_line := a_line.next
			end
			Result := Result + x_in_characters
		end

	number_of_lines: INTEGER
			-- Number of lines in `whole_text'
		do
			Result := whole_text.count
		end

feature -- Cursor movement

	go_right_char
			-- Move to next character, if there is one.
		local
			l_first_token: detachable EDITOR_TOKEN
		do
			if pos_in_token = token.length then
					-- Go to next token, first character.
				if not attached token.next as l_next then
						-- No next token? Go to next line.
					if line.next /= Void then
						set_line_to_next
						l_first_token := line.first_token
						check l_first_token /= Void end -- Never, otherwise a bug.
						set_current_char (l_first_token, 1)
					end
				else
					set_current_char (l_next, 1)
				end
			else
				set_current_char (token, pos_in_token + 1)
			end
		end

	go_left_char
			-- Move to previous character, if there is one.
		local
			l_eol_token: detachable EDITOR_TOKEN
		do
			if pos_in_token = 1 then
					-- Go to previous token, last character.
				if not attached token.previous as l_previous then
						-- No previous token? Go to previous line.
					if line.previous /= Void then
						set_line_to_previous
						l_eol_token := line.eol_token
						check l_eol_token /= Void end -- Never, otherwise a bug.
						set_current_char (l_eol_token, l_eol_token.length)
					end
				else
					set_current_char (l_previous, l_previous.length)
				end
			else
				set_current_char (token, pos_in_token - 1)
			end
		end

	go_up_line
			-- Move up one line (to preceding line), if possible.
		do
			set_line_to_previous
			update_current_char
		end

	go_down_line
			-- Move down one line (to next line), if possible.
		do
			set_line_to_next
			update_current_char
		end

	go_start_line
			-- Move to beginning of line.
		local
			l_token: detachable EDITOR_TOKEN
		do
			l_token := line.first_token
			check l_token /= Void end -- Never, otherwise a bug.
			set_current_char (l_token, 1)
		end

	go_end_line
			-- Move to end of line.
		local
			l_token: detachable EDITOR_TOKEN
		do
			l_token := line.eol_token
			check l_token /= Void end -- Never, otherwise a bug.
			set_current_char (l_token, l_token.length)
		end

feature -- Element change

	set_line (a_line: like line)
			-- Make `a_line' the new value of `line'.
		require
			a_line_exists: a_line /= Void
			a_line_valid: a_line.is_valid
		do
			line := a_line
			y_in_lines := a_line.index
			update_current_char
		end

	set_current_char (a_token: EDITOR_TOKEN; a_position: INTEGER)
			-- Make `a_token' be the new value for `token'.
			-- Set the value of `pos_in_token' to `a_position'.
			-- Update `x_in_pixels' accordingly.
		require
			a_token_exists: a_token /= Void
			a_position_positive_not_null: a_position >= 0
		local
			current_width: INTEGER
			current_token: detachable EDITOR_TOKEN
		do
				-- Update the attributes.
			token := a_token
			pos_in_token := a_position

				-- Compute the size of the current token.
			current_width := a_token.get_substring_width (a_position - 1)

				-- Rewind the tokens of the line to get
				-- the width of each one.
			from
				current_token := a_token.previous
			until
				current_token = Void
			loop
				current_width := current_width + current_token.width
				current_token := current_token.previous
			end

				-- Update the value of `x_in_pixels'
			x_in_pixels := current_width
		end

	set_x_in_pixels (x: INTEGER)
			-- Make `x' be the new value of `x_in_pixels'.
		require
			x_valid: x >= 0
		do
				-- Update the attribute.
			x_in_pixels := x

				-- Update the current token and the
				-- the position in it.
			update_current_char
		end

	set_y_in_lines (y: INTEGER)
			-- Make `y' be the new value of `y_in_lines'.
			-- Change `line' accordingly.
		require
			y_valid: y >= 1 and then y <= number_of_lines
		local
			l_line: detachable like line
		do
			y_in_lines := y

				-- Update the line attribute.
			l_line := whole_text.item (y)
			check l_line /= Void end -- Implied by precondition
			line := l_line
			update_current_char
		end

	set_x_in_characters (x_in_ch: INTEGER)
			-- Set attributes so that `x_in_characters' return `x_in_ch'.
		require
			x_in_ch_valid: x_in_ch >= 1
		local
			current_x: INTEGER
			current_token, l_end_token: detachable EDITOR_TOKEN
			remaining_ch: INTEGER
		do
				-- Update the current token.
			from
				current_token := line.first_token
				current_x := 0
				remaining_ch := x_in_ch
			until
				current_token = Void or else remaining_ch <= current_token.length
			loop
					-- Compute where we are in pixels.
				current_x := current_x + current_token.width

					-- Compute where we are in characters.
				remaining_ch := remaining_ch - current_token.length

					-- Prepare next iteration.
				current_token := current_token.next
			end
			check
				before_goal: remaining_ch > 0
			end
			if current_token /= Void then
					-- We stopped in a token. Now we look in the token.
				token := current_token
				pos_in_token := remaining_ch

					-- Now retrieve position in pixels
				x_in_pixels := current_x + token.get_substring_width (remaining_ch - 1)
			else
					-- The cursor is further than the end of the line, so
					-- we set the current token to the last of the line.
				l_end_token := line.eol_token
				check l_end_token /= Void end -- Not possible, otherwise a bug.
				token := l_end_token
				pos_in_token := 1
				x_in_pixels := current_x
			end
		ensure
			valid_result: x_in_characters = x_in_ch
		end

feature -- Comparison

	is_less alias "<" (other: like Current): BOOLEAN
			-- Is current object less than `other'?
		do
			Result := (y_in_lines < other.y_in_lines) or else
				((y_in_lines = other.y_in_lines) and then (x_in_pixels < other.x_in_pixels and then
												((token /= other.token) or else (pos_in_token /= other.pos_in_token))))
				--| We have to verify that Current and `other' are not equal.
		end

	is_equal (other: like Current): BOOLEAN
			-- Is Current equal to `other'?
		do
			Result := (y_in_lines = other.y_in_lines) and then (token = other.token) and then (pos_in_token = other.pos_in_token)
		end

feature {NONE} -- Implementation

	set_line_to_next
			-- Make `line.next' the new value of `line'.
			-- Change `y_in_lines' accordingly.
			-- Do not update `pos' and `token',
			-- as it is done at a higher level.
		local
--			last_line_displayed: INTEGER
		do
			if attached line.next as l_next then
				line := l_next
				y_in_lines := y_in_lines + 1

---------------------------------------
-- FIXME ARNAUD: To be done in Vision2
---------------------------------------
--					-- Scroll the window if necessary
--				last_line_displayed := associated_window.first_line_displayed
--									 + associated_window.number_of_lines_displayed - 1
--				if y_in_lines >= last_line_displayed then
--					associated_window.on_vertical_scroll (Sb_linedown,0)
--				end
---------------------------------------
			end
		end

	set_line_to_previous
			-- Make `line.previous' the new value of `line'.
			-- Change `y_in_lines' accordingly.
			-- Do not update `pos' and `token',
			-- as it is done at a higher level.
		do
			if attached line.previous as l_previous then
				line := l_previous
				y_in_lines := y_in_lines - 1

---------------------------------------
-- FIXME ARNAUD: To be done in Vision2
---------------------------------------
--					-- Scroll the window if necessary
--				if y_in_lines <= associated_window.first_line_displayed - 1 then
--					associated_window.on_vertical_scroll (Sb_lineup,0)
--				end
---------------------------------------
			end
		end

	update_current_char
			-- Update the current token and the the position in it.
		local
			current_x: INTEGER
			current_token, l_previous, l_end_token: detachable EDITOR_TOKEN
		do
				-- Update the current token.
			from
				current_token := line.first_token
				current_x := 0
			until
				current_token = Void or else current_x >= x_in_pixels
			loop
					-- Compute where we are in pixels.
				current_x := current_x + current_token.width

					-- Prepare next iteration.
				current_token := current_token.next
			end

			if current_token /= Void then
				-- The cursor is situated before the end of the line.
				if current_x = x_in_pixels then
						-- We are lucky. The cursor is situated at the
						-- beggining of a token
					pos_in_token := 1
					token := current_token
				else
						-- We are too far, so the good token is the
						-- previous one, we have to look into it.
					l_previous := current_token.previous
					check l_previous /= Void end -- Never, otherwise a bug.
					token := l_previous
						-- Retrieve the position inside the token.
					pos_in_token := l_previous.retrieve_position_by_width (l_previous.width + x_in_pixels - current_x)
				end
			else
				-- The cursor is further than the end of the line, so
				-- we set the current token to the last of the line.
				l_end_token := line.eol_token
				check l_end_token /= Void end -- Never, otherwise a bug.
				token := l_end_token
				pos_in_token := 1
			end
		end

	update_x_in_pixels
			-- Update x_in_pixels from `token' and `pos_in_token'
		local
			current_width: INTEGER
			current_token: detachable EDITOR_TOKEN
		do
				-- Compute the size of the current token.
			current_width := token.get_substring_width(pos_in_token - 1)

				-- Rewind the tokens of the line to get
				-- the width of each one.
			from
				current_token := token.previous
			until
				current_token = Void
			loop
				current_width := current_width + current_token.width
				current_token := current_token.previous
			end

				-- Update the value of `x_in_pixels'
			x_in_pixels := current_width
		end

feature {NONE} -- Private attributes

	whole_text: VIEWER_CONTENT
		-- Whole text displayed.

invariant
	x_in_pixels_positive_or_null: x_in_pixels >= 0
	y_in_lines_positive_or_null: y_in_lines >= 0
	pos_in_token_positive: pos_in_token > 0
	whole_text_not_void: whole_text /= Void

note
	copyright:	"Copyright (c) 1984-2021, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"

end
