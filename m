Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA1A8639BA1
	for <lists+linux-integrity@lfdr.de>; Sun, 27 Nov 2022 17:07:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229644AbiK0QH5 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Sun, 27 Nov 2022 11:07:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229630AbiK0QH4 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Sun, 27 Nov 2022 11:07:56 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D0E3EE1E;
        Sun, 27 Nov 2022 08:07:55 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 046FA60DD7;
        Sun, 27 Nov 2022 16:07:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0DA57C433B5;
        Sun, 27 Nov 2022 16:07:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1669565274;
        bh=TS2skIq/1L44f7iCxGZ+KXxC0nDt4u486TOQzXsedQM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=iuRureIP/P297HmWleZzfjTAGMUIWhVCXwdkx7gVJ7uXY0dmQBwPq4Kwtqk8+yB3P
         3ZhuVUJdLmAEvJX/HSQVfBQTnCDCvnZvS6hgHFGTAhB8VyS7MK1RUteooPdzxb0AVR
         v1pDLLU8sB0mNY8BFc7VTbGVOPALLK+W/Zr5O42O3ozzjR0THMI+MnK2SI9G73iOXR
         CA5mxmZrkduhN+n96Ga65TgnFri5nQwjZBAHIexOteDmD20t3e3QKnjzrEBEwG+OYb
         naXA4s06jRSs+tAtvkBxQMAf1UMViDSqxg8lJhTJk3q3m0BzRLwZ6Df24DDN3SbeD6
         I1R9VYccceZhw==
Date:   Sun, 27 Nov 2022 18:07:50 +0200
From:   Jarkko Sakkinen <jarkko@kernel.org>
To:     Evan Green <evgreen@chromium.org>
Cc:     linux-kernel@vger.kernel.org, corbet@lwn.net,
        linux-integrity@vger.kernel.org,
        Eric Biggers <ebiggers@kernel.org>, gwendal@chromium.org,
        dianders@chromium.org, apronin@chromium.org,
        Pavel Machek <pavel@ucw.cz>, Ben Boeckel <me@benboeckel.net>,
        rjw@rjwysocki.net, jejb@linux.ibm.com,
        Kees Cook <keescook@chromium.org>, dlunev@google.com,
        zohar@linux.ibm.com, Matthew Garrett <mgarrett@aurora.tech>,
        linux-pm@vger.kernel.org, Matthew Garrett <mjg59@google.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Peter Huewe <peterhuewe@gmx.de>, axelj <axelj@axis.com>
Subject: Re: [PATCH v5 01/11] tpm: Add support for in-kernel resetting of PCRs
Message-ID: <Y4OLVoErV4VHxsCx@kernel.org>
References: <20221111231636.3748636-1-evgreen@chromium.org>
 <20221111151451.v5.1.I776854f47e3340cc2913ed4d8ecdd328048b73c3@changeid>
 <Y4OK9aXt0SrFzbT7@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y4OK9aXt0SrFzbT7@kernel.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Sun, Nov 27, 2022 at 06:06:13PM +0200, Jarkko Sakkinen wrote:
> On Fri, Nov 11, 2022 at 03:16:26PM -0800, Evan Green wrote:
> > Add an internal command for resetting a PCR. This will be used by the
> > encrypted hibernation code to set PCR23 to a known value. The
> > hibernation code will seal the hibernation key with a policy specifying
> > PCR23 be set to this known value as a mechanism to ensure that the
> > hibernation key is genuine. But to do this repeatedly, resetting the PCR
> > is necessary as well.
> > 
> > Link: https://lore.kernel.org/lkml/20210220013255.1083202-2-matthewgarrett@google.com/
> > Co-developed-by: Matthew Garrett <mjg59@google.com>
> > Signed-off-by: Matthew Garrett <mjg59@google.com>
> > Signed-off-by: Evan Green <evgreen@chromium.org>
> > 
> > ---
> > 
> > Changes in v5:
> >  - Change to co-developed by Matthew (Kees)
> > 
> > Changes in v4:
> >  - Open code tpm2_pcr_reset implementation in tpm-interface.c (Jarkko)
> >  - Rename interface symbol to tpm2_pcr_reset, fix kerneldocs (Jarkko)
> > 
> > Changes in v3:
> >  - Unify tpm1/2_pcr_reset prototypes (Jarkko)
> >  - Wait no, remove the TPM1 stuff altogether (Jarkko)
> >  - Remove extra From tag and blank in commit msg (Jarkko).
> > 
> >  drivers/char/tpm/tpm-interface.c | 47 ++++++++++++++++++++++++++++++++
> >  drivers/char/tpm/tpm2-cmd.c      |  7 -----
> >  include/linux/tpm.h              | 14 ++++++++++
> >  3 files changed, 61 insertions(+), 7 deletions(-)
> > 
> > diff --git a/drivers/char/tpm/tpm-interface.c b/drivers/char/tpm/tpm-interface.c
> > index 1621ce8187052c..886277b2654e3b 100644
> > --- a/drivers/char/tpm/tpm-interface.c
> > +++ b/drivers/char/tpm/tpm-interface.c
> > @@ -342,6 +342,53 @@ int tpm_pcr_extend(struct tpm_chip *chip, u32 pcr_idx,
> >  }
> >  EXPORT_SYMBOL_GPL(tpm_pcr_extend);
> >  
> > +/**
> > + * tpm2_pcr_reset - Reset the specified PCR
> > + * @chip: A &struct tpm_chip instance, %NULL for the default chip
> > + * @pcr_idx: The PCR to be reset
> > + *
> > + * Return: Same as with tpm_transmit_cmd(), or ENOTTY for TPM1 devices.
> > + */
> > +int tpm2_pcr_reset(struct tpm_chip *chip, u32 pcr_idx)
> > +{
> > +	struct tpm2_null_auth_area auth_area;
> > +	struct tpm_buf buf;
> > +	int rc;
> > +
> > +	chip = tpm_find_get_ops(chip);
> > +	if (!chip)
> > +		return -ENODEV;
> > +
> > +	if (!(chip->flags & TPM_CHIP_FLAG_TPM2)) {
> > +		rc = -ENOTTY;
> > +		goto out;
> > +	}
> > +
> > +	rc = tpm_buf_init(&buf, TPM2_ST_SESSIONS, TPM2_CC_PCR_RESET);
> > +	if (rc)
> > +		goto out;
> > +
> > +	tpm_buf_append_u32(&buf, pcr_idx);
> > +
> > +	auth_area.handle = cpu_to_be32(TPM2_RS_PW);
> > +	auth_area.nonce_size = 0;
> > +	auth_area.attributes = 0;
> > +	auth_area.auth_size = 0;
> > +
> > +	tpm_buf_append_u32(&buf, sizeof(struct tpm2_null_auth_area));
> > +	tpm_buf_append(&buf, (const unsigned char *)&auth_area,
> > +		       sizeof(auth_area));
> > +
> > +	rc = tpm_transmit_cmd(chip, &buf, 0, "attempting to reset a PCR");
> > +
> > +	tpm_buf_destroy(&buf);
> > +
> > +out:
> > +	tpm_put_ops(chip);
> > +	return rc;
> > +}
> > +EXPORT_SYMBOL_GPL(tpm2_pcr_reset);
> > +
> >  /**
> >   * tpm_send - send a TPM command
> >   * @chip:	a &struct tpm_chip instance, %NULL for the default chip
> > diff --git a/drivers/char/tpm/tpm2-cmd.c b/drivers/char/tpm/tpm2-cmd.c
> > index 65d03867e114c5..303ce2ea02a4b0 100644
> > --- a/drivers/char/tpm/tpm2-cmd.c
> > +++ b/drivers/char/tpm/tpm2-cmd.c
> > @@ -216,13 +216,6 @@ int tpm2_pcr_read(struct tpm_chip *chip, u32 pcr_idx,
> >  	return rc;
> >  }
> >  
> > -struct tpm2_null_auth_area {
> > -	__be32  handle;
> > -	__be16  nonce_size;
> > -	u8  attributes;
> > -	__be16  auth_size;
> > -} __packed;
> > -
> >  /**
> >   * tpm2_pcr_extend() - extend a PCR value
> >   *
> > diff --git a/include/linux/tpm.h b/include/linux/tpm.h
> > index dfeb25a0362dee..70134e6551745f 100644
> > --- a/include/linux/tpm.h
> > +++ b/include/linux/tpm.h
> > @@ -219,6 +219,7 @@ enum tpm2_command_codes {
> >  	TPM2_CC_HIERARCHY_CONTROL       = 0x0121,
> >  	TPM2_CC_HIERARCHY_CHANGE_AUTH   = 0x0129,
> >  	TPM2_CC_CREATE_PRIMARY          = 0x0131,
> > +	TPM2_CC_PCR_RESET		= 0x013D,
> >  	TPM2_CC_SEQUENCE_COMPLETE       = 0x013E,
> >  	TPM2_CC_SELF_TEST	        = 0x0143,
> >  	TPM2_CC_STARTUP		        = 0x0144,
> > @@ -293,6 +294,13 @@ struct tpm_header {
> >  	};
> >  } __packed;
> >  
> > +struct tpm2_null_auth_area {
> > +	__be32  handle;
> > +	__be16  nonce_size;
> > +	u8  attributes;
> > +	__be16  auth_size;
> > +} __packed;
> > +
> >  /* A string buffer type for constructing TPM commands. This is based on the
> >   * ideas of string buffer code in security/keys/trusted.h but is heap based
> >   * in order to keep the stack usage minimal.
> > @@ -423,6 +431,7 @@ extern ssize_t tpm_transmit_cmd(struct tpm_chip *chip, struct tpm_buf *buf,
> >  				size_t min_rsp_body_length, const char *desc);
> >  extern int tpm_pcr_read(struct tpm_chip *chip, u32 pcr_idx,
> >  			struct tpm_digest *digest);
> > +extern int tpm2_pcr_reset(struct tpm_chip *chip, u32 pcr_idx);
> >  extern int tpm_pcr_extend(struct tpm_chip *chip, u32 pcr_idx,
> >  			  struct tpm_digest *digests);
> >  extern int tpm_send(struct tpm_chip *chip, void *cmd, size_t buflen);
> > @@ -440,6 +449,11 @@ static inline int tpm_pcr_read(struct tpm_chip *chip, int pcr_idx,
> >  	return -ENODEV;
> >  }
> >  
> > +static inline int tpm2_pcr_reset(struct tpm_chip *chip, int pcr_idx)
> > +{
> > +	return -ENODEV;
> > +}
> > +
> >  static inline int tpm_pcr_extend(struct tpm_chip *chip, u32 pcr_idx,
> >  				 struct tpm_digest *digests)
> >  {
> > -- 
> > 2.38.1.431.g37b22c650d-goog
> > 
> 
> Reviewed-by: Jarkko Sakkinen <jarkko@kernel.org>

Please ignore, wrong patch, sorry.

BR, Jarkko
