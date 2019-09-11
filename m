Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2D478AF566
	for <lists+linux-integrity@lfdr.de>; Wed, 11 Sep 2019 07:18:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725924AbfIKFSA (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 11 Sep 2019 01:18:00 -0400
Received: from mail-yw1-f67.google.com ([209.85.161.67]:37788 "EHLO
        mail-yw1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725798AbfIKFSA (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 11 Sep 2019 01:18:00 -0400
Received: by mail-yw1-f67.google.com with SMTP id u65so1688284ywe.4;
        Tue, 10 Sep 2019 22:17:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=B1gkHH/vtIQIzLRopG5WCX6poJs+AROQ9wwzxaKQiMI=;
        b=pQhc9gXZVHi+8+PbiXQ0kw6JEVpXEbAfwQAWlXD2WA75qPjWhFJjLDJmLmUYDus413
         kOo8J3ryUV/KuURCOY0cobUadf3NuXLBFdcOq5ax0iVOzgFsoOoDXGy1NzCB1jbvUUvM
         iRbsdYapI4imKDYMfJZ2DKXOuSBf89u9M8E5/4cBkePmFpMWtkGZOEn0vxxR3YhW8Tw7
         5NRlVHl9Na6zb831hXbfrKz78rhJogsBOKRrDSHh3m77t3g4zM9+FJbRlT/3Ey/ycXhg
         5+mDuuP6CxRrdrru9C1rYnumCuhkz0snvAe8pCfsDvwzNDElrlobWCBmoXZ3/sdMzgA9
         iPKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=B1gkHH/vtIQIzLRopG5WCX6poJs+AROQ9wwzxaKQiMI=;
        b=r48AoxdEFxFcgq8Cis+9nNv6kk1H3lIhp4y2/Q/aR0vmgEaJU/lXZDsFiCpFbQ2GVR
         i9r8bkISRQJO/vENuerUwRL8S2BLt3zVW8R/OIDGerb83fQiMM/Zatan7ZeT4BFwlPtA
         YLaBe4SFPNvBUhDSfteaUjvkZl1AAmP3mpIgcTfDIJeYNBD8ZWZdvlwHxYOGThee513/
         6SYlKpoWUelKAiDVQZcLQ58I8TnQrbsBHxdh4Mhy0x23mRXK0Di1UUzTTOXtPFFBHTks
         WOcEmMCUjRL5+2wPyUOBgaXcentx6A/+be3HvtplkzldrGKLEZrlLzLB80ICk/aM9+hg
         Hu2w==
X-Gm-Message-State: APjAAAWutLbx8ymD9WCSziKvI7GbyPmFgoIGmwMIas8Z6hWJ7QFZJaqO
        4k59dR574tA78xGofppSnm9yh2UGXGIVYOmhdhU=
X-Google-Smtp-Source: APXvYqwjH/NeuhnI2cFmY+Mf24H5HyFtcFN1CuwMilu3VYb09XsGdzbn/Z5C5Q/WkDO8XoEv3gEW+y9MYWPucXBE0dU=
X-Received: by 2002:a0d:e64b:: with SMTP id p72mr23178254ywe.347.1568179079047;
 Tue, 10 Sep 2019 22:17:59 -0700 (PDT)
MIME-Version: 1.0
From:   Seunghun Han <kkamagui@gmail.com>
Date:   Wed, 11 Sep 2019 14:17:48 +0900
Message-ID: <CAHjaAcStAfarJoPG0tbSY0BVcp0-7Lvah2FdpmC_eCFfxaSVFw@mail.gmail.com>
Subject: Re: [PATCH v2] Fix fTPM on AMD Zen+ CPUs
To:     ivan.lazeev@gmail.com
Cc:     arnd@arndb.de, gregkh@linuxfoundation.org,
        jarkko.sakkinen@linux.intel.com, jgg@ziepe.ca,
        linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org,
        peterhuewe@gmx.de
Content-Type: text/plain; charset="UTF-8"
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

> > And why is this allocating memory inside the acpi table walker? It
> > seems to me like the memory should be allocated once the mapping is
> > made.
> >
>
> Yes, this looks bad. Letting the walker build the list and then using
> it is, probably, a better idea.
>
> > Maybe all the mappings should be created from the ACPI ranges right
> > away?
> >
>
> I don't know if it's a good idea to just map them all instead of doing
> so only for relevant ones. Maybe it is safe, here I need an advice
> from a more knowledgeable person.
>

Vanya,
I also made a patch series to solve AMD's fTPM. My patch link is here,
https://lkml.org/lkml/2019/9/9/132 .

The maintainer, Jarkko, wanted me to remark on your patch, so I would
like to cooperate with you.

Your patch is good for me. If you are fine, I would like to take your
patch and merge it with my patch series. I also would like to change
some points Jason mentioned before.

Of course, I will leave your commit message and sign-off-by note.
According to the guideline below, I will just add co-developed-by and
sign-off-by notes behind you.
https://www.kernel.org/doc/html/v5.2/process/submitting-patches.html#when-to-use-acked-by-cc-and-co-developed-by

If you have any idea about our co-work, please let me know.
I hope we can solve AMD's fTPM problem soon.

Seunghun
