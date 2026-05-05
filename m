Return-Path: <linux-integrity+bounces-9453-lists+linux-integrity=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-integrity@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oJpoEWk6+mnHKwMAu9opvQ
	(envelope-from <linux-integrity+bounces-9453-lists+linux-integrity=lfdr.de@vger.kernel.org>)
	for <lists+linux-integrity@lfdr.de>; Tue, 05 May 2026 20:43:53 +0200
X-Original-To: lists+linux-integrity@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id ADC8C4D2D09
	for <lists+linux-integrity@lfdr.de>; Tue, 05 May 2026 20:43:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 9C782302DF58
	for <lists+linux-integrity@lfdr.de>; Tue,  5 May 2026 18:43:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C844548C8AD;
	Tue,  5 May 2026 18:43:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="pr8AaWJx"
X-Original-To: linux-integrity@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45C273CBE89;
	Tue,  5 May 2026 18:43:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778006629; cv=none; b=Jn8SjrizX1lBvt05e7Wte08EoRTF4U6iVt3hDofULIYGZHZYnCWV86MNzVno03NdSlMmd8vfgjYtGJTaFM5+v3J/a3TT9bYR8/XIGBVeZeb0BtKA5IwIy8QpZRW/qo8pqGHwPL4oVSH434J1fxdN22/H9gSoiKpl7tEA5fKcoKs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778006629; c=relaxed/simple;
	bh=Xd3tarvIE/l41+kjtm/+RRQgcrHoeGUWQhOwM5ezzmk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FF//1hDzSpPVxSkHDmSd0Hb31oBLCp9OWXaW3MDex8G/GAsdmY+TMKwxW8gl6JZUQT4clc6f6Si9C3Q/tZFyw2eey2sgQhYhcG6SCBJ4i6F04LUrO/LgpbqrOI2Kw1Sqdh7j3av2OaHwQfjdDHylXTCrWxs92HOJs9rGjVuqvQY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=pr8AaWJx; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from [10.14.142.64] (unknown [131.107.1.128])
	by linux.microsoft.com (Postfix) with ESMTPSA id 11A6620B7168;
	Tue,  5 May 2026 11:43:45 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 11A6620B7168
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1778006625;
	bh=F9MzB697gTAO9oKRkWYwU1+lugmrvS1Au1oAW14IHlM=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=pr8AaWJxUVxu/pJlDvhAVnp/+uK8xDEwbIa+J/OgP2yd7/smA33D+xlFGiizOcUFp
	 0hztwil2b1zVu+sy+0+dct4S++kRyI5M38pkmi+I6F2cLFejpeBXjKrPqsnGGXl+rP
	 HdmqTfXdAAxLD3PEllz9DyN8uasvRptjhOx3bhJI=
Message-ID: <eef0d9a2-b84f-4cc9-ad09-94ce5940f888@linux.microsoft.com>
Date: Tue, 5 May 2026 11:43:46 -0700
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 11/13] ima: Support staging and deleting N measurements
 entries
To: Roberto Sassu <roberto.sassu@huaweicloud.com>, corbet@lwn.net,
 skhan@linuxfoundation.org, zohar@linux.ibm.com, dmitry.kasatkin@gmail.com,
 eric.snowberg@oracle.com, paul@paul-moore.com, jmorris@namei.org,
 serge@hallyn.com
Cc: linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-integrity@vger.kernel.org, linux-security-module@vger.kernel.org,
 gregorylumen@linux.microsoft.com, nramas@linux.microsoft.com,
 Roberto Sassu <roberto.sassu@huawei.com>,
 steven chen <chenste@linux.microsoft.com>
References: <20260429160319.4162918-1-roberto.sassu@huaweicloud.com>
 <20260429160319.4162918-12-roberto.sassu@huaweicloud.com>
Content-Language: en-US
From: steven chen <chenste@linux.microsoft.com>
In-Reply-To: <20260429160319.4162918-12-roberto.sassu@huaweicloud.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: ADC8C4D2D09
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.microsoft.com,none];
	R_DKIM_ALLOW(-0.20)[linux.microsoft.com:s=default];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-9453-lists,linux-integrity=lfdr.de];
	FREEMAIL_TO(0.00)[huaweicloud.com,lwn.net,linuxfoundation.org,linux.ibm.com,gmail.com,oracle.com,paul-moore.com,namei.org,hallyn.com];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[17];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[chenste@linux.microsoft.com,linux-integrity@vger.kernel.org];
	DKIM_TRACE(0.00)[linux.microsoft.com:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-integrity];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TO_DN_SOME(0.00)[]

On 4/29/2026 9:03 AM, Roberto Sassu wrote:
> From: Roberto Sassu <roberto.sassu@huawei.com>
>
> Add support for sending a value N between 1 and ULONG_MAX to the IMA
> original measurement interface. This value represents the number of
> measurements that should be deleted from the current measurements list. In
> this case, measurements are staged in an internal non-user visible list,
> and immediately deleted.
>
> This staging method allows the remote attestation agents to easily separate
> the measurements that were verified (staged and deleted) from those that
> weren't due to the race between taking a TPM quote and reading the
> measurements list.
>
> In order to minimize the locking time of ima_extend_list_mutex, deleting
> N entries is realized by doing a lockless walk in the current measurements
> list to determine the N-th entry to cut, to cut the current measurements
> list under the lock, and by deleting the excess entries after releasing the
> lock.
>
> Flushing the hash table is not supported for N entries, since it would
> require removing the N entries one by one from the hash table under the
> ima_extend_list_mutex lock, which would increase the locking time.
>
> The ima_extend_list_mutex lock is necessary in ima_dump_measurement_list()
> because ima_queue_delete_partial() uses __list_cut_position() to modify
> ima_measurements, for which no RCU-safe variant exists. For the staging
> with prompt flavor alone, list_replace_rcu() could have been used instead,
> but since both flavors share the same kexec serialization path, the mutex
> is required regardless.

This submit provides two ways for trimming logs:
     Patch 9: stage and delete
     This patch 11: stage and delete N

Both are doing the same thing in different ways

I think the best way is just keep the patch 11 for following reasons:
     Kernel list lock time is minimum
Kernel code change will be much simpler (almost half gone)
User space processing for log trimming is much simpler
no need to maintain two lists (old and staged) in user space
No two lists seen from user space (same as before)
no staged list shown

Steven

> Link: https://github.com/linux-integrity/linux/issues/1
> Suggested-by: Steven Chen <chenste@linux.microsoft.com>
> Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>
> ---
>   security/integrity/ima/Kconfig     |  3 +++
>   security/integrity/ima/ima.h       |  1 +
>   security/integrity/ima/ima_fs.c    | 21 ++++++++++++++-
>   security/integrity/ima/ima_kexec.c |  3 ++-
>   security/integrity/ima/ima_queue.c | 43 ++++++++++++++++++++++++++++++
>   5 files changed, 69 insertions(+), 2 deletions(-)
>
> diff --git a/security/integrity/ima/Kconfig b/security/integrity/ima/Kconfig
> index 48c906793efb..4f4373859a4f 100644
> --- a/security/integrity/ima/Kconfig
> +++ b/security/integrity/ima/Kconfig
> @@ -341,6 +341,9 @@ config IMA_STAGING
>   	  It allows user space to stage the measurements list for deletion and
>   	  to delete the staged measurements after confirmation.
>   
> +	  Or, alternatively, it allows user space to specify N measurements
> +	  entries to stage internally, so that they can be immediately deleted.
> +
>   	  On kexec, staging is reverted and staged measurements are prepended
>   	  to the current measurements list when measurements are copied to the
>   	  secondary kernel.
> diff --git a/security/integrity/ima/ima.h b/security/integrity/ima/ima.h
> index 4af66c1de4dc..9a741b33d524 100644
> --- a/security/integrity/ima/ima.h
> +++ b/security/integrity/ima/ima.h
> @@ -320,6 +320,7 @@ struct ima_template_desc *lookup_template_desc(const char *name);
>   bool ima_template_has_modsig(const struct ima_template_desc *ima_template);
>   int ima_queue_stage(void);
>   int ima_queue_staged_delete_all(void);
> +int ima_queue_delete_partial(unsigned long req_value);
>   int ima_restore_measurement_entry(struct ima_template_entry *entry);
>   int ima_restore_measurement_list(loff_t bufsize, void *buf);
>   int ima_measurements_show(struct seq_file *m, void *v);
> diff --git a/security/integrity/ima/ima_fs.c b/security/integrity/ima/ima_fs.c
> index 088d5a69aa92..6843dc203b54 100644
> --- a/security/integrity/ima/ima_fs.c
> +++ b/security/integrity/ima/ima_fs.c
> @@ -28,6 +28,7 @@
>    * Requests:
>    * 'A\n': stage the entire measurements list
>    * 'D\n': delete all staged measurements
> + * '[1, ULONG_MAX]\n' delete N measurements entries
>    */
>   #define STAGED_REQ_LENGTH 21
>   
> @@ -312,6 +313,7 @@ static ssize_t _ima_measurements_write(struct file *file,
>   				       loff_t *ppos, bool staged_interface)
>   {
>   	char req[STAGED_REQ_LENGTH];
> +	unsigned long req_value;
>   	int ret;
>   
>   	if (*ppos > 0 || datalen < 2 || datalen > STAGED_REQ_LENGTH)
> @@ -339,7 +341,24 @@ static ssize_t _ima_measurements_write(struct file *file,
>   		ret = ima_queue_staged_delete_all();
>   		break;
>   	default:
> -		ret = -EINVAL;
> +		if (staged_interface)
> +			return -EINVAL;
> +
> +		if (ima_flush_htable) {
> +			pr_debug("Deleting staged N measurements not supported when flushing the hash table is requested\n");
> +			return -EINVAL;
> +		}
> +
> +		ret = kstrtoul(req, 10, &req_value);
> +		if (ret < 0)
> +			return ret;
> +
> +		if (req_value == 0) {
> +			pr_debug("Must delete at least one entry\n");
> +			return -EINVAL;
> +		}
> +
> +		ret = ima_queue_delete_partial(req_value);
>   	}
>   
>   	if (ret < 0)
> diff --git a/security/integrity/ima/ima_kexec.c b/security/integrity/ima/ima_kexec.c
> index 064cfce0c318..e7bde3d917b2 100644
> --- a/security/integrity/ima/ima_kexec.c
> +++ b/security/integrity/ima/ima_kexec.c
> @@ -107,7 +107,8 @@ static int ima_dump_measurement_list(unsigned long *buffer_size, void **buffer,
>   	memset(&khdr, 0, sizeof(khdr));
>   	khdr.version = 1;
>   	/*
> -	 * It can race with ima_queue_stage() and ima_queue_staged_delete_all().
> +	 * It can race with ima_queue_stage(), ima_queue_staged_delete_all()
> +	 * and ima_queue_delete_partial().
>   	 */
>   	mutex_lock(&ima_extend_list_mutex);
>   
> diff --git a/security/integrity/ima/ima_queue.c b/security/integrity/ima/ima_queue.c
> index f5c18acfbc43..64c4fe73dd5f 100644
> --- a/security/integrity/ima/ima_queue.c
> +++ b/security/integrity/ima/ima_queue.c
> @@ -371,6 +371,49 @@ int ima_queue_staged_delete_all(void)
>   	return 0;
>   }
>   
> +int ima_queue_delete_partial(unsigned long req_value)
> +{
> +	unsigned long req_value_copy = req_value;
> +	unsigned long size_to_remove = 0, num_to_remove = 0;
> +	LIST_HEAD(ima_measurements_trim);
> +	struct ima_queue_entry *qe;
> +	int ret = 0;
> +
> +	/*
> +	 * Safe to walk without rcu_read_lock(): single-writer
> +	 * exclusion in ima_fs.c prevents any concurrent modification
> +	 * to ima_measurements during this walk.
> +	 */
> +	list_for_each_entry_rcu(qe, &ima_measurements, later, true) {
> +		size_to_remove += get_binary_runtime_size(qe->entry);
> +		num_to_remove++;
> +
> +		if (--req_value_copy == 0)
> +			break;
> +	}
> +
> +	/* Not enough entries to delete. */
> +	if (req_value_copy > 0)
> +		return -ENOENT;
> +
> +	mutex_lock(&ima_extend_list_mutex);
> +	/*
> +	 * qe remains valid because ima_fs.c enforces single-writer exclusion.
> +	 */
> +	__list_cut_position(&ima_measurements_trim, &ima_measurements,
> +			    &qe->later);
> +
> +	atomic_long_sub(num_to_remove, &ima_num_entries[BINARY]);
> +
> +	if (IS_ENABLED(CONFIG_IMA_KEXEC))
> +		binary_runtime_size[BINARY] -= size_to_remove;
> +
> +	mutex_unlock(&ima_extend_list_mutex);
> +
> +	ima_queue_delete(&ima_measurements_trim, false);
> +	return ret;
> +}
> +
>   static void ima_queue_delete(struct list_head *head, bool flush_htable)
>   {
>   	struct ima_queue_entry *qe, *qe_tmp;



