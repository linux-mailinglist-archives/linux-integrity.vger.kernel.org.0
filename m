Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 16A1B2EB2D7
	for <lists+linux-integrity@lfdr.de>; Tue,  5 Jan 2021 19:55:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729619AbhAESxr (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 5 Jan 2021 13:53:47 -0500
Received: from linux.microsoft.com ([13.77.154.182]:34276 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726258AbhAESxr (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 5 Jan 2021 13:53:47 -0500
Received: from [192.168.86.31] (c-71-197-163-6.hsd1.wa.comcast.net [71.197.163.6])
        by linux.microsoft.com (Postfix) with ESMTPSA id 167CF20B7192;
        Tue,  5 Jan 2021 10:53:05 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 167CF20B7192
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1609872786;
        bh=4z0o1Q8ayYYboZSCQkOiVolnujOFfwOB2QkQyjTsAWE=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=jZyYAnaB9eK3CuK0Ewu7CmvJoRWBLCBCMZWVFAzdfUA2jknYGnBTUMcEZklImzaYz
         l1KgcpBPp67qtRox4suu7A0AFaAxfNKjFG6Qk1cfEiIE17LRYX0hhC3w3JGzawYLEC
         5emVQZXR+1yklfN/Hsj8IbUAfgfE8v8ct+iBxJaY=
Subject: Re: [PATCH v9 2/8] IMA: add support to measure buffer data hash
To:     Mimi Zohar <zohar@linux.ibm.com>, stephen.smalley.work@gmail.com,
        casey@schaufler-ca.com, agk@redhat.com, snitzer@redhat.com,
        gmazyland@gmail.com, paul@paul-moore.com
Cc:     tyhicks@linux.microsoft.com, sashal@kernel.org, jmorris@namei.org,
        nramas@linux.microsoft.com, linux-integrity@vger.kernel.org,
        selinux@vger.kernel.org, linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, dm-devel@redhat.com
References: <20201212180251.9943-1-tusharsu@linux.microsoft.com>
 <20201212180251.9943-3-tusharsu@linux.microsoft.com>
 <4e83480731b937cea479f688029560444b9cb66a.camel@linux.ibm.com>
From:   Tushar Sugandhi <tusharsu@linux.microsoft.com>
Message-ID: <3fdb72ae-f291-386b-e7b9-688dfe092dc5@linux.microsoft.com>
Date:   Tue, 5 Jan 2021 10:53:04 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <4e83480731b937cea479f688029560444b9cb66a.camel@linux.ibm.com>
Content-Type: text/plain; charset=iso-8859-15; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org



On 2020-12-23 4:03 p.m., Mimi Zohar wrote:
> On Sat, 2020-12-12 at 10:02 -0800, Tushar Sugandhi wrote:
>> The original IMA buffer data measurement sizes were small (e.g. boot
>> command line), but the new buffer data measurement use cases have data
>> sizes that are a lot larger.  Just as IMA measures the file data hash,
>> not the file data, IMA should similarly support the option for measuring
>> the hash of the buffer data.
>>
>> Measuring in-memory buffer-data/buffer-data-hash is different than
>> measuring file-data/file-data-hash. For the file, IMA stores the
>> measurements in both measurement log and the file's extended attribute -
>> which can later be used for appraisal as well. For buffer, the
>> measurements are only stored in the IMA log, since the buffer has no
>> extended attributes associated with it.
> 
> By definition, buffer data is only measured.  Nothing new is added by
> the above paragraph.  Please remove it.
> 
Sure. Will remove.
>>
>> Introduce a boolean parameter measure_buf_hash to support measuring
>> hash of a buffer, which would be much smaller, instead of the buffer
>> itself.
> 
> Like the patch Subject line use "the buffer data hash" instead of the
> "hash of a buffer".
> 
Will do.
> There's no need to include the boolean parameter name
> "measure_buf_hash".  Please remove it.
> 
Will do.
>>
>> Signed-off-by: Tushar Sugandhi <tusharsu@linux.microsoft.com>
>> Reviewed-by: Tyler Hicks <tyhicks@linux.microsoft.com>
>> ---
>>   security/integrity/ima/ima.h                 |  3 +-
>>   security/integrity/ima/ima_appraise.c        |  2 +-
>>   security/integrity/ima/ima_asymmetric_keys.c |  2 +-
>>   security/integrity/ima/ima_main.c            | 38 +++++++++++++++++---
>>   security/integrity/ima/ima_queue_keys.c      |  3 +-
>>   5 files changed, 39 insertions(+), 9 deletions(-)
>>
>> diff --git a/security/integrity/ima/ima.h b/security/integrity/ima/ima.h
>> index e5622ce8cbb1..fa3044a7539f 100644
>> --- a/security/integrity/ima/ima.h
>> +++ b/security/integrity/ima/ima.h
>> @@ -268,7 +268,8 @@ void ima_store_measurement(struct integrity_iint_cache *iint, struct file *file,
>>   			   struct ima_template_desc *template_desc);
>>   void process_buffer_measurement(struct inode *inode, const void *buf, int size,
>>   				const char *eventname, enum ima_hooks func,
>> -				int pcr, const char *func_data);
>> +				int pcr, const char *func_data,
>> +				bool measure_buf_hash);
> 
> Please abbreviate the boolean name to "hash".   The test would then be
> "if (hash == true)" or "if (hash)".
> 
Will do.
>>   void ima_audit_measurement(struct integrity_iint_cache *iint,
>>   			   const unsigned char *filename);
>>   int ima_alloc_init_template(struct ima_event_data *event_data,
>> diff --git a/security/integrity/ima/ima_appraise.c b/security/integrity/ima/ima_appraise.c
>> index 8361941ee0a1..46ffa38bab12 100644
>> --- a/security/integrity/ima/ima_appraise.c
>> +++ b/security/integrity/ima/ima_appraise.c
>> @@ -352,7 +352,7 @@ int ima_check_blacklist(struct integrity_iint_cache *iint,
>>   		if ((rc == -EPERM) && (iint->flags & IMA_MEASURE))
>>   			process_buffer_measurement(NULL, digest, digestsize,
>>   						   "blacklisted-hash", NONE,
>> -						   pcr, NULL);
>> +						   pcr, NULL, false);
>>   	}
>>   
>>   	return rc;
>> diff --git a/security/integrity/ima/ima_asymmetric_keys.c b/security/integrity/ima/ima_asymmetric_keys.c
>> index 1c68c500c26f..a74095793936 100644
>> --- a/security/integrity/ima/ima_asymmetric_keys.c
>> +++ b/security/integrity/ima/ima_asymmetric_keys.c
>> @@ -60,5 +60,5 @@ void ima_post_key_create_or_update(struct key *keyring, struct key *key,
>>   	 */
>>   	process_buffer_measurement(NULL, payload, payload_len,
>>   				   keyring->description, KEY_CHECK, 0,
>> -				   keyring->description);
>> +				   keyring->description, false);
>>   }
>> diff --git a/security/integrity/ima/ima_main.c b/security/integrity/ima/ima_main.c
>> index e76ef4bfd0f4..0f8409d77602 100644
>> --- a/security/integrity/ima/ima_main.c
>> +++ b/security/integrity/ima/ima_main.c
>> @@ -779,7 +779,7 @@ int ima_post_load_data(char *buf, loff_t size,
>>   }
>>   
>>   /*
>> - * process_buffer_measurement - Measure the buffer to ima log.
>> + * process_buffer_measurement - Measure the buffer or the buffer data hash
>>    * @inode: inode associated with the object being measured (NULL for KEY_CHECK)
>>    * @buf: pointer to the buffer that needs to be added to the log.
>>    * @size: size of buffer(in bytes).
>> @@ -787,12 +787,23 @@ int ima_post_load_data(char *buf, loff_t size,
>>    * @func: IMA hook
>>    * @pcr: pcr to extend the measurement
>>    * @func_data: private data specific to @func, can be NULL.
>> + * @measure_buf_hash: measure buffer hash
> 
> ^@hash: measure buffer data hash
> 
Agreed. Will fix.
>>    *
>> - * Based on policy, the buffer is measured into the ima log.
>> + * Measure the buffer into the IMA log, and extend the @pcr.
> 
> IMA always measures/appraises files and measures buffer data based on
> policy.  The above sentence succintly summarizes what
> process_buffer_measurement() does.   This patch adds support for
> measuring the "buffer data hash".   The following would be an
> appropriate change.
> 
> * Based on policy, either the buffer data or buffer data hash is
> measured
> 
Sounds good. Will update.
>> + *
>> + * Determine what buffers are allowed to be measured, based on the policy rules
>> + * and the IMA hook passed using @func.
>> + *
>> + * Use @func_data, if provided, to match against the measurement policy rule
>> + * data for @func.
>> + *
>> + * If @measure_buf_hash is set to true - measure hash of the buffer data,
>> + * else measure the buffer data itself.
> 
> This patch should be limited to adding "buffer data hash" support.
> These changes don't belong in this patch.  Please remove.
> 
Agreed. Will remove.
>>    */
>>   void process_buffer_measurement(struct inode *inode, const void *buf, int size,
>>   				const char *eventname, enum ima_hooks func,
>> -				int pcr, const char *func_data)
>> +				int pcr, const char *func_data,
>> +				bool measure_buf_hash)
>>   {
>>   	int ret = 0;
>>   	const char *audit_cause = "ENOMEM";
>> @@ -807,6 +818,8 @@ void process_buffer_measurement(struct inode *inode, const void *buf, int size,
>>   		struct ima_digest_data hdr;
>>   		char digest[IMA_MAX_DIGEST_SIZE];
>>   	} hash = {};
>> +	char buf_hash[IMA_MAX_DIGEST_SIZE];
>> +	int buf_hash_len = hash_digest_size[ima_hash_algo];
>>   	int violation = 0;
>>   	int action = 0;
>>   	u32 secid;
>> @@ -849,13 +862,27 @@ void process_buffer_measurement(struct inode *inode, const void *buf, int size,
>>   		goto out;
>>   	}
>>   
>> +	if (measure_buf_hash) {
> 
> ^ if (hash) {
Yes.
>> +		memcpy(buf_hash, hash.hdr.digest, buf_hash_len);
>> +
>> +		ret = ima_calc_buffer_hash(buf_hash, buf_hash_len,
>> +					   iint.ima_hash);
>> +		if (ret < 0) {
>> +			audit_cause = "measure_buf_hash_error";
> 
> I don't see a good no reason for defining a new audit cause.  Use the
> existing "hashing_error".
> 
> thanks,
> 
> Mimi
> 

Thanks,
Tushar
>> +			goto out;
>> +		}
>> +
>> +		event_data.buf = buf_hash;
>> +		event_data.buf_len = buf_hash_len;
>> +	}
>> +
>>   	ret = ima_alloc_init_template(&event_data, &entry, template);
>>   	if (ret < 0) {
>>   		audit_cause = "alloc_entry";
>>   		goto out;
>>   	}
>>   
>> -	ret = ima_store_template(entry, violation, NULL, buf, pcr);
>> +	ret = ima_store_template(entry, violation, NULL, event_data.buf, pcr);
>>   	if (ret < 0) {
>>   		audit_cause = "store_entry";
>>   		ima_free_template_entry(entry);
>> @@ -890,7 +917,8 @@ void ima_kexec_cmdline(int kernel_fd, const void *buf, int size)
>>   		return;
>>   
>>   	process_buffer_measurement(file_inode(f.file), buf, size,
>> -				   "kexec-cmdline", KEXEC_CMDLINE, 0, NULL);
>> +				   "kexec-cmdline", KEXEC_CMDLINE, 0, NULL,
>> +				   false);
>>   	fdput(f);
>>   }
>>   
>> diff --git a/security/integrity/ima/ima_queue_keys.c b/security/integrity/ima/ima_queue_keys.c
>> index 69a8626a35c0..c2f2ad34f9b7 100644
>> --- a/security/integrity/ima/ima_queue_keys.c
>> +++ b/security/integrity/ima/ima_queue_keys.c
>> @@ -162,7 +162,8 @@ void ima_process_queued_keys(void)
>>   						   entry->payload_len,
>>   						   entry->keyring_name,
>>   						   KEY_CHECK, 0,
>> -						   entry->keyring_name);
>> +						   entry->keyring_name,
>> +						   false);
>>   		list_del(&entry->list);
>>   		ima_free_key_entry(entry);
>>   	}
> 
