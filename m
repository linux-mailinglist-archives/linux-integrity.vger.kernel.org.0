Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 02B727709D2
	for <lists+linux-integrity@lfdr.de>; Fri,  4 Aug 2023 22:35:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229597AbjHDUfw (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 4 Aug 2023 16:35:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229571AbjHDUfw (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 4 Aug 2023 16:35:52 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 192214C2D;
        Fri,  4 Aug 2023 13:35:51 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9E188620AE;
        Fri,  4 Aug 2023 20:35:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 494BFC433C7;
        Fri,  4 Aug 2023 20:35:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691181350;
        bh=/umkUltN7FGimsaVTr7qz1vfOQRH8k/3U2UDpA8Z288=;
        h=Date:Cc:Subject:From:To:References:In-Reply-To:From;
        b=U3deKzfOAr3MsAJoJhbzmWiGk+szMgMfKPvkPvH39ZuOo2gI/i6ElxUOUvtbG1ZpL
         gY+ZrMrOHU572Po6Ec8dvkED4qs9gB5wteZb7xY6clP9QuW39xfPenT7Wy7E3KVM2X
         ZSe24zSkIBg5kWqlwWxNUI9JFNx18pJP+VUJda7Jy8BlB12v3d1K7szzaFM7ZHKxJz
         EsNmU2HXmsZCMKySBtA+80IVgKFpSebTqJGMYunbXvYwS6rdUmWpgUWkN2Q/R10QeC
         quzfWu8Db7u/afzof9cCKaxQP1KKfSwE8a4ZT+se99Zk/xTcthYKrg78X4CtrbxbwL
         kXTmLExvKuXEA==
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date:   Fri, 04 Aug 2023 23:35:46 +0300
Message-Id: <CUK1R4XYQYE0.H9RI2VM350XF@wks-101042-mac.ad.tuni.fi>
Cc:     <peterhuewe@gmx.de>, <jgg@ziepe.ca>, <linux@dominikbrodowski.net>,
        <linux-integrity@vger.kernel.org>, <daniil.stas@posteo.net>,
        <bitlord0xff@gmail.com>, <stable@vger.kernel.org>
Subject: Re: [PATCH v2] tpm: Disable RNG for all AMD fTPMs
From:   "Jarkko Sakkinen" <jarkko@kernel.org>
To:     "Jason A. Donenfeld" <Jason@zx2c4.com>,
        "Mario Limonciello" <mario.limonciello@amd.com>
X-Mailer: aerc 0.15.2
References: <20230802122533.19508-1-mario.limonciello@amd.com>
 <ZMuvhEwN41qEhY9r@zx2c4.com>
In-Reply-To: <ZMuvhEwN41qEhY9r@zx2c4.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Thu Aug 3, 2023 at 4:45 PM EEST, Jason A. Donenfeld wrote:
> On Wed, Aug 02, 2023 at 07:25:33AM -0500, Mario Limonciello wrote:
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
> > Cc: stable@vger.kernel.org # 6.1.y+
> > Fixes: b006c439d58d ("hwrng: core - start hwrng kthread also for untrus=
ted sources")
> > Fixes: f1324bbc4011 ("tpm: disable hwrng for fTPM on some AMD designs")
>
> Users can trigger this by reading from /dev/hwrng, which some userspace
> daemons are known to do. So I think the proper fixes tag and stable@
> version range actually begins with whenever fTPM support was introduced.
>
> > Reported-by: daniil.stas@posteo.net
> > Closes: https://bugzilla.kernel.org/show_bug.cgi?id=3D217719
> > Reported-by: bitlord0xff@gmail.com
> > Closes: https://bugzilla.kernel.org/show_bug.cgi?id=3D217212
> > Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
>
> Hopefully future AMD hardware won't be broken and we can revisit this.
> Until then, LGTM:
>
> Reviewed-by: Jason A. Donenfeld <Jason@zx2c4.com>

Thanks. I'll add your tag.

BR, Jarkko

