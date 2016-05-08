#!/usr/bin/python3

from lxml import etree
from lxml import html

import sys
import requests

DL_LINK_TEMPLATE = "https://www.factorio.com/get-download/%s/headless/linux64"

if __name__ == "__main__":
    p = requests.get(sys.argv[1])
    tree = html.fromstring(p.content)
    version = tree.xpath("//html/body/div[2]/div[1]/div[1]/h3/text()")
    print(DL_LINK_TEMPLATE % (version[0].split()[0]))
