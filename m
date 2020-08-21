Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0094624DEB7
	for <lists+linux-integrity@lfdr.de>; Fri, 21 Aug 2020 19:41:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726737AbgHURlV (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 21 Aug 2020 13:41:21 -0400
Received: from mga12.intel.com ([192.55.52.136]:3170 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725885AbgHURlU (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 21 Aug 2020 13:41:20 -0400
IronPort-SDR: qpab+ffKENeoygcZ2DRrSqIMNSBsdgJHTyaRESH0Fq86v7mO1yPxsq8HyKPsX0PH4+/kF+FgEB
 RenKslaWHq6w==
X-IronPort-AV: E=McAfee;i="6000,8403,9720"; a="135132397"
X-IronPort-AV: E=Sophos;i="5.76,338,1592895600"; 
   d="scan'208";a="135132397"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Aug 2020 10:41:20 -0700
IronPort-SDR: 1g3nJGIzfe+9EqbuZDAUXiWDGjNtLcb8Rvh8uEdHmr++L8Y1xcgtL70Vt9Ze55jzu9ZL2UKXxU
 CO4EokIV77mg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.76,338,1592895600"; 
   d="scan'208";a="473126768"
Received: from jjakacki-mobl.ger.corp.intel.com (HELO localhost) ([10.252.52.112])
  by orsmga005.jf.intel.com with ESMTP; 21 Aug 2020 10:41:18 -0700
Date:   Fri, 21 Aug 2020 20:41:17 +0300
From:   Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To:     James Bottomley <James.Bottomley@HansenPartnership.com>
Cc:     Jason Gunthorpe <jgg@nvidia.com>, Mimi Zohar <zohar@linux.ibm.com>,
        linux-integrity@vger.kernel.org
Subject: Re: [PATCH v4 1/1] tpm: add sysfs exports for all banks of PCR
 registers
Message-ID: <20200821174117.GB3559@linux.intel.com>
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
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Thu, Aug 20, 2020 at 09:14:44AM -0700, James Bottomley wrote:
> On Wed, 2020-08-19 at 20:21 -0300, Jason Gunthorpe wrote:
> > On Wed, Aug 19, 2020 at 01:09:16PM -0700, James Bottomley wrote:
> > > On Wed, 2020-08-19 at 14:17 -0300, Jason Gunthorpe wrote:
> > > > On Wed, Aug 19, 2020 at 12:57:42PM -0400, Mimi Zohar wrote:
> > > > > On Wed, 2020-08-19 at 13:18 -0300, Jason Gunthorpe wrote:
> > > > > > Yes - it was dropped because TPM 2 was a *complete ABI break*
> > > > > > for everything. The kernel was reset to a uABI that matches
> > > > > > current uABI standards starting TPM 2.
> > > > > > 
> > > > > > The whole userspace needed to be redone anyhow, and certainly
> > > > > > nobody objected at the time.
> > > > > > 
> > > > > > At least my expecation was that a sensible userspace for TPM
> > > > > > (for administrator user) would be built, like we see in other
> > > > > > subsystems eg 'ip' for netdev.
> > > > > 
> > > > > "Because TPM 2 was a complete ABI break for everything" could
> > > > > be reason for upstreaming a minimal subset of functionality
> > > > > initially, which could be expanded over time.  I don't recall a
> > > > > discussion about limting features in the future.
> > > > 
> > > > All new uAPI additions need to pass the usual uAPI hurdles.
> > > > 
> > > > As James outlined, justify why the kernel must present a
> > > > duplicated uAPI between sysfs and /dev/tpm. 
> > > > 
> > > > There have been good reasons in the past, eg SCSI inquiry.
> > > 
> > > First, can we please agree /dev/tpm does not substitute as a
> > > "duplicate API". 
> > 
> > Er? Huh? How so?
> 
> Because like the SCSI command interface it's a binary marshalled
> protocol we want to abstract for users.  We can still argue whether the
> kernel or a toolkit should do the abstraction but it's not one we want
> to dump on users and say "this is it, what do you mean you don't like
> it?"

No we don't. On the contrary, we expose the protocol through /dev/tpm0.

/Jarkko
