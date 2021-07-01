Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 963D63B9573
	for <lists+linux-integrity@lfdr.de>; Thu,  1 Jul 2021 19:25:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232977AbhGAR1l (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 1 Jul 2021 13:27:41 -0400
Received: from linux.microsoft.com ([13.77.154.182]:41646 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232597AbhGAR1k (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 1 Jul 2021 13:27:40 -0400
Received: from [10.137.112.111] (unknown [131.107.147.111])
        by linux.microsoft.com (Postfix) with ESMTPSA id E8C0220B7178;
        Thu,  1 Jul 2021 10:25:09 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com E8C0220B7178
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1625160310;
        bh=WG5wRGaFi1YEYH/p3kLBgZg0QocaUDBiQ9DllXbQwdg=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=fKZbIOvi/02DVVB84hIwaO3QLm9OExz3kLWZ0BGqsJFKP+FQdLzfkvrxfMzURbAHH
         G/fj86bIc2pAMWtIT4puMHYQaqdksoAZ8v9t77OBel7KCsqaR0E1kP1rX3Kd/d9kSN
         W4WCwPUdRahfDrA6GD5EeIkuRrpOqfJhspol22L8=
Subject: Re: [PATCH v2 3/3] ima: Add digest and digest_len params to the
 functions to measure a buffer
To:     Roberto Sassu <roberto.sassu@huawei.com>, zohar@linux.ibm.com,
        paul@paul-moore.com
Cc:     stephen.smalley.work@gmail.com, prsriva02@gmail.com,
        tusharsu@linux.microsoft.com, linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, selinux@vger.kernel.org
References: <20210701125552.2958008-1-roberto.sassu@huawei.com>
 <20210701125552.2958008-4-roberto.sassu@huawei.com>
From:   Lakshmi Ramasubramanian <nramas@linux.microsoft.com>
Message-ID: <25b1fe6f-a378-fbfb-821a-9ca2c3421b5c@linux.microsoft.com>
Date:   Thu, 1 Jul 2021 10:27:05 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210701125552.2958008-4-roberto.sassu@huawei.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On 7/1/2021 5:55 AM, Roberto Sassu wrote:

Hi Roberto,

> This patch adds the 'digest' and 'digest_len' parameters to
> ima_measure_critical_data() and process_buffer_measurement(), so that
> callers can get the digest of the passed buffer.
> 
> These functions calculate the digest even if there is no suitable rule in
> the IMA policy and, in this case, they simply return 1 before generating a
> new measurement entry.
> 

> diff --git a/security/integrity/ima/ima_main.c b/security/integrity/ima/ima_main.c
> index 3386e7436440..b4b1dc25e4fb 100644
> --- a/security/integrity/ima/ima_main.c
> +++ b/security/integrity/ima/ima_main.c
> @@ -838,17 +838,20 @@ int ima_post_load_data(char *buf, loff_t size,
>    * @pcr: pcr to extend the measurement
>    * @func_data: func specific data, may be NULL
>    * @buf_hash: measure buffer data hash
> + * @digest: buffer digest will be written to
> + * @digest_len: buffer length
>    *
>    * Based on policy, either the buffer data or buffer data hash is measured
>    *
> - * Return: 0 if the buffer has been successfully measured, a negative value
> - * otherwise.
> + * Return: 0 if the buffer has been successfully measured, 1 if the digest
> + * has been written to the passed location but not added to a measurement entry,
> + * a negative value otherwise.
>    */
>   int process_buffer_measurement(struct user_namespace *mnt_userns,
>   			       struct inode *inode, const void *buf, int size,
>   			       const char *eventname, enum ima_hooks func,
>   			       int pcr, const char *func_data,
> -			       bool buf_hash)
> +			       bool buf_hash, u8 *digest, size_t digest_len)
>   {
>   	int ret = 0;
>   	const char *audit_cause = "ENOMEM";
> @@ -869,7 +872,10 @@ int process_buffer_measurement(struct user_namespace *mnt_userns,
>   	int action = 0;
>   	u32 secid;
>   
> -	if (!ima_policy_flag)
> +	if (digest && digest_len < digest_hash_len)
> +		return -EINVAL;
> +
> +	if (!ima_policy_flag && !digest)
>   		return -ENOENT;

Just wanted to check if you have verified this scenario:

If ima_policy_flag is 0, the in-memory ima policy data is not yet 
initialized. In this case calling ima_get_action() will cause kernel 
panic (NULL exception).

Please verify the above issue doesn't exist if the caller passes 
non-NULL digest and ima_policy_flag is 0 (ima policy is not initialized).

thanks,
  -lakshmi

>   
>   	template = ima_template_desc_buf();
> @@ -891,7 +897,7 @@ int process_buffer_measurement(struct user_namespace *mnt_userns,
>   		action = ima_get_action(mnt_userns, inode, current_cred(),
>   					secid, 0, func, &pcr, &template,
>   					func_data);
> -		if (!(action & IMA_MEASURE))
> +		if (!(action & IMA_MEASURE) && !digest)
>   			return -ENOENT;
>   	}
>   
> @@ -922,6 +928,12 @@ int process_buffer_measurement(struct user_namespace *mnt_userns,
>   		event_data.buf_len = digest_hash_len;
>   	}
>   
> +	if (digest)
> +		memcpy(digest, iint.ima_hash->digest, digest_hash_len);
> +
> +	if (!ima_policy_flag || (func && !(action & IMA_MEASURE)))
> +		return 1;
> +
>   	ret = ima_alloc_init_template(&event_data, &entry, template);
>   	if (ret < 0) {
>   		audit_cause = "alloc_entry";
> @@ -966,7 +978,7 @@ void ima_kexec_cmdline(int kernel_fd, const void *buf, int size)
>   	ret = process_buffer_measurement(file_mnt_user_ns(f.file),
>   					 file_inode(f.file), buf, size,
>   					 "kexec-cmdline", KEXEC_CMDLINE, 0,
> -					 NULL, false);
> +					 NULL, false, NULL, 0);
>   	fdput(f);
>   }
>   
> @@ -977,26 +989,30 @@ void ima_kexec_cmdline(int kernel_fd, const void *buf, int size)
>    * @buf: pointer to buffer data
>    * @buf_len: length of buffer data (in bytes)
>    * @hash: measure buffer data hash
> + * @digest: buffer digest will be written to
> + * @digest_len: buffer length
>    *
>    * Measure data critical to the integrity of the kernel into the IMA log
>    * and extend the pcr.  Examples of critical data could be various data
>    * structures, policies, and states stored in kernel memory that can
>    * impact the integrity of the system.
>    *
> - * Return: 0 if the buffer has been successfully measured, a negative value
> - * otherwise.
> + * Return: 0 if the buffer has been successfully measured, 1 if the digest
> + * has been written to the passed location but not added to a measurement entry,
> + * a negative value otherwise.
>    */
>   int ima_measure_critical_data(const char *event_label,
>   			      const char *event_name,
>   			      const void *buf, size_t buf_len,
> -			      bool hash)
> +			      bool hash, u8 *digest, size_t digest_len)
>   {
>   	if (!event_name || !event_label || !buf || !buf_len)
>   		return -ENOPARAM;
>   
>   	return process_buffer_measurement(&init_user_ns, NULL, buf, buf_len,
>   					  event_name, CRITICAL_DATA, 0,
> -					  event_label, hash);
> +					  event_label, hash, digest,
> +					  digest_len);
>   }
>   
>   static int __init init_ima(void)
> diff --git a/security/integrity/ima/ima_queue_keys.c b/security/integrity/ima/ima_queue_keys.c
> index e3047ce64f39..b02b061c5fac 100644
> --- a/security/integrity/ima/ima_queue_keys.c
> +++ b/security/integrity/ima/ima_queue_keys.c
> @@ -166,7 +166,7 @@ void ima_process_queued_keys(void)
>   							 entry->keyring_name,
>   							 KEY_CHECK, 0,
>   							 entry->keyring_name,
> -							 false);
> +							 false, NULL, 0);
>   		list_del(&entry->list);
>   		ima_free_key_entry(entry);
>   	}
> diff --git a/security/selinux/ima.c b/security/selinux/ima.c
> index 4db9fa211638..d5d7b3ca9651 100644
> --- a/security/selinux/ima.c
> +++ b/security/selinux/ima.c
> @@ -88,7 +88,7 @@ void selinux_ima_measure_state_locked(struct selinux_state *state)
>   
>   	measure_rc = ima_measure_critical_data("selinux", "selinux-state",
>   					       state_str, strlen(state_str),
> -					       false);
> +					       false, NULL, 0);
>   
>   	kfree(state_str);
>   
> @@ -105,7 +105,8 @@ void selinux_ima_measure_state_locked(struct selinux_state *state)
>   	}
>   
>   	measure_rc = ima_measure_critical_data("selinux", "selinux-policy-hash",
> -					       policy, policy_len, true);
> +					       policy, policy_len, true,
> +					       NULL, 0);
>   
>   	vfree(policy);
>   }
> 
