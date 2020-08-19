Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CB9DE24A8ED
	for <lists+linux-integrity@lfdr.de>; Thu, 20 Aug 2020 00:13:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726603AbgHSWN3 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 19 Aug 2020 18:13:29 -0400
Received: from mga07.intel.com ([134.134.136.100]:55422 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726435AbgHSWN3 (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 19 Aug 2020 18:13:29 -0400
IronPort-SDR: vJ2rcxoh3Qa8UDcFcwBsLOhpaapuJ9Icv3T5E64pPNXZQWTWTY2hlz10/tByN1mDEZCh0mQWAs
 kLU+y3gsqDmg==
X-IronPort-AV: E=McAfee;i="6000,8403,9718"; a="219512269"
X-IronPort-AV: E=Sophos;i="5.76,332,1592895600"; 
   d="scan'208";a="219512269"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Aug 2020 15:13:28 -0700
IronPort-SDR: Mex4dkKvMNz8iH7jvuM+3aZwvnZ/OW50wdfF27op8jX4xPbKhCXHG+kl3OtTICdlaJJ4/ESWo/
 EiYSN7izwHeQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.76,332,1592895600"; 
   d="scan'208";a="497900750"
Received: from abojanow-mobl4.ger.corp.intel.com (HELO localhost) ([10.252.52.107])
  by fmsmga005.fm.intel.com with ESMTP; 19 Aug 2020 15:13:26 -0700
Date:   Thu, 20 Aug 2020 01:13:26 +0300
From:   Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     Mimi Zohar <zohar@linux.ibm.com>,
        James Bottomley <James.Bottomley@HansenPartnership.com>,
        linux-integrity@vger.kernel.org
Subject: Re: [PATCH v4 1/1] tpm: add sysfs exports for all banks of PCR
 registers
Message-ID: <20200819221326.GK9942@linux.intel.com>
References: <20200817213506.4474-1-James.Bottomley@HansenPartnership.com>
 <20200817213506.4474-2-James.Bottomley@HansenPartnership.com>
 <20200818161207.GC137138@linux.intel.com>
 <20200818161955.GD137138@linux.intel.com>
 <20200818162630.GE137138@linux.intel.com>
 <20200818164602.GZ1152540@nvidia.com>
 <39eb6b408e7f060ab241954102d06f97d1f99611.camel@linux.ibm.com>
 <20200818183603.GC1152540@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200818183603.GC1152540@nvidia.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Tue, Aug 18, 2020 at 03:36:03PM -0300, Jason Gunthorpe wrote:
> On Tue, Aug 18, 2020 at 02:26:04PM -0400, Mimi Zohar wrote:
> > On Tue, 2020-08-18 at 13:46 -0300, Jason Gunthorpe wrote:
> > > On Tue, Aug 18, 2020 at 07:26:30PM +0300, Jarkko Sakkinen wrote:
> > > > On Tue, Aug 18, 2020 at 07:19:57PM +0300, Jarkko Sakkinen wrote:
> > > > > On Tue, Aug 18, 2020 at 07:12:09PM +0300, Jarkko Sakkinen wrote:
> > > > > > On Mon, Aug 17, 2020 at 02:35:06PM -0700, James Bottomley wrote:
> > > > > > > Create sysfs per hash groups with 24 PCR files in them one group,
> > > > > > > named pcr-<hash>, for each agile hash of the TPM.  The files are
> > > > > > > plugged in to a PCR read function which is TPM version agnostic, so
> > > > > > > this works also for TPM 1.2 but the hash is only sha1 in that case.
> > > > > > > 
> > > > > > > Note: the macros used to create the hashes emit spurious checkpatch
> > > > > > > warnings.  Do not try to "fix" them as checkpatch recommends, otherwise
> > > > > > > they'll break.
> > > > > > > 
> > > > > > > Signed-off-by: James Bottomley <James.Bottomley@HansenPartnership.com>
> > > > > > > Reviewed-by: Jerry Snitselaar <jsnitsel@redhat.com>
> > > > > > > Tested-by: Thiago Jung Bauermann <bauerman@linux.ibm.com>
> > > > > > 
> > > > > > I have hard time understanding why this is required.
> > > > > > 
> > > > > > You can grab the information through /dev/tpm0 just fine.
> > > > > 
> > > > > I just think it is principally wrong to add sysfs files if they don't
> > > > > have any measurable value other than perhaps some convenience.
> > > > > 
> > > > > It is trival to write only a libc dependent program that outputs PCRs.
> > > > > 
> > > > > I think this is essentially an user space problem that is getting sorted
> > > > > out with kernel code.
> > > > 
> > > > Jason, what do you make of this? I recall that it was you who I
> > > > discussed with about this topic when TPM 2.0 support was first
> > > > upstreamed.
> > > 
> > > TPM 2.0 broke all the userspace so it made sense to get rid of the
> > > non-conforming sysfs files from TPM v1.x time as part of the userspace
> > > API. That was the main reason to not continue forward with PCR in
> > > userspace.
> > > 
> > > As far as doing it properly as this patch does.. I agree with you that
> > > sysfs files should have some reason to be added, espcially if it
> > > causes quite big code cost as this does. eg to drive a udev rule
> > > decision.
> > > 
> > > Why is PCRs so special it needs to be in sysfs? What is userspace
> > > going to do with this information?
> > 
> > The original IMA LTP "boot_aggregate" regression test is dependent on
> > the exported TPM event log and PCRs.  Similar support is needed for TPM
> > 2.0.  There isn't just a single userspace application for reading
> > PCRs.  As soon as we add support for one userspace
> > application,  support for the other applications is requested.  So
> > instead of a having a simple regression test with a single method of
> > reading PCRs, we're now required to support multiple userspace
> > applications.
> 
> But this test already has a C program as part of the boot aggregate
> test, why is it such a problem to use a C program to also read the
> PCRs?
> 
> As Jarkko says it is not so hard
> 
> Jason

"A PCR blob" idea would have the (questionable, I'm not sure if it is
useful) benefit of atomic snapshot but it requires a more complex
implementation to be efficient. E.g. you would have to read PCRs once
in a boot and then intervene PCR manipulating operations, in order to
not cause too much run-time stress.

Convenience does not cut the deal here.

/Jarkko
