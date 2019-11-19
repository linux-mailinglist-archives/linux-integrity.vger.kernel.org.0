Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9D20410110C
	for <lists+linux-integrity@lfdr.de>; Tue, 19 Nov 2019 02:58:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727171AbfKSB6g (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 18 Nov 2019 20:58:36 -0500
Received: from linux.microsoft.com ([13.77.154.182]:40258 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726761AbfKSB6g (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 18 Nov 2019 20:58:36 -0500
Received: from [10.137.112.108] (unknown [131.107.174.108])
        by linux.microsoft.com (Postfix) with ESMTPSA id 3DA9620B7185;
        Mon, 18 Nov 2019 17:58:35 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 3DA9620B7185
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1574128715;
        bh=EwLJ7dZnO9M0Zss7YO2y+ACD+pEYvTL9jIyrqCdm21A=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=URjvum6crfCT/b3wwOqFy+MLioPfsTptUmwCO36GWRB5BNxPuTCSOUViryIRPdBMW
         o5MYK9Vop/WfRJxhuVYaKmDWU5yohWb0R9QZN+6LRwi5gVQpjDwuuElExwYCPnLAQX
         KPV6Vori20PMqmRi1hwhnukbMOk3oF5AZXmYlxwo=
Subject: Re: [PATCH v8 3/5] KEYS: Call the IMA hook to measure keys
To:     Eric Snowberg <eric.snowberg@oracle.com>
Cc:     zohar@linux.ibm.com, linux-integrity@vger.kernel.org,
        linux-kernel@vger.kernel.org, keyrings@vger.kernel.org
References: <20191118223818.3353-1-nramas@linux.microsoft.com>
 <20191118223818.3353-4-nramas@linux.microsoft.com>
 <886A71DC-B2B9-4C25-90D6-511E86F2CA19@oracle.com>
From:   Lakshmi Ramasubramanian <nramas@linux.microsoft.com>
Message-ID: <3e051f5c-927e-cba6-7714-388e0216974a@linux.microsoft.com>
Date:   Mon, 18 Nov 2019 17:58:30 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <886A71DC-B2B9-4C25-90D6-511E86F2CA19@oracle.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On 11/18/19 5:18 PM, Eric Snowberg wrote:

>> +#ifdef CONFIG_ASYMMETRIC_PUBLIC_KEY_SUBTYPE
>> +extern void ima_post_key_create_or_update(struct key *keyring,
>> +					  struct key *key,
>> +					  unsigned long flags, bool create);
>> +#endif
> 
> The extern void ima_post_key_create_or_update will only be defined if CONFIG_IMA=y.
> 

> 
> This will cause a compile error if CONFIG_IMA is not defined and CONFIG_ASYMMETRIC_PUBLIC_KEY_SUBTYPE=y.
> 
> security/keys/key.c: In function 'key_create_or_update':
> security/keys/key.c:940:2: error: implicit declaration of function 'ima_post_key_create_or_update'; did you mean 'key_create_or_update'? [-Werror=implicit-function-declaration]
>    ima_post_key_create_or_update(keyring, key, flags, true);
>    ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>    key_create_or_update
> cc1: some warnings being treated as errors

You are right - Thanks for catching this error.
I'll fix this and send an update.

thanks,
  -lakshmi

