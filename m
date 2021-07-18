Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2EFDD3CC73C
	for <lists+linux-integrity@lfdr.de>; Sun, 18 Jul 2021 04:22:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231409AbhGRCZm (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Sat, 17 Jul 2021 22:25:42 -0400
Received: from out30-54.freemail.mail.aliyun.com ([115.124.30.54]:38719 "EHLO
        out30-54.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230102AbhGRCZm (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Sat, 17 Jul 2021 22:25:42 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R151e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04420;MF=tianjia.zhang@linux.alibaba.com;NM=1;PH=DS;RN=7;SR=0;TI=SMTPD_---0Ug5fTMp_1626574962;
Received: from 30.25.178.219(mailfrom:tianjia.zhang@linux.alibaba.com fp:SMTPD_---0Ug5fTMp_1626574962)
          by smtp.aliyun-inc.com(127.0.0.1);
          Sun, 18 Jul 2021 10:22:43 +0800
Subject: Re: [PATCH ima-evm-utils v5] ima-evm-utils: Support SM2/3 algorithm
 for sign and verify
To:     Vitaly Chikunov <vt@altlinux.org>
Cc:     Mimi Zohar <zohar@linux.ibm.com>, Petr Vorel <pvorel@suse.cz>,
        Stefan Berger <stefanb@linux.ibm.com>,
        linux-integrity@vger.kernel.org,
        Jia Zhang <zhang.jia@linux.alibaba.com>,
        "YiLin . Li" <YiLin.Li@linux.alibaba.com>
References: <20210716092237.17153-1-tianjia.zhang@linux.alibaba.com>
 <f7c05b2618125cb0887ee0302c1197a8c8f49864.camel@linux.ibm.com>
 <7921ca60-8818-b641-3e28-6ffd957f8a1b@linux.alibaba.com>
 <20210717142210.e4xy4lyfav5b4tzq@altlinux.org>
From:   Tianjia Zhang <tianjia.zhang@linux.alibaba.com>
Message-ID: <3ad5310e-5e33-f3d4-a259-988126ed054e@linux.alibaba.com>
Date:   Sun, 18 Jul 2021 10:22:42 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <20210717142210.e4xy4lyfav5b4tzq@altlinux.org>
Content-Type: text/plain; charset=koi8-r; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Hi Vitaly,

On 7/17/21 10:22 PM, Vitaly Chikunov wrote:
> Tianjia, Mimi,
> 
> On Sat, Jul 17, 2021 at 09:48:10AM +0800, Tianjia Zhang wrote:
>> On 7/17/21 12:39 AM, Mimi Zohar wrote:
>>> On Fri, 2021-07-16 at 17:22 +0800, Tianjia Zhang wrote:
>>>> diff --git a/.github/workflows/ci.yml b/.github/workflows/ci.yml
>>>> index 088c041..17407ff 100644
>>>> --- a/.github/workflows/ci.yml
>>>> +++ b/.github/workflows/ci.yml
>>>> @@ -17,6 +17,7 @@ jobs:
>>>>                  ARCH: i386
>>>>                  TSS: tpm2-tss
>>>>                  VARIANT: i386
>>>> +              OPENSSL3: true
>>>>              # cross compilation builds
>>>>              - container: "debian:stable"
>>>> @@ -51,6 +52,7 @@ jobs:
>>>>                env:
>>>>                  CC: clang
>>>>                  TSS: ibmtss
>>>> +              OPENSSL3: true
>>>
>>> I haven't had a chance to look at the entire patch, but defining
>>> OPENSSL3 kind of stood out.  Just as "CC" and "TSS" are generic, I'd
>>> prefer something more generic here.   In the past there was a request
>>> to support Libressl, which never materialized.
>>>
>>
>> I agree that it is appropriate to use a generic variable name. I am thinking
>> of 'CRYPTOGRAPHY' or 'CRYPPTO_LIBRARY'. Are there any better suggestions?
> 
> Perhaps, OPENSSL with tag name. If present, it's git cloned from
> upstream, checked out appropriate tag, compiled, installed, and env set
> to use it to compile ima-evm-utils. If not present (the default) native
> OS OpenSSL is used.
> 

Just use openssl 3.0 to assist in generating keys in the test case, 
evmctl still relies on the default version on the release, which is no 
problem on the mainstream openssl 1.1.1. Secondly, many functions used 
by evmctl have been marked as deprecated in openssl 3.0. There may be a 
major change, maybe it will be better to wait until openssl 3.0 is 
officially released before considering this issue.

Cheers,
Tianjia
