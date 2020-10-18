Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BB5DB292011
	for <lists+linux-integrity@lfdr.de>; Sun, 18 Oct 2020 23:05:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727726AbgJRVFn (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Sun, 18 Oct 2020 17:05:43 -0400
Received: from mail.kernel.org ([198.145.29.99]:43052 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726977AbgJRVFm (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Sun, 18 Oct 2020 17:05:42 -0400
Received: from localhost (83-245-197-237.elisa-laajakaista.fi [83.245.197.237])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AA88F22245;
        Sun, 18 Oct 2020 21:05:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1603055142;
        bh=BRpAzeVmAiwonfBXoWJUAJa6cC+Wi6yHfH8JcBIvdYA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ofIXRkASRkohjfDIw4fHAB+xgigywccjoZAAGEVEkC148C76ho+ZLcSXCqDwIFyUa
         yx8wtB/NU2z99hYiZMLp5zLvR5169R43LYsk5xXgKbFobPAIvfg9nrgOuGZHl7x7au
         BiZoQZz47jhPPslo6rbR1WI11hhHrZ6DEsek0t38=
Date:   Mon, 19 Oct 2020 00:05:39 +0300
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
Message-ID: <20201018210539.GA575510@kapsi.fi>
References: <20201001180925.13808-1-James.Bottomley@HansenPartnership.com>
 <20201013011745.GA41176@linux.intel.com>
 <87tuuyf97r.fsf@jsnitsel.users.ipa.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87tuuyf97r.fsf@jsnitsel.users.ipa.redhat.com>
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Tue, Oct 13, 2020 at 08:15:36AM -0700, Jerry Snitselaar wrote:
> 
> Jarkko Sakkinen @ 2020-10-12 18:17 MST:
> 
> > On Thu, Oct 01, 2020 at 11:09:20AM -0700, James Bottomley wrote:
> >> The current state of the TIS TPM is that interrupts have been globally
> >> disabled by various changes.  The problems we got reported the last
> >> time they were enabled was interrupt storms.  With my own TIS TPM,
> >> I've found that this is caused because my TPM doesn't do legacy
> >> cycles, The TIS spec (chapter 6.1 "Locality Usage Per Register")
> >> requires any TIS TPM without legacy cycles not to act on any write to
> >> an interrupt register unless the locality is enabled.  This means if
> >> an interrupt fires after we relinquish the locality, the TPM_EOI in
> >> the interrupt routine is ineffective meaning the same interrupt
> >> triggers over and over again.  This problem also means we can have
> >> trouble setting up interrupts on TIS TPMs because the current init
> >> code does the setup before the locality is claimed for the first time.
> >> 
> >> James
> >
> > You should consider expanding the audience. Jerry, once you have some
> > bandwidth (no rush, does not land before rc2), it would be great that if
> > you could try this. I'm emphasizing this just because of the
> > intersection. I think it would also make senset to get tested-by from
> > Nayna.
> 
> I will run some tests on some other systems I have access to. As noted
> in the other email I did a quick test with a t490s with an older bios
> that exhibits the problem originally reported when Stefan's patch
> enabled interrupts.

Thank you. As said, I can make a pull request to rc2 or even rc3, if
needed.

/Jarkko
