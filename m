Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C38783C5C90
	for <lists+linux-integrity@lfdr.de>; Mon, 12 Jul 2021 14:46:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233898AbhGLMsm (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 12 Jul 2021 08:48:42 -0400
Received: from out30-133.freemail.mail.aliyun.com ([115.124.30.133]:40714 "EHLO
        out30-133.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230361AbhGLMsm (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 12 Jul 2021 08:48:42 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R201e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e01424;MF=tianjia.zhang@linux.alibaba.com;NM=1;PH=DS;RN=4;SR=0;TI=SMTPD_---0UfYaYs._1626093952;
Received: from B-455UMD6M-2027.local(mailfrom:tianjia.zhang@linux.alibaba.com fp:SMTPD_---0UfYaYs._1626093952)
          by smtp.aliyun-inc.com(127.0.0.1);
          Mon, 12 Jul 2021 20:45:52 +0800
Subject: Re: [PATCH ima-evm-utils v3] ima-evm-utils: Support SM2 algorithm for
 sign and verify
To:     Mimi Zohar <zohar@linux.ibm.com>,
        Vitaly Chikunov <vt@altlinux.org>,
        linux-integrity@vger.kernel.org,
        Jia Zhang <zhang.jia@linux.alibaba.com>
References: <20210526084455.56705-1-tianjia.zhang@linux.alibaba.com>
 <d7526f84-f7c9-cbc6-c4a5-3e8b8d78fb60@linux.alibaba.com>
 <10f55257f543cc1d63e7a8ae36cbf2433a01c30b.camel@linux.ibm.com>
 <bb6afba7-255f-5254-5ac7-e793c24d56d3@linux.alibaba.com>
 <5f61f4b0f305a26df0346524e4999c5bbb66571f.camel@linux.ibm.com>
 <4f4a220d-23c5-dbf4-ac57-0ce16ecff2a7@linux.alibaba.com>
 <d1b072c36b4d3770d6b7385836fbed2ec23be349.camel@linux.ibm.com>
From:   Tianjia Zhang <tianjia.zhang@linux.alibaba.com>
Message-ID: <3b5aea51-c82c-70f3-d41e-d615bc14823a@linux.alibaba.com>
Date:   Mon, 12 Jul 2021 20:45:52 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <d1b072c36b4d3770d6b7385836fbed2ec23be349.camel@linux.ibm.com>
Content-Type: text/plain; charset=iso-8859-15; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org



On 7/12/21 8:35 PM, Mimi Zohar wrote:
> On Mon, 2021-07-12 at 20:12 +0800, Tianjia Zhang wrote:
>>
>> On 7/9/21 8:05 PM, Mimi Zohar wrote:
>>> On Fri, 2021-07-09 at 17:06 +0800, Tianjia Zhang wrote:
>>>> On 7/7/21 10:28 AM, Mimi Zohar wrote:
>>>
>>>
>>>>> I'm also seeing:
>>>>> - openssl req -verbose -new -nodes -utf8 -days 10000 -batch -x509 -sm3
>>>>> -sigopt distid:1234567812345678 -config test-ca.conf -copy_extensions
>>>>> copyall -newkey sm2 -out test-sm2.cer -outform DER -keyout test-sm2.key
>>>>> req: Unrecognized flag copy_extensions
>>>>>
>>>>
>>>> This command is for openssl 3.0, and '-copy_extensions copyall' is also
>>>> a parameter supported on 3.0. At present, the mainstream version of
>>>> openssl 1.1.1 only partially supports SM2 signatures. For example, the
>>>> USERID in the SM2 specification cannot be used, and the certificate
>>>> cannot be operated in the command using the SM2/3 algorithm combination,
>>>> just like the modification of libimaevm.c in this patch, this cannot be
>>>> done directly through the openssl command, even if the '-copy_extensions
>>>> copyall' parameter is deleted, this command will be failed on openssl
>>>> 1.1.1. The final solution may be openssl 3.0.
>>>>
>>>> On openssl 1.1.1, there is no problem to operate the signature of the
>>>> SM2/3 algorithm combination through the API. If it is possible, the
>>>> sign_verify test of sm2/3 is not required. What is your opinion?
>>>
>>> Instead of dropping the test altogether, add an openssl version
>>> dependency.
>>
>> Great. will do in next version patch.
> 
> Please consider adding a new CI distro matrix rule that includes the
> needed openssl version.  Another option would be to define a new script
> in the tests directory to install openssl from the git repo.  Please
> limit using that script to a single distro matrix rule.
> 

Got it, thanks for your suggestion. It seems that the second method is 
more suitable.

Thanks,
Tianjia
