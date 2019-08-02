Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 247D77FFFA
	for <lists+linux-integrity@lfdr.de>; Fri,  2 Aug 2019 20:03:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406492AbfHBSDW (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 2 Aug 2019 14:03:22 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:33460 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2406482AbfHBSDW (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 2 Aug 2019 14:03:22 -0400
Received: by mail-pf1-f193.google.com with SMTP id g2so36417166pfq.0
        for <linux-integrity@vger.kernel.org>; Fri, 02 Aug 2019 11:03:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=message-id:mime-version:content-transfer-encoding:in-reply-to
         :references:subject:from:cc:to:user-agent:date;
        bh=NyzlyT6zt9Jkc1fFHXP64R9Q/pAMXXL/7OlxQ9RBe9E=;
        b=QJWxqrRmB2eyhCgzBXaLVyPr8y9Ll5tqFVTUvvL6frTn4u6dC1Q4lbHrSDKLSJ2vCf
         1jbtiy5Wy8bd7J6qbtA9tuRN28ufm+yx9mtNFvQu5EMWxAp+T7Ts6JpQHfk2QblrNsUP
         +4JXKLOG7BBRtmavlvxJtsg8X4yPTJP8ifX+I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:mime-version
         :content-transfer-encoding:in-reply-to:references:subject:from:cc:to
         :user-agent:date;
        bh=NyzlyT6zt9Jkc1fFHXP64R9Q/pAMXXL/7OlxQ9RBe9E=;
        b=ucby7i0fEjiPpNxxaSAB+ulJuneqnYK6jMe3iRGNMubaeNrp6aKzv3bGH7wGNNf5M3
         dQ3Meyx86Qf/WaWmXoRJrs1nfh652pZyKcF4KtMag+ahFMImPRxPlnTOiOz/oH1Qs14I
         lh9jDKxGAZfzBYpty4jLteHg2d93V6mFgnqyR6kdVicXsE3J4HWH2YbT+n8tfoiwfhro
         prhjrXbycjF5AvJczj9SBTvI2vx+Wog9LNBd9NYqyYeh3l5nK8yOci2uPjZwOAjwU6Oa
         YKNuhsuasxT12m/MLWUbGs4pJDEOe2XMEvRZdL1KdvKyuPfQsgPWnrHUMsLNlvFTielF
         vYAg==
X-Gm-Message-State: APjAAAU/kry6paD2uR+gxkksvjgCE1+/oeAk4vDSXOm4hobUs6qojSqC
        GthmQu0Ads2d1IGZVNEaaI2Gbg==
X-Google-Smtp-Source: APXvYqw+uwQhb8/dIAhFu+edAptuyPEIxBIussJjjnu4pBVHdYnLiRKghs6Oj5hdoOKtbe9CcQD6KQ==
X-Received: by 2002:aa7:82da:: with SMTP id f26mr61308521pfn.82.1564769001817;
        Fri, 02 Aug 2019 11:03:21 -0700 (PDT)
Received: from chromium.org ([2620:15c:202:1:fa53:7765:582b:82b9])
        by smtp.gmail.com with ESMTPSA id i9sm7639397pjj.2.2019.08.02.11.03.21
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Fri, 02 Aug 2019 11:03:21 -0700 (PDT)
Message-ID: <5d447ae9.1c69fb81.27556.5150@mx.google.com>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <4e61869efc51a2b10f931bc010e6d37d62d6c06c.camel@linux.intel.com>
References: <20190716224518.62556-1-swboyd@chromium.org> <20190716224518.62556-6-swboyd@chromium.org> <f824e3ab-ae2f-8c2f-549a-16569b10966e@infineon.com> <5d2f7daf.1c69fb81.c0b13.c3d4@mx.google.com> <5d2f955d.1c69fb81.35877.7018@mx.google.com> <b05904bf-00b9-bf30-0fc9-9f363e181d80@infineon.com> <5d30b649.1c69fb81.f440e.9a0a@mx.google.com> <1bb8d417-3199-7aff-ad60-b25464502cb3@infineon.com> <5d430cfb.1c69fb81.9480d.0d81@mx.google.com> <4e61869efc51a2b10f931bc010e6d37d62d6c06c.camel@linux.intel.com>
Subject: Re: [PATCH v2 5/6] tpm: add driver for cr50 on SPI
From:   Stephen Boyd <swboyd@chromium.org>
Cc:     Andrey Pronin <apronin@chromium.org>, linux-kernel@vger.kernel.org,
        Jason Gunthorpe <jgg@ziepe.ca>, Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-integrity@vger.kernel.org,
        Duncan Laurie <dlaurie@chromium.org>,
        Guenter Roeck <groeck@chromium.org>
To:     Alexander Steffen <Alexander.Steffen@infineon.com>,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        Peter Huewe <peterhuewe@gmx.de>
User-Agent: alot/0.8.1
Date:   Fri, 02 Aug 2019 11:03:20 -0700
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Quoting Jarkko Sakkinen (2019-08-02 08:21:06)
> On Thu, 2019-08-01 at 09:02 -0700, Stephen Boyd wrote:
> > Quoting Alexander Steffen (2019-07-19 00:53:00)
> > > On 18.07.2019 20:11, Stephen Boyd wrote:
> > > > Quoting Alexander Steffen (2019-07-18 09:47:22)
> > > > > On 17.07.2019 23:38, Stephen Boyd wrote:
> > > > > > Quoting Stephen Boyd (2019-07-17 12:57:34)
> > > > > > > Quoting Alexander Steffen (2019-07-17 05:00:06)
> > > > > > > > Can't the code be shared more explicitly, e.g. by cr50_spi =
wrapping
> > > > > > > > tpm_tis_spi, so that it can intercept the calls, execute th=
e additional
> > > > > > > > actions (like waking up the device), but then let tpm_tis_s=
pi do the
> > > > > > > > common work?
> > > > > > > >=20
> > > > > > >=20
> > > > > > > I suppose the read{16,32} and write32 functions could be reus=
ed. I'm not
> > > > > > > sure how great it will be if we combine these two drivers, bu=
t I can
> > > > > > > give it a try today and see how it looks.
> > > > > > >=20
> > > > > >=20
> > > > > > Here's the patch. I haven't tested it besides compile testing.
> > > >=20
> > > > The code seems to work but I haven't done any extensive testing bes=
ides
> > > > making sure that the TPM responds to pcr reads and some commands li=
ke
> > > > reading random numbers.
> > > >=20
> > > > > Thanks for providing this. Makes it much easier to see what the a=
ctual
> > > > > differences between the devices are.
> > > > >=20
> > > > > Do we have a general policy on how to support devices that are ve=
ry
> > > > > similar but need special handling in some places? Not duplicating=
 the
> > > > > whole driver just to change a few things definitely seems like an
> > > > > improvement (and has already been done in the past, as with
> > > > > TPM_TIS_ITPM_WORKAROUND). But should all the code just be added to
> > > > > tpm_tis_spi.c? Or is there some way to keep a clearer separation,
> > > > > especially when (in the future) we have multiple devices that all=
 have
> > > > > their own set of deviations from the spec?
> > > > >=20
> > > >=20
> > > > If you have any ideas on how to do it please let me know. At this p=
oint,
> > > > I'd prefer if the maintainers could provide direction on what they =
want.
> > >=20
> > > Sure, I'd expect Jarkko will say something once he's back from vacati=
on.
> > >=20
> >=20
> > Should I just resend this patch series? I haven't attempted to make the
> > i2c driver changes, but at least the SPI driver changes seem good enough
> > to resend.
>=20
> Hi, I'm back. If there are already like obvious changes, please send an
> update and I'll take a look at that.
>=20

Ok. Will do today. Thanks.

