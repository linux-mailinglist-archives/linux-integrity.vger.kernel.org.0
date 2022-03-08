Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A02E44D1243
	for <lists+linux-integrity@lfdr.de>; Tue,  8 Mar 2022 09:30:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243549AbiCHIba (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 8 Mar 2022 03:31:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238409AbiCHIbY (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 8 Mar 2022 03:31:24 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA70A3F8A1;
        Tue,  8 Mar 2022 00:30:24 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 9924FB8179F;
        Tue,  8 Mar 2022 08:30:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DD48FC340EB;
        Tue,  8 Mar 2022 08:30:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1646728222;
        bh=d4iX8PMKAGFjzqQJsmEWtLrsA3AzOiHHSY+t4oi+qwo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Wyml7Am/nzk+GK45JiukdCoLYjIeuQbDYqgDJxA/Ge5dZXUOoTVH2Kq2PKrmiYcTI
         mfj0O29ZG+Kgcfel2g5Ymz+Ye7gVpUOrQ2ajEUvtQDt4RitMQINFc/bPSD1qvmq/Xd
         RyDFqv71c+ndZ6gLyhJYEJRa6mUT7GACA9yJAvFbusIYfiFwpXmVrUo+yH6TBbUxu1
         AaHVuYDou1Ld96hJF12vkfaTICg4yL/4zzMJhL7OIe3irpG3NPFTYBDawpnjdbZioh
         VBvcabxQ2Uad9ERSArFwdCslBGgndE0JcZEwktTeZtSo7MFouUZw2r6Ue30r9Hz6vs
         wHvETz1aPTaCw==
Date:   Tue, 8 Mar 2022 10:29:41 +0200
From:   Jarkko Sakkinen <jarkko@kernel.org>
To:     James Bottomley <James.Bottomley@hansenpartnership.com>
Cc:     Sergey Temerkhanov <s.temerkhanov@gmail.com>,
        Peter Huewe <peterhuewe@gmx.de>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Jerry Snitselaar <jsnitsel@redhat.com>,
        linux-integrity@vger.kernel.org,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] tpm: use try_get_ops() in tpm-space.c
Message-ID: <YicT9Rjowdtzbrpp@iki.fi>
References: <3953c743ce7e7fc1db26f5b849b53df671b2f221.camel@HansenPartnership.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3953c743ce7e7fc1db26f5b849b53df671b2f221.camel@HansenPartnership.com>
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Mon, Mar 07, 2022 at 03:58:03PM -0500, James Bottomley wrote:
> As part of the series conversion to remove nested TPM operations:
> 
> https://lore.kernel.org/all/20190205224723.19671-1-jarkko.sakkinen@linux.intel.com/
> 
> exposure of the chip->tpm_mutex was removed from much of the upper
> level code.  In this conversion, tpm2_del_space() was missed.  This
> didn't matter much because it's usually called closely after a
> converted operation, so there's only a very tiny race window where the
> chip can be removed before the space flushing is done which causes a
> NULL deref on the mutex.  However, there are reports of this window
> being hit in practice, so fix this by converting tpm2_del_space() to
> use tpm_try_get_ops(), which performs all the teardown checks before
> acquring the mutex.
> 
> Signed-off-by: James Bottomley <James.Bottomley@HansenPartnership.com>
> Reviewed-by: Jarkko Sakkinen <jarkko@kernel.org>
> ---
>  drivers/char/tpm/tpm2-space.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/char/tpm/tpm2-space.c b/drivers/char/tpm/tpm2-space.c
> index 265ec72b1d81..ffb35f0154c1 100644
> --- a/drivers/char/tpm/tpm2-space.c
> +++ b/drivers/char/tpm/tpm2-space.c
> @@ -58,12 +58,12 @@ int tpm2_init_space(struct tpm_space *space, unsigned int buf_size)
>  
>  void tpm2_del_space(struct tpm_chip *chip, struct tpm_space *space)
>  {
> -	mutex_lock(&chip->tpm_mutex);
> -	if (!tpm_chip_start(chip)) {
> +
> +	if (tpm_try_get_ops(chip) == 0) {
>  		tpm2_flush_sessions(chip, space);
> -		tpm_chip_stop(chip);
> +		tpm_put_ops(chip);
>  	}
> -	mutex_unlock(&chip->tpm_mutex);
> +
>  	kfree(space->context_buf);
>  	kfree(space->session_buf);
>  }
> -- 
> 2.34.1
> 
> 

Thank you! 

BR, Jarkko
