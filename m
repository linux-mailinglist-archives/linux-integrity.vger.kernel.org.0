Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 37C9E68E5F1
	for <lists+linux-integrity@lfdr.de>; Wed,  8 Feb 2023 03:14:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230140AbjBHCOR (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 7 Feb 2023 21:14:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229515AbjBHCOP (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 7 Feb 2023 21:14:15 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E28A04239;
        Tue,  7 Feb 2023 18:14:14 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 80F29B81B9B;
        Wed,  8 Feb 2023 02:13:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4ACC4C433D2;
        Wed,  8 Feb 2023 02:13:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1675822422;
        bh=IhRBeyuYL488qr864dxJ1oNRp7re0q54OfLRPrSxCoQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=PHk4nFknYsAnnNj7wn/TP66n0JmKZ3kbxy4Va23PJRplNGsiM1Bwkit7K0D+Ljf59
         XiYTq8nxTZamdk2xqnusitCZLYzO15p2eHiQmKnJel/aT1Vg6reGXwGA/UhRMkJ78K
         z6CxRO9idBZlThxTad7+UPxaW0C7hrEscu39ww6Crvu/Bnm7ku8wKdCWk0Vy9x380b
         1mIbhs2vbmdpIh3ESktYk4yVgHLQqDv551T6+8pJ9+W4CbCtc/ouFwJf+O6nmbYqRB
         SQMCICBolELO17zB5fCN+6hUKOg4Ye5TdZrIrGtOfGvrhc3CWlxj9Kx28kwusziVoq
         BU/cn8hLJwKag==
Date:   Wed, 8 Feb 2023 04:13:37 +0200
From:   Jarkko Sakkinen <jarkko@kernel.org>
To:     James Bottomley <James.Bottomley@HansenPartnership.com>
Cc:     Linux regressions mailing list <regressions@lists.linux.dev>,
        Peter Huewe <peterhuewe@gmx.de>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        linux-integrity@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>, reach622@mailcuk.com,
        1138267643@qq.com, "Jason A. Donenfeld" <Jason@zx2c4.com>
Subject: Re: [regression] Bug 216989 - since 6.1 systems with AMD Ryzen
 stutter when fTPM is enabled
Message-ID: <Y+MFUZ7WD0rX2rU9@kernel.org>
References: <3a196414-68d8-29c9-24cc-2b8cb4c9d358@leemhuis.info>
 <8a7775912f31394944b43db12adc78efd84b1fad.camel@HansenPartnership.com>
 <Y+MFNvr2deX7+Mxa@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y+MFNvr2deX7+Mxa@kernel.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Wed, Feb 08, 2023 at 04:13:16AM +0200, Jarkko Sakkinen wrote:
> On Thu, Feb 02, 2023 at 07:57:37AM -0500, James Bottomley wrote:
> > On Thu, 2023-02-02 at 11:28 +0100, Linux kernel regression tracking
> > (Thorsten Leemhuis) wrote:
> > [...]
> > > So it's a firmware problem, but apparently one that Linux only
> > > triggers since 6.1.
> > > 
> > > Jason, could the hwrng changes have anything to do with this?
> > > 
> > > A bisection really would be helpful, but I guess that is not easy as
> > > the problem apparently only shows up after some time...
> > 
> > the problem description says the fTPM causes system stutter when it
> > writes to NVRAM.  Since an fTPM is a proprietary implementation, we
> > don't know what it does.  The ms TPM implementation definitely doesn't
> > trigger NV writes on rng requests, but it is plausible this fTPM does
> > ... particularly if they have a time based input to the DRNG.  Even if
> > this speculation is true, there's not much we can do about it, since
> > it's a firmware bug and AMD should have delivered the BIOS update that
> > fixes it.
> > 
> > The way to test this would be to set the config option
> > 
> > CONFIG_HW_RANDOM_TPM=n
> > 
> > and see if the stutter goes away.  I suppose if someone could quantify
> > the bad bioses, we could warn, but that's about it.
> > 
> > James
> > 
> 
> And e.g. I do not have a Ryzen CPU so pretty hard to answer such question.

... about hwrng

BR, Jarkko
