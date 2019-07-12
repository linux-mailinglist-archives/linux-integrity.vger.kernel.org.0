Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DBE0A67511
	for <lists+linux-integrity@lfdr.de>; Fri, 12 Jul 2019 20:24:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726976AbfGLSY0 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 12 Jul 2019 14:24:26 -0400
Received: from mail-io1-f65.google.com ([209.85.166.65]:43956 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726811AbfGLSYZ (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 12 Jul 2019 14:24:25 -0400
Received: by mail-io1-f65.google.com with SMTP id k20so22362662ios.10
        for <linux-integrity@vger.kernel.org>; Fri, 12 Jul 2019 11:24:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=QbX5SSmgAX6r0nm0FWvTecY7kBanTKkAwgykxlsGKsM=;
        b=V4E4fQhPPjxF6UpnAwXKFWQ6dyRjFQEqoQe20gPWZh6lpP4IxqPmj5L3+PsvZgXWiQ
         +TP/nX8PVNH6VoOA0cJGnIxFuzfD2+MxYt7ZhYgCY/MrJrDmMeKjjNsj/Cc5fVPg5J55
         OVVhiB7YdP9XQduIVpSu8vDfvinAXj49IJ/QqmUbN24X94YOdQKQy/gm0QGKMiZekXx9
         4OAwPBBTq9a1StUjce0N7guWWv5CxDFxm7m+P9z/n3fnT4VVlB7m5X16bo4/3MmDDv6y
         TJnqWdpGrv2HM05/KxQJhOlTOLC5WH5Gj770WgJK6JiDj3SAQAt2qrEKEApOaB9ugPPp
         aIrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=QbX5SSmgAX6r0nm0FWvTecY7kBanTKkAwgykxlsGKsM=;
        b=nhhe0tRZZrw7fP1P8rYBZRmWZzCY6McA9Y5RgjP6/10aPf8DuAAZ3Q/YxxgczpCtd5
         VMvU5/d+4NkJwaGob8pc7jxWuepyOjrznuJTUXoXrMCV/+yJ5u7CVSnJGZ7sUgsE1+gB
         n6P/9NcizLlGJZgYKk8ucMami9a5wBOgnpPhHfTygYox7Ud3O2dcF4W/uCBkHXHOvHFl
         mKnbFxAxI4qWM+2rsW8jaPrpQ4bYpsC3wvcsfa/OrsrvH2Gmw2AwqWwqvLmL3H90qBG+
         KgQun1LXIO42oYguHgBFo5Ag9CcJn/xOEcb52g7xbHvJTrfCz/krwh7glg2ofpWd3bRv
         lAfg==
X-Gm-Message-State: APjAAAX2Q88n3+UOQQVPH1gx2BTO1rU+qi+bLn+Mw/As7MAZKriukYlE
        KLJBNgSF39OGKDDh3X+Mj1lwKY7eRUhsHI1CxB8Ung==
X-Google-Smtp-Source: APXvYqz39ORlkJRtZIQn44qHJv2C5TOs7NwAnVzR75U0sNqrJ9NTDy4hEvX7634not2CSPsmLdswrKPK+uaZi4PD+Pw=
X-Received: by 2002:a02:2245:: with SMTP id o66mr13462919jao.53.1562955864560;
 Fri, 12 Jul 2019 11:24:24 -0700 (PDT)
MIME-Version: 1.0
References: <BCA04D5D9A3B764C9B7405BBA4D4A3C035EF7BC7@ALPMBAPA12.e2k.ad.ge.com>
 <20190711145850.GC25807@ziepe.ca> <BCA04D5D9A3B764C9B7405BBA4D4A3C035EF7C56@ALPMBAPA12.e2k.ad.ge.com>
 <20190711185027.GG25807@ziepe.ca> <BCA04D5D9A3B764C9B7405BBA4D4A3C035EF7CFE@ALPMBAPA12.e2k.ad.ge.com>
 <CACdnJutS4-N0GgtYPy9GGJ8dVf48VZGF5AFL2raB55bSPKUpNw@mail.gmail.com> <BCA04D5D9A3B764C9B7405BBA4D4A3C035EF7E2A@ALPMBAPA12.e2k.ad.ge.com>
In-Reply-To: <BCA04D5D9A3B764C9B7405BBA4D4A3C035EF7E2A@ALPMBAPA12.e2k.ad.ge.com>
From:   Matthew Garrett <mjg59@google.com>
Date:   Fri, 12 Jul 2019 11:24:13 -0700
Message-ID: <CACdnJutmhRyGjiumXbzai1fTNqcYMRthzTfMsiQgzKFtu3+teA@mail.gmail.com>
Subject: Re: [PATCH] tpm_crb - workaround broken ACPI tables
To:     "Safford, David (GE Global Research, US)" <david.safford@ge.com>
Cc:     Jason Gunthorpe <jgg@ziepe.ca>,
        "linux-integrity@vger.kernel.org" <linux-integrity@vger.kernel.org>,
        "jarkko.sakkinen@linux.intel.com" <jarkko.sakkinen@linux.intel.com>,
        "Wiseman, Monty (GE Global Research, US)" <monty.wiseman@ge.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Fri, Jul 12, 2019 at 5:42 AM Safford, David (GE Global Research,
US) <david.safford@ge.com> wrote:
> Thanks - that was very helpful.
> All of my misbehaving systems are AMD - mostly Ryzen and Threadripper towers,
> of various motherboard OEMs. One system is a 3rd gen Ryzen laptop (Asus FX505dy).

I suspect the issue comes from AMD's reference code rather than
multiple vendors all having made the same mistake. Unfortunate.

> But the laptop shows a new layout:
> [    2.069539] tpm_crb MSFT0101:00: can't request region for resource
> [mem 0xbd11f000-0xbd122fff]
> [    2.069543] tpm_crb: probe of MSFT0101:00 failed with error -16
> [    2.177663] ima: No TPM chip found, activating TPM-bypass!
>
> bbc64000-bd14afff : Reserved
>   bd11f000-bd11ffff : MSFT0101:00
>   bd123000-bd123fff : MSFT0101:00
> bd14b000-bd179fff : ACPI Tables
> bd17a000-bd328fff : ACPI Non-volatile Storage

Hmm, that's interesting. Is this a UEFI or BIOS system? Can you
provide the e820 data from dmesg?

> Have you looked at the sequencing during suspend/restore?
> If ACPI is the last to save, and first to restore, the TPM's use may
> still be safe. I'll try to run some tests along those lines, and look
> at the nvs driver.

The NVS stuff was largely implemented by attempting to identify what
Windows was doing and duplicating that, so it's kind of dangerous to
rely on its ordering - there's a risk it might end up changing
suddenly in order to mimic Windows' behaviour more closely.
