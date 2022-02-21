Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 38AE94BEBAC
	for <lists+linux-integrity@lfdr.de>; Mon, 21 Feb 2022 21:17:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231960AbiBUURs (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 21 Feb 2022 15:17:48 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:40876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229893AbiBUURr (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 21 Feb 2022 15:17:47 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35A64DB7;
        Mon, 21 Feb 2022 12:17:24 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id D6A2CB81785;
        Mon, 21 Feb 2022 20:17:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B7598C340E9;
        Mon, 21 Feb 2022 20:17:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1645474641;
        bh=dnQuGiR73ixyr/qHaebR8rI5KYcoq4B8BGxdgy9X28E=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=VTYgeONiBwaeAdUXLj1vds23ScSw99LVpQSxql7Ttzu9t4M2T7uUc+F1dO3+Z9DjX
         5GHTH+FF+9LZ1hQ8r2vAt/vGc2qQKUxAEsZPHFqEdYeUR/zjx4o422SIzgBDz/ivZk
         WoaJ6mKpWpfQqyXznd9ne8Yq30EkWDGmu3j6LmdXVBdDJ0IjstEGxYUDi0y9v/6NtF
         DEPWwzHf+1Zj0LG3fu68cH534J56Z+PXsAzvmJumUP3GduemvYYGI3twyXH8cNqQ5Q
         vmcmvS19YQK+eFYSIQlJEM51T1zQ3Qv11j79nZA5ExjuWuplmZVo77guhK/fNEBFv7
         8LiKYyZ3YnsTA==
Date:   Mon, 21 Feb 2022 21:17:57 +0100
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
Message-ID: <YhPzdTPFLd77f2p6@iki.fi>
References: <20220201003414.55380-1-ebiggers@kernel.org>
 <20220207114327.7929-1-tianjia.zhang@linux.alibaba.com>
 <YhLvtVT89tAjGnqw@kernel.org>
 <17d1a498-6b27-c61b-787d-667abbbb955b@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <17d1a498-6b27-c61b-787d-667abbbb955b@linux.alibaba.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Mon, Feb 21, 2022 at 10:43:39AM +0800, Tianjia Zhang wrote:
> Hi Jarkko,
> 
> On 2/21/22 9:49 AM, Jarkko Sakkinen wrote:
> > On Mon, Feb 07, 2022 at 07:43:27PM +0800, Tianjia Zhang wrote:
> > > The signature verification of SM2 needs to add the Za value and
> > > recalculate sig->digest, which requires the detection of the pkey_algo
> > > in public_key_verify_signature(). As Eric Biggers said, the pkey_algo
> > > field in sig is attacker-controlled and should be use pkey->pkey_algo
> > > instead of sig->pkey_algo, and secondly, if sig->pkey_algo is NULL, it
> > > will also cause signature verification failure.
> > > 
> > > The software_key_determine_akcipher() already forces the algorithms
> > > are matched, so the SM3 algorithm is enforced in the SM2 signature,
> > > although this has been checked, we still avoid using any algorithm
> > > information in the signature as input.
> > > 
> > > Reported-by: Eric Biggers <ebiggers@google.com>
> > > Signed-off-by: Tianjia Zhang <tianjia.zhang@linux.alibaba.com>
> > > ---
> > >   crypto/asymmetric_keys/public_key.c | 6 +++---
> > >   1 file changed, 3 insertions(+), 3 deletions(-)
> > > 
> > > diff --git a/crypto/asymmetric_keys/public_key.c b/crypto/asymmetric_keys/public_key.c
> > > index a603ee8afdb8..ea9a5501f87e 100644
> > > --- a/crypto/asymmetric_keys/public_key.c
> > > +++ b/crypto/asymmetric_keys/public_key.c
> > > @@ -309,7 +309,8 @@ static int cert_sig_digest_update(const struct public_key_signature *sig,
> > >   	if (ret)
> > >   		return ret;
> > > -	tfm = crypto_alloc_shash(sig->hash_algo, 0, 0);
> > > +	/* SM2 signatures always use the SM3 hash algorithm */
> > > +	tfm = crypto_alloc_shash("sm3", 0, 0);
> > 
> > Why not simply fail when sig->hash_algo != "sm3"?
> > 
> > BR, Jarkko
> 
> This series of Eric's patch 2/2 has done this check.
> 
> Best regards,
> Tianjia

Hmm... So how does that make this legit?

BR, Jarkko
