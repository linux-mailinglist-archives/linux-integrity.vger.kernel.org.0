Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 571D1297C4C
	for <lists+linux-integrity@lfdr.de>; Sat, 24 Oct 2020 14:20:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1761363AbgJXMUK (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Sat, 24 Oct 2020 08:20:10 -0400
Received: from mail.kernel.org ([198.145.29.99]:59858 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1761252AbgJXMUK (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Sat, 24 Oct 2020 08:20:10 -0400
Received: from localhost (83-245-197-237.elisa-laajakaista.fi [83.245.197.237])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 11C4C20725;
        Sat, 24 Oct 2020 12:20:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1603542009;
        bh=R+PTaQxkUD552VPcKHn7XRypzkQms1wfyevgaYGV2xg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=nvT/T3c2dJf33cvAPTqI8hAz2BA2jifQXJlRmZFsTA0EoXzoLT/bKF99D/hFKktlI
         JdhBnNX8oSbSMPEiGIHxiBN/+zRUcNBZS/bLW0aPK6KUXhcrps9k9w0lvg/DjbREBV
         Z0Q6ryT5JptbiabD7r7wiJMbADjo8qtWiG7OQ/Vw=
Date:   Sat, 24 Oct 2020 15:20:07 +0300
From:   Jarkko Sakkinen <jarkko@kernel.org>
To:     Jerry Snitselaar <jsnitsel@redhat.com>
Cc:     equired@linux.intel.com,
        justmentioningitbecauseIthinkthatwouldbeagood@linux.intel.com,
        James Bottomley <James.Bottomley@HansenPartnership.com>,
        linux-integrity@vger.kernel.org, Jason Gunthorpe <jgg@ziepe.ca>,
        Peter Huewe <peterhuewe@gmx.de>,
        Borislav Petkov <bp@alien8.de>,
        Nayna Jain <nayna@linux.ibm.com>
Subject: Re: [PATCH v2 0/5] tpm_tis: fix interrupts (again)
Message-ID: <20201024122007.GD32960@kernel.org>
References: <20201001180925.13808-1-James.Bottomley@HansenPartnership.com>
 <20201013011745.GA41176@linux.intel.com>
 <87tuuyf97r.fsf@jsnitsel.users.ipa.redhat.com>
 <20201018210539.GA575510@kapsi.fi>
 <87y2k0v6h9.fsf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87y2k0v6h9.fsf@redhat.com>
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Tue, Oct 20, 2020 at 04:10:42PM -0700, Jerry Snitselaar wrote:
> 
> Jarkko Sakkinen @ 2020-10-18 14:05 MST:
> 
> > On Tue, Oct 13, 2020 at 08:15:36AM -0700, Jerry Snitselaar wrote:
> >> 
> >> Jarkko Sakkinen @ 2020-10-12 18:17 MST:
> >> 
> >> > On Thu, Oct 01, 2020 at 11:09:20AM -0700, James Bottomley wrote:
> >> >> The current state of the TIS TPM is that interrupts have been globally
> >> >> disabled by various changes.  The problems we got reported the last
> >> >> time they were enabled was interrupt storms.  With my own TIS TPM,
> >> >> I've found that this is caused because my TPM doesn't do legacy
> >> >> cycles, The TIS spec (chapter 6.1 "Locality Usage Per Register")
> >> >> requires any TIS TPM without legacy cycles not to act on any write to
> >> >> an interrupt register unless the locality is enabled.  This means if
> >> >> an interrupt fires after we relinquish the locality, the TPM_EOI in
> >> >> the interrupt routine is ineffective meaning the same interrupt
> >> >> triggers over and over again.  This problem also means we can have
> >> >> trouble setting up interrupts on TIS TPMs because the current init
> >> >> code does the setup before the locality is claimed for the first time.
> >> >> 
> >> >> James
> >> >
> >> > You should consider expanding the audience. Jerry, once you have some
> >> > bandwidth (no rush, does not land before rc2), it would be great that if
> >> > you could try this. I'm emphasizing this just because of the
> >> > intersection. I think it would also make senset to get tested-by from
> >> > Nayna.
> >> 
> >> I will run some tests on some other systems I have access to. As noted
> >> in the other email I did a quick test with a t490s with an older bios
> >> that exhibits the problem originally reported when Stefan's patch
> >> enabled interrupts.
> >
> > Thank you. As said, I can make a pull request to rc2 or even rc3, if
> > needed.
> >
> > /Jarkko
> 
> So outside of the t490s I have access to, it looks like the nuc5 with
> tpm2.0 device, and and older lenovo D30 with a tpm1.2 device both are
> not using interrupts. I'm digging around to see if I can find some
> other systems that I can test interrupts on.
> 
> Regards,
> Jerry

I'm going to test with this C720P chromebook, which has a long standing
bug in the kernel bugzilla. I got it a while ago but it's stuck in the
boot.

If that doesn't boot, I'll pick up old Ivylake NUC from the office,
which has TPM 1.2 and bit newer TPM 2.0 NUC. Should anyway pick them,
have not used them for testing for a while because of pandemia.

/Jarkko
