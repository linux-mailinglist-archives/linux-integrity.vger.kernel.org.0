Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 754853CF50B
	for <lists+linux-integrity@lfdr.de>; Tue, 20 Jul 2021 09:07:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232606AbhGTG07 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 20 Jul 2021 02:26:59 -0400
Received: from out30-45.freemail.mail.aliyun.com ([115.124.30.45]:36306 "EHLO
        out30-45.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S240156AbhGTG0N (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 20 Jul 2021 02:26:13 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R171e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04420;MF=tianjia.zhang@linux.alibaba.com;NM=1;PH=DS;RN=7;SR=0;TI=SMTPD_---0UgOhiuI_1626764809;
Received: from B-455UMD6M-2027.local(mailfrom:tianjia.zhang@linux.alibaba.com fp:SMTPD_---0UgOhiuI_1626764809)
          by smtp.aliyun-inc.com(127.0.0.1);
          Tue, 20 Jul 2021 15:06:50 +0800
Subject: Re: [PATCH ima-evm-utils v5] ima-evm-utils: Support SM2/3 algorithm
 for sign and verify
To:     Mimi Zohar <zohar@linux.ibm.com>, Petr Vorel <pvorel@suse.cz>
Cc:     Vitaly Chikunov <vt@altlinux.org>,
        Stefan Berger <stefanb@linux.ibm.com>,
        linux-integrity@vger.kernel.org,
        Jia Zhang <zhang.jia@linux.alibaba.com>,
        "YiLin . Li" <YiLin.Li@linux.alibaba.com>
References: <20210716092237.17153-1-tianjia.zhang@linux.alibaba.com>
 <f7c05b2618125cb0887ee0302c1197a8c8f49864.camel@linux.ibm.com>
 <7921ca60-8818-b641-3e28-6ffd957f8a1b@linux.alibaba.com>
 <YPQqhTPLTafjLCXP@pevik>
 <1aa1a53101d9eeb6c358bb65677a8b733c19e663.camel@linux.ibm.com>
From:   Tianjia Zhang <tianjia.zhang@linux.alibaba.com>
Message-ID: <fb2ca393-64e9-b709-456e-a3e28e9de0a1@linux.alibaba.com>
Date:   Tue, 20 Jul 2021 15:06:48 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <1aa1a53101d9eeb6c358bb65677a8b733c19e663.camel@linux.ibm.com>
Content-Type: text/plain; charset=iso-8859-15; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Hi Mimi, Petr,

On 7/19/21 8:51 PM, Mimi Zohar wrote:
> Hi -
> 
> On Sun, 2021-07-18 at 15:20 +0200, Petr Vorel wrote:
>>> On 7/17/21 12:39 AM, Mimi Zohar wrote:
>>>> On Fri, 2021-07-16 at 17:22 +0800, Tianjia Zhang wrote:
>>>>> diff --git a/.github/workflows/ci.yml b/.github/workflows/ci.yml
>>>>> index 088c041..17407ff 100644
>>>>> --- a/.github/workflows/ci.yml
>>>>> +++ b/.github/workflows/ci.yml
>>>>> @@ -17,6 +17,7 @@ jobs:
>>>>>                  ARCH: i386
>>>>>                  TSS: tpm2-tss
>>>>>                  VARIANT: i386
>>>>> +              OPENSSL3: true
>>>>>              # cross compilation builds
>>>>>              - container: "debian:stable"
>>>>> @@ -51,6 +52,7 @@ jobs:
>>>>>                env:
>>>>>                  CC: clang
>>>>>                  TSS: ibmtss
>>>>> +              OPENSSL3: true
>>
>>>> I haven't had a chance to look at the entire patch, but defining
>>>> OPENSSL3 kind of stood out.  Just as "CC" and "TSS" are generic, I'd
>>>> prefer something more generic here.   In the past there was a request
>>>> to support Libressl, which never materialized.
>>
>>
>>> I agree that it is appropriate to use a generic variable name. I am thinking
>>> of 'CRYPTOGRAPHY' or 'CRYPPTO_LIBRARY'. Are there any better suggestions?
>> How about COMPILE_OPENSSL? Because that's the current purpose.
> 
> Hm, wondering if it makes sense to generalize this further, including
> Vitaly's suggestion?
> 
> In this case, the generic name would be "SSL"  (e.g. "SSL=openssl").
> Prefixing a generic name with "COMPILE_[TSS|CC|SSL]=<tag|commit>" would
> indicate compiling the application from source.
> 

I will take this suggestion, thanks for your comment.

Cheers,
Tianjia
