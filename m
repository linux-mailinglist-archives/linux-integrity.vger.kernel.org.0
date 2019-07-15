Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3D20069B97
	for <lists+linux-integrity@lfdr.de>; Mon, 15 Jul 2019 21:44:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731207AbfGOToy (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 15 Jul 2019 15:44:54 -0400
Received: from mail-vs1-f65.google.com ([209.85.217.65]:43127 "EHLO
        mail-vs1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729598AbfGOToy (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 15 Jul 2019 15:44:54 -0400
Received: by mail-vs1-f65.google.com with SMTP id j26so12215482vsn.10
        for <linux-integrity@vger.kernel.org>; Mon, 15 Jul 2019 12:44:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=b9lkawqytTP6RbknOMMYQKAtx3JXZeWvxG6NGfcFkAU=;
        b=JbJp+1rBZPLtE2uW5o49WQH0U/xx+ndD8cM8LuS4BwXkYBW+DIPpoleT0je3DDHktt
         9kP0FLcyhgnL4W9CoIeqHl9Ax4u5VJ1nwKdiG1K4laTK67O2xmmWmJLWio41uU0a7Qsc
         19YpfVtItIIw9e0H4vSipG5IglT3Ab/UPdgUK+eV3aeEUkjuXQjEjWUakFwtyMFA3KlJ
         CergKELjia4xFLamVVE9bRenpLqK/TjOvYkjSIkVHcLSRYstHGGIGEyDrun0OBBjiBHB
         AkdG7v2BPvekks0iKIqRfaLjXy+hmhCqo2KVHvBTsRG3hj0HfUJwEyY+cnHvXur042IV
         4IIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=b9lkawqytTP6RbknOMMYQKAtx3JXZeWvxG6NGfcFkAU=;
        b=DpBaxHCrgcDCahq5cPagHQjoNiEUNDX8hFXrjenJ6pkr1WbScilaXvniMdRS0QQ2XH
         wSkpIswJNu+YHdlUG0Y3LZA8oM4VVj16v4EX0yNRYvqztedeOHS2MjNSKT+Mpj7rNcdl
         V9k1wxiCiTvv7Jlo3ycawMqPsHBtZL1CipG4a1YkSg2ODiDx5+A/IJRsRysJdxyJW1sj
         IVesJAUs6z/kUt2XWIJyYMAzA50zbp1nn/2ybdWWcOkkeyCJB8Sh0UwigcAqhhNS7Wq1
         7HIi3lgm8YdQmnUpYx5HDG0qHlENB515WL1+Uwxg1ahfUbWKO51a2r6Ql8RJYF8MeRyT
         NoEw==
X-Gm-Message-State: APjAAAWFCaeGkKgcYC6UaTFIoHiPDgORD5HEe6Lt8DceTKZauFkTDgT3
        54GLy6leX0f4F1ogz4UsycVv7P3xZmbhXxulaWXcJw==
X-Google-Smtp-Source: APXvYqxOMT1DnAu1qSr20KJXerfxrzH7TQl95FmnYRcefMiacahnVqQQlkITGtx0l5OriW6IpZEdo5NQw64tzca16lc=
X-Received: by 2002:a67:ad07:: with SMTP id t7mr17449491vsl.214.1563219892459;
 Mon, 15 Jul 2019 12:44:52 -0700 (PDT)
MIME-Version: 1.0
References: <BCA04D5D9A3B764C9B7405BBA4D4A3C035EF7BC7@ALPMBAPA12.e2k.ad.ge.com>
 <20190711145850.GC25807@ziepe.ca> <BCA04D5D9A3B764C9B7405BBA4D4A3C035EF7C56@ALPMBAPA12.e2k.ad.ge.com>
 <20190711185027.GG25807@ziepe.ca> <BCA04D5D9A3B764C9B7405BBA4D4A3C035EF7CFE@ALPMBAPA12.e2k.ad.ge.com>
 <CACdnJutS4-N0GgtYPy9GGJ8dVf48VZGF5AFL2raB55bSPKUpNw@mail.gmail.com>
 <BCA04D5D9A3B764C9B7405BBA4D4A3C035EF7E2A@ALPMBAPA12.e2k.ad.ge.com>
 <CACdnJutmhRyGjiumXbzai1fTNqcYMRthzTfMsiQgzKFtu3+teA@mail.gmail.com>
 <BCA04D5D9A3B764C9B7405BBA4D4A3C035EF7F56@ALPMBAPA12.e2k.ad.ge.com>
 <CACdnJusqAbBxJTzQttF6DwU1efz336xA4o2uchnV9OFbMB+n1A@mail.gmail.com>
 <BCA04D5D9A3B764C9B7405BBA4D4A3C035EFF39A@ALPMBAPA12.e2k.ad.ge.com> <CACdnJuuE8GLnPdgcYqLzpY+8tY7JedYybb9S7QTYH8nccyLGgA@mail.gmail.com>
In-Reply-To: <CACdnJuuE8GLnPdgcYqLzpY+8tY7JedYybb9S7QTYH8nccyLGgA@mail.gmail.com>
From:   Matthew Garrett <mjg59@google.com>
Date:   Mon, 15 Jul 2019 12:44:41 -0700
Message-ID: <CACdnJusQncWiwrDfjNQpYs4_YoNevJ9+SzBrFzJ0CyLRxA8pQQ@mail.gmail.com>
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

On Sun, Jul 14, 2019 at 4:48 PM Matthew Garrett <mjg59@google.com> wrote:
>
> Hmm that's weird - that's a surprisingly large region of reserved
> space. I've no idea why that would be covered, and it definitely makes
> things more complicated.

My gut feeling here is that we should figure out something with the
NVS code to handle the common case, and independently try to figure
out what's going on with this machine.
