Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE6244BD33D
	for <lists+linux-integrity@lfdr.de>; Mon, 21 Feb 2022 02:49:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245497AbiBUBt1 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Sun, 20 Feb 2022 20:49:27 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:57222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245495AbiBUBt0 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Sun, 20 Feb 2022 20:49:26 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC4D0517D0;
        Sun, 20 Feb 2022 17:49:04 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 7CFABB80E3A;
        Mon, 21 Feb 2022 01:49:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B3B1AC340E8;
        Mon, 21 Feb 2022 01:49:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1645408142;
        bh=HI8NVCMsfUlolaSoMOjtjL/nBpAaZNebOImBZ6Z/x+M=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=i8bOsZ7z2/9hNP2dixd0AchqiaV/IHsV0ZEvA0lcp4lStTEKDeSp++UCFu5Ra8oFV
         R8sZnFes4j0ripdQcghiaXGUhzLJjKffOr+AGNAU1XTkd8O+dohR3ScXfcfIn+pELg
         PxYJkzRykkHCObD8N6odV/nJOMpcue0g5ctk/wFjLtFoI/rudwpJ9paZiye/4EliYQ
         KoafkiKLP5+FLZP0bLMDsUgbZIqbxyiwtMQE+s9GyJXfbKLC+zBPehU/qMii9MaBiv
         IVNkbX0rwu9HfLmDdPRSFqh6zr1FzlGRjXHdmHp/4r3bLKNAS5mvoC730NRNwQyCig
         ox/iRUxYjoygg==
Date:   Mon, 21 Feb 2022 02:49:41 +0100
From:   Jarkko Sakkinen <jarkko@kernel.org>
To:     Tianjia Zhang <tianjia.zhang@linux.alibaba.com>
Cc:     Eric Biggers <ebiggers@google.com>,
        Mimi Zohar <zohar@linux.ibm.com>,
        Vitaly Chikunov <vt@altlinux.org>,
        Stefan Berger <stefanb@linux.ibm.com>,
        Gilad Ben-Yossef <gilad@benyossef.com>,
        David Howells <dhowells@redhat.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>, keyrings@vger.kernel.org,
        linux-crypto@vger.kernel.org, linux-integrity@vger.kernel.org
Subject: Re: [PATCH] KEYS: asymmetric: enforce SM2 signature use pkey algo
Message-ID: <YhLvtVT89tAjGnqw@kernel.org>
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

Why not simply fail when sig->hash_algo != "sm3"?

BR, Jarkko
