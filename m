Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF2F7639BCC
	for <lists+linux-integrity@lfdr.de>; Sun, 27 Nov 2022 17:39:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229552AbiK0QjB (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Sun, 27 Nov 2022 11:39:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229548AbiK0Qi7 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Sun, 27 Nov 2022 11:38:59 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 411BD64CF;
        Sun, 27 Nov 2022 08:38:59 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id DC54BB80A71;
        Sun, 27 Nov 2022 16:38:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 44576C433C1;
        Sun, 27 Nov 2022 16:38:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1669567136;
        bh=inFOgsdBw0p/p65fsw61lY1MN+Gt93Cey4uRiIeIjdE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=sYyZYWtzsgB+jvvmsaGvo/2eOEMRKDAaIqBQi8Ujh9ue50paKbVR6TfRH4DnSQLxP
         Q0eVJRwunYZBWSqSCDt18EeaDjY//lXgqv5eDBSaQN2AWVUa0PzQx54ojaJv3WA8Qz
         1H2/3HOhmdHyYd3Hx0+3KQqD/Z5UPp68jX2DEwRKvVHLBNKTPWsZRXEkid3mgNGnzb
         B81YmRsw6xuHqAr/FJuubqlx5oT9tKIElc23q3rPCkhwxWd3X0kStxH8rc1C+e1u+x
         5sX3t/6bDiT3I8xmqCcngvCC3CXt1eXnkzFDNEbHEIHrEGZR8rXtl8nHyeKN7bubWG
         poB2r5K5LmPFg==
Date:   Sun, 27 Nov 2022 18:38:52 +0200
From:   Jarkko Sakkinen <jarkko@kernel.org>
To:     Michael Kelley <mikelley@microsoft.com>
Cc:     peterhuewe@gmx.de, jgg@ziepe.ca, tomas.winkler@intel.com,
        linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/1] tpm/tpm_crb: Fix error message in
 __crb_relinquish_locality()
Message-ID: <Y4OSnFFhj+20wiO0@kernel.org>
References: <1668195533-16761-1-git-send-email-mikelley@microsoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1668195533-16761-1-git-send-email-mikelley@microsoft.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Fri, Nov 11, 2022 at 11:38:53AM -0800, Michael Kelley wrote:
> The error message in __crb_relinquish_locality() mentions requestAccess
> instead of Relinquish. Fix it.
> 
> Fixes: 888d867df441 ("tpm: cmd_ready command can be issued only after granting locality")
> Signed-off-by: Michael Kelley <mikelley@microsoft.com>
> ---
>  drivers/char/tpm/tpm_crb.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/char/tpm/tpm_crb.c b/drivers/char/tpm/tpm_crb.c
> index 1860665..65f8f17 100644
> --- a/drivers/char/tpm/tpm_crb.c
> +++ b/drivers/char/tpm/tpm_crb.c
> @@ -252,7 +252,7 @@ static int __crb_relinquish_locality(struct device *dev,
>  	iowrite32(CRB_LOC_CTRL_RELINQUISH, &priv->regs_h->loc_ctrl);
>  	if (!crb_wait_for_reg_32(&priv->regs_h->loc_state, mask, value,
>  				 TPM2_TIMEOUT_C)) {
> -		dev_warn(dev, "TPM_LOC_STATE_x.requestAccess timed out\n");
> +		dev_warn(dev, "TPM_LOC_STATE_x.Relinquish timed out\n");
>  		return -ETIME;
>  	}
>  
> -- 
> 1.8.3.1
> 

Please explain.

BR, Jarkko
