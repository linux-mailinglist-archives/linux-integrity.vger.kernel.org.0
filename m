Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 969313703EE
	for <lists+linux-integrity@lfdr.de>; Sat,  1 May 2021 01:09:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232332AbhD3XJw (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 30 Apr 2021 19:09:52 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:51508 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231265AbhD3XJv (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 30 Apr 2021 19:09:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1619824142;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=QSMo0z9Rxmagh5nEn6Z1ZpHmqk1+UCu4svG3FgyyVgw=;
        b=USa43/mK5ohfKubVrmCB9uAykKLHftzkTof4hywWa+oLbHKJuAbf51YLXeVpRcqIGYl6+G
        yLmED5L+laguulbpGQmEx2Cp8kwRs+eM2C/+iSi2eD9n2ZYHPNeF3vRZEd807aTmwYm05g
        kGclFpZUrc7gjr9zpZGjYcJdZbgn/rU=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-409-JCeqZ4bsOdOcU9HqtTTQSQ-1; Fri, 30 Apr 2021 19:09:00 -0400
X-MC-Unique: JCeqZ4bsOdOcU9HqtTTQSQ-1
Received: by mail-qt1-f198.google.com with SMTP id k13-20020ac8140d0000b02901bad0e39d8fso6356390qtj.6
        for <linux-integrity@vger.kernel.org>; Fri, 30 Apr 2021 16:09:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=QSMo0z9Rxmagh5nEn6Z1ZpHmqk1+UCu4svG3FgyyVgw=;
        b=CeChzDqn9tp46WTRlQgni5fMRvhJfCK4DCYVPB+YDYq0HWx/xf6l683vIcQAN1y+nK
         oko5qAAhkVtCtdCc9vvFCvCjPw2YjBC6O2B4/PexVVpR493OCWzPFeyIDnf6wOf8OSYV
         dDt90OV0iec2s5M+EKTTh2hLx3c8BIFhKtNPOdsikDeZQd3skqxaUImn9Z5q97mABKVV
         4SLNxMRkZOJ40sJ2wZH36VMWCZXrXRtYX1lAjf0sxIsLhTX1d4/kZi3duMvSK3Mt/gUt
         wZm8a25yHhIHx5hCWPqhg7ipSu9usgGz9EYC7TZ5rYqzimJTmPIzp8zyCb6Jzg4gqhzh
         bMOQ==
X-Gm-Message-State: AOAM531gbqtuqmTD3Q+tqw4e5IjwjEPIHY140TGm2XEn1JfwbYwxlZlK
        gU/GHQ6qvnHKf8HHMGOys1GG6X8JqxUwhUJRZeyHM5BFlmkjDdONyxzOnekOM+B50X4G/8L0o67
        pNuaIwORlNkTKhlOOrXBabvUkHSar
X-Received: by 2002:ac8:5704:: with SMTP id 4mr6367238qtw.379.1619824140096;
        Fri, 30 Apr 2021 16:09:00 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxxRQVIutmu1/MxdsrOTKOKa2+oNtKY7kpqCZNcAy9Dt75nhfoypX4piStjUJwls24KKPWrfw==
X-Received: by 2002:ac8:5704:: with SMTP id 4mr6367210qtw.379.1619824139909;
        Fri, 30 Apr 2021 16:08:59 -0700 (PDT)
Received: from localhost.localdomain (075-142-250-213.res.spectrum.com. [75.142.250.213])
        by smtp.gmail.com with ESMTPSA id v65sm2624530qkc.125.2021.04.30.16.08.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 30 Apr 2021 16:08:59 -0700 (PDT)
Subject: Re: [PATCH] KEYS: trusted: fix memory leak
To:     Ben Boeckel <me@benboeckel.net>
Cc:     jejb@linux.ibm.com, jarkko@kernel.org, zohar@linux.ibm.com,
        dhowells@redhat.com, jmorris@namei.org, serge@hallyn.com,
        linux-integrity@vger.kernel.org, keyrings@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, Colin King <colin.king@canonical.com>
References: <20210430185810.3331311-1-trix@redhat.com>
 <YIxfehTLhWe58sNE@erythro>
From:   Tom Rix <trix@redhat.com>
Message-ID: <baecdb22-6433-7ad0-6c9e-75f4c5d1201d@redhat.com>
Date:   Fri, 30 Apr 2021 16:08:56 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <YIxfehTLhWe58sNE@erythro>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org


On 4/30/21 12:50 PM, Ben Boeckel wrote:
> On Fri, Apr 30, 2021 at 11:58:10 -0700, trix@redhat.com wrote:
>> From: Tom Rix <trix@redhat.com>
>>
>> Static analysis reports this problem
>> trusted-keys/trusted_tpm1.c:496:10: warning: Potential memory leak
>>    return ret;
>>           ^~~
>>
>> In tpm_seal() some failure handling returns directly, without
>> freeing memory.
>>
>> Fixes: 5df16caada3f ("KEYS: trusted: Fix incorrect handling of tpm_get_random()")
>> Signed-off-by: Tom Rix <trix@redhat.com>
>> ---
>>   security/keys/trusted-keys/trusted_tpm1.c | 8 +++++---
>>   1 file changed, 5 insertions(+), 3 deletions(-)
>>
>> diff --git a/security/keys/trusted-keys/trusted_tpm1.c b/security/keys/trusted-keys/trusted_tpm1.c
>> index 469394550801..aa108bea6739 100644
>> --- a/security/keys/trusted-keys/trusted_tpm1.c
>> +++ b/security/keys/trusted-keys/trusted_tpm1.c
>> @@ -493,10 +493,12 @@ static int tpm_seal(struct tpm_buf *tb, uint16_t keytype,
>>   
>>   	ret = tpm_get_random(chip, td->nonceodd, TPM_NONCE_SIZE);
>>   	if (ret < 0)
>> -		return ret;
>> +		goto out;
>>   
>> -	if (ret != TPM_NONCE_SIZE)
>> -		return -EIO;
>> +	if (ret != TPM_NONCE_SIZE) {
>> +		ret = -EIO;
>> +		goto out;
>> +	}
>>   
>>   	ordinal = htonl(TPM_ORD_SEAL);
>>   	datsize = htonl(datalen);
> I see this patch also submitted by Colin (Cc'd) in Message-Id:
>
>      <20210430113724.110746-1-colin.king@canonical.com>

Let's use Colin's.

Tom

>
> To my eyes, the commit message seems a bit better over there.
>
> --Ben
>

