Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 42DF56C0E8
	for <lists+linux-integrity@lfdr.de>; Wed, 17 Jul 2019 20:21:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388870AbfGQSVR (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 17 Jul 2019 14:21:17 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:42375 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727434AbfGQSVR (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 17 Jul 2019 14:21:17 -0400
Received: by mail-pl1-f193.google.com with SMTP id ay6so12401484plb.9
        for <linux-integrity@vger.kernel.org>; Wed, 17 Jul 2019 11:21:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=message-id:mime-version:content-transfer-encoding:in-reply-to
         :references:subject:to:cc:from:user-agent:date;
        bh=60aDM/x9GaO0dYW0lJAJyWJn0IP5ZBAIAfwXiMeFns8=;
        b=kKueUS7r6CElbotkMBII5pyUvviLIxNFgbsJu5bLvmOpvcNslc1V3CjCuuUsW/M3PA
         TJTEOSRYV07AMKXZXjjDK60PBPTQMkz2EDYYOHDXBF+3P/xXUNuE0eT4FRRpzYsSKA97
         5tByp9c9KlLWOaES2/8Ep1/U9FREh5pv6MSsw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:mime-version
         :content-transfer-encoding:in-reply-to:references:subject:to:cc:from
         :user-agent:date;
        bh=60aDM/x9GaO0dYW0lJAJyWJn0IP5ZBAIAfwXiMeFns8=;
        b=oCSK9K5RhK3DfBZRQKx/d/Fj0QTaRfiIkK16KOWROUTklmn68SD3UjnsJZ+oCgHtdq
         7Bn3wvOxasPIU1D9ICxYBECkDRFP4CEC8ULPo3ssgLp1YT14K9tBEAemjQA+dVdPXaX6
         5lFUeYWYjPMYY9p52qEDEt3SLsKQS0V9O6kDwZAUxPd2YJ1nB6dJWYi0B1PvHjniwnNx
         +OAIrclVAyJxnL3HL80NJuK/rVMWzawweXYYAUoVN5LnRZ80h6FrvGKs+OwiwueBs3Yk
         rCJ/Yp1dyDjNnLXiZ3aXJkiDnNkRGzanIQNsUxilhIDPlaLcJf+N7ZBZENBaTDX17EGh
         kRtw==
X-Gm-Message-State: APjAAAXsRD+Q3ydkNaXGGifko4B0wIm/+KI4i2/Y8bEY0vjr/W0A+Zvd
        8tKqr/k8BA6JOZvNKh3g7H0RKw==
X-Google-Smtp-Source: APXvYqwxQg+NAs2Vse/7JC7XKbRljy12BFTn812N3+LobN/MkziBGg572m6O3ufj074FvASUgh+8iA==
X-Received: by 2002:a17:902:4c88:: with SMTP id b8mr46419720ple.29.1563387676434;
        Wed, 17 Jul 2019 11:21:16 -0700 (PDT)
Received: from chromium.org ([2620:15c:202:1:fa53:7765:582b:82b9])
        by smtp.gmail.com with ESMTPSA id 131sm29949745pfx.57.2019.07.17.11.21.15
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Wed, 17 Jul 2019 11:21:15 -0700 (PDT)
Message-ID: <5d2f671b.1c69fb81.59c84.dec9@mx.google.com>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20190717172544.GL12119@ziepe.ca>
References: <20190716224518.62556-1-swboyd@chromium.org> <20190716224518.62556-6-swboyd@chromium.org> <f824e3ab-ae2f-8c2f-549a-16569b10966e@infineon.com> <20190717122558.GF12119@ziepe.ca> <5d2f51a7.1c69fb81.6495.fbe8@mx.google.com> <20190717165628.GJ12119@ziepe.ca> <5d2f5570.1c69fb81.f3832.3c3f@mx.google.com> <20190717171216.GK12119@ziepe.ca> <5d2f594d.1c69fb81.baadd.d81d@mx.google.com> <20190717172544.GL12119@ziepe.ca>
Subject: Re: [PATCH v2 5/6] tpm: add driver for cr50 on SPI
To:     Jason Gunthorpe <jgg@ziepe.ca>
Cc:     Alexander Steffen <Alexander.Steffen@infineon.com>,
        Peter Huewe <peterhuewe@gmx.de>,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        Andrey Pronin <apronin@chromium.org>,
        linux-kernel@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-integrity@vger.kernel.org,
        Duncan Laurie <dlaurie@chromium.org>,
        Guenter Roeck <groeck@chromium.org>
From:   Stephen Boyd <swboyd@chromium.org>
User-Agent: alot/0.8.1
Date:   Wed, 17 Jul 2019 11:21:14 -0700
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Quoting Jason Gunthorpe (2019-07-17 10:25:44)
> On Wed, Jul 17, 2019 at 10:22:20AM -0700, Stephen Boyd wrote:
> > Quoting Jason Gunthorpe (2019-07-17 10:12:16)
> > > On Wed, Jul 17, 2019 at 10:05:52AM -0700, Stephen Boyd wrote:
> > > >=20
> > > > Yes. The space savings comes from having the extra module 'cr50.ko'=
 that
> > > > holds almost nothing at all when the two drivers are modules.
> > >=20
> > > I'm not sure it is an actual savings, there is alot of minimum
> > > overhead and alignment to have a module in the first place.
> > >=20
> >=20
> > Yeah. I'm pretty sure that's why it's a bool and not a tristate for this
> > symbol. A module has overhead that is not necessary for these little
> > helpers.
>=20
> Linking driver stuff like that to the kernel is pretty hacky, IMHO
>=20

So combine lines?

	obj-$(CONFIG_...) +=3D cr50.o cr50_spi.o

Sounds great.

