Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 32C2030D405
	for <lists+linux-integrity@lfdr.de>; Wed,  3 Feb 2021 08:25:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231786AbhBCHZd (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 3 Feb 2021 02:25:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231654AbhBCHZc (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 3 Feb 2021 02:25:32 -0500
Received: from mail-il1-x134.google.com (mail-il1-x134.google.com [IPv6:2607:f8b0:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 329C1C061573
        for <linux-integrity@vger.kernel.org>; Tue,  2 Feb 2021 23:24:52 -0800 (PST)
Received: by mail-il1-x134.google.com with SMTP id p15so20822197ilq.8
        for <linux-integrity@vger.kernel.org>; Tue, 02 Feb 2021 23:24:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=kXPie67aGWHPNgHF47uizQ310O1g0sk2Dck2gjccgw8=;
        b=sjjHv52dlI9Y0slZMd04GVJKtCrTrdz2SR2wEtwnldo1mzcJ+SbnxKjAk5MFn6xV05
         0B9uPqTD5ir0srolfrUQt5kb9fPsNkocbf4auxFuzEWxUieaB88p8qQ85l6xuZScy/lD
         YTVjbUkF5xM6QtVKKiTBdbQc1HCOBeZPbOThDF8Dj5dqHTWo6zmGk4cW9+1e2jpF0Ogf
         ZcdUQzu92PtvHlAMNsGYs1OU3nQbBSAsEjwOBfy+pXa247cjZAafOt22kakgQEwlwRLf
         Dqp9NcOs8A3gxl0MJ4A86A1alkP836pn26AyIElUG+NUrnk6oCIRSSlaHXA0AJ3L/aPd
         SHrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=kXPie67aGWHPNgHF47uizQ310O1g0sk2Dck2gjccgw8=;
        b=JAb2u66ecdVvvdSLk5chYffK2c/4C+vw5xNqcaNEPrmevq44LgVlUWR2Q4sFNwcN4b
         c+oK9/YwPj/s+iP8ayEbZX7ryi14eSjMAxGZs5CiNtGnX9LIsyMD4PiJHrbjIT7KHgof
         aE8kUQQoNvCVE409kXP+5SJ/G2Q1/0IkfTpQBktBcyTsBx+9XyiVrI7MI0sJAJ0931Bh
         kOhL1fXeK7EUl/FX6RGEwoBRcZGcQQeR0uWkcIoTM2bC3ubETcesU/f3XwDMJurCB+LU
         fTZd6Q4HE/lpbXTOqPM9LgzxTYpdn72N8fDmZA6V1UtQevCL5yS69BYMAt3uUiR2X4Hf
         JEHw==
X-Gm-Message-State: AOAM5310oliabSanRZK2gUt7GZBU0BHO3e72c/yMbXsprPTUc0ncV/ra
        pPr2TleD6i7Nln856q8XhmskP3/j7usw48soy1Q=
X-Google-Smtp-Source: ABdhPJxXX3IrxxT2IvvRaHyt9LITDTLYG70D5JNzrRoa54eH+wZ8pJnCTVkx74qFX9YNdlgRNTWDq95yFl6+Rm//EEM=
X-Received: by 2002:a92:8e42:: with SMTP id k2mr1690557ilh.250.1612337091574;
 Tue, 02 Feb 2021 23:24:51 -0800 (PST)
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
 <fc9a5d48-dc29-0d5d-55dd-bacac346da10@linux.microsoft.com>
 <3f76d250-6aa7-65c1-b903-5bc82f6f8845@linux.microsoft.com>
 <CAOQ4uxj4Pv2Wr1wgvBCDR-tnA5dsZT3rvdDzKgAH1aEV_-r9Qg@mail.gmail.com>
 <3f1571d5b9f2fbb6a8ff9a5fad75b54e2b597904.camel@linux.ibm.com>
 <169af4d7-9f1a-69c9-44a8-9d30deab80cb@linux.microsoft.com> <2cab86154362ac145d3749d05a06a2d4340264f6.camel@linux.ibm.com>
In-Reply-To: <2cab86154362ac145d3749d05a06a2d4340264f6.camel@linux.ibm.com>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Wed, 3 Feb 2021 09:24:40 +0200
Message-ID: <CAOQ4uxiBAGKco1BKgyLOMY54r_Ck2jnvz8RCFODD-V87CGqLEw@mail.gmail.com>
Subject: Re: [RFC] Persist ima logs to disk
To:     Mimi Zohar <zohar@linux.ibm.com>
Cc:     Raphael Gianotti <raphgi@linux.microsoft.com>,
        James Bottomley <James.Bottomley@hansenpartnership.com>,
        janne.karhunen@gmail.com,
        linux-integrity <linux-integrity@vger.kernel.org>,
        tusharsu@linux.microsoft.com, tyhicks@linux.microsoft.com,
        nramas@linux.microsoft.com, balajib@linux.microsoft.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Wed, Feb 3, 2021 at 3:02 AM Mimi Zohar <zohar@linux.ibm.com> wrote:
>
> On Tue, 2021-02-02 at 10:14 -0800, Raphael Gianotti wrote:
> > On 2/2/2021 5:07 AM, Mimi Zohar wrote:
> > > On Tue, 2021-02-02 at 07:54 +0200, Amir Goldstein wrote:
> > >> On Tue, Feb 2, 2021 at 12:53 AM Raphael Gianotti
> > >> <raphgi@linux.microsoft.com> wrote:
> > >>>
> > >>> On 1/8/2021 9:58 AM, Raphael Gianotti wrote:
> > >>>> On 1/8/2021 4:38 AM, Mimi Zohar wrote:
> > >>>>> On Thu, 2021-01-07 at 14:57 -0800, Raphael Gianotti wrote:
> > >>>>>>>>>> But this doesn't address where the offloaded measurement list
> > >>>>>>>>>> will be stored, how long the list will be retained, nor who
> > >>>>>>>>>> guarantees the integrity of the offloaded list.  In addition,
> > >>>>>>>>>> different form factors will have different requirements.
> > >>>>>> For how long the list would be retained, or in the case of a log
> > >>>>>> segments, it
> > >>>>>> might make sense to have that be an admin decision, something that
> > >>>>>> can be
> > >>>>>> configured to satisfy the needs of a specific system, as mentioned
> > >>>>>> below by
> > >>>>>> James, does that seem correct?
> > >>>>> For the discussion on exporting and truncating the IMA measurement
> > >>>>> list, refer to:
> > >>>>> https://lore.kernel.org/linux-integrity/1580998432.5585.411.camel@linux.ibm.com/
> > >>>>>
> > >>>>>
> > >>>>>> Given the possibility of keeping the logs around for an indefinite
> > >>>>>> amount of
> > >>>>>> time, would using an expansion of the method present in this RFC be
> > >>>>>> more
> > >>>>>> appropriate than going down the vfs_tmpfile route? Forgive my lack
> > >>>>>> on expertise
> > >>>>>> on mm, but would the vfs_tmpfile approach work for keeping several
> > >>>>>> log segments
> > >>>>>> across multiple kexecs?
> > >>>>> With the "vfs_tmpfile" mechanism, breaking up and saving the log in
> > >>>>> segments isn't needed.  The existing mechanism for carrying the
> > >>>>> measurement list across kexec would still be used.  Currently, if the
> > >>>>> kernel cannot allocate the memory needed for carrying the measurement
> > >>>>> across kexec, it simply emits an error message, but continues with the
> > >>>>> kexec.
> > >>>> In this change I had introduced "exporting" the log to disk when the size
> > >>>> of the measurement list was too large. Given part of the motivation
> > >>>> behind
> > >>>> moving the measurement list is the possibility of it growing too large
> > >>>> and taking up too much of the kernel memory, that case would likely lead
> > >>>> to kexec not being able to carry over the logs. Do you believe it's
> > >>>> better
> > >>>> to use the "vfs_tmpfile" mechanism for moving the logs to disk and worry
> > >>>> about potential issues with kexec not being able to carry over the logs
> > >>>> separately, given the "vfs_tempfile" approach seems to be preferred and
> > >>>> also simplifies worries regarding truncating the logs?
> > >>> After a chat with Mimi I went ahead and did some investigative
> > >>> work in the vfs_tmpfile approach suggested, and I wanted to
> > >>> restart this thread with some thoughts/questions that came up
> > >>> from that.
> > >>> For the work I did I simply created a tmp file during ima's
> > >>> initialization and then tried to use vm_mmap to map it to memory,
> > >>> with the goal of using that memory mapping to generate return
> > >>> pointers to the code that writes the measurement entries to memory.
> > >> I don't understand why you would want to do that. I might have misunderstood
> > >> the requirements, but this was not how I meant for tmpfile to be used.
> > >>
> > >> Mimi explained to me that currently the IMA measurement list is entirely in
> > >> memory and that you are looking for a way to dump it into a file in order to
> > >> free up memory.
> > >>
> > >> What I suggested is this:
> > >>
> > >> - User opens an O_TMPFILE and passes fd to IMA to start export
> > >> - IMA starts writing (exporting) records to that file using *kernel* write API
> > >> - Every record written to the file is removed from the in-memory list
> > >> - While list is being exported, IMA keeps in-memory count of exported entries
> > >> - In ima_measurements_start, if export file exists, start iterator
> > >> starts reading
> > >>    records from the file
> > >> - In ima_measurements_next(), when next iterator reaches the export count,
> > >>    it switches over to iterate in-memory list
> > >>
> > >> This process can:
> > >> 1. Continue forever without maintaining any in-memory list
> > >> 2. Work in the background to periodically flush list to file
> > >> 3. Controlled by explicit user commands
> > >> 4. All of the above
> > >>
> > >> Is that understood? Did I understand the requirements correctly?
> >
> > Thanks for the clarification Amir, I never actually saw your initial mails,
> > I apologize for the confusion, the use of mmap was something the original
> > author of the export ima logs to disk mentioned had been suggested, which
> > is why I went down that route.
> > Given the actual suggestion you originally had given, I believe the coding
> > of it is somewhat to the code I sent in the RFC in terms of approach (if we
> > were to have it do periodic flushes, for example). With the addition of
> > reads to the log starting with the file as the oldest logs will be there.
> > I believe the only difference there is whether the list is kept in a tmp
> > file or not, so with the tmp file approach it would be just to keep the
> > list out of memory (either partially or permanently), where with a permanent
> > file, the list would still be available after a cold boot for instance.
>
> With Amir's suggestion, userspace still accesses the entire measurement
> list via the existing securityfs interface.  Only the kernel should be
> able to append or access the file.
>

This user API is not an important part of the suggestion:

- User opens an O_TMPFILE and passes fd to IMA to start export

It is just how I understood the API should be.
Kernel could open the O_TMPFILE or named file for that matter just as well.
If the kernel opens an O_TMPFILE, userspace has no standard way to access
that file. There are, as always, ways for privileged users to learn about that
tmpfile and open it with open_by_handle_at().

IMA is an LSM, so the best way to block unauthorized access to that file
would be via LSM hooks. IMA keeps a reference to that file, so it can
identify access to that file from userspace.

Thanks,
Amir.
