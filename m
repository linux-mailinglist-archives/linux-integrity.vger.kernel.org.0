Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E971239A5D1
	for <lists+linux-integrity@lfdr.de>; Thu,  3 Jun 2021 18:34:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229762AbhFCQg3 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 3 Jun 2021 12:36:29 -0400
Received: from linux.microsoft.com ([13.77.154.182]:55934 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229695AbhFCQg3 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 3 Jun 2021 12:36:29 -0400
Received: from nramas-ThinkStation-P520 (c-73-42-176-67.hsd1.wa.comcast.net [73.42.176.67])
        by linux.microsoft.com (Postfix) with ESMTPSA id 4591620B7178;
        Thu,  3 Jun 2021 09:34:44 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 4591620B7178
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1622738084;
        bh=5QlKt2JL+LLfEYnRLLsdB8OoTNP0rnq09tK11I73664=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=bkJT52+roJzSGX/+CdJLM1dwxXflRF1squ/EjVxxb/SpM6QniGuRsFfjyupAiYRSu
         aq09/vtZpjkRxDU0LGjgxvMDXHQyozK2+smlDI0hA1CF9aGwKqcIZCtQb27/KNmUZS
         zvAvyzi/JA0z/w9i54hrW/7LEddx64AW1sQF0qvY=
Message-ID: <a994cedd0b2a07faf8d1949448ec9c14b3dba34c.camel@linux.microsoft.com>
Subject: Re: [RFC PATCH 2/2] evm: output EVM digest calculation info needed
 for debugging
From:   nramas <nramas@linux.microsoft.com>
To:     Mimi Zohar <zohar@linux.ibm.com>, linux-integrity@vger.kernel.org
Cc:     Roberto Sassu <roberto.sassu@huawei.com>,
        Stefan Berger <stefanb@linux.ibm.com>,
        Russell Coker <russell@coker.com.au>
Date:   Thu, 03 Jun 2021 09:34:43 -0700
In-Reply-To: <20210603151819.242247-3-zohar@linux.ibm.com>
References: <20210603151819.242247-1-zohar@linux.ibm.com>
         <20210603151819.242247-3-zohar@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.5-0ubuntu1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Thu, 2021-06-03 at 11:18 -0400, Mimi Zohar wrote:

Hi Mimi,

> Convert and output the binary data used in calculating the EVM digest
> to a hexadecimal string.
> 
> Signed-off-by: Mimi Zohar <zohar@linux.ibm.com>
> ---
>  security/integrity/evm/evm.h        |  1 +
>  security/integrity/evm/evm_crypto.c |  7 +++++++
>  security/integrity/evm/evm_main.c   | 19 +++++++++++++++++++
>  3 files changed, 27 insertions(+)
> 
> diff --git a/security/integrity/evm/evm.h
> b/security/integrity/evm/evm.h
> index 0d44f41d16f8..3d2d2da8fa97 100644
> --- a/security/integrity/evm/evm.h
> +++ b/security/integrity/evm/evm.h
> @@ -64,5 +64,6 @@ int evm_calc_hash(struct dentry *dentry, const char
> *req_xattr_name,
>  int (struct inode *inode, const struct xattr *xattr,
>  		  char *hmac_val);
>  int evm_init_secfs(void);
> +void evm_bin2hex_print(const char *prefix, const void *src, size_t
> count);
>  

For evm_bin2hex_print() can we could do the following in evm.h?

#ifdef DEBUG
void evm_bin2hex_print(const char *prefix, const void *src, size_t
count);
#else
void evm_bin2hex_print(const char *prefix, const void *src, size_t
count) {}
#endif /* DEBUG */

> void evm_bin2hex_print(const char *prefix, const void *src, size_t
> count);


>  #endif
> diff --git a/security/integrity/evm/evm_crypto.c
> b/security/integrity/evm/evm_crypto.c
> index 1628e2ca9862..7601aa29c6d3 100644
> --- a/security/integrity/evm/evm_crypto.c
> +++ b/security/integrity/evm/evm_crypto.c
> @@ -175,6 +175,8 @@ static void hmac_add_misc(struct shash_desc
> *desc, struct inode *inode,
>  	    type != EVM_XATTR_PORTABLE_DIGSIG)
>  		crypto_shash_update(desc, (u8 *)&inode->i_sb->s_uuid,
> UUID_SIZE);
>  	crypto_shash_final(desc, digest);
> +
> +	evm_bin2hex_print("hmac_misc", &hmac_misc, sizeof(struct
> h_misc));
>  }
>  
>  /*
> @@ -230,6 +232,9 @@ static int evm_calc_hmac_or_hash(struct dentry
> *dentry,
>  					     req_xattr_value_len);
>  			if (is_ima)
>  				ima_present = true;
> +
> +			evm_bin2hex_print(req_xattr_name,
> req_xattr_value,
> +				      req_xattr_value_len);
>  			continue;
>  		}
>  		size = vfs_getxattr_alloc(&init_user_ns, dentry, xattr-
> >name,
> @@ -246,6 +251,8 @@ static int evm_calc_hmac_or_hash(struct dentry
> *dentry,
>  		crypto_shash_update(desc, (const u8 *)xattr_value,
> xattr_size);
>  		if (is_ima)
>  			ima_present = true;
> +
> +		evm_bin2hex_print(xattr->name, xattr_value,
> xattr_size);
>  	}
>  	hmac_add_misc(desc, inode, type, data->digest);
>  
> diff --git a/security/integrity/evm/evm_main.c
> b/security/integrity/evm/evm_main.c
> index 2c226e634ae9..03d963fe2e67 100644
> --- a/security/integrity/evm/evm_main.c
> +++ b/security/integrity/evm/evm_main.c
> @@ -155,6 +155,23 @@ static int evm_find_protected_xattrs(struct
> dentry *dentry)
>  	return count;
>  }
>  
> +void evm_bin2hex_print(const char *prefix, const void *src, size_t
> count)
> +{
> +#ifdef DEBUG
> +	char *asciihex, *p;
> +
> +	p = asciihex = kmalloc(count * 2 + 1, GFP_KERNEL);
> +	if (!asciihex)
> +		return;
> +
> +	p = bin2hex(p, src, count);
> +	*p = 0;
> +	printk("%s: (%lu) %.*s\n", prefix, count, (int) count * 2,
> asciihex);

Prefix the message with, say, "evm:".

thanks,
 -lakshmi

> +
> +	kfree(asciihex);
> +#endif
> +}
> +
>  /*
>   * evm_verify_hmac - calculate and compare the HMAC with the EVM
> xattr
>   *
> @@ -272,6 +289,8 @@ static enum integrity_status
> evm_verify_hmac(struct dentry *dentry,
>  		else
>  			evm_status = INTEGRITY_FAIL;
>  	}
> +
> +	evm_bin2hex_print("evm digest", digest.digest,
> digest.hdr.length);
>  out:
>  	if (iint)
>  		iint->evm_status = evm_status;

