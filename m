Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E41D228D12C
	for <lists+linux-integrity@lfdr.de>; Tue, 13 Oct 2020 17:24:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726730AbgJMPYU (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 13 Oct 2020 11:24:20 -0400
Received: from bedivere.hansenpartnership.com ([96.44.175.130]:52846 "EHLO
        bedivere.hansenpartnership.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726657AbgJMPYU (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 13 Oct 2020 11:24:20 -0400
Received: from localhost (localhost [127.0.0.1])
        by bedivere.hansenpartnership.com (Postfix) with ESMTP id 9A1B91280272;
        Tue, 13 Oct 2020 08:24:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=hansenpartnership.com;
        s=20151216; t=1602602659;
        bh=Cd1YhT96M8VV5VN2ax0tr/6gEumQ2k794R5vK929ags=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=D4XSs4TJCb1qtGB2lBYJRw5E03ETCQon7OyGyqzCG3RdoZ81CgCRfxdK5Ti70UaNO
         htiMVmrS7m6zaYW+IG2wjXh/5OPeF0STUHNs6S4Z7lNcmsSJCPNsqQvqN1aFuplLMS
         h/WrmYVu50JMCTYS7LYkPd9dkzPICdR216syN7zU=
Received: from bedivere.hansenpartnership.com ([127.0.0.1])
        by localhost (bedivere.hansenpartnership.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id LkSvGhDhKzjB; Tue, 13 Oct 2020 08:24:19 -0700 (PDT)
Received: from jarvis.int.hansenpartnership.com (c-73-35-198-56.hsd1.wa.comcast.net [73.35.198.56])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by bedivere.hansenpartnership.com (Postfix) with ESMTPSA id 1CDF91280271;
        Tue, 13 Oct 2020 08:24:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=hansenpartnership.com;
        s=20151216; t=1602602659;
        bh=Cd1YhT96M8VV5VN2ax0tr/6gEumQ2k794R5vK929ags=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=D4XSs4TJCb1qtGB2lBYJRw5E03ETCQon7OyGyqzCG3RdoZ81CgCRfxdK5Ti70UaNO
         htiMVmrS7m6zaYW+IG2wjXh/5OPeF0STUHNs6S4Z7lNcmsSJCPNsqQvqN1aFuplLMS
         h/WrmYVu50JMCTYS7LYkPd9dkzPICdR216syN7zU=
Message-ID: <e6930fa6df318ee2f51e13f6402d264fedb5d9ab.camel@HansenPartnership.com>
Subject: Re: [PATCH v2 0/5] tpm_tis: fix interrupts (again)
From:   James Bottomley <James.Bottomley@HansenPartnership.com>
To:     Jerry Snitselaar <jsnitsel@redhat.com>, equired@linux.intel.com,
        justmentioningitbecauseIthinkthatwouldbeagood@linux.intel.com
Cc:     linux-integrity@vger.kernel.org, Jason Gunthorpe <jgg@ziepe.ca>,
        Peter Huewe <peterhuewe@gmx.de>,
        Borislav Petkov <bp@alien8.de>,
        Nayna Jain <nayna@linux.ibm.com>
Date:   Tue, 13 Oct 2020 08:24:18 -0700
In-Reply-To: <87tuuyf97r.fsf@jsnitsel.users.ipa.redhat.com>
References: <20201001180925.13808-1-James.Bottomley@HansenPartnership.com>
         <20201013011745.GA41176@linux.intel.com>
         <87tuuyf97r.fsf@jsnitsel.users.ipa.redhat.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.34.4 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Tue, 2020-10-13 at 08:15 -0700, Jerry Snitselaar wrote:
> Jarkko Sakkinen @ 2020-10-12 18:17 MST:
> 
> > On Thu, Oct 01, 2020 at 11:09:20AM -0700, James Bottomley wrote:
> > > The current state of the TIS TPM is that interrupts have been
> > > globally disabled by various changes.  The problems we got
> > > reported the last time they were enabled was interrupt
> > > storms.  With my own TIS TPM, I've found that this is caused
> > > because my TPM doesn't do legacy cycles, The TIS spec (chapter
> > > 6.1 "Locality Usage Per Register") requires any TIS TPM without
> > > legacy cycles not to act on any write to an interrupt register
> > > unless the locality is enabled.  This means if an interrupt fires
> > > after we relinquish the locality, the TPM_EOI in the interrupt
> > > routine is ineffective meaning the same interrupt triggers over
> > > and over again.  This problem also means we can have trouble
> > > setting up interrupts on TIS TPMs because the current init
> > > code does the setup before the locality is claimed for the first
> > > time.
> > > 
> > > James
> > 
> > You should consider expanding the audience.

Well, most people interested in testing this sort of thing are already
on the integrity list.

> >  Jerry, once you have some bandwidth (no rush, does not land before
> > rc2), it would be great that if you could try this. I'm emphasizing
> > this just because of the intersection. I think it would also make
> > senset to get tested-by from Nayna.
> 
> I will run some tests on some other systems I have access to. As
> noted in the other email I did a quick test with a t490s with an
> older bios that exhibits the problem originally reported when
> Stefan's patch enabled interrupts.

Well, it means there's still some other problem.  I was hoping that
because the rainbow pass system originally exhibited the same symptoms
(interrupt storm) fixing it would also fix the t490 and the ineffective
EOI bug looked like a great candidate for being the root cause.

How amenable are you to debugging this?  I originally figured out the
problem with the rainbow pass by putting ratelimited printks in the
interrupt routine and most of the TIS transmission ones, but it's
somewhat labour intensive doing it this way.

James


