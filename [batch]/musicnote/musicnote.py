from winsound import Beep

single = 500
half = single/2
quarter = single/4
eighth = single/8

s = single
h = half
q = quarter
e = eighth

def freq(n):
    return 440 * 2 ** (n*1.0/12)

#C4
def Do(duration=single):
    Beep(int(freq(-9)), duration)
    return

#D4
def Re(duration=single):
    Beep(int(freq(-7)), duration)
    return

#E4
def Mi(duration=single):
    Beep(int(freq(-5)), duration)
    return

#F4
def Fa(duration=single):
    Beep(int(freq(-4)), duration)
    return

#G4
def Sol(duration=single):
    Beep(int(freq(-2)), duration)
    return

#A4
def La(duration=single):
    Beep(int(freq(0)), duration)
    return

#B4
def Si(duration=single):
    Beep(int(freq(2)), duration)
    return

