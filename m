Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 00DBC6BFB5
	for <lists+linux-integrity@lfdr.de>; Wed, 17 Jul 2019 18:37:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727189AbfGQQgP (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 17 Jul 2019 12:36:15 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:35634 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726494AbfGQQgP (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 17 Jul 2019 12:36:15 -0400
Received: by mail-pf1-f194.google.com with SMTP id u14so11114044pfn.2
        for <linux-integrity@vger.kernel.org>; Wed, 17 Jul 2019 09:36:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=message-id:mime-version:content-transfer-encoding:in-reply-to
         :references:subject:to:cc:from:user-agent:date;
        bh=N0IoPmcNnKM1kJS4mNJCWU46BnLTmxMTIU2UXP3rmdY=;
        b=gGwLB/cqZp7GUACZiJefpZ+436oxp6o5vUK/UHpTJEZ5ybBSbWRkxVyrBlO51X/pRO
         Y0GIwnOit9Apb0qPbP6NQUg6vB075BQmAQGmJnuCtgd4AnW6yh/gM7ZXu1xosrCcpCDx
         OYwQPO5XWGEmJndS2NTvsC9uByZIT26cMlTxg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:mime-version
         :content-transfer-encoding:in-reply-to:references:subject:to:cc:from
         :user-agent:date;
        bh=N0IoPmcNnKM1kJS4mNJCWU46BnLTmxMTIU2UXP3rmdY=;
        b=M+dyKxJj81XcJuPCUDBlvv2vyozIewiULZ42+tsJMcznbV3PB7FAc4zX2tIFOBq99b
         Ducc4nsW5BoUnEjHuDvsX3nd/HS6k4d1eXz8sQ06+TobNfUfEHVspLPu7KZqw+nb9yXb
         WabEcN6rcoTMCtnHAtnm0NpwahsY0qMQAxzZC4tkc7lFBEOK0hwzlIGZKZWUV9SUzFDn
         rthDArYfsYCdbvXU/DwnC+H0zUnUTeUgyW/xXqSBkMlckKpGYSV1WYExHW7H3lTWkelJ
         3aldgMsxWMv3ce+p7cBwZjbidUhpHSmfP9bzFJkuciCoJrPM2G3LCtQx0+18KUpc2KZy
         t7sg==
X-Gm-Message-State: APjAAAUGANhk2YVJ4/GnCVcKYEXtNdw/hSY60Ww1Be+cd24evNqeAmet
        BVdgCRP75ACciWHEJX7nTaKhst8/occ=
X-Google-Smtp-Source: APXvYqzPufMfZtIVtI7KWAsUsFBG9Ul/hFXQVV9hNpvbfysqLMXz+uKIFTGNmcwAXONITnFmYlYZEQ==
X-Received: by 2002:a65:690f:: with SMTP id s15mr37742190pgq.432.1563381374496;
        Wed, 17 Jul 2019 09:36:14 -0700 (PDT)
Received: from chromium.org ([2620:15c:202:1:fa53:7765:582b:82b9])
        by smtp.gmail.com with ESMTPSA id b30sm36977484pfr.117.2019.07.17.09.36.13
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Wed, 17 Jul 2019 09:36:14 -0700 (PDT)
Message-ID: <5d2f4e7e.1c69fb81.a9a8c.a3d2@mx.google.com>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20190717014359.5xcnubpmazl3vqg5@gondor.apana.org.au>
References: <20190716224518.62556-1-swboyd@chromium.org> <20190716224518.62556-2-swboyd@chromium.org> <20190717014359.5xcnubpmazl3vqg5@gondor.apana.org.au>
Subject: Re: [PATCH v2 1/6] hwrng: core: Freeze khwrng thread during suspend
To:     Herbert Xu <herbert@gondor.apana.org.au>
Cc:     Peter Huewe <peterhuewe@gmx.de>,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        linux-kernel@vger.kernel.org, Jason Gunthorpe <jgg@ziepe.ca>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-integrity@vger.kernel.org,
        Andrey Pronin <apronin@chromium.org>,
        Duncan Laurie <dlaurie@chromium.org>,
        Guenter Roeck <groeck@chromium.org>
From:   Stephen Boyd <swboyd@chromium.org>
User-Agent: alot/0.8.1
Date:   Wed, 17 Jul 2019 09:36:13 -0700
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Quoting Herbert Xu (2019-07-16 18:43:59)
> On Tue, Jul 16, 2019 at 03:45:13PM -0700, Stephen Boyd wrote:
> > The hwrng_fill() function can run while devices are suspending and
> > resuming. If the hwrng is behind a bus such as i2c or SPI and that bus
> > is suspended, the hwrng may hang the bus while attempting to add some
> > randomness. It's been observed on ChromeOS devices with suspend-to-idle
> > (s2idle) and an i2c based hwrng that this kthread may run and ask the
> > hwrng device for randomness before the i2c bus has been resumed.
> >=20
> > Let's make this kthread freezable so that we don't try to touch the
> > hwrng during suspend/resume. This ensures that we can't cause the hwrng
> > backing driver to get into a bad state because the device is guaranteed
> > to be resumed before the hwrng kthread is thawed.
> >=20
> > Cc: Andrey Pronin <apronin@chromium.org>
> > Cc: Herbert Xu <herbert@gondor.apana.org.au>
> > Cc: Duncan Laurie <dlaurie@chromium.org>
> > Signed-off-by: Stephen Boyd <swboyd@chromium.org>
> > ---
> >  drivers/char/hw_random/core.c | 5 ++++-
> >  1 file changed, 4 insertions(+), 1 deletion(-)
>=20
> Do you want this to go through the crypto tree? If so you need
> to cc the linux-crypto mailing list.
>=20

Sure. I'll resend just this one Cced to the linux-crypto list and to
you.

