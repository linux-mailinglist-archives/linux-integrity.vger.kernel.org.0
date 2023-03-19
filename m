Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 488CB6C0216
	for <lists+linux-integrity@lfdr.de>; Sun, 19 Mar 2023 14:36:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230085AbjCSNgw (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Sun, 19 Mar 2023 09:36:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230320AbjCSNgu (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Sun, 19 Mar 2023 09:36:50 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91F3A1ACC2;
        Sun, 19 Mar 2023 06:36:46 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 098B5B80B8C;
        Sun, 19 Mar 2023 13:36:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 61B58C433EF;
        Sun, 19 Mar 2023 13:36:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1679233003;
        bh=c29uAlib8R0W2OqrGL3EdVP/0alALH7EvntPLY4DR+c=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=OtC89uFX6NkoWvbISGP86yhT2SI7MnG7pnjbCqLhq3X0PTCFk/OhzuC6EzDYN/2QH
         vCh051qxtLpqb40Qx4gKul5Hp/gq4UH/6dHEfhrH3EcfuxfG4SHNZvb1hQzqzTy6Dr
         860GVVxf+UoFNHnpeqaCGF8fZbmHPeFXgEgfC4VQa2OSofEOrOC8xXO5KJ4sn1uVlt
         lqBZ7sBoHJvJ8FXMwfsNc5q3NAN1wbz2NYUCaVOR0e63785IglnUP2blivi2P/qtEv
         AvMqH1gb2Ib9Zf7lJ6VjtP/ZumxcZPzadwcyBbpW/SXkR5tJU7hj1lp4v1LriIOTd3
         tYWM25UOFwN6A==
Date:   Sun, 19 Mar 2023 15:36:39 +0200
From:   Jarkko Sakkinen <jarkko@kernel.org>
To:     Mark Hasemeyer <markhas@chromium.org>
Cc:     Jason Gunthorpe <jgg@ziepe.ca>, Peter Huewe <peterhuewe@gmx.de>,
        linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] tpm: cr50: i2c: use jiffies to wait for tpm ready irq
Message-ID: <20230319133639.s3isrd35ul4ldiof@kernel.org>
References: <20230314135400.1.I5561dfbc4438418281626e43e345e8acc879cd7c@changeid>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230314135400.1.I5561dfbc4438418281626e43e345e8acc879cd7c@changeid>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Tue, Mar 14, 2023 at 01:54:04PM -0600, Mark Hasemeyer wrote:
> When waiting for a tpm ready completion, the cr50 i2c driver incorrectly
> assumes that the value of timeout_a is represented in milliseconds
> instead of jiffies.
> 
> Remove the msecs_to_jiffies conversion.
> 
> Signed-off-by: Mark Hasemeyer <markhas@chromium.org>
> ---
> 
>  drivers/char/tpm/tpm_tis_i2c_cr50.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/drivers/char/tpm/tpm_tis_i2c_cr50.c b/drivers/char/tpm/tpm_tis_i2c_cr50.c
> index 77cea5b31c6e4..376ae18a04ebb 100644
> --- a/drivers/char/tpm/tpm_tis_i2c_cr50.c
> +++ b/drivers/char/tpm/tpm_tis_i2c_cr50.c
> @@ -100,8 +100,7 @@ static int tpm_cr50_i2c_wait_tpm_ready(struct tpm_chip *chip)
>  	}
>  
>  	/* Wait for interrupt to indicate TPM is ready to respond */
> -	if (!wait_for_completion_timeout(&priv->tpm_ready,
> -					 msecs_to_jiffies(chip->timeout_a))) {
> +	if (!wait_for_completion_timeout(&priv->tpm_ready, chip->timeout_a)) {
>  		dev_warn(&chip->dev, "Timeout waiting for TPM ready\n");
>  		return -ETIMEDOUT;
>  	}
> -- 
> 2.40.0.rc2.332.ga46443480c-goog
> 

Reviewed-by: Jarkko Sakkinen <jarkko@kernel.org>

BR, Jarkko
