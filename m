Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F1A427732F6
	for <lists+linux-integrity@lfdr.de>; Tue,  8 Aug 2023 00:28:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229905AbjHGW2L (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 7 Aug 2023 18:28:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229468AbjHGW2K (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 7 Aug 2023 18:28:10 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7770B3
        for <linux-integrity@vger.kernel.org>; Mon,  7 Aug 2023 15:28:09 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 42824622D0
        for <linux-integrity@vger.kernel.org>; Mon,  7 Aug 2023 22:28:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B3F3AC433C8;
        Mon,  7 Aug 2023 22:28:07 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
        dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="EzDbz08+"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
        t=1691447284;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=i/sR6zlMsW212EFWtq0rbi0vsVh7IJymFItPS0OqlXA=;
        b=EzDbz08+qw9JSU37EQIbN5NJP6T6ybqwu4NWONrEMyrMNhA9u4BtDm2aPPsIqbf8KF3SaD
        2fUmebqW2MALvgYno1DiVjd5seH/+GzWrqcLGAU7C6Mj8UJ2k5g/zvwsMnpdRaZ7pnMxb2
        yP5WaW9qQNo09dR2/hYiej1wfE2CxN8=
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 73aa1093 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
        Mon, 7 Aug 2023 22:28:03 +0000 (UTC)
Date:   Tue, 8 Aug 2023 00:28:01 +0200
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
To:     Jarkko Sakkinen <jarkko@kernel.org>
Cc:     Mario Limonciello <mario.limonciello@amd.com>, jgg@ziepe.ca,
        linux@dominikbrodowski.net, linux-integrity@vger.kernel.org,
        daniil.stas@posteo.net, peterhuewe@gmx.de
Subject: Re: [PATCH v3] tpm: Disable RNG for all AMD fTPMs
Message-ID: <ZNFv8f3r86zq3JSh@zx2c4.com>
References: <20230803182428.25753-1-mario.limonciello@amd.com>
 <CUK4PB8J51W8.2NQ3CSI1HNLDR@wks-101042-mac.ad.tuni.fi>
 <6bfc61fb-6432-cb17-3312-53c6268e2a46@amd.com>
 <CUK5NKQKDAWO.2RCNF768IKZ9Q@wks-101042-mac.ad.tuni.fi>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CUK5NKQKDAWO.2RCNF768IKZ9Q@wks-101042-mac.ad.tuni.fi>
X-Spam-Status: No, score=-6.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Sat, Aug 05, 2023 at 02:39:11AM +0300, Jarkko Sakkinen wrote:
> On Sat Aug 5, 2023 at 2:21 AM EEST, Mario Limonciello wrote:
> > On 8/4/23 17:54, Jarkko Sakkinen wrote:
> > > On Thu Aug 3, 2023 at 9:24 PM EEST, Mario Limonciello wrote:
> > >> The TPM RNG functionality is not necessary for entropy when the CPU
> > >> already supports the RDRAND instruction. The TPM RNG functionality
> > >> was previously disabled on a subset of AMD fTPM series, but reports
> > >> continue to show problems on some systems causing stutter root caused
> > >> to TPM RNG functionality.
> > >>
> > >> Expand disabling TPM RNG use for all AMD fTPMs whether they have versions
> > >> that claim to have fixed or not. To accomplish this, move the detection
> > >> into part of the TPM CRB registration and add a flag indicating that
> > >> the TPM should opt-out of registration to hwrng.
> > >>
> > >> Cc: stable@vger.kernel.org # 5.5+
> > >> Fixes: b006c439d58d ("hwrng: core - start hwrng kthread also for untrusted sources")
> > >> Fixes: f1324bbc4011 ("tpm: disable hwrng for fTPM on some AMD designs")
> > >> Fixes: 3ef193822b25 ("tpm_crb: fix fTPM on AMD Zen+ CPUs")
> > >> Reported-by: daniil.stas@posteo.net
> > >> Closes: https://bugzilla.kernel.org/show_bug.cgi?id=217719
> > >> Reported-by: bitlord0xff@gmail.com
> > >> Closes: https://bugzilla.kernel.org/show_bug.cgi?id=217212
> > >> Reviewed-by: Jason A. Donenfeld <Jason@zx2c4.com>
> > >> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
> > > 
> > > I will skip rc5 and send this for rc6 on Monday.
> > > 
> > > Has anyone with suitable AMD system tested this?
> >
> > Probably obvious; but I tested with a system that can support both dTPM 
> > and fTPM and swapped between the two before I sent it.
> 
> Ok, great. I've tested that with non-AMD system things continue to
> work so I guess that is sufficient enough for:
> 
> Tested-by: Jarkko Sakkinen <jarkko@kernel.org>
> 
> BR, Jarkko

Why is
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=554b841d470338a3b1d6335b14ee1cd0c8f5d754
in Linus' tree? After we told you on several email threads to take the
v3, and you said you would, you still took the v2? What are you doing?
I'm frustrated because this is not the first time you've been out
to lunch about this stuff. Now there's the wrong stable metadata and the
fix is incomplete. Shame.
