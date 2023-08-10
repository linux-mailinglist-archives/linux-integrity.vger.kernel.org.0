Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 72F98777B8E
	for <lists+linux-integrity@lfdr.de>; Thu, 10 Aug 2023 17:04:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233701AbjHJPEc (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 10 Aug 2023 11:04:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231825AbjHJPEc (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 10 Aug 2023 11:04:32 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55A8D26A0
        for <linux-integrity@vger.kernel.org>; Thu, 10 Aug 2023 08:04:31 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E743365F52
        for <linux-integrity@vger.kernel.org>; Thu, 10 Aug 2023 15:04:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 29F57C433C8;
        Thu, 10 Aug 2023 15:04:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691679870;
        bh=MYU+lmPZH4E3gBGpT3UYwmIYpYBLTxymHhnk4YGaU4M=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=To1MX1w9QarKjpzpQ6/jh+iGKPMyEaj4uvpG/Co8sj2GLBnWXtFf53HIcNtq8S7kp
         qtNqQCHOOWj1uzwAGdJvvdl1uawcDwctP9u5v6qnIaziuoBMJYDIRDM29X/4f2Z32q
         dFNhCGYvALPPcd3RmYS2IuZEecTkwE1LHk5Xh0l0rAY33yE292F/ygTMTW4El/JVf7
         /iTrB2CuyVV0Q8c/yR6B99x/sj3MuLrNrwobBFFcGuJCPrbLBcl+QSfPDEaCdIdn5W
         2fVc0Pc460dDjdW09m0OirarR8SO6ntgF0vL/d6xDeX4Y9rs+AaO8smcKlUOyWU3n/
         nc1ncLJJS6pNw==
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date:   Thu, 10 Aug 2023 18:04:24 +0300
Message-Id: <CUOYGPC4XQKO.2W3U1HO9W3X5L@wks-101042-mac.ad.tuni.fi>
From:   "Jarkko Sakkinen" <jarkko@kernel.org>
To:     "Mario Limonciello" <mario.limonciello@amd.com>,
        "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc:     <jgg@ziepe.ca>, <linux@dominikbrodowski.net>,
        <linux-integrity@vger.kernel.org>, <daniil.stas@posteo.net>,
        <peterhuewe@gmx.de>
Subject: Re: [PATCH v3] tpm: Disable RNG for all AMD fTPMs
X-Mailer: aerc 0.15.2
References: <20230803182428.25753-1-mario.limonciello@amd.com>
 <CUK4PB8J51W8.2NQ3CSI1HNLDR@wks-101042-mac.ad.tuni.fi>
 <6bfc61fb-6432-cb17-3312-53c6268e2a46@amd.com>
 <CUK5NKQKDAWO.2RCNF768IKZ9Q@wks-101042-mac.ad.tuni.fi>
 <ZNFv8f3r86zq3JSh@zx2c4.com> <f7f9be14-b5f6-4c2c-a4e3-8d44bfa4b36c@amd.com>
In-Reply-To: <f7f9be14-b5f6-4c2c-a4e3-8d44bfa4b36c@amd.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Tue Aug 8, 2023 at 3:15 AM EEST, Mario Limonciello wrote:
>
>
> On 8/7/23 17:28, Jason A. Donenfeld wrote:
> > On Sat, Aug 05, 2023 at 02:39:11AM +0300, Jarkko Sakkinen wrote:
> >> On Sat Aug 5, 2023 at 2:21 AM EEST, Mario Limonciello wrote:
> >>> On 8/4/23 17:54, Jarkko Sakkinen wrote:
> >>>> On Thu Aug 3, 2023 at 9:24 PM EEST, Mario Limonciello wrote:
> >>>>> The TPM RNG functionality is not necessary for entropy when the CPU
> >>>>> already supports the RDRAND instruction. The TPM RNG functionality
> >>>>> was previously disabled on a subset of AMD fTPM series, but reports
> >>>>> continue to show problems on some systems causing stutter root caus=
ed
> >>>>> to TPM RNG functionality.
> >>>>>
> >>>>> Expand disabling TPM RNG use for all AMD fTPMs whether they have ve=
rsions
> >>>>> that claim to have fixed or not. To accomplish this, move the detec=
tion
> >>>>> into part of the TPM CRB registration and add a flag indicating tha=
t
> >>>>> the TPM should opt-out of registration to hwrng.
> >>>>>
> >>>>> Cc: stable@vger.kernel.org # 5.5+
> >>>>> Fixes: b006c439d58d ("hwrng: core - start hwrng kthread also for un=
trusted sources")
> >>>>> Fixes: f1324bbc4011 ("tpm: disable hwrng for fTPM on some AMD desig=
ns")
> >>>>> Fixes: 3ef193822b25 ("tpm_crb: fix fTPM on AMD Zen+ CPUs")
> >>>>> Reported-by: daniil.stas@posteo.net
> >>>>> Closes: https://bugzilla.kernel.org/show_bug.cgi?id=3D217719
> >>>>> Reported-by: bitlord0xff@gmail.com
> >>>>> Closes: https://bugzilla.kernel.org/show_bug.cgi?id=3D217212
> >>>>> Reviewed-by: Jason A. Donenfeld <Jason@zx2c4.com>
> >>>>> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
> >>>>
> >>>> I will skip rc5 and send this for rc6 on Monday.
> >>>>
> >>>> Has anyone with suitable AMD system tested this?
> >>>
> >>> Probably obvious; but I tested with a system that can support both dT=
PM
> >>> and fTPM and swapped between the two before I sent it.
> >>
> >> Ok, great. I've tested that with non-AMD system things continue to
> >> work so I guess that is sufficient enough for:
> >>
> >> Tested-by: Jarkko Sakkinen <jarkko@kernel.org>
> >>
> >> BR, Jarkko
> >=20
> > Why is
> > https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/comm=
it/?id=3D554b841d470338a3b1d6335b14ee1cd0c8f5d754
> > in Linus' tree? After we told you on several email threads to take the
> > v3, and you said you would, you still took the v2? What are you doing?
> > I'm frustrated because this is not the first time you've been out
> > to lunch about this stuff. Now there's the wrong stable metadata and th=
e
> > fix is incomplete. Shame.
>
> I guess that means I need to re-send out the other fixup that was missed=
=20
> in v3 separately and with a new fixes tag against that hash that landed=
=20
> in Linus' tree?  Or Jarkko are you going to resolve the differences?

I can also revert the commit and apply the correct patch. Either
option works for me.

BR, Jarkko
