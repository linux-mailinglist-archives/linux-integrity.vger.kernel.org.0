Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9213D777B00
	for <lists+linux-integrity@lfdr.de>; Thu, 10 Aug 2023 16:42:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235850AbjHJOmL (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 10 Aug 2023 10:42:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235852AbjHJOmL (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 10 Aug 2023 10:42:11 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0469A2684
        for <linux-integrity@vger.kernel.org>; Thu, 10 Aug 2023 07:42:11 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7EDF265E8A
        for <linux-integrity@vger.kernel.org>; Thu, 10 Aug 2023 14:42:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E89B1C433C8;
        Thu, 10 Aug 2023 14:42:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691678529;
        bh=OK6vlVd6xU6azmmWGEYJG4G5MFuZW6y/SwvnTO7z14U=;
        h=Date:Cc:Subject:From:To:References:In-Reply-To:From;
        b=FQiJjq6UiD+XDUeiZhPyUJ+oEkhlUO7KNfIze/uNlnSCOl8PZ2vDCz2/hkxMD8Evf
         gIHLHHlFdJNT2cDx676XIVKnkdPR88djhdabq/6hAr6xuO4LYbC0W+xNd9O3ynvfGV
         7S7t/Yu14FHbqMnT8YXDdde2m3y3joOzP06yJkKTFpVf6FWRsPCdYMN/Tu/0odFj16
         adm1ZYf1vPFDLmbHY71o/ZaVvkm4Zmx9GHLWp7bdrNz0Fu/Re/ba+9HTR+5khx9Ryn
         qJIhgbA3548krXij+FeCUA5deUjDIT7sS4otzXWwpGq8HxTGQKA3F+E8U5kZH3qRVc
         18FzZoYmzPKLA==
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date:   Thu, 10 Aug 2023 17:42:02 +0300
Message-Id: <CUOXZKF7DMRC.2R0HUQYKOKLA6@wks-101042-mac.ad.tuni.fi>
Cc:     "Mario Limonciello" <mario.limonciello@amd.com>, <jgg@ziepe.ca>,
        <linux@dominikbrodowski.net>, <linux-integrity@vger.kernel.org>,
        <daniil.stas@posteo.net>, <peterhuewe@gmx.de>
Subject: Re: [PATCH v3] tpm: Disable RNG for all AMD fTPMs
From:   "Jarkko Sakkinen" <jarkko@kernel.org>
To:     "Jason A. Donenfeld" <Jason@zx2c4.com>
X-Mailer: aerc 0.15.2
References: <20230803182428.25753-1-mario.limonciello@amd.com>
 <CUK4PB8J51W8.2NQ3CSI1HNLDR@wks-101042-mac.ad.tuni.fi>
 <6bfc61fb-6432-cb17-3312-53c6268e2a46@amd.com>
 <CUK5NKQKDAWO.2RCNF768IKZ9Q@wks-101042-mac.ad.tuni.fi>
 <ZNFv8f3r86zq3JSh@zx2c4.com>
In-Reply-To: <ZNFv8f3r86zq3JSh@zx2c4.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Tue Aug 8, 2023 at 1:28 AM EEST, Jason A. Donenfeld wrote:
> On Sat, Aug 05, 2023 at 02:39:11AM +0300, Jarkko Sakkinen wrote:
> > On Sat Aug 5, 2023 at 2:21 AM EEST, Mario Limonciello wrote:
> > > On 8/4/23 17:54, Jarkko Sakkinen wrote:
> > > > On Thu Aug 3, 2023 at 9:24 PM EEST, Mario Limonciello wrote:
> > > >> The TPM RNG functionality is not necessary for entropy when the CP=
U
> > > >> already supports the RDRAND instruction. The TPM RNG functionality
> > > >> was previously disabled on a subset of AMD fTPM series, but report=
s
> > > >> continue to show problems on some systems causing stutter root cau=
sed
> > > >> to TPM RNG functionality.
> > > >>
> > > >> Expand disabling TPM RNG use for all AMD fTPMs whether they have v=
ersions
> > > >> that claim to have fixed or not. To accomplish this, move the dete=
ction
> > > >> into part of the TPM CRB registration and add a flag indicating th=
at
> > > >> the TPM should opt-out of registration to hwrng.
> > > >>
> > > >> Cc: stable@vger.kernel.org # 5.5+
> > > >> Fixes: b006c439d58d ("hwrng: core - start hwrng kthread also for u=
ntrusted sources")
> > > >> Fixes: f1324bbc4011 ("tpm: disable hwrng for fTPM on some AMD desi=
gns")
> > > >> Fixes: 3ef193822b25 ("tpm_crb: fix fTPM on AMD Zen+ CPUs")
> > > >> Reported-by: daniil.stas@posteo.net
> > > >> Closes: https://bugzilla.kernel.org/show_bug.cgi?id=3D217719
> > > >> Reported-by: bitlord0xff@gmail.com
> > > >> Closes: https://bugzilla.kernel.org/show_bug.cgi?id=3D217212
> > > >> Reviewed-by: Jason A. Donenfeld <Jason@zx2c4.com>
> > > >> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
> > > >=20
> > > > I will skip rc5 and send this for rc6 on Monday.
> > > >=20
> > > > Has anyone with suitable AMD system tested this?
> > >
> > > Probably obvious; but I tested with a system that can support both dT=
PM=20
> > > and fTPM and swapped between the two before I sent it.
> >=20
> > Ok, great. I've tested that with non-AMD system things continue to
> > work so I guess that is sufficient enough for:
> >=20
> > Tested-by: Jarkko Sakkinen <jarkko@kernel.org>
> >=20
> > BR, Jarkko
>
> Why is
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit=
/?id=3D554b841d470338a3b1d6335b14ee1cd0c8f5d754
> in Linus' tree? After we told you on several email threads to take the
> v3, and you said you would, you still took the v2? What are you doing?
> I'm frustrated because this is not the first time you've been out
> to lunch about this stuff. Now there's the wrong stable metadata and the
> fix is incomplete. Shame.

At least part of it must be transitioning from mutt to aerc but point
taken [1].

Should I revert the commit and send a PR with revert and the correct
patch?

[1] https://social.kernel.org/notice/AYOm9K4QULTHJMCN5E=20

BR, Jarkko
