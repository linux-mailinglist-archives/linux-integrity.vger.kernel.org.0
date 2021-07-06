Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8B9083BDDF8
	for <lists+linux-integrity@lfdr.de>; Tue,  6 Jul 2021 21:23:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229998AbhGFTZn (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 6 Jul 2021 15:25:43 -0400
Received: from linux.microsoft.com ([13.77.154.182]:41868 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230002AbhGFTZm (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 6 Jul 2021 15:25:42 -0400
Received: from [10.137.112.111] (unknown [131.107.147.111])
        by linux.microsoft.com (Postfix) with ESMTPSA id 5A77520B7188;
        Tue,  6 Jul 2021 12:23:03 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 5A77520B7188
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1625599383;
        bh=a9HpKeql7g3OUHLYtjfvVAD8p3dRKWU145pXg7M1vS8=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=rUZ/bM7QQjsvKQYPPMj6bPHOyeHm3aT0gjNyHeb7nJNnTQ+jqmkxTavHjcZ+UJJCC
         aEkLnbdveZFRpSEtl1lnF4AZwER1c+SDZKSV32BtuBgwuS6PKwp4cg9OF9DRzsa2tP
         1/933wf4xkJ1/s1RixDdg3ChfsWF1T+eklLH6FLw=
Subject: Re: [PATCH v3 3/3] ima: Add digest and digest_len params to the
 functions to measure a buffer
To:     Roberto Sassu <roberto.sassu@huawei.com>, zohar@linux.ibm.com,
        paul@paul-moore.com
Cc:     stephen.smalley.work@gmail.com, prsriva02@gmail.com,
        tusharsu@linux.microsoft.com, linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, selinux@vger.kernel.org
References: <20210705090922.3321178-1-roberto.sassu@huawei.com>
 <20210705090922.3321178-4-roberto.sassu@huawei.com>
From:   Lakshmi Ramasubramanian <nramas@linux.microsoft.com>
Message-ID: <c740a85c-fc0f-b2d7-d7bf-bcca278a94ae@linux.microsoft.com>
Date:   Tue, 6 Jul 2021 12:24:57 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210705090922.3321178-4-roberto.sassu@huawei.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On 7/5/2021 2:09 AM, Roberto Sassu wrote:
> This patch adds the 'digest' and 'digest_len' parameters to
> ima_measure_critical_data() and process_buffer_measurement(), so that
> callers can get the digest of the passed buffer.
> 
> These functions calculate the digest even if there is no suitable rule in
> the IMA policy and, in this case, they simply return 1 before generating a
> new measurement entry.
> 
> Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>
> ---
>   include/linux/ima.h                          |  5 +--
>   security/integrity/ima/ima.h                 |  2 +-
>   security/integrity/ima/ima_appraise.c        |  2 +-
>   security/integrity/ima/ima_asymmetric_keys.c |  2 +-
>   security/integrity/ima/ima_init.c            |  3 +-
>   security/integrity/ima/ima_main.c            | 36 ++++++++++++++------
>   security/integrity/ima/ima_queue_keys.c      |  2 +-
>   security/selinux/ima.c                       |  6 ++--
>   8 files changed, 39 insertions(+), 19 deletions(-)

Reviewed-by: Lakshmi Ramasubramanian <nramas@linux.microsoft.com>

  -lakshmi

> 
> diff --git a/include/linux/ima.h b/include/linux/ima.h
> index 60492263aa64..b6ab66a546ae 100644
> --- a/include/linux/ima.h
> +++ b/include/linux/ima.h
> @@ -38,7 +38,7 @@ extern void ima_kexec_cmdline(int kernel_fd, const void *buf, int size);
>   extern int ima_measure_critical_data(const char *event_label,
>   				     const char *event_name,
>   				     const void *buf, size_t buf_len,
> -				     bool hash);
> +				     bool hash, u8 *digest, size_t digest_len);
>   
>   #ifdef CONFIG_IMA_APPRAISE_BOOTPARAM
>   extern void ima_appraise_parse_cmdline(void);
> @@ -147,7 +147,8 @@ static inline void ima_kexec_cmdline(int kernel_fd, const void *buf, int size) {
>   static inline int ima_measure_critical_data(const char *event_label,
>   					     const char *event_name,
>   					     const void *buf, size_t buf_len,
> -					     bool hash)
> +					     bool hash, u8 *digest,
> +					     size_t digest_len)
>   {
>   	return -ENOENT;
>   }
> diff --git a/security/integrity/ima/ima.h b/security/integrity/ima/ima.h
> index 03db221324c3..2f4c20b16ad7 100644
> --- a/security/integrity/ima/ima.h
> +++ b/security/integrity/ima/ima.h
> @@ -268,7 +268,7 @@ int process_buffer_measurement(struct user_namespace *mnt_userns,
>   			       struct inode *inode, const void *buf, int size,
>   			       const char *eventname, enum ima_hooks func,
>   			       int pcr, const char *func_data,
> -			       bool buf_hash);
> +			       bool buf_hash, u8 *digest, size_t digest_len);
>   void ima_audit_measurement(struct integrity_iint_cache *iint,
>   			   const unsigned char *filename);
>   int ima_alloc_init_template(struct ima_event_data *event_data,
> diff --git a/security/integrity/ima/ima_appraise.c b/security/integrity/ima/ima_appraise.c
> index ef9dcfce45d4..63bec42c353f 100644
> --- a/security/integrity/ima/ima_appraise.c
> +++ b/security/integrity/ima/ima_appraise.c
> @@ -357,7 +357,7 @@ int ima_check_blacklist(struct integrity_iint_cache *iint,
>   		if ((rc == -EPERM) && (iint->flags & IMA_MEASURE))
>   			process_buffer_measurement(&init_user_ns, NULL, digest, digestsize,
>   						   "blacklisted-hash", NONE,
> -						   pcr, NULL, false);
> +						   pcr, NULL, false, NULL, 0);
>   	}
>   
>   	return rc;
> diff --git a/security/integrity/ima/ima_asymmetric_keys.c b/security/integrity/ima/ima_asymmetric_keys.c
> index c985418698a4..f6aa0b47a772 100644
> --- a/security/integrity/ima/ima_asymmetric_keys.c
> +++ b/security/integrity/ima/ima_asymmetric_keys.c
> @@ -62,5 +62,5 @@ void ima_post_key_create_or_update(struct key *keyring, struct key *key,
>   	 */
>   	process_buffer_measurement(&init_user_ns, NULL, payload, payload_len,
>   				   keyring->description, KEY_CHECK, 0,
> -				   keyring->description, false);
> +				   keyring->description, false, NULL, 0);
>   }
> diff --git a/security/integrity/ima/ima_init.c b/security/integrity/ima/ima_init.c
> index 5076a7d9d23e..b26fa67476b4 100644
> --- a/security/integrity/ima/ima_init.c
> +++ b/security/integrity/ima/ima_init.c
> @@ -154,7 +154,8 @@ int __init ima_init(void)
>   	ima_init_key_queue();
>   
>   	ima_measure_critical_data("kernel_info", "kernel_version",
> -				  UTS_RELEASE, strlen(UTS_RELEASE), false);
> +				  UTS_RELEASE, strlen(UTS_RELEASE), false,
> +				  NULL, 0);
>   
>   	return rc;
>   }
> diff --git a/security/integrity/ima/ima_main.c b/security/integrity/ima/ima_main.c
> index b512c06d8ee1..360266da5a10 100644
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
> @@ -964,7 +976,7 @@ void ima_kexec_cmdline(int kernel_fd, const void *buf, int size)
>   
>   	process_buffer_measurement(file_mnt_user_ns(f.file), file_inode(f.file),
>   				   buf, size, "kexec-cmdline", KEXEC_CMDLINE, 0,
> -				   NULL, false);
> +				   NULL, false, NULL, 0);
>   	fdput(f);
>   }
>   
> @@ -975,26 +987,30 @@ void ima_kexec_cmdline(int kernel_fd, const void *buf, int size)
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
> index 979ef6c71f3d..93056c03bf5a 100644
> --- a/security/integrity/ima/ima_queue_keys.c
> +++ b/security/integrity/ima/ima_queue_keys.c
> @@ -165,7 +165,7 @@ void ima_process_queued_keys(void)
>   						   entry->keyring_name,
>   						   KEY_CHECK, 0,
>   						   entry->keyring_name,
> -						   false);
> +						   false, NULL, 0);
>   		list_del(&entry->list);
>   		ima_free_key_entry(entry);
>   	}
> diff --git a/security/selinux/ima.c b/security/selinux/ima.c
> index 34d421861bfc..727c4e43219d 100644
> --- a/security/selinux/ima.c
> +++ b/security/selinux/ima.c
> @@ -86,7 +86,8 @@ void selinux_ima_measure_state_locked(struct selinux_state *state)
>   	}
>   
>   	ima_measure_critical_data("selinux", "selinux-state",
> -				  state_str, strlen(state_str), false);
> +				  state_str, strlen(state_str), false,
> +				  NULL, 0);
>   
>   	kfree(state_str);
>   
> @@ -103,7 +104,8 @@ void selinux_ima_measure_state_locked(struct selinux_state *state)
>   	}
>   
>   	ima_measure_critical_data("selinux", "selinux-policy-hash",
> -				  policy, policy_len, true);
> +				  policy, policy_len, true,
> +				  NULL, 0);
>   
>   	vfree(policy);
>   }
> 
