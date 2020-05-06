Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C98951C79D9
	for <lists+linux-integrity@lfdr.de>; Wed,  6 May 2020 21:03:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726908AbgEFTDL (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 6 May 2020 15:03:11 -0400
Received: from mail.kernel.org ([198.145.29.99]:60740 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725985AbgEFTDK (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 6 May 2020 15:03:10 -0400
Received: from mail-ot1-f43.google.com (mail-ot1-f43.google.com [209.85.210.43])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2539520A8B;
        Wed,  6 May 2020 19:03:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588791790;
        bh=Yqg0FR03ICsngX2rB2sb2xuYkFg82NaW1zU2YIloR8Y=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=bflTPGqsgd+C46NDp/kwSeS28/ILDYVhFL2jv6BZuKjpMUR/ktwXLjhxxhqV4DNxw
         BdV11rDjdoML/1GZLEggZCBW3Rv5+aD1y+3mF+n45ozmDuANoOdC0IriusDb27jvo9
         q1hg6eJ4AJRQ26qvWHRcDAwDx1PTrIFvQ0txMZVk=
Received: by mail-ot1-f43.google.com with SMTP id i27so2269092ota.7;
        Wed, 06 May 2020 12:03:10 -0700 (PDT)
X-Gm-Message-State: AGi0PuZEh5UQxYharW/JZCj4jfLCggDzrUz/geGqhTsr1EzUkIr8Vxo1
        KmI4Uxy3tiSQbG9DLSvOB1Gbilms3QdG7gAbiQ==
X-Google-Smtp-Source: APiQypK+MaFY1Iurl8mjdABioyqSrQP03zlo2Xmdf7/+1qRLRnupLAu9sz8qI0nEExTPXKjiGpEvDyKMczIxLkNxBhk=
X-Received: by 2002:a9d:1441:: with SMTP id h59mr7763912oth.192.1588791789287;
 Wed, 06 May 2020 12:03:09 -0700 (PDT)
MIME-Version: 1.0
References: <20200427124931.115697-1-amirmizi6@gmail.com> <20200427124931.115697-7-amirmizi6@gmail.com>
 <20200505161226.GA555@bogus> <c2760659-ec14-237e-e060-5d9a2d7c7e4a@gmail.com>
In-Reply-To: <c2760659-ec14-237e-e060-5d9a2d7c7e4a@gmail.com>
From:   Rob Herring <robh@kernel.org>
Date:   Wed, 6 May 2020 14:02:57 -0500
X-Gmail-Original-Message-ID: <CAL_JsqLEkoa1+nnWBQHah14_6BozkMzjcSpbk-hhLS=Rnqaa8Q@mail.gmail.com>
Message-ID: <CAL_JsqLEkoa1+nnWBQHah14_6BozkMzjcSpbk-hhLS=Rnqaa8Q@mail.gmail.com>
Subject: Re: [PATCH v7 6/7] tpm: Add YAML schema for TPM TIS I2C options
To:     Amir Mizinski <amirmizi6@gmail.com>
Cc:     Eyal.Cohen@nuvoton.com,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        Oshri Alkobi <oshrialkoby85@gmail.com>,
        Alexander Steffen <alexander.steffen@infineon.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Peter Huewe <peterhuewe@gmx.de>,
        Jason Gunthorpe <jgg@ziepe.ca>, Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        benoit.houyere@st.com, Eddie James <eajames@linux.ibm.com>,
        Joel Stanley <joel@jms.id.au>, devicetree@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        linux-integrity@vger.kernel.org,
        IS20 Oshri Alkoby <oshri.alkoby@nuvoton.com>,
        Tomer Maimon <tmaimon77@gmail.com>, gcwilson@us.ibm.com,
        kgoldman@us.ibm.com, IS30 Dan Morav <Dan.Morav@nuvoton.com>,
        oren.tanami@nuvoton.com, shmulik.hager@nuvoton.com,
        amir.mizinski@nuvoton.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Wed, May 6, 2020 at 10:20 AM Amir Mizinski <amirmizi6@gmail.com> wrote:
>
>
> On 2020-05-05 16:12, Rob Herring wrote:
> > On Mon, Apr 27, 2020 at 03:49:30PM +0300, amirmizi6@gmail.com wrote:
> >> From: Amir Mizinski <amirmizi6@gmail.com>
> >>
> >> Added a YAML schema to support tpm tis i2c related dt-bindings for the I2c
> >> PTP based physical layer.
> >>
> >> This patch adds the documentation for corresponding device tree bindings of
> >> I2C based Physical TPM.
> >> Refer to the 'I2C Interface Definition' section in
> >> 'TCG PC Client PlatformTPMProfile(PTP) Specification' publication
> >> for specification.
> >
> > Again, DT bindings describe h/w devices, not just a protocol. A device
> > is more than just a protocol interface. There's clocks, power rails,
> > resets, interrupts, firmware, etc.
> >
> > Unless there's something special about TPM chips that makes none of this
> > applicable and no chip will ever have any quirks (or extensions) in
> > their protocol to work-around, then you need compatible string(s) that
> > are specific to the TPM chip. You can have tcg,tpm-tis-i2c as a
> > fallback, but you need specific compatible to handle any quirks.
> >
> > Rob
>
> Hello Rob, currently yes. All TPM chip are implemented according to the TGC specs and should use the same properties for this I2C driver.
> I can't say for sure that it will be the case in the future.

Exactly. That's the issue. If you have just "tcg,tpm-tis-i2c" and need
to handle some difference in the future, then you can't without
updating the DT. You must be able to handle future issues without
updating the DT.

> Shouldn't we use the standard "tcg,tpm-tis-i2c" compatible, and if a specific TPM chip will deviate from the specs, the vendor should add an additional compatible string for it?

Name something where multiple vendors have implemented a spec and
there's no deviation. It simply doesn't exist. How would you know?

Does the TPM spec define all the things I listed above outside of just
the I2C protocol?

Also, what version of the spec is "tcg,tpm-tis-i2c"? Few specs have
only 1 version.

Rob
