Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AF94D159984
	for <lists+linux-integrity@lfdr.de>; Tue, 11 Feb 2020 20:14:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731564AbgBKTOI (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 11 Feb 2020 14:14:08 -0500
Received: from linux.microsoft.com ([13.77.154.182]:35106 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729934AbgBKTOI (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 11 Feb 2020 14:14:08 -0500
Received: from [10.137.112.97] (unknown [131.107.147.225])
        by linux.microsoft.com (Postfix) with ESMTPSA id 4BEDA20B9C02;
        Tue, 11 Feb 2020 11:14:07 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 4BEDA20B9C02
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1581448447;
        bh=RPlYEGk4m98iOqpw+g59ACgnUaVZv4TL9spVUV4kFFc=;
        h=From:Subject:To:Cc:References:Date:In-Reply-To:From;
        b=ZfIWcz7ux7kw0zZv3Ax6nQtTCh3MNWvcZHQYWCSGsQt1AO8pxctZD26sfIOyyRASC
         +MKcb+sT89tq9HLc5Kk7rKpDyPL7hjzAK+v11qnGlzqt875/7CVP1nKSjmWc/NT9wz
         hZ4I2czuN+oLacCQbfvCYzsu25Eyq+JJBN/kW2QE=
From:   Tushar Sugandhi <tusharsu@linux.microsoft.com>
Subject: Re: [PATCH v2 2/3] IMA: Add log statements for failure conditions.
To:     Joe Perches <joe@perches.com>, zohar@linux.ibm.com,
        skhan@linuxfoundation.org, linux-integrity@vger.kernel.org
Cc:     sashal@kernel.org, nramas@linux.microsoft.com,
        linux-kernel@vger.kernel.org
References: <20200211024755.5579-1-tusharsu@linux.microsoft.com>
 <20200211024755.5579-2-tusharsu@linux.microsoft.com>
 <9ed05e364f7eb7ccdeed7c580b3aded8fd8697f7.camel@perches.com>
Message-ID: <ca5e6f88-6946-92ae-d4ac-0f07df54876a@linux.microsoft.com>
Date:   Tue, 11 Feb 2020 11:14:07 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <9ed05e364f7eb7ccdeed7c580b3aded8fd8697f7.camel@perches.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Hi Joe,

On 2020-02-10 7:23 p.m., Joe Perches wrote:
> On Mon, 2020-02-10 at 18:47 -0800, Tushar Sugandhi wrote:
>> process_buffer_measurement() and ima_alloc_key_entry()
>> functions do not have log messages for failure conditions.
> 
> trivia:
> 
>> diff --git a/security/integrity/ima/ima_main.c b/security/integrity/ima/ima_main.c
> []
>> @@ -757,6 +757,9 @@ void process_buffer_measurement(const void *buf, int size,
>>   		ima_free_template_entry(entry);
>>   
>>   out:
>> +	if (ret < 0)
>> +		pr_err("Process buffer measurement failed, result: %d\n", ret);
> 
> perhaps use %s, __func__
> 
> 		pr_err("%s: failed, result: %d\n", __func__, ret);
>   
Sounds good. Will make this change in the next update.
>> diff --git a/security/integrity/ima/ima_queue_keys.c b/security/integrity/ima/ima_queue_keys.c
> []
>> @@ -90,6 +90,7 @@ static struct ima_key_entry *ima_alloc_key_entry(struct key *keyring,
>>   
>>   out:
>>   	if (rc) {
>> +		pr_err("Key entry allocation failed, result: %d\n", rc);
>>   		ima_free_key_entry(entry);
>>   		entry = NULL;
>>   	}
> 
> Likely the pr_err is unnecessary here as kmalloc, kstrdup
> and kmemdup all emit a dump_stack() on allocation failure.
Thanks for pointing out kmalloc, kstrdup, and kmemdup emit a 
dump_stack(). But keeping the above pr_err() will help associate the 
failure with IMA.
For instance - "dmesg | grep ima:" will include this error.
Perhaps I should add __func__ here as well.
And since we are redefining the pr_fmt to prefix module and base names, 
it will help further to pinpoint where exactly the failure is coming from.

> 
> Perhaps instead:
> 
> o Remove unnecessary indentation in ima_free_key_entry by
>    returning early on NULL argument
> o Remove unnecessary rc, tests and label in ima_alloc_key_entry
> ---
>   security/integrity/ima/ima_queue_keys.c | 37 +++++++++++++--------------------
>   1 file changed, 15 insertions(+), 22 deletions(-)
> 
> diff --git a/security/integrity/ima/ima_queue_keys.c b/security/integrity/ima/ima_queue_keys.c
> index c87c722..ba449f 100644
> --- a/security/integrity/ima/ima_queue_keys.c
> +++ b/security/integrity/ima/ima_queue_keys.c
> @@ -58,42 +58,35 @@ void ima_init_key_queue(void)
>   
>   static void ima_free_key_entry(struct ima_key_entry *entry)
>   {
> -	if (entry) {
> -		kfree(entry->payload);
> -		kfree(entry->keyring_name);
> -		kfree(entry);
> -	}
> +	if (!entry)
> +		return;
> +
> +	kfree(entry->payload);
> +	kfree(entry->keyring_name);
> +	kfree(entry);
>   }
>   
Thanks for the feedback. Appreciate it. I would like to make this fix.
But I am not sure if this patchset, which mainly focuses on improving 
logging in IMA, is the right patchset for this.
>   static struct ima_key_entry *ima_alloc_key_entry(struct key *keyring,
>   						 const void *payload,
>   						 size_t payload_len)
>   {
> -	int rc = 0;
>   	struct ima_key_entry *entry;
>   
>   	entry = kzalloc(sizeof(*entry), GFP_KERNEL);
> -	if (entry) {
> -		entry->payload = kmemdup(payload, payload_len, GFP_KERNEL);
> -		entry->keyring_name = kstrdup(keyring->description,
> -					      GFP_KERNEL);
> -		entry->payload_len = payload_len;
> -	}
> -
> -	if ((entry == NULL) || (entry->payload == NULL) ||
> -	    (entry->keyring_name == NULL)) {
> -		rc = -ENOMEM;
> -		goto out;
> -	}
> +	if (!entry)
> +		return NULL;
>   
> -	INIT_LIST_HEAD(&entry->list);
> +	entry->payload = kmemdup(payload, payload_len, GFP_KERNEL);
> +	entry->payload_len = payload_len;
> +	entry->keyring_name = kstrdup(keyring->description, GFP_KERNEL);
>   
> -out:
> -	if (rc) {
> +	if (!entry->payload || !entry->keyring_name) {
>   		ima_free_key_entry(entry);
> -		entry = NULL;
> +		return NULL;
>   	}
>   
> +	INIT_LIST_HEAD(&entry->list);
> +
>   	return entry;
>   }
>   
> 
Thanks again. This recommended change certainly makes the code more 
readable. But again, I am not sure if this patchset is the right one for 
this proposed change.
Perhaps I can create another patchset for the above two recommended 
changes, and only focus on improving logging in this patchset?

Thanks,
Tushar
