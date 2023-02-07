Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 381F868E34B
	for <lists+linux-integrity@lfdr.de>; Tue,  7 Feb 2023 23:14:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229589AbjBGWN6 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 7 Feb 2023 17:13:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229509AbjBGWN6 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 7 Feb 2023 17:13:58 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24C4F30DB;
        Tue,  7 Feb 2023 14:13:57 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id D3DFBB81B2D;
        Tue,  7 Feb 2023 22:13:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 45636C433D2;
        Tue,  7 Feb 2023 22:13:53 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
        dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="OjCtxsH3"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
        t=1675808031;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=AsXc4HhN7TWogGt7Om1RG7NJW43dHss1OJZYQK3mz/Q=;
        b=OjCtxsH3uiPIpo8vgqQvzzRGNNQQIHqw21tve2NKJAKjLnTXG3P96aPJ/gWygDnw4/OFwP
        wfAwBI1Qiv4wGdak5U8n8xsqiKSwGxPZMctOBGqZm8p4F6Byxoioel9ZEFb0EtKIM+lWkR
        FuEb1z/D3nqF+AIWTVXoBu56/9ykfE0=
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 326e6301 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
        Tue, 7 Feb 2023 22:13:51 +0000 (UTC)
Date:   Tue, 7 Feb 2023 19:13:46 -0300
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
To:     Linux regressions mailing list <regressions@lists.linux.dev>
Cc:     Dominik Brodowski <linux@dominikbrodowski.net>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        linux-integrity@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>, reach622@mailcuk.com,
        1138267643@qq.com, Jarkko Sakkinen <jarkko@kernel.org>,
        Peter Huewe <peterhuewe@gmx.de>, Jason Gunthorpe <jgg@ziepe.ca>
Subject: Re: [regression] Bug 216989 - since 6.1 systems with AMD Ryzen
 stutter when fTPM is enabled
Message-ID: <Y+LNGrA5llMxJNCU@zx2c4.com>
References: <3a196414-68d8-29c9-24cc-2b8cb4c9d358@leemhuis.info>
 <1c04756b-574b-210d-9580-a4de2aa16a20@leemhuis.info>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1c04756b-574b-210d-9580-a4de2aa16a20@leemhuis.info>
X-Spam-Status: No, score=-4.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Sun, Feb 05, 2023 at 06:38:16PM +0100, Linux kernel regression tracking (Thorsten Leemhuis) wrote:
> [ccing Dominik (who authored the culprit) and Herbert (who merged it)]
> 
> On 02.02.23 11:28, Linux kernel regression tracking (Thorsten Leemhuis)
> wrote:
> > 
> > I noticed a regression report in bugzilla.kernel.org. As many (most?)
> > kernel developer don't keep an eye on it, I decided to forward it by
> > mail. Quoting from https://bugzilla.kernel.org/show_bug.cgi?id=216989 :
> 
> Turns out according to a bisection from one of the reporters that
> b006c439d58d ("hwrng: core - start hwrng kthread also for untrusted
> sources") (merged for 6.1) apparently makes this hardware issue occur
> quicker/more frequently a lot quicker on any board that didn't get the
> firmware update yet. So it could be argued that from the point of the
> kernel it *might* be considered a regression.

Finally replying without HTML, now that I'm at my laptop.

This isn't a bug with the commit you mentioned. Rather, this is a bug in
the TPM hardware and/or in the TPM driver. Probably the TPM driver
should quirk around the faulty BIOS to disable whatever functionality is
broken, or it should notice these latency spikes and warn, or something.
But I'll leave that to James; that's his wheelhouse.

Jason
