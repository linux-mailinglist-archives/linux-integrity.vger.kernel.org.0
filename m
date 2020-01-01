Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6E0F712E0EF
	for <lists+linux-integrity@lfdr.de>; Wed,  1 Jan 2020 23:55:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727428AbgAAWzr (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 1 Jan 2020 17:55:47 -0500
Received: from mail-ot1-f68.google.com ([209.85.210.68]:45950 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727426AbgAAWzq (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 1 Jan 2020 17:55:46 -0500
Received: by mail-ot1-f68.google.com with SMTP id 59so54696677otp.12
        for <linux-integrity@vger.kernel.org>; Wed, 01 Jan 2020 14:55:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
        bh=m4g1EM/uMp6lAFpxtQOB5KdZUvd0RzaZy5BdRaHYtGA=;
        b=JSHvqra0nthVS/WZxbIUDhbkerztX4y6s1EJjespY6G9TCweChl7HbJNm1e4fAlegf
         sdU7DDAz1G1mSxB2Zcq8Ud74p6a5nXJaC8n7VAkjEg9e1ppOfy4r44K/t5D020wTsOI2
         5kANlserTPCD/A6FRqOZpINlCVTxNOgd0MgPyzM0EUoFMFb2/bUIQ3hs/vBbphKhHVsu
         KGa3yJwGWPM/dQHcpRxuWZ9C2gBmT/6gpy3qAHkXW/JTMYzyb+X4KbMjIuthIP29USjX
         XTN0EbfsS2xSs8vB0OVXo9QP+86xYHA9airQntOhF4Ebz8Taq022dlgkXcA4J+UHsLH8
         wOIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=m4g1EM/uMp6lAFpxtQOB5KdZUvd0RzaZy5BdRaHYtGA=;
        b=O0QVUWA7iUQ1EAoIZbnFhHC/JwkufPhJveITljFmLfoEJrNtJG1w6Dw2VItFzIkNIZ
         UG7bTntkkkQ9Yw+G+v5uMtxtlZQMwVQwQq+wOy5C/bIqpdAZGU5rAUBgl+36zA50w0tn
         iSM7M1oLWguVT29FGkgbFx9UJrMPtbRQ5QHXGpyFleVVeQT8mmz2+GoNnGtNFwyQdWoJ
         iBiEfF7AjbPsOGzWKLkj0IfSpGiE4lFKhoL1wd7YdyZ30ujvKbcZlbSsITKx1gBH9lPA
         4l972gsIdReaV97Ot5hpSU7hP1iX6DAxBfQI/UOTUrjbCzrEHsNcqLQpP8UdCmQ1pPGC
         kPvg==
X-Gm-Message-State: APjAAAWVP+m/0uB3RXvaew6l5okMVKFpOqVOQ58agHxh6rgBtXldXpDP
        rzBXIUEfBrmTrwRCjmSfbBvgXDgRau4jBVtLGvdJgg==
X-Google-Smtp-Source: APXvYqyYggHHo/cuYKjfWS1CkiqpAHZXjkTpGGQGho5N7S1Q4W2SsnIRK0vsM33tBCqAX9hWIyBRV08CgneULQDz+5U=
X-Received: by 2002:a9d:6f11:: with SMTP id n17mr73904211otq.126.1577919345862;
 Wed, 01 Jan 2020 14:55:45 -0800 (PST)
MIME-Version: 1.0
References: <1577122577157232@kroah.com> <CAPcyv4jfpOX85GWgNTyugWksU=e-j=RhU_fcrcHBo4GMZ8_bhw@mail.gmail.com>
 <c6ce34b130210d2d1330fc4079d6d82bd74dcef1.camel@linux.intel.com>
 <50217a688ffa56cf5f150ffd358daba2a88cad48.camel@linux.intel.com>
 <20191228151526.GA6971@linux.intel.com> <CAPcyv4i_frm8jZeknniPexp8AAmGsaq0_DHegmL4XZHQi1ThxA@mail.gmail.com>
 <CAPcyv4iyQeXBWvp8V_UPBsOk29cfmTVZGYrrDgyYYqzsQvTjNA@mail.gmail.com> <20191231003000.ywdvfjdhqadnl6wo@cantor>
In-Reply-To: <20191231003000.ywdvfjdhqadnl6wo@cantor>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Wed, 1 Jan 2020 14:55:35 -0800
Message-ID: <CAPcyv4gs66ME_iLjew-fvvdX5mojdjpyZ5Zitvg738rXzOOxKQ@mail.gmail.com>
Subject: Re: Patch "tpm_tis: reserve chip for duration of tpm_tis_core_init"
 has been added to the 5.4-stable tree
To:     Jerry Snitselaar <jsnitsel@redhat.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        Greg KH <gregkh@linuxfoundation.org>,
        Christian Bundy <christianbundy@fraction.io>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Peter Huewe <peterhuewe@gmx.de>,
        Stefan Berger <stefanb@linux.vnet.ibm.com>,
        stable-commits@vger.kernel.org, linux-integrity@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Mon, Dec 30, 2019 at 4:30 PM Jerry Snitselaar <jsnitsel@redhat.com> wrote:
>
> On Sun Dec 29 19, Dan Williams wrote:
> >On Sat, Dec 28, 2019 at 9:17 AM Dan Williams <dan.j.williams@intel.com> wrote:
> >>
> >> On Sat, Dec 28, 2019 at 7:15 AM Jarkko Sakkinen
> >> <jarkko.sakkinen@linux.intel.com> wrote:
> >> >
> >> > On Fri, Dec 27, 2019 at 08:11:50AM +0200, Jarkko Sakkinen wrote:
> >> > > Dan, please also test the branch and tell if other patches are needed.
> >> > > I'm a bit blind with this as I don't have direct access to the faulting
> >> > > hardware. Thanks. [*]
> >> > >
> >> > > [*] https://lkml.org/lkml/2019/12/27/12
> >> >
> >> > Given that:
> >> >
> >> > 1. I cannot reproduce the bug locally.
> >> > 2. Neither of the patches have any appropriate tags (tested-by and
> >> >    reviewed-by). [*]
> >> >
> >> > I'm sorry but how am I expected to include these patches?
> >>
> >> Thanks for the branch, I'll get it tested on the failing hardware.
> >> Might be a few days due to holiday lag.
> >
> >This looked like the wrong revert to me, and testing confirms that
> >this does not fix the problem.
> >
> >As I mentioned in the original report [1] the commit that bisect flagged was:
> >
> >    5b359c7c4372 tpm_tis_core: Turn on the TPM before probing IRQ's
> >
> >That commit moved tpm_chip_start() before irq probing. Commit
> >21df4a8b6018 "tpm_tis: reserve chip for duration of tpm_tis_core_init"
> >does not appear to change anything in that regard.
> >
> >Perhaps this hardware has always had broken interrupts and needs to be
> >quirked off? I'm trying an experiment with tpm_tis_core.interrupts=0
> >workaround.
> >
>
> Hi Dan,
>
> Just to make sure I understand correctly are you saying you still have
> the screaming interrupt with the flag commit reverted,

Correct.

> or that it is
> polling instead of using interrupts [2]? Was that testing with both
> commits reverted, or just the flag commit?

With both patches reverted the driver falls back to polled mode, with
just the flag commit reverted the screaming interrupt issue is still
present.

> What kernel were you
> running before you saw the issue with 5.3 stable?

The regression was detected when moving to v5.3.6 which includes
commit 7f064c378e2c "tpm_tis_core: Turn on the TPM before probing
IRQ's".

> On that kernel you
> weren't seeing the polling message, and interrupts were working?

I've never seen interrupts working.

> Are
> you able to boot a 5.0 kernel on the system? It would be interesting
> to see how it was behaving before the power gating changes. I think it
> would be using polling due to how the code behaves because of that
> flag. It looks like without the flag being enabled by Stefan's commit
> TPM_GLOBAL_INT_ENABLE will never get cleared because tpm_tis_probe_irq_single
> expects tpm_tis_send to clear it if there is a problem, and without the
> flag being set that whole section of code is skipped.

I'll try to get a result from a pre-5.3.4 kernel to see what the
behavior is. I did have system owner run an experiment with
tpm_tis.interrupts=0 on the kernel command line and that also avoids
the problem.
