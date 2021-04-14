Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D5D8435F5EB
	for <lists+linux-integrity@lfdr.de>; Wed, 14 Apr 2021 16:14:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346555AbhDNOH6 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 14 Apr 2021 10:07:58 -0400
Received: from mail.hallyn.com ([178.63.66.53]:39066 "EHLO mail.hallyn.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S243063AbhDNOH6 (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 14 Apr 2021 10:07:58 -0400
Received: by mail.hallyn.com (Postfix, from userid 1001)
        id 54277A30; Wed, 14 Apr 2021 09:07:34 -0500 (CDT)
Date:   Wed, 14 Apr 2021 09:07:34 -0500
From:   "Serge E. Hallyn" <serge@hallyn.com>
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     Sumit Garg <sumit.garg@linaro.org>,
        James Bottomley <jejb@linux.ibm.com>,
        Jarkko Sakkinen <jarkko@kernel.org>,
        Mimi Zohar <zohar@linux.ibm.com>,
        David Howells <dhowells@redhat.com>,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        linux-integrity@vger.kernel.org, keyrings@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] KEYS: trusted: fix a couple error pointer dereferences
Message-ID: <20210414140734.GB11180@mail.hallyn.com>
References: <YHaG+p5nlOXQFp1n@mwanda>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YHaG+p5nlOXQFp1n@mwanda>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Wed, Apr 14, 2021 at 09:08:58AM +0300, Dan Carpenter wrote:
> If registering "reg_shm_out" fails, then it is an error pointer and the
> error handling will call tee_shm_free(reg_shm_out) which leads to an
> error pointer dereference and an Oops.
> 
> I've re-arranged it so we only free things that have been allocated
> successfully.
> 
> Fixes: 6dd95e650c8a ("KEYS: trusted: Introduce TEE based Trusted Keys")
> Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
> ---
>  security/keys/trusted-keys/trusted_tee.c | 24 ++++++++++--------------
>  1 file changed, 10 insertions(+), 14 deletions(-)
> 
> diff --git a/security/keys/trusted-keys/trusted_tee.c b/security/keys/trusted-keys/trusted_tee.c
> index 2ce66c199e1d..45f96f6ed673 100644
> --- a/security/keys/trusted-keys/trusted_tee.c
> +++ b/security/keys/trusted-keys/trusted_tee.c
> @@ -65,7 +65,7 @@ static int trusted_tee_seal(struct trusted_key_payload *p, char *datablob)
>  	int ret;
>  	struct tee_ioctl_invoke_arg inv_arg;
>  	struct tee_param param[4];
> -	struct tee_shm *reg_shm_in = NULL, *reg_shm_out = NULL;
> +	struct tee_shm *reg_shm_in, *reg_shm_out;

I don't have this file (trusted_tee.c) in my tree and there's no lore
link here to previous what threads this depends on.  Based on the
context I can't verify that reg_shm_in will always be initialized
before you get to the free_shm_in label.

>  
>  	memset(&inv_arg, 0, sizeof(inv_arg));
>  	memset(&param, 0, sizeof(param));
> @@ -84,7 +84,7 @@ static int trusted_tee_seal(struct trusted_key_payload *p, char *datablob)
>  	if (IS_ERR(reg_shm_out)) {
>  		dev_err(pvt_data.dev, "blob shm register failed\n");
>  		ret = PTR_ERR(reg_shm_out);
> -		goto out;
> +		goto free_shm_in;
>  	}
>  
>  	inv_arg.func = TA_CMD_SEAL;
> @@ -109,11 +109,9 @@ static int trusted_tee_seal(struct trusted_key_payload *p, char *datablob)
>  		p->blob_len = param[1].u.memref.size;
>  	}
>  
> -out:
> -	if (reg_shm_out)
> -		tee_shm_free(reg_shm_out);
> -	if (reg_shm_in)
> -		tee_shm_free(reg_shm_in);
> +	tee_shm_free(reg_shm_out);
> +free_shm_in:
> +	tee_shm_free(reg_shm_in);
>  
>  	return ret;
>  }
> @@ -126,7 +124,7 @@ static int trusted_tee_unseal(struct trusted_key_payload *p, char *datablob)
>  	int ret;
>  	struct tee_ioctl_invoke_arg inv_arg;
>  	struct tee_param param[4];
> -	struct tee_shm *reg_shm_in = NULL, *reg_shm_out = NULL;
> +	struct tee_shm *reg_shm_in, *reg_shm_out;
>  
>  	memset(&inv_arg, 0, sizeof(inv_arg));
>  	memset(&param, 0, sizeof(param));
> @@ -145,7 +143,7 @@ static int trusted_tee_unseal(struct trusted_key_payload *p, char *datablob)
>  	if (IS_ERR(reg_shm_out)) {
>  		dev_err(pvt_data.dev, "key shm register failed\n");
>  		ret = PTR_ERR(reg_shm_out);
> -		goto out;
> +		goto free_shm_in;
>  	}
>  
>  	inv_arg.func = TA_CMD_UNSEAL;
> @@ -170,11 +168,9 @@ static int trusted_tee_unseal(struct trusted_key_payload *p, char *datablob)
>  		p->key_len = param[1].u.memref.size;
>  	}
>  
> -out:
> -	if (reg_shm_out)
> -		tee_shm_free(reg_shm_out);
> -	if (reg_shm_in)
> -		tee_shm_free(reg_shm_in);
> +	tee_shm_free(reg_shm_out);
> +free_shm_in:
> +	tee_shm_free(reg_shm_in);
>  
>  	return ret;
>  }
> -- 
> 2.30.2
