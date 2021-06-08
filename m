Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 50E9439FBAF
	for <lists+linux-integrity@lfdr.de>; Tue,  8 Jun 2021 18:06:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229724AbhFHQHz (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 8 Jun 2021 12:07:55 -0400
Received: from linux.microsoft.com ([13.77.154.182]:47562 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230205AbhFHQHy (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 8 Jun 2021 12:07:54 -0400
Received: from nramas-ThinkStation-P520 (c-73-42-176-67.hsd1.wa.comcast.net [73.42.176.67])
        by linux.microsoft.com (Postfix) with ESMTPSA id 84BD120B7188;
        Tue,  8 Jun 2021 09:06:01 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 84BD120B7188
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1623168361;
        bh=dtIyOy4Ilzq3XGMrQp8PfRC6MPvd5F+IjWQXdREdog4=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=PzsmbAg0cgBlIsRrfdHTj9feHMHTrfbFu24zLm8xGp33WHBylZkeg89rsQoWSP5u6
         QAsXRiI69xBVqtKaze/ZOwXIbLqvbqvzGwTwpuuPxJw+KGj7XZqlbWpT1Kvj78v5eR
         bALfd3QTyfBVzmE+PZ16atVDeswAAYIbx8hr13SI=
Message-ID: <6f42e07fb057efdc72dc292017f6dbf05c3adfe9.camel@linux.microsoft.com>
Subject: Re: [PATCH 2/2] evm: output EVM digest calculation info
From:   nramas <nramas@linux.microsoft.com>
To:     Mimi Zohar <zohar@linux.ibm.com>, linux-integrity@vger.kernel.org
Cc:     linux-security-module@vger.kernel.org,
        Stefan Berger <stefanb@linux.ibm.com>,
        Russell Coker <russell@coker.com.au>
Date:   Tue, 08 Jun 2021 09:06:00 -0700
In-Reply-To: <20210608132950.424148-3-zohar@linux.ibm.com>
References: <20210608132950.424148-1-zohar@linux.ibm.com>
         <20210608132950.424148-3-zohar@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.5-0ubuntu1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Tue, 2021-06-08 at 09:29 -0400, Mimi Zohar wrote:
> Output the data used in calculating the EVM digest and the resulting
> digest as ascii hexadecimal strings.

Reviewed-by: Lakshmi Ramasubramanian <nramas@linux.microsoft.com>

> 
> Suggested-by: Lakshmi Ramasubramanian <nramas@linux.microsoft.com>
> (CONFIG_DYNAMIC_DEBUG)
> Signed-off-by: Mimi Zohar <zohar@linux.ibm.com>
> ---
> Changelog:
> - Use pr_debug *phN format
> - Define dump_security_xattr() for larger binary data
> - Based on CONFIG_DYNAMIC_DEBUG
> 
>  security/integrity/evm/evm_crypto.c | 42
> +++++++++++++++++++++++++++++
>  security/integrity/evm/evm_main.c   |  4 +++
>  2 files changed, 46 insertions(+)
> 
> diff --git a/security/integrity/evm/evm_crypto.c
> b/security/integrity/evm/evm_crypto.c
> index 1628e2ca9862..900cf8a157b6 100644
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
> @@ -175,6 +177,29 @@ static void hmac_add_misc(struct shash_desc
> *desc, struct inode *inode,
>  	    type != EVM_XATTR_PORTABLE_DIGSIG)
>  		crypto_shash_update(desc, (u8 *)&inode->i_sb->s_uuid,
> UUID_SIZE);
>  	crypto_shash_final(desc, digest);
> +
> +	pr_debug("hmac_misc: (%lu) [%*phN]\n", sizeof(struct h_misc),
> +		 (int) sizeof(struct h_misc), &hmac_misc);
> +}
> +
> +/*
> + * Dump large security xattr values as a continuous ascii
> hexademical string.
> + * (pr_debug is limited to 64 bytes.)
> + */
> +static void dump_security_xattr(const char *prefix, const void *src,
> size_t count)
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
> +	pr_debug("%s: (%lu) %.*s\n", prefix, count, (int) count * 2,
> asciihex);
> +	kfree(asciihex);
> +#endif
>  }
>  
>  /*
> @@ -230,6 +255,16 @@ static int evm_calc_hmac_or_hash(struct dentry
> *dentry,
>  					     req_xattr_value_len);
>  			if (is_ima)
>  				ima_present = true;
> +
> +			if (req_xattr_value_len < 64)
> +				pr_debug("%s: (%lu) [%*phN]\n",
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
> @@ -246,6 +281,13 @@ static int evm_calc_hmac_or_hash(struct dentry
> *dentry,
>  		crypto_shash_update(desc, (const u8 *)xattr_value,
> xattr_size);
>  		if (is_ima)
>  			ima_present = true;
> +
> +		if (xattr_size < 64)
> +			pr_debug("%s: (%lu) [%*phN]", xattr->name,
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
> index 2c226e634ae9..059ac17a0041 100644
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

