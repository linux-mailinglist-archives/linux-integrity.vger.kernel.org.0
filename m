Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2159A25A5B5
	for <lists+linux-integrity@lfdr.de>; Wed,  2 Sep 2020 08:45:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726669AbgIBGoj (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 2 Sep 2020 02:44:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726510AbgIBGof (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 2 Sep 2020 02:44:35 -0400
Received: from mail-lf1-x143.google.com (mail-lf1-x143.google.com [IPv6:2a00:1450:4864:20::143])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EBBFEC061244
        for <linux-integrity@vger.kernel.org>; Tue,  1 Sep 2020 23:44:34 -0700 (PDT)
Received: by mail-lf1-x143.google.com with SMTP id z17so2173072lfi.12
        for <linux-integrity@vger.kernel.org>; Tue, 01 Sep 2020 23:44:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=YDHke23vzCvAQUQypALWrR4PU/4l3kzoSBeGg71eFZg=;
        b=q+nYeOPgFsmIn4ZgLnkWQU1WumFmGgTzGINUj9HBgF90+cnYgDnTk/GWeESDmHL501
         DOUM2Y0xxsq3jS3JDe1Z33jpc37yYIO0sN5xC/ZQJia64HEi4TNXfMlMoXrFcxeutl4x
         CW2lkkJ9/BcSIGRJLGxyPhrQ5Jb9n7ReoMJdE8Krz22UjFy0271TJdu5I5iTSsANC83u
         PYwVdIIsG8/4wUKVy+kNv1HFEgs5aNNzBHFp38gQUMbh5HWiQtJOsRt2QrBWwA3MpRPc
         VAt+OgwnDyAAvo9tguLYkzT7/GYcGkzG7n53SpQc8ku4HTBP4kbkmvQU4z+Pz4BaQg4o
         GkYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=YDHke23vzCvAQUQypALWrR4PU/4l3kzoSBeGg71eFZg=;
        b=Q7SkE0z26DU7oHtY/UuzVsBCISqIUwExCombMXFrm8xiMpEVYH4VVZWc5PCkE5XioJ
         nnxe9h/U+ZAyk8pS+zKFqT5j617ugKJEXh7Rl8zQwtMzCRQrRlp4vEOwssPsXY2uzc+N
         DHibQAX2TuVYN48VXdAVuYG/wK2air7q/wfo75V9Nr3KwxV+CVbePeWgMDshLzFKPKAt
         eMT6NczLiCgeX1+JTO20wFhC2qWbxDR09bL3djbUecHl9pK6O8lXt46tQp2bqfwmwTWl
         DsUCJzeFf0f1ZGagJbCpUtfN0AkW1uA1+WJFmkYdKijWbR06ZBn4SIRQO2bggU0XlySC
         N14Q==
X-Gm-Message-State: AOAM533zAyPWlmIbIKCihstosi3HcvNcYduP7eSwTwyfr4WcXZTXHGga
        4waqexDlPe/AhhLx3oeANto1Mven+lV0ImAcmNg=
X-Google-Smtp-Source: ABdhPJw9l8Rt9VjSjigDs7V+mj7qqEDEK2qGLnCbR87eSEB0OhDrV0uNM+UsiOVXNajVXi76eE+YzogoQWAU43jrm+A=
X-Received: by 2002:a19:8907:: with SMTP id l7mr2524971lfd.105.1599029072560;
 Tue, 01 Sep 2020 23:44:32 -0700 (PDT)
MIME-Version: 1.0
References: <436e3951-d6d5-014a-dde1-8a6398dfe7a1@linux.microsoft.com>
 <57e0095a-ff6f-e5dc-6250-1320bd6518cb@linux.microsoft.com>
 <CAE=NcrYOy56_mRNUvvOBX5v=zGsNXwqmz9Q6q3Ovu0vfCRKBpQ@mail.gmail.com>
 <CAE=NcraZDd=8GPGYYuKOVtk++yk5iquPHkCa_h4VbUyH-OP6AQ@mail.gmail.com>
 <CAE=NcraN5+K_mNiaDdi7tFn2PFDbXtfaF0K-ozrdq0=_nKtuFA@mail.gmail.com>
 <341c60a8-d037-1b84-d579-e27634c34e68@linux.microsoft.com>
 <CAE=NcrZzFZeuG0f_otk4p6vU5S+KaPdeuq6srvDe8huKFYRVPQ@mail.gmail.com> <eb2b5e27-e5b3-7735-6d6d-367ae167e7cd@linux.microsoft.com>
In-Reply-To: <eb2b5e27-e5b3-7735-6d6d-367ae167e7cd@linux.microsoft.com>
From:   Janne Karhunen <janne.karhunen@gmail.com>
Date:   Wed, 2 Sep 2020 09:44:21 +0300
Message-ID: <CAE=NcrbdS-3gVvnnEwdNSOLOvTenLjyppDz2aJACGRgBYSh=Gw@mail.gmail.com>
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

Hi Raphael,

Thanks a lot. I understand it very well that the mm tricks surprise
many. Moreover, I certainly understand that it might be
over-engineering in the case it hits a trap with the mm, but the
approach does have clear benefits in case it works (most importantly
we would never use any kernel memory). Let's see what you come up
with. Thanks again,


--
Janne

On Wed, Sep 2, 2020 at 12:32 AM Raphael Gianotti
<raphgi@linux.microsoft.com> wrote:
>
> Hi Janne,
>
> As I mentioned previously I know very little about the approach you had
> mentioned. I read a little more on it and I think now I understand it a
> little better and yes, it should actually work.
>
>   I will spend some time familiarizing myself with how this would work
> so I can actually compare both approaches myself on a technical level
> and have a more well informed opinion on the matter before moving on
> with either sending an RFC for the first approach (based on your code
> from last year) or starting some work using the new approach you brought up.
>
> Thanks,
>
> -Raphael
>
> On 8/31/2020 11:52 PM, Janne Karhunen wrote:
> > Hi Raphael,
> >
> > It depends how well you make it, if you do it right you would not lose
> > them. If the pagefile has a readable format it should all be safe,
> > right?
> >
> >
> > --
> > Janne
> >
> > On Mon, Aug 31, 2020 at 7:49 PM Raphael Gianotti
> > <raphgi@linux.microsoft.com> wrote:
> >> Hi Janne,
> >>
> >> Thanks for your response, I didn't reply right away as I hadn't used mm
> >> and vmarea via vfs_tmpfile before, so I wanted to read some code to
> >> familiarize myself with it. Correct me if I am misunderstanding the
> >> approach you mentioned, but in it, we would still lose the logs accross
> >> kexec/cold boots as we do today, is that correct? It feels like this
> >> approach would solely solve the issue where we can potentially run out
> >> of memory for ima logs.
> >>
> >> For the original approach, I have a prototype version that I intend to
> >> send as an RFC soon (I will link you and it's based off of your original
> >> RFC from late last year).
> >>
> >> - Raphael
> >>
> >> On 8/26/2020 7:12 AM, Janne Karhunen wrote:
> >>> Hi,
> >>>
> >>> Come to think of it, there could be a MM trap though as I'm not sure
> >>> this has been done before. This new file vmarea would sit in the
> >>> kernel virtual memory area somewhere above the page_offset and the mm
> >>> code might assume that there is no need to look for dirty pages there
> >>> when running the PTE scan. But that shouldn't be more than one line
> >>> patch if that is the only trap..
> >>>
> >>>
> >>> --
> >>> Janne
> >>>
> >>> On Wed, Aug 26, 2020 at 4:40 PM Janne Karhunen <janne.karhunen@gmail.com> wrote:
> >>>> Hi,
> >>>>
> >>>> Attached a variant of the patch from that time that only does the
> >>>> element free and relies on the userspace reading the data.
> >>>>
> >>>> The reason why I stopped working on this at the time was that below
> >>>> was sufficient for my needs. However, after a discussion between Mimi
> >>>> and myself (based on a suggestion by Amir Goldstein) we realized that
> >>>> we could do something considerably more elegant through vfs_tmpfile.
> >>>> It's also much more work.
> >>>>
> >>>> The way this could probably work the best is if we would implement a
> >>>> new allocator that would pull pages from a vmarea tied to a
> >>>> vfs_tmpfile and the file could be opened by the kernel itself during
> >>>> the ima init. Now if all the measurement list data blobs would be
> >>>> allocated through this allocator the pages would never be permanently
> >>>> resident in the kernel, they would only visit the memory for a while
> >>>> when someone reads the data. If done this way the allocator probably
> >>>> does not even need a 'free' and the mm code would do all the real work
> >>>> pushing the data out.
> >>>>
> >>>> The benefits would be that no-one would ever have to poll from
> >>>> userspace (kernel does not depend on the userspace to work) and we
> >>>> would never OOM because of IMA as long as the filesystem is writable.
> >>>> Also we would never lose any data as long as the file system is
> >>>> functioning.
> >>>>
> >>>> Thoughts?
> >>>>
> >>>>
> >>>> --
> >>>> Janne
> >>>>
> >>>> On Wed, Aug 26, 2020 at 11:14 AM Janne Karhunen
> >>>> <janne.karhunen@gmail.com> wrote:
> >>>>> Hi Raphael,
> >>>>>
> >>>>> Sorry I missed the reply. I'm not working on this right now, feel free
> >>>>> to grab. Please copy me with the results, thank you.
> >>>>>
> >>>>>
> >>>>> --
> >>>>> Janne
> >>>>>
> >>>>> On Tue, Aug 18, 2020 at 12:30 AM Raphael Gianotti
> >>>>> <raphgi@linux.microsoft.com> wrote:
> >>>>>> Hi Janne,
> >>>>>>
> >>>>>> Subject: Re: [RFC] ima: export the measurement list when needed
> >>>>>>> Date: Wed, 18 Dec 2019 17:11:22 +0200
> >>>>>>> From: Janne Karhunen <janne.karhunen@gmail.com>
> >>>>>>> To: linux-integrity@vger.kernel.org, Mimi Zohar <zohar@linux.ibm.com>
> >>>>>>> CC: Ken Goldman <kgold@linux.ibm.com>, david.safford@gmail.com,
> >>>>>>> monty.wiseman@ge.com
> >>>>>>>
> >>>>>>> Hi,
> >>>>>>>
> >>>>>>> Have in mind that below is the first trial draft that booted and
> >>>>>>> seemingly accomplished the task once, it was not really tested at all
> >>>>>>> yet. I will make a polished and tested version if people like the
> >>>>>>> concept.
> >>>>>>>
> >>>>>>> Note that the code (almost) supports pushing and pulling of the
> >>>>>>> entries. This variant is a simple pull given that the list size is
> >>>>>>> above the defined limits. Pushing can be put in place if the recursion
> >>>>>>> with the list extend_list_mutex is cleared, maybe this could be done
> >>>>>>> via another patch later on when we have a workqueue for the export
> >>>>>>> task? The workqueue might be the best context for the export job since
> >>>>>>> clearing the list is a heavy operation (and it's not entirely correct
> >>>>>>> here AFAIK, there is no rcu sync before the template free).
> >>>>>>>
> >>>>>>>
> >>>>>>> -- Janne
> >>>>>>>
> >>>>>>> On Wed, Dec 18, 2019 at 2:53 PM Janne Karhunen
> >>>>>>> <janne.karhunen@gmail.com> wrote:
> >>>>>>>> Some systems can end up carrying lots of entries in the ima
> >>>>>>>> measurement list. Since every entry is using a bit of kernel
> >>>>>>>> memory, add a new Kconfig variable to allow the sysadmin to
> >>>>>>>> define the maximum measurement list size and the location
> >>>>>>>> of the exported list.
> >>>>>>>>
> >>>>>>>> The list is written out in append mode, so the system will
> >>>>>>>> keep writing new entries as long as it stays running or runs
> >>>>>>>> out of space. File is also automatically truncated on startup.
> >>>>>>>>
> >>>>>>>> Signed-off-by: Janne Karhunen <janne.karhunen@gmail.com>
> >>>>>>>> ---
> >>>>>>>>    security/integrity/ima/Kconfig     |  10 ++
> >>>>>>>>    security/integrity/ima/ima.h       |   7 +-
> >>>>>>>>    security/integrity/ima/ima_fs.c    | 178 +++++++++++++++++++++++++++++
> >>>>>>>>    security/integrity/ima/ima_queue.c |   2 +-
> >>>>>>>>    4 files changed, 192 insertions(+), 5 deletions(-)
> >>>>>> I've been looking into a solution to this same issue you started some
> >>>>>> work on. I was wondering if you are still working on it. I was
> >>>>>> considering taking your initial prototyping on this and extending it
> >>>>>> into a final solution, but I wanted to reply here first and check if you
> >>>>>> are currently working on this.
> >>>>>>
