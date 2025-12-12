Return-Path: <linux-integrity+bounces-7939-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D0D69CB9B0F
	for <lists+linux-integrity@lfdr.de>; Fri, 12 Dec 2025 20:49:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 833FA30946E7
	for <lists+linux-integrity@lfdr.de>; Fri, 12 Dec 2025 19:47:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3288325700;
	Fri, 12 Dec 2025 19:41:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="HpHVc+SH"
X-Original-To: linux-integrity@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6852B3254B6;
	Fri, 12 Dec 2025 19:41:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765568481; cv=none; b=TgkkIyu39ueKwp4cjA3a8P7hYJoWXKdFhZkomIKbNapvKA/c10Zae4AxFyyzfavYLEN8cRDFM7/R0G4lBCHtHYqt7KS4siPRHfjZNFHlwUp8Fgnp7rmH2p8AIaLD1TyyfqEAtu8D9mVKyQwQDIY1Tvxh6uYNzlDu4jQidrPasJo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765568481; c=relaxed/simple;
	bh=veneZt6uzfxEfphvdbmRdmM7wiVIPWA21hhP5GxbfCA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Bqx9fxaU8HnSX6HlppAOyiaK7Mt2/r8iZPuNiz2KwCGgMn/puUhd1VvI46QwSFJQg91FCkolOL2CkgMi/ZJMRlsKAZZd+IzI6xy34Hb0UqHZneEEC2TmljyCUvSA57ClOq21FSecWByiGDU7wETHzxMABUXDtXADAeeWRxBJpHU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=HpHVc+SH; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from [10.17.64.150] (unknown [131.107.8.22])
	by linux.microsoft.com (Postfix) with ESMTPSA id 5C597211B7C0;
	Fri, 12 Dec 2025 11:41:11 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 5C597211B7C0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1765568471;
	bh=neHdLwRPRwiLshpVv7uZMsfOrA9pDZcx/GLYvlAWDqo=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=HpHVc+SHuu+Mnurfb55gydYRSXN686Cw02Q2h8g/EtLNE1r2NHt8gVJrNxw7q/60/
	 fqgp9E5KHqJ8mJx+0UioYDbbfp6LnKag4Ig6cT+FFoUScpKPHXwJvDV/NOb0hwfRlu
	 Buq3cA+ObcbuEhsPSvJvxLKy87bQsCcbEd1vc0K0=
Message-ID: <ee41e18a-6f58-47d4-a6bc-797cef8317c3@linux.microsoft.com>
Date: Fri, 12 Dec 2025 11:41:10 -0800
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC][PATCH v2] ima: Add support for staging measurements for
 deletion and trimming
To: Roberto Sassu <roberto.sassu@huaweicloud.com>, corbet@lwn.net,
 zohar@linux.ibm.com, dmitry.kasatkin@gmail.com, eric.snowberg@oracle.com,
 paul@paul-moore.com, jmorris@namei.org, serge@hallyn.com
Cc: linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-integrity@vger.kernel.org, linux-security-module@vger.kernel.org,
 gregorylumen@linux.microsoft.com, nramas@linux.microsoft.com,
 Roberto Sassu <roberto.sassu@huawei.com>,
 steven chen <chenste@linux.microsoft.com>
References: <20251212171932.316676-1-roberto.sassu@huaweicloud.com>
Content-Language: en-US
From: steven chen <chenste@linux.microsoft.com>
In-Reply-To: <20251212171932.316676-1-roberto.sassu@huaweicloud.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 12/12/2025 9:19 AM, Roberto Sassu wrote:
> From: Roberto Sassu <roberto.sassu@huawei.com>
>
> Introduce the ability of staging the entire (or a portion of the) IMA
> measurement list for deletion. Staging means moving the current content of
> the measurement list to a separate location, and allowing users to read and
> delete it. This causes the measurement list to be atomically truncated
> before new measurements can be added. Staging can be done only once at a
> time. In the event of kexec(), staging is reverted and staged entries will
> be carried over to the new kernel.
>
> User space is responsible to concatenate the staged IMA measurements list
> portions following the temporal order in which the operations were done,
> together with the current measurement list. Then, it can send the collected
> data to the remote verifiers.
>
> Also introduce the ability of trimming N measurements entries from the IMA
> measurements list, provided that user space has already read them. Trimming
> combines staging and deletion in one operation.
>
> The benefit of these solutions is the ability to free precious kernel
> memory, in exchange of delegating user space to reconstruct the full
> measurement list from the chunks. No trust needs to be given to user space,
> since the integrity of the measurement list is protected by the TPM.
>
> By default, staging/trimming the measurements list does not alter the hash
> table. When staging/trimming are done, IMA is still able to detect
> collisions on the staged and later deleted measurement entries, by keeping
> the entry digests (only template data are freed).
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
> binary_runtime_measurement_staged_<algo> interfaces to stage/trim/delete
> the measurements. Use 'echo A > <IMA interface>' and
> 'echo D > <IMA interface>' to respectively stage and delete the entire
> measurements list. Use 'echo N > <IMA interface>', with N between 1 and
> LONG_MAX, to stage the selected portion of the measurements list, and
> 'echo -N > <IMA interface>' to trim N measurements entries.
>
> The ima_measure_users counter (protected by the ima_measure_lock mutex) has
> been introduced to protect access to the measurements list and the staged
> part. The open method of all the measurement interfaces has been extended
> to allow only one writer at a time or, in alternative, multiple readers.
> The write permission is used to stage/trim/delete the measurements, the
> read permission to read them. Write requires also the CAP_SYS_ADMIN
> capability.
>
> Finally, introduce and maintain dedicate counters for the number of
> measurement entries and binary size, for the current measurements list
> (BINARY_SIZE), for the current measurements list plus staged entries
> (BINARY_SIZE_STAGED) useful for kexec() segment allocation, and for the
> entire measurement list without staging/trimming (BINARY_SIZE_FULL) useful
> for the kexec-related critical data records.
Hello Roberto,

I think staged N proposal without one step trim N solution has following 
shortages compare
"one step trim N solution":
     list lock time longer
     UM need to do more work
     implementation more complex
     more code changed/added
     not energy green: cost more to run the function

I appreciate that you have fully incorporated my one-step solution for 
trimming N entries
into your RFC. I will now review your proposed roadmap and compare it 
with mine.

               Roberto’s                 |      Steven’s
                                         |
Version 0:  Snapshot (staged)           |     Trim N entries, one step 
(version 1)
               Two steps to trim log     |        One step to trim log
                                         |
                                         |
Version 1:  Staged N                    |     Trim N entries, one step 
(version 2)
              Two steps to trim log      |        One step to trim log
                                         |
               Take “N” from Steven’s    |
                                         |        Resolve comments (From 
Roberto, acked)
                                         |        Performance 
improvement (From Roberto, acked)
                                         |
                                         |
Version 2:  Staged plus                 |     Trim N entries, one step
                Two step to trim log     |        One step to trim log
                                         |
                Take “N” from Steven’s   |
                One step from Steven's   |
                                         |        will release soon
                                         |        Will take good points 
from everyone
                                         |
Possible                                |
Version 3:  Trim N entries, one step (please refer to Steven's proposal)
               No body will need Staged
               because of no value


The follow are differences of two proposals:

                                The cost of proposal

        Staged without "one step trim N" |     Trim N entries, one step
                                         |
   running cost:      150 cents          |        100 cents (for example)
     code added:      400+               |        200+


                               The complex of proposal

        Staged without "one step trim N" |     Trim N entries, one step
            total 6 steps                |       total 3 steps
                                         |
         1. UM reads list without lock   |     1. UM reads list without lock
         2. UM stages list with lock     |     2. UM decides to trim N 
entries
         3. UM decides to trim N entries |     3. Kernel trim log with lock
         4. Kernel trim staged list      |
         5. kexec save the staged list   |
         6. kexec restore the staged list|


                               The lock time of proposal

        Staged without "one step trim N" |     Trim N entries, one step
                                         |
               time 1 ms (for example)   |      should less than 1 ms


I think everyone knows the Trim N entries one step solution is the best 
for now.

If you insist on staged, it is not good for open source community!!!

You did not reply my comments in your version 1 release so I add refer here.

[RFC][PATCH] ima: Add support for staging measurements for deletion
https://lore.kernel.org/linux-integrity/207fd6d7-53c-57bb-36d8-13a0902052d1@linux.microsoft.com/T/#t

I also add my Trim N entries on step version 2 refer here.

[PATCH v2 0/1] Trim N entries of IMA event logs
https://lore.kernel.org/linux-integrity/20251210235314.3341-1-chenste@linux.microsoft.com/T/#t

Thanks,

Steven

> Note: This code derives from the Alt-IMA Huawei project, and is being
>        released under the dual license model (GPL-2.0 OR MIT).
>
> Link: https://github.com/linux-integrity/linux/issues/1
> Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>
> ---
>   .../admin-guide/kernel-parameters.txt         |   4 +
>   security/integrity/ima/ima.h                  |  18 +-
>   security/integrity/ima/ima_fs.c               | 240 +++++++++++++++++-
>   security/integrity/ima/ima_kexec.c            |  42 ++-
>   security/integrity/ima/ima_queue.c            | 169 +++++++++++-
>   5 files changed, 439 insertions(+), 34 deletions(-)
>
> diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
> index 6c42061ca20e..e5f1e11bd0a2 100644
> --- a/Documentation/admin-guide/kernel-parameters.txt
> +++ b/Documentation/admin-guide/kernel-parameters.txt
> @@ -2215,6 +2215,10 @@
>   			Use the canonical format for the binary runtime
>   			measurements, instead of host native format.
>   
> +	ima_flush_htable  [IMA]
> +			Flush the IMA hash table when staging for deletion or
> +			trimming measurement entries.
> +
>   	ima_hash=	[IMA]
>   			Format: { md5 | sha1 | rmd160 | sha256 | sha384
>   				   | sha512 | ... }
> diff --git a/security/integrity/ima/ima.h b/security/integrity/ima/ima.h
> index e3d71d8d56e3..8a6be4284210 100644
> --- a/security/integrity/ima/ima.h
> +++ b/security/integrity/ima/ima.h
> @@ -28,6 +28,15 @@ enum ima_show_type { IMA_SHOW_BINARY, IMA_SHOW_BINARY_NO_FIELD_LEN,
>   		     IMA_SHOW_BINARY_OLD_STRING_FMT, IMA_SHOW_ASCII };
>   enum tpm_pcrs { TPM_PCR0 = 0, TPM_PCR8 = 8, TPM_PCR10 = 10 };
>   
> +/*
> + * BINARY_SIZE: size of the current measurements list
> + * BINARY_SIZE_STAGED: size of current measurements list + staged entries
> + * BINARY_SIZE_FULL: size of measurements list since IMA initialization
> + */
> +enum binary_size_types {
> +	BINARY_SIZE, BINARY_SIZE_STAGED, BINARY_SIZE_FULL, BINARY__LAST
> +};
> +
>   /* digest size for IMA, fits SHA1 or MD5 */
>   #define IMA_DIGEST_SIZE		SHA1_DIGEST_SIZE
>   #define IMA_EVENT_NAME_LEN_MAX	255
> @@ -117,6 +126,8 @@ struct ima_queue_entry {
>   	struct ima_template_entry *entry;
>   };
>   extern struct list_head ima_measurements;	/* list of all measurements */
> +extern struct list_head ima_measurements_staged; /* list of staged meas. */
> +extern bool ima_measurements_staged_exist;	/* If there are staged meas. */
>   
>   /* Some details preceding the binary serialized measurement list */
>   struct ima_kexec_hdr {
> @@ -281,10 +292,12 @@ struct ima_template_desc *ima_template_desc_current(void);
>   struct ima_template_desc *ima_template_desc_buf(void);
>   struct ima_template_desc *lookup_template_desc(const char *name);
>   bool ima_template_has_modsig(const struct ima_template_desc *ima_template);
> +int ima_queue_stage_trim(unsigned long req_value, bool trim);
> +int ima_queue_delete_staged_trimmed(bool staged_moved);
>   int ima_restore_measurement_entry(struct ima_template_entry *entry);
>   int ima_restore_measurement_list(loff_t bufsize, void *buf);
>   int ima_measurements_show(struct seq_file *m, void *v);
> -unsigned long ima_get_binary_runtime_size(void);
> +unsigned long ima_get_binary_runtime_size(enum binary_size_types type);
>   int ima_init_template(void);
>   void ima_init_template_list(void);
>   int __init ima_init_digests(void);
> @@ -298,11 +311,12 @@ int ima_lsm_policy_change(struct notifier_block *nb, unsigned long event,
>   extern spinlock_t ima_queue_lock;
>   
>   struct ima_h_table {
> -	atomic_long_t len;	/* number of stored measurements in the list */
> +	atomic_long_t len[BINARY__LAST]; /* num of stored meas. in the list */
>   	atomic_long_t violations;
>   	struct hlist_head queue[IMA_MEASURE_HTABLE_SIZE];
>   };
>   extern struct ima_h_table ima_htable;
> +extern struct mutex ima_extend_list_mutex;
>   
>   static inline unsigned int ima_hash_key(u8 *digest)
>   {
> diff --git a/security/integrity/ima/ima_fs.c b/security/integrity/ima/ima_fs.c
> index 87045b09f120..a96f7c36b34a 100644
> --- a/security/integrity/ima/ima_fs.c
> +++ b/security/integrity/ima/ima_fs.c
> @@ -24,7 +24,18 @@
>   
>   #include "ima.h"
>   
> +/*
> + * Requests:
> + * 'A\n': stage the entire measurements list
> + * '[1, LONG_MAX]\n' stage N measurements entries
> + * '-[1, LONG_MAX]\n' trim N measurements entries
> + * 'D\n': delete staged measurements
> + */
> +#define STAGED_REQ_LENGTH 21
> +
>   static DEFINE_MUTEX(ima_write_mutex);
> +static DEFINE_MUTEX(ima_measure_lock);
> +static long ima_measure_users;
>   
>   bool ima_canonical_fmt;
>   static int __init default_canonical_fmt_setup(char *str)
> @@ -64,7 +75,8 @@ static ssize_t ima_show_measurements_count(struct file *filp,
>   					   char __user *buf,
>   					   size_t count, loff_t *ppos)
>   {
> -	return ima_show_htable_value(buf, count, ppos, &ima_htable.len);
> +	return ima_show_htable_value(buf, count, ppos,
> +				     &ima_htable.len[BINARY_SIZE]);
>   
>   }
>   
> @@ -74,14 +86,15 @@ static const struct file_operations ima_measurements_count_ops = {
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
> @@ -91,7 +104,18 @@ static void *ima_measurements_start(struct seq_file *m, loff_t *pos)
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
> @@ -103,7 +127,18 @@ static void *ima_measurements_next(struct seq_file *m, void *v, loff_t *pos)
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
> @@ -202,16 +237,147 @@ static const struct seq_operations ima_measurments_seqops = {
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
> +	bool trim = false;
> +	int ret;
> +
> +	if (*ppos > 0 || datalen < 2 || datalen > STAGED_REQ_LENGTH)
> +		return -EINVAL;
> +
> +	if (copy_from_user(req, buf, datalen) != 0)
> +		return -EFAULT;
> +
> +	if (req[datalen - 1] != '\n')
> +		return -EINVAL;
> +
> +	req[datalen - 1] = '\0';
> +	req_ptr = req;
> +
> +	switch (req[0]) {
> +	case 'A':
> +		if (datalen != 2 || req[1] != '\0')
> +			return -EINVAL;
> +
> +		ret = ima_queue_stage_trim(LONG_MAX, false);
> +		break;
> +	case 'D':
> +		if (datalen != 2 || req[1] != '\0')
> +			return -EINVAL;
> +
> +		ret = ima_queue_delete_staged_trimmed(false);
> +		break;
> +	case '-':
> +		trim = true;
> +		req_ptr++;
> +		fallthrough;
> +	default:
> +		ret = kstrtoul(req_ptr, 0, &req_value);
> +		if (ret < 0)
> +			return ret;
> +
> +		ret = ima_queue_stage_trim(req_value, trim);
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
> @@ -279,14 +445,37 @@ static const struct seq_operations ima_ascii_measurements_seqops = {
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
> @@ -419,6 +608,25 @@ static int __init create_securityfs_measurement_lists(void)
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
> @@ -528,6 +736,20 @@ int __init ima_fs_init(void)
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
> index 7362f68f2d8b..13c7e78aeefd 100644
> --- a/security/integrity/ima/ima_kexec.c
> +++ b/security/integrity/ima/ima_kexec.c
> @@ -40,8 +40,8 @@ void ima_measure_kexec_event(const char *event_name)
>   	long len;
>   	int n;
>   
> -	buf_size = ima_get_binary_runtime_size();
> -	len = atomic_long_read(&ima_htable.len);
> +	buf_size = ima_get_binary_runtime_size(BINARY_SIZE_FULL);
> +	len = atomic_long_read(&ima_htable.len[BINARY_SIZE_FULL]);
>   
>   	n = scnprintf(ima_kexec_event, IMA_KEXEC_EVENT_LEN,
>   		      "kexec_segment_size=%lu;ima_binary_runtime_size=%lu;"
> @@ -78,6 +78,17 @@ static int ima_alloc_kexec_file_buf(size_t segment_size)
>   	return 0;
>   }
>   
> +static int ima_dump_measurement(struct ima_kexec_hdr *khdr,
> +				struct ima_queue_entry *qe)
> +{
> +	if (ima_kexec_file.count >= ima_kexec_file.size)
> +		return -EINVAL;
> +
> +	khdr->count++;
> +	ima_measurements_show(&ima_kexec_file, qe);
> +	return 0;
> +}
> +
>   static int ima_dump_measurement_list(unsigned long *buffer_size, void **buffer,
>   				     unsigned long segment_size)
>   {
> @@ -93,17 +104,25 @@ static int ima_dump_measurement_list(unsigned long *buffer_size, void **buffer,
>   
>   	memset(&khdr, 0, sizeof(khdr));
>   	khdr.version = 1;
> -	/* This is an append-only list, no need to hold the RCU read lock */
> -	list_for_each_entry_rcu(qe, &ima_measurements, later, true) {
> -		if (ima_kexec_file.count < ima_kexec_file.size) {
> -			khdr.count++;
> -			ima_measurements_show(&ima_kexec_file, qe);
> -		} else {
> -			ret = -EINVAL;
> +
> +	/* It can race with ima_queue_stage_trim(). */
> +	mutex_lock(&ima_extend_list_mutex);
> +
> +	list_for_each_entry(qe, &ima_measurements_staged, later) {
> +		ret = ima_dump_measurement(&khdr, qe);
> +		if (ret < 0)
> +			break;
> +	}
> +
> +	list_for_each_entry(qe, &ima_measurements, later) {
> +		if (!ret)
> +			ret = ima_dump_measurement(&khdr, qe);
> +		if (ret < 0)
>   			break;
> -		}
>   	}
>   
> +	mutex_unlock(&ima_extend_list_mutex);
> +
>   	/*
>   	 * fill in reserved space with some buffer details
>   	 * (eg. version, buffer size, number of measurements)
> @@ -157,7 +176,8 @@ void ima_add_kexec_buffer(struct kimage *image)
>   	else
>   		extra_memory = CONFIG_IMA_KEXEC_EXTRA_MEMORY_KB * 1024;
>   
> -	binary_runtime_size = ima_get_binary_runtime_size() + extra_memory;
> +	binary_runtime_size = ima_get_binary_runtime_size(BINARY_SIZE_STAGED) +
> +			      extra_memory;
>   
>   	if (binary_runtime_size >= ULONG_MAX - PAGE_SIZE)
>   		kexec_segment_size = ULONG_MAX;
> diff --git a/security/integrity/ima/ima_queue.c b/security/integrity/ima/ima_queue.c
> index 590637e81ad1..7dfa24b8ae31 100644
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
> +static LIST_HEAD(ima_measurements_trim); /* list of measurements to trim */
> +bool ima_measurements_staged_exist; /* If there are staged measurements */
>   #ifdef CONFIG_IMA_KEXEC
> -static unsigned long binary_runtime_size;
> +static unsigned long binary_runtime_size[BINARY__LAST];
>   #else
> -static unsigned long binary_runtime_size = ULONG_MAX;
> +static unsigned long binary_runtime_size[BINARY_SIZE] = ULONG_MAX;
> +static unsigned long binary_runtime_size[BINARY_SIZE_FULL] = ULONG_MAX;
> +static unsigned long binary_runtime_size[BINARY_SIZE_STAGED] = ULONG_MAX;
>   #endif
>   
>   /* key: inode (before secure-hashing a file) */
>   struct ima_h_table ima_htable = {
> -	.len = ATOMIC_LONG_INIT(0),
> +	.len = { ATOMIC_LONG_INIT(0) },
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
> @@ -101,7 +114,7 @@ static int ima_add_digest_entry(struct ima_template_entry *entry,
>   				bool update_htable)
>   {
>   	struct ima_queue_entry *qe;
> -	unsigned int key;
> +	unsigned int i, key;
>   
>   	qe = kmalloc(sizeof(*qe), GFP_KERNEL);
>   	if (qe == NULL) {
> @@ -113,18 +126,23 @@ static int ima_add_digest_entry(struct ima_template_entry *entry,
>   	INIT_LIST_HEAD(&qe->later);
>   	list_add_tail_rcu(&qe->later, &ima_measurements);
>   
> -	atomic_long_inc(&ima_htable.len);
> +	for (i = 0; i < BINARY__LAST; i++)
> +		atomic_long_inc(&ima_htable.len[i]);
> +
>   	if (update_htable) {
>   		key = ima_hash_key(entry->digests[ima_hash_algo_idx].digest);
>   		hlist_add_head_rcu(&qe->hnext, &ima_htable.queue[key]);
>   	}
>   
> -	if (binary_runtime_size != ULONG_MAX) {
> +	if (binary_runtime_size[BINARY_SIZE_FULL] != ULONG_MAX) {
>   		int size;
>   
>   		size = get_binary_runtime_size(entry);
> -		binary_runtime_size = (binary_runtime_size < ULONG_MAX - size) ?
> -		     binary_runtime_size + size : ULONG_MAX;
> +
> +		for (i = 0; i < BINARY__LAST; i++)
> +			binary_runtime_size[i] =
> +				(binary_runtime_size[i] < ULONG_MAX - size) ?
> +				binary_runtime_size[i] + size : ULONG_MAX;
>   	}
>   	return 0;
>   }
> @@ -134,12 +152,18 @@ static int ima_add_digest_entry(struct ima_template_entry *entry,
>    * entire binary_runtime_measurement list, including the ima_kexec_hdr
>    * structure.
>    */
> -unsigned long ima_get_binary_runtime_size(void)
> +unsigned long ima_get_binary_runtime_size(enum binary_size_types type)
>   {
> -	if (binary_runtime_size >= (ULONG_MAX - sizeof(struct ima_kexec_hdr)))
> +	unsigned long val;
> +
> +	mutex_lock(&ima_extend_list_mutex);
> +	val = binary_runtime_size[type];
> +	mutex_unlock(&ima_extend_list_mutex);
> +
> +	if (val >= (ULONG_MAX - sizeof(struct ima_kexec_hdr)))
>   		return ULONG_MAX;
>   	else
> -		return binary_runtime_size + sizeof(struct ima_kexec_hdr);
> +		return val + sizeof(struct ima_kexec_hdr);
>   }
>   
>   static int ima_pcr_extend(struct tpm_digest *digests_arg, int pcr)
> @@ -220,6 +244,127 @@ int ima_add_template_entry(struct ima_template_entry *entry, int violation,
>   	return result;
>   }
>   
> +int ima_queue_stage_trim(unsigned long req_value, bool trim)
req_value idea comes from Trim N entries one step proposal
trim idea come from Trim N entries one step proposal
> +{
> +	unsigned long req_value_copy = req_value, to_remove = 0;
> +	struct list_head *moved = &ima_measurements_staged;
> +	struct ima_queue_entry *qe;
> +
> +	if (req_value == 0 || req_value > LONG_MAX)
> +		return -EINVAL;
> +
> +	if (ima_measurements_staged_exist)
> +		return -EEXIST;
> +
> +	if (trim)
> +		moved = &ima_measurements_trim;
> +
> +	mutex_lock(&ima_extend_list_mutex);
> +	if (list_empty(&ima_measurements)) {
> +		mutex_unlock(&ima_extend_list_mutex);
> +		return -ENOENT;
> +	}
> +
> +	if (req_value == LONG_MAX) {
> +		list_replace(&ima_measurements, moved);
> +		INIT_LIST_HEAD(&ima_measurements);
> +		atomic_long_set(&ima_htable.len[BINARY_SIZE], 0);
> +		if (IS_ENABLED(CONFIG_IMA_KEXEC))
> +			binary_runtime_size[BINARY_SIZE] = 0;
> +
> +		if (trim) {
> +			atomic_long_set(&ima_htable.len[BINARY_SIZE_STAGED], 0);
> +			if (IS_ENABLED(CONFIG_IMA_KEXEC))
> +				binary_runtime_size[BINARY_SIZE_STAGED] = 0;
> +		}
> +	} else {
> +		list_for_each_entry(qe, &ima_measurements, later) {
> +			to_remove += get_binary_runtime_size(qe->entry);
Trim N entries one step proposal does not need this step, this will save 
lock time
> +			if (--req_value_copy == 0)
> +				break;
> +		}
> +
> +		if (req_value_copy > 0) {
> +			mutex_unlock(&ima_extend_list_mutex);
> +			return -ENOENT;
> +		}
> +
> +		__list_cut_position(moved, &ima_measurements, &qe->later);
> +		atomic_long_sub(req_value, &ima_htable.len[BINARY_SIZE]);
> +		if (IS_ENABLED(CONFIG_IMA_KEXEC))
> +			binary_runtime_size[BINARY_SIZE] -= to_remove;
> +
> +		if (trim) {
> +			atomic_long_sub(req_value,
> +					&ima_htable.len[BINARY_SIZE_STAGED]);
> +			if (IS_ENABLED(CONFIG_IMA_KEXEC))
> +				binary_runtime_size[BINARY_SIZE_STAGED] -=
> +								to_remove;
> +		}
> +	}
> +
> +	if (ima_flush_htable)
> +		/* Either staged/trimmed entries are removed from hash table. */
> +		list_for_each_entry(qe, moved, later)
> +			/* It can race with ima_lookup_digest_entry(). */
> +			hlist_del_rcu(&qe->hnext);
> +
> +	mutex_unlock(&ima_extend_list_mutex);
> +	ima_measurements_staged_exist = true;
> +
> +	if (ima_flush_htable)
> +		synchronize_rcu();
> +
> +	if (trim)
> +		return ima_queue_delete_staged_trimmed(true);
> +
> +	return 0;
> +}
> +
> +int ima_queue_delete_staged_trimmed(bool staged_moved)
> +{
> +	struct ima_queue_entry *qe, *qe_tmp;
> +	unsigned int i;
> +
> +	if (!ima_measurements_staged_exist)
> +		return -ENOENT;
> +
> +	if (!staged_moved) {
> +		mutex_lock(&ima_extend_list_mutex);
> +		list_replace(&ima_measurements_staged, &ima_measurements_trim);
> +		INIT_LIST_HEAD(&ima_measurements_staged);
> +		atomic_long_set(&ima_htable.len[BINARY_SIZE_STAGED], 0);
> +		if (IS_ENABLED(CONFIG_IMA_KEXEC))
> +			binary_runtime_size[BINARY_SIZE_STAGED] = 0;
> +
> +		mutex_unlock(&ima_extend_list_mutex);
> +	}
> +
> +	list_for_each_entry_safe(qe, qe_tmp, &ima_measurements_trim, later) {
> +		/*
> +		 * Ok because after list delete qe is only accessed by
> +		 * ima_lookup_digest_entry().
> +		 */
> +		for (i = 0; i < qe->entry->template_desc->num_fields; i++) {
> +			kfree(qe->entry->template_data[i].data);
> +			qe->entry->template_data[i].data = NULL;
> +			qe->entry->template_data[i].len = 0;
> +		}
> +
> +		list_del(&qe->later);
> +
> +		/* No leak if !ima_flush_htable, referenced by ima_htable. */
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



