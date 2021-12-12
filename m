Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8B062471DAE
	for <lists+linux-integrity@lfdr.de>; Sun, 12 Dec 2021 22:21:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230205AbhLLVVp (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Sun, 12 Dec 2021 16:21:45 -0500
Received: from mail.hallyn.com ([178.63.66.53]:32794 "EHLO mail.hallyn.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229775AbhLLVVW (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Sun, 12 Dec 2021 16:21:22 -0500
Received: by mail.hallyn.com (Postfix, from userid 1001)
        id 6FF246B4; Sun, 12 Dec 2021 15:21:17 -0600 (CST)
Date:   Sun, 12 Dec 2021 15:21:17 -0600
From:   "Serge E. Hallyn" <serge@hallyn.com>
To:     Jianglei Nie <niejianglei2021@163.com>
Cc:     jejb@linux.ibm.com, jarkko@kernel.org, zohar@linux.ibm.com,
        dhowells@redhat.com, jmorris@namei.org, serge@hallyn.com,
        linux-integrity@vger.kernel.org, keyrings@vger.kernel.org,
        linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] security:trusted_tpm2: Fix memory leak in
 tpm2_key_encode()
Message-ID: <20211212212117.GA5737@mail.hallyn.com>
References: <20211212135403.59724-1-niejianglei2021@163.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211212135403.59724-1-niejianglei2021@163.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Sun, Dec 12, 2021 at 09:54:03PM +0800, Jianglei Nie wrote:
> Line 36 (#1) allocates a memory chunk for scratch by kmalloc(), but
> it is never freed through the function, which will lead to a memory
> leak.
> 
> We should kfree() scratch before the function returns (#2, #3 and #4).
> 
> 31 static int tpm2_key_encode(struct trusted_key_payload *payload,
> 32			   struct trusted_key_options *options,
> 33			   u8 *src, u32 len)
> 34 {
> 36	u8 *scratch = kmalloc(SCRATCH_SIZE, GFP_KERNEL);
>       	// #1: kmalloc space
> 37	u8 *work = scratch, *work1;
> 50	if (!scratch)
> 51		return -ENOMEM;
> 
> 56	if (options->blobauth_len == 0) {
> 60		if (WARN(IS_ERR(w), "BUG: Boolean failed to encode"))
> 61			return PTR_ERR(w); // #2: missing kfree
> 63	}
> 
> 71	if (WARN(work - scratch + pub_len + priv_len + 14 > SCRATCH_SIZE,
> 72		 "BUG: scratch buffer is too small"))
> 73		return -EINVAL; // #3: missing kfree
> 
>   	// #4: missing kfree: scratch is never used afterwards.
> 82	if (WARN(IS_ERR(work1), "BUG: ASN.1 encoder failed"))
> 83		return PTR_ERR(work1);
> 
> 85	return work1 - payload->blob;
> 86 }
> 
> Signed-off-by: Jianglei Nie <niejianglei2021@163.com>

I don't know that we need to keep the line by line recap in
the full git log, but it def looks correct:

Reviewed-by: Serge Hallyn <serge@hallyn.com>

thanks,
-serge

> ---
>  security/keys/trusted-keys/trusted_tpm2.c | 9 +++++++--
>  1 file changed, 7 insertions(+), 2 deletions(-)
> 
> diff --git a/security/keys/trusted-keys/trusted_tpm2.c b/security/keys/trusted-keys/trusted_tpm2.c
> index 0165da386289..3408a74c855f 100644
> --- a/security/keys/trusted-keys/trusted_tpm2.c
> +++ b/security/keys/trusted-keys/trusted_tpm2.c
> @@ -57,8 +57,10 @@ static int tpm2_key_encode(struct trusted_key_payload *payload,
>  		unsigned char bool[3], *w = bool;
>  		/* tag 0 is emptyAuth */
>  		w = asn1_encode_boolean(w, w + sizeof(bool), true);
> -		if (WARN(IS_ERR(w), "BUG: Boolean failed to encode"))
> +		if (WARN(IS_ERR(w), "BUG: Boolean failed to encode")) {
> +			kfree(scratch);
>  			return PTR_ERR(w);
> +		}
>  		work = asn1_encode_tag(work, end_work, 0, bool, w - bool);
>  	}
>  
> @@ -69,9 +71,12 @@ static int tpm2_key_encode(struct trusted_key_payload *payload,
>  	 * trigger, so if it does there's something nefarious going on
>  	 */
>  	if (WARN(work - scratch + pub_len + priv_len + 14 > SCRATCH_SIZE,
> -		 "BUG: scratch buffer is too small"))
> +		 "BUG: scratch buffer is too small")) {
> +		kfree(scratch);
>  		return -EINVAL;
> +	}
>  
> +	kfree(scratch);
>  	work = asn1_encode_integer(work, end_work, options->keyhandle);
>  	work = asn1_encode_octet_string(work, end_work, pub, pub_len);
>  	work = asn1_encode_octet_string(work, end_work, priv, priv_len);
> -- 
> 2.25.1
