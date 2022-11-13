Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5FD13627279
	for <lists+linux-integrity@lfdr.de>; Sun, 13 Nov 2022 21:31:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235400AbiKMUb2 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Sun, 13 Nov 2022 15:31:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230525AbiKMUb1 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Sun, 13 Nov 2022 15:31:27 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9055512608;
        Sun, 13 Nov 2022 12:31:26 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0C69A60BDB;
        Sun, 13 Nov 2022 20:31:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BFD59C433D6;
        Sun, 13 Nov 2022 20:31:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1668371485;
        bh=Z3hKGPb3JVjXMwmS/Knu2xoEPDWXo+XzHB0SUKGU1MI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=fq1tFo1Ks4huQqkpuAB7lbl7qnjDuhG7E+DJEFMViWMTlO/GSyicK/f0VBEUOU2+r
         Xv0qnW7VqdvRwjmuSAF6xfR42U/FOC+OOlzbfTSa7HSBkGuWiFOZpWF3YPGU/r0EMc
         9U1eH6aQB+pWcyGh6La4SIkI3gIon4HwQwTHFwGdr2cDHX1NI3bf3yTzMrFzpEmWhV
         yVYlBFB85gk3tF/diWjOWSC9EAFvAL6FHYv23FJ6liOS6xhrppkWr5Bz2OLtW8vg8W
         U9R2+Z69+u4yAfWihGILYo7IQXwV6Rit61wO7vJEbdNuhHK6P7YvNE4BQaehWZJ6q1
         NtVR3K7q066OQ==
Date:   Sun, 13 Nov 2022 12:31:23 -0800
From:   Eric Biggers <ebiggers@kernel.org>
To:     Evan Green <evgreen@chromium.org>
Cc:     linux-kernel@vger.kernel.org, corbet@lwn.net,
        linux-integrity@vger.kernel.org, gwendal@chromium.org,
        dianders@chromium.org, apronin@chromium.org,
        Pavel Machek <pavel@ucw.cz>, Ben Boeckel <me@benboeckel.net>,
        rjw@rjwysocki.net, jejb@linux.ibm.com,
        Kees Cook <keescook@chromium.org>, dlunev@google.com,
        zohar@linux.ibm.com, Matthew Garrett <mgarrett@aurora.tech>,
        jarkko@kernel.org, linux-pm@vger.kernel.org,
        Matthew Garrett <mjg59@google.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Peter Huewe <peterhuewe@gmx.de>, axelj <axelj@axis.com>
Subject: Re: [PATCH v5 01/11] tpm: Add support for in-kernel resetting of PCRs
Message-ID: <Y3FUGyYbpWM0uIdg@sol.localdomain>
References: <20221111231636.3748636-1-evgreen@chromium.org>
 <20221111151451.v5.1.I776854f47e3340cc2913ed4d8ecdd328048b73c3@changeid>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221111151451.v5.1.I776854f47e3340cc2913ed4d8ecdd328048b73c3@changeid>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Fri, Nov 11, 2022 at 03:16:26PM -0800, Evan Green wrote:
> diff --git a/drivers/char/tpm/tpm-interface.c b/drivers/char/tpm/tpm-interface.c
> index 1621ce8187052c..886277b2654e3b 100644
> --- a/drivers/char/tpm/tpm-interface.c
> +++ b/drivers/char/tpm/tpm-interface.c
> @@ -342,6 +342,53 @@ int tpm_pcr_extend(struct tpm_chip *chip, u32 pcr_idx,
>  }
>  EXPORT_SYMBOL_GPL(tpm_pcr_extend);
>  
> +/**
> + * tpm2_pcr_reset - Reset the specified PCR

Should this function be in drivers/char/tpm/tpm2-cmd.c instead of here?

> + * @chip: A &struct tpm_chip instance, %NULL for the default chip
> + * @pcr_idx: The PCR to be reset
> + *
> + * Return: Same as with tpm_transmit_cmd(), or ENOTTY for TPM1 devices.
> + */
> +int tpm2_pcr_reset(struct tpm_chip *chip, u32 pcr_idx)

The callers of this function assume it returns a negative errno value.  But
actually it can return positive TPM2_RC_* error codes as well.  Probably you
should make it only return negative errno values.

> +{
> +	struct tpm2_null_auth_area auth_area;
> +	struct tpm_buf buf;
> +	int rc;
> +
> +	chip = tpm_find_get_ops(chip);
> +	if (!chip)
> +		return -ENODEV;
> +
> +	if (!(chip->flags & TPM_CHIP_FLAG_TPM2)) {
> +		rc = -ENOTTY;
> +		goto out;
> +	}
> +
> +	rc = tpm_buf_init(&buf, TPM2_ST_SESSIONS, TPM2_CC_PCR_RESET);
> +	if (rc)
> +		goto out;
> +
> +	tpm_buf_append_u32(&buf, pcr_idx);
> +
> +	auth_area.handle = cpu_to_be32(TPM2_RS_PW);
> +	auth_area.nonce_size = 0;
> +	auth_area.attributes = 0;
> +	auth_area.auth_size = 0;
> +
> +	tpm_buf_append_u32(&buf, sizeof(struct tpm2_null_auth_area));

sizeof(struct tpm2_null_auth_area) => sizeof(auth_area)

> +	tpm_buf_append(&buf, (const unsigned char *)&auth_area,

unsigned char => u8

Also, since the code to append a "null" authorization area appears in both
tpm2_pcr_reset() and tpm2_pcr_extend(), perhaps it should be refactored into a
helper function?

> diff --git a/include/linux/tpm.h b/include/linux/tpm.h
> index dfeb25a0362dee..70134e6551745f 100644
> --- a/include/linux/tpm.h
> +++ b/include/linux/tpm.h
> @@ -219,6 +219,7 @@ enum tpm2_command_codes {
>  	TPM2_CC_HIERARCHY_CONTROL       = 0x0121,
>  	TPM2_CC_HIERARCHY_CHANGE_AUTH   = 0x0129,
>  	TPM2_CC_CREATE_PRIMARY          = 0x0131,
> +	TPM2_CC_PCR_RESET		= 0x013D,
>  	TPM2_CC_SEQUENCE_COMPLETE       = 0x013E,
>  	TPM2_CC_SELF_TEST	        = 0x0143,
>  	TPM2_CC_STARTUP		        = 0x0144,
> @@ -293,6 +294,13 @@ struct tpm_header {
>  	};
>  } __packed;
>  
> +struct tpm2_null_auth_area {
> +	__be32  handle;
> +	__be16  nonce_size;
> +	u8  attributes;
> +	__be16  auth_size;
> +} __packed;

struct tpm2_null_auth_area is only used by code in drivers/char/tpm/, so should
its declaration go in the internal header drivers/char/tpm/tpm.h instead?

- Eric
