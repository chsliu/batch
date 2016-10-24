import ConfigParser

cfgfile = 'example.cfg'

def getint(section,item):
    config = ConfigParser.RawConfigParser()
    config.read(cfgfile)
    try:
        return config.getint(section, item)
    except:
        return 0


def set(section,item,value):
    config = ConfigParser.RawConfigParser()
    config.read(cfgfile)
    try:
        config.add_section(section)
    except:
        pass
    config.set(section, item, value)

    configfile = open(cfgfile, 'wb')
    config.write(configfile)


def createconfig():
    config = ConfigParser.RawConfigParser()

    config.add_section('Record')
    config.set('Record', 'rebootcount', '0')

    # Writing our configuration file to 'example.cfg'
    configfile = open('example.cfg', 'wb')
    config.write(configfile)


def readconfig():
    config = ConfigParser.RawConfigParser()
    config.read('example.cfg')

    # getfloat() raises an exception if the value is not a float
    # getint() and getboolean() also do this for their respective types
    float = config.getfloat('Section1', 'float')
    int = config.getint('Section1', 'int')
    print float + int

    # Notice that the next output does not interpolate '%(bar)s' or '%(baz)s'.
    # This is because we are using a RawConfigParser().
    if config.getboolean('Section1', 'bool'):
        print config.get('Section1', 'foo')


def main():
    createconfig()


if __name__ == "__main__":
    main()


