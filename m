Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7245DE54A2
	for <lists+linux-integrity@lfdr.de>; Fri, 25 Oct 2019 21:49:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726369AbfJYTt2 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 25 Oct 2019 15:49:28 -0400
Received: from linux.microsoft.com ([13.77.154.182]:38732 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726263AbfJYTt2 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 25 Oct 2019 15:49:28 -0400
Received: from [10.137.112.111] (unknown [131.107.147.111])
        by linux.microsoft.com (Postfix) with ESMTPSA id 632C62010AC9;
        Fri, 25 Oct 2019 12:49:27 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 632C62010AC9
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1572032967;
        bh=arffu6CtqVuIvQ0iJb4yQV3sPO18YA6ZcJjsgBLt/xQ=;
        h=Subject:To:References:From:Date:In-Reply-To:From;
        b=lD93IP13AyAM2AwIGQvUum25fkCiBf3v7KXinxUlkR4XjpFDt5L83C2dKGYY3/tiu
         Hrn2jhYlP4712hBMEMtZ9zx7eNeKe56E8ME8t/sv7Y6J78os4oUe4F6I4GeL+LtQi6
         QENmDTLIJ9GIhTP8aIuKaFddenhSXQtN7EiMFd+g=
Subject: Re: [PATCH v2 1/4] KEYS: Defined an ima hook for measuring keys on
 key create or update
To:     Mimi Zohar <zohar@linux.ibm.com>, dhowells@redhat.com,
        casey@schaufler-ca.com, sashal@kernel.org,
        jamorris@linux.microsoft.com,
        linux-security-module@vger.kernel.org,
        linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org,
        keyrings@vger.kernel.org
References: <20191023233950.22072-1-nramas@linux.microsoft.com>
 <20191023233950.22072-2-nramas@linux.microsoft.com>
 <1572032428.4532.72.camel@linux.ibm.com>
From:   Lakshmi Ramasubramanian <nramas@linux.microsoft.com>
Message-ID: <715d35ba-a102-3524-77a8-70a784628b46@linux.microsoft.com>
Date:   Fri, 25 Oct 2019 12:49:45 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.0
MIME-Version: 1.0
In-Reply-To: <1572032428.4532.72.camel@linux.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On 10/25/2019 12:40 PM, Mimi Zohar wrote:

> On Wed, 2019-10-23 at 16:39 -0700, Lakshmi Ramasubramanian wrote:
>> Defined an ima hook to measure keys created or updated in the system.
> 
> "IMA" is an anacronym.  Unless it is a part of a function name, it
> should be capitalized.
Will fix that.

> 
> Before describing "what" you're doing, describe the problem.  For
> example, "The asymmetric keys used for verifying file signatures or
> certificates are currently not included in the IMA measurement list.
>   This patch defines a new IMA hook named ima_key_create_or_update() to
> measure keys."
Agree - will update.


>> +
>> +	if (!ima_initialized)
>> +		return;
> 
> There's no reason to define a new variable to determine if IMA is
> initialized.  Use ima_policy_flag.
Will change it.

>  Like process_measurements, the test should be in process_buffer_measurement(), not here.

Currently, queuing of requests when IMA is not initialized is done for 
keys only. Moving that check inside process_buffer_measurement would 
mean handling queuing for all buffer measurements.

Can that be done as a separate patch set and not in this one?

>> @@ -936,6 +937,9 @@ key_ref_t key_create_or_update(key_ref_t keyring_ref,
>>   		goto error_link_end;
>>   	}
>>   
>> +	/* let the ima module know about the created key. */
>> +	ima_post_key_create_or_update(keyring, key, flags, true);
>> +
>>   	key_ref = make_key_ref(key, is_key_possessed(keyring_ref));
> 
> This patch defines the new IMA hook.  This call and the subsequent one
> below can be defined in a separate patch.  The subject line of that
> patch would be "keys: Add ima_key_create_or_update call to measure
> keys".
> 
> Mimi
Agree - will change it.

thanks,
  -lakshmi
