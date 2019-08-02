Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A040E80330
	for <lists+linux-integrity@lfdr.de>; Sat,  3 Aug 2019 01:25:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389382AbfHBXZI (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 2 Aug 2019 19:25:08 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:40851 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389365AbfHBXZH (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 2 Aug 2019 19:25:07 -0400
Received: by mail-pf1-f194.google.com with SMTP id p184so36743821pfp.7
        for <linux-integrity@vger.kernel.org>; Fri, 02 Aug 2019 16:25:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=message-id:mime-version:content-transfer-encoding:in-reply-to
         :references:subject:from:cc:to:user-agent:date;
        bh=2tknq8ha5U7BNuuyVatdtjPrjoFm8FVQiAPwO+BVgX8=;
        b=mx+c4i+C8tUW+7JDguP35xhR2WoEl5zaNtr74xW7KRFkkEMEawzKZqCutkcuVc6Y+i
         +c4QrhEPS7BAUe3/EsS72++dyo2Zq3xVYCWpZxxU2puKBjHe/IhblCWqnRK9EkwkmYX4
         dNw+cFrWsqbBEDEcSCwakZtYTsUhJudYq3FTY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:mime-version
         :content-transfer-encoding:in-reply-to:references:subject:from:cc:to
         :user-agent:date;
        bh=2tknq8ha5U7BNuuyVatdtjPrjoFm8FVQiAPwO+BVgX8=;
        b=OQ37LjJXO1Fk+nemj453VDtpH0pMcdW5XpEDdNaH6U0iHGdQbEccdBZQ5gg14SdNM8
         HMdAb0ODYG4bez19U2wvJ67RMCG9x1V1GrsmFyknhyGkT3pZuUStDwqeDcK7nCEsyLSG
         UTQPXzdMamCzeEfHQJmh3IfQWqjtFueAseYhkS4pD0Ill8GNJuQjOln82GEs7ic7FBiX
         +oRNk3+TUYGjSul5euQW5dl/cSyOYZ44yRiGFCL7e8BS3arQXhvY40DcEuPOsymQisss
         Snk3PvHGLrkTqGxCPGOK4Rc06WN2fdO8kNeHiqYzbvUZmvT8zZoA0s/HYsAVZV7ukcoU
         2Egg==
X-Gm-Message-State: APjAAAVN3n+M9jNnzDACxpoB086Sv6KJtcr5E4IJio0DkLXRWpTWQS/v
        qNhlgDmYQGzcrxI8QeK9obfMzw==
X-Google-Smtp-Source: APXvYqxNh0B8Wf8ImRp8AspYzF98NGC9VpLKh9ipgxTx9XSVhtLvzsOHEkswTpvOyF0jVuId3lju4w==
X-Received: by 2002:a17:90a:bb94:: with SMTP id v20mr6693868pjr.88.1564787885862;
        Fri, 02 Aug 2019 16:18:05 -0700 (PDT)
Received: from chromium.org ([2620:15c:202:1:fa53:7765:582b:82b9])
        by smtp.gmail.com with ESMTPSA id j16sm7485490pjz.31.2019.08.02.16.18.04
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Fri, 02 Aug 2019 16:18:05 -0700 (PDT)
Message-ID: <5d44c4ad.1c69fb81.49b6c.56dd@mx.google.com>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20190802202209.2jzeosacc66mtnpr@linux.intel.com>
References: <20190716224518.62556-1-swboyd@chromium.org> <20190716224518.62556-2-swboyd@chromium.org> <20190802202209.2jzeosacc66mtnpr@linux.intel.com>
Subject: Re: [PATCH v2 1/6] hwrng: core: Freeze khwrng thread during suspend
From:   Stephen Boyd <swboyd@chromium.org>
Cc:     Peter Huewe <peterhuewe@gmx.de>, linux-kernel@vger.kernel.org,
        Jason Gunthorpe <jgg@ziepe.ca>, Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-integrity@vger.kernel.org,
        Andrey Pronin <apronin@chromium.org>,
        Duncan Laurie <dlaurie@chromium.org>,
        Guenter Roeck <groeck@chromium.org>,
        Herbert Xu <herbert@gondor.apana.org.au>
To:     Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
User-Agent: alot/0.8.1
Date:   Fri, 02 Aug 2019 16:18:03 -0700
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Quoting Jarkko Sakkinen (2019-08-02 13:22:09)
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
>=20
> This does not need a fixes tag?
>=20

I'll add Fixes: be4000bc4644 ("hwrng: create filler thread")

