-- This file has been generated by EWG. Do not edit. Changes will be lost!

class PIX_MAP_STRUCT

inherit

	EWG_STRUCT

	PIX_MAP_STRUCT_EXTERNAL
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

	baseaddr: POINTER is
			-- Access member `baseAddr'
		require
			exists: exists
		do
			Result := get_baseaddr_external (item)
		ensure
			result_correct: Result = get_baseaddr_external (item)
		end

	set_baseaddr (a_value: POINTER) is
			-- Set member `baseAddr'
		require
			exists: exists
		do
			set_baseaddr_external (item, a_value)
		ensure
			a_value_set: a_value = baseaddr
		end

	rowbytes: INTEGER is
			-- Access member `rowBytes'
		require
			exists: exists
		do
			Result := get_rowbytes_external (item)
		ensure
			result_correct: Result = get_rowbytes_external (item)
		end

	set_rowbytes (a_value: INTEGER) is
			-- Set member `rowBytes'
		require
			exists: exists
		do
			set_rowbytes_external (item, a_value)
		ensure
			a_value_set: a_value = rowbytes
		end

	bounds: POINTER is
			-- Access member `bounds'
		require
			exists: exists
		do
			Result := get_bounds_external (item)
		ensure
			result_correct: Result = get_bounds_external (item)
		end

	set_bounds (a_value: POINTER) is
			-- Set member `bounds'
		require
			exists: exists
		do
			set_bounds_external (item, a_value)
		end

	pmversion: INTEGER is
			-- Access member `pmVersion'
		require
			exists: exists
		do
			Result := get_pmversion_external (item)
		ensure
			result_correct: Result = get_pmversion_external (item)
		end

	set_pmversion (a_value: INTEGER) is
			-- Set member `pmVersion'
		require
			exists: exists
		do
			set_pmversion_external (item, a_value)
		ensure
			a_value_set: a_value = pmversion
		end

	packtype: INTEGER is
			-- Access member `packType'
		require
			exists: exists
		do
			Result := get_packtype_external (item)
		ensure
			result_correct: Result = get_packtype_external (item)
		end

	set_packtype (a_value: INTEGER) is
			-- Set member `packType'
		require
			exists: exists
		do
			set_packtype_external (item, a_value)
		ensure
			a_value_set: a_value = packtype
		end

	packsize: INTEGER is
			-- Access member `packSize'
		require
			exists: exists
		do
			Result := get_packsize_external (item)
		ensure
			result_correct: Result = get_packsize_external (item)
		end

	set_packsize (a_value: INTEGER) is
			-- Set member `packSize'
		require
			exists: exists
		do
			set_packsize_external (item, a_value)
		ensure
			a_value_set: a_value = packsize
		end

	hres: INTEGER is
			-- Access member `hRes'
		require
			exists: exists
		do
			Result := get_hres_external (item)
		ensure
			result_correct: Result = get_hres_external (item)
		end

	set_hres (a_value: INTEGER) is
			-- Set member `hRes'
		require
			exists: exists
		do
			set_hres_external (item, a_value)
		ensure
			a_value_set: a_value = hres
		end

	vres: INTEGER is
			-- Access member `vRes'
		require
			exists: exists
		do
			Result := get_vres_external (item)
		ensure
			result_correct: Result = get_vres_external (item)
		end

	set_vres (a_value: INTEGER) is
			-- Set member `vRes'
		require
			exists: exists
		do
			set_vres_external (item, a_value)
		ensure
			a_value_set: a_value = vres
		end

	pixeltype: INTEGER is
			-- Access member `pixelType'
		require
			exists: exists
		do
			Result := get_pixeltype_external (item)
		ensure
			result_correct: Result = get_pixeltype_external (item)
		end

	set_pixeltype (a_value: INTEGER) is
			-- Set member `pixelType'
		require
			exists: exists
		do
			set_pixeltype_external (item, a_value)
		ensure
			a_value_set: a_value = pixeltype
		end

	pixelsize: INTEGER is
			-- Access member `pixelSize'
		require
			exists: exists
		do
			Result := get_pixelsize_external (item)
		ensure
			result_correct: Result = get_pixelsize_external (item)
		end

	set_pixelsize (a_value: INTEGER) is
			-- Set member `pixelSize'
		require
			exists: exists
		do
			set_pixelsize_external (item, a_value)
		ensure
			a_value_set: a_value = pixelsize
		end

	cmpcount: INTEGER is
			-- Access member `cmpCount'
		require
			exists: exists
		do
			Result := get_cmpcount_external (item)
		ensure
			result_correct: Result = get_cmpcount_external (item)
		end

	set_cmpcount (a_value: INTEGER) is
			-- Set member `cmpCount'
		require
			exists: exists
		do
			set_cmpcount_external (item, a_value)
		ensure
			a_value_set: a_value = cmpcount
		end

	cmpsize: INTEGER is
			-- Access member `cmpSize'
		require
			exists: exists
		do
			Result := get_cmpsize_external (item)
		ensure
			result_correct: Result = get_cmpsize_external (item)
		end

	set_cmpsize (a_value: INTEGER) is
			-- Set member `cmpSize'
		require
			exists: exists
		do
			set_cmpsize_external (item, a_value)
		ensure
			a_value_set: a_value = cmpsize
		end

	pixelformat: INTEGER is
			-- Access member `pixelFormat'
		require
			exists: exists
		do
			Result := get_pixelformat_external (item)
		ensure
			result_correct: Result = get_pixelformat_external (item)
		end

	set_pixelformat (a_value: INTEGER) is
			-- Set member `pixelFormat'
		require
			exists: exists
		do
			set_pixelformat_external (item, a_value)
		ensure
			a_value_set: a_value = pixelformat
		end

	pmtable: POINTER is
			-- Access member `pmTable'
		require
			exists: exists
		do
			Result := get_pmtable_external (item)
		ensure
			result_correct: Result = get_pmtable_external (item)
		end

	set_pmtable (a_value: POINTER) is
			-- Set member `pmTable'
		require
			exists: exists
		do
			set_pmtable_external (item, a_value)
		ensure
			a_value_set: a_value = pmtable
		end

	pmext: POINTER is
			-- Access member `pmExt'
		require
			exists: exists
		do
			Result := get_pmext_external (item)
		ensure
			result_correct: Result = get_pmext_external (item)
		end

	set_pmext (a_value: POINTER) is
			-- Set member `pmExt'
		require
			exists: exists
		do
			set_pmext_external (item, a_value)
		ensure
			a_value_set: a_value = pmext
		end

end
