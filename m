Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B7F04770C71
	for <lists+linux-integrity@lfdr.de>; Sat,  5 Aug 2023 01:39:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229455AbjHDXjR (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 4 Aug 2023 19:39:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229447AbjHDXjR (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 4 Aug 2023 19:39:17 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 435D83AAF
        for <linux-integrity@vger.kernel.org>; Fri,  4 Aug 2023 16:39:16 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C42316215B
        for <linux-integrity@vger.kernel.org>; Fri,  4 Aug 2023 23:39:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B11ABC433D9;
        Fri,  4 Aug 2023 23:39:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691192355;
        bh=/aVeRC4LW/JHqpULkxIc6DkQMWQgoQd+GRHaiwP7D70=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Cb9WIfwwrlDJzJc5T6iNKktKbaLgT3/aG/XfF6Xu8cHKVL+AOS1soF67c5nsGfIFz
         wGGxWGPscyoSLxay5nBA+a5a6W9EXTehpXq97uDqY4fneDmm+sK5RvBH6QyV5hR4jX
         Mil2mmEu5VPoUAYD1z2jLg0SLBWj3MB7dz7vRTc5NgUaJj0hmPDGyiBJsmRoWS9i/z
         vkHNVFwA44IkjL2hkrKXR/J7+mvbe591yJRsTr5mTU/Korf+DfeVisT5qSjq96JSbX
         7oPyHKPzFIGtrpyHPJkQGpuBXDWErTXQACCr7AxIfc3HP3Z+8hlRdUCVJe03sMGEP2
         nqUzVXJHXPw9w==
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date:   Sat, 05 Aug 2023 02:39:11 +0300
Message-Id: <CUK5NKQKDAWO.2RCNF768IKZ9Q@wks-101042-mac.ad.tuni.fi>
From:   "Jarkko Sakkinen" <jarkko@kernel.org>
To:     "Mario Limonciello" <mario.limonciello@amd.com>
Cc:     "Jason A . Donenfeld" <Jason@zx2c4.com>, <jgg@ziepe.ca>,
        <linux@dominikbrodowski.net>, <linux-integrity@vger.kernel.org>,
        <daniil.stas@posteo.net>, <peterhuewe@gmx.de>
Subject: Re: [PATCH v3] tpm: Disable RNG for all AMD fTPMs
X-Mailer: aerc 0.15.2
References: <20230803182428.25753-1-mario.limonciello@amd.com>
 <CUK4PB8J51W8.2NQ3CSI1HNLDR@wks-101042-mac.ad.tuni.fi>
 <6bfc61fb-6432-cb17-3312-53c6268e2a46@amd.com>
In-Reply-To: <6bfc61fb-6432-cb17-3312-53c6268e2a46@amd.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Sat Aug 5, 2023 at 2:21 AM EEST, Mario Limonciello wrote:
> On 8/4/23 17:54, Jarkko Sakkinen wrote:
> > On Thu Aug 3, 2023 at 9:24 PM EEST, Mario Limonciello wrote:
> >> The TPM RNG functionality is not necessary for entropy when the CPU
> >> already supports the RDRAND instruction. The TPM RNG functionality
> >> was previously disabled on a subset of AMD fTPM series, but reports
> >> continue to show problems on some systems causing stutter root caused
> >> to TPM RNG functionality.
> >>
> >> Expand disabling TPM RNG use for all AMD fTPMs whether they have versi=
ons
> >> that claim to have fixed or not. To accomplish this, move the detectio=
n
> >> into part of the TPM CRB registration and add a flag indicating that
> >> the TPM should opt-out of registration to hwrng.
> >>
> >> Cc: stable@vger.kernel.org # 5.5+
> >> Fixes: b006c439d58d ("hwrng: core - start hwrng kthread also for untru=
sted sources")
> >> Fixes: f1324bbc4011 ("tpm: disable hwrng for fTPM on some AMD designs"=
)
> >> Fixes: 3ef193822b25 ("tpm_crb: fix fTPM on AMD Zen+ CPUs")
> >> Reported-by: daniil.stas@posteo.net
> >> Closes: https://bugzilla.kernel.org/show_bug.cgi?id=3D217719
> >> Reported-by: bitlord0xff@gmail.com
> >> Closes: https://bugzilla.kernel.org/show_bug.cgi?id=3D217212
> >> Reviewed-by: Jason A. Donenfeld <Jason@zx2c4.com>
> >> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
> >=20
> > I will skip rc5 and send this for rc6 on Monday.
> >=20
> > Has anyone with suitable AMD system tested this?
>
> Probably obvious; but I tested with a system that can support both dTPM=
=20
> and fTPM and swapped between the two before I sent it.

Ok, great. I've tested that with non-AMD system things continue to
work so I guess that is sufficient enough for:

Tested-by: Jarkko Sakkinen <jarkko@kernel.org>

BR, Jarkko
