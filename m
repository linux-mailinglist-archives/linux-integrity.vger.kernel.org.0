Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A516B2F946A
	for <lists+linux-integrity@lfdr.de>; Sun, 17 Jan 2021 19:14:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729078AbhAQSOO (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Sun, 17 Jan 2021 13:14:14 -0500
Received: from mail.kernel.org ([198.145.29.99]:37030 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728858AbhAQSOM (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Sun, 17 Jan 2021 13:14:12 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 694BB224D3;
        Sun, 17 Jan 2021 18:13:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1610907212;
        bh=BZ2fA3WLWPi7CwYp1cpAsf6pUYTEtDrTQTl4od6A+RU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=bM4L7k6dLUI2zFJo9UVYWCM+/NLRoUXoGXwoHv2uYcvMRJw8TnTehOPaUNNOzN7hi
         57YmtkSs8e7PJUxgVjyk3yA/5MoRZ2kY/9iihDwMuE8tvw8MpQaJqxq7SLPz+nQcK2
         aSZSSU2CJ5840g9NDpGSMbW1sNyne00boqfs1HXAUp47f//mfjO4QL+tuYDDdGPCJd
         v6eeONWTByzNbQJkOGNZFLwF3Dodpqn/La4zTadbaLaOJYCZ0XKxEyx/FlLOwe/yzO
         9kn5tj9O9KJArwxzwNdNkNcZJ9Z9LtBPSW8OidW7Bvuuuv1TzdlMZwgOBvKRsreETe
         h9PHc84pUIJlg==
Date:   Sun, 17 Jan 2021 20:13:27 +0200
From:   Jarkko Sakkinen <jarkko@kernel.org>
To:     Lino Sanfilippo <LinoSanfilippo@gmx.de>
Cc:     peterhuewe@gmx.de, jgg@ziepe.ca, stefanb@linux.vnet.ibm.com,
        linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org,
        p.rosenberger@kunbus.com, Lino Sanfilippo <l.sanfilippo@kunbus.com>
Subject: Re: [PATCH 3/4] tpm: in tpm2_del_space check if ops pointer is still
 valid
Message-ID: <YAR+R0c8HYsVUhZQ@kernel.org>
References: <1610760161-21982-1-git-send-email-LinoSanfilippo@gmx.de>
 <1610760161-21982-4-git-send-email-LinoSanfilippo@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1610760161-21982-4-git-send-email-LinoSanfilippo@gmx.de>
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Sat, Jan 16, 2021 at 02:22:40AM +0100, Lino Sanfilippo wrote:
> From: Lino Sanfilippo <l.sanfilippo@kunbus.com>
> 
> In tpm2_del_space() the sessions are flushed by means of the tpm_chip
> operations. However the concerning operations pointer my already be NULL at
> this time in case that the chip has been unregistered (see
> tpm_chip_unregister() which calls tpm_del_char_device() which sets
> chip->ops to NULL).
> Avoid the NULL pointer access by first calling tpm_try_get_ops() to check
> if the operations pointer is still valid and skipping the session flushing
> in case of an unregistered chip.
> 
> Signed-off-by: Lino Sanfilippo <l.sanfilippo@kunbus.com>
> ---
>  drivers/char/tpm/tpm2-space.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/char/tpm/tpm2-space.c b/drivers/char/tpm/tpm2-space.c
> index 784b8b3..ea6eee9 100644
> --- a/drivers/char/tpm/tpm2-space.c
> +++ b/drivers/char/tpm/tpm2-space.c
> @@ -59,7 +59,7 @@ int tpm2_init_space(struct tpm_space *space, unsigned int buf_size)
>  void tpm2_del_space(struct tpm_chip *chip, struct tpm_space *space)
>  {
>  	mutex_lock(&chip->tpm_mutex);
> -	if (!tpm_chip_start(chip)) {
> +	if (!tpm_try_get_ops(chip) && !tpm_chip_start(chip)) {
>  		tpm2_flush_sessions(chip, space);
>  		tpm_chip_stop(chip);
>  	}
> -- 
> 2.7.4
> 

I have hard time to believe that any of these patches are based on
actual regressions.

/Jarko
