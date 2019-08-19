Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 19FD494B54
	for <lists+linux-integrity@lfdr.de>; Mon, 19 Aug 2019 19:10:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726987AbfHSRKK (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 19 Aug 2019 13:10:10 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:35570 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727094AbfHSRKK (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 19 Aug 2019 13:10:10 -0400
Received: by mail-pl1-f193.google.com with SMTP id gn20so1264934plb.2
        for <linux-integrity@vger.kernel.org>; Mon, 19 Aug 2019 10:10:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=message-id:mime-version:content-transfer-encoding:in-reply-to
         :references:subject:from:cc:to:user-agent:date;
        bh=Q5LjT2ulgbJMIcnXziCS32ArOw8FLJpPq0N2+3+iSu4=;
        b=Jk4dW+/LwN6k/bNAcq0KPPAUpc24H3TC+TLKxUEQ3bhKuFr1oQ8S1aHZXN/CKrI0wV
         jZd2fO/fFAahPYk4qF+l0SQSdiE8VJGvaCKjTb6Fhwr6ZzF8ddomL3CF/aN2lzXAwHO3
         /X5T1v7JA4S55Jky3E+HExMyytOt3M4eKTuhk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:mime-version
         :content-transfer-encoding:in-reply-to:references:subject:from:cc:to
         :user-agent:date;
        bh=Q5LjT2ulgbJMIcnXziCS32ArOw8FLJpPq0N2+3+iSu4=;
        b=WjUHEkCQI9U/1XmozE7Htqm9q6owTTJ+CC/P3gWHvgWGRlyQpm4i00oxW1505SVYb8
         r/WEQQ/07RASfaIVLK+Lw5N2qLYROMEGFIzBw58AS4NanILJguTdZh8TNtaCDFlMZ1do
         2JEJdIYcXUO+cqs6wdlYLHObmn1Tjk47F3vvwCize8R0ao32cYqluuPDqYV1b2q4CV1Y
         6/2ulig8D0DQ0W8/4W9c80kPU4yPc5T32KzlDq555DWUFusOdeJbuMIu51xUx5T/DFmD
         htVb3o+Gy9r8rtWttlXsLmZTOtNXYq9kINyZSx7OrJL5x6rTpjHJ68BrJYCbJ+7Dimf+
         F0Cg==
X-Gm-Message-State: APjAAAXxeVU0Tr2sMLMun8zoQDjEgFTHxol5iWP4AAYjtN0zrPhslWkA
        /zq6NOmu8VLz/V48Hlsohcdihw==
X-Google-Smtp-Source: APXvYqybFuJuc6ce88amVXBCJHbvICuLITkB68+9d3DrSh+8NFW3c8v3hvDLcMGBKhpBmHlYtNP5Lw==
X-Received: by 2002:a17:902:988d:: with SMTP id s13mr15192166plp.139.1566234609437;
        Mon, 19 Aug 2019 10:10:09 -0700 (PDT)
Received: from chromium.org ([2620:15c:202:1:fa53:7765:582b:82b9])
        by smtp.gmail.com with ESMTPSA id z6sm25497112pgk.18.2019.08.19.10.10.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Aug 2019 10:10:08 -0700 (PDT)
Message-ID: <5d5ad7f0.1c69fb81.ebfc2.7e1d@mx.google.com>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20190819164005.evg35d2hcuslbnrj@linux.intel.com>
References: <20190812223622.73297-1-swboyd@chromium.org> <20190812223622.73297-5-swboyd@chromium.org> <20190819164005.evg35d2hcuslbnrj@linux.intel.com>
Subject: Re: [PATCH v4 4/6] tpm: tpm_tis_spi: Export functionality to other drivers
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
Date:   Mon, 19 Aug 2019 10:10:08 -0700
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Quoting Jarkko Sakkinen (2019-08-19 09:40:05)
> On Mon, Aug 12, 2019 at 03:36:20PM -0700, Stephen Boyd wrote:
> > Export a new function, tpm_tis_spi_init(), and the associated
> > read/write/transfer APIs so that we can create variant drivers based on
> > the core functionality of this TPM SPI driver. Variant drivers can wrap
> > the tpm_tis_spi_phy struct with their own struct and override the
> > behavior of tpm_tis_spi_transfer() by supplying their own flow control
> > and pre-transfer hooks. This shares the most code between the core
> > driver and any variants that want to override certain behavior without
> > cluttering the core driver.
>=20
> I think this is adding way too much complexity for the purpose. We
> definitely do want this three layer architecture here.
>=20
> Instead there should be a single tpm_tis_spi driver that dynamically
> either TCG or CR50. I rather take some extra bytes in the LKM than
> the added complexity.
>=20

Ok. I had that patch originally[1]. Do you want me to resend that patch
and start review over from there?

[1] https://lkml.kernel.org/r/5d2f955d.1c69fb81.35877.7018@mx.google.com
