Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 593313B857C
	for <lists+linux-integrity@lfdr.de>; Wed, 30 Jun 2021 16:54:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235396AbhF3O46 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 30 Jun 2021 10:56:58 -0400
Received: from linux.microsoft.com ([13.77.154.182]:44510 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235177AbhF3O45 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 30 Jun 2021 10:56:57 -0400
Received: from [10.137.112.111] (unknown [131.107.147.111])
        by linux.microsoft.com (Postfix) with ESMTPSA id 28F6D20B7178;
        Wed, 30 Jun 2021 07:54:28 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 28F6D20B7178
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1625064868;
        bh=HGkchr0rJ6ttGuCa+aJ+yp5Pb+8sfjGJgBKBkdQo8rE=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=jFdIK0OYuWvmfpON7YXsGTq8lvdrfknvK9jHcnGh/nDEtvBLgkEnT1fm+9p65Aq1z
         Gb+NDtnzY8Rnj9tq19A1ox0h6apcDqApr/R9MQGsIxJdWzW/NYv5enJveYHVuu6VXo
         IuMEPeZRUuYERxfS0bXy3o9MfQtfD7aENjE6nO4g=
Subject: Re: [PATCH 3/3] ima: Add digest parameter to the functions to measure
 a buffer
To:     Roberto Sassu <roberto.sassu@huawei.com>, zohar@linux.ibm.com,
        paul@paul-moore.com
Cc:     stephen.smalley.work@gmail.com, prsriva02@gmail.com,
        tusharsu@linux.microsoft.com, linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, selinux@vger.kernel.org
References: <20210630141635.2862222-1-roberto.sassu@huawei.com>
 <20210630141635.2862222-4-roberto.sassu@huawei.com>
From:   Lakshmi Ramasubramanian <nramas@linux.microsoft.com>
Message-ID: <e34639b4-145a-05a0-5ab4-ea51f9093e90@linux.microsoft.com>
Date:   Wed, 30 Jun 2021 07:56:24 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210630141635.2862222-4-roberto.sassu@huawei.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On 6/30/2021 7:16 AM, Roberto Sassu wrote:

Hi Roberto,

> This patch adds the 'digest' parameter to ima_measure_critical_data() and
> process_buffer_measurement(), so that callers can get the digest of the
> passed buffer.
> 
> These functions calculate the digest even if there is no suitable rule in
> the IMA policy and, in this case, they simply return 1 before generating a
> new measurement entry.
> 
> Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>
> ---
>   include/linux/ima.h                          |  4 +--
>   security/integrity/ima/ima.h                 |  2 +-
>   security/integrity/ima/ima_appraise.c        |  2 +-
>   security/integrity/ima/ima_asymmetric_keys.c |  2 +-
>   security/integrity/ima/ima_init.c            |  2 +-
>   security/integrity/ima/ima_main.c            | 31 +++++++++++++-------
>   security/integrity/ima/ima_queue_keys.c      |  2 +-
>   security/selinux/ima.c                       |  4 +--
>   8 files changed, 30 insertions(+), 19 deletions(-)
> 

>   
> +	if (digest)
> +		memcpy(digest, iint.ima_hash->digest,
> +		       hash_digest_size[ima_hash_algo]);

I think the caller should also pass the size of the buffer allocated to 
receive the calculated digest. And, here copy only up to that many bytes 
so we don't accidentally cause buffer overrun.

  -lakshmi

> +
> +	if (!ima_policy_flag || (func && !(action & IMA_MEASURE)))
> +		return 1;
> +
>   	ret = ima_alloc_init_template(&event_data, &entry, template);
>   	if (ret < 0) {
>   		audit_cause = "alloc_entry";
> @@ -966,7 +975,7 @@ void ima_kexec_cmdline(int kernel_fd, const void *buf, int size)
>   	ret = process_buffer_measurement(file_mnt_user_ns(f.file),
>   					 file_inode(f.file), buf, size,
>   					 "kexec-cmdline", KEXEC_CMDLINE, 0,
> -					 NULL, false);
> +					 NULL, false, NULL);
>   	fdput(f);
>   }
>   
> @@ -977,26 +986,28 @@ void ima_kexec_cmdline(int kernel_fd, const void *buf, int size)
>    * @buf: pointer to buffer data
>    * @buf_len: length of buffer data (in bytes)
>    * @hash: measure buffer data hash
> + * @digest: buffer digest will be written to
>    *
>    * Measure data critical to the integrity of the kernel into the IMA log
>    * and extend the pcr.  Examples of critical data could be various data
>    * structures, policies, and states stored in kernel memory that can
>    * impact the integrity of the system.
>    *
> - * Returns 0 if the buffer has been successfully measured, a negative value
> - * otherwise.
> + * Returns 0 if the buffer has been successfully measured, 1 if the digest
> + * has been written to the passed location but not added to a measurement entry,
> + * a negative value otherwise.
>    */
>   int ima_measure_critical_data(const char *event_label,
>   			      const char *event_name,
>   			      const void *buf, size_t buf_len,
> -			      bool hash)
> +			      bool hash, u8 *digest)
>   {
>   	if (!event_name || !event_label || !buf || !buf_len)
>   		return -ENOPARAM;
>   
>   	return process_buffer_measurement(&init_user_ns, NULL, buf, buf_len,
>   					  event_name, CRITICAL_DATA, 0,
> -					  event_label, hash);
> +					  event_label, hash, digest);
>   }
>   
>   static int __init init_ima(void)
> diff --git a/security/integrity/ima/ima_queue_keys.c b/security/integrity/ima/ima_queue_keys.c
> index e3047ce64f39..ac00a4778a91 100644
> --- a/security/integrity/ima/ima_queue_keys.c
> +++ b/security/integrity/ima/ima_queue_keys.c
> @@ -166,7 +166,7 @@ void ima_process_queued_keys(void)
>   							 entry->keyring_name,
>   							 KEY_CHECK, 0,
>   							 entry->keyring_name,
> -							 false);
> +							 false, NULL);
>   		list_del(&entry->list);
>   		ima_free_key_entry(entry);
>   	}
> diff --git a/security/selinux/ima.c b/security/selinux/ima.c
> index 4db9fa211638..96bd7ead8081 100644
> --- a/security/selinux/ima.c
> +++ b/security/selinux/ima.c
> @@ -88,7 +88,7 @@ void selinux_ima_measure_state_locked(struct selinux_state *state)
>   
>   	measure_rc = ima_measure_critical_data("selinux", "selinux-state",
>   					       state_str, strlen(state_str),
> -					       false);
> +					       false, NULL);
>   
>   	kfree(state_str);
>   
> @@ -105,7 +105,7 @@ void selinux_ima_measure_state_locked(struct selinux_state *state)
>   	}
>   
>   	measure_rc = ima_measure_critical_data("selinux", "selinux-policy-hash",
> -					       policy, policy_len, true);
> +					       policy, policy_len, true, NULL);
>   
>   	vfree(policy);
>   }
> 
