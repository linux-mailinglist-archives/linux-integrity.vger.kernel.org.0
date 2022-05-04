Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB40C519653
	for <lists+linux-integrity@lfdr.de>; Wed,  4 May 2022 06:17:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344513AbiEDEUe (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 4 May 2022 00:20:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344519AbiEDEUc (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 4 May 2022 00:20:32 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 857C61F632;
        Tue,  3 May 2022 21:16:54 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 255AE61A71;
        Wed,  4 May 2022 04:16:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 03405C385A5;
        Wed,  4 May 2022 04:16:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1651637813;
        bh=kuLEziF1RBwT7frZNU3CgmC3ZYuUArL6BjwI7VssVcU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=mX6chb6cqJWKfxIy+ImvfapILLIsi07JxyNr3R2RM+0iI34p5GUqvRFrTBPmXQHd0
         vbCZ7srmv22qLBxzzKFiyCFjTfTdRr/cFINMCigIHP3t3bHCKloHRvaRw9qza/wwcD
         MTPPrVkmRd0dZg8S2BO8SrE9TdFCoVY3t1kyw9d1SJl11s0TPudFrq2plK/mgwbYTI
         yOrgAzt6TNuZ7cEMBCLoBuTUCfNv5Mib63k1ZFogsDq9TPSCro4+iEf2hqC4+3TsHb
         tq+j9eJW8mUOSXkEKtHg2nyvSc4sLmJ2qwDhYMt8G1HD/05kXexL1C9RQAMTF9oMhx
         0AsKcvMUKgjhg==
Date:   Wed, 4 May 2022 07:15:28 +0300
From:   Jarkko Sakkinen <jarkko@kernel.org>
To:     Ahmad Fatoum <a.fatoum@pengutronix.de>
Cc:     Jonathan Corbet <corbet@lwn.net>,
        David Howells <dhowells@redhat.com>,
        James Bottomley <jejb@linux.ibm.com>,
        Mimi Zohar <zohar@linux.ibm.com>, kernel@pengutronix.de,
        Pankaj Gupta <pankaj.gupta@nxp.com>,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        Horia =?utf-8?Q?Geant=C4=83?= <horia.geanta@nxp.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Biggers <ebiggers@kernel.org>,
        Jan Luebbe <j.luebbe@pengutronix.de>,
        David Gstir <david@sigma-star.at>,
        Richard Weinberger <richard@nod.at>,
        Franck LENORMAND <franck.lenormand@nxp.com>,
        Matthias Schiffer <matthias.schiffer@ew.tq-group.com>,
        Sumit Garg <sumit.garg@linaro.org>, keyrings@vger.kernel.org,
        linux-crypto@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-security-module@vger.kernel.org
Subject: Re: [PATCH v8 5/6] doc: trusted-encrypted: describe new CAAM trust
 source
Message-ID: <YnH94F62yDHPxRlK@kernel.org>
References: <20220428140145.870527-1-a.fatoum@pengutronix.de>
 <20220428140145.870527-6-a.fatoum@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220428140145.870527-6-a.fatoum@pengutronix.de>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Thu, Apr 28, 2022 at 04:01:44PM +0200, Ahmad Fatoum wrote:
> Update documentation for trusted key use with the Cryptographic
> Acceleration and Assurance Module (CAAM), an IP on NXP SoCs.
> 
> Reviewed-by: Pankaj Gupta <pankaj.gupta@nxp.com>
> Signed-off-by: Ahmad Fatoum <a.fatoum@pengutronix.de>
> ---
> v7 -> v8:
>   - add Pankaj's Reviewed-by
> v6 -> v7:
>   - docs update split off as new Patch (Jarkko)
>   - fixed typo in "Trusted Keys usage: CAAM" section
> 
> To: Jonathan Corbet <corbet@lwn.net>
> To: David Howells <dhowells@redhat.com>
> To: Jarkko Sakkinen <jarkko@kernel.org>
> To: James Bottomley <jejb@linux.ibm.com>
> To: Mimi Zohar <zohar@linux.ibm.com>
> Cc: James Morris <jmorris@namei.org>
> Cc: "Serge E. Hallyn" <serge@hallyn.com>
> Cc: "Horia Geantă" <horia.geanta@nxp.com>
> Cc: Pankaj Gupta <pankaj.gupta@nxp.com>
> Cc: Herbert Xu <herbert@gondor.apana.org.au>
> Cc: "David S. Miller" <davem@davemloft.net>
> Cc: Eric Biggers <ebiggers@kernel.org>
> Cc: Jan Luebbe <j.luebbe@pengutronix.de>
> Cc: David Gstir <david@sigma-star.at>
> Cc: Richard Weinberger <richard@nod.at>
> Cc: Franck LENORMAND <franck.lenormand@nxp.com>
> Cc: Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
> Cc: Sumit Garg <sumit.garg@linaro.org>
> Cc: keyrings@vger.kernel.org
> Cc: linux-crypto@vger.kernel.org
> Cc: linux-doc@vger.kernel.org
> Cc: linux-integrity@vger.kernel.org
> Cc: linux-kernel@vger.kernel.org
> Cc: linux-security-module@vger.kernel.org
> ---
>  .../security/keys/trusted-encrypted.rst       | 40 ++++++++++++++++++-
>  1 file changed, 39 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/security/keys/trusted-encrypted.rst b/Documentation/security/keys/trusted-encrypted.rst
> index 2fe6fd1a2bbd..0bfb4c339748 100644
> --- a/Documentation/security/keys/trusted-encrypted.rst
> +++ b/Documentation/security/keys/trusted-encrypted.rst
> @@ -35,6 +35,13 @@ safe.
>           Rooted to Hardware Unique Key (HUK) which is generally burnt in on-chip
>           fuses and is accessible to TEE only.
>  
> +     (3) CAAM (Cryptographic Acceleration and Assurance Module: IP on NXP SoCs)
> +
> +         When High Assurance Boot (HAB) is enabled and the CAAM is in secure
> +         mode, trust is rooted to the OTPMK, a never-disclosed 256-bit key
> +         randomly generated and fused into each SoC at manufacturing time.
> +         Otherwise, a common fixed test key is used instead.
> +
>    *  Execution isolation
>  
>       (1) TPM
> @@ -46,6 +53,10 @@ safe.
>           Customizable set of operations running in isolated execution
>           environment verified via Secure/Trusted boot process.
>  
> +     (3) CAAM
> +
> +         Fixed set of operations running in isolated execution environment.
> +
>    * Optional binding to platform integrity state
>  
>       (1) TPM
> @@ -63,6 +74,11 @@ safe.
>           Relies on Secure/Trusted boot process for platform integrity. It can
>           be extended with TEE based measured boot process.
>  
> +     (3) CAAM
> +
> +         Relies on the High Assurance Boot (HAB) mechanism of NXP SoCs
> +         for platform integrity.
> +
>    *  Interfaces and APIs
>  
>       (1) TPM
> @@ -74,10 +90,13 @@ safe.
>           TEEs have well-documented, standardized client interface and APIs. For
>           more details refer to ``Documentation/staging/tee.rst``.
>  
> +     (3) CAAM
> +
> +         Interface is specific to silicon vendor.
>  
>    *  Threat model
>  
> -     The strength and appropriateness of a particular TPM or TEE for a given
> +     The strength and appropriateness of a particular trust source for a given
>       purpose must be assessed when using them to protect security-relevant data.
>  
>  
> @@ -104,6 +123,12 @@ selected trust source:
>       from platform specific hardware RNG or a software based Fortuna CSPRNG
>       which can be seeded via multiple entropy sources.
>  
> +  *  CAAM: Kernel RNG
> +
> +     The normal kernel random number generator is used. To seed it from the
> +     CAAM HWRNG, enable CRYPTO_DEV_FSL_CAAM_RNG_API and ensure the device
> +     is probed.
> +
>  Users may override this by specifying ``trusted.rng=kernel`` on the kernel
>  command-line to override the used RNG with the kernel's random number pool.
>  
> @@ -193,6 +218,19 @@ Usage::
>  specific to TEE device implementation.  The key length for new keys is always
>  in bytes. Trusted Keys can be 32 - 128 bytes (256 - 1024 bits).
>  
> +Trusted Keys usage: CAAM
> +------------------------
> +
> +Usage::
> +
> +    keyctl add trusted name "new keylen" ring
> +    keyctl add trusted name "load hex_blob" ring
> +    keyctl print keyid
> +
> +"keyctl print" returns an ASCII hex copy of the sealed key, which is in a
> +CAAM-specific format.  The key length for new keys is always in bytes.
> +Trusted Keys can be 32 - 128 bytes (256 - 1024 bits).
> +
>  Encrypted Keys usage
>  --------------------
>  
> -- 
> 2.30.2
> 

Reviewed-by: Jarkko Sakkinen <jarkko@kernel.org>

BR, Jarkko
