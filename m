Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CDD19252F80
	for <lists+linux-integrity@lfdr.de>; Wed, 26 Aug 2020 15:19:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730220AbgHZNTn (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 26 Aug 2020 09:19:43 -0400
Received: from mga06.intel.com ([134.134.136.31]:25491 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728132AbgHZNTn (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 26 Aug 2020 09:19:43 -0400
IronPort-SDR: Lux89oVP6mz3e8PLg/JXRNp/luziRDuoRAk3lw8knucZLR4bWJbRdSrBbPMABZEwFerVeGW5ET
 UcGAK2KmNkpg==
X-IronPort-AV: E=McAfee;i="6000,8403,9724"; a="217834047"
X-IronPort-AV: E=Sophos;i="5.76,355,1592895600"; 
   d="scan'208";a="217834047"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Aug 2020 06:19:42 -0700
IronPort-SDR: SzIka2CP4gc8lFJNkoCf+7ZEvrtVtiQYmyh1WVmAXDNwHj9xqHiXfzc/n6YaR7EOMCjzNWgqch
 AKKzIz+zASIg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.76,355,1592895600"; 
   d="scan'208";a="403062494"
Received: from kempfs-mobl1.ger.corp.intel.com (HELO localhost) ([10.252.55.157])
  by fmsmga001.fm.intel.com with ESMTP; 26 Aug 2020 06:19:39 -0700
Date:   Wed, 26 Aug 2020 16:19:18 +0300
From:   Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To:     James Bottomley <James.Bottomley@HansenPartnership.com>
Cc:     Jason Gunthorpe <jgg@nvidia.com>, Mimi Zohar <zohar@linux.ibm.com>,
        linux-integrity@vger.kernel.org
Subject: Re: [PATCH v4 1/1] tpm: add sysfs exports for all banks of PCR
 registers
Message-ID: <20200826131918.GB6532@linux.intel.com>
References: <20200819171709.GN1152540@nvidia.com>
 <1597867756.3875.39.camel@HansenPartnership.com>
 <20200819232132.GT1152540@nvidia.com>
 <1597940084.3864.35.camel@HansenPartnership.com>
 <20200821193847.GA2811093@nvidia.com>
 <20200824194457.GA7391@linux.intel.com>
 <1598300446.4034.5.camel@HansenPartnership.com>
 <20200825152739.GA8518@linux.intel.com>
 <1598369621.7939.22.camel@HansenPartnership.com>
 <20200826131520.GA6532@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200826131520.GA6532@linux.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Wed, Aug 26, 2020 at 04:15:25PM +0300, Jarkko Sakkinen wrote:
> On Tue, Aug 25, 2020 at 08:33:41AM -0700, James Bottomley wrote:
> > On Tue, 2020-08-25 at 18:27 +0300, Jarkko Sakkinen wrote:
> > > On Mon, Aug 24, 2020 at 01:20:46PM -0700, James Bottomley wrote:
> > > > On Mon, 2020-08-24 at 22:44 +0300, Jarkko Sakkinen wrote:
> > > > > On Fri, Aug 21, 2020 at 04:38:47PM -0300, Jason Gunthorpe wrote:
> > > > > > On Thu, Aug 20, 2020 at 09:14:44AM -0700, James Bottomley
> > > > > > wrote:
> > > > > > 
> > > > > > > > eg we can't do it because we can't access /dev/tpm for
> > > > > > > > permissions or something.
> > > > > > > 
> > > > > > > I already said that: we can't it's root.root 0600
> > > > > > > currently.  All the TSSs seem to change at least /dev/tpmrm
> > > > > > > to tpm.tpm 0660 but we can't do that in the kernel because
> > > > > > > there's no fixed tpm uid/gid.
> > > > > > 
> > > > > > Permissions is a pretty good reason to add a sysfs file.
> > > > > > 
> > > > > > Jason
> > > > > 
> > > > > I'm not sure why suid/sgid utility to read pcrs would be worse.
> > > > 
> > > > We don't do root running or suid/sgid binaries any more because
> > > > they're exceptional security risks.  That's why both TSSs for TPM
> > > > 2.0 change the device ownership.  For Trousers and TPM 1.2 we used
> > > > to run the daemon as root until we started getting CVEs about it.
> > > > 
> > > > James
> > > 
> > > OK, then a binary blob for pcrs would be sufficient.
> > 
> > From a sysfs perspective we only do one value per file and we don't
> > export binary if a valid and useful ascii representation exists.  On
> > both of those kernel principles, the current proposal is canonical.
> > 
> > James
> 
> The event log is also exported as a binary. This patch set pollutes the
> sysfs and adds too much overhead for maintaining. Every single algorithm
> will needs its own file and needs to be patched to the kernel.
> 
> A single 'pcrs' blob could with contents as <alg id, data> pairs would
> remain static.
> 
> If you speak about principles, please add a reference and/or CC your
> patch set also to sysfs maintainers. All I care if what is pragmatically
> the best choice.

A correction: event log is exported through securityfs

I think pcrs should be exported also there instead of sysfs. Does not
feel very sound to have these files in different locations.

> /Jarkko

/Jarkko
