# $Id: Makefile,v 2.36 1997/05/20 20:44:37 davis Exp $
#
#	nmake Makefile for netcdf libsrc
#

!IF "$(CFG)" == ""
CFG=Release
!ENDIF 
!IF "$(CFG)" != "Debug" && "$(CFG)" != "Release"
!MESSAGE Invalid configuration "$(CFG)" specified.
!MESSAGE You can specify a configuration when running NMAKE
!MESSAGE by defining the macro CFG on the command line. For example:
!MESSAGE 
!MESSAGE NMAKE /f "msoft.mak" CFG="Debug"
!MESSAGE 
!MESSAGE Possible choices for configuration are:
!MESSAGE 
!MESSAGE "Release"
!MESSAGE "Debug"
!MESSAGE 
!ERROR An invalid configuration is specified.
!ENDIF 

!IF  "$(CFG)" == "Debug"
COPT=   /nologo /W3 /FD /MTd /Gm /Zi /Od /D "_DEBUG"
!ELSE 
# Release
COPT= /nologo /W3 /FD /MT          /O2
!ENDIF 
INCLUDES= /I..\libsrc
DEFINES= /D "NDEBUG" /D "DLL_NETCDF" /D "VISUAL_CPLUSPLUS"
EXPORT= /D "DLL_EXPORT" /D FCALLSC_QUALIFIER="__declspec(dllexport) __stdcall"
CFLAGS= $(COPT) $(INCLUDES) $(DEFINES) $(EXPORT)
FOR=df
FFLAGS= /nologo /Zi /Od

PATH = ..\ncdump;..\libsrc;$(PATH)

DLL	= ..\libsrc\netcdf.dll
LIBRARY	= ..\libsrc\netcdf.lib

# kludgeomatic
CLIB_OBJS = \
	../libsrc/attr.obj \
	../libsrc/dim.obj \
	../libsrc/error.obj \
	../libsrc/libvers.obj \
	../libsrc/nc.obj \
	../libsrc/posixio.obj \
	../libsrc/ncx.obj \
	../libsrc/putget.obj \
	../libsrc/string.obj \
	../libsrc/v1hpg.obj \
	../libsrc/v2i.obj \
	../libsrc/var.obj

LIB_CSRCS	= \
		  fort-attio.c	\
		  fort-control.c	\
		  fort-dim.c	\
		  fort-genatt.c	\
		  fort-geninq.c	\
		  fort-genvar.c	\
		  fort-lib.c	\
		  fort-misc.c	\
		  fort-v2compat.c	\
		  fort-vario.c	\
		  fort-var1io.c	\
		  fort-varaio.c	\
		  fort-varmio.c	\
		  fort-varsio.c

LIB_OBJS = $(LIB_CSRCS:.c=.obj)


all: $(DLL)

check: test

install:

LINK32=link.exe
LINK32_FLAGS= /nologo /dll /incremental:no

$(DLL) $(LIBRARY): $(LIB_OBJS)
    $(LINK32) $(LINK32_FLAGS) /out:$(DLL) /implib:$(LIBRARY) \
	$(CLIB_OBJS) $(LIB_OBJS)

test:	ftest.exe
	.\ftest.exe


ftest.exe: ftest.obj $(LIBRARY)
	$(FOR) $(FFLAGS) ftest.obj /link $(LIBRARY) /out:$@

ftest.obj: ftest.for
	$(FOR) /c $(FFLAGS) $*.for
ftest.for: ftest.F
	$(CC) /nologo /EP /C $(INCLUDES) $(DEFINES) $? > $@

.c.i:
	$(CC) $(CFLAGS) /E $< >$@ || rm $@

dump:
	ncdump -h test.nc


clean:
	-@rm *.obj *.for ftest.exe test.nc copy.nc > NUL 2>&1
	-@rm *.pdb *.ilk *.idb *.rsp > NUL 2>&1

distclean: clean

	
	
# depends
fort-attio.obj: ..\libsrc\netcdf.h
fort-attio.obj: cfortran.h
fort-attio.obj: fort-attio.c
fort-attio.obj: ncfortran.h
fort-control.obj: ..\libsrc\netcdf.h
fort-control.obj: cfortran.h
fort-control.obj: fort-control.c
fort-control.obj: ncfortran.h
fort-dim.obj: ..\libsrc\netcdf.h
fort-dim.obj: cfortran.h
fort-dim.obj: fort-dim.c
fort-dim.obj: ncfortran.h
fort-genatt.obj: ..\libsrc\netcdf.h
fort-genatt.obj: cfortran.h
fort-genatt.obj: fort-genatt.c
fort-genatt.obj: ncfortran.h
fort-geninq.obj: ..\libsrc\netcdf.h
fort-geninq.obj: cfortran.h
fort-geninq.obj: fort-geninq.c
fort-geninq.obj: ncfortran.h
fort-genvar.obj: ..\libsrc\netcdf.h
fort-genvar.obj: cfortran.h
fort-genvar.obj: fort-genvar.c
fort-genvar.obj: fort-lib.h
fort-genvar.obj: ncfortran.h
fort-lib.obj: ..\libsrc\netcdf.h
fort-lib.obj: fort-lib.c
fort-lib.obj: fort-lib.h
fort-misc.obj: cfortran.h
fort-misc.obj: fort-misc.c
fort-misc.obj: ncfortran.h
fort-v2compat.obj: ..\libsrc\ncconfig.h
fort-v2compat.obj: ..\libsrc\netcdf.h
fort-v2compat.obj: cfortran.h
fort-v2compat.obj: fort-v2compat.c
fort-v2compat.obj: ncfortran.h
fort-var1io.obj: ..\libsrc\netcdf.h
fort-var1io.obj: cfortran.h
fort-var1io.obj: fort-lib.h
fort-var1io.obj: fort-var1io.c
fort-var1io.obj: ncfortran.h
fort-varaio.obj: ..\libsrc\netcdf.h
fort-varaio.obj: cfortran.h
fort-varaio.obj: fort-lib.h
fort-varaio.obj: fort-varaio.c
fort-varaio.obj: ncfortran.h
fort-varmio.obj: ..\libsrc\netcdf.h
fort-varmio.obj: cfortran.h
fort-varmio.obj: fort-lib.h
fort-varmio.obj: fort-varmio.c
fort-varmio.obj: ncfortran.h
fort-varsio.obj: ..\libsrc\netcdf.h
fort-varsio.obj: cfortran.h
fort-varsio.obj: fort-lib.h
fort-varsio.obj: fort-varsio.c
fort-varsio.obj: ncfortran.h
misc.obj: ..\libsrc\netcdf.h
misc.obj: cfortran.h
misc.obj: misc.c
misc.obj: ncfortran.h
