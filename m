Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EE18935CF34
	for <lists+linux-integrity@lfdr.de>; Mon, 12 Apr 2021 19:05:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243971AbhDLRFJ (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 12 Apr 2021 13:05:09 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:50528 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245261AbhDLRE6 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 12 Apr 2021 13:04:58 -0400
Received: from 1.general.cking.uk.vpn ([10.172.193.212])
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <colin.king@canonical.com>)
        id 1lVzzJ-00023K-IM; Mon, 12 Apr 2021 17:04:37 +0000
Subject: Re: [PATCH][next] KEYS: trusted: Fix missing null return from kzalloc
 call
To:     jejb@linux.ibm.com, Jarkko Sakkinen <jarkko@kernel.org>,
        Mimi Zohar <zohar@linux.ibm.com>,
        David Howells <dhowells@redhat.com>,
        James Morris <jmorris@namei.org>,
        "Serge E . Hallyn" <serge@hallyn.com>,
        Sumit Garg <sumit.garg@linaro.org>,
        linux-integrity@vger.kernel.org, keyrings@vger.kernel.org,
        linux-security-module@vger.kernel.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20210412160101.1627882-1-colin.king@canonical.com>
 <adeb7c73d0bb354f04f8117c5ccf6b006dfc15de.camel@linux.ibm.com>
From:   Colin Ian King <colin.king@canonical.com>
Message-ID: <53fef8cf-0dd4-e4fe-260b-0f5ad25d9014@canonical.com>
Date:   Mon, 12 Apr 2021 18:04:37 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <adeb7c73d0bb354f04f8117c5ccf6b006dfc15de.camel@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On 12/04/2021 17:48, James Bottomley wrote:
> On Mon, 2021-04-12 at 17:01 +0100, Colin King wrote:
>> From: Colin Ian King <colin.king@canonical.com>
>>
>> The kzalloc call can return null with the GFP_KERNEL flag so
>> add a null check and exit via a new error exit label. Use the
>> same exit error label for another error path too.
>>
>> Addresses-Coverity: ("Dereference null return value")
>> Fixes: 830027e2cb55 ("KEYS: trusted: Add generic trusted keys
>> framework")
>> Signed-off-by: Colin Ian King <colin.king@canonical.com>
>> ---
>>  security/keys/trusted-keys/trusted_core.c | 6 ++++--
>>  1 file changed, 4 insertions(+), 2 deletions(-)
>>
>> diff --git a/security/keys/trusted-keys/trusted_core.c
>> b/security/keys/trusted-keys/trusted_core.c
>> index ec3a066a4b42..90774793f0b1 100644
>> --- a/security/keys/trusted-keys/trusted_core.c
>> +++ b/security/keys/trusted-keys/trusted_core.c
>> @@ -116,11 +116,13 @@ static struct trusted_key_payload
>> *trusted_payload_alloc(struct key *key)
>>  
>>  	ret = key_payload_reserve(key, sizeof(*p));
>>  	if (ret < 0)
>> -		return p;
>> +		goto err;
>>  	p = kzalloc(sizeof(*p), GFP_KERNEL);
>> +	if (!p)
>> +		goto err;
>>  
>>  	p->migratable = migratable;
>> -
>> +err:
>>  	return p;
> 
> This is clearly a code migration bug in 
> 
> commit 251c85bd106099e6f388a89e88e12d14de2c9cda
> Author: Sumit Garg <sumit.garg@linaro.org>
> Date:   Mon Mar 1 18:41:24 2021 +0530
> 
>     KEYS: trusted: Add generic trusted keys framework
> 
> Which has for addition to trusted_core.c:
> 
> +static struct trusted_key_payload *trusted_payload_alloc(struct key
> *key)
> +{
> +       struct trusted_key_payload *p = NULL;
> +       int ret;
> +
> +       ret = key_payload_reserve(key, sizeof(*p));
> +       if (ret < 0)
> +               return p;
> +       p = kzalloc(sizeof(*p), GFP_KERNEL);
> +
> +       p->migratable = migratable;
> +
> +       return p;
> +}
> 
> And for trusted_tpm1.c:
> 
> -static struct trusted_key_payload *trusted_payload_alloc(struct key
> *key)
> -{
> -       struct trusted_key_payload *p = NULL;
> -       int ret;
> -
> -       ret = key_payload_reserve(key, sizeof *p);
> -       if (ret < 0)
> -               return p;
> -       p = kzalloc(sizeof *p, GFP_KERNEL);
> -       if (p)
> -               p->migratable = 1; /* migratable by default */
> -       return p;
> -}
> 
> The trusted_tpm1.c code was correct and we got this bug introduced by
> what should have been a simple cut and paste ... how did that happen? 
> And therefore, how safe is the rest of the extraction into
> trusted_core.c?
> 

fortunately it gets caught by static analysis, but it does make me also
concerned about what else has changed and how this gets through review.

> James
> 
> 

