Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 692A1438DA6
	for <lists+linux-integrity@lfdr.de>; Mon, 25 Oct 2021 05:04:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231954AbhJYDGc (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Sun, 24 Oct 2021 23:06:32 -0400
Received: from out30-43.freemail.mail.aliyun.com ([115.124.30.43]:55363 "EHLO
        out30-43.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230040AbhJYDGc (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Sun, 24 Oct 2021 23:06:32 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R111e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04394;MF=tianjia.zhang@linux.alibaba.com;NM=1;PH=DS;RN=18;SR=0;TI=SMTPD_---0UtUyMKi_1635131045;
Received: from 30.240.102.8(mailfrom:tianjia.zhang@linux.alibaba.com fp:SMTPD_---0UtUyMKi_1635131045)
          by smtp.aliyun-inc.com(127.0.0.1);
          Mon, 25 Oct 2021 11:04:06 +0800
Message-ID: <0997d70b-9f28-ba0a-853f-2160922dc722@linux.alibaba.com>
Date:   Mon, 25 Oct 2021 11:04:02 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.2.0
Subject: Re: [PATCH v2 1/2] crypto: use SM3 instead of SM3_256
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
References: <20211019100423.43615-1-tianjia.zhang@linux.alibaba.com>
 <20211019100423.43615-2-tianjia.zhang@linux.alibaba.com>
 <f5c87a233027c8026ae8574f3e25c9162da3bfff.camel@kernel.org>
From:   Tianjia Zhang <tianjia.zhang@linux.alibaba.com>
In-Reply-To: <f5c87a233027c8026ae8574f3e25c9162da3bfff.camel@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Hi Jarkko,

On 10/23/21 8:48 AM, Jarkko Sakkinen wrote:
> On Tue, 2021-10-19 at 18:04 +0800, Tianjia Zhang wrote:
>> According to https://tools.ietf.org/id/draft-oscca-cfrg-sm3-01.html,
>> SM3 always produces a 256-bit hash value and there are no plans for
>> other length development, so there is no ambiguity in the name of sm3.
>>
>> Suggested-by: James Bottomley <jejb@linux.ibm.com>
>> Signed-off-by: Tianjia Zhang <tianjia.zhang@linux.alibaba.com>
>> ---
>>   Documentation/security/keys/trusted-encrypted.rst | 2 +-
>>   crypto/hash_info.c                                | 4 ++--
>>   drivers/char/tpm/tpm2-cmd.c                       | 2 +-
>>   include/crypto/hash_info.h                        | 2 +-
>>   include/uapi/linux/hash_info.h                    | 3 ++-
>>   security/keys/trusted-keys/trusted_tpm2.c         | 2 +-
>>   6 files changed, 8 insertions(+), 7 deletions(-)
>>
>> diff --git a/Documentation/security/keys/trusted-encrypted.rst b/Documentation/security/keys/trusted-encrypted.rst
>> index 80d5a5af62a1..3292461517f6 100644
>> --- a/Documentation/security/keys/trusted-encrypted.rst
>> +++ b/Documentation/security/keys/trusted-encrypted.rst
>> @@ -162,7 +162,7 @@ Usage::
>>                        default 1 (resealing allowed)
>>          hash=         hash algorithm name as a string. For TPM 1.x the only
>>                        allowed value is sha1. For TPM 2.x the allowed values
>> -                     are sha1, sha256, sha384, sha512 and sm3-256.
>> +                     are sha1, sha256, sha384, sha512 and sm3.
> 
> You cannot remove sm3-256 from uapi.
> 

Thanks for pointing it out, Maybe this fix is more appropriate in patch 2.

Best regards,
Tianjia
