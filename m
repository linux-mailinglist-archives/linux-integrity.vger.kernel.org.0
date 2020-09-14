Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EF99F2684A6
	for <lists+linux-integrity@lfdr.de>; Mon, 14 Sep 2020 08:17:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726030AbgINGR3 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 14 Sep 2020 02:17:29 -0400
Received: from mail.kernel.org ([198.145.29.99]:43380 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726003AbgINGR2 (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 14 Sep 2020 02:17:28 -0400
Received: from localhost (83-86-74-64.cable.dynamic.v4.ziggo.nl [83.86.74.64])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0D11120756;
        Mon, 14 Sep 2020 06:17:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1600064247;
        bh=tUsSOAw7fVSE3dUyYtKXvkKM+cEyKwq1wWnP9lGX8Io=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=GUyJrPy89zvBkDEAhmfdJrhHPRWlw4Gs13O/jl0f9gqdBp5e7aesDdBlwOWnuB15T
         RG4I3ZTYMHpKOxA+wFoLjzM2MNj64SafWcr8bsh8GsTb4YaJA+3/ZfN5k73IBiSY2w
         rNhZJJScSJ8qA5+o5w31sxIpQZTDij55c7475RLA=
Date:   Mon, 14 Sep 2020 08:17:22 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Hao Wu <hao.wu@rubrik.com>
Cc:     peterhuewe@gmx.de, jarkko.sakkinen@linux.intel.com, jgg@ziepe.ca,
        arnd@arndb.de, hamza@hpe.com, james.l.morris@oracle.com,
        linux-integrity@vger.kernel.org, pmenzel@molgen.mpg.de,
        kgold@linux.ibm.com, seungyeop.han@rubrik.com,
        shrihari.kalkar@rubrik.com, anish.jhaveri@rubrik.com
Subject: Re: [PATCH] Fix Atmel TPM crash caused by too frequent queries
Message-ID: <20200914061722.GA789004@kroah.com>
References: <20200914061343.79018-1-hao.wu@rubrik.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200914061343.79018-1-hao.wu@rubrik.com>
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Sun, Sep 13, 2020 at 11:13:43PM -0700, Hao Wu wrote:
> Since kernel 4.14, we fixed the TPM sleep logic
> from msleep to usleep_range, so that the TPM
> sleeps exactly with TPM_TIMEOUT (=5ms) afterward.
> Before that fix, msleep(5) actually sleeps for
> around 15ms.
> The fix is https://github.com/torvalds/linux/commit/9f3fc7bcddcb51234e23494531f93ab60475e1c3
> 
> That fix uncovered that the TPM_TIMEOUT was not properly
> set previously. We recently found the TPM driver in kernel 4.14+
> (including 5.9-rc4) crashes Atmel TPM chips with
> too frequent TPM queries.
> 
> The TPM crash signature is
> ```
> $ tpm_sealdata -z
> Tspi_Key_LoadKey failed: 0x00001087 - layer=tddl, code=0087 (135), I/O error
> 
> $ sudo dmesg | grep tpm0
> [59154.665549] tpm tpm0: tpm_try_transmit: send(): error -62
> [59154.809532] tpm tpm0: tpm_try_transmit: send(): error -62
> ```
> 
> >From the error code "-62", it looks similar to another bug
> https://patchwork.kernel.org/patch/10520247/
> where the "TPM_TIMEOUT_USECS_MAX" and "TPM_TIMEOUT_USEC_MIN"
> is too small, which causes TPM get queried too frequently,
> and thus crashes.
> 
> This patch fix the TPM_TIMEOUT to 15ms which was
> the actual timeout TPM chips use before the fix
> from msleep to usleep_range. Thus fixed the crash.
> 
> Test Plan:
> - Run fixed kernel on system with Atmel TPM chips
>   and ensure crash does not happen
> - Run fixed kernel on system with other TPM chips
>   (IFX / WEC / STM) ensure not breakages from tpm-tool
> ---
>  drivers/char/tpm/tpm.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/char/tpm/tpm.h b/drivers/char/tpm/tpm.h
> index 947d1db0a5cc..73259ac0a997 100644
> --- a/drivers/char/tpm/tpm.h
> +++ b/drivers/char/tpm/tpm.h
> @@ -37,7 +37,7 @@
>  #define TPM_RETRY		50
>  
>  enum tpm_timeout {
> -	TPM_TIMEOUT = 5,	/* msecs */
> +	TPM_TIMEOUT = 15,	/* msecs */
>  	TPM_TIMEOUT_RETRY = 100, /* msecs */
>  	TPM_TIMEOUT_RANGE_US = 300,	/* usecs */
>  	TPM_TIMEOUT_POLL = 1,	/* msecs */
> -- 
> 2.17.1
> 

Hi,

This is the friendly patch-bot of Greg Kroah-Hartman.  You have sent him
a patch that has triggered this response.  He used to manually respond
to these common problems, but in order to save his sanity (he kept
writing the same thing over and over, yet to different people), I was
created.  Hopefully you will not take offence and will fix the problem
in your patch and resubmit it so that it can be accepted into the Linux
kernel tree.

You are receiving this message because of the following common error(s)
as indicated below:

- Your patch does not have a Signed-off-by: line.  Please read the
  kernel file, Documentation/SubmittingPatches and resend it after
  adding that line.  Note, the line needs to be in the body of the
  email, before the patch, not at the bottom of the patch or in the
  email signature.

If you wish to discuss this problem further, or you have questions about
how to resolve this issue, please feel free to respond to this email and
Greg will reply once he has dug out from the pending patches received
from other developers.

thanks,

greg k-h's patch email bot
