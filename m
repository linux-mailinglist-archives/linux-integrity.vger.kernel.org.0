Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8217434AEB
	for <lists+linux-integrity@lfdr.de>; Tue,  4 Jun 2019 16:49:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727559AbfFDOt3 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 4 Jun 2019 10:49:29 -0400
Received: from lhrrgout.huawei.com ([185.176.76.210]:32984 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727287AbfFDOt3 (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 4 Jun 2019 10:49:29 -0400
Received: from LHREML711-CAH.china.huawei.com (unknown [172.18.7.108])
        by Forcepoint Email with ESMTP id 7C9ACE02319B34BFA501;
        Tue,  4 Jun 2019 15:49:28 +0100 (IST)
Received: from [10.220.96.108] (10.220.96.108) by smtpsuk.huawei.com
 (10.201.108.34) with Microsoft SMTP Server (TLS) id 14.3.408.0; Tue, 4 Jun
 2019 15:49:25 +0100
Subject: Re: [PATCH V3] IMA: Allow profiles to define the desired IMA template
To:     Mimi Zohar <zohar@linux.ibm.com>,
        Matthew Garrett <matthewgarrett@google.com>,
        <linux-integrity@vger.kernel.org>
CC:     <zohar@linux.vnet.ibm.com>, <prsriva02@gmail.com>,
        <bauerman@linux.ibm.com>, Matthew Garrett <mjg59@google.com>
References: <20190603201322.7443-1-matthewgarrett@google.com>
 <1559613113.3956.9.camel@linux.ibm.com>
 <18481910-ea3b-3ca7-ded2-46b094bbe959@huawei.com>
 <1559658772.4076.3.camel@linux.ibm.com>
 <3b452fea-f8e6-ebd3-824d-f7b8c5ceae58@huawei.com>
 <1559659668.4076.10.camel@linux.ibm.com>
From:   Roberto Sassu <roberto.sassu@huawei.com>
Message-ID: <146a2d77-db9e-15ad-9bb5-b8ff45f34613@huawei.com>
Date:   Tue, 4 Jun 2019 16:49:34 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.0
MIME-Version: 1.0
In-Reply-To: <1559659668.4076.10.camel@linux.ibm.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.220.96.108]
X-CFilter-Loop: Reflected
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On 6/4/2019 4:47 PM, Mimi Zohar wrote:
> On Tue, 2019-06-04 at 16:40 +0200, Roberto Sassu wrote:
>> On 6/4/2019 4:32 PM, Mimi Zohar wrote:
>>> On Tue, 2019-06-04 at 16:03 +0200, Roberto Sassu wrote:
>>>> On 6/4/2019 3:51 AM, Mimi Zohar wrote:
>>>>> On Mon, 2019-06-03 at 13:13 -0700, Matthew Garrett wrote:
>>>>>> Admins may wish to log different measurements using different IMA
>>>>>> templates. Add support for overriding the default template on a per-rule
>>>>>> basis.
>>>>>>
>>>>>> Signed-off-by: Matthew Garrett <mjg59@google.com>
>>>>>> ---
>>>>>>
>>>>>> Updated based on review feedback, verified that I can generate an event
>>>>>> log that contains multiple different templates.
>>>>>>
>>>>>>     Documentation/ABI/testing/ima_policy  |  6 ++++--
>>>>>>     security/integrity/ima/ima.h          | 13 +++++++++----
>>>>>>     security/integrity/ima/ima_api.c      | 24 ++++++++++++++++-------
>>>>>>     security/integrity/ima/ima_appraise.c |  2 +-
>>>>>>     security/integrity/ima/ima_init.c     |  2 +-
>>>>>>     security/integrity/ima/ima_main.c     |  9 +++++----
>>>>>>     security/integrity/ima/ima_policy.c   | 28 +++++++++++++++++++++++++--
>>>>>>     security/integrity/ima/ima_template.c | 10 ++++++++--
>>>>>>     8 files changed, 71 insertions(+), 23 deletions(-)
>>>>>>
>>>>>> diff --git a/Documentation/ABI/testing/ima_policy b/Documentation/ABI/testing/ima_policy
>>>>>> index 74c6702de74e..4ded0668a22d 100644
>>>>>> --- a/Documentation/ABI/testing/ima_policy
>>>>>> +++ b/Documentation/ABI/testing/ima_policy
>>>>>> @@ -24,8 +24,7 @@ Description:
>>>>>>     				[euid=] [fowner=] [fsname=]]
>>>>>>     			lsm:	[[subj_user=] [subj_role=] [subj_type=]
>>>>>>     				 [obj_user=] [obj_role=] [obj_type=]]
>>>>>> -			option:	[[appraise_type=]] [permit_directio]
>>>>>> -
>>>>>> +			option:	[[appraise_type=]] [template=] [permit_directio]
>>>>>>     		base: 	func:= [BPRM_CHECK][MMAP_CHECK][CREDS_CHECK][FILE_CHECK][MODULE_CHECK]
>>>>>>     				[FIRMWARE_CHECK]
>>>>>>     				[KEXEC_KERNEL_CHECK] [KEXEC_INITRAMFS_CHECK]
>>>>>> @@ -38,6 +37,9 @@ Description:
>>>>>>     			fowner:= decimal value
>>>>>>     		lsm:  	are LSM specific
>>>>>>     		option:	appraise_type:= [imasig]
>>>>>> +			template:= name or format of a defined IMA template
>>>>>> +			type (eg,ima-ng or d-ng|n-ng). Only valid when action
>>>>>> +			is "measure".
>>>>>
>>>>> This patch only supports specifying the template name, not the
>>>>> template format description.  Please remove "d-ng|n-ng".
>>>>
>>>> The patch is correct. lookup_template_desc() also considers the format.
>>>
>>> Specifying the template format works if it is defined in
>>> builtin_templates[], but seems to fail if it isn't.
>>
>> Yes, the original patch set supports the definition of new templates.
>> That part is not included in this patch.
> 
> There are three patch sets waiting for this new feature.  For now,
> let's remove the reference to the template definition in this patch.
>   The missing support could be added as a separate patch.
> 
> Roberto, are you ok with that?

Yes, it is fine for me.

Roberto

-- 
HUAWEI TECHNOLOGIES Duesseldorf GmbH, HRB 56063
Managing Director: Bo PENG, Jian LI, Yanli SHI
