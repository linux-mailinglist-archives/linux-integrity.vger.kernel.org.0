Return-Path: <linux-integrity+bounces-7907-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 8193ECB4554
	for <lists+linux-integrity@lfdr.de>; Thu, 11 Dec 2025 01:03:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1CB513042190
	for <lists+linux-integrity@lfdr.de>; Thu, 11 Dec 2025 00:03:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB4ADEEBB;
	Thu, 11 Dec 2025 00:03:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="SuZXITXF"
X-Original-To: linux-integrity@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87789A937;
	Thu, 11 Dec 2025 00:03:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765411401; cv=none; b=girSeE5EGpulJVTLEmESU9MRjVOtkKDGkZEv5IUOt2PKLrj+W1p2PtxDECw7UNNY4lW72Qwrtxl/AeRIK7EbAjzSKkpEur3YW3HZUo0lzcUaVswziZZ/ig1Gu+fljabej8OuHFyel8WTA7BvKDam5b049Mx42mNFLszpp7pjqJ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765411401; c=relaxed/simple;
	bh=igiMQsLjOhz5cY2LGvrKXRcBj78HfLCNsdk9eF76KOI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dDqWL3Ty6J4ZIDBqXUPrhaL9xLIMjDXnXfItbt4zkQvHE0i0ERKLCWMQ36C+jv6nFn1Y82dsHIvWNDaXANMQR0x8gppdvNAUuaR8fTg0wyQazbJVzq4QpL/flPoGl6zAKXGXIeb3ZSmjNzvPq4dszRXWgpL22sjKtyv7JnJmxoU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=SuZXITXF; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from [192.168.1.14] (c-67-168-176-124.hsd1.wa.comcast.net [67.168.176.124])
	by linux.microsoft.com (Postfix) with ESMTPSA id 548682120E96;
	Wed, 10 Dec 2025 16:03:17 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 548682120E96
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1765411398;
	bh=agree12y1grf6aPQgtPvR0pm6ID93QqHUtSaG1CfH8E=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=SuZXITXFBQHypERaeuDjV+0mGAbHPCM/5K57vqSRO5t222Nl3XH7e+qLP6XTshq5W
	 kIUF4rhD82aTBjxaS4C1AQgn1fn6CBSzSyhoAlxMjgrQ+Z1P6/AsZZPQ72FSGmETMV
	 4r7PDDCcQgJXScUQD/6jj4pzHktH0KYNKtJVYGCk=
Message-ID: <9cb4cbab-bcca-4ac8-a7a5-0cf3de67353e@linux.microsoft.com>
Date: Wed, 10 Dec 2025 16:03:16 -0800
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC][PATCH] ima: Add support for staging measurements for
 deletion
To: Roberto Sassu <roberto.sassu@huaweicloud.com>, corbet@lwn.net,
 zohar@linux.ibm.com, dmitry.kasatkin@gmail.com, eric.snowberg@oracle.com,
 paul@paul-moore.com, jmorris@namei.org, serge@hallyn.com
Cc: linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-integrity@vger.kernel.org, linux-security-module@vger.kernel.org,
 gregorylumen@linux.microsoft.com, nramas@linux.microsoft.com,
 Roberto Sassu <roberto.sassu@huawei.com>,
 steven chen <chenste@linux.microsoft.com>
References: <20251209101725.3680225-1-roberto.sassu@huaweicloud.com>
Content-Language: en-US
From: steven chen <chenste@linux.microsoft.com>
In-Reply-To: <20251209101725.3680225-1-roberto.sassu@huaweicloud.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 12/9/2025 2:17 AM, Roberto Sassu wrote:
> From: Roberto Sassu <roberto.sassu@huawei.com>
>
> Introduce the ability of staging the entire of the IMA measurement list, or
> a portion, for deletion. Staging means moving the current content of the
> measurement list to a separate location, and allowing users to read and
> delete it. This causes the measurement list to be atomically truncated
> before new measurements can be added. Staging can be done only once at a
> time.
>
> User space is responsible to concatenate the staged IMA measurements list
> portions following the temporal order in which the operations were done,
> together with the current measurement list. Then, it can send the collected
> data to the remote verifiers.
>
> The benefit of this solution is the ability to free precious kernel memory,
> in exchange of delegating user space to reconstruct the full measurement
> list from the chunks. No trust needs to be given to user space, since the
> integrity of the measurement list is protected by the TPM.
>
> By default, staging the measurements list for deletion does not alter the
> hash table. When staging is done, IMA is still able to detect collisions on
> the staged and later deleted measurement entries, by keeping the entry
> digests (only template data are freed).
>
> However, since during the measurements list serialization only the SHA1
> digest is passed, and since there are no template data to recalculate the
> other digests from, the hash table is currently not populated with digests
> from staged/deleted entries after kexec().
>
> Introduce the new kernel option ima_flush_htable to decide whether or not
> the digests of staged measurement entries are flushed from the hash table.
>
> Then, introduce ascii_runtime_measurements_staged_<algo> and
> binary_runtime_measurement_staged_<algo> interfaces to stage/delete the
> measurements. Use 'echo A > <IMA interface>' and 'echo D > <IMA interface>'
> to respectively stage and delete the entire measurements list. Use
> 'echo N > <IMA interface>', with N between 1 and ULONG_MAX, to stage the
> selected portion of the measurements list.
>
> The ima_measure_users counter (protected by the ima_measure_lock mutex) has
> been introduced to protect access to the measurement list and the staged
> part. The open method of all the measurement interfaces has been extended
> to allow only one writer at a time or, in alternative, multiple readers.
> The write permission is used to stage/delete the measurements, the read
> permission to read them. Write requires also the CAP_SYS_ADMIN capability.

Hi Roberto,

I released version 2 of trim N entries patch as bellow:

[PATCH v2 0/1] Trim N entries of IMA event logs 
<https://lore.kernel.org/linux-integrity/20251210235314.3341-1-chenste@linux.microsoft.com/T/#t>

I adapted some of your idea and I think trim N has following advantages:
1: less measurement list hold time than your current implementation
2. operation much simple for user space
3. less kernel code change
4. no potential issue as Gregory mentioned.

Thanks,

Steven

> Finally, introduce the _notrim version of the run-time measurements count
> and the binary measurements list size, to display them in the kexec-related
> critical data records.
>
> Note: This code derives from the Alt-IMA Huawei project, and is being
>        released under the dual license model (GPL-2.0 OR MIT).
>
> Link: https://github.com/linux-integrity/linux/issues/1
> Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>
> ---
>   .../admin-guide/kernel-parameters.txt         |   4 +
>   security/integrity/ima/ima.h                  |  10 +-
>   security/integrity/ima/ima_fs.c               | 222 +++++++++++++++++-
>   security/integrity/ima/ima_kexec.c            |  13 +-
>   security/integrity/ima/ima_queue.c            | 111 ++++++++-
>   5 files changed, 340 insertions(+), 20 deletions(-)
>
> diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
> index 6c42061ca20e..355d8930e3ac 100644
> --- a/Documentation/admin-guide/kernel-parameters.txt
> +++ b/Documentation/admin-guide/kernel-parameters.txt
> @@ -2215,6 +2215,10 @@
>   			Use the canonical format for the binary runtime
>   			measurements, instead of host native format.
>   
> +	ima_flush_htable  [IMA]
> +			Flush the measurement list hash table when staging all
> +			or a part of it for deletion.
> +
>   	ima_hash=	[IMA]
>   			Format: { md5 | sha1 | rmd160 | sha256 | sha384
>   				   | sha512 | ... }
> diff --git a/security/integrity/ima/ima.h b/security/integrity/ima/ima.h
> index e3d71d8d56e3..d7aa4a0f79b1 100644
> --- a/security/integrity/ima/ima.h
> +++ b/security/integrity/ima/ima.h
> @@ -117,6 +117,8 @@ struct ima_queue_entry {
>   	struct ima_template_entry *entry;
>   };
>   extern struct list_head ima_measurements;	/* list of all measurements */
> +extern struct list_head ima_measurements_staged; /* list of staged meas. */
> +extern bool ima_measurements_staged_exist;	/* If there are staged meas. */
>   
>   /* Some details preceding the binary serialized measurement list */
>   struct ima_kexec_hdr {
> @@ -281,10 +283,12 @@ struct ima_template_desc *ima_template_desc_current(void);
>   struct ima_template_desc *ima_template_desc_buf(void);
>   struct ima_template_desc *lookup_template_desc(const char *name);
>   bool ima_template_has_modsig(const struct ima_template_desc *ima_template);
> +int ima_queue_stage(unsigned long req_value);
> +int ima_queue_delete_staged(void);
>   int ima_restore_measurement_entry(struct ima_template_entry *entry);
>   int ima_restore_measurement_list(loff_t bufsize, void *buf);
>   int ima_measurements_show(struct seq_file *m, void *v);
> -unsigned long ima_get_binary_runtime_size(void);
> +unsigned long ima_get_binary_runtime_size(bool notrim);
>   int ima_init_template(void);
>   void ima_init_template_list(void);
>   int __init ima_init_digests(void);
> @@ -298,11 +302,13 @@ int ima_lsm_policy_change(struct notifier_block *nb, unsigned long event,
>   extern spinlock_t ima_queue_lock;
>   
>   struct ima_h_table {
> -	atomic_long_t len;	/* number of stored measurements in the list */
> +	atomic_long_t len;	/* current num of stored meas. in the list */
> +	atomic_long_t len_notrim; /* total num of stored meas. in the list */
>   	atomic_long_t violations;
>   	struct hlist_head queue[IMA_MEASURE_HTABLE_SIZE];
>   };
>   extern struct ima_h_table ima_htable;
> +extern struct mutex ima_extend_list_mutex;
>   
>   static inline unsigned int ima_hash_key(u8 *digest)
>   {
> diff --git a/security/integrity/ima/ima_fs.c b/security/integrity/ima/ima_fs.c
> index 87045b09f120..321c98ae0e55 100644
> --- a/security/integrity/ima/ima_fs.c
> +++ b/security/integrity/ima/ima_fs.c
> @@ -24,7 +24,12 @@
>   
>   #include "ima.h"
>   
> +/* Requests: ('A', [1, ULONG_MAX])\n (stage all/N) or D\n (delete staged) */
> +#define STAGED_REQ_LENGTH 21
> +
>   static DEFINE_MUTEX(ima_write_mutex);
> +static DEFINE_MUTEX(ima_measure_lock);
> +static long ima_measure_users;
>   
>   bool ima_canonical_fmt;
>   static int __init default_canonical_fmt_setup(char *str)
> @@ -74,14 +79,15 @@ static const struct file_operations ima_measurements_count_ops = {
>   };
>   
>   /* returns pointer to hlist_node */
> -static void *ima_measurements_start(struct seq_file *m, loff_t *pos)
> +static void *_ima_measurements_start(struct seq_file *m, loff_t *pos,
> +				     struct list_head *head)
>   {
>   	loff_t l = *pos;
>   	struct ima_queue_entry *qe;
>   
>   	/* we need a lock since pos could point beyond last element */
>   	rcu_read_lock();
> -	list_for_each_entry_rcu(qe, &ima_measurements, later) {
> +	list_for_each_entry_rcu(qe, head, later) {
>   		if (!l--) {
>   			rcu_read_unlock();
>   			return qe;
> @@ -91,7 +97,18 @@ static void *ima_measurements_start(struct seq_file *m, loff_t *pos)
>   	return NULL;
>   }
>   
> -static void *ima_measurements_next(struct seq_file *m, void *v, loff_t *pos)
> +static void *ima_measurements_start(struct seq_file *m, loff_t *pos)
> +{
> +	return _ima_measurements_start(m, pos, &ima_measurements);
> +}
> +
> +static void *ima_measurements_staged_start(struct seq_file *m, loff_t *pos)
> +{
> +	return _ima_measurements_start(m, pos, &ima_measurements_staged);
> +}
> +
> +static void *_ima_measurements_next(struct seq_file *m, void *v, loff_t *pos,
> +				    struct list_head *head)
>   {
>   	struct ima_queue_entry *qe = v;
>   
> @@ -103,7 +120,18 @@ static void *ima_measurements_next(struct seq_file *m, void *v, loff_t *pos)
>   	rcu_read_unlock();
>   	(*pos)++;
>   
> -	return (&qe->later == &ima_measurements) ? NULL : qe;
> +	return (&qe->later == head) ? NULL : qe;
> +}
> +
> +static void *ima_measurements_next(struct seq_file *m, void *v, loff_t *pos)
> +{
> +	return _ima_measurements_next(m, v, pos, &ima_measurements);
> +}
> +
> +static void *ima_measurements_staged_next(struct seq_file *m, void *v,
> +					  loff_t *pos)
> +{
> +	return _ima_measurements_next(m, v, pos, &ima_measurements_staged);
>   }
>   
>   static void ima_measurements_stop(struct seq_file *m, void *v)
> @@ -202,16 +230,138 @@ static const struct seq_operations ima_measurments_seqops = {
>   	.show = ima_measurements_show
>   };
>   
> +static int _ima_measurements_open(struct inode *inode, struct file *file,
> +				  const struct seq_operations *seq_ops)
> +{
> +	bool write = !!(file->f_mode & FMODE_WRITE);
> +	int ret;
> +
> +	if (write && !capable(CAP_SYS_ADMIN))
> +		return -EPERM;
> +
> +	mutex_lock(&ima_measure_lock);
> +	if ((write && ima_measure_users != 0) ||
> +	    (!write && ima_measure_users < 0)) {
> +		mutex_unlock(&ima_measure_lock);
> +		return -EBUSY;
> +	}
> +
> +	ret = seq_open(file, seq_ops);
> +	if (ret < 0) {
> +		mutex_unlock(&ima_measure_lock);
> +		return ret;
> +	}
> +
> +	if (write)
> +		ima_measure_users--;
> +	else
> +		ima_measure_users++;
> +
> +	mutex_unlock(&ima_measure_lock);
> +	return ret;
> +}
> +
>   static int ima_measurements_open(struct inode *inode, struct file *file)
>   {
> -	return seq_open(file, &ima_measurments_seqops);
> +	return _ima_measurements_open(inode, file, &ima_measurments_seqops);
> +}
> +
> +static int ima_measurements_release(struct inode *inode, struct file *file)
> +{
> +	bool write = !!(file->f_mode & FMODE_WRITE);
> +	int ret;
> +
> +	mutex_lock(&ima_measure_lock);
> +	ret = seq_release(inode, file);
> +	if (!ret) {
> +		if (write)
> +			ima_measure_users++;
> +		else
> +			ima_measure_users--;
> +	}
> +
> +	mutex_unlock(&ima_measure_lock);
> +	return ret;
>   }
>   
>   static const struct file_operations ima_measurements_ops = {
>   	.open = ima_measurements_open,
>   	.read = seq_read,
>   	.llseek = seq_lseek,
> -	.release = seq_release,
> +	.release = ima_measurements_release,
> +};
> +
> +static const struct seq_operations ima_measurments_staged_seqops = {
> +	.start = ima_measurements_staged_start,
> +	.next = ima_measurements_staged_next,
> +	.stop = ima_measurements_stop,
> +	.show = ima_measurements_show
> +};
> +
> +static int ima_measurements_staged_open(struct inode *inode, struct file *file)
> +{
> +	return _ima_measurements_open(inode, file,
> +				      &ima_measurments_staged_seqops);
> +}
> +
> +static ssize_t ima_measurements_staged_read(struct file *file, char __user *buf,
> +					    size_t size, loff_t *ppos)
> +{
> +	if (!ima_measurements_staged_exist)
> +		return -ENOENT;
> +
> +	return seq_read(file, buf, size, ppos);
> +}
> +
> +static ssize_t ima_measurements_staged_write(struct file *file,
> +					     const char __user *buf,
> +					     size_t datalen, loff_t *ppos)
> +{
> +	char req[STAGED_REQ_LENGTH], *req_ptr = req;
> +	unsigned long req_value;
> +	int ret;
> +
> +	if (*ppos > 0 || datalen < 2 || datalen > STAGED_REQ_LENGTH)
> +		return -EINVAL;
> +
> +	ret = copy_from_user(req, buf, datalen);
> +	if (ret < 0)
> +		return ret;
> +
> +	if (strsep(&req_ptr, "\n") == NULL)
> +		return -EINVAL;
> +
> +	switch (req[0]) {
> +	case 'A':
> +		if (datalen != 2 || req[1] != '\0')
> +			return -EINVAL;
> +
> +		ret = ima_queue_stage(ULONG_MAX);
> +		break;
> +	case 'D':
> +		if (datalen != 2 || req[1] != '\0')
> +			return -EINVAL;
> +
> +		ret = ima_queue_delete_staged();
> +		break;
> +	default:
> +		ret = kstrtoul(req, 0, &req_value);
> +		if (!ret)
> +			ret = ima_queue_stage(req_value);
> +	}
> +
> +	if (ret < 0)
> +		return ret;
> +
> +	return datalen;
> +}
> +
> +static const struct file_operations ima_measurements_staged_ops = {
> +	.open = ima_measurements_staged_open,
> +	.read = ima_measurements_staged_read,
> +	.write = ima_measurements_staged_write,
> +	.llseek = seq_lseek,
> +	.release = ima_measurements_release,
>   };
>   
>   void ima_print_digest(struct seq_file *m, u8 *digest, u32 size)
> @@ -279,14 +429,37 @@ static const struct seq_operations ima_ascii_measurements_seqops = {
>   
>   static int ima_ascii_measurements_open(struct inode *inode, struct file *file)
>   {
> -	return seq_open(file, &ima_ascii_measurements_seqops);
> +	return _ima_measurements_open(inode, file,
> +				      &ima_ascii_measurements_seqops);
>   }
>   
>   static const struct file_operations ima_ascii_measurements_ops = {
>   	.open = ima_ascii_measurements_open,
>   	.read = seq_read,
>   	.llseek = seq_lseek,
> -	.release = seq_release,
> +	.release = ima_measurements_release,
> +};
> +
> +static const struct seq_operations ima_ascii_measurements_staged_seqops = {
> +	.start = ima_measurements_staged_start,
> +	.next = ima_measurements_staged_next,
> +	.stop = ima_measurements_stop,
> +	.show = ima_ascii_measurements_show
> +};
> +
> +static int ima_ascii_measurements_staged_open(struct inode *inode,
> +					      struct file *file)
> +{
> +	return _ima_measurements_open(inode, file,
> +				      &ima_ascii_measurements_staged_seqops);
> +}
> +
> +static const struct file_operations ima_ascii_measurements_staged_ops = {
> +	.open = ima_ascii_measurements_staged_open,
> +	.read = ima_measurements_staged_read,
> +	.write = ima_measurements_staged_write,
> +	.llseek = seq_lseek,
> +	.release = ima_measurements_release,
>   };
>   
>   static ssize_t ima_read_policy(char *path)
> @@ -419,6 +592,25 @@ static int __init create_securityfs_measurement_lists(void)
>   						&ima_measurements_ops);
>   		if (IS_ERR(dentry))
>   			return PTR_ERR(dentry);
> +
> +		sprintf(file_name, "ascii_runtime_measurements_staged_%s",
> +			hash_algo_name[algo]);
> +		dentry = securityfs_create_file(file_name,
> +					S_IRUSR | S_IRGRP | S_IWUSR | S_IWGRP,
> +					ima_dir, (void *)(uintptr_t)i,
> +					&ima_ascii_measurements_staged_ops);
> +		if (IS_ERR(dentry))
> +			return PTR_ERR(dentry);
> +
> +		sprintf(file_name, "binary_runtime_measurements_staged_%s",
> +			hash_algo_name[algo]);
> +		dentry = securityfs_create_file(file_name,
> +						S_IRUSR | S_IRGRP |
> +						S_IWUSR | S_IWGRP,
> +						ima_dir, (void *)(uintptr_t)i,
> +						&ima_measurements_staged_ops);
> +		if (IS_ERR(dentry))
> +			return PTR_ERR(dentry);
>   	}
>   
>   	return 0;
> @@ -528,6 +720,20 @@ int __init ima_fs_init(void)
>   		goto out;
>   	}
>   
> +	dentry = securityfs_create_symlink("binary_runtime_measurements_staged",
> +		ima_dir, "binary_runtime_measurements_staged_sha1", NULL);
> +	if (IS_ERR(dentry)) {
> +		ret = PTR_ERR(dentry);
> +		goto out;
> +	}
> +
> +	dentry = securityfs_create_symlink("ascii_runtime_measurements_staged",
> +		ima_dir, "ascii_runtime_measurements_staged_sha1", NULL);
> +	if (IS_ERR(dentry)) {
> +		ret = PTR_ERR(dentry);
> +		goto out;
> +	}
> +
>   	dentry = securityfs_create_file("runtime_measurements_count",
>   				   S_IRUSR | S_IRGRP, ima_dir, NULL,
>   				   &ima_measurements_count_ops);
> diff --git a/security/integrity/ima/ima_kexec.c b/security/integrity/ima/ima_kexec.c
> index 7362f68f2d8b..23a20300da7b 100644
> --- a/security/integrity/ima/ima_kexec.c
> +++ b/security/integrity/ima/ima_kexec.c
> @@ -40,8 +40,8 @@ void ima_measure_kexec_event(const char *event_name)
>   	long len;
>   	int n;
>   
> -	buf_size = ima_get_binary_runtime_size();
> -	len = atomic_long_read(&ima_htable.len);
> +	buf_size = ima_get_binary_runtime_size(true);
> +	len = atomic_long_read(&ima_htable.len_notrim);
>   
>   	n = scnprintf(ima_kexec_event, IMA_KEXEC_EVENT_LEN,
>   		      "kexec_segment_size=%lu;ima_binary_runtime_size=%lu;"
> @@ -93,8 +93,10 @@ static int ima_dump_measurement_list(unsigned long *buffer_size, void **buffer,
>   
>   	memset(&khdr, 0, sizeof(khdr));
>   	khdr.version = 1;
> -	/* This is an append-only list, no need to hold the RCU read lock */
> -	list_for_each_entry_rcu(qe, &ima_measurements, later, true) {
> +
> +	/* It can race with ima_queue_stage(). */
> +	mutex_lock(&ima_extend_list_mutex);
> +	list_for_each_entry(qe, &ima_measurements, later) {
>   		if (ima_kexec_file.count < ima_kexec_file.size) {
>   			khdr.count++;
>   			ima_measurements_show(&ima_kexec_file, qe);
> @@ -103,6 +105,7 @@ static int ima_dump_measurement_list(unsigned long *buffer_size, void **buffer,
>   			break;
>   		}
>   	}
> +	mutex_unlock(&ima_extend_list_mutex);
>   
>   	/*
>   	 * fill in reserved space with some buffer details
> @@ -157,7 +160,7 @@ void ima_add_kexec_buffer(struct kimage *image)
>   	else
>   		extra_memory = CONFIG_IMA_KEXEC_EXTRA_MEMORY_KB * 1024;
>   
> -	binary_runtime_size = ima_get_binary_runtime_size() + extra_memory;
> +	binary_runtime_size = ima_get_binary_runtime_size(false) + extra_memory;
>   
>   	if (binary_runtime_size >= ULONG_MAX - PAGE_SIZE)
>   		kexec_segment_size = ULONG_MAX;
> diff --git a/security/integrity/ima/ima_queue.c b/security/integrity/ima/ima_queue.c
> index 590637e81ad1..868f216ac343 100644
> --- a/security/integrity/ima/ima_queue.c
> +++ b/security/integrity/ima/ima_queue.c
> @@ -22,19 +22,32 @@
>   
>   #define AUDIT_CAUSE_LEN_MAX 32
>   
> +bool ima_flush_htable;
> +static int __init ima_flush_htable_setup(char *str)
> +{
> +	ima_flush_htable = true;
> +	return 1;
> +}
> +__setup("ima_flush_htable", ima_flush_htable_setup);
> +
>   /* pre-allocated array of tpm_digest structures to extend a PCR */
>   static struct tpm_digest *digests;
>   
>   LIST_HEAD(ima_measurements);	/* list of all measurements */
> +LIST_HEAD(ima_measurements_staged); /* list of staged measurements */
> +bool ima_measurements_staged_exist; /* If there are staged measurements */
>   #ifdef CONFIG_IMA_KEXEC
>   static unsigned long binary_runtime_size;
> +static unsigned long binary_runtime_size_notrim;
>   #else
>   static unsigned long binary_runtime_size = ULONG_MAX;
> +static unsigned long binary_runtime_size_notrim = ULONG_MAX;
>   #endif
>   
>   /* key: inode (before secure-hashing a file) */
>   struct ima_h_table ima_htable = {
>   	.len = ATOMIC_LONG_INIT(0),
> +	.len_notrim = ATOMIC_LONG_INIT(0),
>   	.violations = ATOMIC_LONG_INIT(0),
>   	.queue[0 ... IMA_MEASURE_HTABLE_SIZE - 1] = HLIST_HEAD_INIT
>   };
> @@ -43,7 +56,7 @@ struct ima_h_table ima_htable = {
>    * and extending the TPM PCR aggregate. Since tpm_extend can take
>    * long (and the tpm driver uses a mutex), we can't use the spinlock.
>    */
> -static DEFINE_MUTEX(ima_extend_list_mutex);
> +DEFINE_MUTEX(ima_extend_list_mutex);
>   
>   /*
>    * Used internally by the kernel to suspend measurements.
> @@ -114,15 +127,19 @@ static int ima_add_digest_entry(struct ima_template_entry *entry,
>   	list_add_tail_rcu(&qe->later, &ima_measurements);
>   
>   	atomic_long_inc(&ima_htable.len);
> +	atomic_long_inc(&ima_htable.len_notrim);
>   	if (update_htable) {
>   		key = ima_hash_key(entry->digests[ima_hash_algo_idx].digest);
>   		hlist_add_head_rcu(&qe->hnext, &ima_htable.queue[key]);
>   	}
>   
> -	if (binary_runtime_size != ULONG_MAX) {
> +	if (binary_runtime_size_notrim != ULONG_MAX) {
>   		int size;
>   
>   		size = get_binary_runtime_size(entry);
> +		binary_runtime_size_notrim =
> +		     (binary_runtime_size_notrim < ULONG_MAX - size) ?
> +		     binary_runtime_size_notrim + size : ULONG_MAX;
>   		binary_runtime_size = (binary_runtime_size < ULONG_MAX - size) ?
>   		     binary_runtime_size + size : ULONG_MAX;
>   	}
> @@ -134,12 +151,18 @@ static int ima_add_digest_entry(struct ima_template_entry *entry,
>    * entire binary_runtime_measurement list, including the ima_kexec_hdr
>    * structure.
>    */
> -unsigned long ima_get_binary_runtime_size(void)
> +unsigned long ima_get_binary_runtime_size(bool notrim)
>   {
> -	if (binary_runtime_size >= (ULONG_MAX - sizeof(struct ima_kexec_hdr)))
> +	unsigned long *val;
> +
> +	mutex_lock(&ima_extend_list_mutex);
> +	val = (notrim) ? &binary_runtime_size_notrim : &binary_runtime_size;
> +	mutex_unlock(&ima_extend_list_mutex);
> +
> +	if (*val >= (ULONG_MAX - sizeof(struct ima_kexec_hdr)))
>   		return ULONG_MAX;
>   	else
> -		return binary_runtime_size + sizeof(struct ima_kexec_hdr);
> +		return *val + sizeof(struct ima_kexec_hdr);
>   }
>   
>   static int ima_pcr_extend(struct tpm_digest *digests_arg, int pcr)
> @@ -220,6 +243,84 @@ int ima_add_template_entry(struct ima_template_entry *entry, int violation,
>   	return result;
>   }
>   
> +int ima_queue_stage(unsigned long req_value)
> +{
> +	unsigned long req_value_copy = req_value, to_remove = 0;
> +	struct ima_queue_entry *qe;
> +
> +	if (ima_measurements_staged_exist)
> +		return -EEXIST;
> +
> +	mutex_lock(&ima_extend_list_mutex);
> +	if (list_empty(&ima_measurements)) {
> +		mutex_unlock(&ima_extend_list_mutex);
> +		return -ENOENT;
> +	}
> +
> +	if (req_value == ULONG_MAX) {
> +		list_replace(&ima_measurements, &ima_measurements_staged);
> +		INIT_LIST_HEAD(&ima_measurements);
> +		atomic_long_set(&ima_htable.len, 0);
> +		if (IS_ENABLED(CONFIG_IMA_KEXEC))
> +			binary_runtime_size = 0;
> +	} else {
> +		list_for_each_entry(qe, &ima_measurements, later) {
> +			to_remove += get_binary_runtime_size(qe->entry);
> +			if (--req_value_copy == 0)
> +				break;
> +		}
> +
> +		if (req_value_copy > 0) {
> +			mutex_unlock(&ima_extend_list_mutex);
> +			return -ENOENT;
> +		}
> +
> +		__list_cut_position(&ima_measurements_staged, &ima_measurements,
> +				    &qe->later);
> +		atomic_long_sub(req_value, &ima_htable.len);
> +		if (IS_ENABLED(CONFIG_IMA_KEXEC))
> +			binary_runtime_size -= to_remove;
> +	}
> +
> +	if (ima_flush_htable) {
> +		list_for_each_entry(qe, &ima_measurements_staged, later)
> +			/* It can race with ima_lookup_digest_entry(). */
> +			hlist_del_rcu(&qe->hnext);
> +	}
> +
> +	mutex_unlock(&ima_extend_list_mutex);
> +	ima_measurements_staged_exist = true;
> +	return 0;
> +}
> +
> +int ima_queue_delete_staged(void)
> +{
> +	struct ima_queue_entry *qe, *qe_tmp;
> +	unsigned int i;
> +
> +	if (!ima_measurements_staged_exist)
> +		return -ENOENT;
> +
> +	list_for_each_entry_safe(qe, qe_tmp, &ima_measurements_staged, later) {
> +		for (i = 0; i < qe->entry->template_desc->num_fields; i++) {
> +			kfree(qe->entry->template_data[i].data);
> +			qe->entry->template_data[i].data = NULL;
> +			qe->entry->template_data[i].len = 0;
> +		}
> +
> +		list_del(&qe->later);
> +
> +		if (ima_flush_htable) {
> +			kfree(qe->entry->digests);
> +			kfree(qe->entry);
> +			kfree(qe);
> +		}
> +	}
> +
> +	ima_measurements_staged_exist = false;
> +	return 0;
> +}
> +
>   int ima_restore_measurement_entry(struct ima_template_entry *entry)
>   {
>   	int result = 0;



