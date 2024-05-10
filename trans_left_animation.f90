program merge_files !written by Aditya Barman
    implicit none
    character(len=100) :: input_file, new_directory_name
    character(len=100) :: line
    integer :: j, unit_in, io_status

    ! Open the output file
    open(unit=11, file= "animation_trans_left.xyz", status='replace', action='write', iostat=io_status)
     

    ! Loop through input files and write their content to the output file
    do j = 1, 26
        input_file = 'trans_left_' // trim(adjustl(int2str(j))) // '.xyz'

        new_directory_name = 'trans_left_' // trim(adjustl(int2str(j)))
        
        ! Opening input file
        open(newunit=unit_in, file=input_file, status='old', action='read', iostat=io_status)
        if (io_status /= 0) then
            print*, "Error opening input file ", input_file
            close(11)
            stop
        end if

        do
            read(unit_in, '(A)', iostat=io_status) line
            if (io_status /= 0) then
                exit
            end if
            write(11, '(A)') trim(line)
        end do

        close(unit_in)
     
         !make the new directory/folder
         call system('mkdir ' // trim(new_directory_name))

         ! move the new output file, inside the new folder
         call system('mv ' // trim(input_file) // ' ' // trim(new_directory_name) // '/')
    end do

    close(11)

     

contains

    ! Function to convert integer to string
    function int2str(i) result(s)
        integer, intent(in) :: i
        character(len=10) :: s
        write(s, '(I10)') i
    end function int2str

end program merge_files
