Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0E29C252F68
	for <lists+linux-integrity@lfdr.de>; Wed, 26 Aug 2020 15:16:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730019AbgHZNP0 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 26 Aug 2020 09:15:26 -0400
Received: from mga17.intel.com ([192.55.52.151]:28045 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729177AbgHZNPY (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 26 Aug 2020 09:15:24 -0400
IronPort-SDR: GTt9xYozK/qErihi/wop0VdsCuWulrJxiq+UnBVB7nYMjorJHY3UroyJywbwocvW3yI36j9Ns2
 MmH9B7ZT5Tkw==
X-IronPort-AV: E=McAfee;i="6000,8403,9724"; a="136348102"
X-IronPort-AV: E=Sophos;i="5.76,355,1592895600"; 
   d="scan'208";a="136348102"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Aug 2020 06:15:24 -0700
IronPort-SDR: ZK9JoCRgCNUZwv8B3w2Z9Nda5TKsQr7Wv9kOcmf7Gro7dL94siEgX+fbcZaNCziauPaegfbRKY
 K8kJdrkLZqdQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.76,355,1592895600"; 
   d="scan'208";a="280305305"
Received: from kempfs-mobl1.ger.corp.intel.com (HELO localhost) ([10.252.55.157])
  by fmsmga007.fm.intel.com with ESMTP; 26 Aug 2020 06:15:22 -0700
Date:   Wed, 26 Aug 2020 16:15:20 +0300
From:   Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To:     James Bottomley <James.Bottomley@HansenPartnership.com>
Cc:     Jason Gunthorpe <jgg@nvidia.com>, Mimi Zohar <zohar@linux.ibm.com>,
        linux-integrity@vger.kernel.org
Subject: Re: [PATCH v4 1/1] tpm: add sysfs exports for all banks of PCR
 registers
Message-ID: <20200826131520.GA6532@linux.intel.com>
References: <78bc28a573f6660ee5b00d5965984fef2e1de167.camel@linux.ibm.com>
 <20200819171709.GN1152540@nvidia.com>
 <1597867756.3875.39.camel@HansenPartnership.com>
 <20200819232132.GT1152540@nvidia.com>
 <1597940084.3864.35.camel@HansenPartnership.com>
 <20200821193847.GA2811093@nvidia.com>
 <20200824194457.GA7391@linux.intel.com>
 <1598300446.4034.5.camel@HansenPartnership.com>
 <20200825152739.GA8518@linux.intel.com>
 <1598369621.7939.22.camel@HansenPartnership.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1598369621.7939.22.camel@HansenPartnership.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Tue, Aug 25, 2020 at 08:33:41AM -0700, James Bottomley wrote:
> On Tue, 2020-08-25 at 18:27 +0300, Jarkko Sakkinen wrote:
> > On Mon, Aug 24, 2020 at 01:20:46PM -0700, James Bottomley wrote:
> > > On Mon, 2020-08-24 at 22:44 +0300, Jarkko Sakkinen wrote:
> > > > On Fri, Aug 21, 2020 at 04:38:47PM -0300, Jason Gunthorpe wrote:
> > > > > On Thu, Aug 20, 2020 at 09:14:44AM -0700, James Bottomley
> > > > > wrote:
> > > > > 
> > > > > > > eg we can't do it because we can't access /dev/tpm for
> > > > > > > permissions or something.
> > > > > > 
> > > > > > I already said that: we can't it's root.root 0600
> > > > > > currently.  All the TSSs seem to change at least /dev/tpmrm
> > > > > > to tpm.tpm 0660 but we can't do that in the kernel because
> > > > > > there's no fixed tpm uid/gid.
> > > > > 
> > > > > Permissions is a pretty good reason to add a sysfs file.
> > > > > 
> > > > > Jason
> > > > 
> > > > I'm not sure why suid/sgid utility to read pcrs would be worse.
> > > 
> > > We don't do root running or suid/sgid binaries any more because
> > > they're exceptional security risks.  That's why both TSSs for TPM
> > > 2.0 change the device ownership.  For Trousers and TPM 1.2 we used
> > > to run the daemon as root until we started getting CVEs about it.
> > > 
> > > James
> > 
> > OK, then a binary blob for pcrs would be sufficient.
> 
> From a sysfs perspective we only do one value per file and we don't
> export binary if a valid and useful ascii representation exists.  On
> both of those kernel principles, the current proposal is canonical.
> 
> James

The event log is also exported as a binary. This patch set pollutes the
sysfs and adds too much overhead for maintaining. Every single algorithm
will needs its own file and needs to be patched to the kernel.

A single 'pcrs' blob could with contents as <alg id, data> pairs would
remain static.

If you speak about principles, please add a reference and/or CC your
patch set also to sysfs maintainers. All I care if what is pragmatically
the best choice.

/Jarkko
