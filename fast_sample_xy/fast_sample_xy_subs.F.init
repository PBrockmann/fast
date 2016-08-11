C******************************************************************
      SUBROUTINE SXY_READ_GRIDFILE (id,FILENAME,
     .           LON,BOUNDS_LON,BOUNDS_LAT)

      INTEGER*4 id
      CHARACTER*256 FILENAME
      REAL*4 LON(*),BOUNDS_LON(*),BOUNDS_LAT(*)

      INCLUDE 'fast_sample_xy_common'

      INCLUDE 'netcdf.inc'
      INTEGER*4 NCID
      INTEGER*4 VARID,VARDIMIDS(NF_MAX_VAR_DIMS)
      INTEGER*4 STATUS

      STATUS=NF_OPEN(FILENAME,NF_NOWRITE,NCID)
      IF (STATUS.NE.NF_NOERR) CALL HANDLE_ERR(id,STATUS)

      STATUS=NF_INQ_VARID(NCID,"lon",VARID)
      IF (STATUS.NE.NF_NOERR) STATUS=NF_INQ_VARID(NCID,"LON",VARID)
      IF (STATUS.NE.NF_NOERR) CALL HANDLE_ERR(id,STATUS)

      STATUS=NF_GET_VAR_REAL(NCID,VARID,LON)
      IF (STATUS.NE.NF_NOERR) CALL HANDLE_ERR(id,STATUS)

      STATUS=NF_INQ_VARDIMID(NCID,VARID,VARDIMIDS)
      IF (STATUS.NE.NF_NOERR) CALL HANDLE_ERR(id,STATUS)

      STATUS=NF_INQ_DIMLEN(NCID,VARDIMIDS(1),IMT)
      IF (STATUS.NE.NF_NOERR) CALL HANDLE_ERR(id,STATUS)

      STATUS=NF_INQ_DIMLEN(NCID,VARDIMIDS(2),JMT)
      IF (STATUS.NE.NF_NOERR) CALL HANDLE_ERR(id,STATUS)

      STATUS=NF_INQ_VARID(NCID,"bounds_lon",VARID)
      IF (STATUS.NE.NF_NOERR) STATUS=NF_INQ_VARID(NCID,"BOUNDS_LON",VARID)
      IF (STATUS.NE.NF_NOERR) CALL HANDLE_ERR(id,STATUS)

      STATUS=NF_GET_VAR_REAL(NCID,VARID,BOUNDS_LON)
      IF (STATUS.NE.NF_NOERR) CALL HANDLE_ERR(id,STATUS)

      STATUS=NF_INQ_VARID(NCID,"bounds_lat",VARID)
      IF (STATUS.NE.NF_NOERR) STATUS=NF_INQ_VARID(NCID,"BOUNDS_LAT",VARID)
      IF (STATUS.NE.NF_NOERR) CALL HANDLE_ERR(id,STATUS)
 
      STATUS=NF_GET_VAR_REAL(NCID,VARID,BOUNDS_LAT)
      IF (STATUS.NE.NF_NOERR) CALL HANDLE_ERR(id,STATUS)

      STATUS=NF_INQ_VARID(NCID,"bounds_depth",VARID)
      IF (STATUS.NE.NF_NOERR) STATUS=NF_INQ_VARID(NCID,"BOUNDS_DEPTH",VARID)
      IF (STATUS.NE.NF_NOERR) CALL HANDLE_ERR(id,STATUS)

      STATUS=NF_GET_VAR_REAL(NCID,VARID,BOUNDS_DEPTH)
      IF (STATUS.NE.NF_NOERR) CALL HANDLE_ERR(id,STATUS)

      STATUS=NF_INQ_VARDIMID(NCID,VARID,VARDIMIDS)
      IF (STATUS.NE.NF_NOERR) CALL HANDLE_ERR(id,STATUS)

      STATUS=NF_INQ_DIMLEN(NCID,VARDIMIDS(1),KMT)
      IF (STATUS.NE.NF_NOERR) CALL HANDLE_ERR(id,STATUS)

      STATUS=NF_CLOSE(NCID)
      IF (STATUS.NE.NF_NOERR) CALL HANDLE_ERR(id,STATUS)

      END

C******************************************************************
      SUBROUTINE HANDLE_ERR (id,STATUS)
      INTEGER*4 id
      INTEGER STATUS

      INCLUDE 'netcdf.inc'

      IF (STATUS.NE.NF_NOERR) THEN
         WRITE(6,*) NF_STRERROR(STATUS)
         CALL ef_bail_out(id,"Error in READ_GRIDFILE subroutine!!!")
      ENDIF

      END

C******************************************************************
      REAL*4 FUNCTION LIMIT_LON (XPOS,CM)
      REAL*4 XPOS,CM

C Limits longitude around a central meridian
C between CM-180. and CM+180.

      LIMIT_LON=XPOS

      DO WHILE (LIMIT_LON.GT.(CM+180.))
        LIMIT_LON=LIMIT_LON-360.
      END DO
      DO WHILE (LIMIT_LON.LE.(CM-180.))
        LIMIT_LON=LIMIT_LON+360.
      END DO

      END

C******************************************************************
      REAL*4 FUNCTION FABS (X)
      REAL*4 X

      IF (X.GT.0.) THEN
         FABS=X
      ELSE
         FABS=-X
      END IF

      END

C******************************************************************
      REAL*4 FUNCTION CLOSEST_LON (X1,X2)
      REAL*4 X1,X2
 
C Closest longitude for x2 relative to x1

      REAL*4 FABS

      CLOSEST_LON=X2

      IF (FABS(CLOSEST_LON-X1).GT.FABS(CLOSEST_LON+360.-X1)) THEN
      	CLOSEST_LON=CLOSEST_LON+360.
      END IF
      IF (FABS(CLOSEST_LON-X1).GT.FABS(CLOSEST_LON-360.-X1)) THEN
      	CLOSEST_LON=CLOSEST_LON-360.
      END IF

      END
 
C******************************************************************
      SUBROUTINE SXY_FIND_CELL_XY (LON_STATION,LAT_STATION,
     .           INDEX_I,INDEX_J,
     .           LON,BOUNDS_LON,BOUNDS_LAT)

      REAL*4 LON_STATION,LAT_STATION
      INTEGER*4 INDEX_I,INDEX_J
      REAL*4 LON(*),BOUNDS_LON(*),BOUNDS_LAT(*)

      INCLUDE 'fast_sample_xy_common'

C Functions 
      REAL*4 LIMIT_LON,CLOSEST_LON
 
      REAL*4 LIMITED_LON_STATION,LON_C
      REAL*4 LON_LL,LON_UL,LON_LR,LON_UR
      REAL*4 LAT_LL,LAT_UL,LAT_LR,LAT_UR
      REAL*4 XX(4),YY(4)
      INTEGER*4 I
      INTEGER*4 INOUT

      LIMITED_LON_STATION=LIMIT_LON(LON_STATION,0.)

C Initialisation
      INDEX_I=-999
      INDEX_J=-999

      DO I=1,IMT*JMT

        LON_C=LIMIT_LON(LON(I),0.)
        LON_LL=LIMIT_LON(BOUNDS_LON(I),0.)
        LON_UL=LIMIT_LON(BOUNDS_LON(I+IMT*JMT*1),0.)
        LON_LR=LIMIT_LON(BOUNDS_LON(I+IMT*JMT*2),0.)
        LON_UR=LIMIT_LON(BOUNDS_LON(I+IMT*JMT*3),0.)
        LAT_LL=BOUNDS_LAT(I)
        LAT_UL=BOUNDS_LAT(I+IMT*JMT*1)
        LAT_LR=BOUNDS_LAT(I+IMT*JMT*2)
        LAT_UR=BOUNDS_LAT(I+IMT*JMT*3)

C Limit cell center longitude (minimize rel. to lon station)
        LON_C=CLOSEST_LON(LIMITED_LON_STATION,LON_C)

C Limit longitude excursion of cell corners (minimize rel. to C)
C Decsribe polygon anticlockwise: LL,LR,UR,UL
	XX(1)=CLOSEST_LON(LON_C,LON_LL)
	XX(2)=CLOSEST_LON(LON_C,LON_LR)
	XX(3)=CLOSEST_LON(LON_C,LON_UR)
	XX(4)=CLOSEST_LON(LON_C,LON_UL)
	YY(1)=LAT_LL
	YY(2)=LAT_LR
	YY(3)=LAT_UR
	YY(4)=LAT_UL

	CALL PNPOLY(LIMITED_LON_STATION,LAT_STATION,XX,YY,4,INOUT) 
C If inside or on edges
	IF (INOUT.GE.0) THEN
           INDEX_J=INT((I-1)/IMT)
           INDEX_I=(I-1)-INDEX_J*IMT
C Fortran notations
           INDEX_J=INDEX_J+1
           INDEX_I=INDEX_I+1
	   GO TO 10
	END IF

      END DO

   10 CONTINUE

      END 

C******************************************************************
