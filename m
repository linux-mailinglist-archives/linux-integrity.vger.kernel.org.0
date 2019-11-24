Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6020C108473
	for <lists+linux-integrity@lfdr.de>; Sun, 24 Nov 2019 19:02:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726840AbfKXSCY (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Sun, 24 Nov 2019 13:02:24 -0500
Received: from mail-pf1-f193.google.com ([209.85.210.193]:37261 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726825AbfKXSCY (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Sun, 24 Nov 2019 13:02:24 -0500
Received: by mail-pf1-f193.google.com with SMTP id p24so6113071pfn.4;
        Sun, 24 Nov 2019 10:02:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=kfIxdj2LVxPAZ1Wflylge9S9kE5jfMTIOd5jj5CenZE=;
        b=pNQRyLgjPx9sp3uAoqGaDL+twbZ6ytwmS3lHalR1VW+f101xGNgn0KnPNZSCOGAHIY
         fdnbzRv2kmAojPMTZyLQcIjbvqE3u9JFGlsqs2j/vZKVqOLEWl6vbr6OgbyyXVo/4K4i
         VnTuNIaR820Zf9G6pNUsTuIOad2EvNHtEj64tzgnlCZnr8MW+zcjVEudTYwArBd082k5
         jqZcgUAyOYM9yu7d1DsXZTjVIkN5gxWWg5iBRC5KoosYopPzkdRNlGoRHgERO0jtsu8r
         MtaGbV2zLre2cRoHeYILUSCq3Im4rM33T+fW92VeIDyeEpP614VosPlVKmPlZTAbijfa
         fvCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=kfIxdj2LVxPAZ1Wflylge9S9kE5jfMTIOd5jj5CenZE=;
        b=GYqpCRTFeNFMB8gsudmHmBJ4ySYVyEGAm2NK+fYWG6QMZD+s0dhkKXlovem1T1QG4B
         3ekpMtOjUaNG+AvmdU0Tp0cNG8eWJwCgjLLhaJrAwkb5z8VqlQ0sN2m+wjxf8UYkyese
         VIThTw7jOneor7WPj7V+yu61g7NwP/Z4Hy8w9ZLzmF+og4RB8NkCS2gadN+A5QkIY6hN
         5YyGq5bEshs+zu+daM4Dl7KaWF5X0MFf6O3xhwEjHdQRs8C5YVNV3kwf5IxkI7TMvLxc
         /ntbSKBcX85eKcDibnQj+D82DqvqYpqNPH3oQTk7rvj059P27qoHbtZaFXdypNaccjnH
         iJDA==
X-Gm-Message-State: APjAAAVAPusvRhgMRLayC1V62I08ipuBdKy3F+sqAcWUiCq43cLV7UNC
        OJtZj25F+a/3L5xkmm6ze2Um3avGw4RopIJCj9I=
X-Google-Smtp-Source: APXvYqz+QhEQbI+zJvb+yOUQctcHTWpvncfbC+TguFgDqeb6TfTL91Xglo+Y7i3unSyfPSwALiE6ZX/IlBCxuULxOIw=
X-Received: by 2002:a63:8e:: with SMTP id 136mr21396785pga.355.1574618543209;
 Sun, 24 Nov 2019 10:02:23 -0800 (PST)
MIME-Version: 1.0
References: <20191110162137.230913-1-amirmizi6@gmail.com> <20191110162137.230913-5-amirmizi6@gmail.com>
 <20191114191054.GA20209@bogus>
In-Reply-To: <20191114191054.GA20209@bogus>
From:   Amir Mizinski <amirmizi6@gmail.com>
Date:   Sun, 24 Nov 2019 20:02:13 +0200
Message-ID: <CAMHTsUXKUfCwHzucq7+zwkopM-9ZravWqXF8PXH9zegbkWjSgA@mail.gmail.com>
Subject: Re: [PATCH v1 4/5] dt-bindings: tpm: Add the TPM TIS I2C device tree
 binding documentaion
To:     Rob Herring <robh@kernel.org>
Cc:     Eyal.Cohen@nuvoton.com,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        Oshri Alkobi <oshrialkoby85@gmail.com>,
        Alexander Steffen <alexander.steffen@infineon.com>,
        Mark Rutland <mark.rutland@arm.com>, peterhuewe@gmx.de,
        jgg@ziepe.ca, Arnd Bergmann <arnd@arndb.de>,
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

On Thu, Nov 14, 2019 at 9:10 PM Rob Herring <robh@kernel.org> wrote:
>
> On Sun, Nov 10, 2019 at 06:21:36PM +0200, amirmizi6@gmail.com wrote:
> > From: Amir Mizinski <amirmizi6@gmail.com>
> >
> > this file aim at documenting TPM TIS I2C related dt-bindings for the I2C PTP based Physical TPM.
> >
> > Signed-off-by: Amir Mizinski <amirmizi6@gmail.com>
> > ---
> >  .../bindings/security/tpm/tpm_tis_i2c.txt          | 24 ++++++++++++++++++++++
> >  1 file changed, 24 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/security/tpm/tpm_tis_i2c.txt
>
> Please make this a schema. See
> Documentation/devicetree/writing-schema.rst.
>
> >
> > diff --git a/Documentation/devicetree/bindings/security/tpm/tpm_tis_i2c.txt b/Documentation/devicetree/bindings/security/tpm/tpm_tis_i2c.txt
> > new file mode 100644
> > index 0000000..7d5a69e
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/security/tpm/tpm_tis_i2c.txt
> > @@ -0,0 +1,24 @@
> > +* Device Tree Bindings for I2C PTP based Trusted Platform Module(TPM)
> > +
> > +The TCG defines hardware protocol, registers and interface (based
> > +on the TPM Interface Specification) for accessing TPM devices
> > +implemented with an I2C interface.
> > +
> > +Refer to the 'I2C Interface Definition' section in 'TCG PC Client
> > +PlatformTPMProfile(PTP) Specification' publication for specification.
> > +
> > +Required properties:
> > +
> > +- compatible     : Should be "tcg,tpm_tis-i2c"
>
> s/_/-/
>
> As this has to be under an I2C controller node, the '-i2c' part is
> redundant.
>

I wrote this Respectively with the tpm_tis-spi driver.
https://github.com/torvalds/linux/blob/master/Documentation/devicetree/bindings/security/tpm/tpm_tis_spi.txt
Should i change it anyway or keep the format?
Also the '-i2c' is added since its not the only protocol used over
tis, and it is handled differently from spi.

> There's a bigger issue that the h/w here is more than just an I2C
> protocol. The chip may have multiple power supplies, clocks, reset
> lines, etc. HID over I2C seems like a similar case. Does the spec define
> *all* of that? If not, you need chip specific compatibles. You can keep
> this as a fallback though.
>
> > +- reg            : Address on the bus
> > +- tpm-pirq       : Input gpio pin, used for host interrupts
>
> GPIO connections are properties ending in '-gpios'. However, if the only
> use is an interrupt, then you should use 'interrupts'.
>

My mistake, i didn't implemented interrupts yet so ill clear this for
now.  thank you.

> > +
> > +Example (for Raspberry Pie 3 Board with Nuvoton's NPCT75X (2.0)
> > +-------------------------------------------------------------------
> > +
> > +tpm_tis-i2c: tpm_tis-i2c@2e {
> > +
> > +       compatible = "tcg,tpm_tis-i2c";
> > +       reg = <0x2e>;
> > +       tpm-pirq = <&gpio 24 GPIO_ACTIVE_HIGH>;
> > +};
> > --
> > 2.7.4
> >

Apologies for the late response, had a personal issue that needed my attention
I'm working on making this a schema for next version. This is new for
me, if you have additional sources regarding how to write it, i'll
appreciate if you send me.
Thank you.

Amir Mizinski
