Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 90C5412086A
	for <lists+linux-integrity@lfdr.de>; Mon, 16 Dec 2019 15:21:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728113AbfLPORs (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 16 Dec 2019 09:17:48 -0500
Received: from mail.kernel.org ([198.145.29.99]:37470 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727974AbfLPORr (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 16 Dec 2019 09:17:47 -0500
Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com [209.85.160.182])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B54202072B;
        Mon, 16 Dec 2019 14:17:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1576505866;
        bh=IQNavyKi0vrFitwEWkaIaMNA22XrAI9Jh2hXEfJH/S0=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=0UAzFff7wvUvbN58awlwQRh/zutRHMnzsFZ/J+0f6XS+7/84/k6W5/crv1KG05rHj
         xSPmTeMqSd/hxVbpfe4BS2z4en5pg9XCm1GD9o6NexACE0quInxp2lBpSFeNeBLcLo
         EZdEcXem8f1KOemOfxNOFGjwuFoSL3Iacll6YJzA=
Received: by mail-qt1-f182.google.com with SMTP id t17so5852562qtr.7;
        Mon, 16 Dec 2019 06:17:46 -0800 (PST)
X-Gm-Message-State: APjAAAXii65COQOmdKJ20nfOCpic2fR6OysbGL9QwIDpLfHD70oq+Bn/
        OsrFiGlRJq7XvN+SgjJQdmqbgh5tRXHPv9z7dQ==
X-Google-Smtp-Source: APXvYqz2f5Gs15/ox6X7o2WZBhM9ygGDGyp6eAHEdmJvScGaM+GL2FIGu82kDvhjbzebssozOwhOMq161rtPybRoLuw=
X-Received: by 2002:ac8:59:: with SMTP id i25mr24605834qtg.110.1576505865893;
 Mon, 16 Dec 2019 06:17:45 -0800 (PST)
MIME-Version: 1.0
References: <20191202133332.178110-1-amirmizi6@gmail.com> <20191202133332.178110-5-amirmizi6@gmail.com>
 <20191213223623.GA14809@bogus> <CAMHTsUW5dH-5LCW9GYzDnWEcqPt-Ch_21efQVpAKMdSvCXB00Q@mail.gmail.com>
In-Reply-To: <CAMHTsUW5dH-5LCW9GYzDnWEcqPt-Ch_21efQVpAKMdSvCXB00Q@mail.gmail.com>
From:   Rob Herring <robh@kernel.org>
Date:   Mon, 16 Dec 2019 08:17:34 -0600
X-Gmail-Original-Message-ID: <CAL_Jsq+7Wnh7pXBGtMZ=b2TD4zcY-8n-58OzrvCKx0Rc+1gpGw@mail.gmail.com>
Message-ID: <CAL_Jsq+7Wnh7pXBGtMZ=b2TD4zcY-8n-58OzrvCKx0Rc+1gpGw@mail.gmail.com>
Subject: Re: [PATCH v2 4/5] dt-bindings: tpm: Add YAML schema for TPM TIS I2C options
To:     Amir Mizinski <amirmizi6@gmail.com>
Cc:     Eyal.Cohen@nuvoton.com,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        Oshri Alkobi <oshrialkoby85@gmail.com>,
        Alexander Steffen <alexander.steffen@infineon.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Peter Huewe <peterhuewe@gmx.de>,
        Jason Gunthorpe <jgg@ziepe.ca>, Arnd Bergmann <arnd@arndb.de>,
        Greg KH <gregkh@linuxfoundation.org>,
        devicetree <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-integrity@vger.kernel.org,
        IS20 Oshri Alkoby <oshri.alkoby@nuvoton.com>,
        Tomer Maimon <tmaimon77@gmail.com>, gcwilson@us.ibm.com,
        kgoldman@us.ibm.com, ayna@linux.vnet.ibm.com,
        IS30 Dan Morav <Dan.Morav@nuvoton.com>,
        oren.tanami@nuvoton.com, shmulik.hager@nuvoton.com,
        amir.mizinski@nuvoton.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Mon, Dec 16, 2019 at 7:53 AM Amir Mizinski <amirmizi6@gmail.com> wrote:
>
> On Sat, Dec 14, 2019 at 12:36 AM Rob Herring <robh@kernel.org> wrote:
> >
> > On Mon, Dec 02, 2019 at 03:33:31PM +0200, amirmizi6@gmail.com wrote:
> > > From: Amir Mizinski <amirmizi6@gmail.com>
> > >
> > > Added a YAML schema to support tpm tis i2c realted dt-bindings for the I2c PTP based physical layer.
> >
> > Wrap your commmit message. And TPM, TIS?, and I2C should be capitalized.
>
> Thanks,  ill fix that.
>
> >
> > >
> > > Signed-off-by: Amir Mizinski <amirmizi6@gmail.com>
> > > ---
> > >  .../bindings/security/tpm/tpm-tis-i2c.yaml         | 38 ++++++++++++++++++++++
> > >  1 file changed, 38 insertions(+)
> > >  create mode 100644 Documentation/devicetree/bindings/security/tpm/tpm-tis-i2c.yaml
> >
> > Please read my comments on v1 (The first v1 from 11/10, not the 2nd v1
> > you sent).
>
> I sent a follow up comment regarding this:
> https://patchwork.kernel.org/patch/11236253/
> (2nd v1 was sent by mistake. sorry about that)

Sorry I missed your reply. However, you didn't address these comments:

> There's a bigger issue that the h/w here is more than just an I2C
> protocol. The chip may have multiple power supplies, clocks, reset
> lines, etc. HID over I2C seems like a similar case. Does the spec define
> *all* of that? If not, you need chip specific compatibles. You can keep
> this as a fallback though.

To rephrase this, a protocol does not fully describe the h/w and DT
should describe the h/w.

Also, you should include the interrupt whether you use it in the
driver currently or not. Again, it's about describing the h/w, not
what a driver happens to use ATM.

Rob
