Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 312953D1BA0
	for <lists+linux-integrity@lfdr.de>; Thu, 22 Jul 2021 04:09:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230045AbhGVB2g (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 21 Jul 2021 21:28:36 -0400
Received: from out30-43.freemail.mail.aliyun.com ([115.124.30.43]:40307 "EHLO
        out30-43.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229932AbhGVB2f (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 21 Jul 2021 21:28:35 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R761e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04426;MF=tianjia.zhang@linux.alibaba.com;NM=1;PH=DS;RN=7;SR=0;TI=SMTPD_---0UgZE9qF_1626919749;
Received: from B-455UMD6M-2027.local(mailfrom:tianjia.zhang@linux.alibaba.com fp:SMTPD_---0UgZE9qF_1626919749)
          by smtp.aliyun-inc.com(127.0.0.1);
          Thu, 22 Jul 2021 10:09:10 +0800
Subject: Re: [PATCH ima-evm-utils v7] ima-evm-utils: Support SM2/3 algorithm
 for sign and verify
To:     Mimi Zohar <zohar@linux.ibm.com>, Petr Vorel <pvorel@suse.cz>,
        Vitaly Chikunov <vt@altlinux.org>,
        Stefan Berger <stefanb@linux.ibm.com>,
        linux-integrity@vger.kernel.org,
        Jia Zhang <zhang.jia@linux.alibaba.com>,
        "YiLin . Li" <YiLin.Li@linux.alibaba.com>
References: <20210721031659.107568-1-tianjia.zhang@linux.alibaba.com>
 <090dad3a30d709e6fbc9d20a4d283d68e27e1620.camel@linux.ibm.com>
From:   Tianjia Zhang <tianjia.zhang@linux.alibaba.com>
Message-ID: <2e064a17-ed77-10a2-3d4c-03665b921a64@linux.alibaba.com>
Date:   Thu, 22 Jul 2021 10:09:09 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <090dad3a30d709e6fbc9d20a4d283d68e27e1620.camel@linux.ibm.com>
Content-Type: text/plain; charset=iso-8859-15; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Hi Mimi,

On 7/22/21 2:02 AM, Mimi Zohar wrote:
> Hi Tianjia,
> 
> On Wed, 2021-07-21 at 11:16 +0800, Tianjia Zhang wrote:
>> Keep in sync with the kernel IMA, IMA signature tool supports SM2/3
>> algorithm combination. Because in the current version of OpenSSL 1.1.1,
>> the SM2 algorithm and the public key using the EC algorithm share the
>> same ID 'EVP_PKEY_EC', and the specific algorithm can only be
>> distinguished by the curve name used. This patch supports this feature.
>>
>> Secondly, the openssl 1.1.1 tool does not fully support the signature
>> of SM2/3 algorithm combination, so the openssl3 tool is used in the
>> test case, and there is no this problem with directly calling the
>> openssl 1.1.1 API in evmctl.
>>
>> Signed-off-by: Tianjia Zhang <tianjia.zhang@linux.alibaba.com>
> 
> Other than the change noted below in .travis.yml, it's fine.  It's now
> queued in next-testing.
> 
>> ---
> 
>> diff --git a/.travis.yml b/.travis.yml
>> index 7a76273..ab030e5 100644
>> --- a/.travis.yml
>> +++ b/.travis.yml
>> @@ -9,7 +9,7 @@ matrix:
>>       include:
>>           # 32 bit build
>>           - os: linux
>> -          env: DISTRO=debian:stable VARIANT=i386 ARCH=i386 TSS=tpm2-tss
>> +          env: DISTRO=debian:stable VARIANT=i386 ARCH=i386 TSS=tpm2-tss COMPILE_SSL: openssl-3.0.0-beta1
> 
> 
> "COMPILE_SSL: openssl-3.0.0-beta1"  -> "COMPILE_SSL=openssl-3.0.0-
> beta1"
> 
> thanks,
> 
> Mimi
> 

I was careless, thanks for the change.

Best regards,
Tianjia

>>             compiler: gcc
>>   
>>           # cross compilation builds
>> @@ -32,7 +32,7 @@ matrix:
>>   
>>           # glibc (gcc/clang)
>>           - os: linux
>> -          env: DISTRO=opensuse/tumbleweed TSS=ibmtss CONTAINER=podman CONTAINER_ARGS="--runtime=/usr/bin/runc --network=host"
>> +          env: DISTRO=opensuse/tumbleweed TSS=ibmtss CONTAINER=podman CONTAINER_ARGS="--runtime=/usr/bin/runc --network=host" COMPILE_SSL: openssl-3.0.0-beta1
>>             compiler: clang
>>   
>>           - os: linux
>> @@ -40,7 +40,7 @@ matrix:
>>             compiler: gcc
>>   
>>           - os: linux
>> -          env: DISTRO=ubuntu:groovy TSS=ibmtss
>> +          env: DISTRO=ubuntu:groovy TSS=ibmtss COMPILE_SSL: openssl-3.0.0-beta1
>>             compiler: gcc
>>   
>>           - os: linux
>>
> 
