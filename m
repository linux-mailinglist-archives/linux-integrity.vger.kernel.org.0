Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 430F23AECEC
	for <lists+linux-integrity@lfdr.de>; Mon, 21 Jun 2021 17:58:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230204AbhFUQBA (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 21 Jun 2021 12:01:00 -0400
Received: from linux.microsoft.com ([13.77.154.182]:51568 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230021AbhFUQA7 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 21 Jun 2021 12:00:59 -0400
Received: from nramas-ThinkStation-P520 (c-73-42-176-67.hsd1.wa.comcast.net [73.42.176.67])
        by linux.microsoft.com (Postfix) with ESMTPSA id 6467320B7178;
        Mon, 21 Jun 2021 08:58:45 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 6467320B7178
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1624291125;
        bh=ZfELfrusyNzSaGtF9Uu7i2Zw2AR4AiYuMnPe2j58Q2I=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=c2shhO7a5Yp+Xoa8YhhEVORUIkmaiI/DAKJyNcKWHfrXYgYG4rLqEIZ/0HdUKr03d
         RGrom4Z+iBvu1EqjL7eSjhdhGg9IjJOhS8pOIhWjM9PNknZf/0YivuHP79tBAUoAWA
         VQZwhisdtmIZk77EOeU2Ad4DoI5UvZ+vxMp7rDww=
Message-ID: <2df02d43dd057e78c72bc341e6c24ce4d5f15a4b.camel@linux.microsoft.com>
Subject: Re: [PATCH v2] evm: output EVM digest calculation info
From:   nramas <nramas@linux.microsoft.com>
To:     Mimi Zohar <zohar@linux.ibm.com>, linux-integrity@vger.kernel.org
Cc:     Roberto Sassu <roberto.sassu@huawei.com>,
        Stefan Berger <stefanb@linux.ibm.com>,
        kernel test robot <lkp@intel.com>
Date:   Mon, 21 Jun 2021 08:58:44 -0700
In-Reply-To: <20210621010327.467523-1-zohar@linux.ibm.com>
References: <20210621010327.467523-1-zohar@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.5-0ubuntu1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Sun, 2021-06-20 at 21:03 -0400, Mimi Zohar wrote:
> Output the data used in calculating the EVM digest and the resulting
> digest as ascii hexadecimal strings.
> 
> Suggested-by: Lakshmi Ramasubramanian <nramas@linux.microsoft.com>
> (CONFIG_DYNAMIC_DEBUG)
> Reviewed-by: Lakshmi Ramasubramanian <nramas@linux.microsoft.com>
> Reported-by: kernel test robot <lkp@intel.com> (Use %zu for size_t)
> Signed-off-by: Mimi Zohar <zohar@linux.ibm.com>
> ---
> Changelog v1:
> - Use %zu for size_t

Reviewed-by: Lakshmi Ramasubramanian <nramas@linux.microsoft.com>

 -lakshmi

> 
>  security/integrity/evm/evm_crypto.c | 43
> +++++++++++++++++++++++++++++
>  security/integrity/evm/evm_main.c   |  4 +++
>  2 files changed, 47 insertions(+)
> 
> diff --git a/security/integrity/evm/evm_crypto.c
> b/security/integrity/evm/evm_crypto.c
> index 1628e2ca9862..bebe160c57b9 100644
> --- a/security/integrity/evm/evm_crypto.c
> +++ b/security/integrity/evm/evm_crypto.c
> @@ -10,6 +10,8 @@
>   *	 Using root's kernel master key (kmk), calculate the HMAC
>   */
>  
> +#define pr_fmt(fmt) "EVM: "fmt
> +
>  #include <linux/export.h>
>  #include <linux/crypto.h>
>  #include <linux/xattr.h>
> @@ -175,6 +177,30 @@ static void hmac_add_misc(struct shash_desc
> *desc, struct inode *inode,
>  	    type != EVM_XATTR_PORTABLE_DIGSIG)
>  		crypto_shash_update(desc, (u8 *)&inode->i_sb->s_uuid,
> UUID_SIZE);
>  	crypto_shash_final(desc, digest);
> +
> +	pr_debug("hmac_misc: (%zu) [%*phN]\n", sizeof(struct h_misc),
> +		 (int)sizeof(struct h_misc), &hmac_misc);
> +}
> +
> +/*
> + * Dump large security xattr values as a continuous ascii
> hexademical string.
> + * (pr_debug is limited to 64 bytes.)
> + */
> +static void dump_security_xattr(const char *prefix, const void *src,
> +				size_t count)
> +{
> +#if defined(DEBUG) || defined(CONFIG_DYNAMIC_DEBUG)
> +	char *asciihex, *p;
> +
> +	p = asciihex = kmalloc(count * 2 + 1, GFP_KERNEL);
> +	if (!asciihex)
> +		return;
> +
> +	p = bin2hex(p, src, count);
> +	*p = 0;
> +	pr_debug("%s: (%zu) %.*s\n", prefix, count, (int)count * 2,
> asciihex);
> +	kfree(asciihex);
> +#endif
>  }
>  
>  /*
> @@ -230,6 +256,16 @@ static int evm_calc_hmac_or_hash(struct dentry
> *dentry,
>  					     req_xattr_value_len);
>  			if (is_ima)
>  				ima_present = true;
> +
> +			if (req_xattr_value_len < 64)
> +				pr_debug("%s: (%zu) [%*phN]\n",
> req_xattr_name,
> +					 req_xattr_value_len,
> +					 (int)req_xattr_value_len,
> +					 req_xattr_value);
> +			else
> +				dump_security_xattr(req_xattr_name,
> +						    req_xattr_value,
> +						    req_xattr_value_len
> );
>  			continue;
>  		}
>  		size = vfs_getxattr_alloc(&init_user_ns, dentry, xattr-
> >name,
> @@ -246,6 +282,13 @@ static int evm_calc_hmac_or_hash(struct dentry
> *dentry,
>  		crypto_shash_update(desc, (const u8 *)xattr_value,
> xattr_size);
>  		if (is_ima)
>  			ima_present = true;
> +
> +		if (xattr_size < 64)
> +			pr_debug("%s: (%zu) [%*phN]", xattr->name,
> xattr_size,
> +				 (int)xattr_size, xattr_value);
> +		else
> +			dump_security_xattr(xattr->name, xattr_value,
> +					    xattr_size);
>  	}
>  	hmac_add_misc(desc, inode, type, data->digest);
>  
> diff --git a/security/integrity/evm/evm_main.c
> b/security/integrity/evm/evm_main.c
> index 977208aecd06..1c8435dfabee 100644
> --- a/security/integrity/evm/evm_main.c
> +++ b/security/integrity/evm/evm_main.c
> @@ -11,6 +11,8 @@
>   *	evm_inode_removexattr, and evm_verifyxattr
>   */
>  
> +#define pr_fmt(fmt) "EVM: "fmt
> +
>  #include <linux/init.h>
>  #include <linux/crypto.h>
>  #include <linux/audit.h>
> @@ -272,6 +274,8 @@ static enum integrity_status
> evm_verify_hmac(struct dentry *dentry,
>  		else
>  			evm_status = INTEGRITY_FAIL;
>  	}
> +	pr_debug("digest: (%d) [%*phN]\n", digest.hdr.length,
> digest.hdr.length,
> +		  digest.digest);
>  out:
>  	if (iint)
>  		iint->evm_status = evm_status;

