Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C6A06B3464
	for <lists+linux-integrity@lfdr.de>; Mon, 16 Sep 2019 07:29:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727255AbfIPF3O (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 16 Sep 2019 01:29:14 -0400
Received: from mail-yw1-f68.google.com ([209.85.161.68]:45169 "EHLO
        mail-yw1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726944AbfIPF3O (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 16 Sep 2019 01:29:14 -0400
Received: by mail-yw1-f68.google.com with SMTP id x82so3019384ywd.12;
        Sun, 15 Sep 2019 22:29:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=TO/AmfnKtANZ8mVZNESH/DlPEtWYchRuqQVqKflh/3Y=;
        b=MtIjhXxkbLue/e0nStAilt/Bvuk+s4J8xquKYB9e9lghThNERr5xnsEdNNRrj7vz4Y
         yDme9NMm9L4DBVrnq23lENWTU3WkGQ4xlTvAYhkgfBHSdJlGUYZQW1y34LM81lr7Xej/
         TpfMoyuaW7xT9nNRPEwh8TOp4dZ/+uotGl23oFn0CqxGMFWC7ioL/WphTqVh7DgWy736
         W/jrDmGUFU/lavzIeOq9nuNdsEkpNyBx4De5fIbb+eIWiuS2h+lwbYFCmpyquw/oQoN+
         zxvtoRc5VIHmrNZsMDfThrAmkPH5lGeUf92s7HvPZzyVBZlY3/NMFTU0ybIraWSPtGBc
         6ulw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=TO/AmfnKtANZ8mVZNESH/DlPEtWYchRuqQVqKflh/3Y=;
        b=LmU7Ifphl5n5fpa3CC9bIBXd8nKK1XYtzpsBG6OCpB0LkIV4aRFzNUvP/eci+ZhMB9
         b4gN8p3GDsYe3gwlwZ8Q9RgWQOdqd7gkUs86x3G1PIoI5N3ndmROJARI48EtdjvboRko
         AbWyvrYpTurRdx6BMQVMvEpP8EVlvZfdi5N7FGrRyzAywne5iq0hTd3V70YhsXQbUl8R
         MWnQQmb+FPEOb3qG8eL71nzEmSvXDV2xeJICr8uzF7PszHEU0g4uPqsH0FL+bGbpg+e3
         86NRNrtKAa3bHnSDNVIibXRvcNux+4iqAMKgNLVJE/IKcu3ftSAp6SiH3Jsxs6I2ntmP
         Qnlg==
X-Gm-Message-State: APjAAAVd1OWMC5xhbYW6PmN733G+SbNsz3Rel/L3w4Hy1zk9wplnqivw
        tKz1X6IP/kdVZ/uFsT+QHklx4ioulVx+OC4eQj4=
X-Google-Smtp-Source: APXvYqzyjkJ0egxXhzgdWexlfKH5i4Q5Pavz0yuyznhk7LArfROmytXoN+G3x5dmWCvZkuPCSNDruiUolLkoDqeQ7dM=
X-Received: by 2002:a0d:e64b:: with SMTP id p72mr41884972ywe.347.1568611752955;
 Sun, 15 Sep 2019 22:29:12 -0700 (PDT)
MIME-Version: 1.0
References: <CAHjaAcStAfarJoPG0tbSY0BVcp0-7Lvah2FdpmC_eCFfxaSVFw@mail.gmail.com>
 <20190913140006.GA29755@linux.intel.com> <20190913140218.GB29755@linux.intel.com>
In-Reply-To: <20190913140218.GB29755@linux.intel.com>
From:   Seunghun Han <kkamagui@gmail.com>
Date:   Mon, 16 Sep 2019 14:29:01 +0900
Message-ID: <CAHjaAcSBCDnn7CwXfxYcfmRnAF2jdud1Sjwng_jtd8ASVS28Sg@mail.gmail.com>
Subject: Re: [PATCH v2] Fix fTPM on AMD Zen+ CPUs
To:     Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Cc:     Vanya Lazeev <ivan.lazeev@gmail.com>, arnd@arndb.de,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        "open list:TPM DEVICE DRIVER" <linux-integrity@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Peter Huewe <peterhuewe@gmx.de>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

>
> On Fri, Sep 13, 2019 at 03:00:06PM +0100, Jarkko Sakkinen wrote:
> > On Wed, Sep 11, 2019 at 02:17:48PM +0900, Seunghun Han wrote:
> > > Vanya,
> > > I also made a patch series to solve AMD's fTPM. My patch link is here,
> > > https://lkml.org/lkml/2019/9/9/132 .
> > >
> > > The maintainer, Jarkko, wanted me to remark on your patch, so I would
> > > like to cooperate with you.
> > >
> > > Your patch is good for me. If you are fine, I would like to take your
> > > patch and merge it with my patch series. I also would like to change
> > > some points Jason mentioned before.
> >
> > I rather handle the review processes separately because I can merge
> > Vanyas's patch first. Bundling them into patch set would only slow
> > down things.
>
> I did not ask to do anything. I just review code changes.

I got it. I should concentrate on my ACPI NVS problem.
Thank you.

Seunghun
