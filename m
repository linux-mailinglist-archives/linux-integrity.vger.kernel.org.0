Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A8D7630D0B2
	for <lists+linux-integrity@lfdr.de>; Wed,  3 Feb 2021 02:18:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229729AbhBCBR6 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 2 Feb 2021 20:17:58 -0500
Received: from mail.kernel.org ([198.145.29.99]:34910 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230008AbhBCBR4 (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 2 Feb 2021 20:17:56 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id BF13064F5F;
        Wed,  3 Feb 2021 01:17:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1612315035;
        bh=DwjVi2v1R+5KPHVa+UHI0lrjo4xD5VXOu2eK9fjoIBo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=WvIzn8s/29E5WxZdsJ9R3F21GQYpmyVbH/olsZLUGvUarxONXF3lurRA3yDkDzv/k
         50fEg7kVxO6mbq6pfVHAAKmd4c6eSX3Xb57/MlGEiAjrYkJUlBYtYCaUQGdCBQQ9re
         ReBnGp4xqBTKw/3HUIxZXft7oCxVT3D/uu9fyUUNE9cfp8m7D8PHBscEmX7g9AmqLZ
         RURxcN+V/zzSUpiukA23sciOJ6N6eLPqbpr0U8G8dkP8zKykn26lDX8vVR1eUGC0Mh
         MSv9vCwHOlCu4JXcoE4K2LihrV+GG6tlzjtpShVipa+UAFXS/Jdx6ce/bEGkrqjLc0
         xuHqF2trzdcZw==
Date:   Wed, 3 Feb 2021 03:17:07 +0200
From:   Jarkko Sakkinen <jarkko@kernel.org>
To:     Lino Sanfilippo <LinoSanfilippo@gmx.de>
Cc:     peterhuewe@gmx.de, jgg@ziepe.ca, stefanb@linux.vnet.ibm.com,
        linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org,
        Lino Sanfilippo <l.sanfilippo@kunbus.com>
Subject: Re: [PATCH v2 3/3] tpm: in tpm2_del_space check if ops pointer is
 still valid
Message-ID: <YBn5kwEIoggc71xY@kernel.org>
References: <1612303743-29017-1-git-send-email-LinoSanfilippo@gmx.de>
 <1612303743-29017-4-git-send-email-LinoSanfilippo@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1612303743-29017-4-git-send-email-LinoSanfilippo@gmx.de>
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Tue, Feb 02, 2021 at 11:09:03PM +0100, Lino Sanfilippo wrote:
> From: Lino Sanfilippo <l.sanfilippo@kunbus.com>
> 
> In tpm2_del_space() the sessions are flushed by means of the tpm_chip
> operations. However the concerning operations pointer my already be NULL at
                                                        ~~
                                                        may

What is "concerniog operations"? Unfamiliar term. Maybe just consistently
se chip->ops? Now you have also "tpm_chip operations" and chip->ops, in
addition to "concerning operations" in one paragraph commit message.

> this time in case that the chip has been unregistered (see
> tpm_chip_unregister() which calls tpm_del_char_device() which sets
> chip->ops to NULL).
> Before accessing chip->ops check if it is still valid. Skip flushing
> the sessions in this case.
> 
> Signed-off-by: Lino Sanfilippo <l.sanfilippo@kunbus.com>

Instead of cross referencing please describe the scenario (i.e.
the sequence of operations) of failure.

Fixes tag is also missing.

> ---
>  drivers/char/tpm/tpm2-space.c | 15 ++++++++++-----
>  1 file changed, 10 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/char/tpm/tpm2-space.c b/drivers/char/tpm/tpm2-space.c
> index 784b8b3..9a29a40 100644
> --- a/drivers/char/tpm/tpm2-space.c
> +++ b/drivers/char/tpm/tpm2-space.c
> @@ -58,12 +58,17 @@ int tpm2_init_space(struct tpm_space *space, unsigned int buf_size)
>  
>  void tpm2_del_space(struct tpm_chip *chip, struct tpm_space *space)
>  {
> -	mutex_lock(&chip->tpm_mutex);
> -	if (!tpm_chip_start(chip)) {
> -		tpm2_flush_sessions(chip, space);
> -		tpm_chip_stop(chip);
> +	down_read(&chip->ops_sem);
> +	if (chip->ops) {
> +		mutex_lock(&chip->tpm_mutex);
> +		if (!tpm_chip_start(chip)) {
> +			tpm2_flush_sessions(chip, space);
> +			tpm_chip_stop(chip);
> +		}
> +		mutex_unlock(&chip->tpm_mutex);
>  	}
> -	mutex_unlock(&chip->tpm_mutex);
> +	up_read(&chip->ops_sem);
> +
>  	kfree(space->context_buf);
>  	kfree(space->session_buf);
>  }
> -- 
> 2.7.4
> 

/Jarkko
