Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 751A53B7A40
	for <lists+linux-integrity@lfdr.de>; Wed, 30 Jun 2021 00:05:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235335AbhF2WHr (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 29 Jun 2021 18:07:47 -0400
Received: from mail.kernel.org ([198.145.29.99]:42650 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234953AbhF2WHq (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 29 Jun 2021 18:07:46 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 1C26D61DA0;
        Tue, 29 Jun 2021 22:05:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1625004318;
        bh=wL4QubpVslVkyqpPYOVGapr51ugDCN40mrI1cMYOd3s=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=mHZD86XEw5OblpWiif0Ap7A/Rozq76oL+oSo8bdhOjX1xlrdGZhDkIDrLnp9y0qtF
         VhOhnhxocUVjv1E4NAmyY4tY7v/iD+GO99jFNcEmhKQ7gfmTm+go9p56vBJHmVTmQF
         4Ah+0bebDFVY4HIgmLVrEbT5ZiyFsSNB4saAbTamM+91fc/NM//5qVQKVTCTSczcSa
         NeRJZUkNrj2AMKY4TrGvBM4uulEd6CLGFL8eBLWdjnzR8fDHxMe+kjs3S9rlJoI3aS
         m2cm+RR7t4ZJZPR+gWH51pagUajDvtesIYOertvk8Mf623uHNR4NKYDURXnUqaeEes
         kKkXcnQnfr6FQ==
Date:   Wed, 30 Jun 2021 01:05:16 +0300
From:   Jarkko Sakkinen <jarkko@kernel.org>
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     Jerry Snitselaar <jsnitsel@redhat.com>,
        Matthew Garrett <mjg59@google.com>,
        linux-integrity <linux-integrity@vger.kernel.org>,
        James Bottomley <James.Bottomley@hansenpartnership.com>
Subject: Re: Recent tpm_tis IRQ handling changes are causing kernel
 backtraces]
Message-ID: <20210629220516.xm3jvjy7v2uw3fvz@kernel.org>
References: <20210527140025.vl3ply6wnn7rsygg@kernel.org>
 <27d71b81-1e89-1b5d-ddaf-a8928bac90fd@redhat.com>
 <20210531043616.u3v25qzkkrik5apq@kernel.org>
 <89d5b891-97d8-caed-4eb1-6d4d485a2fd1@redhat.com>
 <5680899e-9040-7641-e6ac-23edd2d988cf@redhat.com>
 <49bfb4a7-eb3c-77f9-ff8e-b37617a26195@redhat.com>
 <20210623134054.45gjj2wbgz7jpjmy@kernel.org>
 <90ed51b4-66d4-fb10-ca8e-d99532028fab@redhat.com>
 <20210629180445.oind62rsktevm45q@kernel.org>
 <b4398c5b-38dc-d511-ea29-0847bfca60b4@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b4398c5b-38dc-d511-ea29-0847bfca60b4@redhat.com>
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Tue, Jun 29, 2021 at 09:14:39PM +0200, Hans de Goede wrote:
> Hi,
> 
> On 6/29/21 8:04 PM, Jarkko Sakkinen wrote:
> > On Wed, Jun 23, 2021 at 03:54:59PM +0200, Hans de Goede wrote:
> >> Hi,
> >>
> >> On 6/23/21 3:40 PM, Jarkko Sakkinen wrote:
> >>> On Mon, Jun 21, 2021 at 02:04:52PM +0200, Hans de Goede wrote:
> >>>> Hi,
> >>>>
> >>>> On 6/14/21 3:33 PM, Hans de Goede wrote:
> >>>>> Hi,
> >>>>>
> >>>>> On 6/1/21 6:04 PM, Hans de Goede wrote:
> >>>>>> Hi,
> >>>>>>
> >>>>>> On 5/31/21 6:36 AM, Jarkko Sakkinen wrote:
> >>>>>>>> Interestingly enough the first backtrace is also happening on a:
> >>>>>>>> "Dell Inc. XPS 13 9310/0MRT12, BIOS 2.2.0 04/06/2021"
> >>>>>>>>
> >>>>>>>> So it seems that at least with 5.12.6 (which has the last 2 fixes)
> >>>>>>>> all reports are about the XPS 13 9310. I wonder if there is an
> >>>>>>>> issue with the TPM interrupt line on the XPS 13 9310; I've asked the
> >>>>>>>> reporters to try adding tpm_tis.interrupts=0 to their kernel commandline.
> >>>>>>>
> >>>>>>> This is helpful for sure that these all are happening on matching hardware.
> >>>>>>
> >>>>>> So our kernel-backtrace tracking info (ABRT) just recorded a third backtrace
> >>>>>> with a kernel >= 5.12.6, again on the XPS 13 9310, so now we have 3 variants:
> >>>>>>
> >>>>>> 1. Backtrace starting with a call to ima_add_boot_aggregate
> >>>>>> https://bugzilla.redhat.com/show_bug.cgi?id=1963712
> >>>>>>
> >>>>>> 2. Backtrace starting with a call to tpm_dev_async_work:
> >>>>>> https://bugzilla.redhat.com/show_bug.cgi?id=1964974
> >>>>>> (note this one is not easily reproducible)
> >>>>>>
> >>>>>> 3. Backtrace starting with a call to rng_dev_read:
> >>>>>> https://bugzilla.redhat.com/show_bug.cgi?id=1920510
> >>>>>>
> >>>>>> 3. is the new one. All bugs linked above are public, all 3 backtraces
> >>>>>> so far have only been reported on the XPS 13 9310 (with kernel >= 5.12.6)
> >>>>>> and I've asked all the reporters to check if tpm_tis.interrupts=0 helps.
> >>>>>
> >>>>> Quick status update, I've got a response from a XPS 13 9310 user in:
> >>>>>
> >>>>> https://bugzilla.redhat.com/show_bug.cgi?id=1920510
> >>>>>
> >>>>> Indicating that a. he can reproduce this with the latest >= 5.12.6 kernels;
> >>>>> and b. it goes away when specifying tpm_tis.interrupts=0 as I expected
> >>>>> (I expected this because all the bug-reports started when the interrupt
> >>>>> code got fixed/re-enabled a while ago).
> >>>>
> >>>> One more status update.
> >>>>
> >>>> - A new 4th variant of the backtrace has been spotted, where the problem hits
> >>>> when called from probe() -> tpm2_auto_startup -> tpm2_do_selftest, see:
> >>>> https://bugzilla.redhat.com/show_bug.cgi?id=1958381
> >>>>
> >>>> - So far all reports with kernel >= 5.12.6 have been on a Dell XPS 13 9310
> >>>> models. But the new variant is happening on a Dell XPS 15 9500 and the
> >>>> backtrace starting at ima_add_boot_aggregate is also being reported on
> >>>> a Dell XPS 15 9500 (as well as on the XPS 13 9310).
> >>>>
> >>>> Regards,
> >>>>
> >>>> Hans
> >>>
> >>> OK, I'll have to query if I could borrow that laptop from someone. It's
> >>> fairly common laptop, i.e. might be possible.
> >>
> >> In the mean time I've also got a report that this variant of the backtrace:
> >>
> >> 1. Backtrace starting with a call to ima_add_boot_aggregate
> >> https://bugzilla.redhat.com/show_bug.cgi?id=1963712
> >>
> >> Is also still happening with recent 5.12.y kernels on
> >> Dell Precision 7750 laptops. Both the Precision 7750 and the XPS 9500 use
> >> 10th gen comet lake processors (i7-10750H), where as the XPS 9310 is using
> >> an icelake processor. So the common denominator seems to be that they are
> >> all 2020 Dell laptop models using the latest Intel CPUs.
> >>
> >> FYI the complete list of models on which some of the 4 backtrace variants
> >> are still seen on recent 5.12.y kernels is now:
> >>
> >> Dell XPS 13 9310
> >> Dell XPS 15 9500
> >> Dell Precision 7750
> >>
> >> Regards,
> >>
> >> Hans
> > 
> > Does "tpm_tis.interrupts=0" uniformly workaround the issue?
> 
> I unfortunately have not gotten much replies to my request to test with
> tpm_tis.interrupts=0, but for those people who have bothered to test
> (2 reporters IIRC) using tpm_tis.interrupts=0 does avoid the issue.

So we see this in dmesg as first anything from TPM:

[    0.904572] tpm_tis STM0125:00: 2.0 TPM (device-id 0x0, rev-id 78)

This means that one command is successfully processed by the TPM, i.e.
tpm2_probe() in tpm_tis_core_init().

My first *guess*  was that IRQ is given by ACPI, would need ACPI dump to
confirm (e.g. sudo acpidump > acpi.dump). It cannot be so because otherwise
this code path would be executed:

        if (!(chip->flags & TPM_CHIP_FLAG_IRQ)) {
                dev_err(&chip->dev, FW_BUG
                        "TPM interrupt not working, polling instead\n");

                disable_interrupts(chip);
        }

TPM_CHIP_FLAG_IRQ is never set, so you should see this message in dmesg if
a legit value is given to IRQ by ACPI.  We are probably planning re-enable
IRQ code after these type of issues are fully resolved, but right now you
should not end up having it enabled (see tpm_tis_send() function).

To put this together "if (irq != -1) {" path in tpm_tis_core_init() is
never executed. And early in the same function the interrupt hardware is
*explicitly* disabled.

For me this looks like a hardware bug right now: interrupts stay enabled
for some reason.

ACPI dump would be useful to verify some of the assumptions in this.

/Jarkko
