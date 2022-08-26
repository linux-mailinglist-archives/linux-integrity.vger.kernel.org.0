Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 29AE55A1F29
	for <lists+linux-integrity@lfdr.de>; Fri, 26 Aug 2022 05:00:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244796AbiHZDAB (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 25 Aug 2022 23:00:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235147AbiHZC77 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 25 Aug 2022 22:59:59 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 377E333376;
        Thu, 25 Aug 2022 19:59:58 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D372861E64;
        Fri, 26 Aug 2022 02:59:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B32A1C433D6;
        Fri, 26 Aug 2022 02:59:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1661482797;
        bh=G0cteGp0bxyPbU08mT1HNn/O4ILEZ4wJ+AAKm8re164=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=jGvASoibfAEATRm93/PIi92grxXeMlPkH2flVQwrjkxH9ONEiVmyQF2Pea/OEqtnX
         JMKLCmUCH9VqjOQOVbN5qtJhCQp6TDhe4izVHSRPDexYc0ZKn2XiwxZDPoUPyYPANn
         a/RqQLbUbKtW4A0CyA4NImnutxTLgKQeAqmTk4jjUAgIODmrxZ8YXwJPTS+FpquU39
         bbeZ6dIR6XYZph3m/ENNL6DIMz4LIlEn8jm4Vdmmre6L2jp2hWBU+ti6oLcUJVjoV+
         DmYCiJjDbtDWiJsEF/fIdV4hu/kQ61aXWeFSm33+yg1nNRJggM5o5MKpEm23i2Y0Kj
         j2lqXBai4h/xA==
Date:   Fri, 26 Aug 2022 05:59:49 +0300
From:   Jarkko Sakkinen <jarkko@kernel.org>
To:     Evan Green <evgreen@chromium.org>
Cc:     linux-kernel@vger.kernel.org, gwendal@chromium.org,
        Eric Biggers <ebiggers@kernel.org>,
        Matthew Garrett <mgarrett@aurora.tech>, zohar@linux.ibm.com,
        linux-integrity@vger.kernel.org, Pavel Machek <pavel@ucw.cz>,
        apronin@chromium.org, dlunev@google.com, rjw@rjwysocki.net,
        linux-pm@vger.kernel.org, corbet@lwn.net, jejb@linux.ibm.com,
        Matthew Garrett <matthewgarrett@google.com>,
        Matthew Garrett <mjg59@google.com>, Hao Wu <hao.wu@rubrik.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Peter Huewe <peterhuewe@gmx.de>, axelj <axelj@axis.com>
Subject: Re: [PATCH v2 01/10] tpm: Add support for in-kernel resetting of PCRs
Message-ID: <Ywg3JZrWmRjvr/7f@kernel.org>
References: <20220823222526.1524851-1-evgreen@chromium.org>
 <20220823152108.v2.1.I776854f47e3340cc2913ed4d8ecdd328048b73c3@changeid>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220823152108.v2.1.I776854f47e3340cc2913ed4d8ecdd328048b73c3@changeid>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Tue, Aug 23, 2022 at 03:25:17PM -0700, Evan Green wrote:
> From: Matthew Garrett <matthewgarrett@google.com>
> 
> Add an internal command for resetting a PCR. This will be used by the
> encrypted hibernation code to set PCR23 to a known value. The
> hibernation code will seal the hibernation key with a policy specifying
> PCR23 be set to this known value as a mechanism to ensure that the
> hibernation key is genuine. But to do this repeatedly, resetting the PCR
> is necessary as well.
> 
> From: Matthew Garrett <mjg59@google.com>

This is probably here by mistake.

> Signed-off-by: Matthew Garrett <mjg59@google.com>
> 

No empty line here.

> Signed-off-by: Evan Green <evgreen@chromium.org>
> ---
> Matthew's original version of this patch was at:
> https://patchwork.kernel.org/patch/12096487/
> 
> (no changes since v1)
> 
>  drivers/char/tpm/tpm-interface.c | 28 +++++++++++++++++++++++++
>  drivers/char/tpm/tpm.h           |  2 ++
>  drivers/char/tpm/tpm1-cmd.c      | 34 ++++++++++++++++++++++++++++++
>  drivers/char/tpm/tpm2-cmd.c      | 36 ++++++++++++++++++++++++++++++++
>  include/linux/tpm.h              |  7 +++++++
>  5 files changed, 107 insertions(+)
> 
> diff --git a/drivers/char/tpm/tpm-interface.c b/drivers/char/tpm/tpm-interface.c
> index 1621ce8187052c..17b8643ee109c2 100644
> --- a/drivers/char/tpm/tpm-interface.c
> +++ b/drivers/char/tpm/tpm-interface.c
> @@ -342,6 +342,34 @@ int tpm_pcr_extend(struct tpm_chip *chip, u32 pcr_idx,
>  }
>  EXPORT_SYMBOL_GPL(tpm_pcr_extend);
>  
> +/**
> + * tpm_pcr_reset - reset the specified PCR
> + * @chip:	a &struct tpm_chip instance, %NULL for the default chip
> + * @pcr_idx:	the PCR to be reset
> + *
> + * Return: same as with tpm_transmit_cmd()
> + */
> +int tpm_pcr_reset(struct tpm_chip *chip, u32 pcr_idx)
> +{
> +	int rc;
> +
> +	chip = tpm_find_get_ops(chip);
> +	if (!chip)
> +		return -ENODEV;
> +
> +	if (chip->flags & TPM_CHIP_FLAG_TPM2) {
> +		rc = tpm2_pcr_reset(chip, pcr_idx);
> +		goto out;
> +	}
> +
> +	rc = tpm1_pcr_reset(chip, pcr_idx, "attempting to reset a PCR");
> +
> +out:
> +	tpm_put_ops(chip);

        if (chip->flags & TPM_CHIP_FLAG_TPM2)
                rc = tpm2_pcr_reset(chip, pcr_idx);
        else
                rc = tpm1_pcr_reset(chip, pcr_idx, "attempting to reset a PCR");

Where does this asymmetry come with the parameters?

BR, Jarkko
