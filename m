Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 510802657F3
	for <lists+linux-integrity@lfdr.de>; Fri, 11 Sep 2020 06:18:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725788AbgIKESI (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 11 Sep 2020 00:18:08 -0400
Received: from mail.kernel.org ([198.145.29.99]:60136 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725769AbgIKESF (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 11 Sep 2020 00:18:05 -0400
Received: from localhost (83-86-74-64.cable.dynamic.v4.ziggo.nl [83.86.74.64])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A9445221E5;
        Fri, 11 Sep 2020 04:18:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1599797884;
        bh=aFYJOa172nCv0JSV5pG4p0MOZLKhVQYAop9PO0Hayhw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=N3OsGXJWiZnK94vsrF5JOotWW0vuGKsalGVK/brvYWHCD4ySjnlaDYyr9wI0ERgz9
         MR7wI3zqM++7N2BuzKRiehxZ2oXmjMvogkSxGc2K1Vz+5bPejmlgzW1BpO1B4ffJgl
         eFxcmgfLw4n4eNd6CaahO0wKUfNbaPV6U5ZVHsDs=
Date:   Fri, 11 Sep 2020 06:18:00 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Hao Wu <hao.wu@rubrik.com>
Cc:     peterhuewe@gmx.de, jarkko.sakkinen@linux.intel.com, jgg@ziepe.ca,
        arnd@arndb.de, linux-integrity@vger.kernel.org,
        Seungyeop Han <seungyeop.han@rubrik.com>,
        Shrihari Kalkar <shrihari.kalkar@rubrik.com>,
        Anish Jhaveri <anish.jhaveri@rubrik.com>
Subject: Re: [Bug Report] Kernel 4.14+ TPM Driver Bug for Atmel TPM Chip
Message-ID: <20200911041800.GA541925@kroah.com>
References: <9173F912-F682-44CC-8408-565A6C675749@rubrik.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <9173F912-F682-44CC-8408-565A6C675749@rubrik.com>
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Thu, Sep 10, 2020 at 03:13:22PM -0700, Hao Wu wrote:
> Hi TPM Driver Maintainers,
> 
> We are from Rubrik engineering team. We found a TPM driver update since kernel 4.14 causing atmel TPM chips crash. We have root caused it and have a patch on the kernel used by Rubrik products. Given the “bug” has impact on not just Rubrik products, but all atmel TPM chips, we are asking to fix the issue in the kernel upstream.
> 
> The commit that introduced the bug since 4.14 
> https://github.com/torvalds/linux/commit/9f3fc7bcddcb51234e23494531f93ab60475e1c3 <https://github.com/torvalds/linux/commit/9f3fc7bcddcb51234e23494531f93ab60475e1c3>
> 
> Effected platform / system:
> - Cisco UCS C220 M5 with atmel TPM chip
> 	- Ubuntu 16.04
>   	- Kernel 4.14 / 4.15 / 4.18 / 4.20 / 5.8 / 5.9-rc4
> - Cisco UCS C240 M5 with atmel TPM chip
> 	- Ubuntu 16.04
>   	- Kernel 4.14 / 4.15 / 4.18 / 4.20 / 5.8 / 5.9-rc4
> 
> ```
> # TPM chip used in the problematic platform
> $ tpm_version
> TPM 1.2 Version Info:
>   Chip Version:        1.2.66.1
>   Spec Level:          2
>   Errata Revision:     3
>   TPM Vendor ID:       ATML
>   TPM Version:         01010000
>   Manufacturer Info:   41544d4c
> ```
> 
> Not all Cisco server nodes are facing the crash, but there are a good amount of portion (around 50% from nodes in Rubrik) are persistently having the TPM crash issue.
> 
> Our other platforms using TPM chips from other vendors do not have issue. These platform are running the same software as the problematic platforms run. Those TPM non-effected vendors are
> - IFX
> - STM
> - WEC
> 
> TPM crash signature:
> ```
> # error when running tpm tool
> $ tpm_sealdata -z
> Tspi_Key_LoadKey failed: 0x00001087 - layer=tddl, code=0087 (135), I/O error
> 
> # tpm driver sends error
> $ sudo dmesg | grep tpm0
> [59154.665549] tpm tpm0: tpm_try_transmit: send(): error -62
> [59154.809532] tpm tpm0: tpm_try_transmit: send(): error -62
> ```
> 
> Our Root Cause Analysis
> From the error code “-62”, it looks similar to another bug https://patchwork.kernel.org/patch/10520247/ <https://patchwork.kernel.org/patch/10520247/>
> where the “TPM_TIMEOUT_USECS_MAX” and “TPM_TIMEOUT_USEC_MIN” is too small, which causes TPM get queried too frequently, and thus crashes.
> 
> The issue for atmel TPM chip crash is similar the commit https://github.com/torvalds/linux/commit/9f3fc7bcddcb51234e23494531f93ab60475e1c3 <https://github.com/torvalds/linux/commit/9f3fc7bcddcb51234e23494531f93ab60475e1c3> changed TPM sleep logic from using `msleep` to `tpm_msleep`, in which `usleep_range` is used.
> 
> As what https://github.com/torvalds/linux/commit/9f3fc7bcddcb51234e23494531f93ab60475e1c3 <https://github.com/torvalds/linux/commit/9f3fc7bcddcb51234e23494531f93ab60475e1c3> intended to do, using usleep_range can make the sleep period shorter, because msleep actually sleeps longer when the sleep perioid is within 20ms, and usleep_range can make it more precise.
> 
> According to our experiments,
> - usleep_range makes the TPM sleep precisely for TPM_TIMEOUT (i.e. 5ms https://github.com/torvalds/linux/blob/v4.14/drivers/char/tpm/tpm.h#L52 <https://github.com/torvalds/linux/blob/v4.14/drivers/char/tpm/tpm.h#L52>)
> - msleep(TPM_TIMEOUT) actually sleeps around 15ms    
> 
> Thus the TPM get queried more frequently than before, which is likely the root cause of the atmel chip crash. We fix it by bumping up the TPM_TIMEOUT to 15ms.
> 
> 
> Rubrik Patch
> ```
> diff --git a/drivers/char/tpm/tpm.h b/drivers/char/tpm/tpm.h
> index 72d3ce4..9b8f3f8 100644
> --- a/drivers/char/tpm/tpm.h
> +++ b/drivers/char/tpm/tpm.h
> @@ -49,7 +49,15 @@ enum tpm_const {
>  };
> 
>  enum tpm_timeout {
> -       TPM_TIMEOUT = 5,        /* msecs */
> +       TPM_TIMEOUT = 15,       /* msecs */
>         TPM_TIMEOUT_RETRY = 100, /* msecs */
>         TPM_TIMEOUT_RANGE_US = 300      /* usecs */
>  };
> ```
> With the patch, the atmel TPM chip crash is fixed.  
> 
> Proposal
> We want the kernel upstream to adopt the fix or have a better fix for the atmel chip while not bring performance regression for other TPM chips. We understand that https://github.com/torvalds/linux/commit/9f3fc7bcddcb51234e23494531f93ab60475e1c3 <https://github.com/torvalds/linux/commit/9f3fc7bcddcb51234e23494531f93ab60475e1c3> was intended to shorten the TPM respond time, but it does not work well for atmel TPM chips. Probably we should override TPM_TIMEOUT value for atmel chips at least.
> 
> Thanks
> Hao

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

- Your patch is malformed (tabs converted to spaces, linewrapped, etc.)
  and can not be applied.  Please read the file,
  Documentation/email-clients.txt in order to fix this.

- Your patch does not have a Signed-off-by: line.  Please read the
  kernel file, Documentation/SubmittingPatches and resend it after
  adding that line.  Note, the line needs to be in the body of the
  email, before the patch, not at the bottom of the patch or in the
  email signature.

- Your patch was sent privately to Greg.  Kernel development is done in
  public, please always cc: a public mailing list with a patch
  submission.  Using the tool, scripts/get_maintainer.pl on the patch
  will tell you what mailing list to cc.

If you wish to discuss this problem further, or you have questions about
how to resolve this issue, please feel free to respond to this email and
Greg will reply once he has dug out from the pending patches received
from other developers.

thanks,

greg k-h's patch email bot
