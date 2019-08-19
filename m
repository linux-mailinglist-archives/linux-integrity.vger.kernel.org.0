Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C84C594B46
	for <lists+linux-integrity@lfdr.de>; Mon, 19 Aug 2019 19:07:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727955AbfHSRHn (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 19 Aug 2019 13:07:43 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:44214 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727268AbfHSRHn (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 19 Aug 2019 13:07:43 -0400
Received: by mail-pg1-f194.google.com with SMTP id i18so1553311pgl.11
        for <linux-integrity@vger.kernel.org>; Mon, 19 Aug 2019 10:07:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=message-id:mime-version:content-transfer-encoding:in-reply-to
         :references:subject:from:cc:to:user-agent:date;
        bh=3OMQTf3yK7q78u6VwxIrK5PQ7iEp7MQrTRs9nqav3N4=;
        b=CWC4H/SU7vBSR/APXIGyNW29L2rr3h50huf6kOUbrKh9tyFjXQ1r9r8lBnHreVFHep
         wXqhwRj4v0rtZzYH+CF2xNjzPglrOygCPdkR/pt6WT1ruhjaWwC23qjFY5YG8RWA8kV+
         OZdFxe5ePpMIKlO2HUoIn5oQ/HcKmcoHc5OAY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:mime-version
         :content-transfer-encoding:in-reply-to:references:subject:from:cc:to
         :user-agent:date;
        bh=3OMQTf3yK7q78u6VwxIrK5PQ7iEp7MQrTRs9nqav3N4=;
        b=KSZjO23Ap1/PX0S8uCPDT5cFqjp+4gGiPhYsx5KRSq4U+g7FzI1M7MghOykH4jpGFm
         6Qb5fGFW0UyDdlkqByf0hdZRmbEeztaYjS8z870j4/Wb2lBFZNzm1jVzinjYkhPHchnA
         5TetZkjMGW2guK+GGgyQxrJ7tEMVOaotUpekfmQlPyAJPl4e41yqJ+NZ/kHwTUFHbRQ+
         BMnwprxLVYSfMagzhPO0I3RNRdsLpG6ogCP3/KT/mDqr1Hk/u914ybO69gIDx1SctkOY
         T3s9IkTgyPGnFjoeEmfDfJcgcHmBozMbBMOwZHkJPDOshNKocmUkngKiUADeyMrIwju3
         r8HQ==
X-Gm-Message-State: APjAAAULSCGbV4tzSfvOgwArwNL3Fh8pIdMEtRAkZG/1a1a/1dZInPgj
        5wB/S/9dRYYHpxv3qB1nkeriZw==
X-Google-Smtp-Source: APXvYqwfZGY7Q3mA79pKJJfgA6abYVvSmVHyI7CShXe712SzqlftGG9P+/o2gKQnkXEM17A6EH81Ww==
X-Received: by 2002:a17:90a:220a:: with SMTP id c10mr22105238pje.33.1566234462694;
        Mon, 19 Aug 2019 10:07:42 -0700 (PDT)
Received: from chromium.org ([2620:15c:202:1:fa53:7765:582b:82b9])
        by smtp.gmail.com with ESMTPSA id d6sm14816037pgf.55.2019.08.19.10.07.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Aug 2019 10:07:42 -0700 (PDT)
Message-ID: <5d5ad75e.1c69fb81.43fc3.5a77@mx.google.com>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20190819163505.wnyhgrtg4akiifdn@linux.intel.com>
References: <20190812223622.73297-1-swboyd@chromium.org> <20190812223622.73297-4-swboyd@chromium.org> <20190819163505.wnyhgrtg4akiifdn@linux.intel.com>
Subject: Re: [PATCH v4 3/6] tpm: tpm_tis_spi: Add a pre-transfer callback
From:   Stephen Boyd <swboyd@chromium.org>
Cc:     Peter Huewe <peterhuewe@gmx.de>, linux-kernel@vger.kernel.org,
        linux-integrity@vger.kernel.org,
        Andrey Pronin <apronin@chromium.org>,
        Duncan Laurie <dlaurie@chromium.org>,
        Jason Gunthorpe <jgg@ziepe.ca>, Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Guenter Roeck <groeck@chromium.org>,
        Alexander Steffen <Alexander.Steffen@infineon.com>
To:     Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
User-Agent: alot/0.8.1
Date:   Mon, 19 Aug 2019 10:07:41 -0700
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Quoting Jarkko Sakkinen (2019-08-19 09:35:05)
> On Mon, Aug 12, 2019 at 03:36:19PM -0700, Stephen Boyd wrote:
> > Cr50 firmware has a requirement to wait for the TPM to wakeup before
> > sending commands over the SPI bus. Otherwise, the firmware could be in
> > deep sleep and not respond. Add a hook to tpm_tis_spi_transfer() before
> > we start a SPI transfer so we can keep track of the last time the TPM
> > driver accessed the SPI bus.
> >=20
> > Cc: Andrey Pronin <apronin@chromium.org>
> > Cc: Duncan Laurie <dlaurie@chromium.org>
> > Cc: Jason Gunthorpe <jgg@ziepe.ca>
> > Cc: Arnd Bergmann <arnd@arndb.de>
> > Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > Cc: Guenter Roeck <groeck@chromium.org>
> > Cc: Alexander Steffen <Alexander.Steffen@infineon.com>
> > Signed-off-by: Stephen Boyd <swboyd@chromium.org>
> > ---
> >  drivers/char/tpm/tpm_tis_spi.c | 3 +++
> >  1 file changed, 3 insertions(+)
> >=20
> > diff --git a/drivers/char/tpm/tpm_tis_spi.c b/drivers/char/tpm/tpm_tis_=
spi.c
> > index 819602e85b34..93f49b1941f0 100644
> > --- a/drivers/char/tpm/tpm_tis_spi.c
> > +++ b/drivers/char/tpm/tpm_tis_spi.c
> > @@ -44,6 +44,7 @@ struct tpm_tis_spi_phy {
> >       struct spi_device *spi_device;
> >       int (*flow_control)(struct tpm_tis_spi_phy *phy,
> >                           struct spi_transfer *xfer);
> > +     void (*pre_transfer)(struct tpm_tis_spi_phy *phy);
>=20
> A callback should have somewhat well defined purpose. A callback named
> as pre_transfer() could have any purpose.
>=20

Any name is fine for me. Any suggestions?

