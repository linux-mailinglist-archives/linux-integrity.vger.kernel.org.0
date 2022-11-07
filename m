Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A4EE461F1F4
	for <lists+linux-integrity@lfdr.de>; Mon,  7 Nov 2022 12:38:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231857AbiKGLh7 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 7 Nov 2022 06:37:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231837AbiKGLh6 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 7 Nov 2022 06:37:58 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3AFB6D40;
        Mon,  7 Nov 2022 03:37:58 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id E3A9DB81047;
        Mon,  7 Nov 2022 11:37:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9F6C3C433C1;
        Mon,  7 Nov 2022 11:37:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1667821075;
        bh=wmRJ9Bh1sQC5dP/YZFcpYvwOfERvr5wUBEB4e5Epx4E=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=O+DVhJKV0sdvQ9OEqMeJ39GM3xddAsWmwVCTv+OcVovps629wehNde+cOI0Yw3Ucn
         d+eEG+YFVPK1eD5C75kDEy9j0asfxBFJH1WIGxRGw4aVSe0fTeqwwDN2bhnEbpfXdL
         1SwXXP2JA+DGFkUF6iHoswBEKo9mLtEuMPVYn0soK4qAMdYN/tL3mF3FNqGYGRebtO
         AQ5xh6+QWg7/SBlOEcRa8yQzjHAUmsg+uOjPjl5YtOxkYN/vB77G7CetEAfro4gEfA
         xDBU7kkHQ6xokjAwDstiCoq1xizZhyceELdGhJ5cNBXO1cJJhmnZ6doQ0acUvaAlsD
         DwRSHUSdT6W2g==
Date:   Mon, 7 Nov 2022 13:37:49 +0200
From:   Jarkko Sakkinen <jarkko@kernel.org>
To:     Evan Green <evgreen@chromium.org>
Cc:     linux-kernel@vger.kernel.org, corbet@lwn.net,
        linux-pm@vger.kernel.org, rjw@rjwysocki.net, gwendal@chromium.org,
        apronin@chromium.org, Pavel Machek <pavel@ucw.cz>,
        Kees Cook <keescook@chromium.org>,
        Matthew Garrett <mgarrett@aurora.tech>,
        linux-integrity@vger.kernel.org, jejb@linux.ibm.com,
        zohar@linux.ibm.com, dlunev@google.com,
        Eric Biggers <ebiggers@kernel.org>,
        Ben Boeckel <me@benboeckel.net>,
        Jason Gunthorpe <jgg@ziepe.ca>, Peter Huewe <peterhuewe@gmx.de>
Subject: Re: [PATCH v4 02/11] tpm: Export and rename
 tpm2_find_and_validate_cc()
Message-ID: <Y2juDUwRLnYRYCPs@kernel.org>
References: <20221103180120.752659-1-evgreen@chromium.org>
 <20221103105558.v4.2.I7bbedcf5efd3f1c72c32d6002faed086c5ed31c7@changeid>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221103105558.v4.2.I7bbedcf5efd3f1c72c32d6002faed086c5ed31c7@changeid>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Thu, Nov 03, 2022 at 11:01:10AM -0700, Evan Green wrote:
> Export tpm_find_and_validate_cc() since it will be needed by an upcoming
> change allowing access to certain PCRs to be restricted to the kernel.
> In order to export it consistently, and because it's a tpm2-only
> function, rename it to tpm2_find_and_validate_cc().
> 
> Signed-off-by: Evan Green <evgreen@chromium.org>
> 
> ---
> 
> (no changes since v3)
> 
> Changes in v3:
>  - Split find_and_validate_cc() export to its own patch (Jarkko)
>  - Rename tpm_find_and_validate_cc() to tpm2_find_and_validate_cc().
> 
>  drivers/char/tpm/tpm.h        | 3 +++
>  drivers/char/tpm/tpm2-space.c | 8 ++++----
>  2 files changed, 7 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/char/tpm/tpm.h b/drivers/char/tpm/tpm.h
> index 24ee4e1cc452a0..f1e0f490176f01 100644
> --- a/drivers/char/tpm/tpm.h
> +++ b/drivers/char/tpm/tpm.h
> @@ -231,6 +231,9 @@ int tpm2_find_cc(struct tpm_chip *chip, u32 cc);
>  int tpm2_init_space(struct tpm_space *space, unsigned int buf_size);
>  void tpm2_del_space(struct tpm_chip *chip, struct tpm_space *space);
>  void tpm2_flush_space(struct tpm_chip *chip);
> +int tpm2_find_and_validate_cc(struct tpm_chip *chip,
> +			      struct tpm_space *space,
> +			      const void *cmd, size_t len);
>  int tpm2_prepare_space(struct tpm_chip *chip, struct tpm_space *space, u8 *cmd,
>  		       size_t cmdsiz);
>  int tpm2_commit_space(struct tpm_chip *chip, struct tpm_space *space, void *buf,
> diff --git a/drivers/char/tpm/tpm2-space.c b/drivers/char/tpm/tpm2-space.c
> index ffb35f0154c16c..ca34cc006e7f8d 100644
> --- a/drivers/char/tpm/tpm2-space.c
> +++ b/drivers/char/tpm/tpm2-space.c
> @@ -262,9 +262,9 @@ static int tpm2_map_command(struct tpm_chip *chip, u32 cc, u8 *cmd)
>  	return 0;
>  }
>  
> -static int tpm_find_and_validate_cc(struct tpm_chip *chip,
> -				    struct tpm_space *space,
> -				    const void *cmd, size_t len)
> +int tpm2_find_and_validate_cc(struct tpm_chip *chip,
> +			      struct tpm_space *space,
> +			      const void *cmd, size_t len)
>  {
>  	const struct tpm_header *header = (const void *)cmd;
>  	int i;
> @@ -306,7 +306,7 @@ int tpm2_prepare_space(struct tpm_chip *chip, struct tpm_space *space, u8 *cmd,
>  	if (!space)
>  		return 0;
>  
> -	cc = tpm_find_and_validate_cc(chip, space, cmd, cmdsiz);
> +	cc = tpm2_find_and_validate_cc(chip, space, cmd, cmdsiz);
>  	if (cc < 0)
>  		return cc;
>  
> -- 
> 2.38.1.431.g37b22c650d-goog
> 

Acked-by: Jarkko Sakkinen <jarkko@kernel.org>

BR, Jarkko
