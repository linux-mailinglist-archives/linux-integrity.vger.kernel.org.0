Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ACE1168E5E9
	for <lists+linux-integrity@lfdr.de>; Wed,  8 Feb 2023 03:13:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229700AbjBHCNT (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 7 Feb 2023 21:13:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229550AbjBHCNS (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 7 Feb 2023 21:13:18 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EFA594239;
        Tue,  7 Feb 2023 18:13:16 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8AFCD61472;
        Wed,  8 Feb 2023 02:13:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F2B02C433EF;
        Wed,  8 Feb 2023 02:13:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1675822396;
        bh=xXBSsb5FEqcAlgGIMyh5F5YO4eMQXQObvbDjC2bGEB4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ocJJWqg321w6pAkKI50qL7MflUgnF4cC+bm1IgP+W42okgnpCLCNMcOXDBMc6KAnD
         sNzMDJ1uTZTAuXJmhbrnIUq7v5C+3/vrsOrDoxls1I/BZo5M0FEMK2mET/sYe3/ia0
         YTRqc7WC53YxZjhBsi56SA2XnEvngAjksZNGcoqEC0a/Re17jkvSiBwMeqC1H0cQ90
         kkSneToYXhNQQo1QccPaV8j7I9wNLlIcFVSHeLspwkKBFNx3UaB8D+jEBWwuPmaPbm
         i5S6U/E6P0cEFyfXVCWmI71zsSA2yA0rM0dmwHDjxUW++7nQBWzwOprQKhpMC1ShLL
         ArIm4Y4AusSNw==
Date:   Wed, 8 Feb 2023 04:13:10 +0200
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
Message-ID: <Y+MFNvr2deX7+Mxa@kernel.org>
References: <3a196414-68d8-29c9-24cc-2b8cb4c9d358@leemhuis.info>
 <8a7775912f31394944b43db12adc78efd84b1fad.camel@HansenPartnership.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8a7775912f31394944b43db12adc78efd84b1fad.camel@HansenPartnership.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Thu, Feb 02, 2023 at 07:57:37AM -0500, James Bottomley wrote:
> On Thu, 2023-02-02 at 11:28 +0100, Linux kernel regression tracking
> (Thorsten Leemhuis) wrote:
> [...]
> > So it's a firmware problem, but apparently one that Linux only
> > triggers since 6.1.
> > 
> > Jason, could the hwrng changes have anything to do with this?
> > 
> > A bisection really would be helpful, but I guess that is not easy as
> > the problem apparently only shows up after some time...
> 
> the problem description says the fTPM causes system stutter when it
> writes to NVRAM.  Since an fTPM is a proprietary implementation, we
> don't know what it does.  The ms TPM implementation definitely doesn't
> trigger NV writes on rng requests, but it is plausible this fTPM does
> ... particularly if they have a time based input to the DRNG.  Even if
> this speculation is true, there's not much we can do about it, since
> it's a firmware bug and AMD should have delivered the BIOS update that
> fixes it.
> 
> The way to test this would be to set the config option
> 
> CONFIG_HW_RANDOM_TPM=n
> 
> and see if the stutter goes away.  I suppose if someone could quantify
> the bad bioses, we could warn, but that's about it.
> 
> James
> 

And e.g. I do not have a Ryzen CPU so pretty hard to answer such question.

BR, Jarkko
