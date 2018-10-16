#!/usr/bin/env python
#coding=utf-8

import os
from aliyunsdkcore import client
from aliyunsdkcbn.request.v20170912 import CreateCenRequest
from aliyunsdkcore.profile import region_provider
#region_provider.modify_point('cbn', '<regionId>', 'cbn.<regionId>.aliyuncs.com')

# Init
clt = client.AcsClient(os.environ['ALICLOUD_ACCESS_KEY'], os.environ['ALICLOUD_SECRET_KEY'], os.environ['ALICLOUD_REGION'])

# Setting Params
request = CreateCenRequest.CreateCenRequest()
request.set_accept_format('json')


# Sending Request
response = clt.do_action(request)

print response