Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A05D66C139F
	for <lists+linux-integrity@lfdr.de>; Mon, 20 Mar 2023 14:38:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231376AbjCTNi4 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 20 Mar 2023 09:38:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231282AbjCTNiw (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 20 Mar 2023 09:38:52 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A1511BDF
        for <linux-integrity@vger.kernel.org>; Mon, 20 Mar 2023 06:38:03 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 722B2B80E8F
        for <linux-integrity@vger.kernel.org>; Mon, 20 Mar 2023 13:38:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D295BC433D2;
        Mon, 20 Mar 2023 13:37:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1679319480;
        bh=5Fj7q2Vm2mdGMDZzxM9uDY+A8NFQW/3j+SwERkR4DYY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=FWx2F8AyjIoUZm44ZaPpPBPc/H/JIoePfR10McXG9YQ+Ffq2W6XPmfK76qhEoOZac
         UxBW/4TaupuzCLukkZrsQt1d/+mPQAYaTaKXmgGdEkV6qp6pheP81OLptLudIpN780
         K1SrBppssrQ3CSeNSdGM48LPimlluE3eggnXBlq5suiCQjc3lghyOB/QrD0F7Qqvgm
         mJOe/4tZYKxF9gBQPnEUBAmrhOn6UC0tK4Hq8jhFIV3XVi+9SYH0wi+4+jSQO/RX9+
         H74L9WM16NZbftFhOgce+MXcVvmL+XCokGc3fYC/Nk21i7lh9To8fYmpGJNrnukRpl
         cB9CKU0K3GuOA==
Date:   Mon, 20 Mar 2023 15:37:56 +0200
From:   Jarkko Sakkinen <jarkko@kernel.org>
To:     James Bottomley <James.Bottomley@HansenPartnership.com>
Cc:     linux-integrity@vger.kernel.org,
        "Jason A. Donenfeld" <Jason@zx2c4.com>,
        Mario Limonciello <mario.limonciello@amd.com>
Subject: Re: tpm: fix build break in tpm-chip.c caused by AMD fTPM quirk
Message-ID: <20230320133756.owgccfew4qahw4zv@kernel.org>
References: <de3ee520780be213c421685805c751dcda0754df.camel@HansenPartnership.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <de3ee520780be213c421685805c751dcda0754df.camel@HansenPartnership.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Mon, Mar 20, 2023 at 07:15:52AM -0400, James Bottomley wrote:
> The test for the AMD fTPM problem, which just went in, actually uses
> the wrong function template for request_locality().  It's missing an
> argument so the build breaks:
> 
> drivers/char/tpm/tpm-chip.c:568:8: error: too few arguments to function ‘tpm_request_locality’
>   ret = tpm_request_locality(chip);
>         ^~~~~~~~~~~~~~~~~~~~
> drivers/char/tpm/tpm-chip.c:43:12: note: declared here
>  static int tpm_request_locality(struct tpm_chip *chip, int locality)
>             ^~~~~~~~~~~~~~~~~~~~
> 
> Fix this by requesting zero locality.
> 
> Signed-off-by: James Bottomley <James.Bottomley@HansenPartnership.com>
> Fixes: f1324bbc4011 ("tpm: disable hwrng for fTPM on some AMD designs")
> 
> ---
> 
> diff --git a/drivers/char/tpm/tpm-chip.c b/drivers/char/tpm/tpm-chip.c
> index c04d101c7779..fee061780468 100644
> --- a/drivers/char/tpm/tpm-chip.c
> +++ b/drivers/char/tpm/tpm-chip.c
> @@ -565,7 +565,7 @@ static bool tpm_amd_is_rng_defective(struct tpm_chip *chip)
>  	if (!(chip->flags & TPM_CHIP_FLAG_TPM2))
>  		return false;
>  
> -	ret = tpm_request_locality(chip);
> +	ret = tpm_request_locality(chip, 0);
>  	if (ret)
>  		return false;
>  
> 

Thank you, I sent a PR for rc4.

BR, Jarkko
