Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D00453E06D8
	for <lists+linux-integrity@lfdr.de>; Wed,  4 Aug 2021 19:38:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229869AbhHDRic (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 4 Aug 2021 13:38:32 -0400
Received: from linux.microsoft.com ([13.77.154.182]:37284 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230040AbhHDRic (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 4 Aug 2021 13:38:32 -0400
Received: from [10.137.112.111] (unknown [131.107.147.111])
        by linux.microsoft.com (Postfix) with ESMTPSA id 0C32B209DD64;
        Wed,  4 Aug 2021 10:38:19 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 0C32B209DD64
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1628098699;
        bh=LXQPgu22ut9sfQYZjKHGSx3y+YPXB1QiXiyEww2Pox0=;
        h=Subject:To:References:From:Date:In-Reply-To:From;
        b=oHFAzG+6Qi+oewg9DNm48CO0wB5yqg8d6WhcNTDcO5qzqLCvoZIinXnCgBR7gR1s5
         mnVCIG1qPJuLQm7b+Z5i+aZDgEu+yLtWiif17HLP0XDqga1pQ+gZHtLu2jL7fPLSBK
         7qVoDIbfdI1dMe+AEjBa05nCM7T110qS5M6gN3NE=
Subject: Re: [PATCH v6 2/5] IMA: block writes of the security.ima xattr with
 unsupported algorithms
To:     THOBY Simon <Simon.THOBY@viveris.fr>,
        "zohar@linux.ibm.com" <zohar@linux.ibm.com>,
        "dmitry.kasatkin@gmail.com" <dmitry.kasatkin@gmail.com>,
        "linux-integrity@vger.kernel.org" <linux-integrity@vger.kernel.org>,
        BARVAUX Didier <Didier.BARVAUX@viveris.fr>
References: <20210804092010.350372-1-simon.thoby@viveris.fr>
 <20210804092010.350372-3-simon.thoby@viveris.fr>
From:   Lakshmi Ramasubramanian <nramas@linux.microsoft.com>
Message-ID: <3234077b-9e00-7d80-28b9-b448fe1e06af@linux.microsoft.com>
Date:   Wed, 4 Aug 2021 10:40:18 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <20210804092010.350372-3-simon.thoby@viveris.fr>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On 8/4/2021 2:20 AM, THOBY Simon wrote:
> By default, writes to the extended attributes security.ima will be
> allowed even if the hash algorithm used for the xattr is not compiled
> in the kernel (which does not make sense because the kernel would not
> be able to appraise that file as it lacks support for validating the
> hash).
> 
> Prevent writes to the security.ima xattr if the hash algorithm used is
> not available in the current kernel. Lo an audit message if such an
> operation is attempted.
Typo: Lo => Log

Reviewed-by: Lakshmi Ramasubramanian <nramas@linux.microsoft.com>

> 
> Signed-off-by: Simon Thoby <simon.thoby@viveris.fr>
> ---
>   security/integrity/ima/ima.h          |  2 +-
>   security/integrity/ima/ima_appraise.c | 49 ++++++++++++++++++++++++++-
>   2 files changed, 49 insertions(+), 2 deletions(-)
> 
> diff --git a/security/integrity/ima/ima.h b/security/integrity/ima/ima.h
> index 2f4c20b16ad7..829478dabeeb 100644
> --- a/security/integrity/ima/ima.h
> +++ b/security/integrity/ima/ima.h
> @@ -319,7 +319,7 @@ int ima_must_appraise(struct user_namespace *mnt_userns, struct inode *inode,
>   void ima_update_xattr(struct integrity_iint_cache *iint, struct file *file);
>   enum integrity_status ima_get_cache_status(struct integrity_iint_cache *iint,
>   					   enum ima_hooks func);
> -enum hash_algo ima_get_hash_algo(struct evm_ima_xattr_data *xattr_value,
> +enum hash_algo ima_get_hash_algo(const struct evm_ima_xattr_data *xattr_value,
>   				 int xattr_len);
>   int ima_read_xattr(struct dentry *dentry,
>   		   struct evm_ima_xattr_data **xattr_value);
> diff --git a/security/integrity/ima/ima_appraise.c b/security/integrity/ima/ima_appraise.c
> index 63bec42c353f..ed1a98f6ee19 100644
> --- a/security/integrity/ima/ima_appraise.c
> +++ b/security/integrity/ima/ima_appraise.c
> @@ -171,7 +171,7 @@ static void ima_cache_flags(struct integrity_iint_cache *iint,
>   	}
>   }
>   
> -enum hash_algo ima_get_hash_algo(struct evm_ima_xattr_data *xattr_value,
> +enum hash_algo ima_get_hash_algo(const struct evm_ima_xattr_data *xattr_value,
>   				 int xattr_len)
>   {
>   	struct signature_v2_hdr *sig;
> @@ -575,6 +575,51 @@ static void ima_reset_appraise_flags(struct inode *inode, int digsig)
>   		clear_bit(IMA_DIGSIG, &iint->atomic_flags);
>   }
>   
> +/**
> + * validate_hash_algo() - Block setxattr with invalid digests
> + * @dentry: object being setxattr()'ed
> + * @xattr_value: value supplied by userland for the xattr
> + * @xattr_value_len: length of xattr_value
> + *
> + * Context: called when the user tries to write the security.ima xattr.
> + * The xattr value is mapped to some hash algorithm, and this algorithm
> + * must be built in the kernel for the setxattr to be allowed.
> + *
> + * Emit an audit message when the algorithm is invalid.
> + *
> + * Return: 0 on success, else an error.
> + */
> +static int validate_hash_algo(struct dentry *dentry,
> +				   const struct evm_ima_xattr_data *xattr_value,
> +				   size_t xattr_value_len)
> +{
> +	int result = 0;
> +	char *path = NULL, *pathbuf = NULL;
> +	enum hash_algo xattr_hash_algo;
> +
> +	xattr_hash_algo = ima_get_hash_algo(xattr_value, xattr_value_len);
> +
> +	if (likely(xattr_hash_algo == ima_hash_algo ||
> +		   crypto_has_alg(hash_algo_name[xattr_hash_algo], 0, 0)))
> +		return result;
> +
> +	result = -EACCES;
> +
> +	pathbuf = kmalloc(PATH_MAX, GFP_KERNEL);
> +	if (!pathbuf)
> +		return result;
> +
> +	path = dentry_path(dentry, pathbuf, PATH_MAX);
> +
> +	integrity_audit_msg(AUDIT_INTEGRITY_DATA, d_inode(dentry), path,
> +			    "collect_data", "unavailable-hash-algorithm",
> +			    result, 0);
> +
> +	kfree(pathbuf);
> +
> +	return result;
> +}
> +
>   int ima_inode_setxattr(struct dentry *dentry, const char *xattr_name,
>   		       const void *xattr_value, size_t xattr_value_len)
>   {
> @@ -595,6 +640,8 @@ int ima_inode_setxattr(struct dentry *dentry, const char *xattr_name,
>   		ima_reset_appraise_flags(d_backing_inode(dentry), digsig);
>   		if (result == 1)
>   			result = 0;
> +
> +		result = validate_hash_algo(dentry, xvalue, xattr_value_len);
>   	}
>   	return result;
>   }
> 
