      SUBROUTINE DIPOLE(BUF,IBUF,XX,YY,ZZ,HC1,HC2,HC3)
C
C DIPOLE COMPUTES THE MAGNETIC INTENSITY AT THE POINT (XX,YY,ZZ) DUE
C TO A MAGNETIC DIPOLE MOMENT DEFINED ON AN MDIPOLE CARD STORED IN BUF.
C THE FORMULATION COMES FROM DARRELL NIXONS REPORT 27-23 MARCH 1972
C
      REAL MX,MY,MZ,MIN,MAX,MXA,MYB,MZC
      DIMENSION  BUF(50),IBUF(50)
      DATA FPI/12.566371/
C
      HC1=0.
      HC2=0.
      HC3=0.
C
C ICID IS 0 FOR NOW AND WILL NOT BE USED. COORDS. AND MOMENT
C ARE ASSUMED TO BE IN BASIC COORDS
C
      ICID=IBUF(1)
C
C COORDS OF POINT DIPOLE
C
      CX=BUF(2)
      CY=BUF(3)
      CZ=BUF(4)
      MX=BUF(5)
      MY=BUF(6)
      MZ=BUF(7)
      MIN=BUF(8)
      MAX=BUF(9)
C
C H WILL BE COMPUTED ONLY IF DISTANCE FROM (CX,CY,CZ) TO (XX,YY,ZZ) IS
C BETWEEN MIN AND MAX- IF MAX IS 0, COMPUTE FOR ALL POINTS GREATER THAN
C MIN
C
      RMR1=SQRT((XX-CX)**2+(YY-CY)**2+(ZZ-CZ)**2)
      IF(MIN.LE.1.E-6)GO TO 5
      IF(RMR1.LT.MIN)GO TO 20
    5 IF(MAX.LE.1.E-6)GO TO 10
      IF(RMR1.GT.MAX)GO TO 20
C
   10 MXA=3.*MX*(XX-CX)
      MYB=3.*MY*(YY-CY)
      MZC=3.*MZ*(ZZ-CZ)
C
      R3=RMR1**3
      R5=R3*RMR1**2
      XNUM=(MXA+MYB+MZC)/R5
C
      HC1=-MX/R3+XNUM*(XX-CX)
      HC1=HC1/FPI
C
      HC2=-MY/R3+XNUM*(YY-CY)
      HC2=HC2/FPI
C
      HC3=-MZ/R3+XNUM*(ZZ-CZ)
      HC3=HC3/FPI
C
   20 RETURN
      END
