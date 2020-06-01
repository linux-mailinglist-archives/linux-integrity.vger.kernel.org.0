Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 374E41EB1F0
	for <lists+linux-integrity@lfdr.de>; Tue,  2 Jun 2020 00:54:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728507AbgFAWyS (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 1 Jun 2020 18:54:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728474AbgFAWyR (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 1 Jun 2020 18:54:17 -0400
Received: from mail-vs1-xe43.google.com (mail-vs1-xe43.google.com [IPv6:2607:f8b0:4864:20::e43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 815E2C05BD43
        for <linux-integrity@vger.kernel.org>; Mon,  1 Jun 2020 15:54:17 -0700 (PDT)
Received: by mail-vs1-xe43.google.com with SMTP id u7so936377vsp.7
        for <linux-integrity@vger.kernel.org>; Mon, 01 Jun 2020 15:54:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ahBMXlLUd844T91f3aGesWzPLvREUhRkr0Fgcws0YGs=;
        b=fE40P/GaA/oeYfZvFFTM420T8Kn7sVmkFjI7Qoy0bvihR4lmVHQUDbxoCW8m2JzSuj
         CYOn8agMAC73Y21kyw43VwgR2EToUMJXfHZ3OHfVQwIlMjT6c2ctwCKWkTS063a7GUxk
         +cnqb/McO2igW/hXGaTuSyE91w8VGgwOWJfbk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ahBMXlLUd844T91f3aGesWzPLvREUhRkr0Fgcws0YGs=;
        b=Ko+WUDItfF+rLBE1gHc9aGDMY3A4x/reWA7FU01T+qyd13LX2d66FpDzU2pPnKn4fM
         VcVwtiuAyZKVKdJ/Cay8JrUmPlhvZlAL98zryAuotAZUwX6mVHR7bjfrhk5G136V8COD
         40R8aF7P2iKL2yqJJ2eY18uLm6l6KH9y2HNUSp6amQvNFl31ag2rK/HTm4EA3RxNJeyD
         5k2N1+/19GJ6XKMRyjeZbRBy9xmkYdDcskIS2YszV0lafu7DSjWohVkh6htg7Df6X5PY
         ljj5PJQxQnEWmI8UegQ03CgYNXoQh4VhXg5Ru9MVt6qGtmg/ziaikcDGlZV+JX3oIn6h
         6ugg==
X-Gm-Message-State: AOAM533SB0GMTbkgGZ6AprMBUIxGvplrEMRm8b293oNbGEcrlG70Wt9z
        oOcOiczXiPua926Ss2QhQ2f8SORi2Q4=
X-Google-Smtp-Source: ABdhPJzJK94vjANq3Oya6bi1KXYSm6HDpHiUiVDPzXbV+/qKWe3Zg3/eh+K5/Y4Edt8vpQqvmmrDyQ==
X-Received: by 2002:a67:7d4b:: with SMTP id y72mr17542604vsc.59.1591052056309;
        Mon, 01 Jun 2020 15:54:16 -0700 (PDT)
Received: from mail-vs1-f46.google.com (mail-vs1-f46.google.com. [209.85.217.46])
        by smtp.gmail.com with ESMTPSA id c193sm149207vke.17.2020.06.01.15.54.15
        for <linux-integrity@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 01 Jun 2020 15:54:15 -0700 (PDT)
Received: by mail-vs1-f46.google.com with SMTP id k3so947391vsg.2
        for <linux-integrity@vger.kernel.org>; Mon, 01 Jun 2020 15:54:15 -0700 (PDT)
X-Received: by 2002:a67:1703:: with SMTP id 3mr16545948vsx.169.1591052054915;
 Mon, 01 Jun 2020 15:54:14 -0700 (PDT)
MIME-Version: 1.0
References: <20200528151912.1.Id689a39ce8d1ec6f29f4287277ad977ff4f57d7d@changeid>
 <20200601014646.GA794847@linux.intel.com>
In-Reply-To: <20200601014646.GA794847@linux.intel.com>
From:   Doug Anderson <dianders@chromium.org>
Date:   Mon, 1 Jun 2020 15:54:03 -0700
X-Gmail-Original-Message-ID: <CAD=FV=VaET7ZXE0f6ciKmE=p1R1DMF9jCue9_XAD4870byKGog@mail.gmail.com>
Message-ID: <CAD=FV=VaET7ZXE0f6ciKmE=p1R1DMF9jCue9_XAD4870byKGog@mail.gmail.com>
Subject: Re: [PATCH] tpm_tis_spi: Don't send anything during flow control
To:     Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Cc:     Peter Huewe <peterhuewe@gmx.de>,
        Andrey Pronin <apronin@chromium.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        linux-integrity@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Hi,

On Sun, May 31, 2020 at 6:47 PM Jarkko Sakkinen
<jarkko.sakkinen@linux.intel.com> wrote:
>
> On Thu, May 28, 2020 at 03:19:30PM -0700, Douglas Anderson wrote:
> > During flow control we are just reading from the TPM, yet our spi_xfer
> > has the tx_buf and rx_buf both non-NULL which means we're requesting a
> > full duplex transfer.
> >
> > SPI is always somewhat of a full duplex protocol anyway and in theory
> > the other side shouldn't really be looking at what we're sending it
> > during flow control, but it's still a bit ugly to be sending some
> > "random" data when we shouldn't.
> >
> > The default tpm_tis_spi_flow_control() tries to address this by
> > setting 'phy->iobuf[0] = 0'.  This partially avoids the problem of
> > sending "random" data, but since our tx_buf and rx_buf both point to
> > the same place I believe there is the potential of us sending the
> > TPM's previous byte back to it if we hit the retry loop.
> >
> > Another flow control implementation, cr50_spi_flow_control(), doesn't
> > address this at all.
> >
> > Let's clean this up and just make the tx_buf NULL before we call
> > flow_control().  Not only does this ensure that we're not sending any
> > "random" bytes but it also possibly could make the SPI controller
> > behave in a slightly more optimal way.
> >
> > NOTE: no actual observed problems are fixed by this patch--it's was
> > just made based on code inspection.
> >
> > Signed-off-by: Douglas Anderson <dianders@chromium.org>
> > ---
> >
> >  drivers/char/tpm/tpm_tis_spi_main.c | 9 ++++-----
> >  1 file changed, 4 insertions(+), 5 deletions(-)
> >
> > diff --git a/drivers/char/tpm/tpm_tis_spi_main.c b/drivers/char/tpm/tpm_tis_spi_main.c
> > index d96755935529..8d2c581a93c6 100644
> > --- a/drivers/char/tpm/tpm_tis_spi_main.c
> > +++ b/drivers/char/tpm/tpm_tis_spi_main.c
> > @@ -53,8 +53,6 @@ static int tpm_tis_spi_flow_control(struct tpm_tis_spi_phy *phy,
> >
> >       if ((phy->iobuf[3] & 0x01) == 0) {
> >               // handle SPI wait states
> > -             phy->iobuf[0] = 0;
> > -
>
> Why this should be removed?

As far as I can tell the only purpose of that was to make sure we were
sending 0.  Specifically "tx_buf" "rx_buf" both point to "phy->iobuf"
so setting the first byte to 0 here made sure that we weren't sending
out "random" data but were instead sending a 0.  After my change
"tx_buf" is NULL so we don't need to do this--the controller should
take charge of sending nothing on the lines (AKA sending a zero).

Does that answer your question, or were you worried about us needing
to init iobuf[0] to 0 in some other case?

-Doug
