C**************************************************************
C
C Description:
C This function computes a sampling of a 2D (XY) or 3D (XYZ) variable from
C a lon,lat vectors (I-ordered) representing sample positions. It uses 
C information contained in a grid file at the GDT netCDF conventions. 
C Find the exact cell of the model with the "Point Inclusion in Polygon Test" 
C (http://www.ecse.rpi.edu/Homepages/wrf/geom/) for the XY spatial location.
C If data to sample is 2D, the function returns a 1D (X) variable.
C If data to sample is 3D, the function returns a 2D (XZ) variable with the 
C vertical axis of the 3D variable field sampled.
C
C Author: Patrick Brockmann
C Contact: Patrick.Brockmann@cea.fr
C Date: $
C $Name: FAST_672_1_0 $
C $Revision: 1.1.1.5 $
C
C**************************************************************

C
C In this subroutine we provide information about
C the function.  The user configurable information 
C consists of the following:
C
C descr              Text description of the function
C
C num_args           Required number of arguments
C
C axis_inheritance   Type of axis for the result
C                       ( CUSTOM, IMPLIED_BY_ARGS, NORMAL, ABSTRACT )
C                       CUSTOM          - user defined axis
C                       IMPLIED_BY_ARGS - same axis as the incoming argument
C                       NORMAL          - the result is normal to this axis
C                       ABSTRACT        - an axis which only has index values
C
C piecemeal_ok       For memory optimization:
C                       axes where calculation may be performed piecemeal
C                       ( YES, NO )
C 
C
C For each argument we provide the following information:
C
C name               Text name for an argument
C
C unit               Text units for an argument
C
C desc               Text description of an argument
C
C axis_influence     Are this argument's axes the same as the result grid?
C                       ( YES, NO )
C
C axis_extend       How much does Ferret need to extend arg limits relative to result 
C

C-----------------------------------------------------------------------

      SUBROUTINE fast_sample_xy_init(id)

      INCLUDE 'ferret_cmn/EF_Util.cmn'

      INTEGER id, arg

C **********************************************************************
C                                            USER CONFIGURABLE PORTION |
C                                                                      |
C                                                                      V

      CHARACTER*256 fcn_desc

      WRITE (fcn_desc, 10)
   10 FORMAT
     . ('Returns data sampled at a set of (X,Y) points ',
     . 'using inclusion test on boundaries ',
     . 'of cells read from GDT grid file ')
      CALL ef_set_desc(id, fcn_desc)

      CALL ef_set_num_args(id, 5)
      CALL ef_set_axis_inheritance(id, 
     .     IMPLIED_BY_ARGS, NORMAL, IMPLIED_BY_ARGS, NORMAL)
      CALL ef_set_piecemeal_ok(id, NO, NO, NO, NO)

      CALL ef_set_num_work_arrays(id, 4)

      arg = 1
      CALL ef_set_arg_name(id, arg, 'X_POS')
      CALL ef_set_arg_unit(id, arg, 'Degrees East')
      CALL ef_set_arg_desc(id, arg, 'X values of sample points')
      CALL ef_set_axis_influence(id, arg, YES, NO, NO, NO)

      arg = 2 
      CALL ef_set_arg_name(id, arg, 'Y_POS')
      CALL ef_set_arg_unit(id, arg, 'Degrees North')
      CALL ef_set_arg_desc(id, arg, 'Y values of sample points')
      CALL ef_set_axis_influence(id, arg, YES, NO, NO, NO)

      arg = 3 
      CALL ef_set_arg_name(id, arg, 'DAT_TO_SAMPLE')
      CALL ef_set_arg_unit(id, arg, ' ')
      CALL ef_set_arg_desc(id, arg, 'variable (x,y,z) to sample')
      CALL ef_set_axis_influence(id, arg, NO, NO, YES, NO)

      arg = 4 
      CALL ef_set_arg_type(id, arg, STRING_ARG)
      CALL ef_set_arg_name(id, arg, 'FILENAME')
      CALL ef_set_arg_desc(id, arg, 
     .                     'NetCDF grid file at GDT conventions')
      CALL ef_set_axis_influence(id, arg, NO, NO, NO, NO)

      arg = 5 
      CALL ef_set_arg_type(id, arg, STRING_ARG)
      CALL ef_set_arg_name(id, arg, 'QUIET')
      CALL ef_set_arg_desc(id, arg, 
     .                     'Quiet option = "Q"')
      CALL ef_set_axis_influence(id, arg, NO, NO, NO, NO)

C                                                                      ^
C                                                                      ^
C                                                                      ^
C                                                                      ^
C                                                                      |
C                                            USER CONFIGURABLE PORTION |
C **********************************************************************

      RETURN 
      END


C-----------------------------------------------------------------------

*
* In this subroutine we request an amount of storage to be supplied
* by Ferret and passed as an additional argument.
*
      SUBROUTINE fast_sample_xy_work_size(id)

      INCLUDE 'ferret_cmn/EF_Util.cmn'
      INCLUDE 'ferret_cmn/EF_mem_subsc.cmn'

      INTEGER id

* **********************************************************************
*                                            USER CONFIGURABLE PORTION |
*                                                                      |
*                                                                      V

*
* Set the work array X/Y/Z/T dimensions
*
* ef_set_work_array_dims(id,array #,xlo,ylo,zlo,tlo,xhi,yhi,zhi,thi)
*
      INTEGER array_num
      INTEGER arg_lo_ss(4,1:EF_MAX_ARGS), arg_hi_ss(4,1:EF_MAX_ARGS),
     .     arg_incr(4,1:EF_MAX_ARGS)

      CALL ef_get_arg_subscripts(id, arg_lo_ss, arg_hi_ss, arg_incr)



C LON array
      array_num = 1 
      CALL ef_set_work_array_dims(id, array_num,
     .     arg_lo_ss(X_AXIS,ARG3), arg_lo_ss(Y_AXIS,ARG3), 
     .     1, 1, 
     .     arg_hi_ss(X_AXIS,ARG3), arg_hi_ss(Y_AXIS,ARG3), 
     .     1, 1) 

C BOUNDS_LON array
      array_num = 2 
      CALL ef_set_work_array_dims(id, array_num,
     .     arg_lo_ss(X_AXIS,ARG3), arg_lo_ss(Y_AXIS,ARG3), 
     .     1, 1, 
     .     arg_hi_ss(X_AXIS,ARG3), arg_hi_ss(Y_AXIS,ARG3), 
     .     2, 2) 

C BOUNDS_LAT array
      array_num = 3 
      CALL ef_set_work_array_dims(id, array_num,
     .     arg_lo_ss(X_AXIS,ARG3), arg_lo_ss(Y_AXIS,ARG3), 
     .     1, 1, 
     .     arg_hi_ss(X_AXIS,ARG3), arg_hi_ss(Y_AXIS,ARG3), 
     .     2, 2) 


*                                                                      ^
*                                                                      |
*                                            USER CONFIGURABLE PORTION |
* **********************************************************************

      RETURN 
      END

C-----------------------------------------------------------------------

      SUBROUTINE fast_sample_xy_result_limits(id) 

      INCLUDE 'ferret_cmn/EF_Util.cmn'
      INCLUDE 'ferret_cmn/EF_mem_subsc.cmn'
     
      INTEGER id
      INTEGER arg_lo_ss(4,1:EF_MAX_ARGS), arg_hi_ss(4,1:EF_MAX_ARGS),
     .     arg_incr(4,1:EF_MAX_ARGS)

C **********************************************************************
C                                            USER CONFIGURABLE PORTION |
C                                                                      |
C                                                                      V
      INTEGER*4 lo, hi 

      CALL ef_get_arg_subscripts(id, arg_lo_ss, arg_hi_ss, arg_incr) 

      lo =1
      hi = arg_hi_ss(X_AXIS,ARG1)-arg_lo_ss(X_AXIS,ARG1)+1 
      call ef_set_axis_limits(id, X_AXIS, lo, hi)
      WRITE(6,*) "XXXXXXXXXXXXXXXXXXXX",lo, hi

      lo =1
      hi = arg_hi_ss(Z_AXIS,ARG3)-arg_lo_ss(Z_AXIS,ARG3)+1 
      call ef_set_axis_limits(id, Z_AXIS, lo, hi)
      WRITE(6,*) "XXXXXXXXXXXXXXXXXXXX",lo, hi
C                                                                      ^
C                                                                      ^
C                                                                      |
C                                            USER CONFIGURABLE PORTION |
C **********************************************************************

      RETURN 
      END

C-----------------------------------------------------------------------

C
C In this subroutine we compute the result
C
      SUBROUTINE fast_sample_xy_compute(id, arg_1, arg_2, arg_3, 
     .     arg_4, arg_5, result)

      INCLUDE 'ferret_cmn/EF_Util.cmn'
      INCLUDE 'ferret_cmn/EF_mem_subsc.cmn'

      INTEGER id

      REAL bad_flag(1:EF_MAX_ARGS), bad_flag_result
      REAL arg_1(mem1lox:mem1hix, mem1loy:mem1hiy, 
     .           mem1loz:mem1hiz, mem1lot:mem1hit)
      REAL arg_2(mem2lox:mem2hix, mem2loy:mem2hiy, 
     .           mem2loz:mem2hiz, mem2lot:mem2hit)
      REAL arg_3(mem3lox:mem3hix, mem3loy:mem3hiy, 
     .           mem3loz:mem3hiz, mem3lot:mem3hit)
      REAL arg_4(mem4lox:mem4hix, mem4loy:mem4hiy, 
     .           mem4loz:mem4hiz, mem4lot:mem4hit)
      REAL arg_5(mem5lox:mem5hix, mem5loy:mem5hiy, 
     .           mem5loz:mem5hiz, mem5lot:mem5hit)
      REAL LON(wrk1lox:wrk1hix, wrk1loy:wrk1hiy,
     .               wrk1loz:wrk1hiz, wrk1lot:wrk1hit)
      REAL BOUNDS_LON(wrk2lox:wrk2hix, wrk2loy:wrk2hiy,
     .               wrk2loz:wrk2hiz, wrk2lot:wrk2hit)
      REAL BOUNDS_LAT(wrk3lox:wrk3hix, wrk3loy:wrk3hiy,
     .               wrk3loz:wrk3hiz, wrk3lot:wrk3hit)
      REAL result(memreslox:memreshix, memresloy:memreshiy,
     .            memresloz:memreshiz, memreslot:memreshit)

C After initialization, the 'res_' arrays contain indexing information 
C for the result axes.  The 'arg_' arrays will contain the indexing 
C information for each variable's axes. 

      INTEGER res_lo_ss(4), res_hi_ss(4), res_incr(4)
      INTEGER arg_lo_ss(4,1:EF_MAX_ARGS), arg_hi_ss(4,1:EF_MAX_ARGS),
     .     arg_incr(4,1:EF_MAX_ARGS)

      CHARACTER arg4_text*256
      CHARACTER arg5_text*256

C **********************************************************************
C                                            USER CONFIGURABLE PORTION |
C                                                                      |
C                                                                      V

      INTEGER i,j,k,l
      INTEGER i1, j1, k1, l1
      INTEGER i2, j2, k2, l2
      INTEGER i3, j3, k3, l3

      INCLUDE 'fast_sample_xy_common'

      INTEGER*4 INDEX_I,INDEX_J
      INTEGER*4 DYN1_X,DYN2_X 
      INTEGER*4 DYN3_X,DYN3_Y,DYN3_Z 

      CALL ef_get_res_subscripts(id, res_lo_ss, res_hi_ss, res_incr)
      CALL ef_get_arg_subscripts(id, arg_lo_ss, arg_hi_ss, arg_incr)
      CALL ef_get_bad_flags(id, bad_flag, bad_flag_result)

C******************************************************************
C Test arguments
      IF (arg_incr(Y_AXIS,ARG1).NE.0.OR.
     .    arg_incr(Z_AXIS,ARG1).NE.0.OR.
     .    arg_incr(T_AXIS,ARG1).NE.0) THEN
         CALL ef_bail_out(id,"Arg1 must be defined on XAXIS only!")
      END IF
      IF (arg_incr(Y_AXIS,ARG2).NE.0.OR.
     .    arg_incr(Z_AXIS,ARG2).NE.0.OR.
     .    arg_incr(T_AXIS,ARG2).NE.0) THEN
         CALL ef_bail_out(id,"Arg2 must be defined on XAXIS only!")
      END IF
      IF (arg_incr(T_AXIS,ARG3).NE.0) THEN
         CALL ef_bail_out(id,
     .           "Arg3 must not be defined on TAXIS!")
      END IF

      DYN1_X=arg_hi_ss(X_AXIS,ARG1)-arg_lo_ss(X_AXIS,ARG1)+1
      DYN2_X=arg_hi_ss(X_AXIS,ARG2)-arg_lo_ss(X_AXIS,ARG2)+1
      IF (DYN1_X.NE.DYN2_X) THEN
         CALL ef_bail_out(id,
     .   "Arg1,Arg2 must have the same size!")
      END IF

C******************************************************************
      CALL ef_get_arg_string(id,ARG4,arg4_text)
      CALL ef_get_arg_string(id,ARG5,arg5_text)

      DYN3_X=arg_hi_ss(X_AXIS,ARG3)-arg_lo_ss(X_AXIS,ARG3)+1
      DYN3_Y=arg_hi_ss(Y_AXIS,ARG3)-arg_lo_ss(Y_AXIS,ARG3)+1
      DYN3_Z=arg_hi_ss(Z_AXIS,ARG3)-arg_lo_ss(Z_AXIS,ARG3)+1

      CALL SXY_READ_GRIDFILE(id,arg4_text,
     .                   LON,BOUNDS_LON,BOUNDS_LAT)


      IF (arg5_text(1:1).NE.'Q') THEN
          WRITE(6,*) "Grid dimensions:"
          WRITE(6,*) "             IMT= ",IMT
          WRITE(6,*) "             JMT= ",JMT
          WRITE(6,*) "             KMT= ",KMT
          WRITE(6,*) "Variable dimensions:"
          WRITE(6,*) "             IMT= ",DYN3_X
          WRITE(6,*) "             JMT= ",DYN3_Y
          WRITE(6,*) "             KMT= ",DYN3_Z 
      END IF

      IF (DYN3_X.NE.IMT.OR.DYN3_Y.NE.JMT.
     .                  OR.DYN3_Z.GT.KMT) THEN
         CALL ef_bail_out(id,
     .            "Arg3 and grid file have incompatible size!")
      END IF

C******************************************************************
      i1 = arg_lo_ss(X_AXIS,ARG1)
      i2 = arg_lo_ss(X_AXIS,ARG2)
      i3 = arg_lo_ss(X_AXIS,ARG3)
      DO 400 i=res_lo_ss(X_AXIS), res_hi_ss(X_AXIS)

         j1 = arg_lo_ss(Y_AXIS,ARG1)
         j2 = arg_lo_ss(Y_AXIS,ARG2)
         j3 = arg_lo_ss(Y_AXIS,ARG3)
         DO 300 j=res_lo_ss(Y_AXIS), res_hi_ss(Y_AXIS)

            k1 = arg_lo_ss(Z_AXIS,ARG1)
            k2 = arg_lo_ss(Z_AXIS,ARG2)
            k3 = arg_lo_ss(Z_AXIS,ARG3)
            l1 = arg_lo_ss(T_AXIS,ARG1)
            l2 = arg_lo_ss(T_AXIS,ARG2)
            l3 = arg_lo_ss(T_AXIS,ARG3)

            IF (arg5_text(1:1).NE.'Q') THEN
                WRITE(6,*) "**************************"
                WRITE(6,*) "Sample #", i1 
                WRITE(6,*) "X=",arg_1(i1,j1,k1,l1)  
                WRITE(6,*) "Y=",arg_2(i1,j1,k1,l1)  
            END IF

            IF (arg_1(i1,j1,k1,l1).EQ.bad_flag(ARG1) .OR. 
     .          arg_2(i2,j2,k2,l2).EQ.bad_flag(ARG2)) THEN
            
                  result(i,j,k,l) = bad_flag_result

            ELSE

                  call SXY_FIND_CELL_XY(arg_1(i1,j1,k1,l1),
     .                              arg_2(i1,j1,k1,l1),
     .                              INDEX_I,INDEX_J,
     .                              LON,BOUNDS_LON,BOUNDS_LAT)

                  IF (INDEX_I.EQ.-999.OR.INDEX_J.EQ.-999) THEN

                      IF (arg5_text(1:1).NE.'Q') THEN
                          WRITE(6,*) "-----> Not found!"
                      END IF

                      result(i,j,k,l) = bad_flag_result

                  ELSE

                      IF (arg5_text(1:1).NE.'Q') THEN
                          WRITE(6,*) "-----> Found!"
                      END IF

                      DO 200 k=res_lo_ss(Z_AXIS), res_hi_ss(Z_AXIS)
                      DO 100 l=res_lo_ss(T_AXIS), res_hi_ss(T_AXIS)

                          result(i,j,k,l) = arg_3(INDEX_I,INDEX_J,k3,l3)

                          IF (arg5_text(1:1).NE.'Q') THEN
                              WRITE(6,*) "VAR[ I=",INDEX_I,
     .                                   " ,J=",INDEX_J,
     .                                   " ,K=",k3,
     .                                   " ]=",result(i,j,k,l)
                          END IF

                      l1 = l1 + arg_incr(T_AXIS,ARG1)
                      l2 = l2 + arg_incr(T_AXIS,ARG2)
                      l3 = l3 + arg_incr(T_AXIS,ARG3)
 100                  CONTINUE

                      k1 = k1 + arg_incr(Z_AXIS,ARG1)
                      k2 = k2 + arg_incr(Z_AXIS,ARG2)
                      k3 = k3 + arg_incr(Z_AXIS,ARG3)
 200                  CONTINUE

                   END IF

             END IF


            j1 = j1 + arg_incr(Y_AXIS,ARG1)
            j2 = j2 + arg_incr(Y_AXIS,ARG2)
            j3 = j3 + arg_incr(Y_AXIS,ARG3)
 300     CONTINUE

         i1 = i1 + arg_incr(X_AXIS,ARG1)
         i2 = i2 + arg_incr(X_AXIS,ARG2)
         i3 = i3 + arg_incr(X_AXIS,ARG3)
 400  CONTINUE

C                                                                      ^
C                                                                      |
C                                            USER CONFIGURABLE PORTION |
C **********************************************************************

      RETURN 
      END

C-----------------------------------------------------------------------
