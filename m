Return-Path: <linux-integrity+bounces-9743-lists+linux-integrity=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-integrity@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 7cdEBBvGIGov7wAAu9opvQ
	(envelope-from <linux-integrity+bounces-9743-lists+linux-integrity=lfdr.de@vger.kernel.org>)
	for <lists+linux-integrity@lfdr.de>; Thu, 04 Jun 2026 02:26:03 +0200
X-Original-To: lists+linux-integrity@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E78B63C0C2
	for <lists+linux-integrity@lfdr.de>; Thu, 04 Jun 2026 02:26:02 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linux.microsoft.com header.s=default header.b=TOkxpyDI;
	spf=pass (mail.lfdr.de: domain of "linux-integrity+bounces-9743-lists+linux-integrity=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="linux-integrity+bounces-9743-lists+linux-integrity=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=linux.microsoft.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3905930182BE
	for <lists+linux-integrity@lfdr.de>; Thu,  4 Jun 2026 00:26:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4BA83175A81;
	Thu,  4 Jun 2026 00:26:00 +0000 (UTC)
X-Original-To: linux-integrity@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D78FF199D8;
	Thu,  4 Jun 2026 00:25:58 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780532760; cv=none; b=u3KIZ8JEDXUsG8A5jFi/eiaY5uzxWa4SL7/UYlGz/5oOmegYBnU+SieJv2SOz33quHLlkE1rAq40PQmgEjTtajt9u5vSAMFCflW9omD0kEq/GY2drpsk4bzUvFPEuBvGzUCj5Mp8UQYPcZkWrrVZte2ukcPqIGYYC5Ox23CbZ3Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780532760; c=relaxed/simple;
	bh=kQplzmUkmr5e23A2MPsZ+2RVvXH5iEjjuq60aSGEbso=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CZ62UN9Q0HDzajVJMzzzwhs/lzJ+DqDFzzgGMeqEwTSQ0YKIw4ugN5A8ixA2UN4NYGJvMqHlwsDUVsBzDvZk7Ib33373l4EVLaJWhSupofqwvXCNuSd7rA19V8Zm2UR48oECrVX0SZIK8TjNvTzBXSk7rpxTDdR8f8KKWFPJpwQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=TOkxpyDI; arc=none smtp.client-ip=13.77.154.182
Received: from [100.65.233.38] (unknown [20.236.10.163])
	by linux.microsoft.com (Postfix) with ESMTPSA id 9F59020B7168;
	Wed,  3 Jun 2026 17:25:42 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 9F59020B7168
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1780532743;
	bh=KSBysOBtgIjCR6JuPwdx2qXhRPAwOLWIc0hEopuQHGQ=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=TOkxpyDIuucbmb6HPl9pwW4OpNTtGtBlb9u+5PYbiNLarmuHNJTYKU8C7CE2ZkdKZ
	 Xz5AfPnyBm/nkAZ+DiNeVIiOwtCMJog8wRIR0JY7oz4sXG016wOHyZW3R0QKMXCUmb
	 qusCP1dMewNqAcYZuDRLLxUVTqRrBudWh/sH2U5s=
Message-ID: <880b0541-71e3-4676-9036-0597eacf45a6@linux.microsoft.com>
Date: Wed, 3 Jun 2026 17:25:54 -0700
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 11/12] ima: Support staging and deleting N measurements
 records
To: Roberto Sassu <roberto.sassu@huaweicloud.com>, corbet@lwn.net,
 skhan@linuxfoundation.org, zohar@linux.ibm.com, dmitry.kasatkin@gmail.com,
 eric.snowberg@oracle.com, paul@paul-moore.com, jmorris@namei.org,
 serge@hallyn.com
Cc: linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-integrity@vger.kernel.org, linux-security-module@vger.kernel.org,
 gregorylumen@linux.microsoft.com, nramas@linux.microsoft.com,
 Roberto Sassu <roberto.sassu@huawei.com>,
 steven chen <chenste@linux.microsoft.com>
References: <20260602111401.1706052-1-roberto.sassu@huaweicloud.com>
 <20260602111401.1706052-12-roberto.sassu@huaweicloud.com>
Content-Language: en-US
From: steven chen <chenste@linux.microsoft.com>
In-Reply-To: <20260602111401.1706052-12-roberto.sassu@huaweicloud.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.microsoft.com,none];
	R_DKIM_ALLOW(-0.20)[linux.microsoft.com:s=default];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-9743-lists,linux-integrity=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[huaweicloud.com,lwn.net,linuxfoundation.org,linux.ibm.com,gmail.com,oracle.com,paul-moore.com,namei.org,hallyn.com];
	FORGED_SENDER(0.00)[chenste@linux.microsoft.com,linux-integrity@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[17];
	FORGED_RECIPIENTS(0.00)[m:roberto.sassu@huaweicloud.com,m:corbet@lwn.net,m:skhan@linuxfoundation.org,m:zohar@linux.ibm.com,m:dmitry.kasatkin@gmail.com,m:eric.snowberg@oracle.com,m:paul@paul-moore.com,m:jmorris@namei.org,m:serge@hallyn.com,m:linux-doc@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:linux-integrity@vger.kernel.org,m:linux-security-module@vger.kernel.org,m:gregorylumen@linux.microsoft.com,m:nramas@linux.microsoft.com,m:roberto.sassu@huawei.com,m:chenste@linux.microsoft.com,m:dmitrykasatkin@gmail.com,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[chenste@linux.microsoft.com,linux-integrity@vger.kernel.org];
	DKIM_TRACE(0.00)[linux.microsoft.com:+];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-integrity];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,vger.kernel.org:from_smtp,linux.microsoft.com:mid,linux.microsoft.com:from_mime,linux.microsoft.com:dkim]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 7E78B63C0C2

On 6/2/2026 4:14 AM, Roberto Sassu wrote:
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
> N records is realized by doing a lockless walk in the current measurements
> list to determine the N-th entry to cut, to cut the current measurements
> list under the lock, and by deleting the excess records after releasing the
> lock.
>
> Flushing the hash table is not supported for N records, since it would
> require removing the N records one by one from the hash table under the
> ima_extend_list_mutex lock, which would increase the locking time.
>
> Link: https://github.com/linux-integrity/linux/issues/1
> Co-developed-by: Steven Chen <chenste@linux.microsoft.com>

Signed-off-by: Steven Chen <chenste@linux.microsoft.com>

> Co-developed-by: Roberto Sassu <roberto.sassu@huawei.com>
> Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>
> ---
>   security/integrity/ima/Kconfig     |  3 ++
>   security/integrity/ima/ima.h       |  1 +
>   security/integrity/ima/ima_fs.c    | 32 +++++++++++++--
>   security/integrity/ima/ima_queue.c | 63 ++++++++++++++++++++++++++++++
>   4 files changed, 96 insertions(+), 3 deletions(-)
>
> diff --git a/security/integrity/ima/Kconfig b/security/integrity/ima/Kconfig
> index 02436670f746..f4d25e045808 100644
> --- a/security/integrity/ima/Kconfig
> +++ b/security/integrity/ima/Kconfig
> @@ -341,6 +341,9 @@ config IMA_STAGING
>   	  It allows user space to stage the measurements list for deletion and
>   	  to delete the staged measurements after confirmation.
>   
> +	  Or, alternatively, it allows user space to specify N measurements
> +	  records to stage internally, so that they can be immediately deleted.
> +
>   	  On kexec, staging is aborted and any staged measurement records are
>   	  copied to the secondary kernel.
>   
> diff --git a/security/integrity/ima/ima.h b/security/integrity/ima/ima.h
> index d2e740c8ff75..7a1b2d6a8b59 100644
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
> index 96d7503a605b..174a94740da1 100644
> --- a/security/integrity/ima/ima_fs.c
> +++ b/security/integrity/ima/ima_fs.c
> @@ -28,6 +28,7 @@
>    * Requests:
>    * 'A\n': stage the entire measurements list
>    * 'D\n': delete all staged measurements
> + * '[1, ULONG_MAX]\n' delete N measurements records
>    */
>   #define STAGED_REQ_LENGTH 21
>   
> @@ -343,6 +344,7 @@ static ssize_t _ima_measurements_write(struct file *file,
>   				       loff_t *ppos, bool staged_interface)
>   {
>   	char req[STAGED_REQ_LENGTH];
> +	unsigned long req_value;
>   	int ret;
>   
>   	if (datalen < 2 || datalen > STAGED_REQ_LENGTH)
> @@ -370,7 +372,24 @@ static ssize_t _ima_measurements_write(struct file *file,
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
> @@ -379,6 +398,12 @@ static ssize_t _ima_measurements_write(struct file *file,
>   	return datalen;
>   }
>   
> +static ssize_t ima_measurements_write(struct file *file, const char __user *buf,
> +				      size_t datalen, loff_t *ppos)
> +{
> +	return _ima_measurements_write(file, buf, datalen, ppos, false);
> +}
> +
>   static ssize_t ima_measurements_staged_write(struct file *file,
>   					     const char __user *buf,
>   					     size_t datalen, loff_t *ppos)
> @@ -389,6 +414,7 @@ static ssize_t ima_measurements_staged_write(struct file *file,
>   static const struct file_operations ima_measurements_ops = {
>   	.open = ima_measurements_open,
>   	.read = seq_read,
> +	.write = ima_measurements_write,
>   	.llseek = seq_lseek,
>   	.release = ima_measurements_release,
>   };
> @@ -470,6 +496,7 @@ static int ima_ascii_measurements_open(struct inode *inode, struct file *file)
>   static const struct file_operations ima_ascii_measurements_ops = {
>   	.open = ima_ascii_measurements_open,
>   	.read = seq_read,
> +	.write = ima_measurements_write,
>   	.llseek = seq_lseek,
>   	.release = ima_measurements_release,
>   };
> @@ -603,14 +630,13 @@ static int __init create_securityfs_measurement_lists(bool staging)
>   {
>   	const struct file_operations *ascii_ops = &ima_ascii_measurements_ops;
>   	const struct file_operations *binary_ops = &ima_measurements_ops;
> -	umode_t permissions = (S_IRUSR | S_IRGRP);
> +	umode_t permissions = (S_IRUSR | S_IRGRP | S_IWUSR | S_IWGRP);
>   	const char *file_suffix = "";
>   	int count = NR_BANKS(ima_tpm_chip);
>   
>   	if (staging) {
>   		ascii_ops = &ima_ascii_measurements_staged_ops;
>   		binary_ops = &ima_measurements_staged_ops;
> -		permissions |= (S_IWUSR | S_IWGRP);
>   		file_suffix = "_staged";
>   	}
>   
> diff --git a/security/integrity/ima/ima_queue.c b/security/integrity/ima/ima_queue.c
> index af0502f27d57..718991ba8bcd 100644
> --- a/security/integrity/ima/ima_queue.c
> +++ b/security/integrity/ima/ima_queue.c
> @@ -405,6 +405,69 @@ int ima_queue_staged_delete_all(void)
>   	return 0;
>   }
>   
> +/**
> + * ima_queue_delete_partial - Delete current measurements
> + * @req_value: Number of measurements to delete
> + *
> + * Delete the requested number of measurements from the current measurements
> + * list, and update the number of records and the binary run-time size
> + * accordingly.
> + *
> + * Refuse to delete current measurements if measurement is suspended, so that
> + * dump can be done in a lockless way and user space is notified about current
> + * measurements being carried over to the secondary kernel, so that it does not
> + * save them twice.
> + *
> + * Return: Zero on success, a negative value otherwise.
> + */
> +int ima_queue_delete_partial(unsigned long req_value)
> +{
> +	unsigned long req_value_copy = req_value;
> +	unsigned long size_to_remove = 0, num_to_remove = 0;
> +	LIST_HEAD(ima_measurements_trim);
> +	struct ima_queue_entry *qe;
> +	int ret = 0;
> +
> +	/*
> +	 * list_for_each_entry_rcu() without rcu_read_lock() is fine because
> +	 * only list append can happen concurrently. No list replace due to the
> +	 * staging/delete writers mutual exclusion.
> +	 */
> +	list_for_each_entry_rcu(qe, &ima_measurements, later, true) {
> +		size_to_remove += get_binary_runtime_size(qe->entry);
> +		num_to_remove++;
> +
> +		if (--req_value_copy == 0)
> +			break;
> +	}
> +
> +	/* Not enough records to delete. */
> +	if (req_value_copy > 0)
> +		return -ENOENT;
> +
> +	mutex_lock(&ima_extend_list_mutex);
> +	if (ima_measurements_suspended) {
> +		mutex_unlock(&ima_extend_list_mutex);
> +		return -ESTALE;
> +	}
> +
> +	/*
> +	 * qe remains valid because ima_fs.c enforces single-writer exclusion.
> +	 */
> +	__list_cut_position(&ima_measurements_trim, &ima_measurements,
> +			    &qe->later);
> +
> +	atomic_long_sub(num_to_remove, &ima_num_records[BINARY]);
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
>   /**
>    * ima_queue_delete - Delete measurements
>    * @head: List head measurements are deleted from



