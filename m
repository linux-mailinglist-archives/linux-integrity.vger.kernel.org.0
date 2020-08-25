Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B1E74251C46
	for <lists+linux-integrity@lfdr.de>; Tue, 25 Aug 2020 17:27:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726473AbgHYP1o (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 25 Aug 2020 11:27:44 -0400
Received: from mga18.intel.com ([134.134.136.126]:52588 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726294AbgHYP1n (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 25 Aug 2020 11:27:43 -0400
IronPort-SDR: 9FPaFHoCGkECPM0ebzUZBrCrEPWqMGNEph8L+KbanSH4fEH8ZLp3sbdKQs7LFlp2xabggVbHLb
 uNeYzNJTjErg==
X-IronPort-AV: E=McAfee;i="6000,8403,9723"; a="143794477"
X-IronPort-AV: E=Sophos;i="5.76,353,1592895600"; 
   d="scan'208";a="143794477"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Aug 2020 08:27:41 -0700
IronPort-SDR: sor1/Jc4AUXZPH3GQw8vo4BglpbTrCqEAQQJUAYbMpzvJuDJMxPL37dv42Q/1U4UeFdr86AdoM
 wLfyl/RWA8oQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.76,353,1592895600"; 
   d="scan'208";a="331437706"
Received: from lszady-mobl.ger.corp.intel.com (HELO localhost) ([10.252.32.39])
  by fmsmga002.fm.intel.com with ESMTP; 25 Aug 2020 08:27:40 -0700
Date:   Tue, 25 Aug 2020 18:27:39 +0300
From:   Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To:     James Bottomley <James.Bottomley@HansenPartnership.com>
Cc:     Jason Gunthorpe <jgg@nvidia.com>, Mimi Zohar <zohar@linux.ibm.com>,
        linux-integrity@vger.kernel.org
Subject: Re: [PATCH v4 1/1] tpm: add sysfs exports for all banks of PCR
 registers
Message-ID: <20200825152739.GA8518@linux.intel.com>
References: <1597850231.3875.13.camel@HansenPartnership.com>
 <20200819161845.GK1152540@nvidia.com>
 <78bc28a573f6660ee5b00d5965984fef2e1de167.camel@linux.ibm.com>
 <20200819171709.GN1152540@nvidia.com>
 <1597867756.3875.39.camel@HansenPartnership.com>
 <20200819232132.GT1152540@nvidia.com>
 <1597940084.3864.35.camel@HansenPartnership.com>
 <20200821193847.GA2811093@nvidia.com>
 <20200824194457.GA7391@linux.intel.com>
 <1598300446.4034.5.camel@HansenPartnership.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1598300446.4034.5.camel@HansenPartnership.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Mon, Aug 24, 2020 at 01:20:46PM -0700, James Bottomley wrote:
> On Mon, 2020-08-24 at 22:44 +0300, Jarkko Sakkinen wrote:
> > On Fri, Aug 21, 2020 at 04:38:47PM -0300, Jason Gunthorpe wrote:
> > > On Thu, Aug 20, 2020 at 09:14:44AM -0700, James Bottomley wrote:
> > > 
> > > > > eg we can't do it because we can't access /dev/tpm for
> > > > > permissions or
> > > > > something.
> > > > 
> > > > I already said that: we can't it's root.root 0600 currently.  All
> > > > the TSSs seem to change at least /dev/tpmrm to tpm.tpm 0660 but
> > > > we can't do that in the kernel because there's no fixed tpm
> > > > uid/gid.
> > > 
> > > Permissions is a pretty good reason to add a sysfs file.
> > > 
> > > Jason
> > 
> > I'm not sure why suid/sgid utility to read pcrs would be worse.
> 
> We don't do root running or suid/sgid binaries any more because they're
> exceptional security risks.  That's why both TSSs for TPM 2.0 change
> the device ownership.  For Trousers and TPM 1.2 we used to run the
> daemon as root until we started getting CVEs about it.
> 
> James

OK, then a binary blob for pcrs would be sufficient.

/Jarkko
