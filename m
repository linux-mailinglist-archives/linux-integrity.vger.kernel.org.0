Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A6D2B6D37F
	for <lists+linux-integrity@lfdr.de>; Thu, 18 Jul 2019 20:11:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390831AbfGRSLX (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 18 Jul 2019 14:11:23 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:32943 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390821AbfGRSLX (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 18 Jul 2019 14:11:23 -0400
Received: by mail-pg1-f193.google.com with SMTP id f20so4017818pgj.0
        for <linux-integrity@vger.kernel.org>; Thu, 18 Jul 2019 11:11:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=message-id:mime-version:content-transfer-encoding:in-reply-to
         :references:subject:to:cc:from:user-agent:date;
        bh=Oi/2nSCZl5jDAyx1D0V8Sj3D1U9nmMvuGs/3txN4dLs=;
        b=FO34q6uaLm8zMLwroznowA90kyY++czA2WHQyfaV6mnFjf5jGTFt08+9o3lcflz51w
         CbSuz9XwblHT6uHyAlDWGJkWmLmlqahDMTRbZYp5mhhtX3q62nkwkuuQixIQKnE1MeS+
         0Di5Gc3s2khA32/6ABJgAZIn0GoG21hfmCrNk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:mime-version
         :content-transfer-encoding:in-reply-to:references:subject:to:cc:from
         :user-agent:date;
        bh=Oi/2nSCZl5jDAyx1D0V8Sj3D1U9nmMvuGs/3txN4dLs=;
        b=CPoyUwZrU2GznRUY9t8rbgbaaVtr9pxKDag+GA29YF8aezffT/eNkU3Cr8NwbykIQD
         zq82I/Ye64NOhd1G50UDYtTNLAkQ3jFFFoFOUSM17kiYPfCs+ZSSACdCexyYLLu7d3r4
         AQO8oDagux6Hscm/zQSUHKKL0bDlWSr2pfheTG4aL/hJ+sHsw1ndlsoK7s3fBqngEX3h
         Rq10BTWXIAZs+snojTzQdmaahRg4Hrj7rv3Ylb+uDCru2Aa53kcPU//O2yNcYcK/GieW
         7IcJPrdzVPv0Drft6jNDNnmWnRihleD5tdqm66xjaiwfhOXtHiXOuJpX84kNJctXu8s4
         9suw==
X-Gm-Message-State: APjAAAVTzMabhIhvb0hKBI8zB54CjtPtAYOhap6ctrG4RI/Mg/h/iM90
        IfKtYzh/R6CZvAaYb7MUMJrcRQ==
X-Google-Smtp-Source: APXvYqzc2W0dJuZWhL96do1jYvmcyY4eFtxD6hnBLu62vFihqIE/+ygYbrFC5jZvdYvepduXEJyOPQ==
X-Received: by 2002:a63:d944:: with SMTP id e4mr48646810pgj.261.1563473482422;
        Thu, 18 Jul 2019 11:11:22 -0700 (PDT)
Received: from chromium.org ([2620:15c:202:1:fa53:7765:582b:82b9])
        by smtp.gmail.com with ESMTPSA id x9sm35259648pfn.177.2019.07.18.11.11.21
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Thu, 18 Jul 2019 11:11:21 -0700 (PDT)
Message-ID: <5d30b649.1c69fb81.f440e.9a0a@mx.google.com>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <b05904bf-00b9-bf30-0fc9-9f363e181d80@infineon.com>
References: <20190716224518.62556-1-swboyd@chromium.org> <20190716224518.62556-6-swboyd@chromium.org> <f824e3ab-ae2f-8c2f-549a-16569b10966e@infineon.com> <5d2f7daf.1c69fb81.c0b13.c3d4@mx.google.com> <5d2f955d.1c69fb81.35877.7018@mx.google.com> <b05904bf-00b9-bf30-0fc9-9f363e181d80@infineon.com>
Subject: Re: [PATCH v2 5/6] tpm: add driver for cr50 on SPI
To:     Alexander Steffen <Alexander.Steffen@infineon.com>,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        Peter Huewe <peterhuewe@gmx.de>
Cc:     Andrey Pronin <apronin@chromium.org>, linux-kernel@vger.kernel.org,
        Jason Gunthorpe <jgg@ziepe.ca>, Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-integrity@vger.kernel.org,
        Duncan Laurie <dlaurie@chromium.org>,
        Guenter Roeck <groeck@chromium.org>
From:   Stephen Boyd <swboyd@chromium.org>
User-Agent: alot/0.8.1
Date:   Thu, 18 Jul 2019 11:11:20 -0700
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Quoting Alexander Steffen (2019-07-18 09:47:22)
> On 17.07.2019 23:38, Stephen Boyd wrote:
> > Quoting Stephen Boyd (2019-07-17 12:57:34)
> >> Quoting Alexander Steffen (2019-07-17 05:00:06)
> >>>
> >>> Can't the code be shared more explicitly, e.g. by cr50_spi wrapping
> >>> tpm_tis_spi, so that it can intercept the calls, execute the addition=
al
> >>> actions (like waking up the device), but then let tpm_tis_spi do the
> >>> common work?
> >>>
> >>
> >> I suppose the read{16,32} and write32 functions could be reused. I'm n=
ot
> >> sure how great it will be if we combine these two drivers, but I can
> >> give it a try today and see how it looks.
> >>
> >=20
> > Here's the patch. I haven't tested it besides compile testing.

The code seems to work but I haven't done any extensive testing besides
making sure that the TPM responds to pcr reads and some commands like
reading random numbers.

>=20
> Thanks for providing this. Makes it much easier to see what the actual=20
> differences between the devices are.
>=20
> Do we have a general policy on how to support devices that are very=20
> similar but need special handling in some places? Not duplicating the=20
> whole driver just to change a few things definitely seems like an=20
> improvement (and has already been done in the past, as with=20
> TPM_TIS_ITPM_WORKAROUND). But should all the code just be added to=20
> tpm_tis_spi.c? Or is there some way to keep a clearer separation,=20
> especially when (in the future) we have multiple devices that all have=20
> their own set of deviations from the spec?
>=20

If you have any ideas on how to do it please let me know. At this point,
I'd prefer if the maintainers could provide direction on what they want.

