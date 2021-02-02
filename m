Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9399930B77A
	for <lists+linux-integrity@lfdr.de>; Tue,  2 Feb 2021 06:56:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231420AbhBBFzm (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 2 Feb 2021 00:55:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230168AbhBBFzl (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 2 Feb 2021 00:55:41 -0500
Received: from mail-il1-x130.google.com (mail-il1-x130.google.com [IPv6:2607:f8b0:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2287BC061573
        for <linux-integrity@vger.kernel.org>; Mon,  1 Feb 2021 21:55:01 -0800 (PST)
Received: by mail-il1-x130.google.com with SMTP id q5so17983290ilc.10
        for <linux-integrity@vger.kernel.org>; Mon, 01 Feb 2021 21:55:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=b5DJMH/w7D44E+1FfwG/s5wZiBj77V4zuaTb0501xXg=;
        b=uSBQGB4FX/CNo8YcVSwQ0gBp+5erYmyAnY0id3mj5Mnc/VlB5ODW0B51xmfyKHXZnE
         yC4lObmm0N5JbpJBG/ggsregAWqliJ1ifxpD05MFOoU0/a3D82DY3KBxbz9bWTINRjol
         NIDU0EWNhhNIPj+6q39pCROo5kajMmPy89jTjRPwhuSFZUuYAc7d1n3zBo3SdCSSt+/Q
         qionY2KKpl5Gd5LRUlzMikbzkyuilaSwmSifL6EPSj8R0omhUObmOVsL7ZZecYqqMF/O
         ANmDvv45Kt2/sRIzFqg+kiR494YroeQIE/1NRg1s/T0qwDZrl4FKz3hVkkQaDA64fJrG
         igUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=b5DJMH/w7D44E+1FfwG/s5wZiBj77V4zuaTb0501xXg=;
        b=M4uh+eB4ak7rzQdwspFcCUhr6RWidCRlUNw/neBsCcRRo5mXgiXO4I1IPJR3IztoN2
         dSUmN6EDH9y/ykxJn0eDvntekLWRzFAlHn+wA2qaGFXBg4/A03gWxA0h7dY4SC9D0MEH
         jhoypHzyJMFZxq9MF+fFdiL9/uhKELxRmXwsGqau1sSrmgatXMhvOLBW6FbYZe+007C4
         IDFiYyBazv4MWFy4jIBF94dyWpBs596YQXW7RFqmUzA4WDje1BnVO9rgEs8ui9b+s2tH
         QxjvmTVn9CzBv+QFiDY8VKz1bXIlSKnYjpfFFNuwdkKWYlDYO8V99XWpMnz9OUXx4Glr
         j+og==
X-Gm-Message-State: AOAM532jGVxq32H/jOx0ayUxnks2W9lrsFXN+DePSEmDJnJ166c0QxxJ
        fKPtTIwoZe4odqTJMKWQdPMuAs2rjHeYGWzVkvAePU0ZJMw=
X-Google-Smtp-Source: ABdhPJzmOCwX+3jiwn0DGPJBtM4YYkB0I1Y83ln5nt1nfGTvFBxEoT7CKMr5FzaS/5rB7UKr7pSMZilc0lhnAjMWefQ=
X-Received: by 2002:a92:c90b:: with SMTP id t11mr1154483ilp.275.1612245300617;
 Mon, 01 Feb 2021 21:55:00 -0800 (PST)
MIME-Version: 1.0
References: <20210105195742.2629-1-raphgi@linux.microsoft.com>
 <87127d502bcb9707dd4e7a43475ab6bed2fdd421.camel@linux.ibm.com>
 <715a265180a092754ab9ea8522c39427645b25ad.camel@HansenPartnership.com>
 <6e28c7a9742131cf508e77448bfee0a03b2c2e5e.camel@linux.ibm.com>
 <3c50bc449aae2f09bd7d43c401cc9b292f9ec2ae.camel@HansenPartnership.com>
 <570d54ca679b7a4f786fa65eb78601a2af91c397.camel@linux.ibm.com>
 <13447f30db609d4bd77d5a826c5102dd5a931a19.camel@HansenPartnership.com>
 <734adc26-0050-ce8f-4c8c-c8a907b569a6@linux.microsoft.com>
 <8c78437d0e9a4968996b834030661b6f567f87eb.camel@linux.ibm.com>
 <fc9a5d48-dc29-0d5d-55dd-bacac346da10@linux.microsoft.com> <3f76d250-6aa7-65c1-b903-5bc82f6f8845@linux.microsoft.com>
In-Reply-To: <3f76d250-6aa7-65c1-b903-5bc82f6f8845@linux.microsoft.com>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Tue, 2 Feb 2021 07:54:49 +0200
Message-ID: <CAOQ4uxj4Pv2Wr1wgvBCDR-tnA5dsZT3rvdDzKgAH1aEV_-r9Qg@mail.gmail.com>
Subject: Re: [RFC] Persist ima logs to disk
To:     Raphael Gianotti <raphgi@linux.microsoft.com>
Cc:     Mimi Zohar <zohar@linux.ibm.com>,
        James Bottomley <James.Bottomley@hansenpartnership.com>,
        janne.karhunen@gmail.com,
        linux-integrity <linux-integrity@vger.kernel.org>,
        tusharsu@linux.microsoft.com, tyhicks@linux.microsoft.com,
        nramas@linux.microsoft.com, balajib@linux.microsoft.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Tue, Feb 2, 2021 at 12:53 AM Raphael Gianotti
<raphgi@linux.microsoft.com> wrote:
>
>
> On 1/8/2021 9:58 AM, Raphael Gianotti wrote:
> >
> > On 1/8/2021 4:38 AM, Mimi Zohar wrote:
> >> On Thu, 2021-01-07 at 14:57 -0800, Raphael Gianotti wrote:
> >>>>>>> But this doesn't address where the offloaded measurement list
> >>>>>>> will be stored, how long the list will be retained, nor who
> >>>>>>> guarantees the integrity of the offloaded list.  In addition,
> >>>>>>> different form factors will have different requirements.
> >>> For how long the list would be retained, or in the case of a log
> >>> segments, it
> >>> might make sense to have that be an admin decision, something that
> >>> can be
> >>> configured to satisfy the needs of a specific system, as mentioned
> >>> below by
> >>> James, does that seem correct?
> >> For the discussion on exporting and truncating the IMA measurement
> >> list, refer to:
> >> https://lore.kernel.org/linux-integrity/1580998432.5585.411.camel@linux.ibm.com/
> >>
> >>
> >>> Given the possibility of keeping the logs around for an indefinite
> >>> amount of
> >>> time, would using an expansion of the method present in this RFC be
> >>> more
> >>> appropriate than going down the vfs_tmpfile route? Forgive my lack
> >>> on expertise
> >>> on mm, but would the vfs_tmpfile approach work for keeping several
> >>> log segments
> >>> across multiple kexecs?
> >> With the "vfs_tmpfile" mechanism, breaking up and saving the log in
> >> segments isn't needed.  The existing mechanism for carrying the
> >> measurement list across kexec would still be used.  Currently, if the
> >> kernel cannot allocate the memory needed for carrying the measurement
> >> across kexec, it simply emits an error message, but continues with the
> >> kexec.
> >
> > In this change I had introduced "exporting" the log to disk when the size
> > of the measurement list was too large. Given part of the motivation
> > behind
> > moving the measurement list is the possibility of it growing too large
> > and taking up too much of the kernel memory, that case would likely lead
> > to kexec not being able to carry over the logs. Do you believe it's
> > better
> > to use the "vfs_tmpfile" mechanism for moving the logs to disk and worry
> > about potential issues with kexec not being able to carry over the logs
> > separately, given the "vfs_tempfile" approach seems to be preferred and
> > also simplifies worries regarding truncating the logs?
>
> After a chat with Mimi I went ahead and did some investigative
> work in the vfs_tmpfile approach suggested, and I wanted to
> restart this thread with some thoughts/questions that came up
> from that.
> For the work I did I simply created a tmp file during ima's
> initialization and then tried to use vm_mmap to map it to memory,
> with the goal of using that memory mapping to generate return
> pointers to the code that writes the measurement entries to memory.

I don't understand why you would want to do that. I might have misunderstood
the requirements, but this was not how I meant for tmpfile to be used.

Mimi explained to me that currently the IMA measurement list is entirely in
memory and that you are looking for a way to dump it into a file in order to
free up memory.

What I suggested is this:

- User opens an O_TMPFILE and passes fd to IMA to start export
- IMA starts writing (exporting) records to that file using *kernel* write API
- Every record written to the file is removed from the in-memory list
- While list is being exported, IMA keeps in-memory count of exported entries
- In ima_measurements_start, if export file exists, start iterator
starts reading
  records from the file
- In ima_measurements_next(), when next iterator reaches the export count,
  it switches over to iterate in-memory list

This process can:
1. Continue forever without maintaining any in-memory list
2. Work in the background to periodically flush list to file
3. Controlled by explicit user commands
4. All of the above

Is that understood? Did I understand the requirements correctly?

Thanks,
Amir.
