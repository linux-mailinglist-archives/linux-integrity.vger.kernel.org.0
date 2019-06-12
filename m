Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3639742C5D
	for <lists+linux-integrity@lfdr.de>; Wed, 12 Jun 2019 18:33:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2408897AbfFLQdD (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 12 Jun 2019 12:33:03 -0400
Received: from lhrrgout.huawei.com ([185.176.76.210]:33004 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2408886AbfFLQdD (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 12 Jun 2019 12:33:03 -0400
Received: from LHREML712-CAH.china.huawei.com (unknown [172.18.7.106])
        by Forcepoint Email with ESMTP id F20C6200662B4E236A65;
        Wed, 12 Jun 2019 17:33:00 +0100 (IST)
Received: from [10.220.96.108] (10.220.96.108) by smtpsuk.huawei.com
 (10.201.108.35) with Microsoft SMTP Server (TLS) id 14.3.408.0; Wed, 12 Jun
 2019 17:32:52 +0100
Subject: Re: [PATCH v3 0/2] ima/evm fixes for v5.2
To:     Janne Karhunen <janne.karhunen@gmail.com>
CC:     Mimi Zohar <zohar@linux.ibm.com>, <dmitry.kasatkin@huawei.com>,
        <mjg59@google.com>, <linux-integrity@vger.kernel.org>,
        <linux-security-module@vger.kernel.org>,
        <silviu.vlasceanu@huawei.com>
References: <20190606112620.26488-1-roberto.sassu@huawei.com>
 <CAE=NcraYOw9B3RFu3_DbJs9nPT87AtQEptC7zF4kAu4FP8YhxA@mail.gmail.com>
 <d9efe3c7-20dd-bbb0-40d8-40f69cba5b88@huawei.com>
 <CAE=NcraHqzST=SZNcrSgpv5EqfyUfpCCb7iQ0Oh6uohL3yiCdw@mail.gmail.com>
From:   Roberto Sassu <roberto.sassu@huawei.com>
Message-ID: <c13c6b4f-1302-35fb-f077-00b7f84fea08@huawei.com>
Date:   Wed, 12 Jun 2019 18:33:01 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.0
MIME-Version: 1.0
In-Reply-To: <CAE=NcraHqzST=SZNcrSgpv5EqfyUfpCCb7iQ0Oh6uohL3yiCdw@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.220.96.108]
X-CFilter-Loop: Reflected
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On 6/12/2019 3:38 PM, Janne Karhunen wrote:
> On Wed, Jun 12, 2019 at 4:11 PM Roberto Sassu <roberto.sassu@huawei.com> wrote:
> 
>>> - after initialization
>>>     - deny reading|writing anything without security.ima
>>>     - deny reading|writing anything invalid
>>>     - allow everything else
>>>
>>> The logic is pretty handy as it even creates additional layer of
>>> security around the early initialization files as they become
>>> unreadable after use.
>>
>> What if they should be legitimately used after the HMAC key is unsealed
>> and before switching to the persistent root file system?
> 
> Any examples? Log files and such are mostly 'one way' and should
> probably be whitelisted in the policy?

I checked better when the random key would be used to verify files
created during the boot. If we consider rootfs only, basically it would
be used for dracut-state.sh.

Before I was using a rule to measure digest lists in tmpfs. I had many
errors due to the fact that appraisal denied access to files in /run.
The default policy does not appraise files in tmpfs, and also for digest
lists it is not necessary (now I use: measure/appraise fsname=rootfs).


>>> Now, if we initialize the system with a random key like in your patch,
>>> this logic is to change quite drastically? It sounds to me the
>>> userland may actually break, all the userland initialization files in
>>> the existing ima configurations that do not use digsigs would become
>>> unreadable given that the random key is put in? Remember, those files
>>> can be protected via other means (most commonly signed ramdisk).
>>
>> No, the first patch is about adding the ability to verify files created
>> during each boot. For any other file, EVM returns INTEGRITY_UNKNOWN as
>> before. The second patch changes the behavior, as INTEGRITY_UNKNOWN is
>> considered as an error for the enforce-evm appraisal mode. The second
>> patch aims at making the system more secure, as no file would be
>> accessible unless it is verified.
>>
>> It is true that configurations without digsigs won't work anymore but
>> the alternative is accepting any file until the HMAC key is unsealed.
> 
> That's a pretty big change for the userland IMHO. Quite a few
> configurations out there will break, including mine I believe, so I
> hope there is a solid reason asking people to change their stuff. I'm
> fine holding off all writing until it is safe to do so for now..

The goal of appraisal is to allow access only to files with a valid
signature or HMAC. With the current behavior, that cannot be guaranteed.

Unfortunately, dracut-state.sh is created very early. It could be
possible to unseal the key before, but this probably means modifying
systemd.

Roberto

-- 
HUAWEI TECHNOLOGIES Duesseldorf GmbH, HRB 56063
Managing Director: Bo PENG, Jian LI, Yanli SHI
