Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 349B03C28B6
	for <lists+linux-integrity@lfdr.de>; Fri,  9 Jul 2021 19:47:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229491AbhGIRty (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 9 Jul 2021 13:49:54 -0400
Received: from mail.kernel.org ([198.145.29.99]:43392 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229832AbhGIRty (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 9 Jul 2021 13:49:54 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id E37D56139A;
        Fri,  9 Jul 2021 17:47:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1625852830;
        bh=Cu7uGkjSDf0GRtCrMC9tjnhok58w2PHZcd93MdQ+PBo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Ylb1kkr4wD/vrAPg+u+TKNdZBJPzeTAy4BOfyc+VuoQta6WWaIw/fFmQ74FRbhr8L
         bgfh/dWcK3X4S2JeBb7DghldMeW76bLJxjdpoUX5wG59BO9GfYW8NizqN830otK3D5
         z8qlbWDlWTkArUrBHKpfV6VQUtJg8VtcASaJKpJY5mG+nnDefGJeSpLDKk8UIsTMwg
         k8uraLorKjZFPcJOWi7dgLts1ldCL4QmTJpIHKrQeXivaZg7Inqvg2tvWR4YiNn8Io
         fng73sH3DbhDTbB5E2Cqj3BsR8mzoHh4LOOx075xISjLsiOEcT56M+oxXJgmaQHEB+
         XLHYNhsbekRfQ==
Date:   Fri, 9 Jul 2021 20:47:07 +0300
From:   Jarkko Sakkinen <jarkko@kernel.org>
To:     Hao Wu <hao.wu@rubrik.com>
Cc:     shrihari.kalkar@rubrik.com, seungyeop.han@rubrik.com,
        anish.jhaveri@rubrik.com, peterhuewe@gmx.de, jgg@ziepe.ca,
        linux-integrity@vger.kernel.org, pmenzel@molgen.mpg.de,
        kgold@linux.ibm.com, zohar@linux.vnet.ibm.com,
        why2jjj.linux@gmail.com, hamza@hpe.com, gregkh@linuxfoundation.org,
        arnd@arndb.de, nayna@linux.vnet.ibm.com,
        James.Bottomley@hansenpartnership.com
Subject: Re: [PATCH v2] tpm: fix Atmel TPM crash caused by too frequent
 queries
Message-ID: <20210709174707.z2ap7czu2lldeavw@kernel.org>
References: <20210630042205.30051-1-hao.wu@rubrik.com>
 <20210709044028.77278-1-hao.wu@rubrik.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210709044028.77278-1-hao.wu@rubrik.com>
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Thu, Jul 08, 2021 at 09:40:28PM -0700, Hao Wu wrote:
> The Atmel TPM 1.2 chips crash with error
> `tpm_try_transmit: send(): error -62` since kernel 4.14.
> It is observed from the kernel log after running `tpm_sealdata -z`.
> The error thrown from the command is as follows
> ```
> $ tpm_sealdata -z
> Tspi_Key_LoadKey failed: 0x00001087 - layer=tddl,
> code=0087 (135), I/O error
> ```
> 
> The issue was reproduced with the following Atmel TPM chip:
> ```
> $ tpm_version
> T0  TPM 1.2 Version Info:
>   Chip Version:        1.2.66.1
>   Spec Level:          2
>   Errata Revision:     3
>   TPM Vendor ID:       ATML
>   TPM Version:         01010000
>   Manufacturer Info:   41544d4c
> ```
> 
> The root cause of the issue is due to the TPM calls to msleep()
> were replaced with usleep_range() [1], which reduces
> the actual timeout. Via experiments, it is observed that
> the original msleep(5) actually sleeps for 15ms.
> Because of a known timeout issue in Atmel TPM 1.2 chip,
> the shorter timeout than 15ms can cause the error described above.
> 
> A few further changes in kernel 4.16 [2] and 4.18 [3, 4] further
> reduced the timeout to less than 1ms. With experiments,
> the problematic timeout in the latest kernel is the one
> for `wait_for_tpm_stat`.
> 
> To fix it, the patch reverts the timeout of `wait_for_tpm_stat`
> to 15ms for all Atmel TPM 1.2 chips, but leave it untouched
> for Ateml TPM 2.0 chip, and chips from other vendors.
> As explained above, the chosen 15ms timeout is
> the actual timeout before this issue introduced,
> thus the old value is used here.
> Particularly, TPM_ATML_TIMEOUT_WAIT_STAT_MIN is set to 14700us,
> TPM_ATML_TIMEOUT_WAIT_STAT_MIN is set to 15000us according to
> the existing TPM_TIMEOUT_RANGE_US (300us).
> The fixed has been tested in the system with the affected Atmel chip
> with no issues observed after boot up.
> 
> References:
> [1] 9f3fc7bcddcb tpm: replace msleep() with usleep_range() in TPM
> 1.2/2.0 generic drivers
> [2] cf151a9a44d5 tpm: reduce tpm polling delay in tpm_tis_core
> [3] 59f5a6b07f64 tpm: reduce poll sleep time in tpm_transmit()
> [4] 424eaf910c32 tpm: reduce polling time to usecs for even finer
> granularity
> 
> Fixes: 9f3fc7bcddcb ("tpm: replace msleep() with usleep_range() in TPM 1.2/2.0 generic drivers")
> Link: https://patchwork.kernel.org/project/linux-integrity/patch/20200926223150.109645-1-hao.wu@rubrik.com/
> Signed-off-by: Hao Wu <hao.wu@rubrik.com>
> ---
> This version (v2) has following changes on top of the last (v1):
> - follow the existing way to define two timeouts (min and max)
>   for ATMEL chip, thus keep the exact timeout logic for 
>   non-ATEML chips.
> - limit the timeout increase to only ATMEL TPM 1.2 chips,
>   because it is not an issue for TPM 2.0 chips yet.
> 
> Test Plan:
> - Run fixed kernel with ATMEL TPM chips and see crash has been fixed.
> - Run fixed kernel with non-ATMEL TPM chips, and confirm
>   the timeout has not been changed.
> 
>  drivers/char/tpm/tpm.h          |  6 ++++--
>  drivers/char/tpm/tpm_tis_core.c | 23 +++++++++++++++++++++--
>  include/linux/tpm.h             |  3 +++
>  3 files changed, 28 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/char/tpm/tpm.h b/drivers/char/tpm/tpm.h
> index 283f78211c3a..6de1b44c4aab 100644
> --- a/drivers/char/tpm/tpm.h
> +++ b/drivers/char/tpm/tpm.h
> @@ -41,8 +41,10 @@ enum tpm_timeout {
>  	TPM_TIMEOUT_RETRY = 100, /* msecs */
>  	TPM_TIMEOUT_RANGE_US = 300,	/* usecs */
>  	TPM_TIMEOUT_POLL = 1,	/* msecs */
> -	TPM_TIMEOUT_USECS_MIN = 100,      /* usecs */
> -	TPM_TIMEOUT_USECS_MAX = 500      /* usecs */
> +	TPM_TIMEOUT_USECS_MIN = 100,	/* usecs */
> +	TPM_TIMEOUT_USECS_MAX = 500,	/* usecs */
> +	TPM_ATML_TIMEOUT_WAIT_STAT_MIN = 14700,	/* usecs */
> +	TPM_ATML_TIMEOUT_WAIT_STAT_MAX = 15000	/* usecs */
>  };
>  
>  /* TPM addresses */
> diff --git a/drivers/char/tpm/tpm_tis_core.c b/drivers/char/tpm/tpm_tis_core.c
> index 55b9d3965ae1..ae27d66fdd94 100644
> --- a/drivers/char/tpm/tpm_tis_core.c
> +++ b/drivers/char/tpm/tpm_tis_core.c
> @@ -80,8 +80,17 @@ static int wait_for_tpm_stat(struct tpm_chip *chip, u8 mask,
>  		}
>  	} else {
>  		do {
> -			usleep_range(TPM_TIMEOUT_USECS_MIN,
> -				     TPM_TIMEOUT_USECS_MAX);
> +			/* this code path could be executed before
> +			 * timeouts initialized in chip instance.
> +			 */
> +			if (chip->timeout_wait_stat_min &&
> +			    chip->timeout_wait_stat_max)
> +				usleep_range(chip->timeout_wait_stat_min,
> +					     chip->timeout_wait_stat_max);
> +			else
> +				usleep_range(TPM_TIMEOUT_USECS_MIN,
> +					     TPM_TIMEOUT_USECS_MAX);

This starts to look otherwise fine but you don't need this condition.
Just initialize variables to TPM_TIMEOUT_USECS_{MIN, MAX} for non-Atmel.

/Jarkko
