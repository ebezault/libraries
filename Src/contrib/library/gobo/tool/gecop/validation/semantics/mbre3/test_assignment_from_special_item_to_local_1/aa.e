class AA

create

	make

feature

	make
		local
			s: SPECIAL [CC]
			d: DD
			c1, c2: CC
		do
			create s.make_empty (5)
			d.set_value (2)
			if condition then
				print ("## copy expected%N")
				s.extend (d)
			else
				s.extend (create {CC})
			end
			print ("## copy expected%N")
			c1 := s.item (0)
			print ("## copy expected%N")
			c2 := s.item (0)
			print ("##%N")
			print ("c1.value = " + c1.value.out + "%N")
			print ("c2.value = " + c2.value.out + "%N")
			c1.set_value (3)
			print ("c1.value = " + c1.value.out + "%N")
			print ("c2.value = " + c2.value.out + "%N")
			c2.set_value (4)
			print ("c1.value = " + c1.value.out + "%N")
			print ("c2.value = " + c2.value.out + "%N")
		end
	
	condition: BOOLEAN
		local
			s: STRING
		do
			s := "gobo"
			Result := s.count \\ 2 = 0
		end
		
end
