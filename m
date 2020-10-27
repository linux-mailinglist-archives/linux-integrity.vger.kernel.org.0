Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0F1CB29C059
	for <lists+linux-integrity@lfdr.de>; Tue, 27 Oct 2020 18:14:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1784029AbgJ0ROT (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 27 Oct 2020 13:14:19 -0400
Received: from mail.kernel.org ([198.145.29.99]:42804 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1815474AbgJ0ROM (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 27 Oct 2020 13:14:12 -0400
Received: from kernel.org (83-245-197-237.elisa-laajakaista.fi [83.245.197.237])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3EE5320809;
        Tue, 27 Oct 2020 17:14:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1603818851;
        bh=/8XUq3Zh0so0TxFZFLww8BwCIQaXorIOMMLi2gaSgP0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=1QkZL1KhFKXUR6JPtcw+tGDyzjeOiW3wHprGS1pgKx+vYIPtxecnFNMibpI81DLXl
         /Vs4EL4G+VGPaCKlHS1Q45tT9B1H5zjodGPRDixQ8PDjp/t0/swdOAM1ezYly/6uHn
         W6v0BT7cbJEkuXLOvAPkq5kBsYnGW0X9LSS5KeQc=
Date:   Tue, 27 Oct 2020 19:14:06 +0200
From:   Jarkko Sakkinen <jarkko@kernel.org>
To:     Jerry Snitselaar <jsnitsel@redhat.com>
Cc:     James Bottomley <James.Bottomley@hansenpartnership.com>,
        linux-integrity@vger.kernel.org, Jason Gunthorpe <jgg@ziepe.ca>,
        Peter Huewe <peterhuewe@gmx.de>,
        Borislav Petkov <bp@alien8.de>,
        Nayna Jain <nayna@linux.ibm.com>
Subject: Re: [PATCH v2 0/5] tpm_tis: fix interrupts (again)
Message-ID: <20201027171406.GA6292@kernel.org>
References: <20201001180925.13808-1-James.Bottomley@HansenPartnership.com>
 <20201013011745.GA41176@linux.intel.com>
 <87tuuyf97r.fsf@jsnitsel.users.ipa.redhat.com>
 <20201018210539.GA575510@kapsi.fi>
 <87y2k0v6h9.fsf@redhat.com>
 <20201024122007.GD32960@kernel.org>
 <87o8kox2lh.fsf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87o8kox2lh.fsf@redhat.com>
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Mon, Oct 26, 2020 at 11:29:46AM -0700, Jerry Snitselaar wrote:
> 
> Jarkko Sakkinen @ 2020-10-24 05:20 MST:
> 
> > On Tue, Oct 20, 2020 at 04:10:42PM -0700, Jerry Snitselaar wrote:
> >> 
> >> Jarkko Sakkinen @ 2020-10-18 14:05 MST:
> >> 
> >> > On Tue, Oct 13, 2020 at 08:15:36AM -0700, Jerry Snitselaar wrote:
> >> >> 
> >> >> Jarkko Sakkinen @ 2020-10-12 18:17 MST:
> >> >> 
> >> >> > On Thu, Oct 01, 2020 at 11:09:20AM -0700, James Bottomley wrote:
> >> >> >> The current state of the TIS TPM is that interrupts have been globally
> >> >> >> disabled by various changes.  The problems we got reported the last
> >> >> >> time they were enabled was interrupt storms.  With my own TIS TPM,
> >> >> >> I've found that this is caused because my TPM doesn't do legacy
> >> >> >> cycles, The TIS spec (chapter 6.1 "Locality Usage Per Register")
> >> >> >> requires any TIS TPM without legacy cycles not to act on any write to
> >> >> >> an interrupt register unless the locality is enabled.  This means if
> >> >> >> an interrupt fires after we relinquish the locality, the TPM_EOI in
> >> >> >> the interrupt routine is ineffective meaning the same interrupt
> >> >> >> triggers over and over again.  This problem also means we can have
> >> >> >> trouble setting up interrupts on TIS TPMs because the current init
> >> >> >> code does the setup before the locality is claimed for the first time.
> >> >> >> 
> >> >> >> James
> >> >> >
> >> >> > You should consider expanding the audience. Jerry, once you have some
> >> >> > bandwidth (no rush, does not land before rc2), it would be great that if
> >> >> > you could try this. I'm emphasizing this just because of the
> >> >> > intersection. I think it would also make senset to get tested-by from
> >> >> > Nayna.
> >> >> 
> >> >> I will run some tests on some other systems I have access to. As noted
> >> >> in the other email I did a quick test with a t490s with an older bios
> >> >> that exhibits the problem originally reported when Stefan's patch
> >> >> enabled interrupts.
> >> >
> >> > Thank you. As said, I can make a pull request to rc2 or even rc3, if
> >> > needed.
> >> >
> >> > /Jarkko
> >> 
> >> So outside of the t490s I have access to, it looks like the nuc5 with
> >> tpm2.0 device, and and older lenovo D30 with a tpm1.2 device both are
> >> not using interrupts. I'm digging around to see if I can find some
> >> other systems that I can test interrupts on.
> >> 
> >> Regards,
> >> Jerry
> >
> > I'm going to test with this C720P chromebook, which has a long standing
> > bug in the kernel bugzilla. I got it a while ago but it's stuck in the
> > boot.
> >
> > If that doesn't boot, I'll pick up old Ivylake NUC from the office,
> > which has TPM 1.2 and bit newer TPM 2.0 NUC. Should anyway pick them,
> > have not used them for testing for a while because of pandemia.
> >
> > /Jarkko
> 
> My search continues through the systems in our labs. Running into the
> same issue with the Dells. Looking at the TCPA table it looks like
> they aren't set up for interrupts as well. I have some tpm2.0 systems
> to still try.

The chromebook that I have feels like bricked, at least for the window
for testing this bug. I'll pick up the nucs tomorrow.

> Jerry

/Jarkko
