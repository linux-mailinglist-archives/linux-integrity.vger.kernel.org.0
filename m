Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 107FB7DFAE
	for <lists+linux-integrity@lfdr.de>; Thu,  1 Aug 2019 18:02:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732581AbfHAQCF (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 1 Aug 2019 12:02:05 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:42489 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729117AbfHAQCE (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 1 Aug 2019 12:02:04 -0400
Received: by mail-pl1-f194.google.com with SMTP id ay6so32453656plb.9
        for <linux-integrity@vger.kernel.org>; Thu, 01 Aug 2019 09:02:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=message-id:mime-version:content-transfer-encoding:in-reply-to
         :references:cc:from:to:subject:user-agent:date;
        bh=21DtoTC7v3Cr6EchpPn/gSwYheXn1PUX53YRruG65c8=;
        b=aESn6w6rfB2I7Dtwsmf4DoqdwRCMVpJM+XOGXy9mRoNEs+qhbPdJUgV/hNnWQGLe9n
         KfB/g5+tFjwQSr2fVsQU8UWB/quVDBz2o1rtbfRRfAIJUyEPg7mQTYufIE/haqulR4Hm
         HRw/1RB8E8Hn2PsHYZzBPwa/PFZQ79uPgVqqA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:mime-version
         :content-transfer-encoding:in-reply-to:references:cc:from:to:subject
         :user-agent:date;
        bh=21DtoTC7v3Cr6EchpPn/gSwYheXn1PUX53YRruG65c8=;
        b=SNX2SSwi5eXKbABlyIWWdaLDmvKVHhLujIziK9zK9W5jjt3eHMSm00xkMxqyEmX0Cw
         NEhuZyoFUCkkiKDZy0rNrZRObY8RdyiSYHTllCwBPVm6gDIYSH0BWV3Ph0bzxuHJ7yFi
         udkXQyIYZiaXgS+2rDjVxoj9jCaQ78nwD7QIxmTd0OArUGBcqGByLBgIwUNi/NeoRBbF
         yu6WQzW5C8fjKdDjQLrX0rTyQAFRspLWjlj1I7HwXfZQ5ueCllrrH4KmuxE62tzTg8J5
         nJaszeD/GlwJA1aJtEAv59STf8otTu6xUL4fD5OWGwBSw7iSqCUYZGQtkSjbHPoLtTbq
         aOzA==
X-Gm-Message-State: APjAAAUyFL1kEwvSl6rqi/iNarUdZ23JKu5SsdXEn0Uv7OHBPFPJ96+U
        13eAUkRHbtlurKZJ9uNot/YZ+A==
X-Google-Smtp-Source: APXvYqzI/7aUYrcyTgYWGod9QE+ZxKyfMUSIYB0Iyn0g4DkrWYSkoZcV1k4vtJ8y3v5GTqIP2r3gsQ==
X-Received: by 2002:a17:902:2aa8:: with SMTP id j37mr120884127plb.316.1564675324209;
        Thu, 01 Aug 2019 09:02:04 -0700 (PDT)
Received: from chromium.org ([2620:15c:202:1:fa53:7765:582b:82b9])
        by smtp.gmail.com with ESMTPSA id x9sm48446954pgp.75.2019.08.01.09.02.03
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Thu, 01 Aug 2019 09:02:03 -0700 (PDT)
Message-ID: <5d430cfb.1c69fb81.9480d.0d81@mx.google.com>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <1bb8d417-3199-7aff-ad60-b25464502cb3@infineon.com>
References: <20190716224518.62556-1-swboyd@chromium.org> <20190716224518.62556-6-swboyd@chromium.org> <f824e3ab-ae2f-8c2f-549a-16569b10966e@infineon.com> <5d2f7daf.1c69fb81.c0b13.c3d4@mx.google.com> <5d2f955d.1c69fb81.35877.7018@mx.google.com> <b05904bf-00b9-bf30-0fc9-9f363e181d80@infineon.com> <5d30b649.1c69fb81.f440e.9a0a@mx.google.com> <1bb8d417-3199-7aff-ad60-b25464502cb3@infineon.com>
Cc:     Andrey Pronin <apronin@chromium.org>, linux-kernel@vger.kernel.org,
        Jason Gunthorpe <jgg@ziepe.ca>, Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-integrity@vger.kernel.org,
        Duncan Laurie <dlaurie@chromium.org>,
        Guenter Roeck <groeck@chromium.org>
From:   Stephen Boyd <swboyd@chromium.org>
To:     Alexander Steffen <Alexander.Steffen@infineon.com>,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        Peter Huewe <peterhuewe@gmx.de>
Subject: Re: [PATCH v2 5/6] tpm: add driver for cr50 on SPI
User-Agent: alot/0.8.1
Date:   Thu, 01 Aug 2019 09:02:02 -0700
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Quoting Alexander Steffen (2019-07-19 00:53:00)
> On 18.07.2019 20:11, Stephen Boyd wrote:
> > Quoting Alexander Steffen (2019-07-18 09:47:22)
> >> On 17.07.2019 23:38, Stephen Boyd wrote:
> >>> Quoting Stephen Boyd (2019-07-17 12:57:34)
> >>>> Quoting Alexander Steffen (2019-07-17 05:00:06)
> >>>>>
> >>>>> Can't the code be shared more explicitly, e.g. by cr50_spi wrapping
> >>>>> tpm_tis_spi, so that it can intercept the calls, execute the additi=
onal
> >>>>> actions (like waking up the device), but then let tpm_tis_spi do the
> >>>>> common work?
> >>>>>
> >>>>
> >>>> I suppose the read{16,32} and write32 functions could be reused. I'm=
 not
> >>>> sure how great it will be if we combine these two drivers, but I can
> >>>> give it a try today and see how it looks.
> >>>>
> >>>
> >>> Here's the patch. I haven't tested it besides compile testing.
> >=20
> > The code seems to work but I haven't done any extensive testing besides
> > making sure that the TPM responds to pcr reads and some commands like
> > reading random numbers.
> >=20
> >>
> >> Thanks for providing this. Makes it much easier to see what the actual
> >> differences between the devices are.
> >>
> >> Do we have a general policy on how to support devices that are very
> >> similar but need special handling in some places? Not duplicating the
> >> whole driver just to change a few things definitely seems like an
> >> improvement (and has already been done in the past, as with
> >> TPM_TIS_ITPM_WORKAROUND). But should all the code just be added to
> >> tpm_tis_spi.c? Or is there some way to keep a clearer separation,
> >> especially when (in the future) we have multiple devices that all have
> >> their own set of deviations from the spec?
> >>
> >=20
> > If you have any ideas on how to do it please let me know. At this point,
> > I'd prefer if the maintainers could provide direction on what they want.
>=20
> Sure, I'd expect Jarkko will say something once he's back from vacation.
>=20

Should I just resend this patch series? I haven't attempted to make the
i2c driver changes, but at least the SPI driver changes seem good enough
to resend.

