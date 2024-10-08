﻿note
	description: "[
		Device independent bitmap which can be created from a file.

		Note: Not all variants of the bmp format can be read. If you have
			problems with a certain image please use i.e. MS Paint to convert
			the image to the standard bmp format and then try again.
		]"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	WEL_DIB

inherit
	WEL_STRUCTURE
		rename
			make as structure_make
		redefine
			destroy_item
		end

	IDENTIFIED_ROUTINES
		undefine
			copy, is_equal
		end

create
	make_by_file,
	make_by_stream,
	make_by_content_pointer,
	make_with_info_and_data

feature {NONE} -- Initialization

	make_by_file (file: RAW_FILE)
			-- Create the dib by reading `file'.
		require
			file_not_void: file /= Void
			file_exists: file.exists
			file_opened: file.is_open_read
		do
			make_by_stream (file)
			file.close
		ensure
			file_closed: file.is_closed
		end

	make_by_stream (a_stream: IO_MEDIUM)
		require
			a_stream_not_void: a_stream /= Void
			a_stream_exists: a_stream.exists
			a_stream_opened: a_stream.is_open_read
		local
			bitmap_file_header: WEL_BITMAP_FILE_HEADER
			a_buf_1, a_buf_2: MANAGED_POINTER
		do
			create bitmap_file_header.make
			create info_header.make
			create a_buf_1.share_from_pointer (bitmap_file_header.item, bitmap_file_header.structure_size)
			a_stream.read_to_managed_pointer (a_buf_1, 0, bitmap_file_header.structure_size)
			structure_size := bitmap_file_header.size - bitmap_file_header.structure_size
			structure_make
			create a_buf_2.share_from_pointer (item, structure_size)
			a_stream.read_to_managed_pointer (a_buf_2, 0, structure_size)
			info_header.memory_copy (item, info_header.structure_size)
			palette := new_palette
		end

	make_by_content_pointer (bits_ptr: POINTER; size: INTEGER)
		obsolete
			"Use `make_with_info_and_data' which is a safer way to proceed [2017-05-31]."
		do
			create info_header.make

			structure_size := size
			structure_make

			memory_copy (bits_ptr, structure_size)
			info_header.memory_copy (item, info_header.structure_size)
			palette := new_palette
		end

	make_with_info_and_data (an_info: WEL_BITMAP_INFO; a_ptr: POINTER; a_size: INTEGER)
			-- Create a WEL_DIB section using data of `a_ptr' corresponding to `an_info'.
		require
			an_info_not_void: an_info /= Void
			an_info_exists: an_info.exists
			a_ptr_not_null: a_ptr /= default_pointer
			a_size_positive: a_size > 0
			rgb_data: an_info.header.compression = {WEL_BI_COMPRESSION_CONSTANTS}.bi_rgb
			valid_size:
				(4 * ((an_info.header.width * an_info.header.bit_count + 31) // 32)) * an_info.header.height = a_size
		do
			structure_size := a_size + an_info.structure_size
			structure_make
			item.memory_copy (an_info.item, an_info.structure_size)
			(item + an_info.structure_size).memory_copy (a_ptr, a_size)
			create info_header.make
			info_header.memory_copy (item, info_header.structure_size)
			palette := new_palette
		end

feature -- Access

	color_count: INTEGER
			-- How many colors in the dib?
		require
			exists: exists
		do
			Result := info_header.color_count
		ensure
			positive_result: Result >= 0
		end

	width: INTEGER
			-- Dib width.
		require
			exists: exists
		do
			Result := info_header.width
		ensure
			positive_result: Result >= 0
		end

	height: INTEGER
			-- Dib height.
		require
			exists: exists
		do
			Result := info_header.height
		ensure
			positive_result: Result >= 0
		end

	item_bits: POINTER
		require
			exists: exists
		do
			Result := item + (info_header.structure_size + color_count * rgb_quad_size)
		end

	palette: WEL_PALETTE
			-- Dib palette.
			--
			-- You can track the references of `palette' if you want to
			-- free the GDI object contained in `palette' more quickly.

feature -- Basic operations

	set_pal_color
			-- Transform the dib to be compatible with
			-- `Dib_pal_colors' mode.
		require
			exists: exists
		local
			i: INTEGER
			num_color: INTEGER
		do
			num_color := color_count
			from
				i := 0
			until
				i = num_color
			loop
				(item + (info_header.structure_size + i * rgb_quad_size // 2)).	memory_copy ($i, 1)
				i := i + 1
			end
		end

feature -- Measurement

	structure_size: INTEGER
			-- Size of the C structure representing `Current'.

feature {NONE} -- Removal

	destroy_item
			-- Free all GDI resource allocated by Current.
			-- Should be called by the GC or by the user.
		do
			if palette.reference_tracked then
				palette.decrement_reference
			elseif palette.references_count = 0 then
				palette.delete
			end
			info_header.dispose
			Precursor
		end

feature {NONE} -- Implementation

	i_th_quad (i: INTEGER): WEL_RGB_QUAD
		require
			exists: exists
			positive_i: i >= 0
			i_small_enough: i < color_count
		do
			create Result.make
			Result.memory_copy (item + (info_header.structure_size + i * rgb_quad_size), rgb_quad_size)
		ensure
			result_not_void: Result /= Void
		end

	new_palette: WEL_PALETTE
			-- Calculates pallete for images regardless of their colordepth.
		require
			exists: exists
		local
			num_color: INTEGER
		do
			num_color := color_count
			if num_color /= 0 then
				Result := new_palette_all_but_24_bits
			elseif has_24_bits or has_32_bits then
				Result := new_palette_24_bits
			else
					-- Dead end! This code must never be reached
				check
					dead_end: False
				end
					-- For void-safety purpose, create a dummy palette
				create Result.make (create {WEL_LOG_PALETTE}.make (1, 1))
			end
		ensure
			palette_not_void: Result /= Void
			palette_exists: Result.exists
		end

	new_palette_all_but_24_bits: WEL_PALETTE
			-- Calculates pallete for images with all colordepths except 24 bits.
		require
			exists: exists
			has_not_24_bits: not has_24_bits

		local
			ind: INTEGER
			pal_entry: WEL_PALETTE_ENTRY
			log_pal: WEL_LOG_PALETTE
			rgb_quad: WEL_RGB_QUAD
			num_color: INTEGER
		do
			num_color := color_count
			create log_pal.make (768, num_color)
			--| 768 is the Windows version (0x300)
			from
				ind := 0
			until
				ind = num_color
			loop
				rgb_quad := i_th_quad (ind)
				create pal_entry.make (rgb_quad.red, rgb_quad.green,
							rgb_quad.blue, 0)
				log_pal.set_pal_entry (ind, pal_entry)
				ind := ind + 1
			end
			create Result.make (log_pal)
		ensure
			palette_not_void: Result /= Void
			palette_exists: Result.exists
		end

	new_palette_24_bits: WEL_PALETTE
			-- Calculates pallete for images with a colordepth of 24 bits (32bits is the same).
			-- A 24 bitcount DIB has no color table entries so, set the number of
			-- to the maximum value (max_palette).
		require
			exists: exists
			has_24_bits: has_24_bits or has_32_bits
		local
			ind, red, green, blue: INTEGER
			pal_entry: WEL_PALETTE_ENTRY
			log_pal: WEL_LOG_PALETTE
		do
			create log_pal.make (768, max_palette)
			from
				ind := 0
			until
				ind = max_palette
			loop
				create pal_entry.make (red, green, blue, 0)
				log_pal.set_pal_entry (ind, pal_entry)


				red := red + 32
				if
					red = 256
				then
					red := 0
					green := green + 32
					if
						green = 256
					then
						green := 0
						blue := blue + 64
						if
							blue = 256
						then
							blue := 0
						end
					end
				end

				ind := ind + 1
			end
			create Result.make (log_pal)
		ensure
			palette_not_void: Result /= Void
			palette_exists: Result.exists
		end

	has_24_bits: BOOLEAN
		require
			exists: exists
		do
			Result := info_header.bit_count = 24
		end

	has_32_bits: BOOLEAN
		require
			exists: exists
		do
			Result := info_header.bit_count = 32
		end

	max_palette: INTEGER = 256

	rgb_quad_size: INTEGER
		local
			rgb: WEL_RGB_QUAD
		once
			create rgb.make
			Result := rgb.structure_size
		ensure
			positive_result: Result >= 0
		end

feature {WEL_BITMAP}

	info_header: WEL_BITMAP_INFO_HEADER;

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
