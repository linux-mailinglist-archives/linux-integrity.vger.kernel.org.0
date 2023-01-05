Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5355165EFD1
	for <lists+linux-integrity@lfdr.de>; Thu,  5 Jan 2023 16:19:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229651AbjAEPSo (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 5 Jan 2023 10:18:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234421AbjAEPSP (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 5 Jan 2023 10:18:15 -0500
Received: from bedivere.hansenpartnership.com (bedivere.hansenpartnership.com [IPv6:2607:fcd0:100:8a00::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 121575C912;
        Thu,  5 Jan 2023 07:18:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
        d=hansenpartnership.com; s=20151216; t=1672931884;
        bh=SpKViO9KKGPQsDvTqPuWi6tYm/odcCiu/A949QhiGJ0=;
        h=Message-ID:Subject:From:To:Date:In-Reply-To:References:From;
        b=A2aIKmogTcyzNm7tjuP+lhTI3Gp+YPwcqoEOg2TP1fVpLMndKdaau7uVzbj+2ZBfI
         EBogZ6fwCmIS2kR9PjLE+GJZK6glENFoQloIshif5/NItnGKTdjlj5eqI/7LtqIN3P
         PftGPoyMSAbvcdZEL9RYdxkUWB8yMRn6Jpv/viMc=
Received: from localhost (localhost [127.0.0.1])
        by bedivere.hansenpartnership.com (Postfix) with ESMTP id 438571286048;
        Thu,  5 Jan 2023 10:18:04 -0500 (EST)
Received: from bedivere.hansenpartnership.com ([127.0.0.1])
        by localhost (bedivere.hansenpartnership.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id VTRp5QcrKI60; Thu,  5 Jan 2023 10:18:04 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
        d=hansenpartnership.com; s=20151216; t=1672931883;
        bh=SpKViO9KKGPQsDvTqPuWi6tYm/odcCiu/A949QhiGJ0=;
        h=Message-ID:Subject:From:To:Date:In-Reply-To:References:From;
        b=M1/zSBx8nbMV6uqcavEg8XMD/PmEJijFlvKEsjZoLhxtz5gKtIWcTos8g4nwaOrBj
         rIYCrvu+sbfcmELu6UWOLHb66Jwaob5iJ3pp2t9Z0I5GXbb9lgZo7GK32E4NhHVGpa
         lz75UgDjBt3EMqIdrmW5io7mQ0jcbKx1zG9liDrU=
Received: from lingrow.int.hansenpartnership.com (unknown [IPv6:2601:5c4:4302:c21::c14])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (prime256v1) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (Client did not present a certificate)
        by bedivere.hansenpartnership.com (Postfix) with ESMTPSA id 56F66128603E;
        Thu,  5 Jan 2023 10:17:59 -0500 (EST)
Message-ID: <2d07d185384ed444bef46648316354ef5afd481a.camel@HansenPartnership.com>
Subject: Re: [REGRESSION] suspend to ram fails in 6.2-rc1 due to tpm errors
From:   James Bottomley <James.Bottomley@HansenPartnership.com>
To:     Thorsten Leemhuis <regressions@leemhuis.info>
Cc:     Vlastimil Babka <vbabka@suse.cz>, Peter Huewe <peterhuewe@gmx.de>,
        Jarkko Sakkinen <jarkko@kernel.org>,
        Jason Gunthorpe <jgg@ziepe.ca>, Jan Dabros <jsd@semihalf.com>,
        regressions@lists.linux.dev, LKML <linux-kernel@vger.kernel.org>,
        linux-integrity@vger.kernel.org,
        Dominik Brodowski <linux@dominikbrodowski.net>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        "Jason A. Donenfeld" <Jason@zx2c4.com>,
        Johannes Altmanninger <aclopte@gmail.com>
Date:   Thu, 05 Jan 2023 10:17:57 -0500
In-Reply-To: <7ebab1ff-48f1-2737-f0d3-25c72666d041@leemhuis.info>
References: <7cbe96cf-e0b5-ba63-d1b4-f63d2e826efa@suse.cz>
         <c39cc02da9f60412a0f7f7772ef3d89e4a081d38.camel@HansenPartnership.com>
         <Y60RoP77HnwaukEA@zx2c4.com>
         <7ebab1ff-48f1-2737-f0d3-25c72666d041@leemhuis.info>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.4 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Thu, 2023-01-05 at 14:59 +0100, Thorsten Leemhuis wrote:
> On 29.12.22 05:03, Jason A. Donenfeld wrote:
> > On Wed, Dec 28, 2022 at 06:07:25PM -0500, James Bottomley wrote:
> > > On Wed, 2022-12-28 at 21:22 +0100, Vlastimil Babka wrote:
> > > > Ugh, while the problem [1] was fixed in 6.1, it's now happening
> > > > again on the T460 with 6.2-rc1. Except I didn't see any oops
> > > > message or "tpm_try_transmit" error this time. The first
> > > > indication of a problem is this during a resume from suspend to
> > > > ram:
> > > > 
> > > > tpm tpm0: A TPM error (28) occurred continue selftest
> > > > 
> > > > and then periodically 
> > > > 
> > > > tpm tpm0: A TPM error (28) occurred attempting get random
> > > 
> > > That's a TPM 1.2 error which means the TPM failed the selftest. 
> > > The original problem was reported against TPM 2.0  because of a
> > > missing try_get_ops().
> > 
> > No, I'm pretty sure the original bug, which was fixed by "char:
> > tpm: Protect tpm_pm_suspend with locks" regards 1.2 as well,
> > especially considering it's the same hardware from Vlastimil
> > causing this. I also recall seeing this in 1.2 when I ran this with
> > the TPM emulator. So that's not correct.
> 
> James, are you or some other TPM developer looking into this? Or is
> this deadlocked now?

Not really: TPM 1.2 way predates my interest in the TPM subsystem, and
I've only ever done patches to 2.0.  I can look at the paths
theoretically, but I don't have any hardware.  Self Test failures tend
to be hardware specific, so even poking around in the emulator is
unlikely to give what might be the cause.

>  And if so: how can we get this unstuck to get this regression
> solved?

One of the TPM maintainers with hardware (possibly the specific TPM ...
what is it, by the way?) needs to get involved.

James



