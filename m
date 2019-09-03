Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3AD23A7107
	for <lists+linux-integrity@lfdr.de>; Tue,  3 Sep 2019 18:52:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729056AbfICQwK (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 3 Sep 2019 12:52:10 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:45523 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729557AbfICQwK (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 3 Sep 2019 12:52:10 -0400
Received: by mail-pg1-f193.google.com with SMTP id 4so5911314pgm.12
        for <linux-integrity@vger.kernel.org>; Tue, 03 Sep 2019 09:52:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=message-id:mime-version:content-transfer-encoding:in-reply-to
         :references:cc:subject:to:from:user-agent:date;
        bh=h8ngCQI7EcgQWs7APOFWbvcG4aSSwNLHZV1kuBNnkzI=;
        b=YuGW0e5HrYZ6b94ppeM5MXTtua4CcL16l3ub8KkaJuMmVJgtVIA/KuvNZdHKhrB1aP
         b3xLah9iPDQQvqGgTvGVB8dqgoQ9yfLVsPeFjXoqLZvmFulF6BltLka8xKVVoApPI6WU
         4RodOC944LFAyTo5JOofVH8PPXRQOMmmtgcaA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:mime-version
         :content-transfer-encoding:in-reply-to:references:cc:subject:to:from
         :user-agent:date;
        bh=h8ngCQI7EcgQWs7APOFWbvcG4aSSwNLHZV1kuBNnkzI=;
        b=Fn4qOJeLfwigsvTrWMzNmzi9yuVp9L5pC1kiwvRmzXdbxGA4N/TcBTIsg637PC0S8M
         gL4yzlzyQHteQ21/h64yk9oVjJsotZ61EKiTJtA146mv9U7qZmQVEkoj2IGsMpdX/PGj
         fiUVI9WChxcUrV3Oh2B+zDZaTsVj8zy2X2c1TSeec19oEm/Z/xPoB1ECER6oc+137pBn
         ZsGkXuhmJeQ0zNM+Gt1BWPp3KtkdDZGymB5cmVCH7GedqpKmprWAymetca9qt6juvNj5
         UMwOawif21QvXjr7eHp0C0cUNNB0FJb6vZHLFOC+IZjrR2HJS2u3B2S7e3M6mFtdmdNI
         RM2A==
X-Gm-Message-State: APjAAAVcMoGTUkoC2JB5f19ZNEOuV1q+8qHRmunBwUVwARdTLSGhiNHa
        tWQ6gaACs+RSjEYqFab2zY122w==
X-Google-Smtp-Source: APXvYqwtlv4autqI3NKfe7BRjyKjRftw9BYTCaZgTZpqVeHhpReslgkrKgkusl97Sb4RiFhhgxGohA==
X-Received: by 2002:a63:ee08:: with SMTP id e8mr31805414pgi.70.1567529529306;
        Tue, 03 Sep 2019 09:52:09 -0700 (PDT)
Received: from chromium.org ([2620:15c:202:1:fa53:7765:582b:82b9])
        by smtp.gmail.com with ESMTPSA id v12sm16966488pff.40.2019.09.03.09.52.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Sep 2019 09:52:08 -0700 (PDT)
Message-ID: <5d6e9a38.1c69fb81.ad03c.cb4c@mx.google.com>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <a950f3986375ee4893dff156dc2f9554338c27d8.camel@linux.intel.com>
References: <20190829224110.91103-1-swboyd@chromium.org> <20190829224110.91103-5-swboyd@chromium.org> <a950f3986375ee4893dff156dc2f9554338c27d8.camel@linux.intel.com>
Cc:     Andrey Pronin <apronin@chromium.org>, linux-kernel@vger.kernel.org,
        linux-integrity@vger.kernel.org,
        Duncan Laurie <dlaurie@chromium.org>,
        Jason Gunthorpe <jgg@ziepe.ca>, Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Guenter Roeck <groeck@chromium.org>,
        Alexander Steffen <Alexander.Steffen@infineon.com>,
        Heiko Stuebner <heiko@sntech.de>
Subject: Re: [PATCH v6 4/4] tpm: tpm_tis_spi: Support cr50 devices
To:     Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        Peter Huewe <peterhuewe@gmx.de>
From:   Stephen Boyd <swboyd@chromium.org>
User-Agent: alot/0.8.1
Date:   Tue, 03 Sep 2019 09:52:07 -0700
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Quoting Jarkko Sakkinen (2019-09-03 09:39:51)
> On Thu, 2019-08-29 at 15:41 -0700, Stephen Boyd wrote:
> > From: Andrey Pronin <apronin@chromium.org>
> >=20
> > Add TPM2.0 PTP FIFO compatible SPI interface for chips with Cr50
> > firmware. The firmware running on the currently supported H1 Secure
> > Microcontroller requires a special driver to handle its specifics:
> >=20
> >  - need to ensure a certain delay between SPI transactions, or else
> >    the chip may miss some part of the next transaction
> >  - if there is no SPI activity for some time, it may go to sleep,
> >    and needs to be waken up before sending further commands
> >  - access to vendor-specific registers
> >=20
> > Cr50 firmware has a requirement to wait for the TPM to wakeup before
> > sending commands over the SPI bus. Otherwise, the firmware could be in
> > deep sleep and not respond. The method to wait for the device to wakeup
> > is slightly different than the usual flow control mechanism described in
> > the TCG SPI spec. Add a completion to tpm_tis_spi_transfer() before we
> > start a SPI transfer so we can keep track of the last time the TPM
> > driver accessed the SPI bus to support the flow control mechanism.
> >=20
> > Split the cr50 logic off into a different file to keep it out of the
> > normal code flow of the existing SPI driver while making it all part of
> > the same module when the code is optionally compiled into the same
> > module. Export a new function, tpm_tis_spi_init(), and the associated
> > read/write/transfer APIs so that we can do this. Make the cr50 code wrap
> > the tpm_tis_spi_phy struct with its own struct to override the behavior
> > of tpm_tis_spi_transfer() by supplying a custom flow control hook. This
> > shares the most code between the core driver and the cr50 support
> > without combining everything into the core driver or exporting module
> > symbols.
> >=20
> > Signed-off-by: Andrey Pronin <apronin@chromium.org>
> > Cc: Andrey Pronin <apronin@chromium.org>
> > Cc: Duncan Laurie <dlaurie@chromium.org>
> > Cc: Jason Gunthorpe <jgg@ziepe.ca>
> > Cc: Arnd Bergmann <arnd@arndb.de>
> > Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > Cc: Guenter Roeck <groeck@chromium.org>
> > Cc: Alexander Steffen <Alexander.Steffen@infineon.com>
> > Cc: Heiko Stuebner <heiko@sntech.de>
>=20
> Had to time to look at this patch set after all before LPC. I just
> realized that the kconfig has taken away. Not sure why is that
> because there's been only request to not have a new LKM. There
> still should be ability opt-out to have Cr50 support in vmlinux.
>=20

That's fair. I'll put the Kconfig option back. There's still the small
issue of what to do about the module name. Should I rename the
tpm_tis_spi.c file to something else so that the module can keep the
same name? Or was the tpm_tis_spi_mod.ko trick from v5 good enough?

