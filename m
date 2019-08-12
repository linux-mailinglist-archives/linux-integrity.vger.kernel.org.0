Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 23F7E8A07B
	for <lists+linux-integrity@lfdr.de>; Mon, 12 Aug 2019 16:16:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726682AbfHLOQP (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 12 Aug 2019 10:16:15 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:45565 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726579AbfHLOQP (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 12 Aug 2019 10:16:15 -0400
Received: by mail-pf1-f195.google.com with SMTP id w26so4492213pfq.12
        for <linux-integrity@vger.kernel.org>; Mon, 12 Aug 2019 07:16:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=message-id:mime-version:content-transfer-encoding:in-reply-to
         :references:subject:from:cc:to:user-agent:date;
        bh=4+IxFmcczn6w0IUyxNclj/z/O54y2p3yNKEitHl1YCg=;
        b=TEtlpoZjJG3S9Vk8AuZ9w3eWebrsx2oy57Mz6EW5bfwt+PEVz38MLfQDGSkDt2jjbk
         D6PTeTmGtc6EFWdvkklBfDZjlq2QNhrZnQa6lgTKzKOEFB6FUtaACBYds3TT0XIHOobu
         m9gaNn0eDPcz28Cn4bPcqtr2NkLrlEfsxgeyc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:mime-version
         :content-transfer-encoding:in-reply-to:references:subject:from:cc:to
         :user-agent:date;
        bh=4+IxFmcczn6w0IUyxNclj/z/O54y2p3yNKEitHl1YCg=;
        b=PR3vuJ3Aso88d7L0t7pe+D7rzO+D1gy4dJGFifP1FaiIcwrj8ZmBNhSB/R6c0xMB4r
         crTS3GDd+URkc6loGlliP6yLFHSAZUc7+oAb9gBq9BxPiLwPpeKFCaPvKIXkcbtVcbfK
         GpHUGD8wkp6DAx00MKWrHabQpTzbCmWUeIsv43m4NuJR2aD84lerxFJ4mA+fG6GiGm6r
         glsOSCmH5VuSB7fMLuD3wjYWo9j0ldIzoCT26AetGzMHAnASLNS1iZWdFi1/mVN172vN
         rG9VYQ0yGzJCms5ONHjp995vQR17yK6Q+0ljHhUDG/9a6w/k9eebB/FjxX79tyUgk8zE
         0SPA==
X-Gm-Message-State: APjAAAVvNb+a6orqDMqSVG7ULLWTZlZRNdRDWk1Rx5qhOzhUNpY5AsHz
        tsZEssUc2DXjjUyWHTA5jp9mKw==
X-Google-Smtp-Source: APXvYqxDfttKUcmHsgU/Xg053HVQ+iP2DBqp6JswvMD+CUZv/8p7Qt9eF+EOEyeg6kNVnw+Q/T5xpg==
X-Received: by 2002:aa7:8201:: with SMTP id k1mr34931618pfi.97.1565619374901;
        Mon, 12 Aug 2019 07:16:14 -0700 (PDT)
Received: from chromium.org ([2620:15c:202:1:fa53:7765:582b:82b9])
        by smtp.gmail.com with ESMTPSA id i15sm111311568pfd.160.2019.08.12.07.16.14
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 12 Aug 2019 07:16:14 -0700 (PDT)
Message-ID: <5d5174ae.1c69fb81.85930.8e93@mx.google.com>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <f441fd9a5452bf2943e5dbe6d74b5d5f26016a90.camel@linux.intel.com>
References: <20190806220750.86597-1-swboyd@chromium.org> <20190806220750.86597-3-swboyd@chromium.org> <f441fd9a5452bf2943e5dbe6d74b5d5f26016a90.camel@linux.intel.com>
Subject: Re: [PATCH v3 2/4] tpm: tpm_tis_spi: Export functionality to other drivers
From:   Stephen Boyd <swboyd@chromium.org>
Cc:     linux-kernel@vger.kernel.org, linux-integrity@vger.kernel.org,
        Andrey Pronin <apronin@chromium.org>,
        Duncan Laurie <dlaurie@chromium.org>,
        Jason Gunthorpe <jgg@ziepe.ca>, Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Guenter Roeck <groeck@chromium.org>,
        Alexander Steffen <Alexander.Steffen@infineon.com>
To:     Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        Peter Huewe <peterhuewe@gmx.de>
User-Agent: alot/0.8.1
Date:   Mon, 12 Aug 2019 07:16:13 -0700
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Quoting Jarkko Sakkinen (2019-08-09 13:28:13)
> On Tue, 2019-08-06 at 15:07 -0700, Stephen Boyd wrote:
> > We want to use most of the code in this driver, except we want to modify
> > the flow control and idle behavior. Let's "libify" this driver so that
> > another driver can call the code in here and slightly tweak the
> > behavior.
>=20
> Neither "libifying" nor "slightly tweaking" gives an idea what the
> commit does. A great commit message should be in imperative form
> describe what it does and why in as plain english as possible.
>=20
> Often commit messages are seen just as a necessary bad and not much
> energy is spent on them but for a maitainer solid commit messages have
> an indispensable value.
>=20
> > +     void (*pre_transfer)(struct tpm_tis_spi_phy *phy);
>=20
> Adding a new calback should be a commit of its own.
>=20

Ok. I will do that and focus the commit message.

