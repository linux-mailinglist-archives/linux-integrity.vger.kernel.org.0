Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 85C90774542
	for <lists+linux-integrity@lfdr.de>; Tue,  8 Aug 2023 20:39:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232571AbjHHSjk (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 8 Aug 2023 14:39:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232584AbjHHSjQ (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 8 Aug 2023 14:39:16 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2305E74AD7
        for <linux-integrity@vger.kernel.org>; Tue,  8 Aug 2023 10:19:37 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 57CA36287B
        for <linux-integrity@vger.kernel.org>; Tue,  8 Aug 2023 17:19:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CBE4CC433C7;
        Tue,  8 Aug 2023 17:19:34 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
        dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="LS9DmS3/"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
        t=1691515171;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=KWJ+tL6fXfn5mmcmnGToTc8ffpsUrrpqjM5IOZKSx7M=;
        b=LS9DmS3/m6PEzq1iXd2bwraXeWUuQuQ9zvwBR6Wk50MIWW2k3SVzcI/Z74XwGuSSIhqMaC
        IyCYbLd/JtAZVN/tM2CF25nwcnkMdxSTjk6hM3QDA8Eg9ajGHu4PcuV/v7vwq+LkzRCGFn
        nPXV2OR7BpGMp79hqbsSnGApwFAzJ3A=
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 23fbef99 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
        Tue, 8 Aug 2023 17:19:31 +0000 (UTC)
Date:   Tue, 8 Aug 2023 19:19:29 +0200
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Mario Limonciello <mario.limonciello@amd.com>,
        Jarkko Sakkinen <jarkko@kernel.org>, jgg@ziepe.ca,
        linux@dominikbrodowski.net, linux-integrity@vger.kernel.org,
        daniil.stas@posteo.net, peterhuewe@gmx.de
Subject: Re: [PATCH v3] tpm: Disable RNG for all AMD fTPMs
Message-ID: <ZNJ5IZjpOdOBFFja@zx2c4.com>
References: <20230803182428.25753-1-mario.limonciello@amd.com>
 <CUK4PB8J51W8.2NQ3CSI1HNLDR@wks-101042-mac.ad.tuni.fi>
 <6bfc61fb-6432-cb17-3312-53c6268e2a46@amd.com>
 <CUK5NKQKDAWO.2RCNF768IKZ9Q@wks-101042-mac.ad.tuni.fi>
 <ZNFv8f3r86zq3JSh@zx2c4.com>
 <f7f9be14-b5f6-4c2c-a4e3-8d44bfa4b36c@amd.com>
 <ZNGOpFbH43qQ/v5T@zx2c4.com>
 <CAHk-=whT2hf5f6SwK32J4cF2Yu+q9SZaO6JZVzBOsLz63uPW1w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAHk-=whT2hf5f6SwK32J4cF2Yu+q9SZaO6JZVzBOsLz63uPW1w@mail.gmail.com>
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Mon, Aug 07, 2023 at 08:26:03PM -0700, Linus Torvalds wrote:
> On Mon, 7 Aug 2023 at 17:39, Jason A. Donenfeld <Jason@zx2c4.com> wrote:
> >
> > I'm not sure what's best or what Linus prefers. Linus - Jarkko sent you
> > the wrong version patch. Do you want a fixup patch that accounts for the
> > difference, and then I'll address the stable@ metadata deficiency
> > manually by talking to Greg, or would you rather some merge commit
> > magic, or something else?
> 
> Either works for me, whatever ends up being easiest.
> 
> However, looking at that v3 patch, that "should we enable/disable the
> hwrng" is now repeated *three* times, and that first one is
> 
>   if (!IS_ENABLED(CONFIG_HW_RANDOM_TPM) || tpm_is_firmware_upgrade(chip) ||
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

Alright, looks like Mario took care of that:
https://lore.kernel.org/all/20230808041229.22514-1-mario.limonciello@amd.com/
Once this is in your tree I'll ping Greg about the right stable versions
to make up for the wrong tag.

Jason
