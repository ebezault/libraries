indexing
	description: "Objects that represent an EV_DIALOG.%
		%The original version of this class was generated by EiffelBuild."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	GENERATION_DIALOG

inherit
	GENERATION_DIALOG_IMP

	SHARED_TEST_CONTROLLER
		undefine
			default_create, copy, is_equal
		end

	GENERATION_CONSTANTS
		undefine
			default_create, copy, is_equal
		end

feature {NONE} -- Initialization

	user_initialization is
			-- called by `initialize'.
			-- Any custom user initialization that
			-- could not be performed in `initialize',
			-- (due to regeneration of implementation class)
			-- can be added here.
		do
			set_default_cancel_button (cancel_button)
			cancel_button.select_actions.extend (agent hide)
			directory_display.set_background_color (create {EV_COLOR}.make_with_8_bit_rgb (255, 255, 255))
		end

feature -- Basic operation

	set_message (a_text: STRING) is
			-- Assign `a_text' to `message_label'.
		require
			a_text_not_void: a_text /= Void
		do
			message_label.set_text (a_text)
		ensure
			text_set: message_label.text.is_equal (a_text)
		end

feature {NONE} -- Implementation


	display_directory_dialog is
			-- Called by `select_actions' of `select_directory_button'.
		local
			directory: DIRECTORY
			error_dialog: EV_WARNING_DIALOG
			valid_directory: BOOLEAN
			cancelled: BOOLEAN
		do
			from
			until
				valid_directory or cancelled
			loop
				directory_dialog.show_modal_to_window (Current)
				create directory.make (directory_dialog.directory)
				if directory.exists then
					valid_directory := True
				elseif Directory_dialog.selected_button.is_equal ((create {EV_DIALOG_CONSTANTS}).ev_cancel) then
					cancelled := True
				else
					create error_dialog.make_with_text ("The selected directory does not exist.%NPlease select a valid directory.")
					error_dialog.show_modal_to_window (Current)
				end
			end
			if not cancelled then
				directory_display.set_text (Directory_dialog.directory)
				ok_button.enable_sensitive
			else
				directory_display.remove_text
				ok_button.disable_sensitive
			end
		end


	ok_pressed is
			-- Called by `select_actions' of `ok_button'.
		local
			directory: DIRECTORY
			contents: ARRAYED_LIST [STRING]
			clashing_files: STRING
			warning_dialog: WARNING_DIALOG
			supress_generation: BOOLEAN
		do
			create directory.make (directory_display.text)
			contents := directory.linear_representation
			contents.compare_objects
			clashing_files := ""
			if contents.has (Ace_file_name) then
				clashing_files := Ace_file_name + "%N"
			end
			if contents.has (Application_file_name) then
				clashing_files := clashing_files + Application_file_name + "%N"
			end
			if contents.has (Common_test_file_name) then
				clashing_files := clashing_files + Common_test_file_name + "%N"
			end
			if contents.has (Test_controller.selected_test_name + ".e") then
				clashing_files := clashing_files + Test_controller.selected_test_name + ".e" + "%N"
			end

			if not clashing_files.is_empty then
				clashing_files := "Conflict found in directory " + directory.name +
				"%NThe following files already exist:%N%N" + clashing_files +
				"%N%NDo you wish to overwrite these files?"
				create warning_dialog.make_with_text (clashing_files)
				warning_dialog.show_modal_to_window (Current)
				if not warning_dialog.selected_button.is_equal ("OK") then
					supress_generation := True
				end
			end
			if not supress_generation then
				test_controller.generate_current_test (directory)
				hide
			end
		end


	cancel_pressed is
			-- Called by `select_actions' of `cancel_button'.
		do
		end

	directory_dialog: EV_DIRECTORY_DIALOG is
			-- Dialog used to retrieve directory for
			-- generation.
		once
			create Result
		end


indexing
	copyright:	"Copyright (c) 1984-2006, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"


end -- class GENERATION_DIALOG


