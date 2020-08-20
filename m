Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3781B24C3CA
	for <lists+linux-integrity@lfdr.de>; Thu, 20 Aug 2020 18:55:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729432AbgHTQzh (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 20 Aug 2020 12:55:37 -0400
Received: from mail.hallyn.com ([178.63.66.53]:57874 "EHLO mail.hallyn.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729681AbgHTQzh (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 20 Aug 2020 12:55:37 -0400
Received: by mail.hallyn.com (Postfix, from userid 1001)
        id 79185F14; Thu, 20 Aug 2020 11:55:35 -0500 (CDT)
Date:   Thu, 20 Aug 2020 11:55:35 -0500
From:   "Serge E. Hallyn" <serge@hallyn.com>
To:     James Bottomley <James.Bottomley@HansenPartnership.com>
Cc:     Jason Gunthorpe <jgg@nvidia.com>, Mimi Zohar <zohar@linux.ibm.com>,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        linux-integrity@vger.kernel.org
Subject: Re: [PATCH v4 1/1] tpm: add sysfs exports for all banks of PCR
 registers
Message-ID: <20200820165535.GA972@mail.hallyn.com>
References: <20200818183603.GC1152540@nvidia.com>
 <14eaf21a808e333ca414c954d8f3a2f7b6dbf2ca.camel@linux.ibm.com>
 <20200819120238.GD1152540@nvidia.com>
 <1597850231.3875.13.camel@HansenPartnership.com>
 <20200819161845.GK1152540@nvidia.com>
 <78bc28a573f6660ee5b00d5965984fef2e1de167.camel@linux.ibm.com>
 <20200819171709.GN1152540@nvidia.com>
 <1597867756.3875.39.camel@HansenPartnership.com>
 <20200819232132.GT1152540@nvidia.com>
 <1597940084.3864.35.camel@HansenPartnership.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1597940084.3864.35.camel@HansenPartnership.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Thu, Aug 20, 2020 at 09:14:44AM -0700, James Bottomley wrote:
> On Wed, 2020-08-19 at 20:21 -0300, Jason Gunthorpe wrote:
> > On Wed, Aug 19, 2020 at 01:09:16PM -0700, James Bottomley wrote:
> > I went to try to make a python implementation.. After about 10mins I
> > came up with this approximate thing:
> > 
> >  select = struct.pack(">BBB", 1, 0, 0) # PCR 1
> >  pcrread_in = struct.pack(">IHB", 1, TPM2_ALG_SHA1, len(select)) +
> > select
> >  msg = struct.pack(">HII", TPM2_ST_NO_SESSIONS, 10 + len(pcrread_in),
> > TPM2_CC_PCR_READ) + pcrread_in
> > 
> >  with open("/dev/tpm","wb") as tpm:
> >     tpm.write(msg)
> >     resp = tpm.read(msg)
> > 
> >  tag, length, return_code = struct.unpack(">HII",res[:10])
> >  if not return_code:
> >     raise Error()
> > 
> >  return res[10+20:] # digest
> > 
> > Which is hopefully quite close to being something working - at least
> > it looks fairly close to what the kernel implementation does.
> > 
> > Fortunately no Phd was required! I think Go would be about similar,
> > right?
> 
> I could do the same with perl, but not bash.  In the same way I could
> construct an anomalous SO(3) higgs model as a party trick.
> 
> the point is that when you ask users would they rather do the above or
> cat /sys/class/tpm/tpm0/pcr-sha1/1 they'll universally opt for the
> latter because it's way simpler.
> 
> Now perhaps if the mechanism that services this in the kernel were
> thousands of lines long and unmaintainable you'd think twice, but it's
> not, it's under 200 lines.  So the maintainability bar to us providing
> this is low and the user convenience quite high ... that's what makes
> it look like a good interface.
> 
> James

I'd also point out that this is the fundamental thing you do with the
pcrs.  There is no other way that some library would want to do it, and
everything builds on it.  We're exporting the core functionality as a
simpler file read/write.  I know that after taking filesystem interfaces
to an extreme, over the past 20 years we've turned back a bit, but in
this case it seems the right way to do it.
