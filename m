Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0517324A889
	for <lists+linux-integrity@lfdr.de>; Wed, 19 Aug 2020 23:33:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726570AbgHSVdR (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 19 Aug 2020 17:33:17 -0400
Received: from mga06.intel.com ([134.134.136.31]:57807 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726466AbgHSVdR (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 19 Aug 2020 17:33:17 -0400
IronPort-SDR: YkkaEqAkXX1ys1IN11cRkb+O5k8gvP7JKfr93wVdPVzZxZp+xNpIoPFxtRBnXaMJOAXJJBZdHO
 +4wCK/ng3tWw==
X-IronPort-AV: E=McAfee;i="6000,8403,9718"; a="216731885"
X-IronPort-AV: E=Sophos;i="5.76,332,1592895600"; 
   d="scan'208";a="216731885"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Aug 2020 14:33:16 -0700
IronPort-SDR: Go1Hu9n8J+6kiCdDwSMxOrOoCjJdgmLiUafYbi86+nSPZ+Q7vxl4iecI0YsCJxNxvQRc0Cm7z0
 U4yDIolDyzug==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.76,332,1592895600"; 
   d="scan'208";a="400949871"
Received: from abojanow-mobl4.ger.corp.intel.com (HELO localhost) ([10.252.52.107])
  by fmsmga001.fm.intel.com with ESMTP; 19 Aug 2020 14:33:14 -0700
Date:   Thu, 20 Aug 2020 00:33:14 +0300
From:   Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To:     James Bottomley <James.Bottomley@HansenPartnership.com>
Cc:     linux-integrity@vger.kernel.org, Mimi Zohar <zohar@linux.ibm.com>
Subject: Re: [PATCH v4 1/1] tpm: add sysfs exports for all banks of PCR
 registers
Message-ID: <20200819213314.GH9942@linux.intel.com>
References: <20200817213506.4474-1-James.Bottomley@HansenPartnership.com>
 <20200817213506.4474-2-James.Bottomley@HansenPartnership.com>
 <20200818161207.GC137138@linux.intel.com>
 <20200818161955.GD137138@linux.intel.com>
 <1597769070.3898.36.camel@HansenPartnership.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1597769070.3898.36.camel@HansenPartnership.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Tue, Aug 18, 2020 at 09:44:30AM -0700, James Bottomley wrote:
> On Tue, 2020-08-18 at 19:19 +0300, Jarkko Sakkinen wrote:
> > On Tue, Aug 18, 2020 at 07:12:09PM +0300, Jarkko Sakkinen wrote:
> > > On Mon, Aug 17, 2020 at 02:35:06PM -0700, James Bottomley wrote:
> > > > Create sysfs per hash groups with 24 PCR files in them one group,
> > > > named pcr-<hash>, for each agile hash of the TPM.  The files are
> > > > plugged in to a PCR read function which is TPM version agnostic,
> > > > so this works also for TPM 1.2 but the hash is only sha1 in that
> > > > case.
> > > > 
> > > > Note: the macros used to create the hashes emit spurious
> > > > checkpatch warnings.  Do not try to "fix" them as checkpatch
> > > > recommends, otherwise they'll break.
> > > > 
> > > > Signed-off-by: James Bottomley <James.Bottomley@HansenPartnership
> > > > .com>
> > > > Reviewed-by: Jerry Snitselaar <jsnitsel@redhat.com>
> > > > Tested-by: Thiago Jung Bauermann <bauerman@linux.ibm.com>
> > > 
> > > I have hard time understanding why this is required.
> > > 
> > > You can grab the information through /dev/tpm0 just fine.
> > 
> > I just think it is principally wrong to add sysfs files if they don't
> > have any measurable value other than perhaps some convenience.
> 
> That's pretty much the whole point of sysfs (and procfs): to add
> convenient extraction of information even if it could potentially be
> obtained by other sources.  For instance, the whole reason we add a lot
> of the broken out inquiry data in SCSI via sysfs is precisely so users
> don't have to go prodding devices with direct SCSI commands, which are
> pretty much analagous to TPM device commands.
> 
> The question you should be asking isn't whether the information *could*
> be obtained by other means, but whether providing it in this form
> facilitates current operations and whether the interface would have
> users.

Usually users use some appropriate applications to do their work, not
talk directly to the kernel.

Grabbing PCRs is a trivial program to write and I don't get the logic.

My email program is useful for me but I definitely do not want it to be
part of the Linux kernel. One great reason for that is that it would
involve a tedious process to update it later on.

/Jarkko
