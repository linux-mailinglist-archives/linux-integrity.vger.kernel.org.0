Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 36E2C4E1DE9
	for <lists+linux-integrity@lfdr.de>; Sun, 20 Mar 2022 22:14:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232186AbiCTVPr (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Sun, 20 Mar 2022 17:15:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343723AbiCTVNz (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Sun, 20 Mar 2022 17:13:55 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9BF11760DC;
        Sun, 20 Mar 2022 14:12:31 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 84B166123C;
        Sun, 20 Mar 2022 21:12:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 62BAEC340ED;
        Sun, 20 Mar 2022 21:12:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1647810751;
        bh=hLpKnRD3ITRJU2ilav2q6ufwlJgxfqoW4ypzibIIJO0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=gvyEQIn7viEeCiKVyUWkm5NIC+gdon9weyKl0dvvmfQV7coD9W9r3Fm3YFIBaswu7
         96DH6zi/irShSC0GHRSpZqCNC8bCtCPbLBfuURaeN4Qkc9I3xyu1B/F55BPSWn0OzT
         Ye9oyuuXwf6sIwtlTsK8y1u/DBW6np8NXyZkZn/qLVG/nBpb+qAAp0p4fqbV3qMLsS
         NBCMZIHyBOXJHsA8z7zElfNqEpYeNS6Zml07ADKE9ok/8FxDXBecJlgMr22ZmH0DWR
         Mi5XDeknn7inOAOtyYJBQ1wqRe084cUC2S92k+IU9sERrPlol06KGCYSH/YhI8T1/H
         4DYVgaIMdfw/A==
Date:   Sun, 20 Mar 2022 23:13:31 +0200
From:   Jarkko Sakkinen <jarkko@kernel.org>
To:     Haowen Bai <baihaowen@meizu.com>
Cc:     peterhuewe@gmx.de, jgg@ziepe.ca, linux-integrity@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] tpm/tpm_ftpm_tee: Return true/false (not 1/0) from bool
 functions
Message-ID: <YjeY+7CI6n7gUdVX@kernel.org>
References: <1647574525-25152-1-git-send-email-baihaowen@meizu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1647574525-25152-1-git-send-email-baihaowen@meizu.com>
X-Spam-Status: No, score=-8.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Fri, Mar 18, 2022 at 11:35:25AM +0800, Haowen Bai wrote:
> Return boolean values ("true" or "false") instead of 1 or 0 from bool
> functions.
> 
> Signed-off-by: Haowen Bai <baihaowen@meizu.com>
> ---
>  drivers/char/tpm/tpm_ftpm_tee.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/char/tpm/tpm_ftpm_tee.c b/drivers/char/tpm/tpm_ftpm_tee.c
> index 6e32355..5c23342 100644
> --- a/drivers/char/tpm/tpm_ftpm_tee.c
> +++ b/drivers/char/tpm/tpm_ftpm_tee.c
> @@ -177,7 +177,7 @@ static u8 ftpm_tee_tpm_op_status(struct tpm_chip *chip)
>  
>  static bool ftpm_tee_tpm_req_canceled(struct tpm_chip *chip, u8 status)
>  {
> -	return 0;
> +	return false;
>  }
>  
>  static const struct tpm_class_ops ftpm_tee_tpm_ops = {
> -- 
> 2.7.4
> 

Reviewed-by: Jarkko Sakkinen <jarkko@kernel.org>

BR, Jarkko
