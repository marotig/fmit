

# Audio Capture System: acs_qt, acs_alsa, acs_jack, acs_portaudio, acs_oss
CONFIG += acs_qt


# TODO
DEFINES += "PACKAGE_NAME=\\\"FMIT\\\""
DEFINES += "PACKAGE_VERSION=\\\"1.0.80\\\""
DEFINES += "PREFIX=\\\"/usr/local/\\\""


# ------------------------------------------------------------------------------
# (modify the following at your own risks !) -----------------------------------

message(CONFIG=$$CONFIG)

# Manage Architectures
win32:message(For Windows)
unix:message(For Linux)
msvc:message(Using MSVC compiler)
gcc:message(Using GCC compiler)
contains(QT_ARCH, i386):message(For 32bits)
contains(QT_ARCH, x86_64):message(For 64bits)

# ------------------------------------------------------------------------------
# Manage options for Audio Capture System --------------------------------------

CONFIG(acs_qt) {
    message(Audio Capture System: Request Qt support)
    DEFINES += CAPTURE_QT
    QT += multimedia
    SOURCES += src/CaptureThreadImplQt.cpp
}

CONFIG(acs_alsa) {
    message(Audio Capture System: Request ALSA support)
    DEFINES += CAPTURE_ALSA
    SOURCES += src/CaptureThreadImplALSA.cpp
    LIBS += -lasound
}

CONFIG(acs_jack) {
    message(Audio Capture System: Request JACK support)
    SOURCES += src/CaptureThreadImplJACK.cpp
    DEFINES += CAPTURE_JACK
    LIBS += -ljack
}

CONFIG(acs_portaudio) {
    message(Audio Capture System: Request PortAudio support)
    DEFINES += CAPTURE_PORTAUDIO
    SOURCES += src/CaptureThreadImplPortAudio.cpp
    LIBS += -lportaudio
}

CONFIG(acs_oss) {
    message(Audio Capture System: Request OSS support)
    DEFINES += CAPTURE_OSS
    SOURCES += src/CaptureThreadImplOSS.cpp
    LIBS += -lasound
}

INCLUDEPATH += "C:\Users\Norwin\Documents\GitHub\lib\fftw-3.3.4-dll64"


# FFTW -------------------------------------------------------------------------
win32 {
    isEmpty(FFT_LIBDIR) {
        contains(QMAKE_TARGET.arch, x86_64) {
            FFT_LIBDIR = "$$_PRO_FILE_PWD_/../lib/fftw-3.3.4-dll64"
        } else {
            FFT_LIBDIR = "$$_PRO_FILE_PWD_/../lib/fftw-3.3.4-dll32"
        }
    }
    message(FFT_LIBDIR=$$FFT_LIBDIR)
    INCLUDEPATH += $$FFT_LIBDIR
    LIBS += -L$$FFT_LIBDIR
    msvc: LIBS += $$FFT_LIBDIR/libfftw3-3.lib
    gcc: LIBS += -lfftw3-3
}
unix {
    LIBS += -lfftw3
}

# Open GL ----------------------------------------------------------------------
win32 {
    isEmpty(GLUT_LIBDIR) {
        GLUT_LIBDIR = "$$_PRO_FILE_PWD_/../lib/freeglut-MSVC-3.0.0-1.mp/freeglut"
    }

    message(GLUT_LIBDIR=$$GLUT_LIBDIR)
    INCLUDEPATH += $$GLUT_LIBDIR/include

    contains(QMAKE_TARGET.arch, x86_64) {
        msvc: LIBS += $$GLUT_LIBDIR/lib/x64/freeglut.lib
    } else {
        msvc: LIBS += $$GLUT_LIBDIR/lib/freeglut.lib
    }
}
unix {
    LIBS += -lglut -lGLU -lGL
}


# Common configurations --------------------------------------------------------

QT += core gui opengl
greaterThan(QT_MAJOR_VERSION, 4): QT += widgets

INCLUDEPATH += libs

TARGET = fmit
TEMPLATE = app


SOURCES +=  src/main.cpp \
            src/CustomInstrumentTunerForm.cpp \
            src/AutoQSettings.cpp \
            src/CaptureThread.cpp \
            src/DummyMonoQuantizer.cpp \
            src/LatencyMonoQuantizer.cpp \
            src/MonoQuantizer.cpp \
            src/modules/View.cpp \
            src/modules/DialView.cpp \
            src/modules/GLErrorHistory.cpp \
            src/modules/GLFreqStruct.cpp \
            src/modules/GLFT.cpp \
            src/modules/GLGraph.cpp \
            src/modules/GLSample.cpp \
            src/modules/GLStatistics.cpp \
            src/modules/GLVolumeHistory.cpp \
            src/modules/MicrotonalView.cpp \
            libs/Music/Algorithm.cpp \
            libs/Music/Autocorrelation.cpp \
            libs/Music/CFFTW3.cpp \
            libs/Music/CombedFT.cpp \
            libs/Music/Convolution.cpp \
            libs/Music/CumulativeDiff.cpp \
            libs/Music/CumulativeDiffAlgo.cpp \
            libs/Music/Filter.cpp \
            libs/Music/FreqAnalysis.cpp \
            libs/Music/LPC.cpp \
            libs/Music/MultiCumulativeDiffAlgo.cpp \
            libs/Music/Music.cpp \
            libs/Music/Note.cpp \
            libs/Music/SPWindow.cpp \
            libs/Music/TimeAnalysis.cpp \
            libs/CppAddons/CAMath.cpp \
            libs/CppAddons/Random.cpp


HEADERS  += src/CustomInstrumentTunerForm.h \
            src/AutoQSettings.h \
            src/CaptureThread.h \
            src/DummyMonoQuantizer.h \
            src/LatencyMonoQuantizer.h \
            src/MonoQuantizer.h \
            src/modules/View.h \
            src/modules/DialView.h \
            src/modules/GLErrorHistory.h \
            src/modules/GLFreqStruct.h \
            src/modules/GLFT.h \
            src/modules/GLGraph.h \
            src/modules/GLSample.h \
            src/modules/GLStatistics.h \
            src/modules/GLVolumeHistory.h \
            src/modules/MicrotonalView.h \
            libs/Music/Algorithm.h \
            libs/Music/Autocorrelation.h \
            libs/Music/CFFTW3.h \
            libs/Music/CombedFT.h \
            libs/Music/Convolution.h \
            libs/Music/CumulativeDiff.h \
            libs/Music/CumulativeDiffAlgo.h \
            libs/Music/Filter.h \
            libs/Music/FreqAnalysis.h \
            libs/Music/LPC.h \
            libs/Music/MultiCumulativeDiffAlgo.h \
            libs/Music/Music.h \
            libs/Music/Note.h \
            libs/Music/SPWindow.h \
            libs/Music/TimeAnalysis.h \
            libs/CppAddons/CAMath.h \
            libs/CppAddons/Fit.h \
            libs/CppAddons/Observer.h \
            libs/CppAddons/Random.h \
            libs/CppAddons/Singleton.h \
            libs/CppAddons/StringAddons.h

FORMS    += ui/InstrumentTunerForm.ui \
            ui/ConfigForm.ui

RESOURCES += ui/fmit.qrc
