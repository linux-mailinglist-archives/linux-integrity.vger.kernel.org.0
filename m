Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C9BD777BA4
	for <lists+linux-integrity@lfdr.de>; Thu, 10 Aug 2023 17:07:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235999AbjHJPG4 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 10 Aug 2023 11:06:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235280AbjHJPGz (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 10 Aug 2023 11:06:55 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74BCC2686
        for <linux-integrity@vger.kernel.org>; Thu, 10 Aug 2023 08:06:55 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 12CD765F85
        for <linux-integrity@vger.kernel.org>; Thu, 10 Aug 2023 15:06:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B67B8C43142;
        Thu, 10 Aug 2023 15:06:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691680014;
        bh=ZD8Ufxw8XwmX6SWKtS8MYa/pbJQAg17BQKY7tiPVRic=;
        h=Date:Cc:Subject:From:To:References:In-Reply-To:From;
        b=A+EWRydmGGbQ2f78NgEv+G7at2GB56POV3+20aqAN+HxP9AlsXXAROxH9DP4fDhKv
         3cfHV1We7ZrLOyGs2mOHbUMeD10ddzm2vwNrpB9PXu0Az0B0PgOVP4uAnL33WtocYW
         yEBs4gjfcqzkU7LHuvlfUZRckmXRwKn87kNG5JTWyVsrw6/zTuwri8oyVnuBnoeK1H
         KfnfKtDXMuwYK2UpDHQO0WVBqMJUKQn7i26QfZ1RtnqOCxW70RXnMEUTBCVaHy1+Aa
         g+MnxMHrnZ4/BcIEa3fnJoZT7GDEGIsXijTX1fTD+8hnIYoYZYZqkvHjb+elDPkhSQ
         MKw0v8g8cuBgQ==
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date:   Thu, 10 Aug 2023 18:06:48 +0300
Message-Id: <CUOYIJAA5HYW.2I8CO5JXZV6NN@wks-101042-mac.ad.tuni.fi>
Cc:     "Mario Limonciello" <mario.limonciello@amd.com>, <jgg@ziepe.ca>,
        <linux@dominikbrodowski.net>, <linux-integrity@vger.kernel.org>,
        <daniil.stas@posteo.net>, <peterhuewe@gmx.de>
Subject: Re: [PATCH v3] tpm: Disable RNG for all AMD fTPMs
From:   "Jarkko Sakkinen" <jarkko@kernel.org>
To:     "Linus Torvalds" <torvalds@linux-foundation.org>,
        "Jason A. Donenfeld" <Jason@zx2c4.com>
X-Mailer: aerc 0.15.2
References: <20230803182428.25753-1-mario.limonciello@amd.com>
 <CUK4PB8J51W8.2NQ3CSI1HNLDR@wks-101042-mac.ad.tuni.fi>
 <6bfc61fb-6432-cb17-3312-53c6268e2a46@amd.com>
 <CUK5NKQKDAWO.2RCNF768IKZ9Q@wks-101042-mac.ad.tuni.fi>
 <ZNFv8f3r86zq3JSh@zx2c4.com> <f7f9be14-b5f6-4c2c-a4e3-8d44bfa4b36c@amd.com>
 <ZNGOpFbH43qQ/v5T@zx2c4.com>
 <CAHk-=whT2hf5f6SwK32J4cF2Yu+q9SZaO6JZVzBOsLz63uPW1w@mail.gmail.com>
In-Reply-To: <CAHk-=whT2hf5f6SwK32J4cF2Yu+q9SZaO6JZVzBOsLz63uPW1w@mail.gmail.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Tue Aug 8, 2023 at 6:26 AM EEST, Linus Torvalds wrote:
> On Mon, 7 Aug 2023 at 17:39, Jason A. Donenfeld <Jason@zx2c4.com> wrote:
> >
> > I'm not sure what's best or what Linus prefers. Linus - Jarkko sent you
> > the wrong version patch. Do you want a fixup patch that accounts for th=
e
> > difference, and then I'll address the stable@ metadata deficiency
> > manually by talking to Greg, or would you rather some merge commit
> > magic, or something else?
>
> Either works for me, whatever ends up being easiest.
>
> However, looking at that v3 patch, that "should we enable/disable the
> hwrng" is now repeated *three* times, and that first one is
>
>   if (!IS_ENABLED(CONFIG_HW_RANDOM_TPM) || tpm_is_firmware_upgrade(chip) =
||
> -     tpm_amd_is_rng_defective(chip))
> +     chip->flags & TPM_CHIP_FLAG_HWRNG_DISABLED)
>
> and wants fixing anyway: you want parenthesis around the '&'.
>
> Yes, yes, it works (because bitwise ops have higher precedence than
> logical ones), but let's not do that.
>
> But more importantly, can we just have a single helper inline function
> for this and *not* repeat the same multi-line expression three times
> (just in negated and then 2x non-negated format)?
>
> That test is ugly anyway. Why is "tpm_is_firmware_upgrade()" a wrapper
> function around testing "chip->flags", but then right next to it it
> tests them explicitly.
>
> So if we have to re-do this all, let's re-do it properly. Ok?
>
> Thinking about it, I do guess that makes it easier to just send an
> incremental patch on top.
>
>               Linus

What if I just revert the commit, apply the correct one, and send a PR?

BR, Jarkko
