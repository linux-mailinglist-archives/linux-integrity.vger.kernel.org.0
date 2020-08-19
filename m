Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 89F6D24A8DB
	for <lists+linux-integrity@lfdr.de>; Thu, 20 Aug 2020 00:01:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726617AbgHSWBs (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 19 Aug 2020 18:01:48 -0400
Received: from mga12.intel.com ([192.55.52.136]:33814 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726435AbgHSWBr (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 19 Aug 2020 18:01:47 -0400
IronPort-SDR: CAryYM/nkqbBuIdCWtPu7EWHZ+xGbaF6xdFZ/PwDJiZgZ/u6eGwE6BLC+b3s8XPXEDfDXK4tlu
 2q9A5Lfvcn7Q==
X-IronPort-AV: E=McAfee;i="6000,8403,9718"; a="134723478"
X-IronPort-AV: E=Sophos;i="5.76,332,1592895600"; 
   d="scan'208";a="134723478"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Aug 2020 15:01:46 -0700
IronPort-SDR: 8zxKylrMtU4hUa/rYZUP6jP8w7m6wLmJDypuC8Z3Q9QrcLcrW8bdMfU8qxckdYKKJAxrbwxXw0
 Gg03KRMyzaQw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.76,332,1592895600"; 
   d="scan'208";a="297360666"
Received: from pbooyens-mobl1.ger.corp.intel.com (HELO localhost) ([10.252.52.107])
  by orsmga006.jf.intel.com with ESMTP; 19 Aug 2020 15:01:45 -0700
Date:   Thu, 20 Aug 2020 01:01:44 +0300
From:   Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To:     Mimi Zohar <zohar@linux.ibm.com>
Cc:     Jason Gunthorpe <jgg@nvidia.com>,
        James Bottomley <James.Bottomley@HansenPartnership.com>,
        linux-integrity@vger.kernel.org
Subject: Re: [PATCH v4 1/1] tpm: add sysfs exports for all banks of PCR
 registers
Message-ID: <20200819220144.GJ9942@linux.intel.com>
References: <20200817213506.4474-1-James.Bottomley@HansenPartnership.com>
 <20200817213506.4474-2-James.Bottomley@HansenPartnership.com>
 <20200818161207.GC137138@linux.intel.com>
 <20200818161955.GD137138@linux.intel.com>
 <20200818162630.GE137138@linux.intel.com>
 <20200818164602.GZ1152540@nvidia.com>
 <39eb6b408e7f060ab241954102d06f97d1f99611.camel@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <39eb6b408e7f060ab241954102d06f97d1f99611.camel@linux.ibm.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Tue, Aug 18, 2020 at 02:26:04PM -0400, Mimi Zohar wrote:
> On Tue, 2020-08-18 at 13:46 -0300, Jason Gunthorpe wrote:
> > On Tue, Aug 18, 2020 at 07:26:30PM +0300, Jarkko Sakkinen wrote:
> > > On Tue, Aug 18, 2020 at 07:19:57PM +0300, Jarkko Sakkinen wrote:
> > > > On Tue, Aug 18, 2020 at 07:12:09PM +0300, Jarkko Sakkinen wrote:
> > > > > On Mon, Aug 17, 2020 at 02:35:06PM -0700, James Bottomley wrote:
> > > > > > Create sysfs per hash groups with 24 PCR files in them one group,
> > > > > > named pcr-<hash>, for each agile hash of the TPM.  The files are
> > > > > > plugged in to a PCR read function which is TPM version agnostic, so
> > > > > > this works also for TPM 1.2 but the hash is only sha1 in that case.
> > > > > > 
> > > > > > Note: the macros used to create the hashes emit spurious checkpatch
> > > > > > warnings.  Do not try to "fix" them as checkpatch recommends, otherwise
> > > > > > they'll break.
> > > > > > 
> > > > > > Signed-off-by: James Bottomley <James.Bottomley@HansenPartnership.com>
> > > > > > Reviewed-by: Jerry Snitselaar <jsnitsel@redhat.com>
> > > > > > Tested-by: Thiago Jung Bauermann <bauerman@linux.ibm.com>
> > > > > 
> > > > > I have hard time understanding why this is required.
> > > > > 
> > > > > You can grab the information through /dev/tpm0 just fine.
> > > > 
> > > > I just think it is principally wrong to add sysfs files if they don't
> > > > have any measurable value other than perhaps some convenience.
> > > > 
> > > > It is trival to write only a libc dependent program that outputs PCRs.
> > > > 
> > > > I think this is essentially an user space problem that is getting sorted
> > > > out with kernel code.
> > > 
> > > Jason, what do you make of this? I recall that it was you who I
> > > discussed with about this topic when TPM 2.0 support was first
> > > upstreamed.
> > 
> > TPM 2.0 broke all the userspace so it made sense to get rid of the
> > non-conforming sysfs files from TPM v1.x time as part of the userspace
> > API. That was the main reason to not continue forward with PCR in
> > userspace.
> > 
> > As far as doing it properly as this patch does.. I agree with you that
> > sysfs files should have some reason to be added, espcially if it
> > causes quite big code cost as this does. eg to drive a udev rule
> > decision.
> > 
> > Why is PCRs so special it needs to be in sysfs? What is userspace
> > going to do with this information?
> 
> The original IMA LTP "boot_aggregate" regression test is dependent on
> the exported TPM event log and PCRs.  Similar support is needed for TPM
> 2.0.  There isn't just a single userspace application for reading
> PCRs.  As soon as we add support for one userspace
> application,  support for the other applications is requested.  So
> instead of a having a simple regression test with a single method of
> reading PCRs, we're now required to support multiple userspace
> applications.
> 
> I'm definitely in favor of exporting the PCRs, just as the TPM 2.0
> event log and version are now exported.
> 
> Mimi

They are very different use cases from this. In both kernel has
informatino that the user space does not possess. This is not the
case with the PCR values.

/Jarkko
