note
	description: "Define a type of possible index type that occur in the tables we are interested in."
	date: "$Date$"
	revision: "$Revision$"

deferred class
	PE_LIST

inherit
	PE_INDEX_BASE
		redefine
			make_with_index,
			make_with_tag_and_index,
			get_index_shift,
			has_index_overflow
		end

feature {NONE} -- Initialization

	make_with_index (a_index: NATURAL_32)
		do
			Precursor (a_index)
			is_list_index_set := True
		ensure then
			is_list_index_set
		end

	make_with_tag_and_index (a_tag: INTEGER; a_index: NATURAL_32)
		do
			Precursor (a_tag, a_index)
			is_list_index_set := True
		ensure then
			is_list_index_set
		end

	make_default
		do
				-- TODO: also use a default `tag`?
			make_with_index (default_index)
			is_list_index_set := False
		end

feature -- Access

	associated_table_index: NATURAL_32
		deferred
		end

	default_index: NATURAL_32 = 0
			-- Index value for uninitialized `index`.

feature -- Operations

	update_index (idx: like index)
		require
			valid_index: idx >= 0
		do
			index := idx
			is_list_index_set := True
		ensure
			is_list_index_set
		end

feature -- Status report

	is_list_index_set: BOOLEAN
			-- Is first index of Current list set ?

feature -- Access

	get_index_shift: INTEGER
		do
			Result := 0
		end

	has_index_overflow (a_sizes: ARRAY [NATURAL_32]): BOOLEAN
		do
			Result := large (a_sizes [associated_table_index.to_integer_32 + 1])
		end

end
