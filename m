Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D63B03BDDF1
	for <lists+linux-integrity@lfdr.de>; Tue,  6 Jul 2021 21:20:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231872AbhGFTVt (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 6 Jul 2021 15:21:49 -0400
Received: from linux.microsoft.com ([13.77.154.182]:41376 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231774AbhGFTVt (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 6 Jul 2021 15:21:49 -0400
Received: from [10.137.112.111] (unknown [131.107.147.111])
        by linux.microsoft.com (Postfix) with ESMTPSA id 4E1F320B7188;
        Tue,  6 Jul 2021 12:19:10 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 4E1F320B7188
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1625599150;
        bh=HAyiPMPlknf585eyjiByUkZYMcEfesGAqJ5IRtDhZNY=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=cw2ZMpdXbJc2YaqalFiZFCL2zmBUDnNh/RiSOFP2Wggm2eE5TVzXqFerw1CYvhy+/
         eM0D7iqhnJp4l+wiiEIS643DB+s02Ry+iUnZuuvIAZWpprtuo1IQsAaTcaUnoEgaiZ
         0zAPn4Sm907XkbmpCgwGjJNxKOgAohrkVfrMmvgs=
Subject: Re: [PATCH v3 2/3] ima: Return int in the functions to measure a
 buffer
To:     Roberto Sassu <roberto.sassu@huawei.com>, zohar@linux.ibm.com,
        paul@paul-moore.com
Cc:     stephen.smalley.work@gmail.com, prsriva02@gmail.com,
        tusharsu@linux.microsoft.com, linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, selinux@vger.kernel.org
References: <20210705090922.3321178-1-roberto.sassu@huawei.com>
 <20210705090922.3321178-3-roberto.sassu@huawei.com>
From:   Lakshmi Ramasubramanian <nramas@linux.microsoft.com>
Message-ID: <5bc9d707-b193-6111-fea6-50c70e6f2245@linux.microsoft.com>
Date:   Tue, 6 Jul 2021 12:21:04 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210705090922.3321178-3-roberto.sassu@huawei.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On 7/5/2021 2:09 AM, Roberto Sassu wrote:
> ima_measure_critical_data() and process_buffer_measurement() currently
> don't return a result. A caller wouldn't be able to know whether those
> functions were executed successfully.
> 
> This patch modifies the return type from void to int, and returns 0 if the
> buffer has been successfully measured, a negative value otherwise.
> 
> Also, this patch does not modify the behavior of existing callers by
> processing the returned value. For those, the return value is ignored.
> 
> Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>
> ---
>   include/linux/ima.h               | 15 +++++++-----
>   security/integrity/ima/ima.h      | 10 ++++----
>   security/integrity/ima/ima_main.c | 40 ++++++++++++++++++-------------
>   3 files changed, 37 insertions(+), 28 deletions(-)

Reviewed-by: Lakshmi Ramasubramanian <nramas@linux.microsoft.com>

  -lakshmi

> 
> diff --git a/include/linux/ima.h b/include/linux/ima.h
> index 81e830d01ced..60492263aa64 100644
> --- a/include/linux/ima.h
> +++ b/include/linux/ima.h
> @@ -35,10 +35,10 @@ extern void ima_post_path_mknod(struct user_namespace *mnt_userns,
>   extern int ima_file_hash(struct file *file, char *buf, size_t buf_size);
>   extern int ima_inode_hash(struct inode *inode, char *buf, size_t buf_size);
>   extern void ima_kexec_cmdline(int kernel_fd, const void *buf, int size);
> -extern void ima_measure_critical_data(const char *event_label,
> -				      const char *event_name,
> -				      const void *buf, size_t buf_len,
> -				      bool hash);
> +extern int ima_measure_critical_data(const char *event_label,
> +				     const char *event_name,
> +				     const void *buf, size_t buf_len,
> +				     bool hash);
>   
>   #ifdef CONFIG_IMA_APPRAISE_BOOTPARAM
>   extern void ima_appraise_parse_cmdline(void);
> @@ -144,10 +144,13 @@ static inline int ima_inode_hash(struct inode *inode, char *buf, size_t buf_size
>   
>   static inline void ima_kexec_cmdline(int kernel_fd, const void *buf, int size) {}
>   
> -static inline void ima_measure_critical_data(const char *event_label,
> +static inline int ima_measure_critical_data(const char *event_label,
>   					     const char *event_name,
>   					     const void *buf, size_t buf_len,
> -					     bool hash) {}
> +					     bool hash)
> +{
> +	return -ENOENT;
> +}
>   
>   #endif /* CONFIG_IMA */
>   
> diff --git a/security/integrity/ima/ima.h b/security/integrity/ima/ima.h
> index f0e448ed1f9f..03db221324c3 100644
> --- a/security/integrity/ima/ima.h
> +++ b/security/integrity/ima/ima.h
> @@ -264,11 +264,11 @@ void ima_store_measurement(struct integrity_iint_cache *iint, struct file *file,
>   			   struct evm_ima_xattr_data *xattr_value,
>   			   int xattr_len, const struct modsig *modsig, int pcr,
>   			   struct ima_template_desc *template_desc);
> -void process_buffer_measurement(struct user_namespace *mnt_userns,
> -				struct inode *inode, const void *buf, int size,
> -				const char *eventname, enum ima_hooks func,
> -				int pcr, const char *func_data,
> -				bool buf_hash);
> +int process_buffer_measurement(struct user_namespace *mnt_userns,
> +			       struct inode *inode, const void *buf, int size,
> +			       const char *eventname, enum ima_hooks func,
> +			       int pcr, const char *func_data,
> +			       bool buf_hash);
>   void ima_audit_measurement(struct integrity_iint_cache *iint,
>   			   const unsigned char *filename);
>   int ima_alloc_init_template(struct ima_event_data *event_data,
> diff --git a/security/integrity/ima/ima_main.c b/security/integrity/ima/ima_main.c
> index 8ef1fa357e0c..b512c06d8ee1 100644
> --- a/security/integrity/ima/ima_main.c
> +++ b/security/integrity/ima/ima_main.c
> @@ -827,7 +827,7 @@ int ima_post_load_data(char *buf, loff_t size,
>   	return 0;
>   }
>   
> -/*
> +/**
>    * process_buffer_measurement - Measure the buffer or the buffer data hash
>    * @mnt_userns:	user namespace of the mount the inode was found from
>    * @inode: inode associated with the object being measured (NULL for KEY_CHECK)
> @@ -840,12 +840,15 @@ int ima_post_load_data(char *buf, loff_t size,
>    * @buf_hash: measure buffer data hash
>    *
>    * Based on policy, either the buffer data or buffer data hash is measured
> + *
> + * Return: 0 if the buffer has been successfully measured, a negative value
> + * otherwise.
>    */
> -void process_buffer_measurement(struct user_namespace *mnt_userns,
> -				struct inode *inode, const void *buf, int size,
> -				const char *eventname, enum ima_hooks func,
> -				int pcr, const char *func_data,
> -				bool buf_hash)
> +int process_buffer_measurement(struct user_namespace *mnt_userns,
> +			       struct inode *inode, const void *buf, int size,
> +			       const char *eventname, enum ima_hooks func,
> +			       int pcr, const char *func_data,
> +			       bool buf_hash)
>   {
>   	int ret = 0;
>   	const char *audit_cause = "ENOMEM";
> @@ -867,7 +870,7 @@ void process_buffer_measurement(struct user_namespace *mnt_userns,
>   	u32 secid;
>   
>   	if (!ima_policy_flag)
> -		return;
> +		return -ENOENT;
>   
>   	template = ima_template_desc_buf();
>   	if (!template) {
> @@ -889,7 +892,7 @@ void process_buffer_measurement(struct user_namespace *mnt_userns,
>   					secid, 0, func, &pcr, &template,
>   					func_data);
>   		if (!(action & IMA_MEASURE))
> -			return;
> +			return -ENOENT;
>   	}
>   
>   	if (!pcr)
> @@ -937,7 +940,7 @@ void process_buffer_measurement(struct user_namespace *mnt_userns,
>   					func_measure_str(func),
>   					audit_cause, ret, 0, ret);
>   
> -	return;
> +	return ret;
>   }
>   
>   /**
> @@ -977,18 +980,21 @@ void ima_kexec_cmdline(int kernel_fd, const void *buf, int size)
>    * and extend the pcr.  Examples of critical data could be various data
>    * structures, policies, and states stored in kernel memory that can
>    * impact the integrity of the system.
> + *
> + * Return: 0 if the buffer has been successfully measured, a negative value
> + * otherwise.
>    */
> -void ima_measure_critical_data(const char *event_label,
> -			       const char *event_name,
> -			       const void *buf, size_t buf_len,
> -			       bool hash)
> +int ima_measure_critical_data(const char *event_label,
> +			      const char *event_name,
> +			      const void *buf, size_t buf_len,
> +			      bool hash)
>   {
>   	if (!event_name || !event_label || !buf || !buf_len)
> -		return;
> +		return -ENOPARAM;
>   
> -	process_buffer_measurement(&init_user_ns, NULL, buf, buf_len, event_name,
> -				   CRITICAL_DATA, 0, event_label,
> -				   hash);
> +	return process_buffer_measurement(&init_user_ns, NULL, buf, buf_len,
> +					  event_name, CRITICAL_DATA, 0,
> +					  event_label, hash);
>   }
>   
>   static int __init init_ima(void)
> 
