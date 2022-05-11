Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 59B115236F1
	for <lists+linux-integrity@lfdr.de>; Wed, 11 May 2022 17:18:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245707AbiEKPR7 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 11 May 2022 11:17:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245706AbiEKPR6 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 11 May 2022 11:17:58 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD0A320F4FD;
        Wed, 11 May 2022 08:17:57 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6B035618D6;
        Wed, 11 May 2022 15:17:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 52C70C340EE;
        Wed, 11 May 2022 15:17:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1652282276;
        bh=15pJJEvRiuh11eXzFUTX/Cwaj4pw2lagxUeoD6XptCw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ONIcOnI44zE5Tg6ztuEmm0O+DTBmtSBtOpWp0UabRx2n1nmqAU56mPPAXziljv3+K
         5Kekccr9BKxpYXhQ143unTvldjH4BFm2xaTRoIM339zjsDzHTh22wlbpkJLOmNCqln
         iV7gh6OZ21a/uUP88nZw9mQkBgF+coPaoMY2B1QZ4n/7hdvzPgDaBSwicXs/NNm+AT
         QyoCvS2gGK0bmsVf30hDh9CWy0Oa3kvImIu8YHFfC2inRWPfADasjfIh6roKmPbD6I
         ZKHTbcWPGhuiSQKwPLbjJ4kgIQCtI9q+3MtEen0TBoL0i8bPjWz4gkHJuF3rhHlE9L
         anIxWuwhMyDfA==
Date:   Wed, 11 May 2022 18:16:26 +0300
From:   Jarkko Sakkinen <jarkko@kernel.org>
To:     Johannes Holland <johannes.holland@infineon.com>,
        Nayna <nayna@linux.vnet.ibm.com>,
        Mimi Zohar <zohar@linux.ibm.com>
Cc:     linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org,
        peterhuewe@gmx.de, jgg@ziepe.ca
Subject: Re: [PATCH] tpm: sleep at least <...> ms in tpm_msleep()
Message-ID: <YnvTSqRgYkWu0qgp@kernel.org>
References: <20220510112902.23213-1-johannes.holland@infineon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220510112902.23213-1-johannes.holland@infineon.com>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Tue, May 10, 2022 at 01:29:03PM +0200, Johannes Holland wrote:
> To comply with protocol requirements, minimum polling times must often
> be adhered to. Therefore, a macro like tpm_msleep() should sleep at
> least the given amount of time (not up to the given period). Have
> tpm_msleep() sleep at least the given number of milliseconds.
> 
> Signed-off-by: Johannes Holland <johannes.holland@infineon.com>
> ---
>  drivers/char/tpm/tpm.h | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/char/tpm/tpm.h b/drivers/char/tpm/tpm.h
> index 2163c6ee0d36..0971b55fffe3 100644
> --- a/drivers/char/tpm/tpm.h
> +++ b/drivers/char/tpm/tpm.h
> @@ -185,8 +185,8 @@ int tpm_pm_resume(struct device *dev);
>  
>  static inline void tpm_msleep(unsigned int delay_msec)
>  {
> -	usleep_range((delay_msec * 1000) - TPM_TIMEOUT_RANGE_US,
> -		     delay_msec * 1000);
> +	usleep_range(delay_msec * 1000, (delay_msec * 1000)
> +		     + TPM_TIMEOUT_RANGE_US);
>  };
>  
>  int tpm_chip_start(struct tpm_chip *chip);
> -- 
> 2.34.1
> 

For this I would really like to hear a 2nd opinion from Nayna and Mimi.

BR, Jarkko
