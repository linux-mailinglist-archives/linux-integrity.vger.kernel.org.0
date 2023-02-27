Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F6EC6A3DA2
	for <lists+linux-integrity@lfdr.de>; Mon, 27 Feb 2023 09:57:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229821AbjB0I5j (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 27 Feb 2023 03:57:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229827AbjB0I5N (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 27 Feb 2023 03:57:13 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 721911CAF8;
        Mon, 27 Feb 2023 00:48:48 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C56E960DBD;
        Mon, 27 Feb 2023 08:36:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 889E3C4339B;
        Mon, 27 Feb 2023 08:36:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1677486996;
        bh=aPB28of5jnYKF5zuEBrnpPszEjEvVLjOQvY4NhHt17A=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=JFPqh1Ogm/HoDNRgb3Ysou8wTnAM1OdtalmbxiF6ZRdJqh5a6mWD64zhfMwtM+IEc
         kEs3UxGlT0/mUrepUR2K+jEIoe18CNoXP7Ifx/IPvYvozltdS1z85c7XY2MqZJ9eOH
         vbTXET3qAm8HaAWlJwVxANbZXRBqw0ogcFLou+bCejyx3lAY2ND2QHZGsBWE9TOmcw
         uluDBOccY0x1gNeSckwFZBnZu2mLg+zdPioIZB/NkYIxldNaOO+eV+iuFLTve0feVv
         lnvxIFaxjw4cYc+lde06ijZZdMrWcCnyI78T4rBmPuq/vI1eEiSA82iRU901kPSj9C
         WbQvU+/M7o4Uw==
Date:   Mon, 27 Feb 2023 10:36:33 +0200
From:   Jarkko Sakkinen <jarkko@kernel.org>
To:     James Bottomley <James.Bottomley@hansenpartnership.com>
Cc:     linux-integrity@vger.kernel.org, keyrings@vger.kernel.org,
        Ard Biesheuvel <ardb@kernel.org>
Subject: Re: [PATCH 05/12] tpm: add buffer function to point to returned
 parameters
Message-ID: <Y/xrkaMnyMbUlrXd@kernel.org>
References: <20230216201410.15010-1-James.Bottomley@HansenPartnership.com>
 <20230216201410.15010-6-James.Bottomley@HansenPartnership.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230216201410.15010-6-James.Bottomley@HansenPartnership.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Thu, Feb 16, 2023 at 03:14:03PM -0500, James Bottomley wrote:
> Introducing encryption sessions changes where the return parameters
> are located in the buffer because if a return session is present
> they're 4 bytes beyond the header with those 4 bytes showing the
> parameter length.  If there is no return session, then they're in the
> usual place immediately after the header.  The tpm_buf_parameters()
> encapsulates this calculation and should be used everywhere
> &buf.data[TPM_HEADER_SIZE] is used now
> 
> Signed-off-by: James Bottomley <James.Bottomley@HansenPartnership.com>
> ---
>  drivers/char/tpm/tpm-buf.c | 10 ++++++++++
>  include/linux/tpm.h        |  2 ++
>  2 files changed, 12 insertions(+)
> 
> diff --git a/drivers/char/tpm/tpm-buf.c b/drivers/char/tpm/tpm-buf.c
> index b76158f9bcd0..2518b675e866 100644
> --- a/drivers/char/tpm/tpm-buf.c
> +++ b/drivers/char/tpm/tpm-buf.c
> @@ -183,3 +183,13 @@ u32 tpm_get_inc_u32(const u8 **ptr)
>  	return val;
>  }
>  EXPORT_SYMBOL_GPL(tpm_get_inc_u32);
> +
> +u8 *tpm_buf_parameters(struct tpm_buf *buf)

kdoc

> +{
> +	int offset = TPM_HEADER_SIZE;
> +
> +	if (tpm_buf_tag(buf) == TPM2_ST_SESSIONS)
> +		offset += 4;
> +
> +	return &buf->data[offset];
> +}
> diff --git a/include/linux/tpm.h b/include/linux/tpm.h
> index f7cff1d114b0..fa8d1f932c0f 100644
> --- a/include/linux/tpm.h
> +++ b/include/linux/tpm.h
> @@ -339,6 +339,8 @@ u8 tpm_get_inc_u8(const u8 **ptr);
>  u16 tpm_get_inc_u16(const u8 **ptr);
>  u32 tpm_get_inc_u32(const u8 **ptr);
>  
> +u8 *tpm_buf_parameters(struct tpm_buf *buf);
> +
>  /*
>   * Check if TPM device is in the firmware upgrade mode.
>   */
> -- 
> 2.35.3
> 

BR, Jarkko
