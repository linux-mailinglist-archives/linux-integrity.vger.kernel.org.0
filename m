Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9CE656BFDB
	for <lists+linux-integrity@lfdr.de>; Wed, 17 Jul 2019 18:50:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729284AbfGQQtp (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 17 Jul 2019 12:49:45 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:40498 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727331AbfGQQto (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 17 Jul 2019 12:49:44 -0400
Received: by mail-pf1-f195.google.com with SMTP id p184so11111169pfp.7
        for <linux-integrity@vger.kernel.org>; Wed, 17 Jul 2019 09:49:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=message-id:mime-version:content-transfer-encoding:in-reply-to
         :references:subject:to:cc:from:user-agent:date;
        bh=5Fl5Dlb5En2+Wq+o2LvoJPZA7FE64mKY2RfJ/AGSAjg=;
        b=M/7Z9+gDOEv7M8nlkeWZGNUlHiLiUkiZxwSc3n4jfdPNWM8nq23uOTzE9YrocVC6mA
         ZBT/EdbYeCiH/878aDGvzDeCSjfwdU+F4dPXbRJzJt20lFphSw1EcL5j1ZXjvx8gS26h
         0rbXKJHS3Sy2SUDezNgRx+/x694+ydI33ktK0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:mime-version
         :content-transfer-encoding:in-reply-to:references:subject:to:cc:from
         :user-agent:date;
        bh=5Fl5Dlb5En2+Wq+o2LvoJPZA7FE64mKY2RfJ/AGSAjg=;
        b=qlBRfNHPWd+TfDqJAkMPvVbWK6fyPBBFRITK/zAG1UxnHzNV3DQQqKV9gN36desk1O
         PTHACU3M45j76BLkes+k4L+5GKnZvWb8R3SUNnqYi36so0ASVUV4m2tcsLrcKCAqgSaN
         t6tjYMq6yQUaEtgi8naOVQtGUDcxuIlV5oSC4gAYbCsjdP6tb5MT00uqJbPeQojSMdZa
         RVWKeYXA9mL+tGiUamEWZkRjqjH1a7TBSc29/np5suhVqC1IGeKXAnwmCFvRF2yzyvS/
         eD2fygmqE31TZvIFCcmnXJHHZzWIltZ7CuKb2jiRu/tTVeEb2tjDkud3qCk8ExUqDbEN
         wbZA==
X-Gm-Message-State: APjAAAWvshYDJIfCscZ90Jrwo1zddMhmXllTO5CfbsJ94F2+VfPsFQlB
        jCl8ub4O/EqJGwJC06q1LWjVXQ==
X-Google-Smtp-Source: APXvYqw4Ife04xsJ26z+6JtibYR39+gVPDdH9hC1m6zoSzlbBqMUpf4Yyn8uq1P4TAOm/LcO5jxK7g==
X-Received: by 2002:a63:b919:: with SMTP id z25mr41988841pge.201.1563382184041;
        Wed, 17 Jul 2019 09:49:44 -0700 (PDT)
Received: from chromium.org ([2620:15c:202:1:fa53:7765:582b:82b9])
        by smtp.gmail.com with ESMTPSA id r1sm24176724pgv.70.2019.07.17.09.49.43
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Wed, 17 Jul 2019 09:49:43 -0700 (PDT)
Message-ID: <5d2f51a7.1c69fb81.6495.fbe8@mx.google.com>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20190717122558.GF12119@ziepe.ca>
References: <20190716224518.62556-1-swboyd@chromium.org> <20190716224518.62556-6-swboyd@chromium.org> <f824e3ab-ae2f-8c2f-549a-16569b10966e@infineon.com> <20190717122558.GF12119@ziepe.ca>
Subject: Re: [PATCH v2 5/6] tpm: add driver for cr50 on SPI
To:     Alexander Steffen <Alexander.Steffen@infineon.com>,
        Jason Gunthorpe <jgg@ziepe.ca>
Cc:     Peter Huewe <peterhuewe@gmx.de>,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        Andrey Pronin <apronin@chromium.org>,
        linux-kernel@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-integrity@vger.kernel.org,
        Duncan Laurie <dlaurie@chromium.org>,
        Guenter Roeck <groeck@chromium.org>
From:   Stephen Boyd <swboyd@chromium.org>
User-Agent: alot/0.8.1
Date:   Wed, 17 Jul 2019 09:49:42 -0700
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Quoting Jason Gunthorpe (2019-07-17 05:25:58)
> On Wed, Jul 17, 2019 at 02:00:06PM +0200, Alexander Steffen wrote:
> > On 17.07.2019 00:45, Stephen Boyd wrote:
> > > diff --git a/drivers/char/tpm/Kconfig b/drivers/char/tpm/Kconfig
> > > index 88a3c06fc153..b7028bfa6f87 100644
> > > +++ b/drivers/char/tpm/Kconfig
> > > @@ -114,6 +114,22 @@ config TCG_ATMEL
> > >       will be accessible from within Linux.  To compile this driver
> > >       as a module, choose M here; the module will be called tpm_atmel.
> > > +config TCG_CR50
> > > +   bool
> > > +   ---help---
> > > +     Common routines shared by drivers for Cr50-based devices.
> > > +
> >=20
> > Is it a common pattern to add config options that are not useful on the=
ir
> > own? When would I ever enable TCG_CR50 without also enabling TCG_CR50_S=
PI?
> > Why can't you just use TCG_CR50_SPI for everything?
>=20
> This is an internal kconfig symbol, it isn't seen by the user, which
> is a pretty normal pattern.
>=20
> But I don't think the help should be included (since it cannot be
> seen), and I'm pretty sure it should be a tristate

Good point. I'll fix it.

>=20
> But overall, it might be better to just double link the little helper:
>=20
> obj-$(CONFIG_TCG_CR50_SPI) +=3D cr50.o cr50_spi.o
> obj-$(CONFIG_TCG_CR50_I2C) +=3D cr50.o cr50_i2c.o
>=20
> As we don't actually ever expect to load both modules into the same
> system
>=20

Sometimes we have both drivers built-in. To maintain the tiny space
savings I'd prefer to just leave this as helpless and tristate.

