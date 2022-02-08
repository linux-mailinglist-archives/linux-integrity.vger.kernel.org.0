Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0567D4AD12B
	for <lists+linux-integrity@lfdr.de>; Tue,  8 Feb 2022 06:41:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232262AbiBHFjs (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 8 Feb 2022 00:39:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347281AbiBHFjK (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 8 Feb 2022 00:39:10 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31682C002B78;
        Mon,  7 Feb 2022 21:35:40 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id BF0F76158D;
        Tue,  8 Feb 2022 05:35:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C60B6C004E1;
        Tue,  8 Feb 2022 05:35:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1644298539;
        bh=AXrY6BR4KI/ng+vUcusbxpW1VwMvDAX1ZU0xAfw+9y4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=i+04zGq/Laqd9CbZa4lVMSe5EweAJT5NuF19YS9bJhrw8eScaNEb1pMx2xDcbyBAd
         jkjHZzi+UMYsao6mydGUCxiGVZGzsaAVPYZeVG5aVn7WrsT8/31L0tA/Bkhp4azjR9
         A2b8YE+rnl8gJwb99Btdtu4rWKXMHixecXWFuMvvR/MCaFW4rwIB5BvRskWp9JKgah
         RpmFOdYzte55ydABGggVDZ2Lta1A0zXhuEhTAVwgLdzCK/OpIUJ2zY1rtfOCm98Lsq
         VbpkdQSJp0nGkOfVKy2zvn/He0JBx3LzJX4p6drPoRWf9noSbWVbxb98RFj0TaapRS
         rO7bCt5Ab426w==
Date:   Mon, 7 Feb 2022 21:35:37 -0800
From:   Eric Biggers <ebiggers@kernel.org>
To:     Tianjia Zhang <tianjia.zhang@linux.alibaba.com>
Cc:     Mimi Zohar <zohar@linux.ibm.com>,
        Vitaly Chikunov <vt@altlinux.org>,
        Stefan Berger <stefanb@linux.ibm.com>,
        Jarkko Sakkinen <jarkko@kernel.org>,
        Gilad Ben-Yossef <gilad@benyossef.com>,
        David Howells <dhowells@redhat.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>, keyrings@vger.kernel.org,
        linux-crypto@vger.kernel.org, linux-integrity@vger.kernel.org
Subject: Re: [PATCH] KEYS: asymmetric: enforce SM2 signature use pkey algo
Message-ID: <YgIBKeFkiKtD1unK@sol.localdomain>
References: <20220201003414.55380-1-ebiggers@kernel.org>
 <20220207114327.7929-1-tianjia.zhang@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220207114327.7929-1-tianjia.zhang@linux.alibaba.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Mon, Feb 07, 2022 at 07:43:27PM +0800, Tianjia Zhang wrote:
> The signature verification of SM2 needs to add the Za value and
> recalculate sig->digest, which requires the detection of the pkey_algo
> in public_key_verify_signature(). As Eric Biggers said, the pkey_algo
> field in sig is attacker-controlled and should be use pkey->pkey_algo
> instead of sig->pkey_algo, and secondly, if sig->pkey_algo is NULL, it
> will also cause signature verification failure.
> 
> The software_key_determine_akcipher() already forces the algorithms
> are matched, so the SM3 algorithm is enforced in the SM2 signature,
> although this has been checked, we still avoid using any algorithm
> information in the signature as input.
> 
> Reported-by: Eric Biggers <ebiggers@google.com>
> Signed-off-by: Tianjia Zhang <tianjia.zhang@linux.alibaba.com>

Can you add a Fixes tag?

> ---
>  crypto/asymmetric_keys/public_key.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/crypto/asymmetric_keys/public_key.c b/crypto/asymmetric_keys/public_key.c
> index a603ee8afdb8..ea9a5501f87e 100644
> --- a/crypto/asymmetric_keys/public_key.c
> +++ b/crypto/asymmetric_keys/public_key.c
> @@ -309,7 +309,8 @@ static int cert_sig_digest_update(const struct public_key_signature *sig,
>  	if (ret)
>  		return ret;
>  
> -	tfm = crypto_alloc_shash(sig->hash_algo, 0, 0);
> +	/* SM2 signatures always use the SM3 hash algorithm */
> +	tfm = crypto_alloc_shash("sm3", 0, 0);
>  	if (IS_ERR(tfm))
>  		return PTR_ERR(tfm);
>  
> @@ -414,8 +415,7 @@ int public_key_verify_signature(const struct public_key *pkey,
>  	if (ret)
>  		goto error_free_key;
>  
> -	if (sig->pkey_algo && strcmp(sig->pkey_algo, "sm2") == 0 &&
> -	    sig->data_size) {
> +	if (strcmp(pkey->pkey_algo, "sm2") == 0 && sig->data_size) {
>  		ret = cert_sig_digest_update(sig, tfm);
>  		if (ret)
>  			goto error_free_key;
> -- 

This is an improvement, but do you also have a plan to address the problem where
the code allows the "Za" hash step to be skipped?  The definitions of SM2 that I
could find require that step.  So, it is unclear that the algorithm with that
step skipped is still SM2, and how its security relates to that of the SM2
algorithm as actually defined.

- Eric
