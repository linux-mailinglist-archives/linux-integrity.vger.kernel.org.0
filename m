Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 626EE6C13E9
	for <lists+linux-integrity@lfdr.de>; Mon, 20 Mar 2023 14:48:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229665AbjCTNsU (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 20 Mar 2023 09:48:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229696AbjCTNsT (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 20 Mar 2023 09:48:19 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E8CA4237
        for <linux-integrity@vger.kernel.org>; Mon, 20 Mar 2023 06:48:18 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id C7923B80E60
        for <linux-integrity@vger.kernel.org>; Mon, 20 Mar 2023 13:48:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 31D66C433EF;
        Mon, 20 Mar 2023 13:48:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1679320095;
        bh=QBqjhMphxTss/lzOhTHC4mpc8kNHIm+N3wJZGZ4gHo8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=JwfCksflNyEOvrpB1ETXqZWY/e5b63TxYeLx1R6Fklhj17BiuOtIa9jyQIz1Xdeqj
         ckbs+nL7RoRwvXgIqPYq9E8vsoMhBP+aBwsF3fWY0nB4z/8YCSe2vWW03zKtFLYhdu
         mnTxaTgVrk3EofTECwcRxlTKcSM+cVWH1FF1NiuAR29Pb7ta/DFu4wNMK9OSbFShEC
         6l7HCJ3nyHSi3OM1CFZozizRZDOdN/weGbqxIWNEWGe0q4ccmqC76G81LFTxmWRhVA
         t87y1/6HKRsI55+6dnvJO/pcNfdeh18R6Ikyda/Ho5n01u7hZwW+Qe6wkpKslL2de7
         YFw8NcQLlhAtA==
Date:   Mon, 20 Mar 2023 15:48:12 +0200
From:   Jarkko Sakkinen <jarkko@kernel.org>
To:     Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
Cc:     Peter Huewe <peterhuewe@gmx.de>, Jason Gunthorpe <jgg@ziepe.ca>,
        linux-integrity@vger.kernel.org, kernel@pengutronix.de
Subject: Re: [PATCH 0/3] tpm: Convert to platform remove callback returning
 void
Message-ID: <20230320134812.t5jyhyl4khlxdte6@kernel.org>
References: <20230320080607.306495-1-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230320080607.306495-1-u.kleine-koenig@pengutronix.de>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Mon, Mar 20, 2023 at 09:06:04AM +0100, Uwe Kleine-König wrote:
> Hello,
> 
> this series adapts the platform drivers below drivers/char/tpm to use the
> .remove_new() callback. Compared to the traditional .remove() callback
> .remove_new() returns no value. This is a good thing because the driver core
> doesn't (and cannot) cope for errors during remove. The only effect of a
> non-zero return value in .remove() is that the driver core emits a warning. The
> device is removed anyhow and an early return from .remove() usually yields a
> resource leak.
> 
> The drivers converted here returned zero in their remove callback, to the
> transformation was easy.
> 
> Best regards
> Uwe
> 
> Uwe Kleine-König (3):
>   tpm/tpm_ftpm_tee: Convert to platform remove callback returning void
>   tpm/tpm_tis: Convert to platform remove callback returning void
>   tpm/tpm_tis_synquacer: Convert to platform remove callback returning
>     void
> 
>  drivers/char/tpm/tpm_ftpm_tee.c      | 6 +++---
>  drivers/char/tpm/tpm_tis.c           | 6 ++----
>  drivers/char/tpm/tpm_tis_synquacer.c | 6 ++----
>  3 files changed, 7 insertions(+), 11 deletions(-)
> 
> base-commit: fe15c26ee26efa11741a7b632e9f23b01aca4cc6
> -- 
> 2.39.2
> 

To all:

Reviewed-by: Jarkko Sakkinen <jarkko@kernel.org>

BR, Jarkko
