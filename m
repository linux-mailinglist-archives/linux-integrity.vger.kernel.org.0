Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 30E5F5427DA
	for <lists+linux-integrity@lfdr.de>; Wed,  8 Jun 2022 09:47:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232989AbiFHHa7 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 8 Jun 2022 03:30:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352482AbiFHGQE (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 8 Jun 2022 02:16:04 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0193231398;
        Tue,  7 Jun 2022 22:49:36 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9057C619E1;
        Wed,  8 Jun 2022 05:49:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9258EC34116;
        Wed,  8 Jun 2022 05:49:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1654667375;
        bh=u8WDlK6nbiqQrhUyJTCvQcFC26Lk50FBqfzDklR810A=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=l1xpWHvwjUgQkTiiFrC6/QTYRo2lQbE3m9Ui6x3OVfvti5TZEBcnfDIc/p7wdGPGe
         TdFYRO5aWtGl0kjNm7RYt7UjccAxSRxY5FK02gapS3jtdHGd/Ler548BllMUYuz0U5
         76k8fGn/UiwmkgBjpRBtLDiiZntsQ8WSzUuwD9+Tnw08FgMTenNcAdbrHLQfPnnGvf
         S+Hj2q+yo/Jdj0JEpUtgE2ruOxEaAiEfyCLBZhuns/02Frei7EtKKatC7qqFQevYLm
         OCmkesrp9fCQeDUYnaVJw1thgBwUj2jqQcGOBXG3JTlCxQ2ftYpANM2S4lTq4z7jj/
         z8xLg8WrIyyDQ==
Date:   Wed, 8 Jun 2022 08:47:38 +0300
From:   Jarkko Sakkinen <jarkko@kernel.org>
To:     david.safford@gmail.com
Cc:     Ahmad Fatoum <a.fatoum@pengutronix.de>,
        James Bottomley <jejb@linux.ibm.com>,
        Mimi Zohar <zohar@linux.ibm.com>,
        David Howells <dhowells@redhat.com>,
        James Morris <jmorris@namei.org>,
        "SergeE.Hallyn" <serge@hallyn.com>,
        linux-integrity@vger.kernel.org, keyrings@vger.kernel.org,
        linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] KEYS: trusted: tpm2: Fix migratable logic
Message-ID: <YqA3+vfte7RbbGBa@iki.fi>
References: <141492344ae13c9842626e696685316ee340d717.camel@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <141492344ae13c9842626e696685316ee340d717.camel@gmail.com>
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Tue, Jun 07, 2022 at 02:07:57PM -0400, david.safford@gmail.com wrote:
> When creating (sealing) a new trusted key, migratable
> trusted keys have the FIXED_TPM and FIXED_PARENT attributes
> set, and non-migratable keys don't. This is backwards, and
> also causes creation to fail when creating a migratable key
> under a migratable parent. (The TPM thinks you are trying to
> seal a non-migratable blob under a migratable parent.)
> 
> The following simple patch fixes the logic, and has been
> tested for all four combinations of migratable and non-migratable
> trusted keys and parent storage keys. With this logic, you will
> get a proper failure if you try to create a non-migratable
> trusted key under a migratable parent storage key, and all other
> combinations work correctly.
> 
> Fixes: e5fb5d2c5a03 ("security: keys: trusted: Make sealed key properly interoperable")
> Signed-off-by: David Safford <david.safford@gmail.com>
> ---
> Changelog:
>  * v2:
>    * added Signed-off-by, Fixes, proper Subject and distribution
> .
>  security/keys/trusted-keys/trusted_tpm2.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/security/keys/trusted-keys/trusted_tpm2.c b/security/keys/trusted-keys/trusted_tpm2.c
> index 0165da386289..2b2c8eb258d5 100644
> --- a/security/keys/trusted-keys/trusted_tpm2.c
> +++ b/security/keys/trusted-keys/trusted_tpm2.c
> @@ -283,8 +283,8 @@ int tpm2_seal_trusted(struct tpm_chip *chip,
>  	/* key properties */
>  	flags = 0;
>  	flags |= options->policydigest_len ? 0 : TPM2_OA_USER_WITH_AUTH;
> -	flags |= payload->migratable ? (TPM2_OA_FIXED_TPM |
> -					TPM2_OA_FIXED_PARENT) : 0;
> +	flags |= payload->migratable ? 0 : (TPM2_OA_FIXED_TPM |
> +					    TPM2_OA_FIXED_PARENT);
>  	tpm_buf_append_u32(&buf, flags);
> 
>  	/* policy */
> --
> 2.36.1

David, thanks a lot for fixing this (what an embarrassing bug)!

Reviewed-by: Jarkko Sakkinen <jarkko@kernel.org>

BR, Jarkko
