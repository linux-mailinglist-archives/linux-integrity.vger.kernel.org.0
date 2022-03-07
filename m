Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 301A24D046B
	for <lists+linux-integrity@lfdr.de>; Mon,  7 Mar 2022 17:45:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237612AbiCGQpy (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 7 Mar 2022 11:45:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237287AbiCGQpx (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 7 Mar 2022 11:45:53 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C3B68E1AA;
        Mon,  7 Mar 2022 08:44:58 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 1FF29B8162B;
        Mon,  7 Mar 2022 16:44:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 70865C340F6;
        Mon,  7 Mar 2022 16:44:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1646671495;
        bh=+lMbhkKgsCWNtZnEkoIXQadhDs5xopjEiqcvXcXUsrI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=b5CrvhCv9OZOlezkIrShag5TNQObmfRqwGexTpcHcGYSJMp1OFQJREjB45z/GSsAT
         34fOuRUy+pSTc9q2/jAfvGWsMCgtfmATdlCdotlxq/SywLrfFClyAGw94j8Wh7+PFB
         7pdCElnKDWcqkZwSju/1ewAT5U4DHgpKBFjTw8aOIRIB4mkOfP8qV/PBIBN/vnbUrQ
         UWg3qmOnkefIF/SlKPfca71BCp5jI1SsUSlnnuBuwOisDWDBj8ODJZo1bCCydDB8w0
         DnqgINrvevtzppau6uDs/LXM8uiRevOTjz43BTzJfL5eE+ksYCfpdw9z7thRFWPw/T
         8UbqOt6/0pQPw==
Date:   Mon, 7 Mar 2022 18:44:15 +0200
From:   Jarkko Sakkinen <jarkko@kernel.org>
To:     James Bottomley <James.Bottomley@hansenpartnership.com>
Cc:     Sergey Temerkhanov <s.temerkhanov@gmail.com>,
        Peter Huewe <peterhuewe@gmx.de>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Jerry Snitselaar <jsnitsel@redhat.com>,
        linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] tpm: Rework open/close/shutdown to avoid races
Message-ID: <YiY2X/0W+6aRHioN@iki.fi>
References: <20201215133801.546207-1-s.temerkhanov@gmail.com>
 <e7566e1e48f5be9dca034b4bfb67683b5d3cb88f.camel@HansenPartnership.com>
 <YiYnpsryEDlrryzU@iki.fi>
 <120839d2925750e278810b2ad211f5465638f7b0.camel@HansenPartnership.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <120839d2925750e278810b2ad211f5465638f7b0.camel@HansenPartnership.com>
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Mon, Mar 07, 2022 at 11:22:27AM -0500, James Bottomley wrote:
> On Mon, 2022-03-07 at 17:41 +0200, Jarkko Sakkinen wrote:
> [...]
> > James, would it possible for you to construct a proper patch from
> > this and send it so we could include it to the next PR (use my tree
> > as baseline)?
> 
> Sure,  There's not really any identifiable patch for a fixes tag, since
> the race really always existed.
> 
> How about the below.
> 
> James
> 
> -------------------8>8>8><8<8<8------------------
> 
> From 3e0e640e47e5728b68693c5d45bf3cdd0bff48ca Mon Sep 17 00:00:00 2001
> From: James Bottomley <James.Bottomley@HansenPartnership.com>
> Date: Mon, 7 Mar 2022 11:16:55 -0500
> Subject: [PATCH] tpm: use try_get_ops() in tpm-space.c
> 
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

Thank you! LGTM. 

Reviewed-by: Jarkko Sakkinen <jarkko@kernel.org>

BR, Jarkko
