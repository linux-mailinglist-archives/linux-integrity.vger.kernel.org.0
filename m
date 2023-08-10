Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 06709777BEB
	for <lists+linux-integrity@lfdr.de>; Thu, 10 Aug 2023 17:14:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229906AbjHJPOU (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 10 Aug 2023 11:14:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234259AbjHJPOT (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 10 Aug 2023 11:14:19 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9236D2694
        for <linux-integrity@vger.kernel.org>; Thu, 10 Aug 2023 08:14:17 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 304F664F04
        for <linux-integrity@vger.kernel.org>; Thu, 10 Aug 2023 15:14:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A889AC433C8;
        Thu, 10 Aug 2023 15:14:15 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
        dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="FozMdkmu"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
        t=1691680453;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=nacRYH/SMyVNzco8tP2Y2i0fCxofzp/Fhz7PN+PPY/o=;
        b=FozMdkmuCmKyL5YsERQbwaqe2KGm9Bncqof2z3rv1QCb4sxkxQwBwj64a4/C2bwl9d4ceI
        PLMoP6jqz7/lovvV9LknCOwI6yi3WV5cKBwNroYABhWKFekkpzJY44NO30Hn1LBfNVxeRf
        qt/kgIR1d9+HzufBEymarZtgdrmNLJ4=
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 9066df54 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
        Thu, 10 Aug 2023 15:14:11 +0000 (UTC)
Date:   Thu, 10 Aug 2023 17:14:10 +0200
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
To:     Jarkko Sakkinen <jarkko@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Mario Limonciello <mario.limonciello@amd.com>, jgg@ziepe.ca,
        linux@dominikbrodowski.net, linux-integrity@vger.kernel.org,
        daniil.stas@posteo.net, peterhuewe@gmx.de
Subject: Re: [PATCH v3] tpm: Disable RNG for all AMD fTPMs
Message-ID: <ZNT+wvrX/hywsA4M@zx2c4.com>
References: <20230803182428.25753-1-mario.limonciello@amd.com>
 <CUK4PB8J51W8.2NQ3CSI1HNLDR@wks-101042-mac.ad.tuni.fi>
 <6bfc61fb-6432-cb17-3312-53c6268e2a46@amd.com>
 <CUK5NKQKDAWO.2RCNF768IKZ9Q@wks-101042-mac.ad.tuni.fi>
 <ZNFv8f3r86zq3JSh@zx2c4.com>
 <f7f9be14-b5f6-4c2c-a4e3-8d44bfa4b36c@amd.com>
 <ZNGOpFbH43qQ/v5T@zx2c4.com>
 <CAHk-=whT2hf5f6SwK32J4cF2Yu+q9SZaO6JZVzBOsLz63uPW1w@mail.gmail.com>
 <CUOYIJAA5HYW.2I8CO5JXZV6NN@wks-101042-mac.ad.tuni.fi>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CUOYIJAA5HYW.2I8CO5JXZV6NN@wks-101042-mac.ad.tuni.fi>
X-Spam-Status: No, score=-6.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Thu, Aug 10, 2023 at 06:06:48PM +0300, Jarkko Sakkinen wrote:
> On Tue Aug 8, 2023 at 6:26 AM EEST, Linus Torvalds wrote:
> > On Mon, 7 Aug 2023 at 17:39, Jason A. Donenfeld <Jason@zx2c4.com> wrote:
> > >
> > > I'm not sure what's best or what Linus prefers. Linus - Jarkko sent you
> > > the wrong version patch. Do you want a fixup patch that accounts for the
> > > difference, and then I'll address the stable@ metadata deficiency
> > > manually by talking to Greg, or would you rather some merge commit
> > > magic, or something else?
> >
> > Either works for me, whatever ends up being easiest.
> >
> > However, looking at that v3 patch, that "should we enable/disable the
> > hwrng" is now repeated *three* times, and that first one is
> >
> >   if (!IS_ENABLED(CONFIG_HW_RANDOM_TPM) || tpm_is_firmware_upgrade(chip) ||
> > -     tpm_amd_is_rng_defective(chip))
> > +     chip->flags & TPM_CHIP_FLAG_HWRNG_DISABLED)
> >
> > and wants fixing anyway: you want parenthesis around the '&'.
> >
> > Yes, yes, it works (because bitwise ops have higher precedence than
> > logical ones), but let's not do that.
> >
> > But more importantly, can we just have a single helper inline function
> > for this and *not* repeat the same multi-line expression three times
> > (just in negated and then 2x non-negated format)?
> >
> > That test is ugly anyway. Why is "tpm_is_firmware_upgrade()" a wrapper
> > function around testing "chip->flags", but then right next to it it
> > tests them explicitly.
> >
> > So if we have to re-do this all, let's re-do it properly. Ok?
> >
> > Thinking about it, I do guess that makes it easier to just send an
> > incremental patch on top.
> >
> >               Linus
> 
> What if I just revert the commit, apply the correct one, and send a PR?

No, stop, please. We have it sorted already. There's a thread with Greg
now about the stable backport you can weigh in on, though. Please just
read all your emails from the last week, and then it'll be clear what's
up. Do that catchup before taking further actions, please.

Jason
