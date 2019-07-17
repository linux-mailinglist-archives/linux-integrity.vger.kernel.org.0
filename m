Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 39BDE6C00A
	for <lists+linux-integrity@lfdr.de>; Wed, 17 Jul 2019 19:03:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727108AbfGQRDY (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 17 Jul 2019 13:03:24 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:33833 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727107AbfGQRDY (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 17 Jul 2019 13:03:24 -0400
Received: by mail-pl1-f196.google.com with SMTP id i2so12307968plt.1
        for <linux-integrity@vger.kernel.org>; Wed, 17 Jul 2019 10:03:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=message-id:mime-version:content-transfer-encoding:in-reply-to
         :references:subject:to:cc:from:user-agent:date;
        bh=ll2TSZ+W14CatTO8QRYSJ95wycJRxflDCU2uIe5dMkI=;
        b=ciGRSY1ZqcR6eJAPXpERbUYACi50bfefsD8fNzBg1S5TkrWq1RcE3GU9SORWbHPE5+
         OjM4k2u5WNvcf0DSpE9lq+6SzrVQiBmlr3JT6O16nLc80g/tE+m/SIAndxzcWVOFFuFW
         +F9rlCqWqdjCm18Opce4dg0x4VyDRToTYlSJU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:mime-version
         :content-transfer-encoding:in-reply-to:references:subject:to:cc:from
         :user-agent:date;
        bh=ll2TSZ+W14CatTO8QRYSJ95wycJRxflDCU2uIe5dMkI=;
        b=DkPXQgMsTUE76lPS8FljB2UgiMz8X6R8N58ul0m9w79B3hzzN+fHkUsuzFu1zZpHz/
         alD6RB6PKg/Efn9CiQmg4fd/emdQA3rH7MKgzsHB9UqRhuNzfzO+EreewcObKIbA+am3
         O6Cr9rYR+9up4Wuil0LrvkEi/4xT3I0EqBQYMGQRcwP3wc9rOAoh4e2vJ1DAla8UrtOQ
         2YoXLCOeyyIGV9zc75yqQqLNeWNmdPgRgBk4KZSWk7diZROT0SL12+MhuNebDxMhVfX8
         L6OIrbQ9jBoxmT0z+DkFI88jJLFcGGx4K04E1V+flmDlIkwA+GDHou5BwLjUtwDI6f2p
         LqHg==
X-Gm-Message-State: APjAAAVBDU5rr67gwXiXVkOQUU8R0ax3njpoTavaEr0WuXmnM24MJOCa
        bUp8QtPnmVqpYrNtaJ76fzkWsA==
X-Google-Smtp-Source: APXvYqyyyG+wEJYC3gU+xCNnKRVoo7ENtTDPU9F1+sXkjHH6JtJdJulTMcO4/9LyCab7adJ9E3zY2g==
X-Received: by 2002:a17:902:f204:: with SMTP id gn4mr44952272plb.3.1563383003657;
        Wed, 17 Jul 2019 10:03:23 -0700 (PDT)
Received: from chromium.org ([2620:15c:202:1:fa53:7765:582b:82b9])
        by smtp.gmail.com with ESMTPSA id u69sm31655275pgu.77.2019.07.17.10.03.23
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Wed, 17 Jul 2019 10:03:23 -0700 (PDT)
Message-ID: <5d2f54db.1c69fb81.5720c.dc05@mx.google.com>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20190717165011.GI12119@ziepe.ca>
References: <20190716224518.62556-1-swboyd@chromium.org> <20190716224518.62556-2-swboyd@chromium.org> <20190717113956.GA12119@ziepe.ca> <5d2f4ff9.1c69fb81.3c314.ab00@mx.google.com> <20190717165011.GI12119@ziepe.ca>
Subject: Re: [PATCH v2 1/6] hwrng: core: Freeze khwrng thread during suspend
To:     Jason Gunthorpe <jgg@ziepe.ca>
Cc:     Peter Huewe <peterhuewe@gmx.de>,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        linux-kernel@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-integrity@vger.kernel.org,
        Andrey Pronin <apronin@chromium.org>,
        Duncan Laurie <dlaurie@chromium.org>,
        Guenter Roeck <groeck@chromium.org>,
        Herbert Xu <herbert@gondor.apana.org.au>
From:   Stephen Boyd <swboyd@chromium.org>
User-Agent: alot/0.8.1
Date:   Wed, 17 Jul 2019 10:03:22 -0700
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Quoting Jason Gunthorpe (2019-07-17 09:50:11)
> On Wed, Jul 17, 2019 at 09:42:32AM -0700, Stephen Boyd wrote:
> > Quoting Jason Gunthorpe (2019-07-17 04:39:56)
> > > On Tue, Jul 16, 2019 at 03:45:13PM -0700, Stephen Boyd wrote:
> > > > The hwrng_fill() function can run while devices are suspending and
> > > > resuming. If the hwrng is behind a bus such as i2c or SPI and that =
bus
> > > > is suspended, the hwrng may hang the bus while attempting to add so=
me
> > > > randomness. It's been observed on ChromeOS devices with suspend-to-=
idle
> > > > (s2idle) and an i2c based hwrng that this kthread may run and ask t=
he
> > > > hwrng device for randomness before the i2c bus has been resumed.
> > >=20
> > > You mean the TPM here right?
> >=20
> > In my case yes, but in general it isn't the TPM.
> >=20
> > >=20
> > > Should we be more careful in the TPM code to check if the TPM is
> > > suspended before trying to use it, rather than muck up callers?
> > >=20
> >=20
> > Given that it's not just a TPM issue I don't see how checking in the TPM
> > is going to fix this problem. It's better to not try to get random bytes
> > from the hwrng when the device could be suspended.
>=20
> I think the same comment would apply to all the other suspend capable
> hwrngs...

Yes. That's exactly my point. A hwrng that's suspended will fail here
and it's better to just not try until it's guaranteed to have resumed.

>=20
> It just seems weird to do this, what about all the other tpm API
> users? Do they have a racy problem with suspend too?

I haven't looked at them. Are they being called from suspend/resume
paths? I don't think anything for the userspace API can be a problem
because those tasks are all frozen. The only problem would be some
kernel internal API that TPM API exposes. I did a quick grep and I see
things like IMA or the trusted keys APIs that might need a closer look.

Either way, trying to hold off a TPM operation from the TPM API when
we're suspended isn't really possible. If something like IMA needs to
get TPM data from deep suspend path and it fails because the device is
suspended, all we can do is return an error from TPM APIs and hope the
caller can recover. The fix is probably going to be to change the code
to not call into the TPM API until the hardware has resumed by avoiding
doing anything with the TPM until resume is over. So we're at best able
to make same sort of band-aid here in the TPM API where all we can do is
say -EAGAIN but we can't tell the caller when to try again.

