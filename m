Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1A2E52F57EE
	for <lists+linux-integrity@lfdr.de>; Thu, 14 Jan 2021 04:01:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728448AbhANCLi (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 13 Jan 2021 21:11:38 -0500
Received: from mail.kernel.org ([198.145.29.99]:43216 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729251AbhAMWPS (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 13 Jan 2021 17:15:18 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id DC5B823339;
        Wed, 13 Jan 2021 22:14:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1610576069;
        bh=YPaA0+QkNX7/eq1Wwg82C84x12V1KgYhdxKCWybAf+s=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=TPbBI+c5z5j8US2/+SnQvl6ws1oIjV/+5WO9kPgqQIB3iIqL0W4Fet3M7Wr79vg0o
         HSrhF8H9OHK5Cx1wjuL4xisOUrfrbuMaMrTMl0qy+FmHI8sYkkiP59LbTWV23KH3HQ
         4VOh4gizvB5yYUDLYwxQ/V92bNIZu8f94t5mARZxE1UJG9gQi6akxhvU0KdwvZCDXa
         UPoiJhCjrnpBuWjV8d8B/YhKOwixKMs8vdai/30sHpjuURYIHYFqu5wka7eQzHiOko
         sOom5LmkoFSrg61hPZDvksKoLJvKtxfrVOoZqmVVJaOAFq7capIIWJjzKd/KGFgAex
         BaZ8v50WQkgzw==
Date:   Thu, 14 Jan 2021 00:14:24 +0200
From:   Jarkko Sakkinen <jarkko@kernel.org>
To:     James Bottomley <James.Bottomley@hansenpartnership.com>
Cc:     Greg KH <greg@kroah.com>, linux-integrity@vger.kernel.org,
        Mimi Zohar <zohar@linux.ibm.com>,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        linux-api@vger.kernel.org
Subject: Re: [PATCH v5 1/1] tpm: add sysfs exports for all banks of PCR
 registers
Message-ID: <X/9wwEr477zSttED@kernel.org>
References: <20210113015958.6685-1-James.Bottomley@HansenPartnership.com>
 <20210113015958.6685-2-James.Bottomley@HansenPartnership.com>
 <X/6lyuhqQ8TSXOSa@kroah.com>
 <a6bdeef73f9271cca99585d3e855681cf6b6f589.camel@HansenPartnership.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a6bdeef73f9271cca99585d3e855681cf6b6f589.camel@HansenPartnership.com>
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Wed, Jan 13, 2021 at 09:31:44AM -0800, James Bottomley wrote:
> On Wed, 2021-01-13 at 08:48 +0100, Greg KH wrote:
> > On Tue, Jan 12, 2021 at 05:59:58PM -0800, James Bottomley wrote:
> > > Create sysfs per hash groups with 24 PCR files in them one group,
> > > named pcr-<hash>, for each agile hash of the TPM.  The files are
> > > plugged in to a PCR read function which is TPM version agnostic, so
> > > this works also for TPM 1.2 but the hash is only sha1 in that case.
> > > 
> > > Note: the macros used to create the hashes emit spurious checkpatch
> > > warnings.  Do not try to "fix" them as checkpatch recommends,
> > > otherwise
> > > they'll break.
> > > 
> > > Signed-off-by: James Bottomley <
> > > James.Bottomley@HansenPartnership.com>
> > > Reviewed-by: Jerry Snitselaar <jsnitsel@redhat.com>
> > > Tested-by: Thiago Jung Bauermann <bauerman@linux.ibm.com>
> > > 
> > > ---
> > > 
> > > v2: fix TPM 1.2 legacy links failure
> > > v3: fix warn on and add note to tpm_algorithms
> > > v4: reword commit and add tested-by
> > > v5: algorithm spelling fix WARN->dev_err
> > > ---
> > >  drivers/char/tpm/tpm-sysfs.c | 179
> > > +++++++++++++++++++++++++++++++++++
> > >  include/linux/tpm.h          |   9 +-
> > >  2 files changed, 187 insertions(+), 1 deletion(-)
> > 
> > You add new sysfs files, but do not add Documentation/ABI/ entries
> > showing how they are used and what they contain :(
> > 
> > Please do that for the next version of this patch.
> 
> It's a bit of a chicken and egg problem since I've no idea when this
> will go upstream and the entries require that information making the
> ABI more of a post accept type thing.  I can make a guess about the
> values if Jarkko is going to but this in for the next merge window.
> 
> James

I agree with the ABI side, so you can safely include this to the patch set. 
And yes, this looks like something I can include to the 5.12 PR.

Did you address Greg's remarks about warns?

Other than that, please send a version with ABI entries  so that
we can move forward with this.

/Jarkko
