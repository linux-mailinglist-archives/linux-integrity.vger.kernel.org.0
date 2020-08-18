Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B00D3248B92
	for <lists+linux-integrity@lfdr.de>; Tue, 18 Aug 2020 18:27:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726978AbgHRQ1J (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 18 Aug 2020 12:27:09 -0400
Received: from mga05.intel.com ([192.55.52.43]:1229 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726758AbgHRQ0d (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 18 Aug 2020 12:26:33 -0400
IronPort-SDR: cVIpBXoUghvrdIvWzi8odFataBRoDmuqphriX1drXuLRtgUpNjzvQ6bk7IWBLTY+d7wgXXtVYD
 qHof5bj3uFTQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9716"; a="239775987"
X-IronPort-AV: E=Sophos;i="5.76,328,1592895600"; 
   d="scan'208";a="239775987"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Aug 2020 09:26:32 -0700
IronPort-SDR: 76DfGtLTLbueqVaHMe+Z2aF+nBVb2IDPYlYjK/hGAhmikyywLpd+62x4OSJXqMsGuODKL3G1PY
 HD4qYqRPuHaA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.76,328,1592895600"; 
   d="scan'208";a="310493054"
Received: from ribnhajh-mobl.ger.corp.intel.com (HELO localhost) ([10.249.47.113])
  by orsmga002.jf.intel.com with ESMTP; 18 Aug 2020 09:26:31 -0700
Date:   Tue, 18 Aug 2020 19:26:30 +0300
From:   Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To:     James Bottomley <James.Bottomley@HansenPartnership.com>,
        Jason Gunthorpe <jgg@mellanox.com>
Cc:     linux-integrity@vger.kernel.org, Mimi Zohar <zohar@linux.ibm.com>
Subject: Re: [PATCH v4 1/1] tpm: add sysfs exports for all banks of PCR
 registers
Message-ID: <20200818162630.GE137138@linux.intel.com>
References: <20200817213506.4474-1-James.Bottomley@HansenPartnership.com>
 <20200817213506.4474-2-James.Bottomley@HansenPartnership.com>
 <20200818161207.GC137138@linux.intel.com>
 <20200818161955.GD137138@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200818161955.GD137138@linux.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Tue, Aug 18, 2020 at 07:19:57PM +0300, Jarkko Sakkinen wrote:
> On Tue, Aug 18, 2020 at 07:12:09PM +0300, Jarkko Sakkinen wrote:
> > On Mon, Aug 17, 2020 at 02:35:06PM -0700, James Bottomley wrote:
> > > Create sysfs per hash groups with 24 PCR files in them one group,
> > > named pcr-<hash>, for each agile hash of the TPM.  The files are
> > > plugged in to a PCR read function which is TPM version agnostic, so
> > > this works also for TPM 1.2 but the hash is only sha1 in that case.
> > > 
> > > Note: the macros used to create the hashes emit spurious checkpatch
> > > warnings.  Do not try to "fix" them as checkpatch recommends, otherwise
> > > they'll break.
> > > 
> > > Signed-off-by: James Bottomley <James.Bottomley@HansenPartnership.com>
> > > Reviewed-by: Jerry Snitselaar <jsnitsel@redhat.com>
> > > Tested-by: Thiago Jung Bauermann <bauerman@linux.ibm.com>
> > 
> > I have hard time understanding why this is required.
> > 
> > You can grab the information through /dev/tpm0 just fine.
> 
> I just think it is principally wrong to add sysfs files if they don't
> have any measurable value other than perhaps some convenience.
> 
> It is trival to write only a libc dependent program that outputs PCRs.
> 
> I think this is essentially an user space problem that is getting sorted
> out with kernel code.

Jason, what do you make of this? I recall that it was you who I
discussed with about this topic when TPM 2.0 support was first
upstreamed.

/Jarkko
