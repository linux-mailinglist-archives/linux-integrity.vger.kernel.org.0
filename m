Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 721CC62729B
	for <lists+linux-integrity@lfdr.de>; Sun, 13 Nov 2022 21:46:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234001AbiKMUqp (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Sun, 13 Nov 2022 15:46:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229692AbiKMUqo (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Sun, 13 Nov 2022 15:46:44 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA07C13F14;
        Sun, 13 Nov 2022 12:46:43 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 834D360BEF;
        Sun, 13 Nov 2022 20:46:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5153DC433D6;
        Sun, 13 Nov 2022 20:46:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1668372402;
        bh=xaqwb9NYQc7TzmX7HYtly04qWi7S1HITQEWMQIaFxA4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Imsp1W2jf7KdLzPe1JeZLgTsq0M+NNKyEean/wrpNUZlp5TYk47OiIqaLCCCocsu4
         P0ZJYrAKbBcOl4+2vY5lGmAJRVP2AOIq1L9lI1ZjQhUOpTV0niaFp6UqRu3JKLfBfc
         NTW+jnoiB2g7ZvoHysYobOuxw8F2y2e4zbpu/T8CEz/iyGP5D2fvExMi9bmpjBHMpM
         nktMLTc5rjoo5kSUy2qLouIStbN45I3QytBW8czH9iARD+NoT9abjz/Q7DNhI6PQfK
         V/O/mEaazytC8tSd7WKFcYVY8IC55k+LTb8UKqvaJRAqnArqpl+bPsB9RRe8POAEuG
         ViC9DuMz8TVpQ==
Date:   Sun, 13 Nov 2022 12:46:40 -0800
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
        Jason Gunthorpe <jgg@ziepe.ca>, Peter Huewe <peterhuewe@gmx.de>
Subject: Re: [PATCH v5 03/11] tpm: Allow PCR 23 to be restricted to
 kernel-only use
Message-ID: <Y3FXsPbBeZjAKv1/@sol.localdomain>
References: <20221111231636.3748636-1-evgreen@chromium.org>
 <20221111151451.v5.3.I9ded8c8caad27403e9284dfc78ad6cbd845bc98d@changeid>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221111151451.v5.3.I9ded8c8caad27403e9284dfc78ad6cbd845bc98d@changeid>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Fri, Nov 11, 2022 at 03:16:28PM -0800, Evan Green wrote:
> Introduce a new Kconfig, TCG_TPM_RESTRICT_PCR, which if enabled

TCG_TPM_RESTRICT_PCR => TCG_TPM2_RESTRICT_PCR

> For systems with TPM1 devices, having this Kconfig enabled completely
> restricts usermode's access to the TPM.

This doesn't appear to actually be the case.

> +config TCG_TPM2_RESTRICT_PCR
> +	bool "Restrict userland access to PCR 23 on TPM2 devices"
> +	depends on TCG_TPM

I assume you also considered making this a once-settable sysctl, or similar?
I guess this kconfig is fine for now, but IMO it does violate the concept of
"kernel provides mechanism, not policy".

> diff --git a/drivers/char/tpm/tpm2-cmd.c b/drivers/char/tpm/tpm2-cmd.c
> index 303ce2ea02a4b0..3bc5546fddc792 100644
> --- a/drivers/char/tpm/tpm2-cmd.c
> +++ b/drivers/char/tpm/tpm2-cmd.c
> @@ -778,3 +778,25 @@ int tpm2_find_cc(struct tpm_chip *chip, u32 cc)
>  
>  	return -1;
>  }
> +
> +#ifdef CONFIG_TCG_TPM2_RESTRICT_PCR
> +int tpm2_cmd_restricted(struct tpm_chip *chip, u8 *buffer, size_t size)
> +{
> +	int cc = tpm2_find_and_validate_cc(chip, NULL, buffer, size);
> +	__be32 *handle;
> +
> +	switch (cc) {
> +	case TPM2_CC_PCR_EXTEND:
> +	case TPM2_CC_PCR_RESET:
> +		if (size < (TPM_HEADER_SIZE + sizeof(u32)))
> +			return -EINVAL;
> +
> +		handle = (__be32 *)&buffer[TPM_HEADER_SIZE];
> +		if (be32_to_cpu(*handle) == TPM_RESTRICTED_PCR)
> +			return -EPERM;

get_unaligned_be32((__be32 *)&buffer[TPM_HEADER_SIZE]),
to avoid an unaligned memory access.

> +		break;
> +	}
> +
> +	return 0;

So, if tpm2_find_and_validate_cc() returns an error code, the command is *not*
restricted, even if it uses one of the forbidden command codes.  Are you sure
there are no loopholes here?

- Eric
