Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0A6F12CF0DD
	for <lists+linux-integrity@lfdr.de>; Fri,  4 Dec 2020 16:39:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729144AbgLDPi3 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 4 Dec 2020 10:38:29 -0500
Received: from mail.kernel.org ([198.145.29.99]:40178 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727153AbgLDPi3 (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 4 Dec 2020 10:38:29 -0500
Date:   Fri, 4 Dec 2020 17:37:43 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1607096268;
        bh=hIB09Y3GrjL/5l/QzpOvJADROc32g4QH+imO+G2d6ys=;
        h=From:To:Cc:Subject:References:In-Reply-To:From;
        b=L78R5U2UvhDm9u5+AQ6vgVTnodERvRaW8EWJ145KshY5luSl0LyrMdmDGEXGctKDS
         gbdn3u/CyqMAputGWpxJV2dGiYJA0qXd0TWeZAkNV8jvNc7ym559u4xXfBeYD4IrQL
         2OVMfglHy9zq9txgj/Do2xeVMrHrs5c4IH2LSdnKmY12d80YF9Pvkx8ElpZEOsCVEp
         p+VX2hjEF2SSADuwAuntO6VBCgwRfrbEDtDOSITUILDU4RverPQGvNV2ZqAGbXAPBv
         b6y0fiXXS1eWQGv41ZSuUHUHj/JaFf0Sq5dcTXAgr/27/9SQGqt8LaYOFLIWs+gQUG
         2qg/o6XgfVLdw==
From:   Jarkko Sakkinen <jarkko@kernel.org>
To:     Dafna Hirschfeld <dafna.hirschfeld@collabora.com>
Cc:     linux-integrity@vger.kernel.org, peterhuewe@gmx.de, jgg@ziepe.ca,
        enric.balletbo@collabora.com, kernel@collabora.com,
        dafna3@gmail.com, Andrey Pronin <apronin@chromium.org>
Subject: Re: [PATCH] tpm: ignore failed selftest in probe
Message-ID: <20201204153743.GA6337@kernel.org>
References: <20201204135649.19391-1-dafna.hirschfeld@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201204135649.19391-1-dafna.hirschfeld@collabora.com>
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Fri, Dec 04, 2020 at 02:56:49PM +0100, Dafna Hirschfeld wrote:
> From: Andrey Pronin <apronin@chromium.org>
> 
> If a tpm firmware update is interrupted, e.g due
> to loss of power or a reset while installing the
> update, you end with the tpm chip in failure mode.
> ConstinueSelfTest command results in TPM_FAILEDSELFTEST

I guess ContinueSelfTest? What command is that anywyay
in which context? TPM spec does not have that at least.

Please use the exact same phrasings as they are in the
TPM spec.

> error, and probe fails. The tpm device is not
> created, and that prevents the OS from attempting
> any further recover operations with the tpm. Instead,
> ignore the error code of the self test, and create the
> device - the chip is out there, it's just in the
> failed state.
> 
> Testing:
> Tested with swtpm as tpm simulator and a patch in libtpms
> to enter failure mode
> 
> With this settings, the 'dev/tpm0' is created but

'dev/tpm0' -> /dev/tpm0

> the tcsd daemon fails to run.
> In addition, the commands
> TPM_GetTestResult, TPM_GetCapability and TPM_GetRandom
> were tested.
> 
> A normal operation was tested with
> Chromeos Elm device.

Please format these paragraphs properly using 75 character
line length. And capitalize acronyms correctly, e.g. "TPM",
not "tpm".

Please explain what "Elm" is as I have zero idea of it.

> 
> Signed-off-by: Andrey Pronin <apronin@chromium.org>
> [change the code to still fail in case of fatal error]
> Signed-off-by: Dafna Hirschfeld <dafna.hirschfeld@collabora.com>
> 
> ---

Please put all below just before diffstat.

> This commit comes from chromeos:
> https://chromium.googlesource.com/chromiumos/third_party/kernel/+/1065c2fe54d6%5E%21/
> 
> In Chromeos, the selftest fails if the tpm firmware is updated
> during EC reset. In that case the userspace wants to access
> the tpm for recovery.
> 
> This patch is for tpm 1.2 only, I can also send a patch for tpm 2
> if it is required that the behaviour stays consistent among the versions.
> 
> libtpms patch:
> https://gitlab.collabora.com/dafna/libtpms/-/commit/42848f4a838636d01ddb5ed353b3990dad3f601d
> 
> tpm tests:
> https://gitlab.collabora.com/dafna/test-tpm1.git
> ---
>  drivers/char/tpm/tpm1-cmd.c | 17 ++++++++---------
>  1 file changed, 8 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/char/tpm/tpm1-cmd.c b/drivers/char/tpm/tpm1-cmd.c
> index ca7158fa6e6c..8b7997ef8d1c 100644
> --- a/drivers/char/tpm/tpm1-cmd.c
> +++ b/drivers/char/tpm/tpm1-cmd.c
> @@ -697,6 +697,8 @@ EXPORT_SYMBOL_GPL(tpm1_do_selftest);
>  /**
>   * tpm1_auto_startup - Perform the standard automatic TPM initialization
>   *                     sequence
> + * NOTE: if tpm1_do_selftest returns with a TPM error code, we return 0 (success)
> + *	 to allow userspace interaction with the TPM when it is on failure mode.
>   * @chip: TPM chip to use
>   *
>   * Returns 0 on success, < 0 in case of fatal error.
> @@ -707,18 +709,15 @@ int tpm1_auto_startup(struct tpm_chip *chip)
>  
>  	rc = tpm1_get_timeouts(chip);
>  	if (rc)
> -		goto out;
> +		return rc < 0 ? rc : -ENODEV;
> +
>  	rc = tpm1_do_selftest(chip);
>  	if (rc) {
> -		dev_err(&chip->dev, "TPM self test failed\n");
> -		goto out;
> +		dev_err(&chip->dev, "TPM self test failed %d\n", rc);
> +		if (rc < 0)
> +			return rc;
>  	}
> -
> -	return rc;
> -out:
> -	if (rc > 0)
> -		rc = -ENODEV;
> -	return rc;
> +	return 0;
>  }
>  
>  #define TPM_ORD_SAVESTATE 152
> -- 
> 2.17.1
> 
> 

Let's look at the code change once the commit message looks sane...

/Jarkko
