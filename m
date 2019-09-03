Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7CD4AA7260
	for <lists+linux-integrity@lfdr.de>; Tue,  3 Sep 2019 20:15:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727069AbfICSPD (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 3 Sep 2019 14:15:03 -0400
Received: from mail-yw1-f66.google.com ([209.85.161.66]:32948 "EHLO
        mail-yw1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727352AbfICSPD (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 3 Sep 2019 14:15:03 -0400
Received: by mail-yw1-f66.google.com with SMTP id e65so6154176ywh.0;
        Tue, 03 Sep 2019 11:15:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=fXkAkHucmqjgRur+IjQhyi5kKT37YWuWTzD3VpWtsg0=;
        b=ntv7CEaollKFU9wsGZi+urn8zpOjY8CZrCGX9uanU9rEkUUwtoG2BQKLAK4j1JP31E
         mdAOGt7iwUcrZFg0chBC92R/1SxbUnu3D5LM/lSWidgtI3+jzUkg7qUbKq9A1FYQsL87
         jolqCgEbdAjycGAxGkfudyhK36bxCTFhbAaTL/y1zJSRQWu2gJ82rLSCp6OFDDovL62y
         mmopsdkjOUsLZqJ4BRQpHvitszF5ZpPn9a5Ir/XLS6LpB+nCi3iMo3rthv/EkBgG8zLW
         0TrqloJ1w2W/HGRBbXst7/kckF8TRQmcHaqxhUtGGsIKfK0iy9YRoMT99XNzZYi159Kp
         MVJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=fXkAkHucmqjgRur+IjQhyi5kKT37YWuWTzD3VpWtsg0=;
        b=QiwMPgxkx56aWfvgSpvWmBjTor/0kNHzXKGKtEVuK2cVSN4K44VoiUWUEl435kuQkQ
         9/j695MjjQZ9u4RnaHCsLV5w6HuLVt2Z6pPs2egj5RhVaJR3uNC7ucTonwOMNSRL/1BR
         YteX5G3snVrhpfkV8VgX2YdxpuW+olgv61PLumqcDfmo+tPq4mlywFBu4wILeyMrXEQs
         0bzatt6aagwmSql1TMeAY/NJGUM+MBwLd25b25YhmTdo5jcLT0BYWupjot8ndkJyczi3
         urrGO3PgaaWS8ygzHx+5gh7WthRBmhFUfwLmqQWB5uq0k3okWsVWpW6p5UYJw0a6vYSL
         iRhA==
X-Gm-Message-State: APjAAAUSsqKPIPELuv2FnlyiayW2Jazo8plWTfkKQpVRbWXVa5s8hbL0
        bQCLEX6saL7nInd9M5bfps/qP7nQ4pkIpdLPMaE=
X-Google-Smtp-Source: APXvYqzUteMvbu/JD+RSQQW5D8Phtl/I5oQ+l/SfFU9QA9W63S8MlbNMxGvgLrr0HNBCbU2A7ewkAz85UTDHn8mvceY=
X-Received: by 2002:a0d:df13:: with SMTP id i19mr26242555ywe.264.1567534502345;
 Tue, 03 Sep 2019 11:15:02 -0700 (PDT)
MIME-Version: 1.0
References: <20190830095639.4562-1-kkamagui@gmail.com> <20190830095639.4562-3-kkamagui@gmail.com>
 <20190830124334.GA10004@ziepe.ca> <CAHjaAcQ0MrPCZUit7s0Rmqpwpp0w5jiYjNUNEEm2yc1AejZ3ng@mail.gmail.com>
 <BCA04D5D9A3B764C9B7405BBA4D4A3C035F1CC59@ALPMBAPA12.e2k.ad.ge.com>
 <CAHjaAcQu3jOSj0QV3u4GSgnhpkTmJTMqckY_cnuzeTY-HNUWcA@mail.gmail.com>
 <BCA04D5D9A3B764C9B7405BBA4D4A3C035F1CD06@ALPMBAPA12.e2k.ad.ge.com>
 <CAHjaAcRPg9-9MXiLH7AfJO6P1k25CSwJrSiuUwzFLwN5Ynr0DQ@mail.gmail.com> <BCA04D5D9A3B764C9B7405BBA4D4A3C035F1CF04@ALPMBAPA12.e2k.ad.ge.com>
In-Reply-To: <BCA04D5D9A3B764C9B7405BBA4D4A3C035F1CF04@ALPMBAPA12.e2k.ad.ge.com>
From:   Seunghun Han <kkamagui@gmail.com>
Date:   Wed, 4 Sep 2019 03:14:48 +0900
Message-ID: <CAHjaAcQ9+w_iQfSeGr+TgELN5w8+iAjix22q7SpPjKvyh_W_uA@mail.gmail.com>
Subject: Re: [PATCH 2/2] tpm: tpm_crb: enhance resource mapping mechanism for
 supporting AMD's fTPM
To:     "Safford, David (GE Global Research, US)" <david.safford@ge.com>
Cc:     Jason Gunthorpe <jgg@ziepe.ca>,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        Peter Huewe <peterhuewe@gmx.de>,
        Matthew Garrett <mjg59@srcf.ucam.org>,
        Matthew Garrett <mjg59@google.com>,
        "open list:TPM DEVICE DRIVER" <linux-integrity@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

> I tried your patch out on my systems with a "reserved" but not "NVS"
> region conflict, and you are correct - the region is not busy, and
> the driver is able to map the buffers with your patch.
>
> > First of all, I misunderstood your message.
> > I have to tell you about the buffer size exactly. The command and response
> > buffer sizes in ACPI table were 0x1000 and this was 4K, not 1K. The sizes in
> > the control register were 0x4000 and this was 16K (large buffer size), not 4K.
> > I have been using the TPM for my research and the typical cases like creating
> > public/private keys, encrypting/decrypting data, sealing/unsealing a secrete,
> > and getting random numbers are not over 4K buffer. So, as you know, I think
> > the 4K buffer can handle the most cases and the current implementation of
> > crb_fixup_cmd_size() works well. If you concern the specific case that uses
> > over 4K buffer, please let me know.
>
> I have read postings of some systems where ACPI says 1K, but in all of my cases
> that I can test,  you are correct that ACPI is saying 4K instead of the device's 16K.
> I tried really hard, but couldn't send any valid requests over 4K, (I believe that's
> actually the max by the spec), and therefore never saw any failures on my
> systems. I think the driver behavior is wrong for those other cases, but perhaps
> this should wait until someone can get access and do the testing.
>
> So I'm happy with your patches, other than what is decided for the nvs driver
> conflict. I'm testing them on some production systems, and have seen no other
> issues.
>
> dave

Thank you for your help and testing. I would like to make patch v2 to
change the point that kbuild robot told me.
If you don't mind, may I add "tested-by" tag to patch v2 with your
name and email address?

Seunghun
