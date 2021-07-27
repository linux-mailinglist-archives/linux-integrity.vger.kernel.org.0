Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0A24D3D6C14
	for <lists+linux-integrity@lfdr.de>; Tue, 27 Jul 2021 04:51:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234410AbhG0CKb (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 26 Jul 2021 22:10:31 -0400
Received: from mail.kernel.org ([198.145.29.99]:40118 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233727AbhG0CKa (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 26 Jul 2021 22:10:30 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 74DB060F37;
        Tue, 27 Jul 2021 02:50:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1627354258;
        bh=e/5suBuh0kynCbKoUdPgHhl4uUReI115X0ZIMZyGY1E=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=m13se6LjTs8MzEQVGj5/P4rsb3ffz3gJAD6FPH9usFdSB7mSYvqOldEiXlLZmAWFA
         WSHn89lqA+euwJUdI3+2hiJLuctbAa4nG9qW1LUcaVlg2XIJkkjv6iA+DrK5yPek9A
         evKempTPYCEQA1ETS4sMUrSxxY3TNwGxPzlUyi63vhmhO7jdmyaUrfPXdkmkiDLQ2T
         KJyuasNRElN/CM72Tyw7/4ThStR9QofUf6oCJdWfxLLtjHE4y1FTy57RMvO3wmjAuC
         86/dh+sy1U2XjUcdfyHzOgderhqMpPFsufJIX2HZ3xuYGJmS7xcNJ4n4vqL8R6Ig9O
         qmLW9ZXEutjDw==
Date:   Tue, 27 Jul 2021 05:50:55 +0300
From:   Jarkko Sakkinen <jarkko@kernel.org>
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     Jerry Snitselaar <jsnitsel@redhat.com>,
        Matthew Garrett <mjg59@google.com>,
        linux-integrity <linux-integrity@vger.kernel.org>,
        James Bottomley <James.Bottomley@hansenpartnership.com>
Subject: Re: Recent tpm_tis IRQ handling changes are causing kernel
 backtraces]
Message-ID: <20210727025055.uftpemuemmes2zed@kernel.org>
References: <49bfb4a7-eb3c-77f9-ff8e-b37617a26195@redhat.com>
 <20210623134054.45gjj2wbgz7jpjmy@kernel.org>
 <90ed51b4-66d4-fb10-ca8e-d99532028fab@redhat.com>
 <20210629180445.oind62rsktevm45q@kernel.org>
 <b4398c5b-38dc-d511-ea29-0847bfca60b4@redhat.com>
 <20210629220516.xm3jvjy7v2uw3fvz@kernel.org>
 <29e72255-b995-9ffe-f379-5e9e349bee07@redhat.com>
 <8819200d-e468-7b09-2e08-e44f5f2ed59f@redhat.com>
 <20210709184426.7yftmufrmw3tp24s@kernel.org>
 <fa61681f-b07f-9d31-b193-9d42cd23167a@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <fa61681f-b07f-9d31-b193-9d42cd23167a@redhat.com>
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Sat, Jul 17, 2021 at 06:10:04PM +0200, Hans de Goede wrote:
> Hi,
> 
> On 7/9/21 8:44 PM, Jarkko Sakkinen wrote:
> > On Wed, Jun 30, 2021 at 03:36:55PM +0200, Hans de Goede wrote:
> >> Hi,
> >>
> >> On 6/30/21 2:47 PM, Hans de Goede wrote:
> >>> Hi,
> >>>
> >>> On 6/30/21 12:05 AM, Jarkko Sakkinen wrote:
> >>>> On Tue, Jun 29, 2021 at 09:14:39PM +0200, Hans de Goede wrote:
> >>>>> Hi,
> >>>>>
> >>>>> On 6/29/21 8:04 PM, Jarkko Sakkinen wrote:
> >>>>>> On Wed, Jun 23, 2021 at 03:54:59PM +0200, Hans de Goede wrote:
> >>>>>>> Hi,
> >>>>>>>
> >>>>>>> On 6/23/21 3:40 PM, Jarkko Sakkinen wrote:
> >>>>>>>> On Mon, Jun 21, 2021 at 02:04:52PM +0200, Hans de Goede wrote:
> >>>>>>>>> Hi,
> >>>>>>>>>
> >>>>>>>>> On 6/14/21 3:33 PM, Hans de Goede wrote:
> >>>>>>>>>> Hi,
> >>>>>>>>>>
> >>>>>>>>>> On 6/1/21 6:04 PM, Hans de Goede wrote:
> >>>>>>>>>>> Hi,
> >>>>>>>>>>>
> >>>>>>>>>>> On 5/31/21 6:36 AM, Jarkko Sakkinen wrote:
> >>>>>>>>>>>>> Interestingly enough the first backtrace is also happening on a:
> >>>>>>>>>>>>> "Dell Inc. XPS 13 9310/0MRT12, BIOS 2.2.0 04/06/2021"
> >>>>>>>>>>>>>
> >>>>>>>>>>>>> So it seems that at least with 5.12.6 (which has the last 2 fixes)
> >>>>>>>>>>>>> all reports are about the XPS 13 9310. I wonder if there is an
> >>>>>>>>>>>>> issue with the TPM interrupt line on the XPS 13 9310; I've asked the
> >>>>>>>>>>>>> reporters to try adding tpm_tis.interrupts=0 to their kernel commandline.
> >>>>>>>>>>>>
> >>>>>>>>>>>> This is helpful for sure that these all are happening on matching hardware.
> >>>>>>>>>>>
> >>>>>>>>>>> So our kernel-backtrace tracking info (ABRT) just recorded a third backtrace
> >>>>>>>>>>> with a kernel >= 5.12.6, again on the XPS 13 9310, so now we have 3 variants:
> >>>>>>>>>>>
> >>>>>>>>>>> 1. Backtrace starting with a call to ima_add_boot_aggregate
> >>>>>>>>>>> https://bugzilla.redhat.com/show_bug.cgi?id=1963712
> >>>>>>>>>>>
> >>>>>>>>>>> 2. Backtrace starting with a call to tpm_dev_async_work:
> >>>>>>>>>>> https://bugzilla.redhat.com/show_bug.cgi?id=1964974
> >>>>>>>>>>> (note this one is not easily reproducible)
> >>>>>>>>>>>
> >>>>>>>>>>> 3. Backtrace starting with a call to rng_dev_read:
> >>>>>>>>>>> https://bugzilla.redhat.com/show_bug.cgi?id=1920510
> >>>>>>>>>>>
> >>>>>>>>>>> 3. is the new one. All bugs linked above are public, all 3 backtraces
> >>>>>>>>>>> so far have only been reported on the XPS 13 9310 (with kernel >= 5.12.6)
> >>>>>>>>>>> and I've asked all the reporters to check if tpm_tis.interrupts=0 helps.
> >>>>>>>>>>
> >>>>>>>>>> Quick status update, I've got a response from a XPS 13 9310 user in:
> >>>>>>>>>>
> >>>>>>>>>> https://bugzilla.redhat.com/show_bug.cgi?id=1920510
> >>>>>>>>>>
> >>>>>>>>>> Indicating that a. he can reproduce this with the latest >= 5.12.6 kernels;
> >>>>>>>>>> and b. it goes away when specifying tpm_tis.interrupts=0 as I expected
> >>>>>>>>>> (I expected this because all the bug-reports started when the interrupt
> >>>>>>>>>> code got fixed/re-enabled a while ago).
> >>>>>>>>>
> >>>>>>>>> One more status update.
> >>>>>>>>>
> >>>>>>>>> - A new 4th variant of the backtrace has been spotted, where the problem hits
> >>>>>>>>> when called from probe() -> tpm2_auto_startup -> tpm2_do_selftest, see:
> >>>>>>>>> https://bugzilla.redhat.com/show_bug.cgi?id=1958381
> >>>>>>>>>
> >>>>>>>>> - So far all reports with kernel >= 5.12.6 have been on a Dell XPS 13 9310
> >>>>>>>>> models. But the new variant is happening on a Dell XPS 15 9500 and the
> >>>>>>>>> backtrace starting at ima_add_boot_aggregate is also being reported on
> >>>>>>>>> a Dell XPS 15 9500 (as well as on the XPS 13 9310).
> >>>>>>>>>
> >>>>>>>>> Regards,
> >>>>>>>>>
> >>>>>>>>> Hans
> >>>>>>>>
> >>>>>>>> OK, I'll have to query if I could borrow that laptop from someone. It's
> >>>>>>>> fairly common laptop, i.e. might be possible.
> >>>>>>>
> >>>>>>> In the mean time I've also got a report that this variant of the backtrace:
> >>>>>>>
> >>>>>>> 1. Backtrace starting with a call to ima_add_boot_aggregate
> >>>>>>> https://bugzilla.redhat.com/show_bug.cgi?id=1963712
> >>>>>>>
> >>>>>>> Is also still happening with recent 5.12.y kernels on
> >>>>>>> Dell Precision 7750 laptops. Both the Precision 7750 and the XPS 9500 use
> >>>>>>> 10th gen comet lake processors (i7-10750H), where as the XPS 9310 is using
> >>>>>>> an icelake processor. So the common denominator seems to be that they are
> >>>>>>> all 2020 Dell laptop models using the latest Intel CPUs.
> >>>>>>>
> >>>>>>> FYI the complete list of models on which some of the 4 backtrace variants
> >>>>>>> are still seen on recent 5.12.y kernels is now:
> >>>>>>>
> >>>>>>> Dell XPS 13 9310
> >>>>>>> Dell XPS 15 9500
> >>>>>>> Dell Precision 7750
> >>>>>>>
> >>>>>>> Regards,
> >>>>>>>
> >>>>>>> Hans
> >>>>>>
> >>>>>> Does "tpm_tis.interrupts=0" uniformly workaround the issue?
> >>>>>
> >>>>> I unfortunately have not gotten much replies to my request to test with
> >>>>> tpm_tis.interrupts=0, but for those people who have bothered to test
> >>>>> (2 reporters IIRC) using tpm_tis.interrupts=0 does avoid the issue.
> >>>>
> >>>> So we see this in dmesg as first anything from TPM:
> >>>>
> >>>> [    0.904572] tpm_tis STM0125:00: 2.0 TPM (device-id 0x0, rev-id 78)
> >>>>
> >>>> This means that one command is successfully processed by the TPM, i.e.
> >>>> tpm2_probe() in tpm_tis_core_init().
> >>>>
> >>>> My first *guess*  was that IRQ is given by ACPI, would need ACPI dump to
> >>>> confirm (e.g. sudo acpidump > acpi.dump). It cannot be so because otherwise
> >>>> this code path would be executed:
> >>>>
> >>>>         if (!(chip->flags & TPM_CHIP_FLAG_IRQ)) {
> >>>>                 dev_err(&chip->dev, FW_BUG
> >>>>                         "TPM interrupt not working, polling instead\n");
> >>>>
> >>>>                 disable_interrupts(chip);
> >>>>         }
> >>>>
> >>>> TPM_CHIP_FLAG_IRQ is never set, so you should see this message in dmesg if
> >>>> a legit value is given to IRQ by ACPI.  We are probably planning re-enable
> >>>> IRQ code after these type of issues are fully resolved, but right now you
> >>>> should not end up having it enabled (see tpm_tis_send() function).
> >>>>
> >>>> To put this together "if (irq != -1) {" path in tpm_tis_core_init() is
> >>>> never executed. And early in the same function the interrupt hardware is
> >>>> *explicitly* disabled.
> >>>>
> >>>> For me this looks like a hardware bug right now: interrupts stay enabled
> >>>> for some reason.
> >>>>
> >>>> ACPI dump would be useful to verify some of the assumptions in this.
> >>>
> >>> Ok, I've added a comment to the Fedora bugs for the 4 different backtrace
> >>> variants asking for acpidumps for the Dell XPS 13 9310, Dell XPS 15 9500
> >>> and Dell Precision 7750 laptops.
> >>
> >> 2 XPS 9310 acpidumps have been attached to:
> >>
> >> https://bugzilla.redhat.com/show_bug.cgi?id=1920510
> >> https://bugzilla.redhat.com/show_bug.cgi?id=1964974
> >>
> >> Note the reporter of the first bug mentions that he is no longer having
> >> this issue, but we are definitely still getting reports for kernel version
> >>> 5.12.6 (which has the last 2 fixes) from XPS 9310 users...
> >>
> >> Maybe there are different BIOS versions in play ? It might be interesting
> >> to compare the 2 acpidumps...
> > 
> > ❯ diff -u ../tmp/ssdt7.dsl ../tmp2/ssdt7.dsl
> > --- ../tmp/ssdt7.dsl	2021-07-09 21:32:06.473166420 +0300
> > +++ ../tmp2/ssdt7.dsl	2021-07-09 21:33:45.065934469 +0300
> > @@ -5,7 +5,7 @@
> >   * 
> >   * Disassembling to symbolic ASL+ operators
> >   *
> > - * Disassembly of ssdt7.dat, Fri Jul  9 21:32:06 2021
> > + * Disassembly of ssdt7.dat, Fri Jul  9 21:33:45 2021
> >   *
> >   * Original Table Header:
> >   *     Signature        "SSDT"
> > @@ -121,7 +121,7 @@
> >                      0xFED40000,         // Address Base
> >                      0x00005000,         // Address Length
> >                      )
> > -                Interrupt (ResourceConsumer, Level, ActiveLow, Shared, ,, _Y58)
> > +                Interrupt (ResourceConsumer, Level, ActiveLow, Shared, ,, _Y55)
> >                  {
> >                      0x0000000C,
> >                  }
> > @@ -141,7 +141,7 @@
> >                  }
> >                  Else
> >                  {
> > -                    CreateDWordField (RES0, \_SB.TPM._Y58._INT, LIRQ)  // _INT: Interrupts
> > +                    CreateDWordField (RES0, \_SB.TPM._Y55._INT, LIRQ)  // _INT: Interrupts
> >                      LIRQ = IRQN /* \_SB_.TPM_.IRQN */
> >                      Return (RES0) /* \_SB_.TPM_.RES0 */
> >                  }
> > @@ -152,14 +152,14 @@
> >                  If ((IRQN != Zero))
> >                  {
> >                      CreateDWordField (Arg0, 0x11, IRQ0)
> > -                    CreateDWordField (RES0, \_SB.TPM._Y58._INT, LIRQ)  // _INT: Interrupts
> > +                    CreateDWordField (RES0, \_SB.TPM._Y55._INT, LIRQ)  // _INT: Interrupts
> >                      LIRQ = IRQ0 /* \_SB_.TPM_._SRS.IRQ0 */
> >                      IRQN = IRQ0 /* \_SB_.TPM_._SRS.IRQ0 */
> >                      CreateBitField (Arg0, 0x79, ITRG)
> > -                    CreateBitField (RES0, \_SB.TPM._Y58._HE, LTRG)  // _HE_: High-Edge
> > +                    CreateBitField (RES0, \_SB.TPM._Y55._HE, LTRG)  // _HE_: High-Edge
> >                      LTRG = ITRG /* \_SB_.TPM_._SRS.ITRG */
> >                      CreateBitField (Arg0, 0x7A, ILVL)
> > -                    CreateBitField (RES0, \_SB.TPM._Y58._LL, LLVL)  // _LL_: Low Level
> > +                    CreateBitField (RES0, \_SB.TPM._Y55._LL, LLVL)  // _LL_: Low Level
> >                      LLVL = ILVL /* \_SB_.TPM_._SRS.ILVL */
> >                      If ((((TID0 & 0x0F) == Zero) || ((TID0 & 0x0F
> >                          ) == 0x0F)))
> > 
> > This delta from "acpidump for Dell XPS 9310 (with Qualcomm QCA6390)" to
> > "acpidump output from a Dell XPS 13 9310 that no longer has a problem"
> > in SSDT7. The bug I'm referring to is
> > 
> > https://bugzilla.redhat.com/show_bug.cgi?id=1920510
> > 
> > Looks to me just using a different label.
> 
> Yes, although I have the feeling that does indicate that their are possibly
> other changes under the hood. The 0x00000000c interrupt referred to seems to
> be an interrupt directly on the APIC, which means that it is a GPIO in direct-irq
> mode with level vs edge interrupt mode selection (pullup/down settings is all
> directly done by the BIOS.
> 
> I'm aware that misconfiguring those settings (which Linux cannot see) was
> an issue with the TPM IRQ on some Lenovo models, maybe the same is going on
> here; and later BIOS versions contain a fix (and this somehow also has
> changed the label in the DSDT ?).
> 
> > What if we just set "interrupts=0" explicitly for STM0125 HID since the
> > workaround seems to work according to the report?
> 
> That sounds like a reasonable workaround.

I just came from two week leave.

I'll create a patch that adds such workaround when I'm done with
purging all the email

/Jarkko
