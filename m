Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6DD502D834F
	for <lists+linux-integrity@lfdr.de>; Sat, 12 Dec 2020 01:15:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2395008AbgLLAOw (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 11 Dec 2020 19:14:52 -0500
Received: from linux.microsoft.com ([13.77.154.182]:56822 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389275AbgLLAO3 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 11 Dec 2020 19:14:29 -0500
Received: from sequoia (162-237-133-238.lightspeed.rcsntx.sbcglobal.net [162.237.133.238])
        by linux.microsoft.com (Postfix) with ESMTPSA id 5BFD120B717B;
        Fri, 11 Dec 2020 16:13:47 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 5BFD120B717B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1607732028;
        bh=J4T3fJj4p9fqeSZhjR49wzXu76bzrKvsGoakDtGMpRg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ISm5PIapPGVFsbLta5feYiGOqSo+05ZuXwfztAFSr8g7kZUuCi9k9GZ7gQAFAgKDE
         hALQ9gB6RT86EsGPaY7QfYeIm6E9TNY+TwWyq62Ia803vjNxX61kJJUFPCJ4ptG/uF
         XzvDMf3+vCE23bGmoGyuWrlQOj73B2RhImTtCNv4=
Date:   Fri, 11 Dec 2020 18:13:43 -0600
From:   Tyler Hicks <tyhicks@linux.microsoft.com>
To:     Tushar Sugandhi <tusharsu@linux.microsoft.com>
Cc:     zohar@linux.ibm.com, stephen.smalley.work@gmail.com,
        casey@schaufler-ca.com, agk@redhat.com, snitzer@redhat.com,
        gmazyland@gmail.com, paul@paul-moore.com, sashal@kernel.org,
        jmorris@namei.org, nramas@linux.microsoft.com,
        linux-integrity@vger.kernel.org, selinux@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, dm-devel@redhat.com
Subject: Re: [PATCH v8 3/8] IMA: define a hook to measure kernel integrity
 critical data
Message-ID: <20201212001343.GE4951@sequoia>
References: <20201211235807.30815-1-tusharsu@linux.microsoft.com>
 <20201211235807.30815-4-tusharsu@linux.microsoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201211235807.30815-4-tusharsu@linux.microsoft.com>
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On 2020-12-11 15:58:02, Tushar Sugandhi wrote:
> IMA provides capabilities to measure file data, and in-memory buffer
> data. However, various data structures, policies, and states
> stored in kernel memory also impact the integrity of the system.
> Several kernel subsystems contain such integrity critical data. These
> kernel subsystems help protect the integrity of a device. Currently,
> IMA does not provide a generic function for kernel subsystems to measure
> their integrity critical data.
>  
> Define a new IMA hook - ima_measure_critical_data to measure kernel
> integrity critical data.
> 
> Signed-off-by: Tushar Sugandhi <tusharsu@linux.microsoft.com>

Reviewed-by: Tyler Hicks <tyhicks@linux.microsoft.com>

Tyler

> ---
>  include/linux/ima.h               |  6 ++++++
>  security/integrity/ima/ima.h      |  1 +
>  security/integrity/ima/ima_api.c  |  2 +-
>  security/integrity/ima/ima_main.c | 34 +++++++++++++++++++++++++++++++
>  4 files changed, 42 insertions(+), 1 deletion(-)
> 
> diff --git a/include/linux/ima.h b/include/linux/ima.h
> index ac3d82f962f2..675f54db6264 100644
> --- a/include/linux/ima.h
> +++ b/include/linux/ima.h
> @@ -30,6 +30,9 @@ extern int ima_post_read_file(struct file *file, void *buf, loff_t size,
>  extern void ima_post_path_mknod(struct dentry *dentry);
>  extern int ima_file_hash(struct file *file, char *buf, size_t buf_size);
>  extern void ima_kexec_cmdline(int kernel_fd, const void *buf, int size);
> +extern void ima_measure_critical_data(const char *event_name,
> +				      const void *buf, int buf_len,
> +				      bool measure_buf_hash);
>  
>  #ifdef CONFIG_IMA_APPRAISE_BOOTPARAM
>  extern void ima_appraise_parse_cmdline(void);
> @@ -122,6 +125,9 @@ static inline int ima_file_hash(struct file *file, char *buf, size_t buf_size)
>  }
>  
>  static inline void ima_kexec_cmdline(int kernel_fd, const void *buf, int size) {}
> +static inline void ima_measure_critical_data(const char *event_name,
> +					     const void *buf, int buf_len,
> +					     bool measure_buf_hash) {}
>  #endif /* CONFIG_IMA */
>  
>  #ifndef CONFIG_IMA_KEXEC
> diff --git a/security/integrity/ima/ima.h b/security/integrity/ima/ima.h
> index fa3044a7539f..7d9deda6a8b3 100644
> --- a/security/integrity/ima/ima.h
> +++ b/security/integrity/ima/ima.h
> @@ -201,6 +201,7 @@ static inline unsigned int ima_hash_key(u8 *digest)
>  	hook(POLICY_CHECK, policy)			\
>  	hook(KEXEC_CMDLINE, kexec_cmdline)		\
>  	hook(KEY_CHECK, key)				\
> +	hook(CRITICAL_DATA, critical_data)		\
>  	hook(MAX_CHECK, none)
>  
>  #define __ima_hook_enumify(ENUM, str)	ENUM,
> diff --git a/security/integrity/ima/ima_api.c b/security/integrity/ima/ima_api.c
> index af218babd198..9917e1730cb6 100644
> --- a/security/integrity/ima/ima_api.c
> +++ b/security/integrity/ima/ima_api.c
> @@ -176,7 +176,7 @@ void ima_add_violation(struct file *file, const unsigned char *filename,
>   *		subj=, obj=, type=, func=, mask=, fsmagic=
>   *	subj,obj, and type: are LSM specific.
>   *	func: FILE_CHECK | BPRM_CHECK | CREDS_CHECK | MMAP_CHECK | MODULE_CHECK
> - *	| KEXEC_CMDLINE | KEY_CHECK
> + *	| KEXEC_CMDLINE | KEY_CHECK | CRITICAL_DATA
>   *	mask: contains the permission mask
>   *	fsmagic: hex value
>   *
> diff --git a/security/integrity/ima/ima_main.c b/security/integrity/ima/ima_main.c
> index 0f8409d77602..dff4bce4fb09 100644
> --- a/security/integrity/ima/ima_main.c
> +++ b/security/integrity/ima/ima_main.c
> @@ -922,6 +922,40 @@ void ima_kexec_cmdline(int kernel_fd, const void *buf, int size)
>  	fdput(f);
>  }
>  
> +/**
> + * ima_measure_critical_data - measure kernel integrity critical data
> + * @event_name: event name to be used for the buffer entry
> + * @buf: pointer to buffer containing data to measure
> + * @buf_len: length of buffer(in bytes)
> + * @measure_buf_hash: measure buffer hash
> + *
> + * Measure the kernel subsystem data, critical to the integrity of the kernel,
> + * into the IMA log and extend the @pcr.
> + *
> + * Use @event_name to describe the state/buffer data change.
> + * Examples of critical data (@buf) could be various data structures,
> + * policies, and states stored in kernel memory that can impact the integrity
> + * of the system.
> + *
> + * If @measure_buf_hash is set to true - measure hash of the buffer data,
> + * else measure the buffer data itself.
> + * @measure_buf_hash can be used to save space, if the data being measured
> + * is too large.
> + *
> + * The data (@buf) can only be measured, not appraised.
> + */
> +void ima_measure_critical_data(const char *event_name,
> +			       const void *buf, int buf_len,
> +			       bool measure_buf_hash)
> +{
> +	if (!event_name || !buf || !buf_len)
> +		return;
> +
> +	process_buffer_measurement(NULL, buf, buf_len, event_name,
> +				   CRITICAL_DATA, 0, NULL,
> +				   measure_buf_hash);
> +}
> +
>  static int __init init_ima(void)
>  {
>  	int error;
> -- 
> 2.17.1
> 
