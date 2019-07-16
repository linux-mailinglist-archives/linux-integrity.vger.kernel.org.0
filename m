Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B2F0B6AE98
	for <lists+linux-integrity@lfdr.de>; Tue, 16 Jul 2019 20:28:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388462AbfGPS2y (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 16 Jul 2019 14:28:54 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:46748 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388358AbfGPS2y (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 16 Jul 2019 14:28:54 -0400
Received: by mail-pg1-f195.google.com with SMTP id i8so9832267pgm.13
        for <linux-integrity@vger.kernel.org>; Tue, 16 Jul 2019 11:28:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=message-id:mime-version:content-transfer-encoding:in-reply-to
         :references:from:to:subject:cc:user-agent:date;
        bh=zvGcK+VeZ8cxUQUUb/Ziua1dyjBrgzj1NF9vZ94FkTY=;
        b=HaFxzYUquBICo8Qa2dhDAMayVb4+B8XnoZq6FveM6TFEZ4xttZwMrCmGGANC/QGVlw
         u+Q8JPimlFkaChFUdUbnRKD6m1PJup0MyZsBkdRyVka7yI9ODuShs0+cBre686lEzvVj
         jGQyqpkhbiFKGwnAmGCcyqaMlrf7d6Hd+QgwM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:mime-version
         :content-transfer-encoding:in-reply-to:references:from:to:subject:cc
         :user-agent:date;
        bh=zvGcK+VeZ8cxUQUUb/Ziua1dyjBrgzj1NF9vZ94FkTY=;
        b=ffnYTYSXZn72HmjeKamMNpf774umPcbo7uClJAaamZ/vsgppnvuMYCr9XtphDtGyKG
         +x8Ty1RKvPhc0DAYnmkh5csFDzmC5bsCR0SY+pB67324eftWJXi6vwLKBBC8wR8qgonw
         4vm01hP4+4D1n3TVIJeorrL7cZicq1bcehb/ONGVR15B9JZR3GJmUd1NXsF4unS1iHjD
         yQ8qPxZ9zBLEl8cn35cI0+oqh6a1kIUGmR+RRdiTQrGkc+MZvTTncF9Rfld2+F/DQycg
         zTYP7EFcEnmRz7C749Dv7eC8q1SPLP0u7SzD9DAthGwyV56amnHMS1C+YgNiKSSrg5ej
         JpZw==
X-Gm-Message-State: APjAAAXPjfaJOmJo2+gaA4KQ7bwhkzpDyP8moaTxmkuG+5Z4AcZzL4Aw
        A6wZMUtiwwa4Q/NsK/JrILHKuA==
X-Google-Smtp-Source: APXvYqz4qZBoRB6OmcdQOJn/RkfEoww9MxRhFBGtRytBBWzy2H7BHROzWqtrB66vhSitRPsWPlDCmg==
X-Received: by 2002:a63:5550:: with SMTP id f16mr17160524pgm.426.1563301733618;
        Tue, 16 Jul 2019 11:28:53 -0700 (PDT)
Received: from chromium.org ([2620:15c:202:1:fa53:7765:582b:82b9])
        by smtp.gmail.com with ESMTPSA id x8sm18949101pfa.46.2019.07.16.11.28.52
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Tue, 16 Jul 2019 11:28:52 -0700 (PDT)
Message-ID: <5d2e1764.1c69fb81.448bb.65c0@mx.google.com>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20190624142654.zprcpz42hivuyrjq@gondor.apana.org.au>
References: <20190613180931.65445-1-swboyd@chromium.org> <20190613180931.65445-2-swboyd@chromium.org> <20190613232613.GH22901@ziepe.ca> <5d03e394.1c69fb81.f028c.bffb@mx.google.com> <20190617225134.GA30762@ziepe.ca> <5d0c2cd6.1c69fb81.e66af.32bf@mx.google.com> <20190624142654.zprcpz42hivuyrjq@gondor.apana.org.au>
From:   Stephen Boyd <swboyd@chromium.org>
To:     Herbert Xu <herbert@gondor.apana.org.au>
Subject: Re: [PATCH 1/8] tpm: block messages while suspended
Cc:     Jason Gunthorpe <jgg@ziepe.ca>, Peter Huewe <peterhuewe@gmx.de>,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        Andrey Pronin <apronin@chromium.org>,
        linux-kernel@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-integrity@vger.kernel.org, devicetree@vger.kernel.org,
        Duncan Laurie <dlaurie@chromium.org>,
        Guenter Roeck <groeck@chromium.org>,
        Matt Mackall <mpm@selenic.com>, linux-crypto@vger.kernel.org
User-Agent: alot/0.8.1
Date:   Tue, 16 Jul 2019 11:28:51 -0700
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Quoting Herbert Xu (2019-06-24 07:26:54)
> On Thu, Jun 20, 2019 at 06:03:17PM -0700, Stephen Boyd wrote:
> >
> > What do you think of the attached patch? I haven't tested it, but it
> > would make sure that the kthread is frozen so that the hardware can be
> > resumed before the kthread is thawed and tries to go touch the hardware.
>=20
> Looks good to me.
>=20

Thanks for checking. I haven't been able to reproduce the problem yet to
confirm this is actually fixing anything, even after tweaking the sysctl
values for khwrng to try and force the thread to run continuously.

From reading the bug report that caused this 'is_suspended' code to be
added to the driver I'm fairly convinced this is the right solution. To
give some more background, it looks like we use s2idle suspend (i.e.
all CPUs are idle across suspend) and then we have the kthread running
to ask the hardware for some more random numbers. The i2c transaction
fails when asking the hwrng for data, and we see these messages printed
on the resume path:

	i2c_designware i2c_designware.2: i2c_dw_handle_tx_abort: lost arbitration
	tpm tpm0: i2c transfer failed (attempt 3/3): -11
	tpm0: tpm_transmit: tpm_send: error -11
	hwrng: no data available

Userspace tasks are thawed after this failure so it looks like something
in the kernel kicks khwrng to grab more data before the i2c bus can be
resumed.

