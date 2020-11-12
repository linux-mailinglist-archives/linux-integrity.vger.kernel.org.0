Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 85CB02B109F
	for <lists+linux-integrity@lfdr.de>; Thu, 12 Nov 2020 22:49:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727384AbgKLVs4 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 12 Nov 2020 16:48:56 -0500
Received: from linux.microsoft.com ([13.77.154.182]:53680 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727362AbgKLVsz (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 12 Nov 2020 16:48:55 -0500
Received: from [192.168.86.31] (c-71-197-163-6.hsd1.wa.comcast.net [71.197.163.6])
        by linux.microsoft.com (Postfix) with ESMTPSA id 4CDCA20C2872;
        Thu, 12 Nov 2020 13:48:54 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 4CDCA20C2872
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1605217734;
        bh=gj7I7H7R+K+HUdjzOSyTXtGvFpPPfgwXVjL9OcdcHEo=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=RBiN6mtpwxcu9Z+PR5cU/KcnnExclGovD66+hhEb4gPSium3dfPvzhtaGPdEUjbzY
         2JO6951UPvYg7t/EaqmVMnYF8N3jfjC5/eumKdaTxoyUhw96E2kxbbH2yVIXDr1XPZ
         tvV2Bs9ArFN0/wjQ9AKGSGKFMCiqdW10LeVV9ipo=
Subject: Re: [PATCH v5 2/7] IMA: update process_buffer_measurement to measure
 buffer hash
To:     Mimi Zohar <zohar@linux.ibm.com>, stephen.smalley.work@gmail.com,
        casey@schaufler-ca.com, agk@redhat.com, snitzer@redhat.com,
        gmazyland@gmail.com, paul@paul-moore.com
Cc:     tyhicks@linux.microsoft.com, sashal@kernel.org, jmorris@namei.org,
        nramas@linux.microsoft.com, linux-integrity@vger.kernel.org,
        selinux@vger.kernel.org, linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, dm-devel@redhat.com
References: <20201101222626.6111-1-tusharsu@linux.microsoft.com>
 <20201101222626.6111-3-tusharsu@linux.microsoft.com>
 <811fbc4a6f4bd02c77518bd4196d354071145f3e.camel@linux.ibm.com>
From:   Tushar Sugandhi <tusharsu@linux.microsoft.com>
Message-ID: <702e7d17-27f0-30e7-b5ce-affecb0c8de7@linux.microsoft.com>
Date:   Thu, 12 Nov 2020 13:48:53 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <811fbc4a6f4bd02c77518bd4196d354071145f3e.camel@linux.ibm.com>
Content-Type: text/plain; charset=iso-8859-15; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org



On 2020-11-06 4:11 a.m., Mimi Zohar wrote:
> Hi Tushar,
> 
> Below inline are a few additional comments.
> 
>> diff --git a/security/integrity/ima/ima_main.c b/security/integrity/ima/ima_main.c
>> index ae5da9f3339d..4485d87c0aa5 100644
>> --- a/security/integrity/ima/ima_main.c
>> +++ b/security/integrity/ima/ima_main.c
>> @@ -787,12 +787,15 @@ int ima_post_load_data(char *buf, loff_t size,
>>    * @func: IMA hook
>>    * @pcr: pcr to extend the measurement
>>    * @func_data: private data specific to @func, can be NULL.
>> + * @measure_buf_hash: if set to true - will measure hash of the buf,
>> + *                    instead of buf
>>    *
>>    * Based on policy, the buffer is measured into the ima log.
> 
> Both the brief and longer function descriptions need to be updated, as
> well as the last argument description.  The last argument should be
> limited to "measure buffer hash".  How it is used could be included in
> the longer function description.  The longer function description would
> include adding the buffer data or the buffer data hash to the IMA
> measurement list and extending the PCR.
> 
> For example,
> process_buffer_measurement - measure the buffer data or the buffer data
> hash
> 
Thanks Mimi. Will update the brief and longer descriptions accordingly.
> 
>>    */
>>   void process_buffer_measurement(struct inode *inode, const void *buf, int size,
>>   				const char *eventname, enum ima_hooks func,
>> -				int pcr, const char *func_data)
>> +				int pcr, const char *func_data,
>> +				bool measure_buf_hash)
>>   {
>>   	int ret = 0;
>>   	const char *audit_cause = "ENOMEM";
>> @@ -807,6 +810,8 @@ void process_buffer_measurement(struct inode *inode, const void *buf, int size,
>>   		struct ima_digest_data hdr;
>>   		char digest[IMA_MAX_DIGEST_SIZE];
>>   	} hash = {};
>> +	char digest_hash[IMA_MAX_DIGEST_SIZE];
>> +	int hash_len = hash_digest_size[ima_hash_algo];
>>   	int violation = 0;
>>   	int action = 0;
>>   	u32 secid;
>> @@ -855,6 +860,21 @@ void process_buffer_measurement(struct inode *inode, const void *buf, int size,
>>   		goto out;
>>   	}
>>   
>> +	if (measure_buf_hash) {
>> +		memcpy(digest_hash, hash.hdr.digest, hash_len);
> 
> Instead of digest_hash and hash_len, consider naming the variables
> buf_hash and buf_hashlen.
> 
Thanks. Will do.
>> +
>> +		ret = ima_calc_buffer_hash(digest_hash,
>> +					   hash_len,
>> +					   iint.ima_hash);
> 
> There's no need for each variable to be on a separate line.
> 
Thanks, will fix.
~Tushar

> thanks,
> 
> Mimi
> 
>> +		if (ret < 0) {
>> +			audit_cause = "measure_buf_hash_error";
>> +			goto out;
>> +		}
>> +
>> +		event_data.buf = digest_hash;
>> +		event_data.buf_len = hash_len;
>> +	}
>> +
>>   	ret = ima_alloc_init_template(&event_data, &entry, template);
>>   	if (ret < 0) {
>>   		audit_cause = "alloc_entry";
