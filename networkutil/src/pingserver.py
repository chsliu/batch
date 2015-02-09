

def sendemail(server, errmsg, sender='chsliu@gmail.com', receivers=['chsliu@gmail.com']):
##    sender = 'chsliu@gmail.com'
##    receivers = ['chsliu@gmail.com']

##To: Sita Liu <chsliu@gmail.com>

    message = """\
From: %s
Subject: About %s

%s
""" % (sender, server,errmsg)

    import smtplib
    try:
       smtpObj = smtplib.SMTP('msa.hinet.net')
       smtpObj.sendmail(sender, receivers, message)
       print "Successfully sent email"
    except SMTPException:
       print "Error: unable to send email"


def pingserver(server,timeout=2):
    import ping, socket
    try:
        delay = ping.do_one(server, timeout)
        if delay  !=  None:
            return None
        error = "Ping failed. (timeout within %ssec.)" % timeout
    except socket.error, e:
        error = "Ping Error:" + str(e)
    print error
    return error


def usage(prog):
    print "%s servername" % prog


def main():
    import sys
    args = sys.argv[1:]
    if len(args) == 0:
        usage(sys.argv[0])

    for arg in args:
        server = arg#'goodview.com.tw'
        errmsg =  pingserver(server)
        if errmsg:
            sendemail(server, errmsg)
        else:
            print server, 'is alive.'


if __name__ == "__main__":
    main()

