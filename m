Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 06B1E3DF291
	for <lists+linux-integrity@lfdr.de>; Tue,  3 Aug 2021 18:31:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232662AbhHCQcF (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 3 Aug 2021 12:32:05 -0400
Received: from linux.microsoft.com ([13.77.154.182]:46624 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232693AbhHCQcE (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 3 Aug 2021 12:32:04 -0400
Received: from [10.137.112.111] (unknown [131.107.147.111])
        by linux.microsoft.com (Postfix) with ESMTPSA id 88E5620B36E0;
        Tue,  3 Aug 2021 09:31:53 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 88E5620B36E0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1628008313;
        bh=UXwJ1Cz3yK/JX29E1oWqihOANzFZyClEMkbqIi2dn58=;
        h=Subject:To:References:From:Date:In-Reply-To:From;
        b=LP9bMsUweU0DgG/pNdVfETXnWd7CSCNdEZy9emI05yOT7iuf+Hw0iWs0zfZ6h6tyB
         6HU953s6px+AVt2kwHtP78Qmzd+mzb/B/v+EHS4fblegSJkTgCmhw22BkN9fbzZDQZ
         dBMD7TAHADMTnatYS57CKZQeBzBmx8rIXJyFvcCg=
Subject: Re: [PATCH v5 2/5] IMA: block writes of the security.ima xattr with
 unsupported algorithms
To:     THOBY Simon <Simon.THOBY@viveris.fr>,
        "zohar@linux.ibm.com" <zohar@linux.ibm.com>,
        "dmitry.kasatkin@gmail.com" <dmitry.kasatkin@gmail.com>,
        "linux-integrity@vger.kernel.org" <linux-integrity@vger.kernel.org>,
        BARVAUX Didier <Didier.BARVAUX@viveris.fr>
References: <20210728132112.258606-1-simon.thoby@viveris.fr>
 <20210728132112.258606-3-simon.thoby@viveris.fr>
From:   Lakshmi Ramasubramanian <nramas@linux.microsoft.com>
Message-ID: <ec75d9c4-62fc-819f-f983-7629196a8d77@linux.microsoft.com>
Date:   Tue, 3 Aug 2021 09:33:54 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <20210728132112.258606-3-simon.thoby@viveris.fr>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Hi Simon,

On 7/28/2021 6:21 AM, THOBY Simon wrote:
> By default, any write to the extended attributes security.ima will be
> accepted, even if the xattr value uses a hash algorithm not compiled in
> the kernel (which doesn't make sense, because the kernel wouldn't be able
> to appraise that file, as it lacks support for validating the hash).

Some nit changes in the above paragraph:

By default, write to the extended file attribute, security.ima, will be 
allowed even if the hash algorithm used for the xattr value is not 
compiled in the kernel (which does not make sense because the kernel 
would not be able to appraise that file as it lacks support for 
validating the hash).

> 
> Prevent such writes: only writes using hash algorithms
> available in the current kernel are now allowed. Any attempt to
> perform these writes will be denied with an audit message.

Prevent writes to security.ima if the hash algorithm used for the xattr 
value is not available in the current kernel. Log an audit message if 
such an operation is attempted.

> 
> Note however that CONFIG_IMA depends on CONFIG_CRYPTO_SHA1, which
> somewhat hampers the security benefits of this measure (but MD4 and
> MD5 can be disabled, which is already a significant improvement).

I am not sure if the above paragraph adds any value for this patch.

> 
> Signed-off-by: Simon Thoby <simon.thoby@viveris.fr>
> ---
>   security/integrity/ima/ima_appraise.c | 50 +++++++++++++++++++++++++++
>   1 file changed, 50 insertions(+)
> 
> diff --git a/security/integrity/ima/ima_appraise.c b/security/integrity/ima/ima_appraise.c
> index ef9dcfce45d4..a5e0d3400bd1 100644
> --- a/security/integrity/ima/ima_appraise.c
> +++ b/security/integrity/ima/ima_appraise.c
> @@ -575,6 +575,53 @@ static void ima_reset_appraise_flags(struct inode *inode, int digsig)
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
> +				   const void *xattr_value,
> +				   size_t xattr_value_len)
> +{
> +	char *path = NULL, *pathbuf = NULL;
> +	enum hash_algo xattr_hash_algo;
> +
> +	xattr_hash_algo = ima_get_hash_algo((struct evm_ima_xattr_data *)xattr_value,
> +					    xattr_value_len);
> +
> +	if (likely(xattr_hash_algo == ima_hash_algo ||
> +		   crypto_has_alg(hash_algo_name[xattr_hash_algo], 0, 0)))
> +		return 0;
> +
> +	pathbuf = kmalloc(PATH_MAX, GFP_KERNEL);
> +	if (pathbuf) {
         if (!pathbuf)
            return -EACCESS;

Indentation for the block below can then be removed.

> +		path = dentry_path(dentry, pathbuf, PATH_MAX);
> +
> +		/*
> +		 * disallow xattr writes with algorithms disabled in the
> +		 * kernel configuration
> +		 */
The above comment is not relevant for the audit message call below. The 
purpose of this function is already stated in the function header. You 
could remove the above comment.

  -lakshmi

> +		integrity_audit_msg(AUDIT_INTEGRITY_DATA, d_inode(dentry),
> +				    path, "collect_data",
> +				    "unavailable-hash-algorithm",
> +				    -EACCES, 0);
> +
> +		kfree(pathbuf);
> +	}
> +
> +	return -EACCES;
> +}
> +
>   int ima_inode_setxattr(struct dentry *dentry, const char *xattr_name,
>   		       const void *xattr_value, size_t xattr_value_len)
>   {
> @@ -595,6 +642,9 @@ int ima_inode_setxattr(struct dentry *dentry, const char *xattr_name,
>   		ima_reset_appraise_flags(d_backing_inode(dentry), digsig);
>   		if (result == 1)
>   			result = 0;
> +
> +		result = validate_hash_algo(dentry, xattr_value,
> +					    xattr_value_len);
>   	}
>   	return result;
>   }
> 
