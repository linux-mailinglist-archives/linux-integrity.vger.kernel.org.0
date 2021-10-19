Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 24562433254
	for <lists+linux-integrity@lfdr.de>; Tue, 19 Oct 2021 11:35:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235071AbhJSJh3 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 19 Oct 2021 05:37:29 -0400
Received: from out30-43.freemail.mail.aliyun.com ([115.124.30.43]:35815 "EHLO
        out30-43.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234561AbhJSJh2 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 19 Oct 2021 05:37:28 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R661e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04400;MF=tianjia.zhang@linux.alibaba.com;NM=1;PH=DS;RN=18;SR=0;TI=SMTPD_---0UsuQlL7_1634636110;
Received: from 30.240.101.11(mailfrom:tianjia.zhang@linux.alibaba.com fp:SMTPD_---0UsuQlL7_1634636110)
          by smtp.aliyun-inc.com(127.0.0.1);
          Tue, 19 Oct 2021 17:35:11 +0800
Message-ID: <3bd42726-b383-eb33-5c03-2932036d06a4@linux.alibaba.com>
Date:   Tue, 19 Oct 2021 17:35:05 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.2.0
Subject: Re: [PATCH 1/2] crypto: use SM3 instead of SM3_256
Content-Language: en-US
To:     jejb@linux.ibm.com, Jarkko Sakkinen <jarkko@kernel.org>,
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
From:   Tianjia Zhang <tianjia.zhang@linux.alibaba.com>
In-Reply-To: <7035153d58e220473fe3cd17c9f574f2d91c740b.camel@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Hi James,

On 10/18/21 9:05 PM, James Bottomley wrote:
> On Sat, 2021-10-09 at 21:08 +0800, Tianjia Zhang wrote:
> [...]
>> diff --git a/include/uapi/linux/hash_info.h
>> b/include/uapi/linux/hash_info.h
>> index 74a8609fcb4d..1355525dd4aa 100644
>> --- a/include/uapi/linux/hash_info.h
>> +++ b/include/uapi/linux/hash_info.h
>> @@ -32,7 +32,7 @@ enum hash_algo {
>>   	HASH_ALGO_TGR_128,
>>   	HASH_ALGO_TGR_160,
>>   	HASH_ALGO_TGR_192,
>> -	HASH_ALGO_SM3_256,
>> +	HASH_ALGO_SM3,
>>   	HASH_ALGO_STREEBOG_256,
>>   	HASH_ALGO_STREEBOG_512,
>>   	HASH_ALGO__LAST
> 
> This is another one you can't do: all headers in UAPI are exports to
> userspace and the definitions constitute an ABI.  If you simply do a
> rename, every userspace program that uses the current definition will
> immediately break on compile.  You could add HASH_ALGO_SM3, but you
> can't remove HASH_ALGO_SM3_256
> 
> James
> 

Correct, Thanks for pointing it out, redefining a macro is indeed a more 
appropriate method.

Best regards,
Tianjia
