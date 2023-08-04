Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B0D6770C25
	for <lists+linux-integrity@lfdr.de>; Sat,  5 Aug 2023 00:54:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229476AbjHDWyd (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 4 Aug 2023 18:54:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbjHDWyc (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 4 Aug 2023 18:54:32 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3742611B
        for <linux-integrity@vger.kernel.org>; Fri,  4 Aug 2023 15:54:31 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C03BB6214C
        for <linux-integrity@vger.kernel.org>; Fri,  4 Aug 2023 22:54:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AFCB1C433C8;
        Fri,  4 Aug 2023 22:54:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691189670;
        bh=I1LWwL6PgPAAt6sTmBk0yMtdSe7CbSGk+Us9FeWDAwo=;
        h=Date:Cc:Subject:From:To:References:In-Reply-To:From;
        b=ox4oUh6mTnjXVTUdaFfQA9areZseRTnVCezUrQXvMosYrrqFmNRX2oHFqzyh/9Dmc
         xfvCSYGpVMp1CIBfAr94A3wTx7csgYrcnFQ7ilIvj8hMlyU6IdMU9tF7ssch/FiCLG
         1ByU5QPkjD1EsHG8tji70aQQUURz02V8Ys3M3rVz1sIh5k+yyrsqgsW0SGdZgjzslf
         ea8C/FnskjLkykXjkngH1/rgtDotnXg3F1jClOzn46sTlJrjIYFD2IcuLNRmSmWP8F
         4xHfkyX+OrPG81Ln5u6k5gBwA273/+Y1Mx4PCwmGjIYTn/l2whbWhNxqL4u2DPNBa9
         rJ442bXmNlGLw==
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date:   Sat, 05 Aug 2023 01:54:26 +0300
Message-Id: <CUK4PB8J51W8.2NQ3CSI1HNLDR@wks-101042-mac.ad.tuni.fi>
Cc:     "Jason A . Donenfeld" <Jason@zx2c4.com>, <jgg@ziepe.ca>,
        <linux@dominikbrodowski.net>, <linux-integrity@vger.kernel.org>,
        <daniil.stas@posteo.net>, <peterhuewe@gmx.de>
Subject: Re: [PATCH v3] tpm: Disable RNG for all AMD fTPMs
From:   "Jarkko Sakkinen" <jarkko@kernel.org>
To:     "Mario Limonciello" <mario.limonciello@amd.com>
X-Mailer: aerc 0.15.2
References: <20230803182428.25753-1-mario.limonciello@amd.com>
In-Reply-To: <20230803182428.25753-1-mario.limonciello@amd.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Thu Aug 3, 2023 at 9:24 PM EEST, Mario Limonciello wrote:
> The TPM RNG functionality is not necessary for entropy when the CPU
> already supports the RDRAND instruction. The TPM RNG functionality
> was previously disabled on a subset of AMD fTPM series, but reports
> continue to show problems on some systems causing stutter root caused
> to TPM RNG functionality.
>
> Expand disabling TPM RNG use for all AMD fTPMs whether they have versions
> that claim to have fixed or not. To accomplish this, move the detection
> into part of the TPM CRB registration and add a flag indicating that
> the TPM should opt-out of registration to hwrng.
>
> Cc: stable@vger.kernel.org # 5.5+
> Fixes: b006c439d58d ("hwrng: core - start hwrng kthread also for untruste=
d sources")
> Fixes: f1324bbc4011 ("tpm: disable hwrng for fTPM on some AMD designs")
> Fixes: 3ef193822b25 ("tpm_crb: fix fTPM on AMD Zen+ CPUs")
> Reported-by: daniil.stas@posteo.net
> Closes: https://bugzilla.kernel.org/show_bug.cgi?id=3D217719
> Reported-by: bitlord0xff@gmail.com
> Closes: https://bugzilla.kernel.org/show_bug.cgi?id=3D217212
> Reviewed-by: Jason A. Donenfeld <Jason@zx2c4.com>
> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>

I will skip rc5 and send this for rc6 on Monday.

Has anyone with suitable AMD system tested this?

BR, Jarkko
