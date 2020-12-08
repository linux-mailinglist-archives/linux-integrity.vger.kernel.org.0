Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4B76C2D3133
	for <lists+linux-integrity@lfdr.de>; Tue,  8 Dec 2020 18:36:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730203AbgLHRfh (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 8 Dec 2020 12:35:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726278AbgLHRfh (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 8 Dec 2020 12:35:37 -0500
Received: from mail.kapsi.fi (mail.kapsi.fi [IPv6:2001:67c:1be8::25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D53DC061749
        for <linux-integrity@vger.kernel.org>; Tue,  8 Dec 2020 09:34:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=kapsi.fi;
         s=20161220; h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:
        Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=O5FDiRTsliEq8+2pz2ae1HrRqZgOVeCYVz3ir+qNdkY=; b=jtoP9P15WtYQ+APcBXTxALbNXB
        BRX6YepL4TY0HljBWfiYMPi6l801wulRSmiVa0dhkdZLLBetAwdFwprtHrOL0YusNDbazM0yIKeAY
        4nG4M4wHHV77DaF+BT0osAsoZ81yC3L/A8pYUz9RGmV5Yoh0ZfRH/8BBfCQsSUhy636MyQBo5IZui
        kTs2iNLOkL8IHdgTL3O3Of69CtOFYB2QX/EP1yOWnVJ9tI+NuCibDm5/7z5k0HXbCMxFTt/l4pA4a
        u+kwfVg78jaVoZ0m7I3sOqFqLtvlbiB3YuZtd/R3mqCDeqfR1N3m4yJij4/PrgQOwHfvLPV3npIKu
        BE8dQTxA==;
Received: from 83-245-197-237.elisa-laajakaista.fi ([83.245.197.237] helo=kapsi.fi)
        by mail.kapsi.fi with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <jarkko.sakkinen@iki.fi>)
        id 1kmgt3-0007FJ-5C; Tue, 08 Dec 2020 19:34:53 +0200
Date:   Tue, 8 Dec 2020 19:34:51 +0200
From:   Jarkko Sakkinen <jarkko.sakkinen@iki.fi>
To:     Dafna Hirschfeld <dafna.hirschfeld@collabora.com>
Cc:     linux-integrity@vger.kernel.org, peterhuewe@gmx.de,
        jarkko@kernel.org, jgg@ziepe.ca, enric.balletbo@collabora.com,
        kernel@collabora.com, dafna3@gmail.com,
        Andrey Pronin <apronin@chromium.org>
Subject: Re: [PATCH v2] tpm: ignore failed selftest in probe
Message-ID: <20201208173451.GA57585@kapsi.fi>
References: <20201207135710.17321-1-dafna.hirschfeld@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201207135710.17321-1-dafna.hirschfeld@collabora.com>
X-SA-Exim-Connect-IP: 83.245.197.237
X-SA-Exim-Mail-From: jarkko.sakkinen@iki.fi
X-SA-Exim-Scanned: No (on mail.kapsi.fi); SAEximRunCond expanded to false
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Mon, Dec 07, 2020 at 02:57:10PM +0100, Dafna Hirschfeld wrote:
> From: Andrey Pronin <apronin@chromium.org>
> 
> If a TPM firmware update is interrupted, e.g due to loss of power or a
> reset while installing the update, you end with the TPM chip in failure
> mode. TPM_ContinueSelfTest command is called when the device is probed.
> It results in TPM_FAILEDSELFTEST error, and probe fails. The TPM device
> is not created, and that prevents the OS from attempting any further
> recover operations with the TPM. Instead, ignore the error code of the
> TPM_ContinueSelfTest command, and create the device - the chip is out
> there, it's just in failure mode.
> 
> Testing:
> Tested with the swtpm as TPM simulator and a patch in 'libtpms'
> to enter failure mode
> 
> With this settings, the '/dev/tpm0' is created but the tcsd daemon fails
> to run.  In addition, the commands TPM_GetTestResult, TPM_GetCapability
> and TPM_GetRandom were tested.
> 
> A normal operation was tested with an Acer Chromebook R13 device
> (also called Elm) running Debian.

Move testing part to the stuff before diffstat.

> Signed-off-by: Andrey Pronin <apronin@chromium.org>
> [change the code to still fail in case of fatal error]

What is this?

> Signed-off-by: Dafna Hirschfeld <dafna.hirschfeld@collabora.com>
> 
> ---
> changes since v1:
> - rewriting the commit message
> 
> This commit comes from chromeos:
> https://chromium.googlesource.com/chromiumos/third_party/kernel/+/1065c2fe54d6%5E%21/
> 
> In Chromeos, the selftest fails if the TPM firmware is updated during EC
> reset. In that case the userspace wants to access the TPM for recovery.
> 
> This patch is for TPM 1.2 only, I can also send a patch for TPM 2 if it
> is required that the behaviour stays consistent among the versions.
> 
> libtpms patch:
> https://gitlab.collabora.com/dafna/libtpms/-/commit/42848f4a838636d01ddb5ed353b3990dad3f601d
> 
> TPM tests:
> https://gitlab.collabora.com/dafna/test-tpm1.git
> 
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


Please do not use "we ...". Use imperative form.

Also that is wrong place for the description:

https://www.kernel.org/doc/Documentation/kernel-doc-nano-HOWTO.txt

>   *
>   * Returns 0 on success, < 0 in case of fatal error.
> @@ -707,18 +709,15 @@ int tpm1_auto_startup(struct tpm_chip *chip)
>  
>  	rc = tpm1_get_timeouts(chip);
>  	if (rc)
> -		goto out;
> +		return rc < 0 ? rc : -ENODEV;

Do not use ternary operators. Also we are interested on
TPM_SELFTESTFAILED only (according to the commit message).

I.e. afaik should be

	if (rc) {
		if (rc == TPM_SELFTESTFAILED)
			return -ENODEV;
		else
			return rc;
	}


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

You don't need to remove the goto-statement. You could just
replace the existing condition with what I described above.
This is patch is doing changes that are not mandatory for
the change.

>  }
>  
>  #define TPM_ORD_SAVESTATE 152
> -- 
> 2.17.1

/Jarkko
