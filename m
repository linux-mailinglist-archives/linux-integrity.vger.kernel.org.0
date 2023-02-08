Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A4CA368E616
	for <lists+linux-integrity@lfdr.de>; Wed,  8 Feb 2023 03:32:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230244AbjBHCcC (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 7 Feb 2023 21:32:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229527AbjBHCb7 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 7 Feb 2023 21:31:59 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D08422DE1;
        Tue,  7 Feb 2023 18:31:58 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id AAD0D6142E;
        Wed,  8 Feb 2023 02:31:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AAC34C4339C;
        Wed,  8 Feb 2023 02:31:56 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
        dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="f5+/J+WT"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
        t=1675823513;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=7hemVHJkzyEdMXCbMpFmzxQSbtTaU4nVB65VwzkWZIs=;
        b=f5+/J+WTqAOpJIqSYmAO0xLPutOrafSfnGry2TVpb98OIjeP3/+8/mKuVT+CUdGKvP05Z/
        WKqgKJSJn5ea/Ac9L6KMV+RCk8EZ7SveVkR6uZ2HuGXh1ZxIvdyoC2nPBxuiAqefJS4YNZ
        4K92R8jxEuZBpJidrhu04J6aiISzL2k=
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id a2edc6ba (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
        Wed, 8 Feb 2023 02:31:52 +0000 (UTC)
Received: by mail-ej1-f41.google.com with SMTP id gr7so47736786ejb.5;
        Tue, 07 Feb 2023 18:31:52 -0800 (PST)
X-Gm-Message-State: AO0yUKUrBX6LYDngtl5Ez1mqX8yny8zLlADWhWNft5/k6jnED7sHufvc
        vvoYSFp86Ze+qeTn+98LKtD8iS8C7syEgEs4RrM=
X-Google-Smtp-Source: AK7set8FqOcnj5YNRuRXgSkVmgG8iHzRDZ6CtsFJRJsR0dtMC7G7yD+8RwNIFtOT95Klvbkepy0hidZ4mGEMi6roTIE=
X-Received: by 2002:a17:906:e24c:b0:89c:7298:2de4 with SMTP id
 gq12-20020a170906e24c00b0089c72982de4mr1176679ejb.91.1675823510908; Tue, 07
 Feb 2023 18:31:50 -0800 (PST)
MIME-Version: 1.0
References: <3a196414-68d8-29c9-24cc-2b8cb4c9d358@leemhuis.info>
 <8a7775912f31394944b43db12adc78efd84b1fad.camel@HansenPartnership.com>
 <Y+MFNvr2deX7+Mxa@kernel.org> <Y+MFUZ7WD0rX2rU9@kernel.org>
In-Reply-To: <Y+MFUZ7WD0rX2rU9@kernel.org>
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
Date:   Tue, 7 Feb 2023 23:31:37 -0300
X-Gmail-Original-Message-ID: <CAHmME9pwT52maXyQMNutv6svgDxAaz3L4MDeq_KVDutOAe8uPw@mail.gmail.com>
Message-ID: <CAHmME9pwT52maXyQMNutv6svgDxAaz3L4MDeq_KVDutOAe8uPw@mail.gmail.com>
Subject: Re: [regression] Bug 216989 - since 6.1 systems with AMD Ryzen
 stutter when fTPM is enabled
To:     Jarkko Sakkinen <jarkko@kernel.org>
Cc:     James Bottomley <James.Bottomley@hansenpartnership.com>,
        Linux regressions mailing list <regressions@lists.linux.dev>,
        Peter Huewe <peterhuewe@gmx.de>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        linux-integrity@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>, reach622@mailcuk.com,
        1138267643@qq.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-4.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Tue, Feb 7, 2023 at 11:13 PM Jarkko Sakkinen <jarkko@kernel.org> wrote:
>
> On Wed, Feb 08, 2023 at 04:13:16AM +0200, Jarkko Sakkinen wrote:
> > On Thu, Feb 02, 2023 at 07:57:37AM -0500, James Bottomley wrote:
> > > On Thu, 2023-02-02 at 11:28 +0100, Linux kernel regression tracking
> > > (Thorsten Leemhuis) wrote:
> > > [...]
> > > > So it's a firmware problem, but apparently one that Linux only
> > > > triggers since 6.1.
> > > >
> > > > Jason, could the hwrng changes have anything to do with this?
> > > >
> > > > A bisection really would be helpful, but I guess that is not easy as
> > > > the problem apparently only shows up after some time...
> > >
> > > the problem description says the fTPM causes system stutter when it
> > > writes to NVRAM.  Since an fTPM is a proprietary implementation, we
> > > don't know what it does.  The ms TPM implementation definitely doesn't
> > > trigger NV writes on rng requests, but it is plausible this fTPM does
> > > ... particularly if they have a time based input to the DRNG.  Even if
> > > this speculation is true, there's not much we can do about it, since
> > > it's a firmware bug and AMD should have delivered the BIOS update that
> > > fixes it.
> > >
> > > The way to test this would be to set the config option
> > >
> > > CONFIG_HW_RANDOM_TPM=n
> > >
> > > and see if the stutter goes away.  I suppose if someone could quantify
> > > the bad bioses, we could warn, but that's about it.
> > >
> > > James
> > >
> >
> > And e.g. I do not have a Ryzen CPU so pretty hard to answer such question.
>
> ... about hwrng

Well, the options here are basically:

a) Do nothing, and just expect people to update their BIOSes, since an
update is available.
b) Do nothing, and expect people with broken BIOSes to `echo blacklist
tpm >> /etc/modprobesomethingsomething`.
c) Figure out how to identify the buggy BIOS and disable the TPM's rng
with a quirk in this case.
d) Figure out how to dynamically detect TPM rng latency, and warn about it.
e) Figure out how to dynamically detect TPM rng latency, and disable it.

I think given that a firmware update *is* available, (a) is fine. And
the generic workaround remains (b). But if you want to be really nice,
(c) would be fine too. Somebody with the affected hardware would
probably have to send in some DMI logs or whatever else. (d) and (e)
sound possible in theory but I dunno really... seems finicky.

Jason
