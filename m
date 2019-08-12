Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2DFD28A890
	for <lists+linux-integrity@lfdr.de>; Mon, 12 Aug 2019 22:46:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726770AbfHLUqi (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 12 Aug 2019 16:46:38 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:35210 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726690AbfHLUqi (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 12 Aug 2019 16:46:38 -0400
Received: by mail-pg1-f196.google.com with SMTP id n4so8345407pgv.2
        for <linux-integrity@vger.kernel.org>; Mon, 12 Aug 2019 13:46:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=message-id:mime-version:content-transfer-encoding:in-reply-to
         :references:subject:from:cc:to:user-agent:date;
        bh=9CfjXilodmw9BsgbwaSAlw+obuKZRe+IX22W8bs4rYc=;
        b=IkVsjy3Qlswuptc8SNo3wFzVDH0wtJRsCr4rT8zG3fa+YDeYAYgW3a1Gbw/ow7XJMJ
         jV4pTeMYAtCVs9ZBCZNbgn1B8wi29HRiG5r9Dwa0uZcPQFyabZVeeEwAW//9DoQ2iGQU
         Qgfxy8Is7G+w517i9KgGGkwO1Ml89RglKyUZc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:mime-version
         :content-transfer-encoding:in-reply-to:references:subject:from:cc:to
         :user-agent:date;
        bh=9CfjXilodmw9BsgbwaSAlw+obuKZRe+IX22W8bs4rYc=;
        b=roLJLnccNRFu8BF6bC4RgYwZBKKSD1GDRE1x6INbDGFUlJZQLC4u4g00A5L5j1Pp9v
         1BsSPT+QbIvZae3CyWPTG+YczjRYNj3D7fr24QFAq0OI5/0rG383Kf9Dm6kAWGkVv1vK
         +sz4xH3ywaomU1ZONJUVpi9ehXvckoaLVZXJtk0WNeJLNSU+kdgANeyfxxT6/spMw8Yx
         NQTRbYHT+8ybppn3wRNyaR9QN5ZTDLxkc4QXaqEPTuO8dEBOsfkYRE3keb21cpiE6qzC
         SL+ZjRxqcqq4TL4kPjMFSTFv9hoHanLkkrnY/+Qxw9iib5Jw0bQEsBYUc77OYBUjjF6h
         OkUg==
X-Gm-Message-State: APjAAAWcp5YJ9ZbHjrlt9fjfeK66TGo7YcrTXV6nS7QmpkqBlTGTL2dH
        eCWS0jt4TvwvqyNJWCF5LII6OA==
X-Google-Smtp-Source: APXvYqyDQqDbCcR+d7VFmdaWIiHiJ6hJdgKP21T2ghZY/bltbjkjp+2smqWYE/yUIBH9VWiQmY5Slg==
X-Received: by 2002:a63:4612:: with SMTP id t18mr31918123pga.85.1565642797467;
        Mon, 12 Aug 2019 13:46:37 -0700 (PDT)
Received: from chromium.org ([2620:15c:202:1:fa53:7765:582b:82b9])
        by smtp.gmail.com with ESMTPSA id k36sm107716672pgl.42.2019.08.12.13.46.36
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 12 Aug 2019 13:46:36 -0700 (PDT)
Message-ID: <5d51d02c.1c69fb81.6f113.f06a@mx.google.com>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <e7951cb251116e903cf0040ee6f271dc4e68ff2e.camel@linux.intel.com>
References: <20190806220750.86597-1-swboyd@chromium.org> <20190806220750.86597-5-swboyd@chromium.org> <e7951cb251116e903cf0040ee6f271dc4e68ff2e.camel@linux.intel.com>
Subject: Re: [PATCH v3 4/4] tpm: add driver for cr50 on SPI
From:   Stephen Boyd <swboyd@chromium.org>
Cc:     Andrey Pronin <apronin@chromium.org>, linux-kernel@vger.kernel.org,
        linux-integrity@vger.kernel.org,
        Duncan Laurie <dlaurie@chromium.org>,
        Jason Gunthorpe <jgg@ziepe.ca>, Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Guenter Roeck <groeck@chromium.org>,
        Alexander Steffen <Alexander.Steffen@infineon.com>
To:     Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        Peter Huewe <peterhuewe@gmx.de>
User-Agent: alot/0.8.1
Date:   Mon, 12 Aug 2019 13:46:35 -0700
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Quoting Jarkko Sakkinen (2019-08-09 13:31:04)
> On Tue, 2019-08-06 at 15:07 -0700, Stephen Boyd wrote:
> > From: Andrey Pronin <apronin@chromium.org>
> >=20
> > Add TPM2.0 PTP FIFO compatible SPI interface for chips with Cr50
> > firmware. The firmware running on the currently supported H1
> > Secure Microcontroller requires a special driver to handle its
> > specifics:
> >=20
> >  - need to ensure a certain delay between spi transactions, or else
> >    the chip may miss some part of the next transaction;
> >  - if there is no spi activity for some time, it may go to sleep,
> >    and needs to be waken up before sending further commands;
> >  - access to vendor-specific registers.
>=20
> Which Chromebook models have this chip?

Pretty much all Chromebooks released in the last year or two have this
chip in them. I don't have an exhaustive list, but you can usually check
this by putting your device into dev mode and then looking at the driver
attached to the TPM device in sysfs or by grepping the dmesg output for
cr50.

>=20
> If I had an access to one, how do I do kernel testing with it i.e.
> how do I get it to boot initramfs and bzImage from a USB stick?
>=20
>=20

You can follow the developer guide[1] and build a USB image for the
board you have. You can usually checkout the latest upstream kernel in
place of where the kernel is built from in the chroot, typically
~/trunk/src/third_party/kernel/<version number>. The build should pick
up that it's an upstream tree and try to use some default defconfig.
This driver isn't upstream yet, so you may need to enable it in the
defconfig, located in
~/trunk/src/third_party/chromiumos-overlay/eclass/cros-kernel/ so that
the driver is actually built. After that, use 'cros flash' to flash the
new kernel image to your USB stick and boot from USB with 'ctrl+u' and
you should be on your way to chromeos kernel testing.

[1] https://chromium.googlesource.com/chromiumos/docs/+/master/developer_gu=
ide.md

