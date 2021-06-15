Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2CAA93A7F0E
	for <lists+linux-integrity@lfdr.de>; Tue, 15 Jun 2021 15:18:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230368AbhFONUz (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 15 Jun 2021 09:20:55 -0400
Received: from mail.kernel.org ([198.145.29.99]:37330 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229977AbhFONUz (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 15 Jun 2021 09:20:55 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 696A06145C;
        Tue, 15 Jun 2021 13:18:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1623763130;
        bh=cyUcW2oXT2KCRlpSFEeoLemdK9iMlf71Q0+DZT5CQpg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=HnaARLy7SadXp251JZ5yL6IPorkdn/Ai04tEBaZz/+zmoDCuOkBFq/ghSsrK1cS6r
         URyzW3SP//eI50b6wBDKb3mR3mJX6vJehQ0kjF33YwPiucW7gd5DcrVlLWsqS1o3f0
         OHZ0OeLlu0BaJBMUbTlMYJJxv/+alLMMdjY6oJDu33UIlNzFzzHh0J7TjBp+6DzHPU
         tNM5GDzUmwjHCGkztO2qSp81WGbNSCtYlK7YiMJWPHs3FbvpoqmoV1hhTU0UHTEa+H
         9XwfLbMxseMsZaBtAlimeFgFobPd60uK9kpgpT/O5DUNTPHMBkk3ZhcEbjYHVkEdRR
         z/6YdTu9jqbfg==
Date:   Tue, 15 Jun 2021 16:18:48 +0300
From:   Jarkko Sakkinen <jarkko@kernel.org>
To:     Vincent Whitchurch <vincent.whitchurch@axis.com>
Cc:     Peter Huewe <peterhuewe@gmx.de>, Jason Gunthorpe <jgg@ziepe.ca>,
        kernel@axis.com, linux-integrity@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] tpm: Fix crash on tmprm release
Message-ID: <20210615131848.cynblt5qindtvtiz@kernel.org>
References: <20210615091410.17007-1-vincent.whitchurch@axis.com>
 <20210615091410.17007-2-vincent.whitchurch@axis.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210615091410.17007-2-vincent.whitchurch@axis.com>
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Tue, Jun 15, 2021 at 11:14:09AM +0200, Vincent Whitchurch wrote:
> If the tpm_tis module is removed (or a system shutdown is triggered)
> while the tpmrm device is use, the kernel crashes due to chip->ops being
> NULL:
> 
>  # exec 3<>/dev/tpmrm0
>  # rmmod tpm_tis
>  # exit
>  ==================================================================
>  BUG: KASAN: null-ptr-deref in tpm_chip_start+0x2d/0x120 [tpm]
>  Read of size 8 at addr 0000000000000060 by task sh/994
> 
>  Call Trace:
>   kasan_report.cold.13+0x10f/0x111
>   tpm_chip_start+0x2d/0x120 [tpm]
>   tpm2_del_space+0x2c/0xa0 [tpm]
>   tpmrm_release+0x3f/0x50 [tpm]
>   __fput+0x110/0x3c0
>   task_work_run+0x94/0xd0
>   do_exit+0x683/0x13e0
>   do_group_exit+0x8b/0x140
>   do_syscall_64+0x3c/0x80
>  ==================================================================
> 
> Fix this by making tpm2_del_space() use tpm_try_get_ops().  The latter
> already includes the calls to tpm_chip_start() and tpm_chip_stop().

This lacks explanation why migrating to tpm_try_get_ops() fixes the
issue. Saying that doing something fixes something is not good enough
explanation. So, can you extend this paragraph just a bit in the next
version?

> 
> Signed-off-by: Vincent Whitchurch <vincent.whitchurch@axis.com>
> ---
>  drivers/char/tpm/tpm2-space.c | 6 ++----
>  1 file changed, 2 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/char/tpm/tpm2-space.c b/drivers/char/tpm/tpm2-space.c
> index 784b8b3cb903..e1111261021f 100644
> --- a/drivers/char/tpm/tpm2-space.c
> +++ b/drivers/char/tpm/tpm2-space.c
> @@ -58,12 +58,10 @@ int tpm2_init_space(struct tpm_space *space, unsigned int buf_size)
>  
>  void tpm2_del_space(struct tpm_chip *chip, struct tpm_space *space)
>  {
> -	mutex_lock(&chip->tpm_mutex);
> -	if (!tpm_chip_start(chip)) {
> +	if (!tpm_try_get_ops(chip)) {
>  		tpm2_flush_sessions(chip, space);
> -		tpm_chip_stop(chip);
> +		tpm_put_ops(chip);
>  	}
> -	mutex_unlock(&chip->tpm_mutex);
>  	kfree(space->context_buf);
>  	kfree(space->session_buf);
>  }
> -- 
> 2.28.0
> 
> 

/Jarkko
