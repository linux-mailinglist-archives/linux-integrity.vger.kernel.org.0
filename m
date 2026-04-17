Return-Path: <linux-integrity+bounces-9226-lists+linux-integrity=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-integrity@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wPT/NqKl4mlV8gAAu9opvQ
	(envelope-from <linux-integrity+bounces-9226-lists+linux-integrity=lfdr.de@vger.kernel.org>)
	for <lists+linux-integrity@lfdr.de>; Fri, 17 Apr 2026 23:26:58 +0200
X-Original-To: lists+linux-integrity@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B083041EB19
	for <lists+linux-integrity@lfdr.de>; Fri, 17 Apr 2026 23:26:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 0F8E33014BAE
	for <lists+linux-integrity@lfdr.de>; Fri, 17 Apr 2026 21:26:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E0E233F394;
	Fri, 17 Apr 2026 21:26:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="Y6Lq7TVG"
X-Original-To: linux-integrity@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CBF729827E;
	Fri, 17 Apr 2026 21:26:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776461213; cv=none; b=SpMkm9S0UpMBa9FwIKBvX2vSBoSfFUx1M+nQ7ociJGHXUIzhUeBkvueN89iKq/9hyXbOrVFnFXhgjFH57jdDfx8hGhqL3HPbVgAqGF1istyRzRRAEGf1MESdFuLD3YCL+lGNtSLHA2MwBE3dpA6aXNPCirtrVIuE5xJU5WV1TwY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776461213; c=relaxed/simple;
	bh=FIH0/6DHEf8EV634HZoZhql2gFFlLYPOCRMS8vVWJHo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GgpUozmyQoqdO3WqC+DSOP96lNHU4zNgaL9qOjQdx4/98OqVmM5bYb5meOex2ifsvoc5LEF+LmXrSAwMYY5mulMMp6gSUilZ/aqWElINdHJHCFJnvpvFW5F485ra+JF67s0kNmDJioNJ0m0d3xSaB6qAN+SpE2XEUfICX30ECoA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=Y6Lq7TVG; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from [192.168.1.15] (c-67-168-176-124.hsd1.wa.comcast.net [67.168.176.124])
	by linux.microsoft.com (Postfix) with ESMTPSA id AF12D20B7128;
	Fri, 17 Apr 2026 14:26:44 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com AF12D20B7128
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1776461205;
	bh=1ET3yfHaxXrfdCgeBtEVPboINFR8mMRFnfzuQnPH5Hw=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=Y6Lq7TVGPjR4ZhE6cwvjds/JQPVj30uUgjMxQBWLOYwxF3p4SVuFhga03+ap+s83O
	 o5MtRk3jmMZ7OZLpJsePS2JATvwe/PlnWQxmByISBEwNCsENIDsGa7q3KmTaePpLpi
	 KE7iIokZKAf7BoDxrHRjdBW7PsiYPd49TGJ8hOWw=
Message-ID: <6277ef57-5f7e-4cf7-8214-e06868104cc5@linux.microsoft.com>
Date: Fri, 17 Apr 2026 14:26:44 -0700
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 2/3] ima: trim N IMA event log records
To: Roberto Sassu <roberto.sassu@huaweicloud.com>,
 linux-integrity@vger.kernel.org
Cc: zohar@linux.ibm.com, roberto.sassu@huawei.com, dmitry.kasatkin@gmail.com,
 eric.snowberg@oracle.com, corbet@lwn.net, serge@hallyn.com,
 paul@paul-moore.com, jmorris@namei.org,
 linux-security-module@vger.kernel.org, anirudhve@linux.microsoft.com,
 gregorylumen@linux.microsoft.com, nramas@linux.microsoft.com,
 sushring@linux.microsoft.com, linux-doc@vger.kernel.org,
 steven chen <chenste@linux.microsoft.com>
References: <20260401172956.4581-1-chenste@linux.microsoft.com>
 <20260401172956.4581-3-chenste@linux.microsoft.com>
 <b0b65c5a2d407301905dc4232eee4b16030920c8.camel@huaweicloud.com>
Content-Language: en-US
From: steven chen <chenste@linux.microsoft.com>
In-Reply-To: <b0b65c5a2d407301905dc4232eee4b16030920c8.camel@huaweicloud.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.microsoft.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[linux.microsoft.com:s=default];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[linux.ibm.com,huawei.com,gmail.com,oracle.com,lwn.net,hallyn.com,paul-moore.com,namei.org,vger.kernel.org,linux.microsoft.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	TAGGED_FROM(0.00)[bounces-9226-lists,linux-integrity=lfdr.de];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[chenste@linux.microsoft.com,linux-integrity@vger.kernel.org];
	DKIM_TRACE(0.00)[linux.microsoft.com:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-integrity];
	RCPT_COUNT_TWELVE(0.00)[17];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: B083041EB19
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 4/7/2026 9:19 AM, Roberto Sassu wrote:
> On Wed, 2026-04-01 at 10:29 -0700, steven chen wrote:
>> Trim N entries of the IMA event logs. Do not clean the hash table.
> The very first change of this patch is the kernel option
> ima_flush_htable option that I introduced for my use case.
>
> At the bottom of this patch you actually check the ima_flush_htable
> boolean, and delete the measurements entries without disconnecting them
> from the hash table, so the digest lookup is done on freed memory.
>
> Next, you duplicated my changes regarding the measurements list
> counter. But instead of removing the old counter from the hash table,
> you keep incrementing both, but use the new one.
>
> In ima_log_trim_open(), you use again my duplicated code to manage
> exclusive write/concurrent read scheme for the measurement interfaces.
> However, for read, if the process does not have CAP_SYS_ADMIN it falls
> back calling _ima_measurements_open(). Not sure it was intended.
Hi Roberto,

I acknowledged these are coming from you in my cover letter. Please
let me know the best way to show your contribution and I will update
in my next version.

All above issues you mentioned, I will update in next version.
> And, in ima_log_trim_release(), you check again CAP_SYS_ADMIN which is
> redundant, you would not reach this code if the same requirements were
> not met at open time. You also return an error on close().

Will update in next version.

Thanks,

> In ima_log_trim_write(), you do manual string to number conversion for
> your first number and use kstrtoul() for the second.
>
> The measurements lists and the associated counter are atomically
> updated in ima_add_digest_entry(), but not atomically accessed in
> ima_delete_event_log(). Also, the measurements list is traversed
> without _rcu variant or lock.

Will update in next version.

Thanks

>
> While this trimming scheme aims at minimizing the kernel space and user
> space delay, it also introduces the following problem. If two agents
> perform a TPM quote that include a different number of entries, there
> is no guarantee that the one willing to trim less entries wins. Which
> means that, one agent could end up not seeing the most recent entries,
> as they were already trimmed by the other agent.
This should be acceptable: the second trim request will be rejected and
the agent can find all logs in user space if all user agents handle the log
in the right way.
Also there is other way to do it: the user agent can hold the list by open
the ima_trim_log with write permission during reading, attestation, trim 
period.
In this way, the user agent for "Trim N method" will have similar user 
space hold time
as "staged method" but has less kernel list lock time, and user agent 
requirement
for "Trim N method" is much simple than that for "stage method".
>
> My solution is not affected by this problem, since there will be only
> one process collecting all the measurements in user space and exposing
> them to the agents.

Please see above response.

Thanks,

Steven

>
> Also, I didn't understand why T and ima_measure_users have to be
> preserved on soft reboots. Especially ima_measure_users reflects the
> state of open files for a particular kernel, but on soft reboot a new
> kernel is booted.
>
> I personally will not endorse a solution based on the ima_trim_log
> interface. I could accept trimming N even more efficiently than we
> currently do with a lockless walk to determine the cutting position in
> ima_queue_stage(), so that we don't need to splice back entries to the
> measurement list. This would be a replacement of patch 11 in my patch
> set, but this would be as far as I would like to go.
>
> Roberto
>
>> The values saved in hash table were already used.
>>
>> Provide a userspace interface ima_trim_log:
>> When read this interface, it returns total number T of entries trimmed
>> since system boot up.
>> When write to this interface need to provide two numbers T:N to let
>> kernel to trim N entries of IMA event logs.
>>
>> Kernel measurement list lock time performance improvement by not
>> clean the hash table.
>>
>> when kernel get log trim request T:N
>>   - Get the T, compare with the total trimmed number
>>   - if equal, then do trim N and change T to T+N
>>   - else return error
>>
>> Signed-off-by: steven chen <chenste@linux.microsoft.com>
>> ---
>>   .../admin-guide/kernel-parameters.txt         |   4 +
>>   security/integrity/ima/ima.h                  |   4 +-
>>   security/integrity/ima/ima_fs.c               | 198 +++++++++++++++++-
>>   security/integrity/ima/ima_kexec.c            |   2 +-
>>   security/integrity/ima/ima_queue.c            |  96 +++++++++
>>   5 files changed, 296 insertions(+), 8 deletions(-)
>>
>> diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
>> index e92c0056e4e0..cd1a1d0bf0e2 100644
>> --- a/Documentation/admin-guide/kernel-parameters.txt
>> +++ b/Documentation/admin-guide/kernel-parameters.txt
>> @@ -2197,6 +2197,10 @@
>>   			Use the canonical format for the binary runtime
>>   			measurements, instead of host native format.
>>   
>> +	ima_flush_htable  [IMA]
>> +			Flush the measurement list hash table when trim all
>> +			or a part of it for deletion.
>> +
>>   	ima_hash=	[IMA]
>>   			Format: { md5 | sha1 | rmd160 | sha256 | sha384
>>   				   | sha512 | ... }
>> diff --git a/security/integrity/ima/ima.h b/security/integrity/ima/ima.h
>> index e3d71d8d56e3..5cbee3a295a0 100644
>> --- a/security/integrity/ima/ima.h
>> +++ b/security/integrity/ima/ima.h
>> @@ -243,11 +243,13 @@ void ima_post_key_create_or_update(struct key *keyring, struct key *key,
>>   				   const void *payload, size_t plen,
>>   				   unsigned long flags, bool create);
>>   #endif
>> -
>> +extern atomic_long_t ima_number_entries;
>>   #ifdef CONFIG_IMA_KEXEC
>>   void ima_measure_kexec_event(const char *event_name);
>> +long ima_delete_event_log(long req_val);
>>   #else
>>   static inline void ima_measure_kexec_event(const char *event_name) {}
>> +static inline long ima_delete_event_log(long req_val) { return 0; }
>>   #endif
>>   
>>   /*
>> diff --git a/security/integrity/ima/ima_fs.c b/security/integrity/ima/ima_fs.c
>> index 87045b09f120..8e26e0f34311 100644
>> --- a/security/integrity/ima/ima_fs.c
>> +++ b/security/integrity/ima/ima_fs.c
>> @@ -21,6 +21,9 @@
>>   #include <linux/rcupdate.h>
>>   #include <linux/parser.h>
>>   #include <linux/vmalloc.h>
>> +#include <linux/ktime.h>
>> +#include <linux/timekeeping.h>
>> +#include <linux/ima.h>
>>   
>>   #include "ima.h"
>>   
>> @@ -38,6 +41,17 @@ __setup("ima_canonical_fmt", default_canonical_fmt_setup);
>>   
>>   static int valid_policy = 1;
>>   
>> +#define IMA_LOG_TRIM_REQ_NUM_LENGTH 15
>> +#define IMA_LOG_TRIM_REQ_TOTAL_LENGTH 32
>> +atomic_long_t ima_number_entries = ATOMIC_LONG_INIT(0);
>> +static long trimcount;
>> +/* mutex protects atomicity of trimming measurement list
>> + * and also protects atomicity the measurement list read
>> + * write operation.
>> + */
>> +static DEFINE_MUTEX(ima_measure_lock);
>> +static long ima_measure_users;
>> +
>>   static ssize_t ima_show_htable_value(char __user *buf, size_t count,
>>   				     loff_t *ppos, atomic_long_t *val)
>>   {
>> @@ -64,8 +78,7 @@ static ssize_t ima_show_measurements_count(struct file *filp,
>>   					   char __user *buf,
>>   					   size_t count, loff_t *ppos)
>>   {
>> -	return ima_show_htable_value(buf, count, ppos, &ima_htable.len);
>> -
>> +	return ima_show_htable_value(buf, count, ppos, &ima_number_entries);
>>   }
>>   
>>   static const struct file_operations ima_measurements_count_ops = {
>> @@ -202,16 +215,77 @@ static const struct seq_operations ima_measurments_seqops = {
>>   	.show = ima_measurements_show
>>   };
>>   
>> +/*
>> + * _ima_measurements_open - open the IMA measurements file
>> + * @inode: inode of the file being opened
>> + * @file: file being opened
>> + * @seq_ops: sequence operations for the file
>> + *
>> + * Returns 0 on success, or negative error code.
>> + * Implements mutual exclusion between readers and writer
>> + * of the measurements file. Multiple readers are allowed,
>> + * but writer get exclusive access only no other readers/writers.
>> + * Readers is not allowed when there is a writer.
>> + */
>> +static int _ima_measurements_open(struct inode *inode, struct file *file,
>> +				  const struct seq_operations *seq_ops)
>> +{
>> +	bool write = !!(file->f_mode & FMODE_WRITE);
>> +	int ret;
>> +
>> +	if (write && !capable(CAP_SYS_ADMIN))
>> +		return -EPERM;
>> +
>> +	mutex_lock(&ima_measure_lock);
>> +	if ((write && ima_measure_users != 0) ||
>> +	    (!write && ima_measure_users < 0)) {
>> +		mutex_unlock(&ima_measure_lock);
>> +		return -EBUSY;
>> +	}
>> +
>> +	ret = seq_open(file, seq_ops);
>> +	if (ret < 0) {
>> +		mutex_unlock(&ima_measure_lock);
>> +		return ret;
>> +	}
>> +
>> +	if (write)
>> +		ima_measure_users--;
>> +	else
>> +		ima_measure_users++;
>> +
>> +	mutex_unlock(&ima_measure_lock);
>> +	return ret;
>> +}
>> +
>>   static int ima_measurements_open(struct inode *inode, struct file *file)
>>   {
>> -	return seq_open(file, &ima_measurments_seqops);
>> +	return _ima_measurements_open(inode, file, &ima_measurments_seqops);
>> +}
>> +
>> +static int ima_measurements_release(struct inode *inode, struct file *file)
>> +{
>> +	bool write = !!(file->f_mode & FMODE_WRITE);
>> +	int ret;
>> +
>> +	mutex_lock(&ima_measure_lock);
>> +	ret = seq_release(inode, file);
>> +	if (!ret) {
>> +		if (!write)
>> +			ima_measure_users--;
>> +		else
>> +			ima_measure_users++;
>> +	}
>> +
>> +	mutex_unlock(&ima_measure_lock);
>> +	return ret;
>>   }
>>   
>>   static const struct file_operations ima_measurements_ops = {
>>   	.open = ima_measurements_open,
>>   	.read = seq_read,
>>   	.llseek = seq_lseek,
>> -	.release = seq_release,
>> +	.release = ima_measurements_release,
>>   };
>>   
>>   void ima_print_digest(struct seq_file *m, u8 *digest, u32 size)
>> @@ -279,14 +353,114 @@ static const struct seq_operations ima_ascii_measurements_seqops = {
>>   
>>   static int ima_ascii_measurements_open(struct inode *inode, struct file *file)
>>   {
>> -	return seq_open(file, &ima_ascii_measurements_seqops);
>> +	return _ima_measurements_open(inode, file, &ima_ascii_measurements_seqops);
>>   }
>>   
>>   static const struct file_operations ima_ascii_measurements_ops = {
>>   	.open = ima_ascii_measurements_open,
>>   	.read = seq_read,
>>   	.llseek = seq_lseek,
>> -	.release = seq_release,
>> +	.release = ima_measurements_release,
>> +};
>> +
>> +static int ima_log_trim_open(struct inode *inode, struct file *file)
>> +{
>> +	bool write = !!(file->f_mode & FMODE_WRITE);
>> +
>> +	if (!write && capable(CAP_SYS_ADMIN))
>> +		return 0;
>> +	else if (!capable(CAP_SYS_ADMIN))
>> +		return -EPERM;
>> +
>> +	return _ima_measurements_open(inode, file, &ima_measurments_seqops);
>> +}
>> +
>> +static ssize_t ima_log_trim_read(struct file *file, char __user *buf, size_t size, loff_t *ppos)
>> +{
>> +	char tmpbuf[IMA_LOG_TRIM_REQ_NUM_LENGTH];
>> +	ssize_t len;
>> +
>> +	len = scnprintf(tmpbuf, sizeof(tmpbuf), "%li\n", trimcount);
>> +	return simple_read_from_buffer(buf, size, ppos, tmpbuf, len);
>> +}
>> +
>> +static ssize_t ima_log_trim_write(struct file *file,
>> +				  const char __user *buf, size_t datalen, loff_t *ppos)
>> +{
>> +	char tmpbuf[IMA_LOG_TRIM_REQ_TOTAL_LENGTH];
>> +	char *p = tmpbuf;
>> +	long count, ret, val = 0, max = LONG_MAX;
>> +
>> +	if (*ppos > 0 || datalen > IMA_LOG_TRIM_REQ_TOTAL_LENGTH || datalen < 2) {
>> +		ret = -EINVAL;
>> +		goto out;
>> +	}
>> +
>> +	if (copy_from_user(tmpbuf, buf, datalen) != 0) {
>> +		ret = -EFAULT;
>> +		goto out;
>> +	}
>> +
>> +	p = tmpbuf;
>> +
>> +	while (*p && *p != ':') {
>> +		if (!isdigit((unsigned char)*p))
>> +			return -EINVAL;
>> +
>> +		/* digit value */
>> +		int d = *p - '0';
>> +
>> +		/* overflow check: val * 10 + d > max -> (val > (max - d) / 10) */
>> +		if (val > (max - d) / 10)
>> +			return -ERANGE;
>> +
>> +		val = val * 10 + d;
>> +		p++;
>> +	}
>> +
>> +	if (*p != ':')
>> +		return -EINVAL;
>> +
>> +	/* verify trim count matches */
>> +	if (val != trimcount)
>> +		return -EINVAL;
>> +
>> +	p++; /* skip ':' */
>> +	ret = kstrtoul(p, 0, &count);
>> +
>> +	if (ret < 0)
>> +		goto out;
>> +
>> +	ret = ima_delete_event_log(count);
>> +
>> +	if (ret < 0)
>> +		goto out;
>> +
>> +	trimcount += ret;
>> +
>> +	ret = datalen;
>> +out:
>> +	return ret;
>> +}
>> +
>> +static int ima_log_trim_release(struct inode *inode, struct file *file)
>> +{
>> +	bool write = !!(file->f_mode & FMODE_WRITE);
>> +
>> +	if (!write && capable(CAP_SYS_ADMIN))
>> +		return 0;
>> +	else if (!capable(CAP_SYS_ADMIN))
>> +		return -EPERM;
>> +
>> +	return ima_measurements_release(inode, file);
>> +}
>> +
>> +static const struct file_operations ima_log_trim_ops = {
>> +	.open = ima_log_trim_open,
>> +	.read = ima_log_trim_read,
>> +	.write = ima_log_trim_write,
>> +	.llseek = generic_file_llseek,
>> +	.release = ima_log_trim_release
>>   };
>>   
>>   static ssize_t ima_read_policy(char *path)
>> @@ -528,6 +702,18 @@ int __init ima_fs_init(void)
>>   		goto out;
>>   	}
>>   
>> +	if (IS_ENABLED(CONFIG_IMA_LOG_TRIMMING)) {
>> +		dentry = securityfs_create_file("ima_trim_log",
>> +						S_IRUSR | S_IRGRP | S_IWUSR | S_IWGRP,
>> +						ima_dir, NULL, &ima_log_trim_ops);
>> +		if (IS_ERR(dentry)) {
>> +			ret = PTR_ERR(dentry);
>> +			goto out;
>> +		}
>> +	}
>> +
>> +	trimcount = 0;
>> +
>>   	dentry = securityfs_create_file("runtime_measurements_count",
>>   				   S_IRUSR | S_IRGRP, ima_dir, NULL,
>>   				   &ima_measurements_count_ops);
>> diff --git a/security/integrity/ima/ima_kexec.c b/security/integrity/ima/ima_kexec.c
>> index 7362f68f2d8b..bee997683e03 100644
>> --- a/security/integrity/ima/ima_kexec.c
>> +++ b/security/integrity/ima/ima_kexec.c
>> @@ -41,7 +41,7 @@ void ima_measure_kexec_event(const char *event_name)
>>   	int n;
>>   
>>   	buf_size = ima_get_binary_runtime_size();
>> -	len = atomic_long_read(&ima_htable.len);
>> +	len = atomic_long_read(&ima_number_entries);
>>   
>>   	n = scnprintf(ima_kexec_event, IMA_KEXEC_EVENT_LEN,
>>   		      "kexec_segment_size=%lu;ima_binary_runtime_size=%lu;"
>> diff --git a/security/integrity/ima/ima_queue.c b/security/integrity/ima/ima_queue.c
>> index 590637e81ad1..07225e19b9b5 100644
>> --- a/security/integrity/ima/ima_queue.c
>> +++ b/security/integrity/ima/ima_queue.c
>> @@ -22,6 +22,14 @@
>>   
>>   #define AUDIT_CAUSE_LEN_MAX 32
>>   
>> +bool ima_flush_htable;
>> +static int __init ima_flush_htable_setup(char *str)
>> +{
>> +	ima_flush_htable = true;
>> +	return 1;
>> +}
>> +__setup("ima_flush_htable", ima_flush_htable_setup);
>> +
>>   /* pre-allocated array of tpm_digest structures to extend a PCR */
>>   static struct tpm_digest *digests;
>>   
>> @@ -114,6 +122,7 @@ static int ima_add_digest_entry(struct ima_template_entry *entry,
>>   	list_add_tail_rcu(&qe->later, &ima_measurements);
>>   
>>   	atomic_long_inc(&ima_htable.len);
>> +	atomic_long_inc(&ima_number_entries);
>>   	if (update_htable) {
>>   		key = ima_hash_key(entry->digests[ima_hash_algo_idx].digest);
>>   		hlist_add_head_rcu(&qe->hnext, &ima_htable.queue[key]);
>> @@ -220,6 +229,93 @@ int ima_add_template_entry(struct ima_template_entry *entry, int violation,
>>   	return result;
>>   }
>>   
>> +/**
>> + * ima_delete_event_log - delete IMA event entry
>> + * @num_records: number of records to delete
>> + *
>> + * delete num_records entries off the measurement list.
>> + * Returns num_records, or negative error code.
>> + */
>> +long ima_delete_event_log(long num_records)
>> +{
>> +	long len, cur = num_records, tmp_len = 0;
>> +	struct ima_queue_entry *qe, *qe_tmp;
>> +	LIST_HEAD(ima_measurements_to_delete);
>> +	struct list_head *list_ptr;
>> +
>> +	if (!IS_ENABLED(CONFIG_IMA_LOG_TRIMMING))
>> +		return -EOPNOTSUPP;
>> +
>> +	if (num_records <= 0)
>> +		return num_records;
>> +
>> +	list_ptr = &ima_measurements;
>> +
>> +	len = atomic_long_read(&ima_number_entries);
>> +
>> +	if (num_records <= len) {
>> +		list_for_each_entry(qe, list_ptr, later) {
>> +			if (cur > 0) {
>> +				tmp_len += get_binary_runtime_size(qe->entry);
>> +				--cur;
>> +			}
>> +			if (cur == 0) {
>> +				qe_tmp = qe;
>> +				break;
>> +			}
>> +		}
>> +	}
>> +	else {
>> +		return -ENOENT;
>> +	}
>> +
>> +
>> +	mutex_lock(&ima_extend_list_mutex);
>> +	len = atomic_long_read(&ima_number_entries);
>> +
>> +	if (num_records == len) {
>> +		list_replace(&ima_measurements, &ima_measurements_to_delete);
>> +		INIT_LIST_HEAD(&ima_measurements);
>> +		atomic_long_set(&ima_number_entries, 0);
>> +		list_ptr = &ima_measurements_to_delete;
>> +	}
>> +	else {
>> +		__list_cut_position(&ima_measurements_to_delete, &ima_measurements,
>> +				    &qe_tmp->later);
>> +		atomic_long_sub(num_records, &ima_number_entries);
>> +		if (IS_ENABLED(CONFIG_IMA_KEXEC))
>> +			binary_runtime_size -= tmp_len;
>> +	}
>> +
>> +	mutex_unlock(&ima_extend_list_mutex);
>> +
>> +	if (ima_flush_htable)
>> +		synchronize_rcu();
>> +
>> +	list_for_each_entry_safe(qe, qe_tmp, &ima_measurements_to_delete, later) {
>> +		/*
>> +		 * Ok because after list delete qe is only accessed by
>> +		 * ima_lookup_digest_entry().
>> +		 */
>> +		for (int i = 0; i < qe->entry->template_desc->num_fields; i++) {
>> +			kfree(qe->entry->template_data[i].data);
>> +			qe->entry->template_data[i].data = NULL;
>> +			qe->entry->template_data[i].len = 0;
>> +		}
>> +
>> +		list_del(&qe->later);
>> +
>> +		/* No leak if !ima_flush_htable, referenced by ima_htable. */
>> +		if (ima_flush_htable) {
>> +			kfree(qe->entry->digests);
>> +			kfree(qe->entry);
>> +			kfree(qe);
>> +		}
>> +	}
>> +
>> +	return num_records;
>> +}
>> +
>>   int ima_restore_measurement_entry(struct ima_template_entry *entry)
>>   {
>>   	int result = 0;



