Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 62E72267645
	for <lists+linux-integrity@lfdr.de>; Sat, 12 Sep 2020 01:00:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725902AbgIKXAG (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 11 Sep 2020 19:00:06 -0400
Received: from linux.microsoft.com ([13.77.154.182]:52670 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725849AbgIKW77 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 11 Sep 2020 18:59:59 -0400
Received: from [192.168.86.21] (c-71-197-163-6.hsd1.wa.comcast.net [71.197.163.6])
        by linux.microsoft.com (Postfix) with ESMTPSA id 48C492071703;
        Fri, 11 Sep 2020 15:59:56 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 48C492071703
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1599865196;
        bh=3mB/+NIQZm9nLRVP6Hg0ImDbHIMG6AfKoHkA/Vjy4a8=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=E2hVZKMn+VKxUHDGOCQY/9tBMYhF4eVsqI0EvdruSyOQxubshGBnS69DJ7TeQ7Cu7
         LoSQ+gJzX6cKsG7djAtpkApJMYt60tZ2XsfZABtzr7uZ4KIojwBu2pmH/c/eU89Yxx
         so+o1+5t1fChjuj+2EgIKZ0kNUUkQBJWHMZglFno=
Subject: Re: [PATCH v3 2/2] dm-crypt: collect data and submit to DM to measure
To:     Milan Broz <gmazyland@gmail.com>, zohar@linux.ibm.com,
        agk@redhat.com, snitzer@redhat.com
Cc:     tyhicks@linux.microsoft.com, sashal@kernel.org, jmorris@namei.org,
        nramas@linux.microsoft.com, linux-integrity@vger.kernel.org,
        linux-kernel@vger.kernel.org, dm-devel@redhat.com
References: <20200828202700.23086-1-tusharsu@linux.microsoft.com>
 <20200828202700.23086-3-tusharsu@linux.microsoft.com>
 <02daeaf7-aefc-448a-a6b3-ab22fe054224@gmail.com>
From:   Tushar Sugandhi <tusharsu@linux.microsoft.com>
Message-ID: <ff8c22a3-abe2-2021-f577-f2742a7540cb@linux.microsoft.com>
Date:   Fri, 11 Sep 2020 15:59:55 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <02daeaf7-aefc-448a-a6b3-ab22fe054224@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Thanks for taking a look at this patch Milan.
Appreciate it.

Sorry for responding late. I was on vacation last week.

My responses below.

On 2020-08-31 3:54 a.m., Milan Broz wrote:
> On 28/08/2020 22:27, Tushar Sugandhi wrote:
>> Currently, dm-crypt does not take advantage of IMA measuring
>> capabilities, and ultimately the benefits of remote attestation.
>>
>> Measure various dm-crypt constructs by calling various device-mapper
>> functions - dm_ima_*() that use IMA measuring capabilities. Implement
>> ima_measure_dm_crypt_data() to measure various dm-crypt constructs.
>>
>> Ensure that ima_measure_dm_crypt_data() is non intrusive, i.e. failures
>> in this function and the call-stack below should not affect the core
>> functionality of dm-crypt.
> 
> Just my opinion, but I really do not like to add every relevant DM table option
> as a harcoded value here. (But maybe it is necessary, dunno).
> 
> Why you cannot measure the whole device-mapper table as a string?
> (output of STATUSTYPE_TABLE).
> But it has own problems, like table can contain key etc.
> 
Correct. That’s one of the reasons why we don’t want to measure
the whole device mapper table. We don’t want the keys to leave the
device – even for IMA measurements/attestation.

Here is the list of problems, that I can think of, with measuring the 
whole device mapper table:

     1. The table may not output all the important attributes that we
        want to measure, for all the targets we are interested in. (e.g.
        for crypt it doesn’t output many of the integrity/bio attributes
        from crypt_config)

     2. The targets may output sensitive information to the table that
        should not leave the device, even in case of measurement/
        attestation.
        (crypt has keys, other targets may have similar sensitive
        information)

     3. The order of entries in the table maybe different on each
        activation, and not all the entries will be present on each
        activation. The entries may come and go, based on policy
        changes and/or devices getting added/removed from the system.
        This would generate at least 2^n different hashes (where n is the
        number of entries in the table). And attestation server will have
        to keep track of all these permutations. With each entry measured
        separately, the possible hashes that the attestation server needs
        to keep track of will grow more linearly with the number of
        entries, and not exponentially.

     4. With bulk measuring of entire table, we are not giving sys-admins
        any choice on which targets to measure, and which not to measure.
        With the current approach – they have this choice (using the IMA
        policy I introduced in the patch -
        https://patchwork.kernel.org/patch/11742027/
        and
        https://patchwork.kernel.org/patch/11742035/

     5. The table would contain the targets that we don’t care about for
        IMA measurements. Measuring the whole table will simply pollute
        the data unnecessarily.

> Anyway with the above, the whole measurement can reside in DM core (I hope).
> 
Could you please provide more info – where in DM core? Currently, I have
implemented the functionality to be generic enough to measure any dm
target (not just dm-crypt). It is present in the new module dm-ima.c
which only gets applied when CONFIG_IMA=y. See patch 1/2 of this series.
or https://patchwork.kernel.org/patch/11743713/

> But there are some problems - we can activate device with optional flags
> (for example allow_discards) - should this be IMA measurement?
> 
allow_discards translates to ti->num_discard_bios. And I am already 
measuring it. But thanks for validating the need to measure it.

static int crypt_ctr_optional(...)
{
<snip>
		if (!strcasecmp(opt_string, "allow_discards"))
			ti->num_discard_bios = 1;

...

static void ima_measure_dm_crypt_data(...)
{
<snip>
r = ima_append_num_values(ti, "ti_num_discard_bios",
                               ti->num_discard_bios);

> And what about device size (you already measure offset)?
> 
Ok. I will measure device size. I will try and find where device size 
attribute is. But if you could point me to it, that would really help.

> IMO it depends on situation (policy).
> 
Do you mean I should conditionally measure the attributes based on some 
policy?
Wouldn’t that be too much granularity?

Or do you mean something else?

I have already introduced a new IMA policy in the patches below, that
can help admins choose which DM targets to measure. I believe further
granularity is not needed, and may pose security risks.
https://patchwork.kernel.org/patch/11742027/
and
https://patchwork.kernel.org/patch/11742035/

> It is quite often that we add performance flags later (like these no_workqueue in 5.9).
> Some of them should be measured because there is possible security/data integrity impact.
> 
The optional parameters like no_read_workqueue, no_write_workqueue, 
same_cpu_crypt, submit_from_crypt_cpus, are part of cc->flags. And I am 
already measuring cc->flags.

Please let me know if I missed any other important parameters, and I 
will be happy to measure those. (my series is based on 5.9.0-rc2 in IMA
repo, but its possible that I have missed any new attributes in the dm
repos that are not upstreamed to the main repo)

static int crypt_ctr_optional(...)
{
<snip>
		else if (!strcasecmp(opt_string, "same_cpu_crypt"))
			set_bit(DM_CRYPT_SAME_CPU, &cc->flags);

		else if (!strcasecmp(opt_string, "submit_from_crypt_cpus"))
			set_bit(DM_CRYPT_NO_OFFLOAD, &cc->flags);
		else if (!strcasecmp(opt_string, "no_read_workqueue"))
			set_bit(DM_CRYPT_NO_READ_WORKQUEUE, &cc->flags);
		else if (!strcasecmp(opt_string, "no_write_workqueue"))
			set_bit(DM_CRYPT_NO_WRITE_WORKQUEUE, &cc->flags);

...
static void ima_measure_dm_crypt_data(...)
{
<snip>
	r = ima_append_num_values(ti, "flags", cc->flags);	

> And one note - input table accepts also a device path, but output of table is always
> major:minor, see:
> 
> # dmsetup create test --table "0 2097152 crypt aes-cbc-essiv:sha256 9c1185a5c5e9fc54612808977ee8f548b2258d31ddadef707ba62c166051b9e3 0 /dev/sdg 0"
> # dmsetup table test --showkeys
> 0 2097152 crypt aes-cbc-essiv:sha256 9c1185a5c5e9fc54612808977ee8f548b2258d31ddadef707ba62c166051b9e3 0 8:96 0
> 
> I think dm_table_device_name() should work here (as you use it), but major number can change
> on different activations (in general) later, isn't it problem here?
> (Like dynamic major for DM devices that depends on module sequence load.)
> 
> Milan
> 
Good point. I thought about using the device path instead of
major:minor. But major:minor seemed the standard way of referring to the
device name in dm code, so I used that instead of device path.

Do you think device path is more apt to use in the IMA measurement context?

If so, do you know a standard way of getting device path from 
major:minor? I will also try to find it myself.

~Tushar
>>
>> Register dm-crypt as supported data source for IMA measurement in ima.h.
>>
>> A demonstrative usage of above functionality on a system:
>>
>> If the IMA policy contains the following rule:
>>
>>      measure func=CRITICAL_DATA critical_kernel_data_sources=dm-crypt template=ima-buf
>>
>> and, the following commands are used to setup a crypt target:
>>
>>   #key="faf453b4ee938cff2f0d2c869a0b743f59125c0a37f5bcd8f1dbbd911a78abaa"
>>   #arg="'0 1953125 crypt aes-xts-plain64 "
>>   #arg="$arg $key 0 "
>>   #arg="$arg /dev/loop0 0 1 allow_discards'"
>>   #tgt_name="test-crypt"
>>   #cmd="dmsetup create $tgt_name --table $arg"
>>   #eval $cmd
>>
>> then, the IMA log at
>> /sys/kernel/security/integrity/ima/ascii_runtime_measurements should
>> contain the dm-crypt measurements. And, the following IMA log entry
>> should be added in the IMA log,
>>
>>   ima-buf sha1:039d8ff71918608d585adca3e5aab2e3f41f84d6
>>   1598637500:520585536:dm-crypt:add_target
>>   74695f6e756d5f646973636172645f62696f733d313b7065725f62696f5f646
>>   174615f73697a653d3834383b646d7265715f73746172743d3136383b74666d
>>   735f636f756e743d313b6f6e5f6469736b5f7461675f73697a653d303b696e7
>>   46567726974795f69765f73697a653d303b696e746567726974795f7461675f
>>   73697a653d303b69765f73697a653d31363b69765f6f66667365743d303b736
>>   563746f725f73686966743d303b736563746f725f73697a653d3531323b666c
>>   6167733d323b6369706865725f666c6167733d303b73746172743d303b6b657
>>   95f6d61635f73697a653d303b6b65795f65787472615f73697a653d303b6b65
>>   795f70617274733d313b6b65795f73697a653d33323b6369706865725f73747
>>   2696e673d6165732d7874732d706c61696e36343b6465766963655f6e616d65
>>   3d3235333a303b
>>
>> where, the ascii representation of the above data is:
>>
>>   ti_num_discard_bios=1;per_bio_data_size=848;dmreq_start=168;
>>   tfms_count=1;on_disk_tag_size=0;integrity_iv_size=0;
>>   integrity_tag_size=0;iv_size=16;iv_offset=0;sector_shift=0;
>>   sector_size=512;flags=2;cipher_flags=0;start=0;key_mac_size=0;
>>   key_extra_size=0;key_parts=1;key_size=32;
>>   cipher_string=aes-xts-plain64;device_name=253:0;
>>
>> Some of the above values can be verified using:
>>
>>   #dmsetup table --showkeys
>>
>> where, the output of the command should be similar to:
>>
>>   test-crypt: 0 1953125 crypt aes-xts-plain64
>>   faf453b4ee938cff2f0d2c869a0b743f59125c0a37f5bcd8f1dbbd911a78abaa
>>   0 7:0 0 1 allow_discards
>>
>> Signed-off-by: Tushar Sugandhi <tusharsu@linux.microsoft.com>
>> ---
>>   drivers/md/dm-crypt.c          | 171 +++++++++++++++++++++++++++++++++
>>   security/integrity/ima/Kconfig |   3 +-
>>   security/integrity/ima/ima.h   |   1 +
>>   3 files changed, 173 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/md/dm-crypt.c b/drivers/md/dm-crypt.c
>> index 148960721254..47fb2ce15211 100644
>> --- a/drivers/md/dm-crypt.c
>> +++ b/drivers/md/dm-crypt.c
>> @@ -2529,6 +2529,8 @@ static void crypt_dtr(struct dm_target *ti)
>>   
>>   	ti->private = NULL;
>>   
>> +	dm_ima_exit_measurements(ti->type);
>> +
>>   	if (!cc)
>>   		return;
>>   
>> @@ -2991,6 +2993,167 @@ static int crypt_report_zones(struct dm_target *ti,
>>   
>>   #endif
>>   
>> +#ifdef CONFIG_IMA
>> +/*
>> + * append integer values to dm-crypt specific data
>> + * to be measured through IMA
>> + */
>> +static int ima_append_num_values(struct dm_target *ti,
>> +				 const char *key,
>> +				 long long num_val)
>> +{
>> +	char *num_str = NULL;
>> +	int length = 0;
>> +	int r = 0;
>> +
>> +	if (!ti || !key) {
>> +		r = -EINVAL;
>> +		goto error;
>> +	}
>> +
>> +	length = snprintf(NULL, 0, "%lld", num_val);
>> +	num_str = kzalloc(length + 1, GFP_KERNEL);
>> +	if (!num_str) {
>> +		r = -ENOMEM;
>> +		goto error;
>> +	}
>> +	snprintf(num_str, length + 1, "%lld", num_val);
>> +	dm_ima_append_measurement_list(ti->type,
>> +				       key,
>> +				       (const void *)num_str,
>> +				       length);
>> +	kzfree(num_str);
>> +	return r;
>> +error:
>> +	DMERR("appending num values to IMA measurement list failed %d", r);
>> +	return r;
>> +}
>> +/*
>> + * Measure dm-crypt specific data through IMA.
>> + * It appends all the needed data to the list as a key-val pair using
>> + * dm_ima_append_measurement_list() and internal ima_append_num_values(),
>> + * and finally measures the list using dm_ima_finalize_and_measure().
>> + */
>> +static void ima_measure_dm_crypt_data(struct dm_target *ti, const char *desc)
>> +{
>> +	int r = 0;
>> +	struct crypt_config *cc = NULL;
>> +	const char *devname = dm_table_device_name(ti->table);
>> +
>> +	if (!ti) {
>> +		r = -EINVAL;
>> +		goto out;
>> +	}
>> +
>> +	cc = ti->private;
>> +
>> +	if (devname) {
>> +		dm_ima_append_measurement_list(ti->type,
>> +					       "device_name",
>> +					       (const void *)devname,
>> +					       strlen(devname));
>> +	}
>> +
>> +	if (cc->cipher_string) {
>> +		dm_ima_append_measurement_list(ti->type,
>> +					       "cipher_string",
>> +					       (const void *)cc->cipher_string,
>> +					       strlen(cc->cipher_string));
>> +	}
>> +
>> +	if (cc->cipher_auth) {
>> +		dm_ima_append_measurement_list(ti->type,
>> +					       "cipher_auth",
>> +					       (const void *)cc->cipher_auth,
>> +					       strlen(cc->cipher_auth));
>> +	}
>> +
>> +	r = ima_append_num_values(ti, "key_size", cc->key_size);
>> +	if (r)
>> +		goto out;
>> +
>> +	r = ima_append_num_values(ti, "key_parts", cc->key_parts);
>> +	if (r)
>> +		goto out;
>> +
>> +	r = ima_append_num_values(ti, "key_extra_size", cc->key_extra_size);
>> +	if (r)
>> +		goto out;
>> +
>> +	r = ima_append_num_values(ti, "key_mac_size", cc->key_mac_size);
>> +	if (r)
>> +		goto out;
>> +
>> +	r = ima_append_num_values(ti, "start", cc->start);
>> +	if (r)
>> +		goto out;
>> +
>> +	r = ima_append_num_values(ti, "cipher_flags", cc->cipher_flags);
>> +	if (r)
>> +		goto out;
>> +
>> +	r = ima_append_num_values(ti, "flags", cc->flags);
>> +	if (r)
>> +		goto out;
>> +
>> +	r = ima_append_num_values(ti, "sector_size", cc->sector_size);
>> +	if (r)
>> +		goto out;
>> +
>> +	r = ima_append_num_values(ti, "sector_shift", cc->sector_shift);
>> +	if (r)
>> +		goto out;
>> +
>> +	r = ima_append_num_values(ti, "iv_offset", cc->iv_offset);
>> +	if (r)
>> +		goto out;
>> +
>> +	r = ima_append_num_values(ti, "iv_size", cc->iv_size);
>> +	if (r)
>> +		goto out;
>> +
>> +	r = ima_append_num_values(ti, "integrity_tag_size", cc->integrity_tag_size);
>> +	if (r)
>> +		goto out;
>> +
>> +	r = ima_append_num_values(ti, "integrity_iv_size", cc->integrity_iv_size);
>> +	if (r)
>> +		goto out;
>> +
>> +	r = ima_append_num_values(ti, "on_disk_tag_size", cc->on_disk_tag_size);
>> +	if (r)
>> +		goto out;
>> +
>> +	r = ima_append_num_values(ti, "tfms_count", cc->tfms_count);
>> +	if (r)
>> +		goto out;
>> +
>> +	r = ima_append_num_values(ti, "dmreq_start", cc->dmreq_start);
>> +	if (r)
>> +		goto out;
>> +
>> +	r = ima_append_num_values(ti, "per_bio_data_size", cc->per_bio_data_size);
>> +	if (r)
>> +		goto out;
>> +
>> +	r = ima_append_num_values(ti, "ti_num_discard_bios",
>> +			      ti->num_discard_bios);
>> +	if (r)
>> +		goto out;
>> +
>> +	dm_ima_finalize_and_measure(ti->type, desc, false);
>> +	return;
>> +
>> +out:
>> +	DMERR("IMA measurement of dm-crypt data failed %d", r);
>> +
>> +}
>> +#else
>> +static inline void ima_measure_dm_crypt_data(struct dm_target *ti,
>> +					     const char *desc) {}
>> +#endif /* CONFIG_IMA */
>> +
>> +
>>   /*
>>    * Construct an encryption mapping:
>>    * <cipher> [<key>|:<key_size>:<user|logon>:<key_description>] <iv_offset> <dev_path> <start>
>> @@ -3186,6 +3349,10 @@ static int crypt_ctr(struct dm_target *ti, unsigned int argc, char **argv)
>>   
>>   	ti->num_flush_bios = 1;
>>   
>> +	dm_ima_init_measurements(ti->type);
>> +
>> +	ima_measure_dm_crypt_data(ti, "add_target");
>> +
>>   	return 0;
>>   
>>   bad:
>> @@ -3324,6 +3491,8 @@ static void crypt_postsuspend(struct dm_target *ti)
>>   	struct crypt_config *cc = ti->private;
>>   
>>   	set_bit(DM_CRYPT_SUSPENDED, &cc->flags);
>> +
>> +	ima_measure_dm_crypt_data(ti, "post_suspend");
>>   }
>>   
>>   static int crypt_preresume(struct dm_target *ti)
>> @@ -3343,6 +3512,8 @@ static void crypt_resume(struct dm_target *ti)
>>   	struct crypt_config *cc = ti->private;
>>   
>>   	clear_bit(DM_CRYPT_SUSPENDED, &cc->flags);
>> +
>> +	ima_measure_dm_crypt_data(ti, "resume");
>>   }
>>   
>>   /* Message interface
>> diff --git a/security/integrity/ima/Kconfig b/security/integrity/ima/Kconfig
>> index 953314d145bb..ad643cc5aad4 100644
>> --- a/security/integrity/ima/Kconfig
>> +++ b/security/integrity/ima/Kconfig
>> @@ -324,8 +324,7 @@ config IMA_MEASURE_ASYMMETRIC_KEYS
>>   
>>   config IMA_QUEUE_EARLY_BOOT_DATA
>>   	bool
>> -	depends on IMA_MEASURE_ASYMMETRIC_KEYS
>> -	depends on SYSTEM_TRUSTED_KEYRING
>> +        depends on (IMA_MEASURE_ASYMMETRIC_KEYS && SYSTEM_TRUSTED_KEYRING) || DM_CRYPT
>>   	default y
>>   
>>   config IMA_SECURE_AND_OR_TRUSTED_BOOT
>> diff --git a/security/integrity/ima/ima.h b/security/integrity/ima/ima.h
>> index 422fe833037d..bc922aa2ff92 100644
>> --- a/security/integrity/ima/ima.h
>> +++ b/security/integrity/ima/ima.h
>> @@ -230,6 +230,7 @@ struct modsig;
>>   
>>   #define __ima_supported_kernel_data_sources(source)	\
>>   	source(MIN_SOURCE, min_source)			\
>> +	source(DM_CRYPT, dm-crypt)			\
>>   	source(MAX_SOURCE, max_source)
>>   
>>   #define __ima_enum_stringify(ENUM, str) (#str),
>>
