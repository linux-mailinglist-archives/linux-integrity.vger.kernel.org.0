Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B74BF770C35
	for <lists+linux-integrity@lfdr.de>; Sat,  5 Aug 2023 01:06:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229452AbjHDXGR (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 4 Aug 2023 19:06:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229679AbjHDXGR (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 4 Aug 2023 19:06:17 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7DE0346B3
        for <linux-integrity@vger.kernel.org>; Fri,  4 Aug 2023 16:06:16 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 17D406215E
        for <linux-integrity@vger.kernel.org>; Fri,  4 Aug 2023 23:06:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0CA58C433C8;
        Fri,  4 Aug 2023 23:06:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691190375;
        bh=k7+HwmFRvIuSyZU4GWREudOZRUREPyHI3mAIEpqClTk=;
        h=Date:Cc:Subject:From:To:References:In-Reply-To:From;
        b=lvkwpx7hfAT2h/0FYp0Gl+9ELU8C62a+4EWS9/O8N2RyOM6fqFar0QzqnJNOg6KRY
         wlb6lV7VNfUPdhEaVSpdtJiDwor0tgiQyXHAAZ+K6IIMufvK9Hv+GBwCuXna4wySiw
         lC8pjtk1Y9F5HOHuK+75V72y7wXm2XEKnL6ZRbKZRHMuAEfmk52bCmcToRrsjt0Lwt
         NfbZtldMsKUnRdooJg4JNZX7r4gqLl4YBx3of3io+5gHQviBY3c+6XXhQEsEKzi8Wo
         AKZShpxeeoT7Kj6cZPXk3g8q/jvJuV5rw2YeegbqOBvAPIKBvSoqOdb2uSVA8FauWU
         jS4XGt8b0VOrA==
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date:   Sat, 05 Aug 2023 02:06:11 +0300
Message-Id: <CUK4YBBCU7P4.1QJZJYJNFR9G6@wks-101042-mac.ad.tuni.fi>
Cc:     <jgg@ziepe.ca>, <linux@dominikbrodowski.net>,
        <linux-integrity@vger.kernel.org>, <daniil.stas@posteo.net>,
        <peterhuewe@gmx.de>
Subject: Re: [PATCH v3] tpm: Disable RNG for all AMD fTPMs
From:   "Jarkko Sakkinen" <jarkko@kernel.org>
To:     "Jason A. Donenfeld" <Jason@zx2c4.com>,
        "Mario Limonciello" <mario.limonciello@amd.com>
X-Mailer: aerc 0.15.2
References: <20230803182428.25753-1-mario.limonciello@amd.com>
 <ZMz879q9fXcJ1X46@zx2c4.com>
In-Reply-To: <ZMz879q9fXcJ1X46@zx2c4.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Fri Aug 4, 2023 at 4:28 PM EEST, Jason A. Donenfeld wrote:
> On Thu, Aug 03, 2023 at 01:24:28PM -0500, Mario Limonciello wrote:
> > The TPM RNG functionality is not necessary for entropy when the CPU
> > already supports the RDRAND instruction. The TPM RNG functionality
> > was previously disabled on a subset of AMD fTPM series, but reports
> > continue to show problems on some systems causing stutter root caused
> > to TPM RNG functionality.
> >=20
> > Expand disabling TPM RNG use for all AMD fTPMs whether they have versio=
ns
> > that claim to have fixed or not. To accomplish this, move the detection
> > into part of the TPM CRB registration and add a flag indicating that
> > the TPM should opt-out of registration to hwrng.
> >=20
> > Cc: stable@vger.kernel.org # 5.5+
> > Fixes: b006c439d58d ("hwrng: core - start hwrng kthread also for untrus=
ted sources")
> > Fixes: f1324bbc4011 ("tpm: disable hwrng for fTPM on some AMD designs")
> > Fixes: 3ef193822b25 ("tpm_crb: fix fTPM on AMD Zen+ CPUs")
> > Reported-by: daniil.stas@posteo.net
> > Closes: https://bugzilla.kernel.org/show_bug.cgi?id=3D217719
> > Reported-by: bitlord0xff@gmail.com
> > Closes: https://bugzilla.kernel.org/show_bug.cgi?id=3D217212
> > Reviewed-by: Jason A. Donenfeld <Jason@zx2c4.com>
> > Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
>
> LGTM. Jarkko - can you replace the commit in your staging tree with this
> one?

I'll replace either during weekend or Monday and send the PR for rc6.

BR, Jarkko
