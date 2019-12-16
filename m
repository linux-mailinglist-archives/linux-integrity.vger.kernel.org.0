Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A2D241207A7
	for <lists+linux-integrity@lfdr.de>; Mon, 16 Dec 2019 14:53:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727807AbfLPNxt (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 16 Dec 2019 08:53:49 -0500
Received: from mail-pf1-f195.google.com ([209.85.210.195]:36227 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727579AbfLPNxt (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 16 Dec 2019 08:53:49 -0500
Received: by mail-pf1-f195.google.com with SMTP id x184so5636107pfb.3;
        Mon, 16 Dec 2019 05:53:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=xgYwA15dG8l4/wpZxWioQV4WW+kSKdvUXyu4yhTQhow=;
        b=srMiz4eIHwRt4AcKl94JS4sGdCgPVQsffWApQLSTrRA79QvkgaG79feUeSX0NrNwJm
         WrGhPNr8BqkrhOnvK46V6PSKm2RGReFTD5aA8cAFBdZ4rcqHBAT4v1rprJd9e3vq2V+L
         ap1RVlPQc6Wzn0SINx9L7yw8MX/FdKRxNBKcBgbwj9FhRDZ99NET6QateR8+cYFutQJG
         7+IC4cNhOZErZjm8gwiL3wA1GZL/+plRTMJ867PLgNLshaipadQ6n6xxKhRI7nrHsmvN
         B8bldV/Fk4m2SEepyOaACzyVEbAXyjnUe6fsCqHEgVZRpvzlCfgBsQpUGjB/Pg0CVXog
         427A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=xgYwA15dG8l4/wpZxWioQV4WW+kSKdvUXyu4yhTQhow=;
        b=Pfb3sl+l47nNAma9EzJOuMCdogDDh1o9BLAG1ozmj/YyRoWNx3lM1T3DNS1l4Ru9vN
         qFjHb2xAu1+e1qpsNZW6UTAd4wKi/vTDHgiGg1AAm2bLcOPVa/oPc+5wJt3lHd499Bn6
         7eRokh2S4OPvkVjeJyBvkZEvU+/b0b/qUAnew2IbrADhDz/0NO0zoyh0nFaEAQNFWmv+
         H+CjzDjXXMyspRV9uKg33TKxoh48c//vxpMwxbmBMWwlZVCDZ4K+HUzAap+HIxoO2VsP
         mlmDvGM7Hon3Cg4/+3Y/WMiT06MJBuHUT5Cmls1bG3i/+gvh5HSEKYjVtjL5t0tOuGwf
         ORAA==
X-Gm-Message-State: APjAAAXk88iQEp0EAMGX7vIhes+Bju1v9YYRJBrYkUjBNBbvZc4aEcU6
        TvAZOn7dZp3Xw6DiifKHqRbRmBXOrRrMFvzXpP0=
X-Google-Smtp-Source: APXvYqydiSRLoIrO5tJIaDzEjthd12WbO2NO97JKasfyed/B32rvFQzDeiRf2fqpRNXZjFV6ZOujHqCMwIujhCKpeBg=
X-Received: by 2002:a63:e0f:: with SMTP id d15mr18174165pgl.255.1576504428809;
 Mon, 16 Dec 2019 05:53:48 -0800 (PST)
MIME-Version: 1.0
References: <20191202133332.178110-1-amirmizi6@gmail.com> <20191202133332.178110-5-amirmizi6@gmail.com>
 <20191213223623.GA14809@bogus>
In-Reply-To: <20191213223623.GA14809@bogus>
From:   Amir Mizinski <amirmizi6@gmail.com>
Date:   Mon, 16 Dec 2019 15:53:48 +0200
Message-ID: <CAMHTsUW5dH-5LCW9GYzDnWEcqPt-Ch_21efQVpAKMdSvCXB00Q@mail.gmail.com>
Subject: Re: [PATCH v2 4/5] dt-bindings: tpm: Add YAML schema for TPM TIS I2C options
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

On Sat, Dec 14, 2019 at 12:36 AM Rob Herring <robh@kernel.org> wrote:
>
> On Mon, Dec 02, 2019 at 03:33:31PM +0200, amirmizi6@gmail.com wrote:
> > From: Amir Mizinski <amirmizi6@gmail.com>
> >
> > Added a YAML schema to support tpm tis i2c realted dt-bindings for the I2c PTP based physical layer.
>
> Wrap your commmit message. And TPM, TIS?, and I2C should be capitalized.

Thanks,  ill fix that.

>
> >
> > Signed-off-by: Amir Mizinski <amirmizi6@gmail.com>
> > ---
> >  .../bindings/security/tpm/tpm-tis-i2c.yaml         | 38 ++++++++++++++++++++++
> >  1 file changed, 38 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/security/tpm/tpm-tis-i2c.yaml
>
> Please read my comments on v1 (The first v1 from 11/10, not the 2nd v1
> you sent).

I sent a follow up comment regarding this:
https://patchwork.kernel.org/patch/11236253/
(2nd v1 was sent by mistake. sorry about that)

>
> Rob

Amir Mizinski
