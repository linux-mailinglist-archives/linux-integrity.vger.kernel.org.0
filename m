Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C0960544310
	for <lists+linux-integrity@lfdr.de>; Thu,  9 Jun 2022 07:23:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238182AbiFIFXS (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 9 Jun 2022 01:23:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235383AbiFIFXR (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 9 Jun 2022 01:23:17 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 507C3E0BF;
        Wed,  8 Jun 2022 22:23:16 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A7A7961D1F;
        Thu,  9 Jun 2022 05:23:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A8052C34114;
        Thu,  9 Jun 2022 05:23:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1654752195;
        bh=XHZdFhnq6qjYdg5fXbtYu1DYUiXJ7YdR40VwYr8Qwhs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=S4jNXjOa+bXfsBQgDssKkfORXh7KV4Fv2Qbc1fIUpHJ9pwlQ6mdX+H2LjTz2f+uIU
         l2a5Dvp03xSxHTGoi0XvVX3+rpg+JNkhEWbTM3hsK8tahLym+j1QiV/FxQZoRJ/luc
         CCaMTsS/9Guys5kITQ7QS7h1kmAXR6bJcTJn9LHJIhYMyL7fc+AmbrxNqItuGDSPsA
         m4lf6G+itblmu7MwvAWKxZzOF7YF8Em86E2V6X/X5HpAAhRK1XEbwgDGIza7r7DDsv
         fzEpaigSTtdKaowngUCwPEirA8QeCLXzXVb3MrzNYaN6BykbvjdEU4iP4JL6kT6h4c
         LoMbeCq+Sl+kQ==
Date:   Thu, 9 Jun 2022 08:21:17 +0300
From:   Jarkko Sakkinen <jarkko@kernel.org>
To:     Jianglei Nie <niejianglei2021@163.com>
Cc:     jejb@linux.ibm.com, zohar@linux.ibm.com, dhowells@redhat.com,
        jmorris@namei.org, serge@hallyn.com,
        linux-integrity@vger.kernel.org, keyrings@vger.kernel.org,
        linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] KEYS: trusted: Fix memory leak in tpm2_key_encode()
Message-ID: <YqGDTVa64aknbldb@iki.fi>
References: <20220608131732.550234-1-niejianglei2021@163.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220608131732.550234-1-niejianglei2021@163.com>
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Wed, Jun 08, 2022 at 09:17:32PM +0800, Jianglei Nie wrote:
> tpm2_key_encode() allocates a memory chunk from scratch with kmalloc(),
> but it is never freed, which leads to a memory leak. Free the memory
> chunk with kfree() in the return path.
> 
> Signed-off-by: Jianglei Nie <niejianglei2021@163.com>
> ---

You should write down the changelog ere. No idea what changed
from the previous version.

>  security/keys/trusted-keys/trusted_tpm2.c | 23 +++++++++++++++++------
>  1 file changed, 17 insertions(+), 6 deletions(-)
> 
> diff --git a/security/keys/trusted-keys/trusted_tpm2.c b/security/keys/trusted-keys/trusted_tpm2.c
> index 0165da386289..8b7ab22950d1 100644
> --- a/security/keys/trusted-keys/trusted_tpm2.c
> +++ b/security/keys/trusted-keys/trusted_tpm2.c
> @@ -32,6 +32,7 @@ static int tpm2_key_encode(struct trusted_key_payload *payload,
>  			   struct trusted_key_options *options,
>  			   u8 *src, u32 len)
>  {
> +	int err;

Declare as the last local variable (reverse christmas tree order).

Also, I'd use "int ret" since in other functions that is used.

>  	const int SCRATCH_SIZE = PAGE_SIZE;
>  	u8 *scratch = kmalloc(SCRATCH_SIZE, GFP_KERNEL);
>  	u8 *work = scratch, *work1;
> @@ -57,8 +58,10 @@ static int tpm2_key_encode(struct trusted_key_payload *payload,
>  		unsigned char bool[3], *w = bool;
>  		/* tag 0 is emptyAuth */
>  		w = asn1_encode_boolean(w, w + sizeof(bool), true);
> -		if (WARN(IS_ERR(w), "BUG: Boolean failed to encode"))
> -			return PTR_ERR(w);
> +		if (WARN(IS_ERR(w), "BUG: Boolean failed to encode")) {
> +			err = PTR_ERR(w);
> +			goto out;
> +		}
>  		work = asn1_encode_tag(work, end_work, 0, bool, w - bool);
>  	}
>  
> @@ -69,8 +72,10 @@ static int tpm2_key_encode(struct trusted_key_payload *payload,
>  	 * trigger, so if it does there's something nefarious going on
>  	 */
>  	if (WARN(work - scratch + pub_len + priv_len + 14 > SCRATCH_SIZE,
> -		 "BUG: scratch buffer is too small"))
> -		return -EINVAL;
> +		 "BUG: scratch buffer is too small")) {
> +		err = -EINVAL;
> +		goto out;
> +	}
>  
>  	work = asn1_encode_integer(work, end_work, options->keyhandle);
>  	work = asn1_encode_octet_string(work, end_work, pub, pub_len);
> @@ -79,10 +84,16 @@ static int tpm2_key_encode(struct trusted_key_payload *payload,
>  	work1 = payload->blob;
>  	work1 = asn1_encode_sequence(work1, work1 + sizeof(payload->blob),
>  				     scratch, work - scratch);
> -	if (WARN(IS_ERR(work1), "BUG: ASN.1 encoder failed"))
> -		return PTR_ERR(work1);
> +	if (WARN(IS_ERR(work1), "BUG: ASN.1 encoder failed")) {
> +		err = -EINVAL;
> +		goto out;

Why you are changing the return value from PTR_ERR(work1
to -EINVAL?

> +	}
> +	kfree(scratch);
>  
>  	return work1 - payload->blob;
> +
> +out:

Nit:

err:

It's only used for the error path.

> +	return err;
>  }
>  
>  struct tpm2_key_context {
> -- 
> 2.25.1
> 

BR, Jarkko
