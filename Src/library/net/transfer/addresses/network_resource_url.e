indexing
	description:
		"URLs for network resources"

	status:	"See note at end of class"
	date: "$Date$"
	revision: "$Revision$"

deferred class NETWORK_RESOURCE_URL inherit

	URL
		redefine
			make, is_equal
		end

	HOST_VALIDITY_CHECKER
		rename
			host_ok as proxy_host_ok
		undefine
			is_equal
		end

feature {NONE} -- Initialization

	make (a: STRING) is
			-- Create address.
		do
			create username.make (0)
			create password.make (0)
			path_charset := Host_charset.twin
			path_charset.add ("%%/_")
			Precursor (a)
		end
		
feature -- Access

	host: STRING
			-- Name or IP address of host

	path: STRING
			-- Path of resource

	username: STRING
			-- Optional username

	password: STRING
			-- Optional password

	location: STRING is
			-- Full URL of resource
		do
			Result := service.twin
			Result.append ("://")
			Result.append (host)
			Result.extend ('/')
			if path /= Void and then not path.is_empty then
				Result.append (path)
			end
		end
			
	hash_code: INTEGER is
			-- Hash function
		local
			str: STRING
		do
			str := host.twin
			if not username.is_empty then
				str.precede (':')
				str.prepend (username)
			end
			Result := str.hash_code
		end

feature -- Comparison

	is_equal (other: like Current): BOOLEAN is
			-- Is equal to `other'?
		do
			if host /= Void and username /= Void and other /= Void then
				Result := equal (host, other.host) and 
					equal (username, other.username)
				if Result then
					Result := equal (is_proxy_used, other.is_proxy_used)
					if Result and is_proxy_used then
						Result := equal (proxy_host, other.proxy_host)
					end
				end
			end
		end

feature -- Status report

	is_host_correct (h: STRING): BOOLEAN is
			-- Is host `h' name correct?
		do
			Result :=  h /= Void and then host_charset.contains_string (h)
		end

	is_path_correct (p: STRING): BOOLEAN is
			-- Is path name correct?
		do
			Result := p /= Void and then path_charset.contains_string (p)
		end

	is_correct: BOOLEAN is
			-- Is address correct?
		do
			Result := is_host_correct (host) and then is_path_correct (path)
		end

	is_password_accepted: BOOLEAN is
			-- Can a password be set?
		do
			Result := not username.is_empty
		end
		
feature -- Status setting

	set_username (un: STRING) is
			-- Set username.
		do
			username := un
		ensure then
			username_set: username = un
		end
	 
	set_password (pw: STRING) is
			-- Set password.
		do
			password := pw
		ensure then
			password_set: password = pw
		end
	 
feature {NONE} -- Basic operations

	analyze is
			-- Analyze address.
		local
			pos, pos2: INTEGER
		do
			if not address.has ('/') then
				address.extend ('/')
			end
			pos := address.index_of ('/', 1)
				check
					has_slash: pos > 0
						-- Because we added a slash if there was none 
				end
			if pos > 1 and address.substring_index ("//", 1) = 0 and
				address.substring_index (Service + ":", 1) = 0 then
				host := address.substring (1, pos - 1)
				address.remove_head (pos)
				path := address.twin
			elseif address.substring_index ("//", 1) > 0 and 
				address.substring_index (Service + ":", 1) > 0 then
				pos2 := address.index_of ('/', pos + 2)
				host := address.substring (pos + 2, pos2 - 1)
				address.remove_head (pos2)
				path := address.twin
			end		
			
			host.to_lower
						
			if not host.is_empty and has_username and 
				host.occurrences ('@') = 1 then
				pos := host.index_of ('@', 1)
				username := host.substring (1, pos - 1)
				host.remove_head (pos)
				if not username.is_empty and 
					username.occurrences (':') = 1 then
					pos := username.index_of (':', 1)
					password := username.substring (pos + 1, username.count)
					username.keep_head (pos - 1)
				end
			end
			if not host.is_empty and host.occurrences (':') <= 1 then
				pos := host.index_of (':', 1)
				if pos = host.count then
					host.remove_tail (1)
					pos := 0
				elseif pos > 0 and 
					host.substring (pos + 1, host.count).is_integer then
					port := host.substring (pos + 1, host.count).to_integer
					host.remove_head (pos)
				end
			end
		end

feature {NONE} -- Implementation

	path_charset: CHARACTER_SET
			-- Character set for path names
	
invariant

	path_charset_defined: path_charset /= Void and then 
				not path_charset.is_empty
	username_exists: username /= Void
	password_exists: password /= Void
	password_constraint: not password.is_empty implies not username.is_empty
	
end -- class NETWORK_RESOURCE_URL

--|----------------------------------------------------------------
--| EiffelNet: library of reusable components for ISE Eiffel.
--| Copyright (C) 1985-2004 Eiffel Software. All rights reserved.
--| Duplication and distribution prohibited.  May be used only with
--| ISE Eiffel, under terms of user license.
--| Contact Eiffel Software for any other use.
--|
--| Interactive Software Engineering Inc.
--| dba Eiffel Software
--| 356 Storke Road, Goleta, CA 93117 USA
--| Telephone 805-685-1006, Fax 805-685-6869
--| Contact us at: http://www.eiffel.com/general/email.html
--| Customer support: http://support.eiffel.com
--| For latest info on our award winning products, visit:
--|	http://www.eiffel.com
--|----------------------------------------------------------------

