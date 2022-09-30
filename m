Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7EFE75F13D6
	for <lists+linux-integrity@lfdr.de>; Fri, 30 Sep 2022 22:43:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230246AbiI3Und (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 30 Sep 2022 16:43:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232311AbiI3Un3 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 30 Sep 2022 16:43:29 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 598C91F44C8;
        Fri, 30 Sep 2022 13:43:28 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 0EBD9B82A15;
        Fri, 30 Sep 2022 20:43:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 58D5DC433D7;
        Fri, 30 Sep 2022 20:43:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1664570605;
        bh=z2RpGAIcRBWCb7IMQFBrYAdIp7GxRJ1+dBWwYERxUf4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=B+N4GxKeheFD5MJ9b7wxhRdCUXT8pP0l2H4sY7I/09wP6jR1CRIjv1CwJzJxnCniG
         Rl4XJTeSkiUdNovNP4JRFAoFuGOgrD3X2RGQDQ53fKkXGF/D6Uwq1shxO7H7vnm2Xa
         Q7EkoAK3QPwfC6+YF/3iy2mvH9gOn/4lh84elU5LbxRTyMhlLkXGwRHQf8F8Sg6PhG
         h6X7o4hyl32FtE18hlfIlDKo7xm2ZvVy1lDmlinuzcLS6va2hc18Bx8O570LKPGcKg
         9JUm4Ef3ru1sjynckt3GP9xh2S1qOf3hXUOacXwhsO2XoYxgQnw1dBKSTKtxciJLiV
         DOnFMVYlverhQ==
Date:   Fri, 30 Sep 2022 23:43:22 +0300
From:   Jarkko Sakkinen <jarkko@kernel.org>
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc:     Peter Huewe <peterhuewe@gmx.de>, Jason Gunthorpe <jgg@ziepe.ca>,
        linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/3] tpm: st33zp24: switch to using gpiod API
Message-ID: <YzdU6tpZaqSvVm5/@kernel.org>
References: <20220926053958.1541912-1-dmitry.torokhov@gmail.com>
 <20220926053958.1541912-2-dmitry.torokhov@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220926053958.1541912-2-dmitry.torokhov@gmail.com>
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Sun, Sep 25, 2022 at 10:39:57PM -0700, Dmitry Torokhov wrote:
> This patch switches the driver from legacy gpio API to the newer gpiod
> API, so that eventually we can drop the former.

Once a patch is applied, it's a commit, not a patch. Just start by
"Switch ...".

Please also define what is the legacy API exactly, and what sort of
API it is switched to with a bit more detail. I don't follow GPIO.

> During conversion it was noted that the gpio handling code for SPI and
> I2C variants duplicates each other, so it was moved into the core.

Who noted what? Please provide a reference. I do not connect this
sentence to anything, as I do not follow gpio's mailing list.

> Also, it seems that the driver never assigned tpm_dev->io_lpcpd in the
> past, so gpio-based power management was most likely not working ever.
> 
> Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>

BR, Jarkko
