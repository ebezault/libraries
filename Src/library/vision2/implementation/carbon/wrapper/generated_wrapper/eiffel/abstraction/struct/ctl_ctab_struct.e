-- This file has been generated by EWG. Do not edit. Changes will be lost!

class CTL_CTAB_STRUCT

inherit

	EWG_STRUCT

	CTL_CTAB_STRUCT_EXTERNAL
		export
			{NONE} all
		end

create

	make_new_unshared,
	make_new_shared,
	make_unshared,
	make_shared

feature {ANY} -- Access

	sizeof: INTEGER is
		do
			Result := sizeof_external
		end

feature {ANY} -- Member Access

	ccseed: INTEGER is
			-- Access member `ccSeed'
		require
			exists: exists
		do
			Result := get_ccseed_external (item)
		ensure
			result_correct: Result = get_ccseed_external (item)
		end

	set_ccseed (a_value: INTEGER) is
			-- Set member `ccSeed'
		require
			exists: exists
		do
			set_ccseed_external (item, a_value)
		ensure
			a_value_set: a_value = ccseed
		end

	ccrider: INTEGER is
			-- Access member `ccRider'
		require
			exists: exists
		do
			Result := get_ccrider_external (item)
		ensure
			result_correct: Result = get_ccrider_external (item)
		end

	set_ccrider (a_value: INTEGER) is
			-- Set member `ccRider'
		require
			exists: exists
		do
			set_ccrider_external (item, a_value)
		ensure
			a_value_set: a_value = ccrider
		end

	ctsize: INTEGER is
			-- Access member `ctSize'
		require
			exists: exists
		do
			Result := get_ctsize_external (item)
		ensure
			result_correct: Result = get_ctsize_external (item)
		end

	set_ctsize (a_value: INTEGER) is
			-- Set member `ctSize'
		require
			exists: exists
		do
			set_ctsize_external (item, a_value)
		ensure
			a_value_set: a_value = ctsize
		end

	cttable: POINTER is
			-- Access member `ctTable'
		require
			exists: exists
		do
			Result := get_cttable_external (item)
		ensure
			result_correct: Result = get_cttable_external (item)
		end

end
