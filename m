Return-Path: <linux-integrity+bounces-9108-lists+linux-integrity=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-integrity@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UBIIDuPAxWlnBQUAu9opvQ
	(envelope-from <linux-integrity+bounces-9108-lists+linux-integrity=lfdr.de@vger.kernel.org>)
	for <lists+linux-integrity@lfdr.de>; Fri, 27 Mar 2026 00:27:31 +0100
X-Original-To: lists+linux-integrity@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id ADD1433D0A9
	for <lists+linux-integrity@lfdr.de>; Fri, 27 Mar 2026 00:27:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3C95A304E0D5
	for <lists+linux-integrity@lfdr.de>; Thu, 26 Mar 2026 23:20:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94CF2399039;
	Thu, 26 Mar 2026 23:20:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="RLrBfzvs"
X-Original-To: linux-integrity@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E0FA39890F;
	Thu, 26 Mar 2026 23:20:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774567202; cv=none; b=ed+d5FvD1+6878SmfI/K4Dw0VP+huN/8hrkCufYPhHFQrnoTmg4LNo99hj7Ds02Jxzeiq3rCPkJYszKJSudihfubij24+V3mPT+i3vp7Q58ajB6v/ZcyLdc4rJC/9EfQxM8bBJ7PHG2ve9UND2wNy0MDM65l7/jOdPvWn0F2KmE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774567202; c=relaxed/simple;
	bh=j82O37u6rk4f+KTXFCV3xVtYDU9AF+DOfKLr7N7TSwY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=aoQkX7ambUpAz7pc28u1aI53zHDd+eGqiacMmWBlZOxYi+4YMIb7snI5OTWnF2chrgJs+5ma4jiJ8ffhN76ktFO2X1GoZH6U4NZMiPMz12LlGDFYQK5fjMcNYjkxvJ4qedh1rMV3QnYChUM12D/eQyrsdCCVUYX71MLJCQCHt9Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=RLrBfzvs; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from [10.14.72.19] (unknown [131.107.1.147])
	by linux.microsoft.com (Postfix) with ESMTPSA id 0B55320B6F01;
	Thu, 26 Mar 2026 16:20:00 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 0B55320B6F01
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1774567200;
	bh=+p4onuxpbYbBW7OfHIVSvTRfcRCsy8+NygRurjvJdnw=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=RLrBfzvsB0dA6GFfXNv6pkWcceeKjpdPyiA4rmqOt1n5WSkeJfQ6sTh8sz68mEZZF
	 kINESV7rX51GXLFpufdtc6t7IJeJv3fkd7ox8ZaOJRcJM9BLxN4y7HOU5jgZeeOsk1
	 aTQE0jdD/g0Pr6kZbCpCIfFPwKYilNq0TAjPNvWQ=
Message-ID: <0e186faf-8111-4fd9-a7df-bff30f7fb20a@linux.microsoft.com>
Date: Thu, 26 Mar 2026 16:19:58 -0700
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 11/13] ima: Support staging and deleting N measurements
 entries
To: Roberto Sassu <roberto.sassu@huaweicloud.com>, corbet@lwn.net,
 skhan@linuxfoundation.org, zohar@linux.ibm.com, dmitry.kasatkin@gmail.com,
 eric.snowberg@oracle.com, paul@paul-moore.com, jmorris@namei.org,
 serge@hallyn.com
Cc: linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-integrity@vger.kernel.org, linux-security-module@vger.kernel.org,
 gregorylumen@linux.microsoft.com, nramas@linux.microsoft.com,
 Roberto Sassu <roberto.sassu@huawei.com>
References: <20260326173011.1191815-1-roberto.sassu@huaweicloud.com>
 <20260326173011.1191815-12-roberto.sassu@huaweicloud.com>
Content-Language: en-US
From: steven chen <chenste@linux.microsoft.com>
In-Reply-To: <20260326173011.1191815-12-roberto.sassu@huaweicloud.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.microsoft.com,none];
	R_DKIM_ALLOW(-0.20)[linux.microsoft.com:s=default];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-9108-lists,linux-integrity=lfdr.de];
	FREEMAIL_TO(0.00)[huaweicloud.com,lwn.net,linuxfoundation.org,linux.ibm.com,gmail.com,oracle.com,paul-moore.com,namei.org,hallyn.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[16];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[chenste@linux.microsoft.com,linux-integrity@vger.kernel.org];
	DKIM_TRACE(0.00)[linux.microsoft.com:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-integrity];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.microsoft.com:dkim,linux.microsoft.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: ADD1433D0A9
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 3/26/2026 10:30 AM, Roberto Sassu wrote:
> From: Roberto Sassu <roberto.sassu@huawei.com>
>
> Add support for sending a value N between 1 and ULONG_MAX to the staging
> interface. This value represents the number of measurements that should be
> deleted from the current measurements list.
>
> This staging method allows the remote attestation agents to easily separate
> the measurements that were verified (staged and deleted) from those that
> weren't due to the race between taking a TPM quote and reading the
> measurements list.
>
> In order to minimize the locking time of ima_extend_list_mutex, deleting
> N entries is realized by staging the entire current measurements list
> (with the lock), by determining the N-th staged entry (without the lock),
> and by splicing the entries in excess back to the current measurements list
> (with the lock). Finally, the N entries are deleted (without the lock).
>
> Flushing the hash table is not supported for N entries, since it would
> require removing the N entries one by one from the hash table under the
> ima_extend_list_mutex lock, which would increase the locking time.
>
> The ima_extend_list_mutex lock is necessary in ima_dump_measurement_list()
> because ima_queue_staged_delete_partial() uses __list_cut_position() to
> modify ima_measurements_staged, for which no RCU-safe variant exists. For
> the staging with prompt flavor alone, list_replace_rcu() could have been
> used instead, but since both flavors share the same kexec serialization
> path, the mutex is required regardless.
>
> Link: https://github.com/linux-integrity/linux/issues/1
> Suggested-by: Steven Chen <chenste@linux.microsoft.com>
> Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>
> ---
>   security/integrity/ima/Kconfig     |  3 ++
>   security/integrity/ima/ima.h       |  1 +
>   security/integrity/ima/ima_fs.c    | 22 +++++++++-
>   security/integrity/ima/ima_queue.c | 70 ++++++++++++++++++++++++++++++
>   4 files changed, 95 insertions(+), 1 deletion(-)
>
> diff --git a/security/integrity/ima/Kconfig b/security/integrity/ima/Kconfig
> index e714726f3384..6ddb4e77bff5 100644
> --- a/security/integrity/ima/Kconfig
> +++ b/security/integrity/ima/Kconfig
> @@ -341,6 +341,9 @@ config IMA_STAGING
>   	  It allows user space to stage the measurements list for deletion and
>   	  to delete the staged measurements after confirmation.
>   
> +	  Or, alternatively, it allows user space to specify N measurements
> +	  entries to be deleted.
> +
>   	  On kexec, staging is reverted and staged measurements are prepended
>   	  to the current measurements list when measurements are copied to the
>   	  secondary kernel.
> diff --git a/security/integrity/ima/ima.h b/security/integrity/ima/ima.h
> index 699b735dec7d..de0693fce53c 100644
> --- a/security/integrity/ima/ima.h
> +++ b/security/integrity/ima/ima.h
> @@ -319,6 +319,7 @@ struct ima_template_desc *lookup_template_desc(const char *name);
>   bool ima_template_has_modsig(const struct ima_template_desc *ima_template);
>   int ima_queue_stage(void);
>   int ima_queue_staged_delete_all(void);
> +int ima_queue_staged_delete_partial(unsigned long req_value);
>   int ima_restore_measurement_entry(struct ima_template_entry *entry);
>   int ima_restore_measurement_list(loff_t bufsize, void *buf);
>   int ima_measurements_show(struct seq_file *m, void *v);
> diff --git a/security/integrity/ima/ima_fs.c b/security/integrity/ima/ima_fs.c
> index 39d9128e9f22..eb3f343c1138 100644
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
> @@ -319,6 +320,7 @@ static ssize_t ima_measurements_staged_write(struct file *file,
>   					     size_t datalen, loff_t *ppos)
>   {
>   	char req[STAGED_REQ_LENGTH];
> +	unsigned long req_value;
>   	int ret;
>   
>   	if (*ppos > 0 || datalen < 2 || datalen > STAGED_REQ_LENGTH)
> @@ -346,7 +348,25 @@ static ssize_t ima_measurements_staged_write(struct file *file,
>   		ret = ima_queue_staged_delete_all();
>   		break;
>   	default:
> -		ret = -EINVAL;
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
> +		ret = ima_queue_stage();
> +		if (ret < 0)
> +			return ret;
> +
> +		ret = ima_queue_staged_delete_partial(req_value);
The default processing is "Trim N" idea plus performance improvement.

Here do everything in one time. And this is what I said in v3.

[PATCH v3 1/3] ima: Remove ima_h_table structure 
<https://lore.kernel.org/linux-integrity/c61aeaa79929a98cb3a6d30835972891fac3570f.camel@linux.ibm.com/T/#t>


The important two parts of trimming is "trim N" and performance improvement.

The performance improvement include two parts:
     hash table staging
     active log list staging

And I think "Trim N" plus performance improvement is the right direction 
to go.
Lots of code for two steps "stage and trim" "stage" part can be removed.

Also race condition may happen if not holding the list all time in user 
space
during attestation period: from stage, read list, attestation and trimming.

So in order to improve the above user space lock time, "Trim T:N" can be 
used
not to hold list long in user space during attestation.

For Trim T:N, T represent total log trimmed since system boot up. Please 
refer to
https://lore.kernel.org/linux-integrity/20260205235849.7086-1-chenste@linux.microsoft.com/T/#t

Thanks,

Steven
>   	}
>   
>   	if (ret < 0)
> diff --git a/security/integrity/ima/ima_queue.c b/security/integrity/ima/ima_queue.c
> index f5c18acfbc43..4fb557d61a88 100644
> --- a/security/integrity/ima/ima_queue.c
> +++ b/security/integrity/ima/ima_queue.c
> @@ -371,6 +371,76 @@ int ima_queue_staged_delete_all(void)
>   	return 0;
>   }
>   
> +int ima_queue_staged_delete_partial(unsigned long req_value)
> +{
> +	unsigned long req_value_copy = req_value;
> +	unsigned long size_to_remove = 0, num_to_remove = 0;
> +	struct list_head *cut_pos = NULL;
> +	LIST_HEAD(ima_measurements_trim);
> +	struct ima_queue_entry *qe;
> +	int ret = 0;
> +
> +	/*
> +	 * Safe walk (no concurrent write), not under ima_extend_list_mutex
> +	 * for performance reasons.
> +	 */
> +	list_for_each_entry(qe, &ima_measurements_staged, later) {
> +		size_to_remove += get_binary_runtime_size(qe->entry);
> +		num_to_remove++;
> +
> +		if (--req_value_copy == 0) {
> +			/* qe->later always points to a valid list entry. */
> +			cut_pos = &qe->later;
> +			break;
> +		}
> +	}
> +
> +	/* Nothing to remove, undoing staging. */
> +	if (req_value_copy > 0) {
> +		size_to_remove = 0;
> +		num_to_remove = 0;
> +		ret = -ENOENT;
> +	}
> +
> +	mutex_lock(&ima_extend_list_mutex);
> +	if (list_empty(&ima_measurements_staged)) {
> +		mutex_unlock(&ima_extend_list_mutex);
> +		return -ENOENT;
> +	}
> +
> +	if (cut_pos != NULL)
> +		/*
> +		 * ima_dump_measurement_list() does not modify the list,
> +		 * cut_pos remains the same even if it was computed before
> +		 * the lock.
> +		 */
> +		__list_cut_position(&ima_measurements_trim,
> +				    &ima_measurements_staged, cut_pos);
> +
> +	atomic_long_sub(num_to_remove, &ima_num_entries[BINARY_STAGED]);
> +	atomic_long_add(atomic_long_read(&ima_num_entries[BINARY_STAGED]),
> +			&ima_num_entries[BINARY]);
> +	atomic_long_set(&ima_num_entries[BINARY_STAGED], 0);
> +
> +	if (IS_ENABLED(CONFIG_IMA_KEXEC)) {
> +		binary_runtime_size[BINARY_STAGED] -= size_to_remove;
> +		binary_runtime_size[BINARY] +=
> +					binary_runtime_size[BINARY_STAGED];
> +		binary_runtime_size[BINARY_STAGED] = 0;
> +	}
> +
> +	/*
> +	 * Splice (prepend) any remaining non-deleted staged entries to the
> +	 * active list (RCU not needed, there cannot be concurrent readers).
> +	 */
> +	list_splice(&ima_measurements_staged, &ima_measurements);
> +	INIT_LIST_HEAD(&ima_measurements_staged);
> +	mutex_unlock(&ima_extend_list_mutex);
> +
> +	ima_queue_delete(&ima_measurements_trim, false);
> +	return ret;
> +}
> +
>   static void ima_queue_delete(struct list_head *head, bool flush_htable)
>   {
>   	struct ima_queue_entry *qe, *qe_tmp;



