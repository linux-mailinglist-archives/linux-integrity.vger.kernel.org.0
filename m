Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 11441252902
	for <lists+linux-integrity@lfdr.de>; Wed, 26 Aug 2020 10:15:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726690AbgHZIPK (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 26 Aug 2020 04:15:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726016AbgHZIPK (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 26 Aug 2020 04:15:10 -0400
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7BC9BC061574
        for <linux-integrity@vger.kernel.org>; Wed, 26 Aug 2020 01:15:09 -0700 (PDT)
Received: by mail-lf1-x12f.google.com with SMTP id x64so509358lff.0
        for <linux-integrity@vger.kernel.org>; Wed, 26 Aug 2020 01:15:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=4yATq2MR8la2Bc4bQ3AwTbjiJ3p/Q0bAzZG+f16r8BY=;
        b=NtPGRUC0Emn0nJWUcLQrK69/awPPG/z/G64X9J1MO+FzBB5NcnJE66WiwDKo9B1eDs
         HnVhqDPLOa9Jf/s/PlbwzCgsTEqtI/5SvPjRFQyx49GOUwrFd+rQJbpNop8IzMq6mBrC
         CP/M/5ruW77z2fmdnUbSzTDXAl0tQIH0/BuTt3b8dcE6qAj2y9MSrBLwylSqfajAfKlU
         +ploJmYtT9EbZmodGNFrXqnrpqoMAHKwxB4DlVTppYYLyNS/eSG4OklwsDDw4tlM1/GC
         19NhxWmsccg6mjGfPHovNl1kdoqsDeK/xjv4p3GlXy11lDQX1JZIY/KATHFAfEpnnTEd
         HaZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=4yATq2MR8la2Bc4bQ3AwTbjiJ3p/Q0bAzZG+f16r8BY=;
        b=MUBcF2Y+bF+62M5J7EHlu3U3BdIZDaZ4dvm2jD/0qZjCZywa9Ul/oBddHiYBRNxOjt
         Xuugg3mTKZsa29THkl1HZifhVXE0TP+34BmoPTEdOmFq4y7I3+EmVBU2umYjaz7ARfli
         V/Yjo37GfQHJTMGzn16JBolwYWE7P78RMdMWxRcugkzoxyIy5/KRYbFpSGytXyncLc2J
         GJ9tthkEpN46evg9wJAgMuOUHpvafBzRqRYCClEVuNZobto2QbwDSHYWBtqP1AUZukP7
         pOM0YyKFJbo/kS6Zw9j8IoJ3HhGNzw9c/mG233ClhjCGu5JgSes6ZrGhiGiE0T477Auk
         1t2A==
X-Gm-Message-State: AOAM5321A0PQ28p93oaYZxiRZTwwBg3bp7KfPecz9Ula838oI3Mkz7kb
        GWBAHoiVnpfzVoCU2T/+11cZiV1d9EvqO6Pw7eg=
X-Google-Smtp-Source: ABdhPJzsupgEUgXuqx7NcbnAJdZexJ2y4KiN/tW0arqvtpgFa5CO62MHrSCtY15612xfkjPzcj88MKUCjWIxheTRizg=
X-Received: by 2002:ac2:58c6:: with SMTP id u6mr6821824lfo.105.1598429707616;
 Wed, 26 Aug 2020 01:15:07 -0700 (PDT)
MIME-Version: 1.0
References: <436e3951-d6d5-014a-dde1-8a6398dfe7a1@linux.microsoft.com> <57e0095a-ff6f-e5dc-6250-1320bd6518cb@linux.microsoft.com>
In-Reply-To: <57e0095a-ff6f-e5dc-6250-1320bd6518cb@linux.microsoft.com>
From:   Janne Karhunen <janne.karhunen@gmail.com>
Date:   Wed, 26 Aug 2020 11:14:56 +0300
Message-ID: <CAE=NcrYOy56_mRNUvvOBX5v=zGsNXwqmz9Q6q3Ovu0vfCRKBpQ@mail.gmail.com>
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

Sorry I missed the reply. I'm not working on this right now, feel free
to grab. Please copy me with the results, thank you.


--
Janne

On Tue, Aug 18, 2020 at 12:30 AM Raphael Gianotti
<raphgi@linux.microsoft.com> wrote:
>
>
> Hi Janne,
>
> Subject: Re: [RFC] ima: export the measurement list when needed
> > Date: Wed, 18 Dec 2019 17:11:22 +0200
> > From: Janne Karhunen <janne.karhunen@gmail.com>
> > To: linux-integrity@vger.kernel.org, Mimi Zohar <zohar@linux.ibm.com>
> > CC: Ken Goldman <kgold@linux.ibm.com>, david.safford@gmail.com,
> > monty.wiseman@ge.com
> >
> > Hi,
> >
> > Have in mind that below is the first trial draft that booted and
> > seemingly accomplished the task once, it was not really tested at all
> > yet. I will make a polished and tested version if people like the
> > concept.
> >
> > Note that the code (almost) supports pushing and pulling of the
> > entries. This variant is a simple pull given that the list size is
> > above the defined limits. Pushing can be put in place if the recursion
> > with the list extend_list_mutex is cleared, maybe this could be done
> > via another patch later on when we have a workqueue for the export
> > task? The workqueue might be the best context for the export job since
> > clearing the list is a heavy operation (and it's not entirely correct
> > here AFAIK, there is no rcu sync before the template free).
> >
> >
> > -- Janne
> >
> > On Wed, Dec 18, 2019 at 2:53 PM Janne Karhunen
> > <janne.karhunen@gmail.com> wrote:
> >>
> >> Some systems can end up carrying lots of entries in the ima
> >> measurement list. Since every entry is using a bit of kernel
> >> memory, add a new Kconfig variable to allow the sysadmin to
> >> define the maximum measurement list size and the location
> >> of the exported list.
> >>
> >> The list is written out in append mode, so the system will
> >> keep writing new entries as long as it stays running or runs
> >> out of space. File is also automatically truncated on startup.
> >>
> >> Signed-off-by: Janne Karhunen <janne.karhunen@gmail.com>
> >> ---
> >>  security/integrity/ima/Kconfig     |  10 ++
> >>  security/integrity/ima/ima.h       |   7 +-
> >>  security/integrity/ima/ima_fs.c    | 178 +++++++++++++++++++++++++++++
> >>  security/integrity/ima/ima_queue.c |   2 +-
> >>  4 files changed, 192 insertions(+), 5 deletions(-)
>
> I've been looking into a solution to this same issue you started some
> work on. I was wondering if you are still working on it. I was
> considering taking your initial prototyping on this and extending it
> into a final solution, but I wanted to reply here first and check if you
> are currently working on this.
>
