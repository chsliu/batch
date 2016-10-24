from pingserver import sendemail

def usage(prog):
    print "%s <server> <message> [sender] [receivers]" % prog


def main():
    import sys
    if len(sys.argv) <= 2:
        usage(sys.argv[0])
        return

    servername = sys.argv[1]

    from time import localtime, strftime
    import socket
    import getpass
##    message = strftime("%Y-%m-%d %H:%M:%S", localtime())
##    message += ', IP:' + socket.gethostbyname(socket.gethostname()) + ' '
##    message += '\n'
##    message += sys.argv[2]

    message = '''\
%s from %s(%s) by %s:
%s
''' % ( strftime("%Y-%m-%d %H:%M:%S", localtime()),
        socket.gethostname(),
        socket.gethostbyname(socket.gethostname()),
        getpass.getuser(),
        sys.argv[2])

    if len(sys.argv)>=4:
        sender = sys.argv[3]
    else:
        sender = 'chsliu@gmail.com'

    if len(sys.argv)>=5:
        receivers = sys.argv[4:]
    else:
        receivers = ['chsliu@gmail.com']

    sendemail(servername, message, sender, receivers)


if __name__ == "__main__":
    main()

