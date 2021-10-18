Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A615C430DE2
	for <lists+linux-integrity@lfdr.de>; Mon, 18 Oct 2021 04:38:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243129AbhJRCkV (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Sun, 17 Oct 2021 22:40:21 -0400
Received: from out30-42.freemail.mail.aliyun.com ([115.124.30.42]:41685 "EHLO
        out30-42.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S238675AbhJRCkU (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Sun, 17 Oct 2021 22:40:20 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R731e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04407;MF=tianjia.zhang@linux.alibaba.com;NM=1;PH=DS;RN=18;SR=0;TI=SMTPD_---0UsUNe6S_1634524684;
Received: from 30.240.100.200(mailfrom:tianjia.zhang@linux.alibaba.com fp:SMTPD_---0UsUNe6S_1634524684)
          by smtp.aliyun-inc.com(127.0.0.1);
          Mon, 18 Oct 2021 10:38:06 +0800
Message-ID: <5b0bc02a-eeb5-9d86-852b-d3041f3c6286@linux.alibaba.com>
Date:   Mon, 18 Oct 2021 10:37:56 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.2.0
Subject: Re: [PATCH 2/2] tpm: use SM3 instead of SM3_256
Content-Language: en-US
To:     Jarkko Sakkinen <jarkko@kernel.org>,
        James Bottomley <jejb@linux.ibm.com>,
        Mimi Zohar <zohar@linux.ibm.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>,
        Peter Huewe <peterhuewe@gmx.de>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        David Howells <dhowells@redhat.com>,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        Jerry Snitselaar <jsnitsel@redhat.com>,
        linux-integrity@vger.kernel.org, keyrings@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-crypto@vger.kernel.org, linux-security-module@vger.kernel.org
References: <20211009130828.101396-1-tianjia.zhang@linux.alibaba.com>
 <20211009130828.101396-3-tianjia.zhang@linux.alibaba.com>
 <c6c2337ed83c237f70716cb4c62794d1d3da31f2.camel@kernel.org>
 <5db32f21-1df7-c92e-42a1-a2a85b29dfbf@linux.alibaba.com>
 <31d49f7785dd82fd2f0c1078c9a94153e3c389ac.camel@kernel.org>
From:   Tianjia Zhang <tianjia.zhang@linux.alibaba.com>
In-Reply-To: <31d49f7785dd82fd2f0c1078c9a94153e3c389ac.camel@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Hi Jarkko,

On 10/15/21 11:19 PM, Jarkko Sakkinen wrote:
> On Thu, 2021-10-14 at 17:46 +0800, Tianjia Zhang wrote:
>> Hi Jarkko,
>>
>> On 10/12/21 11:21 PM, Jarkko Sakkinen wrote:
>>> On Sat, 2021-10-09 at 21:08 +0800, Tianjia Zhang wrote:
>>>> According to https://tools.ietf.org/id/draft-oscca-cfrg-sm3-01.html,
>>>> SM3 always produces a 256-bit hash value and there are no plans for
>>>> other length development, so there is no ambiguity in the name of sm3.
>>>>
>>>> Signed-off-by: Tianjia Zhang <tianjia.zhang@linux.alibaba.com>
>>>
>>> This is not enough to make any changes because the commit message
>>> does not describe what goes wrong if we keep it as it was.
>>>
>>> /Jarkko
>>>
>>
>> This did not cause an error, just to use a more standard algorithm name.
>> If it is possible to use the SM3 name instead of SM3_256 if it can be
>> specified from the source, it is of course better. I have contacted the
>> trustedcomputinggroup and have not yet received a reply.
>>
>> Best regards,
>> Tianjia
> 
> Why don't you then create a patch set that fully removes SM3_256, if it
> is incorrect?
> 
> This looks a bit half-baked patch set.
> 
> /Jarkko
> 

This series of patch is a complete replacement. Patch 1 is a replacement 
of the crypto subsystem, and patch 2 is a replacement of the tpm driver.

Best regards,
Tianjia
