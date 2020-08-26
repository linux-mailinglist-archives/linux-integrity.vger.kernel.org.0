Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2035B2530FA
	for <lists+linux-integrity@lfdr.de>; Wed, 26 Aug 2020 16:12:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726894AbgHZOMf (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 26 Aug 2020 10:12:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727822AbgHZOMb (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 26 Aug 2020 10:12:31 -0400
Received: from mail-lj1-x241.google.com (mail-lj1-x241.google.com [IPv6:2a00:1450:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 997DBC061574
        for <linux-integrity@vger.kernel.org>; Wed, 26 Aug 2020 07:12:29 -0700 (PDT)
Received: by mail-lj1-x241.google.com with SMTP id w14so2547981ljj.4
        for <linux-integrity@vger.kernel.org>; Wed, 26 Aug 2020 07:12:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=qzWxHc/USSh6EbviKIYcqY2wyW78oj3gMqT1HFk8k+s=;
        b=C6fpBeXpXjLU7PWuldOzATKmEBwJrSca7fhi7EhAVvUV+KAEgVdtbx2CxhIV2BkWmE
         Qj81jG4ACPxYoB6h8FjJravTEEcU5ahGu/e6BgNt6rb+fhuZglD13fA3biktaHpJDP2S
         SjS9PE1uAytW7aaqouoPNquFQF4r4kHkgv6NfVTtJEUuwTF8ZOgm8sWQ66r72HzmxIwI
         fCDAn5819zDb8guRoo/sIaVlrN6b5nFPXE90pu0NBFrHqYmz1lYXS/INjzojrBO0GtYn
         41sjwpji4MH6x6Frl0WSzjRUu7f5nWT08u1TZJdtDfJwrzXrF4/dAHPx0NJ4amISLlO0
         g9AQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=qzWxHc/USSh6EbviKIYcqY2wyW78oj3gMqT1HFk8k+s=;
        b=QLfZVKpSFZv3c5YKF9ORWUltiDP2YPkYkHUN8mOhfpqE4p7XCLqei58dkFaVuJYdk6
         U4XmC51WV56lgckzaJntwGbBsoVnV/rkGTCYfRzhvpam5FrJ7kUTrR8WT8AhYFe5SgXb
         QuC7Wk3zv3wyKvIzQUr4xxlbv3zzZ78yMhtZiz82y8vULNsVP5teEvV6RZQ4oDjHB4+x
         n2h6TXGWUhV5Ut9PeGyd20p1H73HOH1NC3BraLhIQePVIVSaEUZK737bDvyQ+Kwm54D3
         1df7z5R/X6r68726PdYfkn0J+mwWnrB1una3/CoXvW5iWxC7eVavBpRNJDXh5IVhSnh2
         Hfzw==
X-Gm-Message-State: AOAM532F0eign/YOQgPNuegzYOEyF0fdufJnhmlnHGyQOBGWIzOQgeT/
        DmFr7vCxGDp9eXe4DsoD+IanMKIkwgu9S/g6vGg=
X-Google-Smtp-Source: ABdhPJwyBP3SZnxz2Dwun72n1/dzFi7Yn5KwHyCTLvapBoHCbHcohCNajkHDahvQc8S6fp4hck8+MS9q9cfJr6hVins=
X-Received: by 2002:a2e:8059:: with SMTP id p25mr6570242ljg.219.1598451147988;
 Wed, 26 Aug 2020 07:12:27 -0700 (PDT)
MIME-Version: 1.0
References: <436e3951-d6d5-014a-dde1-8a6398dfe7a1@linux.microsoft.com>
 <57e0095a-ff6f-e5dc-6250-1320bd6518cb@linux.microsoft.com>
 <CAE=NcrYOy56_mRNUvvOBX5v=zGsNXwqmz9Q6q3Ovu0vfCRKBpQ@mail.gmail.com> <CAE=NcraZDd=8GPGYYuKOVtk++yk5iquPHkCa_h4VbUyH-OP6AQ@mail.gmail.com>
In-Reply-To: <CAE=NcraZDd=8GPGYYuKOVtk++yk5iquPHkCa_h4VbUyH-OP6AQ@mail.gmail.com>
From:   Janne Karhunen <janne.karhunen@gmail.com>
Date:   Wed, 26 Aug 2020 17:12:16 +0300
Message-ID: <CAE=NcraN5+K_mNiaDdi7tFn2PFDbXtfaF0K-ozrdq0=_nKtuFA@mail.gmail.com>
Subject: Re: [RFC] ima: export the measurement list when needed
To:     Raphael Gianotti <raphgi@linux.microsoft.com>
Cc:     linux-integrity@vger.kernel.org, Mimi Zohar <zohar@linux.ibm.com>,
        Ken Goldman <kgold@linux.ibm.com>, david.safford@gmail.com,
        "Wiseman, Monty (GE Global Research, US)" <monty.wiseman@ge.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Hi,

Come to think of it, there could be a MM trap though as I'm not sure
this has been done before. This new file vmarea would sit in the
kernel virtual memory area somewhere above the page_offset and the mm
code might assume that there is no need to look for dirty pages there
when running the PTE scan. But that shouldn't be more than one line
patch if that is the only trap..


--
Janne

On Wed, Aug 26, 2020 at 4:40 PM Janne Karhunen <janne.karhunen@gmail.com> wrote:
>
> Hi,
>
> Attached a variant of the patch from that time that only does the
> element free and relies on the userspace reading the data.
>
> The reason why I stopped working on this at the time was that below
> was sufficient for my needs. However, after a discussion between Mimi
> and myself (based on a suggestion by Amir Goldstein) we realized that
> we could do something considerably more elegant through vfs_tmpfile.
> It's also much more work.
>
> The way this could probably work the best is if we would implement a
> new allocator that would pull pages from a vmarea tied to a
> vfs_tmpfile and the file could be opened by the kernel itself during
> the ima init. Now if all the measurement list data blobs would be
> allocated through this allocator the pages would never be permanently
> resident in the kernel, they would only visit the memory for a while
> when someone reads the data. If done this way the allocator probably
> does not even need a 'free' and the mm code would do all the real work
> pushing the data out.
>
> The benefits would be that no-one would ever have to poll from
> userspace (kernel does not depend on the userspace to work) and we
> would never OOM because of IMA as long as the filesystem is writable.
> Also we would never lose any data as long as the file system is
> functioning.
>
> Thoughts?
>
>
> --
> Janne
>
> On Wed, Aug 26, 2020 at 11:14 AM Janne Karhunen
> <janne.karhunen@gmail.com> wrote:
> >
> > Hi Raphael,
> >
> > Sorry I missed the reply. I'm not working on this right now, feel free
> > to grab. Please copy me with the results, thank you.
> >
> >
> > --
> > Janne
> >
> > On Tue, Aug 18, 2020 at 12:30 AM Raphael Gianotti
> > <raphgi@linux.microsoft.com> wrote:
> > >
> > >
> > > Hi Janne,
> > >
> > > Subject: Re: [RFC] ima: export the measurement list when needed
> > > > Date: Wed, 18 Dec 2019 17:11:22 +0200
> > > > From: Janne Karhunen <janne.karhunen@gmail.com>
> > > > To: linux-integrity@vger.kernel.org, Mimi Zohar <zohar@linux.ibm.com>
> > > > CC: Ken Goldman <kgold@linux.ibm.com>, david.safford@gmail.com,
> > > > monty.wiseman@ge.com
> > > >
> > > > Hi,
> > > >
> > > > Have in mind that below is the first trial draft that booted and
> > > > seemingly accomplished the task once, it was not really tested at all
> > > > yet. I will make a polished and tested version if people like the
> > > > concept.
> > > >
> > > > Note that the code (almost) supports pushing and pulling of the
> > > > entries. This variant is a simple pull given that the list size is
> > > > above the defined limits. Pushing can be put in place if the recursion
> > > > with the list extend_list_mutex is cleared, maybe this could be done
> > > > via another patch later on when we have a workqueue for the export
> > > > task? The workqueue might be the best context for the export job since
> > > > clearing the list is a heavy operation (and it's not entirely correct
> > > > here AFAIK, there is no rcu sync before the template free).
> > > >
> > > >
> > > > -- Janne
> > > >
> > > > On Wed, Dec 18, 2019 at 2:53 PM Janne Karhunen
> > > > <janne.karhunen@gmail.com> wrote:
> > > >>
> > > >> Some systems can end up carrying lots of entries in the ima
> > > >> measurement list. Since every entry is using a bit of kernel
> > > >> memory, add a new Kconfig variable to allow the sysadmin to
> > > >> define the maximum measurement list size and the location
> > > >> of the exported list.
> > > >>
> > > >> The list is written out in append mode, so the system will
> > > >> keep writing new entries as long as it stays running or runs
> > > >> out of space. File is also automatically truncated on startup.
> > > >>
> > > >> Signed-off-by: Janne Karhunen <janne.karhunen@gmail.com>
> > > >> ---
> > > >>  security/integrity/ima/Kconfig     |  10 ++
> > > >>  security/integrity/ima/ima.h       |   7 +-
> > > >>  security/integrity/ima/ima_fs.c    | 178 +++++++++++++++++++++++++++++
> > > >>  security/integrity/ima/ima_queue.c |   2 +-
> > > >>  4 files changed, 192 insertions(+), 5 deletions(-)
> > >
> > > I've been looking into a solution to this same issue you started some
> > > work on. I was wondering if you are still working on it. I was
> > > considering taking your initial prototyping on this and extending it
> > > into a final solution, but I wanted to reply here first and check if you
> > > are currently working on this.
> > >
