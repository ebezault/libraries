note
	description	: "Strings for the Graphical User Interface"
	author		: "Generated by the New V=ion2 Application Wizard."
	date		: "$Date$"
	revision	: "1.0.0"

class
	INTERFACE_NAMES

feature -- Access

	Button_ok_item: STRING = "OK"
			-- String for "OK" buttons.

	Menu_file_item: STRING = "&File"
			-- String for menu "File"

	Menu_file_new_item: STRING = "&New%TCtrl+N"
			-- String for menu "File/New"

	Menu_file_open_item: STRING = "&Open...%TCtrl+O"
			-- String for menu "File/Open"

	Menu_file_save_item: STRING = "&Save%TCtrl+S"
			-- String for menu "File/Save"

	Menu_file_saveas_item: STRING = "Save &As..."
			-- String for menu "File/Save As"

	Menu_file_close_item: STRING = "&Close"
			-- String for menu "File/Close"

	Menu_file_exit_item: STRING = "E&xit"
			-- String for menu "File/Exit"

	Menu_help_item: STRING = "&Help"
			-- String for menu "Help"

	Menu_help_contents_item: STRING = "&Contents and Index"
			-- String for menu "Help/Contents and Index"

	Menu_help_about_item: STRING = "&About..."
			-- String for menu "Help/About"

	Label_confirm_close_window: STRING = "You are about to close the window.%NClick OK to proceed."
			-- String for the confirmation dialog box that appears
			-- when the user try to close the first window.

end -- class INTERFACE_NAMES
