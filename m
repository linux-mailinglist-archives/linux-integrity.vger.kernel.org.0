Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1790A3CB2FA
	for <lists+linux-integrity@lfdr.de>; Fri, 16 Jul 2021 09:11:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231376AbhGPHOQ (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 16 Jul 2021 03:14:16 -0400
Received: from out30-130.freemail.mail.aliyun.com ([115.124.30.130]:44432 "EHLO
        out30-130.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229930AbhGPHOP (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 16 Jul 2021 03:14:15 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R561e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04423;MF=tianjia.zhang@linux.alibaba.com;NM=1;PH=DS;RN=7;SR=0;TI=SMTPD_---0UfxYA2k_1626419479;
Received: from B-455UMD6M-2027.local(mailfrom:tianjia.zhang@linux.alibaba.com fp:SMTPD_---0UfxYA2k_1626419479)
          by smtp.aliyun-inc.com(127.0.0.1);
          Fri, 16 Jul 2021 15:11:20 +0800
Subject: Re: [PATCH ima-evm-utils v4] ima-evm-utils: Support SM2 algorithm for
 sign and verify
To:     Mimi Zohar <zohar@linux.ibm.com>, Petr Vorel <pvorel@suse.cz>
Cc:     Stefan Berger <stefanb@linux.ibm.com>,
        Vitaly Chikunov <vt@altlinux.org>,
        linux-integrity@vger.kernel.org,
        Jia Zhang <zhang.jia@linux.alibaba.com>,
        "YiLin . Li" <YiLin.Li@linux.alibaba.com>
References: <20210714130152.25751-1-tianjia.zhang@linux.alibaba.com>
 <422b37b533ed6e24d783f323f7d4e22736f0e4bd.camel@linux.ibm.com>
 <YO/YFAEWN5VzYIsQ@pevik>
 <2af3724d-1fdd-1e98-1119-7ef86c2ee912@linux.alibaba.com>
 <5996b8f9deb4aba43f025844a7415f2069c1e7e2.camel@linux.ibm.com>
From:   Tianjia Zhang <tianjia.zhang@linux.alibaba.com>
Message-ID: <3f5f0a64-f135-01b4-645d-e3a77a4c502f@linux.alibaba.com>
Date:   Fri, 16 Jul 2021 15:11:18 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <5996b8f9deb4aba43f025844a7415f2069c1e7e2.camel@linux.ibm.com>
Content-Type: text/plain; charset=iso-8859-15; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org



On 7/15/21 9:01 PM, Mimi Zohar wrote:
> On Thu, 2021-07-15 at 20:24 +0800, Tianjia Zhang wrote:
>>
>> On 7/15/21 2:39 PM, Petr Vorel wrote:
>>> Hi Mimi, Tianjia,
>>>
>>>> Hi Tianjia,
>>>
>>>> On Wed, 2021-07-14 at 21:01 +0800, Tianjia Zhang wrote:
>>>
>>>>> index 5b07711..a0001b0 100644
>>>>> --- a/.travis.yml
>>>>> +++ b/.travis.yml
>>>>> @@ -93,4 +93,4 @@ before_install:
>>>>>    script:
>>>>>        - INSTALL="${DISTRO%%:*}"
>>>>>        - INSTALL="${INSTALL%%/*}"
>>>>> -    - $CONTAINER run $CONTAINER_ARGS -t ima-evm-utils /bin/sh -c "if
>>>>> [ \"$VARIANT\" ]; then ARCH=\"$ARCH\" ./ci/$INSTALL.$VARIANT.sh; fi
>>>>> && ARCH=\"$ARCH\" CC=\"$CC\" TSS=\"$TSS\" ./ci/$INSTALL.sh && if [ !
>>>>> \"$VARIANT\" ]; then which tpm_server || which swtpm ||
>>>>> ./tests/install-swtpm.sh; fi && CC=\"$CC\" VARIANT=\"$VARIANT\"
>>>>> ./build.sh"
>>>>> +    - $CONTAINER run $CONTAINER_ARGS -t ima-evm-utils /bin/sh -c "if
>>>>> [ \"$VARIANT\" ]; then ARCH=\"$ARCH\" ./ci/$INSTALL.$VARIANT.sh; fi
>>>>> && ARCH=\"$ARCH\" CC=\"$CC\" TSS=\"$TSS\" ./ci/$INSTALL.sh && if [ !
>>>>> \"$VARIANT\" ]; then which tpm_server || which swtpm ||
>>>>> ./tests/install-swtpm.sh; fi && ./tests/install-openssl3.sh &&
>>>>> CC=\"$CC\" VARIANT=\"$VARIANT\" ./build.sh"
>>>
>>>> With "install-openssl3.sh", installing openssl 3.0 is being done for
>>>> every distro matrix rule.  This needs to be limited to a specific
>>>> instance.  Petr, please correct if I'm wrong, I assume a new variable
>>>> needs to be defined, similar to "TSS".
>>> +1
>>>
>>>> A similar change would need to be made in ci.yml.
>>> +1
>>>
>>>>> new file mode 100755
>>>>> index 0000000..21adb6f
>>>>> --- /dev/null
>>>>> +++ b/tests/install-openssl3.sh
>>>>> @@ -0,0 +1,15 @@
>>>>> +#!/bin/sh
>>>>> +
>>>>> +set -ex
>>>>> +
>>>>> +# The latest version in July 2021
>>>>> +wget --no-check-certificate https://github.com/openssl/openssl/archive/refs/tags/openssl-3.0.0-beta1.tar.gz
>>>>> +tar --no-same-owner -xvzf openssl-3.0.0-beta1.tar.gz
>>>
>>>> Petr said,  "Although it appears there is no distro which would have
>>>> openssl 3.0 [1],
>>>> Debian actually have 3.0.0~~beta1-1 in experimental [2]. openSUSE has slightly
>>>> older version openssl-3.0.0-alpha16 [3]. I suppose we update soon to beta1 as
>>>> well.
>>>> Using distro packages would be probably faster to run in CI than install from git."
>>>> I guess, whether the openssl 3.0 source code is from the distro or from
>>>> openssl, it needs to be compiled from source.
>>>
>>>> Perhaps limiting compiling openssl 3.0 to those distros with the source
>>>> package is simpler than defining a new travis.yml variable, as
>>>> suggested above.  Petr?
>>> It'll be slower, but why not. It might be better not cover only Debian.
>>> But IMHO there should be at least some distros tested with regular openssl 1.1.x
>>> (or which particular version it have) which means some runs will be added to the
>>> matrix. But there should be a balance between test coverity and time required
>>> for tests to be run (we don't want to end up like u-boot [1] :)).
>>
>>> [1] https://github.com/u-boot/u-boot/runs/3073277277
>>>
>>
>> evmctl itself relies on openssl version 1.1.1 or lower. I guess, openssl
>> 3.0 needs to be compiled and install to a non-standard path, such as
>> /opt/openssl, otherwise it will affect the subsequent compilation of
>> evmctl in build.sh.
> 
> Compiling evmctl with the new version of openssl will eventually need
> to be done. but that isn't required for your patch.
> 
>> Of course, compile openssl 3.0 from source code.
>> must to limit the number of instances to avoid excessively increasing
>> the time-consuming in CI. Is that right?
> 
> It's more than just "time consuming".   There needs to be a balance
> between testing with the distro openssl version and testing with the
> new openssl version, without going overboard with the number of tests.
> 

Got it. Thanks.

Cheers,
Tianjia
