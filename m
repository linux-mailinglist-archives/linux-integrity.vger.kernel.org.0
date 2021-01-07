Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 799212ED48E
	for <lists+linux-integrity@lfdr.de>; Thu,  7 Jan 2021 17:44:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728842AbhAGQnQ (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 7 Jan 2021 11:43:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728118AbhAGQnP (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 7 Jan 2021 11:43:15 -0500
Received: from bedivere.hansenpartnership.com (bedivere.hansenpartnership.com [IPv6:2607:fcd0:100:8a00::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AECB8C0612F4
        for <linux-integrity@vger.kernel.org>; Thu,  7 Jan 2021 08:42:35 -0800 (PST)
Received: from localhost (localhost [127.0.0.1])
        by bedivere.hansenpartnership.com (Postfix) with ESMTP id 61EDD1280107;
        Thu,  7 Jan 2021 08:42:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
        d=hansenpartnership.com; s=20151216; t=1610037753;
        bh=Z3O619tacpB85wmFOEAStwY0nkcDyv6IfHClJOMSMps=;
        h=Message-ID:Subject:From:To:Date:In-Reply-To:References:From;
        b=RPbSfUS1moAxSFfG9RXC4gYEwNr8FS7dJohGHTl+5emhuNlk4NxRXmHVcT7Dfvukp
         /WGqXHLxUAjlWmep2SZzx+pcOC/jFdR2VSZkSbvXAStRUOLdti9OydQPvEfJFlTBg6
         QP2PrXzdL2UtTDKOEUQpzydIG7YLBAgmWRPQW56U=
Received: from bedivere.hansenpartnership.com ([127.0.0.1])
        by localhost (bedivere.hansenpartnership.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id nVuGRP--WYfi; Thu,  7 Jan 2021 08:42:33 -0800 (PST)
Received: from jarvis.int.hansenpartnership.com (unknown [IPv6:2601:600:8280:66d1::c447])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by bedivere.hansenpartnership.com (Postfix) with ESMTPSA id C475D12800A7;
        Thu,  7 Jan 2021 08:42:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
        d=hansenpartnership.com; s=20151216; t=1610037753;
        bh=Z3O619tacpB85wmFOEAStwY0nkcDyv6IfHClJOMSMps=;
        h=Message-ID:Subject:From:To:Date:In-Reply-To:References:From;
        b=RPbSfUS1moAxSFfG9RXC4gYEwNr8FS7dJohGHTl+5emhuNlk4NxRXmHVcT7Dfvukp
         /WGqXHLxUAjlWmep2SZzx+pcOC/jFdR2VSZkSbvXAStRUOLdti9OydQPvEfJFlTBg6
         QP2PrXzdL2UtTDKOEUQpzydIG7YLBAgmWRPQW56U=
Message-ID: <715a265180a092754ab9ea8522c39427645b25ad.camel@HansenPartnership.com>
Subject: Re: [RFC] Persist ima logs to disk
From:   James Bottomley <James.Bottomley@HansenPartnership.com>
To:     Mimi Zohar <zohar@linux.ibm.com>,
        Raphael Gianotti <raphgi@linux.microsoft.com>,
        janne.karhunen@gmail.com
Cc:     linux-integrity@vger.kernel.org, tusharsu@linux.microsoft.com,
        tyhicks@linux.microsoft.com, nramas@linux.microsoft.com,
        balajib@linux.microsoft.com, Amir Goldstein <amir73il@gmail.com>
Date:   Thu, 07 Jan 2021 08:42:32 -0800
In-Reply-To: <87127d502bcb9707dd4e7a43475ab6bed2fdd421.camel@linux.ibm.com>
References: <20210105195742.2629-1-raphgi@linux.microsoft.com>
         <87127d502bcb9707dd4e7a43475ab6bed2fdd421.camel@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.34.4 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Thu, 2021-01-07 at 10:06 -0500, Mimi Zohar wrote:
> [Cc: Amir Goldstein]
> 
> On Tue, 2021-01-05 at 11:57 -0800, Raphael Gianotti wrote:
> > IMA measures files and buffer data and some systems may end up
> > generating lots of entries in the IMA measurement list. This list
> > is kept in kernel memoryc and as it grows in size it could end up
> > taking too many resources, causing the system to run out of
> > available memory. During kexec, the IMA measurement list can be
> > carried over in memory, but it's possible for the list to become
> > too large for that to happen.
> > 
> > The Kconfig introduced in this series enables admins to configure a
> > maximum number of entries and a file to export the IMA measurement
> > list to whenever the set limit is reached.
> > 
> > The list is written out in append mode, so the system will keep
> > writing new entries as long as it stays running or runs out of
> > space. Whenever the export file is set, it's truncated. If writing
> > to the export list fails, a flag is set to prevent further exports,
> > as the file is likely in a bad state. Setting a new export file
> > resets this flag, allowing exports to resume and giving admins a
> > way to recover from this state if necessary.
> > 
> > In the case of kexec, if the list is too large too be carried over
> > in memory and an export file is configured, the list will be
> > exported, preventing the measurements from being lost during kexec.
> > 
> > This code is based off of a previous RFC sent by Janne Karhunen[1],
> > and is intended to pick up where that was left off.
> > 
> > In a thread with Janne Karhunen[2], it was mentioned that another
> > approach, using mm had been considered. Upon some investigation the
> > approach used in this RFC still seemed adequate for solving this
> > problem.
> > 
> > [1] 
> > https://patchwork.kernel.org/project/linux-integrity/patch/201912
> > 20074929.8191-1-janne.karhunen@gmail.com/
> > [2] 
> > https://lore.kernel.org/linux-integrity/CAE=NcrbdS-3gVvnnEwdNSOLO
> > vTenLjyppDz2aJACGRgBYSh=Gw@mail.gmail.com/
> > 
> > Signed-off-by: Raphael Gianotti <raphgi@linux.microsoft.com>
> 
> My original concerns of truncating the IMA measurement list have not
> been addressed.  Once the IMA measurement list has been truncated,
> quoting and then verifying any of the PCRs contained in the
> measurement list will fail, unless the measurements have been
> preserved and are readily accessible.
> 
> Amir's suggestion addresses kernel memory constraints without
> truncating the IMA measurement list.

What about having a log entry that's the current PCR value?  Then
stretches of the log starting with these entries would be independently
verifiable provided you had a way of trusting the PCR value.  It might
be possible to get the TPM to add a signed quote as an optional part of
the log entry (of course this brings other problems like which key do
you use for the signing and how does it get verified) which would
provide the trust and would definitively allow you to archive log
segments and still make the rest of the log useful.

James


