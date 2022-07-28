Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 395B1583A07
	for <lists+linux-integrity@lfdr.de>; Thu, 28 Jul 2022 10:07:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234990AbiG1IHZ (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 28 Jul 2022 04:07:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234838AbiG1IHY (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 28 Jul 2022 04:07:24 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE3184BD07;
        Thu, 28 Jul 2022 01:07:23 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5C13761B89;
        Thu, 28 Jul 2022 08:07:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6A82AC433C1;
        Thu, 28 Jul 2022 08:07:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1658995642;
        bh=+HJ6jlAD0ouWT2q+KDfgQAcYPW1ZDvP8eATEJFjyLNQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=EORXPtO2GMMtPF95tHjY1C1ceuBdtFgTuIPtUvaOWzpXvtlMFJ8iZyndsUvS1/tvO
         rFi4/wltv4mJyt52zll5VvTVNLeNaiJdqMqNR/HLzPIxyu2vkOjRa/hIJU6AgYtxMw
         884HHcxbC81jJiv/+JHVNR/esc/6ABm2JN53uxxhQzZNnU/kLPtJik+I+nQvX/Navj
         GOXFZeUqYFjLvSBs4w/uZ8cW3nVGI2Hi0Nn+eC29FTWXMbCJf3i0/ns+oUbrThhtGA
         nVVDwWQVLemryqS+lf+pkB/ocYg2h1g0yTMw8zV0E2+W30UY9maC35xirn0IWoNoIB
         FJVq5w5pWGHig==
Date:   Thu, 28 Jul 2022 11:07:19 +0300
From:   Jarkko Sakkinen <jarkko@kernel.org>
To:     Jianglei Nie <niejianglei2021@163.com>
Cc:     jejb@linux.ibm.com, zohar@linux.ibm.com, dhowells@redhat.com,
        jmorris@namei.org, serge@hallyn.com,
        linux-integrity@vger.kernel.org, keyrings@vger.kernel.org,
        linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] KEYS: trusted: Fix memory leak in tpm2_key_encode()
Message-ID: <YuJDt6T6tUv76bIT@kernel.org>
References: <YqGE/v0Zgi+g4gY6@iki.fi>
 <20220722082125.2526529-1-niejianglei2021@163.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220722082125.2526529-1-niejianglei2021@163.com>
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Fri, Jul 22, 2022 at 04:21:25PM +0800, Jianglei Nie wrote:
> tpm2_key_encode() allocates a memory chunk from scratch with kmalloc(),
> but it is never freed, which leads to a memory leak. Free the memory
> chunk with kfree() in the return path.
> 
> Fixes: f2219745250f ("security: keys: trusted: use ASN.1 TPM2 key format for the blobs")
> Signed-off-by: Jianglei Nie <niejianglei2021@163.com>
> ---

The change log is missing. I have no idea what happened in v2 and v3.

>  security/keys/trusted-keys/trusted_tpm2.c | 33 ++++++++++++++++-------
>  1 file changed, 23 insertions(+), 10 deletions(-)
> 
> diff --git a/security/keys/trusted-keys/trusted_tpm2.c b/security/keys/trusted-keys/trusted_tpm2.c
> index 2b2c8eb258d5..eb25c784b5c3 100644
> --- a/security/keys/trusted-keys/trusted_tpm2.c
> +++ b/security/keys/trusted-keys/trusted_tpm2.c
> @@ -32,8 +32,13 @@ static int tpm2_key_encode(struct trusted_key_payload *payload,
>  			   struct trusted_key_options *options,
>  			   u8 *src, u32 len)
>  {
> +	int ret;
>  	const int SCRATCH_SIZE = PAGE_SIZE;
> -	u8 *scratch = kmalloc(SCRATCH_SIZE, GFP_KERNEL);
> +	u8 *scratch;
> +
> +	scratch = kmalloc(SCRATCH_SIZE, GFP_KERNEL);
> +	if (!scratch)
> +		return -ENOMEM;
>  	u8 *work = scratch, *work1;
>  	u8 *end_work = scratch + SCRATCH_SIZE;
>  	u8 *priv, *pub;
> @@ -47,9 +52,6 @@ static int tpm2_key_encode(struct trusted_key_payload *payload,
>  	pub_len = get_unaligned_be16(src) + 2;
>  	pub = src;
>  
> -	if (!scratch)
> -		return -ENOMEM;
> -
>  	work = asn1_encode_oid(work, end_work, tpm2key_oid,
>  			       asn1_oid_len(tpm2key_oid));
>  
> @@ -57,8 +59,10 @@ static int tpm2_key_encode(struct trusted_key_payload *payload,
>  		unsigned char bool[3], *w = bool;
>  		/* tag 0 is emptyAuth */
>  		w = asn1_encode_boolean(w, w + sizeof(bool), true);
> -		if (WARN(IS_ERR(w), "BUG: Boolean failed to encode"))
> -			return PTR_ERR(w);
> +		if (WARN(IS_ERR(w), "BUG: Boolean failed to encode")) {
> +			ret = PTR_ERR(w);
> +			goto err;
> +		}
>  		work = asn1_encode_tag(work, end_work, 0, bool, w - bool);
>  	}
>  
> @@ -69,8 +73,10 @@ static int tpm2_key_encode(struct trusted_key_payload *payload,
>  	 * trigger, so if it does there's something nefarious going on
>  	 */
>  	if (WARN(work - scratch + pub_len + priv_len + 14 > SCRATCH_SIZE,
> -		 "BUG: scratch buffer is too small"))
> -		return -EINVAL;
> +		 "BUG: scratch buffer is too small")) {
> +		ret = -EINVAL;
> +		goto err;
> +	}
>  
>  	work = asn1_encode_integer(work, end_work, options->keyhandle);
>  	work = asn1_encode_octet_string(work, end_work, pub, pub_len);
> @@ -79,10 +85,17 @@ static int tpm2_key_encode(struct trusted_key_payload *payload,
>  	work1 = payload->blob;
>  	work1 = asn1_encode_sequence(work1, work1 + sizeof(payload->blob),
>  				     scratch, work - scratch);
> -	if (WARN(IS_ERR(work1), "BUG: ASN.1 encoder failed"))
> -		return PTR_ERR(work1);
> +	if (WARN(IS_ERR(work1), "BUG: ASN.1 encoder failed")) {
> +		ret = PTR_ERR(work1);
> +		goto err;
> +	}
>  
> +	kfree(scratch);
>  	return work1 - payload->blob;
> +
> +err:
> +	kfree(scratch);
> +	return ret;
>  }
>  
>  struct tpm2_key_context {
> -- 
> 2.25.1
> 

BR, Jarkko
