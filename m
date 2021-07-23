Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3B52D3D3ADF
	for <lists+linux-integrity@lfdr.de>; Fri, 23 Jul 2021 15:07:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235049AbhGWM0u (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 23 Jul 2021 08:26:50 -0400
Received: from out30-43.freemail.mail.aliyun.com ([115.124.30.43]:48358 "EHLO
        out30-43.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234998AbhGWM0u (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 23 Jul 2021 08:26:50 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R251e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04420;MF=tianjia.zhang@linux.alibaba.com;NM=1;PH=DS;RN=7;SR=0;TI=SMTPD_---0Ugj-SkL_1627045641;
Received: from B-455UMD6M-2027.local(mailfrom:tianjia.zhang@linux.alibaba.com fp:SMTPD_---0Ugj-SkL_1627045641)
          by smtp.aliyun-inc.com(127.0.0.1);
          Fri, 23 Jul 2021 21:07:22 +0800
Subject: Re: [PATCH ima-evm-utils v2] ima-evm-utils: Fix incorrect algorithm
 name in hash_info.gen
To:     Petr Vorel <pvorel@suse.cz>, Mimi Zohar <zohar@linux.ibm.com>
Cc:     Vitaly Chikunov <vt@altlinux.org>,
        Stefan Berger <stefanb@linux.ibm.com>,
        linux-integrity@vger.kernel.org,
        Jia Zhang <zhang.jia@linux.alibaba.com>,
        "YiLin . Li" <YiLin.Li@linux.alibaba.com>
References: <20210723064108.14681-1-tianjia.zhang@linux.alibaba.com>
 <4b3c3c5e26e3f64bd3c0cea5eca6b7e515f58627.camel@linux.ibm.com>
 <YPqvqoyM0lpiH4R5@pevik>
From:   Tianjia Zhang <tianjia.zhang@linux.alibaba.com>
Message-ID: <d6ba47d1-595d-3deb-765e-71e31c332d0a@linux.alibaba.com>
Date:   Fri, 23 Jul 2021 21:07:21 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <YPqvqoyM0lpiH4R5@pevik>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Hi Mimi, Petr,

On 7/23/21 8:01 PM, Petr Vorel wrote:
> Hi Tianjia, Mimi,
> 
>> Hi Tianjia,
> 
>> On Fri, 2021-07-23 at 14:41 +0800, Tianjia Zhang wrote:
>>> There is no such an algorithm name as sm3-256. This is an ambiguity
>>> caused by the definition of the macro HASH_ALGO_SM3_256. The sed
>>> command is only a special case of sm3, so sm3 is used to replace
>>> the sm3-256 algorithm name.
> 
>>> Signed-off-by: Tianjia Zhang <tianjia.zhang@linux.alibaba.com>
>>> Reviewed-by: Petr Vorel <pvorel@suse.cz>
>>> ---
>>>   src/.gitignore    | 1 +
>>>   src/hash_info.gen | 7 ++++---
>>>   2 files changed, 5 insertions(+), 3 deletions(-)
> 
>>> diff --git a/src/.gitignore b/src/.gitignore
>>> index 38e8e3c..69d2988 100644
>>> --- a/src/.gitignore
>>> +++ b/src/.gitignore
>>> @@ -1 +1,2 @@
>>>   hash_info.h
>>> +tmp_hash_info.h
>>> diff --git a/src/hash_info.gen b/src/hash_info.gen
>>> index 5f7a97f..f52bb4d 100755
>>> --- a/src/hash_info.gen
>>> +++ b/src/hash_info.gen
>>> @@ -84,9 +84,10 @@ echo "};"
>>>   echo "const char *const hash_algo_name[HASH_ALGO__LAST] = {"
>>>   sed -n 's/HASH_ALGO_\(.*\),/\1 \L\1\E/p' $HASH_INFO | \
>>>     while read a b; do
>>> -    # Normalize text hash name: if it contains underscore between
>>> -    # digits replace it with a dash, other underscores are removed.
>>> -    b=$(echo "$b" | sed "s/\([0-9]\)_\([0-9]\)/\1-\2/g;s/_//g")
>>> +    # Normalize text hash name: sm3 algorithm name is different from
>>> +    # the macro definition, which is also the only special case, and
>>> +    # underscores are removed.
> 
>> Thank you for updating the comment.  Do you mind if I tweak it a bit:
> 
>> ^which is also the only special case of an underscore between digits.
>> Remove all other underscores.
> +1
> 

I'm glad you can tweak it, I'm sorry I didn't express it clarity.

Cheers,
Tianjia

> Kind regards,
> Petr
> 
>> Mimi
> 
>>> +    b=$(echo "$b" | sed "s/sm3_256/sm3/g;s/_//g")
>>>       printf '\t%-26s = "%s",\n' "[HASH_ALGO_$a]" "$b"
>>>     done
>>>   echo "};"
> 
