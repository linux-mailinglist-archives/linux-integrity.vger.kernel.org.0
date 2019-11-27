Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 409C410BC09
	for <lists+linux-integrity@lfdr.de>; Wed, 27 Nov 2019 22:18:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732765AbfK0VMG (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 27 Nov 2019 16:12:06 -0500
Received: from linux.microsoft.com ([13.77.154.182]:40538 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733256AbfK0VMF (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 27 Nov 2019 16:12:05 -0500
Received: from [10.137.112.108] (unknown [131.107.174.108])
        by linux.microsoft.com (Postfix) with ESMTPSA id B36C120B7185;
        Wed, 27 Nov 2019 13:12:04 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com B36C120B7185
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1574889124;
        bh=BjH41wc2s7M+i6lyEXWUb1jJqyOffx38FZ7r2CreKBw=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=C2mnrUf75pU4jHQAMpcwi46dM3w7EZN3ld8GFzsICwqToZRFK07dIXgGA9jdsec85
         cZ+lloUsdrTGs5LnPjNcdidd4r6Af0xuAjlfK3pul1n1M8I/3vc4uHHsE3jqxuLy1b
         Ni+O0M/RgFCc1ts87IAj59+tfrp0YzA2nb6KUPAg=
Subject: Re: [PATCH v0 1/2] IMA: Defined queue functions
To:     Mimi Zohar <zohar@linux.ibm.com>, linux-integrity@vger.kernel.org
Cc:     eric.snowberg@oracle.com, dhowells@redhat.com,
        matthewgarrett@google.com, sashal@kernel.org,
        jamorris@linux.microsoft.com, linux-kernel@vger.kernel.org,
        keyrings@vger.kernel.org, Janne Karhunen <janne.karhunen@gmail.com>
References: <20191127025212.3077-1-nramas@linux.microsoft.com>
 <20191127025212.3077-2-nramas@linux.microsoft.com>
 <1574887137.4793.346.camel@linux.ibm.com>
From:   Lakshmi Ramasubramanian <nramas@linux.microsoft.com>
Message-ID: <ea2fafb8-a97f-5365-debd-d90143e549bf@linux.microsoft.com>
Date:   Wed, 27 Nov 2019 13:11:59 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.1
MIME-Version: 1.0
In-Reply-To: <1574887137.4793.346.camel@linux.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On 11/27/19 12:38 PM, Mimi Zohar wrote:

> Hi Lakshmi,
> 
> Janne Karhunen is defining an IMA workqueue in order to more
> frequently update the on disk security xattrs.  

Has the above patch set been posted for review? I'll take a look and see 
if that one can be used for queuing keys.

The Subject line on
> this patch needs to be more explicit (eg. define workqueue for early
> boot "key" measurements).

Will update the subject line.
I was trying to keep the subject line short and have more details in the 
patch description.

> I'm not sure why you want to differentiate between IMA being
> initialized vs. an empty policy.  I would think you would want to know
> when a custom policy has been loaded.

You are right - When custom ima policy rules are loaded (in 
ima_update_policy() function), ima_process_queued_keys_for_measurement() 
function is called to process queued keys.

The flag ima_process_keys_for_measurement is set to true in 
ima_process_queued_keys_for_measurement(). And, subsequent keys are 
processed immediately.

Please take a look at ima_process_queued_keys_for_measurement() in this 
patch (v0 1/2) and the ima_update_policy() change in "PATCH v0 2/2".

> 
> I would define a function that determines whether or not a custom
> policy has been loaded.

The queued keys need to be processed once when the custom policy is 
loaded. Subsequently, keys are processed immediately (not queued).

Do you still think there is a need to have a function to determine if 
custom policy has been loaded? Wouldn't the flag 
ima_process_keys_for_measurement be sufficient?

Please take a look at "PATCH v0 2/2" and let me know if you disagree.

> (I still need to review adding/removing from the queue.)
> 
>>
>> @@ -27,14 +154,14 @@
>>    * The payload data used to instantiate or update the key is measured.
>>    */
>>   void ima_post_key_create_or_update(struct key *keyring, struct key *key,
>> -				   const void *payload, size_t plen,
>> +				   const void *payload, size_t payload_len,
>>   				   unsigned long flags, bool create)
> 
> This "hunk" and subsequent one seem to be just a variable name change.
>   It has nothing to do with queueing "key" measurements and shouldn't
> be included in this patch.
> 
> Mimi

I'll remove this change.

thanks,
  -lakshmi
