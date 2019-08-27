Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BCDCA9EF59
	for <lists+linux-integrity@lfdr.de>; Tue, 27 Aug 2019 17:49:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729852AbfH0Pti (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 27 Aug 2019 11:49:38 -0400
Received: from mail-yb1-f194.google.com ([209.85.219.194]:34468 "EHLO
        mail-yb1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728939AbfH0Pti (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 27 Aug 2019 11:49:38 -0400
Received: by mail-yb1-f194.google.com with SMTP id u68so8401312ybg.1;
        Tue, 27 Aug 2019 08:49:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=KOl4P8fEhyJyP94iweeG6SBzjgS5BlmzdNYIdasCoOo=;
        b=odoHgBQygTqmk0h2RGHB9TWZjEnGg1AeVHfM8kOnedBoGC8Vx5LzqU4JJNd9pT9DVW
         A5TnD6OKeBXIzQogPjongByt11zwP641YMCnDCiGE14GB/ud/wkHc/Z6sQCuSr0jXzYt
         TQGQfzru4a0xUVBElded01BhK1ICXza6o1sKNQdGFWvWf33y/M/Rq/iIo6f4aXv+zydO
         0+Rsg4YhHPVHat80ry3dmkWJqOh7/S4IghnUt/g/fbDYVhF/zvYo9aMMehplhE1yIRo0
         k7aJVf2DeADLvPy/zButBi+2r7Xke2X58KZrfZjGteJT0EMP3JVUbwQtF1HI/7Vshh9q
         7JiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=KOl4P8fEhyJyP94iweeG6SBzjgS5BlmzdNYIdasCoOo=;
        b=X/WJzXK9l4/6vlDAnDJDxN/duzjhGcweYp4ISi2ZUp+rcwwCurdWkwbxaHUpsS8tzw
         e/xUDOnhAIlwDXlzxDdqfSuXSQ2xSoNxPrQ559zaRSxje5utzVn86+UyKkzbL+yX+h4/
         9vEynNDCI+7qxpnCrdeQVmhiG1CHjiBwecb4V9R8AisvzQS9262AGGYcZv/VkIfMke96
         uEOBCu1nlhwRLB9DG8SYnPqN3B8lHadvWF3O4xpP1CB0iqa5Y20kFlN2U2i93lDi/YJL
         av8Cjzk5IQemiiJ/BYKosMrSer+6WP9vhDG/2fFtuNT3C8aIoCg+HaWhnKv/KaIY17Fu
         wr4w==
X-Gm-Message-State: APjAAAUPJW5RJEXdtxsPme8jEFSdCCuq9755CQeHSuVwAIlU6CCC1c7s
        OHwTz2uZR1cltcPmmvDVh+Sp8arai2yoktGVRAo=
X-Google-Smtp-Source: APXvYqy6kt9gml6gMwc9quYeL/HHSyZ3mvLqPYueqyBIWcN1ZKJ00Sr+VEZK+aDYvviLbNPte2oSGIuYZ0nc28oiIu8=
X-Received: by 2002:a25:5d0b:: with SMTP id r11mr17672976ybb.256.1566920977141;
 Tue, 27 Aug 2019 08:49:37 -0700 (PDT)
MIME-Version: 1.0
References: <20190826081752.57258-1-kkamagui@gmail.com> <CACdnJutomLNthYDzEc0wFBcBHK5iqnk0p-hkAkp57zQZ38oGPA@mail.gmail.com>
 <20190827124707.yhqtaqa4ur6i45h7@linux.intel.com>
In-Reply-To: <20190827124707.yhqtaqa4ur6i45h7@linux.intel.com>
From:   Seunghun Han <kkamagui@gmail.com>
Date:   Wed, 28 Aug 2019 00:49:26 +0900
Message-ID: <CAHjaAcT_9Rgbb2P29vfGjq49jLnsBXZtuJi7Ae4doD36abWFZg@mail.gmail.com>
Subject: Re: [PATCH] x86: tpm: Remove a busy bit of the NVS area for
 supporting AMD's fTPM
To:     Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Cc:     Matthew Garrett <mjg59@google.com>,
        Matthew Garrett <mjg59@srcf.ucam.org>,
        Peter Huewe <peterhuewe@gmx.de>,
        "open list:TPM DEVICE DRIVER" <linux-integrity@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

>
> On Mon, Aug 26, 2019 at 10:40:25AM -0700, Matthew Garrett wrote:
> > On Mon, Aug 26, 2019 at 1:18 AM Seunghun Han <kkamagui@gmail.com> wrote:
> > > To support AMD's fTPM, I removed the busy bit from the ACPI NVS area like
> > > the reserved area so that AMD's fTPM regions could be assigned in it.
> >
> > drivers/acpi/nvs.c saves and restores the contents of NVS regions, and
> > if other drivers use these regions without any awareness of this then
> > things may break. I'm reluctant to say that just unilaterally marking
> > these regions as available is a good thing, but it's clearly what's
> > expected by AMD's implementation. One approach would be to have a
> > callback into the nvs code to indicate that a certain region should be
> > handed off to a driver, which would ensure that we can handle this on
> > a case by case basis?
>
> What if E820 would just have a small piece of code just for fTPM's e.g.
> it would check the ACPI tree for fTPM's and ignore TPM regions.
>
> /Jarkko

It seems that it is possible. However, the memory layout is set by
enumerating e820 table and ACPI table in order, and the memory regions
are typically added and overlapped to the existing memory layout. I
also worry about the direct interaction between the e820 table and
ACPI table. As I know, they have no straightforward interface or
relationship. So, if we make the code for identifying fTPM regions in
ACPI table and write it to e820 code, we would meet other problems
like "acpi=off" kernel option.

In my view, it is natural that ACPI NVS allows device drivers to
assign some regions in it if the hardware reports the regions there.

Seunghun
