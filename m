Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D68984332AA
	for <lists+linux-integrity@lfdr.de>; Tue, 19 Oct 2021 11:39:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234976AbhJSJmJ (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 19 Oct 2021 05:42:09 -0400
Received: from out30-57.freemail.mail.aliyun.com ([115.124.30.57]:60981 "EHLO
        out30-57.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234808AbhJSJmI (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 19 Oct 2021 05:42:08 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R171e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04426;MF=tianjia.zhang@linux.alibaba.com;NM=1;PH=DS;RN=18;SR=0;TI=SMTPD_---0UsueS9M_1634636390;
Received: from 30.240.101.11(mailfrom:tianjia.zhang@linux.alibaba.com fp:SMTPD_---0UsueS9M_1634636390)
          by smtp.aliyun-inc.com(127.0.0.1);
          Tue, 19 Oct 2021 17:39:51 +0800
Message-ID: <aac78812-18dc-5e78-ab48-61e15eeb9315@linux.alibaba.com>
Date:   Tue, 19 Oct 2021 17:39:49 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.2.0
Subject: Re: [PATCH 1/2] crypto: use SM3 instead of SM3_256
Content-Language: en-US
To:     Jarkko Sakkinen <jarkko@kernel.org>, jejb@linux.ibm.com,
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
 <20211009130828.101396-2-tianjia.zhang@linux.alibaba.com>
 <7035153d58e220473fe3cd17c9f574f2d91c740b.camel@linux.ibm.com>
 <dbac037710d711959d5ce0969f80ea0dd18a176e.camel@kernel.org>
 <af8c2098c4cfe23b941a191f7b4ec0e3a5251760.camel@linux.ibm.com>
 <41aba1e1c5849b58f83108eb9f9f115d0cd5826f.camel@kernel.org>
From:   Tianjia Zhang <tianjia.zhang@linux.alibaba.com>
In-Reply-To: <41aba1e1c5849b58f83108eb9f9f115d0cd5826f.camel@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Hi Jarkko,

On 10/18/21 9:41 PM, Jarkko Sakkinen wrote:
> On Mon, 2021-10-18 at 09:32 -0400, James Bottomley wrote:
>> On Mon, 2021-10-18 at 16:27 +0300, Jarkko Sakkinen wrote:
>>> On Mon, 2021-10-18 at 09:05 -0400, James Bottomley wrote:
>>>> On Sat, 2021-10-09 at 21:08 +0800, Tianjia Zhang wrote:
>>>> [...]
>>>>> diff --git a/include/uapi/linux/hash_info.h
>>>>> b/include/uapi/linux/hash_info.h
>>>>> index 74a8609fcb4d..1355525dd4aa 100644
>>>>> --- a/include/uapi/linux/hash_info.h
>>>>> +++ b/include/uapi/linux/hash_info.h
>>>>> @@ -32,7 +32,7 @@ enum hash_algo {
>>>>>          HASH_ALGO_TGR_128,
>>>>>          HASH_ALGO_TGR_160,
>>>>>          HASH_ALGO_TGR_192,
>>>>> -       HASH_ALGO_SM3_256,
>>>>> +       HASH_ALGO_SM3,
>>>>>          HASH_ALGO_STREEBOG_256,
>>>>>          HASH_ALGO_STREEBOG_512,
>>>>>          HASH_ALGO__LAST
>>>>
>>>> This is another one you can't do: all headers in UAPI are exports
>>>> to userspace and the definitions constitute an ABI.  If you simply
>>>> do a rename, every userspace program that uses the current
>>>> definition will immediately break on compile.  You could add
>>>> HASH_ALGO_SM3, but you can't remove HASH_ALGO_SM3_256
>>>>
>>>> James
>>>
>>> So: shouldn't then also the old symbol continue to work also
>>> semantically?
>>
>> Yes, that's the point: you can add a new definition ... in this case an
>> alias for the old one, but you can't remove a definition that's been
>> previously exported.
> 
> Thanks, this of course obvious :-) I forgot temporarily that crypto
> has uapi interface. Tianjia, this patch set break production systems,
> so no chance we would ever merge it in this form.
> 
> Why not just do this:
> 
> ...
> HASH_ALGO_SM3_256,
> HASH_ALOG_SM3 = HASH_ALOG_SM_256,
> ...
> 
> There is not good reason to mod the implementation because both symbols
> are kept.
> 
> /Jarkko
> 

Very good suggestion, I will do this in the next version patch. Maybe 
this is more appropriate:

   HASH_ALGO_SM3,
   HASH_ALGO_SM3_256 = HASH_ALGO_SM3,

Best regards,
Tianjia
