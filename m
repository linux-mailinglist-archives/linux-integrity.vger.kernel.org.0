Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA7536A3E2B
	for <lists+linux-integrity@lfdr.de>; Mon, 27 Feb 2023 10:20:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229991AbjB0JUt (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 27 Feb 2023 04:20:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230008AbjB0JU3 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 27 Feb 2023 04:20:29 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89A04EC4D;
        Mon, 27 Feb 2023 01:16:39 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 1497DB80CA9;
        Mon, 27 Feb 2023 09:16:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4DCEDC433EF;
        Mon, 27 Feb 2023 09:16:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1677489396;
        bh=JeSjrxe11atYOcINTmnm0R97Nl3rtL1hmhT/XE11G94=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=EBpcngk3h3x4zt71ByI7NX3gXVvBHz8tGdVchvnZikqL3VztPe+CDcMluoiREdnTn
         9d3kKgNylhSxdpaZjt/PEEkl7/c1J72vkkkw1gvWkNvHR2Qgptw/VDPt5ol0QWgqGl
         1TazthlwOVahoo73VVU/9SWOiC70qnWXKHOYHgYas7nKROyVIPsxG/eaD6wb7DaYEU
         7D5v1f5SjZLcXuu3g87VfEqRcUOGUzkCU8vik46BB1U86Zti5iMWsuX1vUnHOrLGm5
         xM2Hfk8UwnEuqB4E4RfGCX+IR/E/D7pXZG5ecYOAy8SsnSkeSXc+uD12MfczO9skIw
         SYtYq9jSl2eeQ==
Date:   Mon, 27 Feb 2023 11:16:34 +0200
From:   Jarkko Sakkinen <jarkko@kernel.org>
To:     James Bottomley <James.Bottomley@hansenpartnership.com>
Cc:     linux-integrity@vger.kernel.org, keyrings@vger.kernel.org,
        Ard Biesheuvel <ardb@kernel.org>
Subject: Re: [PATCH 08/12] tpm: add hmac checks to tpm2_pcr_extend()
Message-ID: <Y/x04S0a5+/eOCjf@kernel.org>
References: <20230216201410.15010-1-James.Bottomley@HansenPartnership.com>
 <20230216201410.15010-9-James.Bottomley@HansenPartnership.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230216201410.15010-9-James.Bottomley@HansenPartnership.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Thu, Feb 16, 2023 at 03:14:06PM -0500, James Bottomley wrote:
> We use tpm2_pcr_extend() in trusted keys to extend a PCR to prevent a

"Use tpm2_pcr_extend()"

> key from being re-loaded until the next reboot.  To use this
> functionality securely, that extend must be protected by a session
> hmac.

There's no description of action taken. This is only motivation part.

> 
> Signed-off-by: James Bottomley <James.Bottomley@HansenPartnership.com>
> ---
>  drivers/char/tpm/tpm2-cmd.c | 27 ++++++++++-----------------
>  1 file changed, 10 insertions(+), 17 deletions(-)
> 
> diff --git a/drivers/char/tpm/tpm2-cmd.c b/drivers/char/tpm/tpm2-cmd.c
> index 056dad3dd5c9..ef038cc71f9c 100644
> --- a/drivers/char/tpm/tpm2-cmd.c
> +++ b/drivers/char/tpm/tpm2-cmd.c
> @@ -216,13 +216,6 @@ int tpm2_pcr_read(struct tpm_chip *chip, u32 pcr_idx,
>  	return rc;
>  }
>  
> -struct tpm2_null_auth_area {
> -	__be32  handle;
> -	__be16  nonce_size;
> -	u8  attributes;
> -	__be16  auth_size;
> -} __packed;
> -
>  /**
>   * tpm2_pcr_extend() - extend a PCR value
>   *
> @@ -236,24 +229,22 @@ int tpm2_pcr_extend(struct tpm_chip *chip, u32 pcr_idx,
>  		    struct tpm_digest *digests)
>  {
>  	struct tpm_buf buf;
> -	struct tpm2_null_auth_area auth_area;
>  	int rc;
>  	int i;
>  
> -	rc = tpm_buf_init(&buf, TPM2_ST_SESSIONS, TPM2_CC_PCR_EXTEND);
> +	rc = tpm2_start_auth_session(chip);
>  	if (rc)
>  		return rc;
>  
> -	tpm_buf_append_u32(&buf, pcr_idx);
> +	rc = tpm_buf_init(&buf, TPM2_ST_SESSIONS, TPM2_CC_PCR_EXTEND);
> +	if (rc) {
> +		tpm2_end_auth_session(chip);
> +		return rc;
> +	}
>  
> -	auth_area.handle = cpu_to_be32(TPM2_RS_PW);
> -	auth_area.nonce_size = 0;
> -	auth_area.attributes = 0;
> -	auth_area.auth_size = 0;
> +	tpm_buf_append_name(chip, &buf, pcr_idx, NULL);
> +	tpm_buf_append_hmac_session(chip, &buf, 0, NULL, 0);
>  
> -	tpm_buf_append_u32(&buf, sizeof(struct tpm2_null_auth_area));
> -	tpm_buf_append(&buf, (const unsigned char *)&auth_area,
> -		       sizeof(auth_area));
>  	tpm_buf_append_u32(&buf, chip->nr_allocated_banks);
>  
>  	for (i = 0; i < chip->nr_allocated_banks; i++) {
> @@ -262,7 +253,9 @@ int tpm2_pcr_extend(struct tpm_chip *chip, u32 pcr_idx,
>  			       chip->allocated_banks[i].digest_size);
>  	}
>  
> +	tpm_buf_fill_hmac_session(chip, &buf);
>  	rc = tpm_transmit_cmd(chip, &buf, 0, "attempting extend a PCR value");
> +	rc = tpm_buf_check_hmac_response(chip, &buf, rc);
>  
>  	tpm_buf_destroy(&buf);
>  
> -- 
> 2.35.3
> 

BR, Jarkko
