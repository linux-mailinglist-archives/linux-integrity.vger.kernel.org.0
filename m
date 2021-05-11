Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DC81037B2C2
	for <lists+linux-integrity@lfdr.de>; Wed, 12 May 2021 01:48:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229714AbhEKXt5 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 11 May 2021 19:49:57 -0400
Received: from mail.kernel.org ([198.145.29.99]:34176 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229637AbhEKXt5 (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 11 May 2021 19:49:57 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id D6EE56187E;
        Tue, 11 May 2021 23:48:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1620776930;
        bh=f5Uhg86TzwOug98fVuQOrwO2KdOffUz8NoVk+Hq5+28=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=mG4AaYJgGIJdUykFXlwEvd3iaBtl2lEKie9v5OhhHCaoJDshx+jHoiZOWmBkc90I8
         pjfrqfzweVY/gUrRno7e8XRIx4la4XoesSX6O9I3fLtur7cGrRQpb5qMCNKU7ix7Lb
         26xt1QFJR5YxC0AYo1XChpZPnbHIThPDTMdsGH657UYNLmCb3WJMFciW2WTY6WEmCE
         uB7uOrMB3YLMGUC82YdM5lMgSWONeR5PzMrexopb+VutEjR+Ljni87nnIqwYdBNo5t
         mZxsXCfGIUA4J96XuOiB1iyvBuEx9rl8jJ+ZRTDyNc+FE7d5gp5PfmX+daVmmslKkJ
         Q0FvnzINqT3BQ==
Date:   Wed, 12 May 2021 02:48:48 +0300
From:   Jarkko Sakkinen <jarkko@kernel.org>
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     Jerry Snitselaar <jsnitsel@redhat.com>,
        Matthew Garrett <mjg59@google.com>,
        James Bottomley <James.Bottomley@hansenpartnership.com>,
        linux-integrity <linux-integrity@vger.kernel.org>
Subject: Re: Recent tpm_tis IRQ handling changes are causing kernel backtraces
Message-ID: <YJsX4MSmhKc0r8Tz@kernel.org>
References: <34442b17-c8e6-9d33-831f-fcbf3a38552b@redhat.com>
 <e4afc566-0114-c5a3-ebda-a775132e999d@redhat.com>
 <YFEEas6kH3FUoKJe@kernel.org>
 <8b592417-dc1d-a7f8-0e17-09b6bb1df33a@redhat.com>
 <YJlsdgxPIm5I6Jk8@kernel.org>
 <4f525bca-3836-7f5c-7913-e54d620473aa@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4f525bca-3836-7f5c-7913-e54d620473aa@redhat.com>
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Tue, May 11, 2021 at 10:37:40AM +0200, Hans de Goede wrote:
> Hi,
> 
> On 5/10/21 7:25 PM, Jarkko Sakkinen wrote:
> > On Sat, May 08, 2021 at 11:07:43AM +0200, Hans de Goede wrote:
> >> Hi Jarko,
> >>
> >> On 3/16/21 8:18 PM, Jarkko Sakkinen wrote:
> >>> On Tue, Mar 16, 2021 at 04:34:01PM +0100, Hans de Goede wrote:
> >>>> Hi,
> >>>>
> >>>> On 2/11/21 2:09 PM, Hans de Goede wrote:
> >>>>> Hi Jerry,
> >>>>>
> >>>>> It looks like there still is an issue with the recent changes to the tpm_tis IRQ
> >>>>> handling. At least I think those are the cause I did not dive any deeper,
> >>>>> I just noticed that we (Fedora) have been receiving an aweful lot of
> >>>>> kernel tpm_tis_send_data backtraces with most starting with tpm_tis_probe_irq_...
> >>>>>
> >>>>> See for example:
> >>>>> https://bugzilla.redhat.com/show_bug.cgi?id=1912167
> >>>>> https://bugzilla.redhat.com/show_bug.cgi?id=1927610
> >>>>>
> >>>>> Those are just the 3 which landed in my inbox today, for much more see:
> >>>>> https://bugzilla.redhat.com/buglist.cgi?quicksearch=tpm_tis_send_data
> >>>>> (this shows 18 bugs atm).
> >>>>>
> >>>>> These were reported through the Fedora ABRT tools which automatically
> >>>>> collects backtraces, the bugs have links to the ABRT reports, e.g. :
> >>>>> https://retrace.fedoraproject.org/faf/reports/28155/
> >>>>> https://retrace.fedoraproject.org/faf/reports/37107/
> >>>>>
> >>>>> The 28155 report says that so far there have been 308,412 (ouch) automatic
> >>>>> uploads of that particular variant of these backtraces
> >>>>>
> >>>>> Note the second (37107) retrace report is about this happening
> >>>>> on resume, rather then on probe/tpm_tis_probe_irq_... time.
> >>>>>
> >>>>> Did your work on this work land in 5.10 ? Or could it be that the
> >>>>> issue is an incomplete backport to the 5.10.y stable series ?
> >>>>
> >>>> Ping ?
> >>>>
> >>>> It is raining bug-reports about this:
> >>>>
> >>>> https://bugzilla.redhat.com/buglist.cgi?quicksearch=tpm_tis_send_data
> >>>>
> >>>> Currently lists 25 bugs and that is excluding bugs which have already
> >>>> been marked as a duplicate.
> >>>>
> >>>> Can someone involved in the patch-series which is causing this regression
> >>>> please take a look at these kernel backtraces ?
> >>>>
> >>>> Regards,
> >>>>
> >>>> Hans
> >>>
> >>> I incorporated two fixes to this issue to my last PR, which were taken
> >>> to the mainline. What is the situation with the mainline?
> >>
> >> Thank you for your reply and sorry for being slow to respond.
> >>
> >> Is this expected to be fixed in 5.11, or when you say mainline you
> >> main Linus' master branch / so the fixes are in 5.12 only ?
> >>
> >> The reason I'm asking is because we just received another bugreport
> >> about this against 5.11.17. The bug is marked private (our tool to
> >> automatically file bugs for kernel backtraces does this) so let me
> >> just copy and paste the trace here:
> >>
> >> WARNING: CPU: 0 PID: 3060 at drivers/char/tpm/tpm_tis_core.c:205
> >> tpm_tis_status+0x66/0x70
> >>
> >> CPU: 0 PID: 3060 Comm: systemd-sleep Not tainted 5.11.17-200.fc33.x86_64 #1
> >> Hardware name: Hewlett-Packard HP ProBook 6460b/161D, BIOS 68SCE Ver. F.63
> >> 05/27/2016
> >> RIP: 0010:tpm_tis_status+0x66/0x70
> >> Code: 23 75 05 48 83 c4 10 c3 31 c0 80 3d 38 02 56 01 00 75 f0 48 c7 c7 94 67
> >> 43 96 88 44 24 07 c6 05 24 02 56 01 01 e8 4a 53 3c 00 <0f> 0b 0f b6 44 24 07 eb
> >> d0 90 66 66 66 66 90 41 57 41 56 41 55 41
> >> RSP: 0018:ffffaac581427b10 EFLAGS: 00010282
> >> RAX: 000000000000001b RBX: ffff9dc800b93000 RCX: ffff9dc83b418ac8
> >> RDX: 00000000ffffffd8 RSI: 0000000000000027 RDI: ffff9dc83b418ac0
> >> RBP: ffff9dc800b93000 R08: ffffffff96a64ec0 R09: ffffaac581427ab0
> >> R10: 0000000000000001 R11: 000000002d2d2d2d R12: ffff9dc80667c268
> >> R13: ffff9dc801fd1000 R14: 0000000000000000 R15: ffffaac581427bca
> >> FS:  00007f8f0f32c000(0000) GS:ffff9dc83b400000(0000) knlGS:0000000000000000
> >> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> >> CR2: 0000557044ec6c86 CR3: 0000000062e92001 CR4: 00000000000606f0
> >> Call Trace:
> >>  tpm_tis_send_data+0x2b/0x230
> >>  tpm_tis_send_main+0x1e/0xe0
> >>  tpm_transmit+0xd8/0x3d0
> >>  tpm_transmit_cmd+0x25/0x90
> >>  tpm1_do_selftest+0x88/0x130
> >>  ? _cond_resched+0x16/0x40
> >>  tpm_tis_resume+0x4d/0x120
> >>  ? pnpacpi_resume+0x1b/0xa0
> >>  ? pnp_bus_suspend+0x10/0x10
> >>  pnp_bus_resume+0x63/0x90
> >>  dpm_run_callback+0x4c/0x120
> >>  device_resume+0xa7/0x200
> >>  dpm_resume+0xce/0x2c0
> >>  dpm_resume_end+0xd/0x20
> >>  suspend_devices_and_enter+0x195/0x750
> >>  pm_suspend.cold+0x329/0x374
> >>  state_store+0x71/0xd0
> >>  kernfs_fop_write_iter+0x124/0x1b0
> >>  new_sync_write+0x108/0x180
> >>  vfs_write+0x1bc/0x270
> >>  ksys_write+0x4f/0xc0
> >>  do_syscall_64+0x33/0x40
> >>  entry_SYSCALL_64_after_hwframe+0x44/0xa9
> >> RIP: 0033:0x7f8f102ec4e7
> >> Code: 0d 00 f7 d8 64 89 02 48 c7 c0 ff ff ff ff eb b7 0f 1f 00 f3 0f 1e fa 64
> >> 8b 04 25 18 00 00 00 85 c0 75 10 b8 01 00 00 00 0f 05 <48> 3d 00 f0 ff ff 77 51
> >> c3 48 83 ec 28 48 89 54 24 18 48 89 74 24
> >> RSP: 002b:00007ffe87216bf8 EFLAGS: 00000246 ORIG_RAX: 0000000000000001
> >> RAX: ffffffffffffffda RBX: 0000000000000004 RCX: 00007f8f102ec4e7
> >> RDX: 0000000000000004 RSI: 00007ffe87216ce0 RDI: 0000000000000004
> >> RBP: 00007ffe87216ce0 R08: 000055c485d835e0 R09: 00007f8f103830c0
> >> R10: 00007f8f10382fc0 R11: 0000000000000246 R12: 0000000000000004
> >> R13: 000055c485d7f650 R14: 0000000000000004 R15: 00007f8f103bf720
> >>
> >> Regards,
> >>
> >> Hans
> > 
> > I sent a couple fixes (cc'd to you).
> 
> I've seen the fixes, thank you.
> 
> I'll probably add these as downstream patches to the Fedora 5.12 kernels for now
> and see if that helps.
> 
> Regards,
> 
> Hans

They should soon mirror to 'linux-next'. I'm going to send an additional PR
at some point to Linus for v5.13, with these fixes included.

/Jarkko
