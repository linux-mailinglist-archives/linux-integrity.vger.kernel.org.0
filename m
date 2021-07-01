Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6AF723B946E
	for <lists+linux-integrity@lfdr.de>; Thu,  1 Jul 2021 17:59:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233716AbhGAQBm (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 1 Jul 2021 12:01:42 -0400
Received: from linux.microsoft.com ([13.77.154.182]:59116 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233585AbhGAQBm (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 1 Jul 2021 12:01:42 -0400
Received: from [10.137.112.111] (unknown [131.107.147.111])
        by linux.microsoft.com (Postfix) with ESMTPSA id 201DB20B7178;
        Thu,  1 Jul 2021 08:59:11 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 201DB20B7178
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1625155151;
        bh=tGtlKNJkK5/DZnNBGztqz7wP4h5A4BodXWZyJoZ9Xqk=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=RAOKgrc/aaMD5QhTXy9I86XNptS43VW2TTTHo5I0zoBB/wx6k8k8BvEOVT9neWgvh
         SL3qLtWSm8h99GXlQLhK7Hy9CM8V7byXin2A1gLB6nDwIiwLmjdPECkwtyQNdEJHyZ
         JEZFiobbkTNJo83EhFc1IkIU+oqIlsB+nXzlUvCw=
Subject: Re: [PATCH v2 1/3] ima: Introduce ima_get_current_hash_algo()
To:     Roberto Sassu <roberto.sassu@huawei.com>, zohar@linux.ibm.com,
        paul@paul-moore.com
Cc:     stephen.smalley.work@gmail.com, prsriva02@gmail.com,
        tusharsu@linux.microsoft.com, linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, selinux@vger.kernel.org
References: <20210701125552.2958008-1-roberto.sassu@huawei.com>
 <20210701125552.2958008-2-roberto.sassu@huawei.com>
From:   Lakshmi Ramasubramanian <nramas@linux.microsoft.com>
Message-ID: <6c970b4a-08dd-adc2-6570-3d9aa823f88e@linux.microsoft.com>
Date:   Thu, 1 Jul 2021 09:01:06 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210701125552.2958008-2-roberto.sassu@huawei.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On 7/1/2021 5:55 AM, Roberto Sassu wrote:
> This patch introduces the new function ima_get_current_hash_algo(), that
> callers in the other kernel subsystems might use to obtain the hash
> algorithm selected by IMA.
> 
> Its primary use will be to determine which algorithm has been used to
> calculate the digest written by ima_measure_critical_data() to the location
> passed as a new parameter (in a subsequent patch). >
> Since the hash algorithm does not change after the IMA setup phase, there
> is no risk of races (obtaining a digest calculated with a different
> algorithm than the one returned).

Reviewed-by: Lakshmi Ramasubramanian <nramas@linux.microsoft.com>

  -lakshmi

> Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>
> ---
>   include/linux/ima.h               | 7 +++++++
>   security/integrity/ima/ima_main.c | 5 +++++
>   2 files changed, 12 insertions(+)
> 
> diff --git a/include/linux/ima.h b/include/linux/ima.h
> index 61d5723ec303..81e830d01ced 100644
> --- a/include/linux/ima.h
> +++ b/include/linux/ima.h
> @@ -11,9 +11,11 @@
>   #include <linux/fs.h>
>   #include <linux/security.h>
>   #include <linux/kexec.h>
> +#include <crypto/hash_info.h>
>   struct linux_binprm;
>   
>   #ifdef CONFIG_IMA
> +extern enum hash_algo ima_get_current_hash_algo(void);
>   extern int ima_bprm_check(struct linux_binprm *bprm);
>   extern int ima_file_check(struct file *file, int mask);
>   extern void ima_post_create_tmpfile(struct user_namespace *mnt_userns,
> @@ -64,6 +66,11 @@ static inline const char * const *arch_get_ima_policy(void)
>   #endif
>   
>   #else
> +static inline enum hash_algo ima_get_current_hash_algo(void)
> +{
> +	return HASH_ALGO__LAST;
> +}
> +
>   static inline int ima_bprm_check(struct linux_binprm *bprm)
>   {
>   	return 0;
> diff --git a/security/integrity/ima/ima_main.c b/security/integrity/ima/ima_main.c
> index 287b90509006..8ef1fa357e0c 100644
> --- a/security/integrity/ima/ima_main.c
> +++ b/security/integrity/ima/ima_main.c
> @@ -76,6 +76,11 @@ static int __init hash_setup(char *str)
>   }
>   __setup("ima_hash=", hash_setup);
>   
> +enum hash_algo ima_get_current_hash_algo(void)
> +{
> +	return ima_hash_algo;
> +}
> +
>   /* Prevent mmap'ing a file execute that is already mmap'ed write */
>   static int mmap_violation_check(enum ima_hooks func, struct file *file,
>   				char **pathbuf, const char **pathname,
> 
