Return-Path: <linux-integrity+bounces-8078-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 27FF6CC50DE
	for <lists+linux-integrity@lfdr.de>; Tue, 16 Dec 2025 20:59:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 035EB302E97A
	for <lists+linux-integrity@lfdr.de>; Tue, 16 Dec 2025 19:59:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE8DB337692;
	Tue, 16 Dec 2025 19:59:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="gtkQ3uGf"
X-Original-To: linux-integrity@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE55132E74B;
	Tue, 16 Dec 2025 19:59:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765915181; cv=none; b=NNj2swDQl6y2VkmCApBdiCbMLAu4TpCxxZKTKIYUa9Qp/Nw+T0aaL617d1cLx3GgKvtyA7P2MKy+IK1zyATp4kh3PsC7UYH59jnmBUWRc1iYGvc2n/qQhiMRWHG2agttieThrkcC/dUlEx5T15d869t+/9Skjp5JAXjEG4qeZkk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765915181; c=relaxed/simple;
	bh=Oar1DZrfZa/q9K8BUehLar3eAEb5iQHtOvV/n32EmcQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=J5X76xlmV89rPwLN/rC3zcqO2SXnwd4rOYqkw3E/6J51oRyRbA2QQaFKl1mU/PeeJUWa0wmpwMd5Y+AZjF5Hud38FUsi8c4epIg9GggV6TF85eEgKrvNNpzhQIJI2LnOs/MMJ2kVtj3DD8WI62d4Qe6LohG0c17iQbpDi0GUPeA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=gtkQ3uGf; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from [10.17.64.122] (unknown [131.107.147.250])
	by linux.microsoft.com (Postfix) with ESMTPSA id F1137200D625;
	Tue, 16 Dec 2025 11:59:37 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com F1137200D625
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1765915178;
	bh=Nnm3fRXKwpCcbByYKBNDVQAh/VR68KE8x1qPI3zoWMI=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=gtkQ3uGfDDOrZ6edzbnI3lqfC+VJuuau9YVsy6+rq7s8yx2rmCd6NvAXtyjK6zTjv
	 UKwbyeBiNU3+dOkeEaC0GUR5+owcXKWhe2quRt8Z2En1pMDrZxQcuDQsbB/hnvgd9z
	 2qQ0NvRYjtddYRUUPuPFWs4Vlcfw20V1BVT1+/zg=
Message-ID: <b9d7bcea-3784-4ad6-b494-374db0c00cc6@linux.microsoft.com>
Date: Tue, 16 Dec 2025 11:59:36 -0800
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V2 1/1] IMA event log trimming
To: Mimi Zohar <zohar@linux.ibm.com>, linux-integrity@vger.kernel.org
Cc: roberto.sassu@huawei.com, dmitry.kasatkin@gmail.com,
 eric.snowberg@oracle.com, corbet@lwn.net, serge@hallyn.com,
 paul@paul-moore.com, jmorris@namei.org,
 linux-security-module@vger.kernel.org, anirudhve@linux.microsoft.com,
 gregorylumen@linux.microsoft.com, nramas@linux.microsoft.com,
 sushring@linux.microsoft.com, linux-doc@vger.kernel.org,
 steven chen <chenste@linux.microsoft.com>
References: <20251210235314.3341-1-chenste@linux.microsoft.com>
 <20251210235314.3341-2-chenste@linux.microsoft.com>
 <d80958ec-f139-41e9-afa0-a5aca94221de@linux.microsoft.com>
 <c93907cb0f08f9baa320488989aa87e7867ee9da.camel@linux.ibm.com>
Content-Language: en-US
From: steven chen <chenste@linux.microsoft.com>
In-Reply-To: <c93907cb0f08f9baa320488989aa87e7867ee9da.camel@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 12/16/2025 4:50 AM, Mimi Zohar wrote:
> Hi Steven,
>
> As I previously said, "The main difference between this patch and Roberto's
> version is the length of time needed for locking the measurement list, which
> prevents new entries from being appended to the measurement list.  In Roberto's
> version, the list head is moved quickly and the lock released.  Measuring the
> total amount of time needed to trim the measurement list ignores the benefit of
> his version. I plan on reviewing both this version and his (hopefully today)."
>
> The other difference is "when" the IMA measurement list is read and saved,
> before the trigger to trim the measurement list or after when the measurement
> list is staged.  In this case, the initial trigger trims the measurement list.
> In the other case, the measurement list is staged and then deleted.  When
> reviewing Roberto's patch, I plan to discuss it.

Hi Mimi,

Will update this. Thanks!

> After trimming the measurement list, existing verifiers, which walk the IMA
> measurement list, will obviously fail to match the PCRs.  Breaking existing
> userspace applications is a problem and, unfortunately, requires yet another
> Kconfig option.  It needs to be at least mentioned here in the patch
> description.
Will add Kconfig option. Thanks!
> There are two places where it says, "the list never shrinks, so we don't need a
> lock here".  Either the code, the comment, or both need to be updated.
Will update.
>
> On Thu, 2025-12-11 at 10:41 -0800, steven chen wrote:
>> On 12/10/2025 3:53 PM, steven chen wrote:
>>> This patch is for trimming N entries of the IMA event logs. It will also
>>> cleaning the hash table if ima_flush_htable is set.
> Please refer to "Describe your changes in imperative mood" in the "Describe your
> changes" section of Documentation/process/submitting-patches.rst.
Will update. Thanks!
>>> It provides a userspace interface ima_trim_log that can be used to input
>>> number N to let kernel to trim N entries of IMA event logs. When read
> There is only a single kernel measurement list or event log, not plural.  There
> are N number of "entries" or "records" in the IMA measurement list.
>
> -> trim N records from the IMA measurement list.

Will update. Thanks!


>>> this interface, it returns number of entries trimmed last time.
> Please provide an example of how to initiate the trim.
>
> After trimming the IMA measurement list, are the other securityfs files correct?
> Are they correct after a kexec?  Or are they reset without a way of resurrecting
> them without the full measurement list?

Will update. Thanks!


>
>>> Signed-off-by: steven chen <chenste@linux.microsoft.com>
>>> ---
>>>    .../admin-guide/kernel-parameters.txt         |   4 +
>>>    security/integrity/ima/ima.h                  |   2 +
>>>    security/integrity/ima/ima_fs.c               | 175 +++++++++++++++++-
>>>    security/integrity/ima/ima_queue.c            |  64 +++++++
>>>    4 files changed, 241 insertions(+), 4 deletions(-)
>>>
>>> diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
>>> index e92c0056e4e0..cd1a1d0bf0e2 100644
>>> --- a/Documentation/admin-guide/kernel-parameters.txt
>>> +++ b/Documentation/admin-guide/kernel-parameters.txt
>>> @@ -2197,6 +2197,10 @@
>>>    			Use the canonical format for the binary runtime
>>>    			measurements, instead of host native format.
>>>    
>>> +	ima_flush_htable  [IMA]
>>> +			Flush the measurement list hash table when trim all
>>> +			or a part of it for deletion.
>>> +
>>>    	ima_hash=	[IMA]
>>>    			Format: { md5 | sha1 | rmd160 | sha256 | sha384
>>>    				   | sha512 | ... }
>>> diff --git a/security/integrity/ima/ima.h b/security/integrity/ima/ima.h
>>> index e3d71d8d56e3..ab0e30ee25ea 100644
>>> --- a/security/integrity/ima/ima.h
>>> +++ b/security/integrity/ima/ima.h
>>> @@ -246,8 +246,10 @@ void ima_post_key_create_or_update(struct key *keyring, struct key *key,
>>>    
>>>    #ifdef CONFIG_IMA_KEXEC
>>>    void ima_measure_kexec_event(const char *event_name);
>>> +long ima_purge_event_log(long number_logs);
>>>    #else
>>>    static inline void ima_measure_kexec_event(const char *event_name) {}
>>> +static inline long ima_purge_event_log(long number_logs) { return 0; }
>>>    #endif
>>>    
>>>    /*
>>> diff --git a/security/integrity/ima/ima_fs.c b/security/integrity/ima/ima_fs.c
>>> index 87045b09f120..410f7d03c43f 100644
>>> --- a/security/integrity/ima/ima_fs.c
>>> +++ b/security/integrity/ima/ima_fs.c
>>> @@ -21,6 +21,9 @@
>>>    #include <linux/rcupdate.h>
>>>    #include <linux/parser.h>
>>>    #include <linux/vmalloc.h>
>>> +#include <linux/ktime.h>
>>> +#include <linux/timekeeping.h>
>>> +#include <linux/ima.h>
>>>    
>>>    #include "ima.h"
>>>    
>>> @@ -38,6 +41,14 @@ __setup("ima_canonical_fmt", default_canonical_fmt_setup);
>>>    
>>>    static int valid_policy = 1;
>>>    
>>> +#define IMA_LOG_TRIM_REQ_LENGTH 11
>>> +#define IMA_LOG_TRIM_EVENT_LEN 256
>>> +
>>> +static long trimcount;
>>> +/* mutex protects atomicity of trimming measurement list requests */
> ima_measure_lock is taken for more than just synchronization of trimming the
> measurement list.  Please update comment.

Will update. Thanks!


>
>>> +static DEFINE_MUTEX(ima_measure_lock);
>>> +static long ima_measure_users;
>>> +
>>>    static ssize_t ima_show_htable_value(char __user *buf, size_t count,
>>>    				     loff_t *ppos, atomic_long_t *val)
>>>    {
>>> @@ -202,16 +213,65 @@ static const struct seq_operations ima_measurments_seqops = {
>>>    	.show = ima_measurements_show
>>>    };
>>>    
> _ima_measurements_open() seems pretty fundamental to the locking scheme.
> Preventing opening the IMA measurement list is new.  There should at least be a
> short, regular comment explaining what you're locking and why.

Will update. Thanks!


>>> +static int _ima_measurements_open(struct inode *inode, struct file *file,
>>> +				  const struct seq_operations *seq_ops)
>>> +{
>>> +	bool write = !!(file->f_mode & FMODE_WRITE);
>>> +	int ret;
>>> +
>>> +	if (write && !capable(CAP_SYS_ADMIN))
>>> +		return -EPERM;
>>> +
>>> +	mutex_lock(&ima_measure_lock);
>>> +	if ((write && ima_measure_users != 0) ||
>>> +	    (!write && ima_measure_users < 0)) {
>>> +		mutex_unlock(&ima_measure_lock);
>>> +		return -EBUSY;
>>> +	}
>>> +
>>> +	ret = seq_open(file, seq_ops);
>>> +	if (ret < 0) {
>>> +		mutex_unlock(&ima_measure_lock);
>>> +		return ret;
>>> +	}
>>> +
>>> +	if (write)
>>> +		ima_measure_users--;
>>> +	else
>>> +		ima_measure_users++;
>>> +
>>> +	mutex_unlock(&ima_measure_lock);
>>> +	return ret;
>>> +}
>>> +
>>>    static int ima_measurements_open(struct inode *inode, struct file *file)
>>>    {
>>> -	return seq_open(file, &ima_measurments_seqops);
>>> +	return _ima_measurements_open(inode, file, &ima_measurments_seqops);
>>> +}
>>> +
>>> +static int ima_measurements_release(struct inode *inode, struct file *file)
>>> +{
>>> +	bool write = !!(file->f_mode & FMODE_WRITE);
>>> +	int ret;
>>> +
>>> +	mutex_lock(&ima_measure_lock);
>>> +	ret = seq_release(inode, file);
>>> +	if (!ret) {
>>> +		if (write)
>>> +			ima_measure_users++;
>>> +		else
>>> +			ima_measure_users--;
>>> +	}
>>> +
>>> +	mutex_unlock(&ima_measure_lock);
>>> +	return ret;
>>>    }
>>>    
>>>    static const struct file_operations ima_measurements_ops = {
>>>    	.open = ima_measurements_open,
>>>    	.read = seq_read,
>>>    	.llseek = seq_lseek,
>>> -	.release = seq_release,
>>> +	.release = ima_measurements_release,
>>>    };
>>>    
>>>    void ima_print_digest(struct seq_file *m, u8 *digest, u32 size)
>>> @@ -279,14 +339,111 @@ static const struct seq_operations ima_ascii_measurements_seqops = {
>>>    
>>>    static int ima_ascii_measurements_open(struct inode *inode, struct file *file)
>>>    {
>>> -	return seq_open(file, &ima_ascii_measurements_seqops);
>>> +	return _ima_measurements_open(inode, file, &ima_ascii_measurements_seqops);
>>>    }
>>>    
>>>    static const struct file_operations ima_ascii_measurements_ops = {
>>>    	.open = ima_ascii_measurements_open,
>>>    	.read = seq_read,
>>>    	.llseek = seq_lseek,
>>> -	.release = seq_release,
>>> +	.release = ima_measurements_release,
>>> +};
>>> +
>>> +static void ima_measure_trim_event(const long number_logs)
>>> +{
>>> +	char ima_log_trim_event[IMA_LOG_TRIM_EVENT_LEN];
>>> +	struct timespec64 ts;
>>> +	u64 time_ns;
>>> +	int n;
>>> +
>>> +	ktime_get_real_ts64(&ts);
>>> +	time_ns = (u64)ts.tv_sec * 1000000000ULL + ts.tv_nsec;
>>> +	n = scnprintf(ima_log_trim_event, IMA_LOG_TRIM_EVENT_LEN,
>>> +		      "time=%llu; log trim this time=%lu;",
>>> +		       time_ns, number_logs);
>>> +
>>> +	ima_measure_critical_data("ima_log_trim", "trim ima event logs", ima_log_trim_event, n, false, NULL, 0);
>>> +}
> There's no mention of a new critical data record in the patch description.  It
> should be a separate patch with a full patch description describing what it is
> and how to verify it.

Will update this. Thanks!


>>> +
>>> +static int ima_log_trim_open(struct inode *inode, struct file *file)
>>> +{
>>> +	bool write = !!(file->f_mode & FMODE_WRITE);
>>> +
>>> +	if (!write && capable(CAP_SYS_ADMIN))
>>> +		return 0;
>>> +	else if (!capable(CAP_SYS_ADMIN))
>>> +		return -EPERM;
>>> +
>>> +	return _ima_measurements_open(inode, file, &ima_measurments_seqops);
>>> +}
>>> +
>>> +static ssize_t ima_log_trim_read(struct file *file, char __user *buf, size_t size, loff_t *ppos)
>>> +{
>>> +	char tmpbuf[IMA_LOG_TRIM_REQ_LENGTH];	/* greater than largest 'long' string value */
>>> +	ssize_t len;
>>> +
>>> +	len = scnprintf(tmpbuf, sizeof(tmpbuf), "%li\n", trimcount);
>>> +	return simple_read_from_buffer(buf, size, ppos, tmpbuf, len);
>>> +}
>>> +
>>> +static ssize_t ima_log_trim_write(struct file *file,
>>> +				  const char __user *buf, size_t datalen, loff_t *ppos)
>>> +{
>>> +	unsigned char req[IMA_LOG_TRIM_REQ_LENGTH];
>>> +	long count, n;
>>> +	int ret;
>>> +
>>> +	if (*ppos > 0 || datalen > IMA_LOG_TRIM_REQ_LENGTH || datalen < 2) {
>>> +		ret = -EINVAL;
>>> +		goto out;
>>> +	}
>>> +
>>> +	n = (int)datalen;
>>> +
>>> +	ret = copy_from_user(req, buf, datalen);
>>> +	if (ret < 0)
>>> +		goto out;
>>> +
>>> +	count = 0;
>>> +	for (int i = 0; i < n; ++i) {
>>> +		if (req[i] < '0' || req[i] > '9') {
>>> +			ret = -EINVAL;
>>> +			goto out;
>>> +		}
>>> +		count = count * 10 + req[i] - '0';
>>> +	}
> This code can be simplified by using the kstrto*_from_user() family of
> functions.  The patch description should include an example how to trim the
> measurement list.

Will update. Thanks!


>>> +	ret = ima_purge_event_log(count);
> The term "purge" is really strong wording.  I hope you're not purging the
> measurement list, but simply removing them from kernel memory.

Will update. Thanks!


>
>>> +
>>> +	if (ret < 0)
>>> +		goto out;
>>> +
>>> +	trimcount = ret;
>>> +
>>> +	if (trimcount > 0)
>>> +		ima_measure_trim_event(trimcount);
>>> +
>>> +	ret = datalen;
>>> +out:
>>> +	return ret;
>>> +}
>>> +
>>> +static int ima_log_trim_release(struct inode *inode, struct file *file)
>>> +{
>>> +	bool write = !!(file->f_mode & FMODE_WRITE);
>>> +	if (!write && capable(CAP_SYS_ADMIN))
>>> +		return 0;
>>> +	else if (!capable(CAP_SYS_ADMIN))
>>> +		return -EPERM;
>>> +
>>> +	return ima_measurements_release(inode, file);
>>> +}
>>> +
>>> +static const struct file_operations ima_log_trim_ops = {
>>> +	.open = ima_log_trim_open,
>>> +	.read = ima_log_trim_read,
>>> +	.write = ima_log_trim_write,
>>> +	.llseek = generic_file_llseek,
>>> +	.release = ima_log_trim_release
>>>    };
>>>    
>>>    static ssize_t ima_read_policy(char *path)
>>> @@ -528,6 +685,16 @@ int __init ima_fs_init(void)
>>>    		goto out;
>>>    	}
>>>    
>>> +	dentry = securityfs_create_file("ima_trim_log",
>>> +					S_IRUSR | S_IRGRP | S_IWUSR | S_IWGRP,
>>> +					ima_dir, NULL, &ima_log_trim_ops);
>>> +	if (IS_ERR(dentry)) {
>>> +		ret = PTR_ERR(dentry);
>>> +		goto out;
>>> +	}
>>> +
>>> +	trimcount = 0;
>>> +
>>>    	dentry = securityfs_create_file("runtime_measurements_count",
>>>    				   S_IRUSR | S_IRGRP, ima_dir, NULL,
>>>    				   &ima_measurements_count_ops);
>>> diff --git a/security/integrity/ima/ima_queue.c b/security/integrity/ima/ima_queue.c
>>> index 590637e81ad1..77ab52469727 100644
>>> --- a/security/integrity/ima/ima_queue.c
>>> +++ b/security/integrity/ima/ima_queue.c
>>> @@ -22,6 +22,14 @@
>>>    
>>>    #define AUDIT_CAUSE_LEN_MAX 32
>>>    
>>> +bool ima_flush_htable;
>>> +static int __init ima_flush_htable_setup(char *str)
>>> +{
>>> +	ima_flush_htable = true;
>>> +	return 1;
>>> +}
>>> +__setup("ima_flush_htable", ima_flush_htable_setup);
>>> +
>>>    /* pre-allocated array of tpm_digest structures to extend a PCR */
>>>    static struct tpm_digest *digests;
>>>    
>>> @@ -220,6 +228,62 @@ int ima_add_template_entry(struct ima_template_entry *entry, int violation,
>>>    	return result;
>>>    }
>>>    
>>> +/* Delete the IMA event logs */
> Do you mean delete the IMA event records/entries?

Will update. Thanks!


>>> +long ima_purge_event_log(long number_logs)
> If this function is not defined as static, then it requires a kernel-doc.

Will update. Thanks!


>>> +{
>>> +	struct ima_queue_entry *qe, *qe_tmp;
>>> +	LIST_HEAD(ima_measurements_staged);
>>> +	unsigned int i;
>>> +	long cur = number_logs;
> The variable name "number_logs" is confusing.  As I mentioned in the patch
> description, there is one measurement list with multiple records.  There aren't
> multiple logs in the kernel (other than the staged list).

Will update it to "req_value". Thanks!


>>> +
>>> +	if (number_logs <= 0)
>>> +		return number_logs;
>>> +
>>> +	mutex_lock(&ima_extend_list_mutex);
>>> +
>>> +
>>> +	list_for_each_entry(qe, &ima_measurements, later) {
>>> +		if (--number_logs == 0)
>>> +			break;
>>> +	}
>>> +
>>> +	if (number_logs > 0) {
>>> +		mutex_unlock(&ima_extend_list_mutex);
>>> +		return -ENOENT;
>>> +	}
>>> +
>>> +	__list_cut_position(&ima_measurements_staged, &ima_measurements,
>>> +				    &qe->later);
>>> +	atomic_long_sub(cur, &ima_htable.len);
>>> +
>>> +	if (!IS_ENABLED(CONFIG_IMA_DISABLE_HTABLE) && ima_flush_htable) {
>>> +		list_for_each_entry(qe, &ima_measurements_staged, later)
>>> +			/* It can race with ima_lookup_digest_entry(). */
>>> +			hlist_del_rcu(&qe->hnext);
>>> +	}
>> If the h table can be staged during the locking period and deleted after
>> unlocking, the time
>> the list is held will be reduced.
>>
>> I will work on this, and any suggestions are greatly appreciated.
>>
>> Thanks,
>>
>> Steven
>>
>>> +
>>> +	mutex_unlock(&ima_extend_list_mutex);
>>> +
>>> +
>>> +	list_for_each_entry_safe(qe, qe_tmp, &ima_measurements_staged, later) {
>>> +		for (i = 0; i < qe->entry->template_desc->num_fields; i++) {
>>> +			kfree(qe->entry->template_data[i].data);
>>> +			qe->entry->template_data[i].data = NULL;
>>> +			qe->entry->template_data[i].len = 0;
>>> +		}
>>> +
>>> +		list_del(&qe->later);
>>> +
>>> +		if (ima_flush_htable) {
>>> +			kfree(qe->entry->digests);
>>> +			kfree(qe->entry);
>>> +			kfree(qe);
>>> +		}
>>> +	}
> To avoid code duplication, there's a similar function named
> ima_free_template_entry().  Any changes needed to the function should be done as
> a preparatory patch.

I will check and update.

Thanks,

Steven

>>> +
>>> +	return cur;
>>> +}
>>> +
>>>    int ima_restore_measurement_entry(struct ima_template_entry *entry)
>>>    {
>>>    	int result = 0;
>


