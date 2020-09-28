Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7FE7D27A75A
	for <lists+linux-integrity@lfdr.de>; Mon, 28 Sep 2020 08:20:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726421AbgI1GUc (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 28 Sep 2020 02:20:32 -0400
Received: from mail.kernel.org ([198.145.29.99]:60880 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726380AbgI1GUb (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 28 Sep 2020 02:20:31 -0400
Received: from mail-oo1-f46.google.com (mail-oo1-f46.google.com [209.85.161.46])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D1DD720BED;
        Mon, 28 Sep 2020 06:20:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1601274030;
        bh=qGVBcNhDEEBkJu2At1hZbhtzuUFdZojHwVUCzhbrbsk=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=DRd1dek7hHeI6wDiG0Q2fzMYzBlt6/up5Isinltgd8XP78NXerLQJNSRJfHvz8nfY
         Yo7QHaHM97V17vkYE7WYc/dl153B28rc9/2n0GzwtIN0moyws3EeKCDw+EuCCVANmv
         tg2YBUl8W9p/tJfLEsRuuOcZX6GtKHIKZaDGiutc=
Received: by mail-oo1-f46.google.com with SMTP id z1so20237ooj.3;
        Sun, 27 Sep 2020 23:20:30 -0700 (PDT)
X-Gm-Message-State: AOAM531wNH68i0VL1ziDaiBb6QZZUWknls1k9bFHSopFUozATrudeoO8
        oEJzvvJa93R3NUaFywhkOYd8Rl5IelRFWyQzxwA=
X-Google-Smtp-Source: ABdhPJya6+NUXngiNKxeosaYSdyZVPk+uYtQRGhgdz0kf1DdRjRrFRW4PGdNv65YNWycBUG1REBKMRMNa4ltvRyBeVk=
X-Received: by 2002:a4a:4910:: with SMTP id z16mr24551ooa.41.1601274030150;
 Sun, 27 Sep 2020 23:20:30 -0700 (PDT)
MIME-Version: 1.0
References: <20200922094128.26245-1-ardb@kernel.org> <20200925055626.GC165011@linux.intel.com>
 <CAMj1kXFLWsFz7HV4sHLbwBkuiEu0gT4esSH8umVrvDDrJaOLrQ@mail.gmail.com>
 <20200925102920.GA180915@linux.intel.com> <20200925120018.GH9916@ziepe.ca>
 <20200927234434.GA5283@linux.intel.com> <9be9c7e7-c424-d241-2255-ad854221bd2e@csgroup.eu>
In-Reply-To: <9be9c7e7-c424-d241-2255-ad854221bd2e@csgroup.eu>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Mon, 28 Sep 2020 08:20:18 +0200
X-Gmail-Original-Message-ID: <CAMj1kXGxNgixUEocma-9F3fYgdJJJADh=bvyrCziXkuArErWdA@mail.gmail.com>
Message-ID: <CAMj1kXGxNgixUEocma-9F3fYgdJJJADh=bvyrCziXkuArErWdA@mail.gmail.com>
Subject: Re: [PATCH] tpm: of: avoid __va() translation for event log address
To:     Christophe Leroy <christophe.leroy@csgroup.eu>
Cc:     Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        linux-integrity <linux-integrity@vger.kernel.org>,
        "open list:LINUX FOR POWERPC (32-BIT AND 64-BIT)" 
        <linuxppc-dev@lists.ozlabs.org>, Peter Huewe <peterhuewe@gmx.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Mon, 28 Sep 2020 at 07:56, Christophe Leroy
<christophe.leroy@csgroup.eu> wrote:
>
>
>
> Le 28/09/2020 =C3=A0 01:44, Jarkko Sakkinen a =C3=A9crit :
> > On Fri, Sep 25, 2020 at 09:00:18AM -0300, Jason Gunthorpe wrote:
> >> On Fri, Sep 25, 2020 at 01:29:20PM +0300, Jarkko Sakkinen wrote:
> >>> On Fri, Sep 25, 2020 at 09:00:56AM +0200, Ard Biesheuvel wrote:
> >>>> On Fri, 25 Sep 2020 at 07:56, Jarkko Sakkinen
> >>>> <jarkko.sakkinen@linux.intel.com> wrote:
> >>>>>
> >>>>> On Tue, Sep 22, 2020 at 11:41:28AM +0200, Ard Biesheuvel wrote:
> >>>>>> The TPM event log is provided to the OS by the firmware, by loadin=
g
> >>>>>> it into an area in memory and passing the physical address via a n=
ode
> >>>>>> in the device tree.
> >>>>>>
> >>>>>> Currently, we use __va() to access the memory via the kernel's lin=
ear
> >>>>>> map: however, it is not guaranteed that the linear map covers this
> >>>>>> particular address, as we may be running under HIGHMEM on a 32-bit
> >>>>>> architecture, or running firmware that uses a memory type for the
> >>>>>> event log that is omitted from the linear map (such as EfiReserved=
).
> >>>>>
> >>>>> Makes perfect sense to the level that I wonder if this should have =
a
> >>>>> fixes tag and/or needs to be backported to the stable kernels?
> >>>>>
> >>>>
> >>>> AIUI, the code was written specifically for ppc64, which is a
> >>>> non-highmem, non-EFI architecture. However, when we start reusing th=
is
> >>>> driver for ARM, this issue could pop up.
> >>>>
> >>>> The code itself has been refactored a couple of times, so I think it
> >>>> will require different versions of the patch for different generatio=
ns
> >>>> of stable kernels.
> >>>>
> >>>> So perhaps just add Cc: <stable@vger.kernel.org>, and wait and see h=
ow
> >>>> far back it applies cleanly?
> >>>
> >>> Yeah, I think I'll cc it with some note before the diffstat.
> >>>
> >>> I'm thinking to cap it to only 5.x kernels (at least first) unless it=
 is
> >>> dead easy to backport below that.
> >>
> >> I have this vauge recollection of pointing at this before and being
> >> told that it had to be __va for some PPC reason?
> >>
> >> Do check with the PPC people first, I see none on the CC list.
> >>
> >> Jason
> >
> > Thanks, added arch/powerpc maintainers.
> >
>
> As far as I can see, memremap() won't work on PPC32 at least:
>
> IIUC, memremap() calls arch_memremap_wb()
> arch_memremap_wb() calls ioremap_cache()
> In case of failure, then ioremap_wt() and ioremap_wc() are tried.
>
> All ioremap calls end up in __ioremap_caller() which will return NULL in =
case you try to ioremap RAM.
>
> So the statement "So instead, use memremap(), which will reuse the linear=
 mapping if
> it is valid, or create another mapping otherwise." seems to be wrong, at =
least for PPC32.
>
> Even for PPC64 which doesn't seem to have the RAM check, I can't see that=
 it will "reuse the linear
> mapping".
>

It is there, please look again. Before any of the above happens,
memremap() will call try_ram_remap() for regions that are covered by a
IORESOURCE_SYSTEM_RAM, and map it using __va() if its PFN is valid and
it is not highmem.

So as far as I can tell, this change has no effect on PPC at all
unless its RAM is not described as IORESOURCE_SYSTEM_RAM.
