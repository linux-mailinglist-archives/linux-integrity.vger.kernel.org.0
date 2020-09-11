Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 565F12664BB
	for <lists+linux-integrity@lfdr.de>; Fri, 11 Sep 2020 18:45:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725851AbgIKQpN (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 11 Sep 2020 12:45:13 -0400
Received: from linux.microsoft.com ([13.77.154.182]:34266 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726456AbgIKQpD (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 11 Sep 2020 12:45:03 -0400
Received: from [192.168.86.21] (c-71-197-163-6.hsd1.wa.comcast.net [71.197.163.6])
        by linux.microsoft.com (Postfix) with ESMTPSA id 955D820716FC;
        Fri, 11 Sep 2020 09:44:57 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 955D820716FC
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1599842698;
        bh=gUgZlvI7DrDjGZFf44Vxy3S7MO/Bh6is8wlbtbN++JI=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=KhjO3g9XgCN1StTC8gEIDZ9q1vanpS1N5gzlJBhXdjraAawoMc1QD8CpdbbG9iUei
         D208weHnfgrxqfq0FzSPHSb6XXxC12bumrdbj9oLuxBUC79lIc7W5d2Gt28Bqv1wOt
         eTcNAtP3r0/DVsSWa/WT2wzgjURxo8n4mUcekG0Y=
Subject: Re: [PATCH v3 3/6] IMA: update process_buffer_measurement to measure
 buffer hash
To:     Mimi Zohar <zohar@linux.ibm.com>, stephen.smalley.work@gmail.com,
        casey@schaufler-ca.com, agk@redhat.com, snitzer@redhat.com,
        gmazyland@gmail.com
Cc:     tyhicks@linux.microsoft.com, sashal@kernel.org, jmorris@namei.org,
        nramas@linux.microsoft.com, linux-integrity@vger.kernel.org,
        selinux@vger.kernel.org, linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, dm-devel@redhat.com
References: <20200828015704.6629-1-tusharsu@linux.microsoft.com>
 <20200828015704.6629-4-tusharsu@linux.microsoft.com>
 <f11dbfc1382e60c04fdd519ce5122239fa0cab8b.camel@linux.ibm.com>
From:   Tushar Sugandhi <tusharsu@linux.microsoft.com>
Message-ID: <c932ae94-d7c3-5d23-2bb4-95517f712ceb@linux.microsoft.com>
Date:   Fri, 11 Sep 2020 09:44:57 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <f11dbfc1382e60c04fdd519ce5122239fa0cab8b.camel@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org



On 2020-08-31 10:02 a.m., Mimi Zohar wrote:
> On Thu, 2020-08-27 at 18:57 -0700, Tushar Sugandhi wrote:
>> process_buffer_measurement() currently only measures the input buffer.
>> When the buffer being measured is too large, it may result in bloated
>> IMA logs.
> 
> The subject of  this sentence refers to an individual record, while
> "bloated" refers to the measurement list.  A "bloated" measurement list
> would contain too many or unnecessary records.  Your concern seems to
> be with the size of the individual record, not the number of
> measurement list entries.
> 
The intent behind that description was twofold. One, as you mentioned,
the individual record size being large; and two, multiple large-sized
individual records will eventually bloat the measurement list too.

It can happen in SeLinux case as we discovered. The SeLinux policy
(which can be a few MBs) can change from 'foo', to 'bar', back to 'foo'.
And the requirement from SeLinux is that 'foo' should be measured the
second time too. When 'foo' and 'bar' are large, the individual records
in the ima log will be large, which will also result in measurement list
being bloated.

But I understand your concern with the current wording. I will update 
the patch description accordingly.

> Measuring the hash of the buffer data is similar to measuring the file
> data.  In the case of the file data, however, the attestation server
> may rely on a white list manifest/DB or the file signature to verify
> the file data hash.  For buffer measurements, how will the attestation
> server ascertain what is a valid buffer hash?
The client and the server implementation will go hand in hand. The
client/kernel would know what data is measured as-is
(e.g. KEXEC_CMDLINE), and what data has it’s hash measured
(e.g. SeLinux Policy). And the attestation server would verify data/hash
accordingly.

Just like the data being measured in other cases, the attestation server 
will know what are possible values of the large buffers being measured. 
It will have to maintain the hash of those buffer values.
> 
> Hint:  I assume, correct me if I'm wrong, the measurement list record
> template data is not meant to be verified, but used to detect if the "critical data" changed.
> 
As mentioned above, the use case for this feature is in-memory loaded 
SeLinux policy, which can be quite large (several MBs) – that's why this 
functionality. The data is meant to be verified by the attestation server.

> Please update the patch description accordingly.
I will update the patch description to clarify all this.
> 
>>
>> Introduce a boolean parameter measure_buf_hash to support measuring
>> hash of a buffer, which would be much smaller, instead of the buffer
>> itself.
>> Signed-off-by: Tushar Sugandhi <tusharsu@linux.microsoft.com>
>> ---
> 
> <snip>
> 
>> +++ b/security/integrity/ima/ima_main.c
>> @@ -733,17 +733,21 @@ int ima_load_data(enum kernel_load_data_id id)
>>    * @func: IMA hook
>>    * @pcr: pcr to extend the measurement
>>    * @func_data: private data specific to @func, can be NULL.
>> + * @measure_buf_hash: if set to true - will measure hash of the buf,
>> + *                    instead of buf
>>    *
>>    * Based on policy, the buffer is measured into the ima log.
>>    */
>>   int process_buffer_measurement(struct inode *inode, const void *buf, int size,
>>   			       const char *eventname, enum ima_hooks func,
>> -			       int pcr, const char *func_data)
>> +			       int pcr, const char *func_data,
>> +			       bool measure_buf_hash)
>>   {
>>   	int ret = 0;
>>   	const char *audit_cause = "ENOMEM";
>>   	struct ima_template_entry *entry = NULL;
>>   	struct integrity_iint_cache iint = {};
>> +	struct integrity_iint_cache digest_iint = {};
>>   	struct ima_event_data event_data = {.iint = &iint,
>>   					    .filename = eventname,
>>   					    .buf = buf,
>> @@ -752,7 +756,7 @@ int process_buffer_measurement(struct inode *inode, const void *buf, int size,
>>   	struct {
>>   		struct ima_digest_data hdr;
>>   		char digest[IMA_MAX_DIGEST_SIZE];
>> -	} hash = {};
>> +	} hash = {}, digest_hash = {};
>>   	int violation = 0;
>>   	int action = 0;
>>   	u32 secid;
>> @@ -801,6 +805,24 @@ int process_buffer_measurement(struct inode *inode, const void *buf, int size,
>>   		goto out;
>>   	}
>>   
>> +	if (measure_buf_hash) {
>> +		digest_iint.ima_hash = &digest_hash.hdr;
>> +		digest_iint.ima_hash->algo = ima_hash_algo;
>> +		digest_iint.ima_hash->length = hash_digest_size[ima_hash_algo];
>> +
>> +		ret = ima_calc_buffer_hash(hash.hdr.digest,
>> +					   iint.ima_hash->length,
>> +					   digest_iint.ima_hash);
>> +		if (ret < 0) {
>> +			audit_cause = "digest_hashing_error";
>> +			goto out;
>> +		}
>> +
>> +		event_data.iint = &digest_iint;
>> +		event_data.buf = hash.hdr.digest;
>> +		event_data.buf_len = iint.ima_hash->length;
>> +	}
>> +
> 
> There seems to be some code and variable duplication by doing it this
> way.  Copying the caluclated buffer data hash to a temporary buffer
> might eliminate it.
> 
With the way ima_calc_buffer_hash() is implemented, I was convinced that
the variable duplication was needed. I didn't want to write a helper 
function in order to minimize the unnecessary code churn in p_b_m().
But I will revisit this to see how I can reduce the code and variable 
duplication.

Thanks for the feedback.
>>   	ret = ima_alloc_init_template(&event_data, &entry, template);
>>   	if (ret < 0) {
>>   		audit_cause = "alloc_entry";
