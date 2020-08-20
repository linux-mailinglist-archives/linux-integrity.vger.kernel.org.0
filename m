Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C906F24C26A
	for <lists+linux-integrity@lfdr.de>; Thu, 20 Aug 2020 17:46:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729026AbgHTPqG (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 20 Aug 2020 11:46:06 -0400
Received: from mga01.intel.com ([192.55.52.88]:32883 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728209AbgHTPqE (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 20 Aug 2020 11:46:04 -0400
IronPort-SDR: 2KyHS3IREAzJ0tfDtbYmswe1WRn+HXBZYi1Xl31Uy8OVInrLeELdkAAHX3tDXtUYEO9V/4VQ/f
 N+0jOuX/2oNA==
X-IronPort-AV: E=McAfee;i="6000,8403,9718"; a="173372167"
X-IronPort-AV: E=Sophos;i="5.76,333,1592895600"; 
   d="scan'208";a="173372167"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Aug 2020 08:46:04 -0700
IronPort-SDR: 6+uuEjHIxSqbONS30x1eFKWkIyzGvLQTkpdVMXB6qcM2I1vgYcHkh4O6PgJfl6N3JjXsMbBCl7
 mGvI8w9yGtjQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.76,333,1592895600"; 
   d="scan'208";a="498190222"
Received: from mkidd-mobl.ger.corp.intel.com (HELO localhost) ([10.249.33.244])
  by fmsmga005.fm.intel.com with ESMTP; 20 Aug 2020 08:46:02 -0700
Date:   Thu, 20 Aug 2020 18:46:02 +0300
From:   Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To:     Jerry Snitselaar <jsnitsel@redhat.com>
Cc:     Mimi Zohar <zohar@linux.ibm.com>, Jason Gunthorpe <jgg@nvidia.com>,
        James Bottomley <James.Bottomley@HansenPartnership.com>,
        linux-integrity@vger.kernel.org
Subject: Re: [PATCH v4 1/1] tpm: add sysfs exports for all banks of PCR
 registers
Message-ID: <20200820154602.GB5462@linux.intel.com>
References: <20200818164602.GZ1152540@nvidia.com>
 <39eb6b408e7f060ab241954102d06f97d1f99611.camel@linux.ibm.com>
 <20200818183603.GC1152540@nvidia.com>
 <14eaf21a808e333ca414c954d8f3a2f7b6dbf2ca.camel@linux.ibm.com>
 <20200819120238.GD1152540@nvidia.com>
 <59f983156fed466d568c324de72ef733c1a15d76.camel@linux.ibm.com>
 <20200819140943.GH1152540@nvidia.com>
 <e33cca9a33a151cf35f12aca9dfd42378d632322.camel@linux.ibm.com>
 <20200819221647.GN9942@linux.intel.com>
 <87lfiamevo.fsf@jsnitsel.users.ipa.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87lfiamevo.fsf@jsnitsel.users.ipa.redhat.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Wed, Aug 19, 2020 at 03:48:11PM -0700, Jerry Snitselaar wrote:
> 
> Jarkko Sakkinen @ 2020-08-19 15:16 MST:
> 
> > On Wed, Aug 19, 2020 at 10:53:38AM -0400, Mimi Zohar wrote:
> >> On Wed, 2020-08-19 at 11:09 -0300, Jason Gunthorpe wrote:
> >> > On Wed, Aug 19, 2020 at 09:27:33AM -0400, Mimi Zohar wrote:
> >> > > On Wed, 2020-08-19 at 09:02 -0300, Jason Gunthorpe wrote:
> >> > > > On Tue, Aug 18, 2020 at 02:55:50PM -0400, Mimi Zohar wrote:
> >> > > > 
> >> > > > > The problem is that there isn't just one single userspace library or
> >> > > > > application for reading PCRs.  So now not only is there the kernel
> >> > > > > "boot_aggregate" regression testing, but regression testing of the tool
> >> > > > > itself to support multiple methods of reading the PCRs.
> >> > > > 
> >> > > > I was thinking just open code 
> >> > > >   open("/dev/tpm")
> >> > > >   write(read_pcrs_cmd)
> >> > > >   read(read_pcrs_cmd)
> >> > > >  
> >> > > > It isn't particularly hard to retrive the PCRs, don't really need to
> >> > > > depend on a library.
> >> > > 
> >> > > Ok, do you want to contribute it to ima-evm-utils?  While you're at it,
> >> > > do you also have code to parse the TPM 2.0 event log that you could
> >> > > contribute?
> >> > > 
> >> > > Seriously, we shouldn't be (re-)writing code to do this.
> >> > 
> >> > The kernel should not be used a dumping ground to work around a
> >> > dysfunctional userspace either. :(
> >> > 
> >> > You've basicaly said you can't rely on a sane userspace library
> >> > because *reasons* so we need to dump stuff in the kernel instead.
> >> > 
> >> > It is not a good justification to add new uAPI.
> >> > 
> >> > James seems to have the same basic conclusion too, unfortunately.
> >> 
> >> "dysfunctional" is dropping existing TPM 1.2 sysfs support, which was
> >> done without consideration about existing applications/tools (e.g. ima-
> >> evm-utils, ltp) and without community input.  It's not only James that
> >> is advocating for exporting the TPM PCRs, but Jerry Snitselaar, who
> >> reviewed this patch and exported the TPM version, and Nayna Jain, who
> >> exported the TPM 2.0 event log.  I'm pretty sure there are a number of
> >> other people who would agree.
> >> 
> >> Mimi
> >
> > This is not true. TPM 1.2 sysfs was not dropped.
> >
> > Not adding something does not mean technically dropping something.
> >
> > /Jarkko
> 
> When reviewing it I honestly didn't give much(any?) thought to whether
> it should be there. My thought was it adhered to the 1 value per file
> rule unlike the 1.2 pcrs file and that was about it.
> 
> IIRC when 2.0 was added there was the issue of things like the 1.2 pcrs
> not conforming to standards, possible issues of races, and a question of
> what exactly should be exported.  1.2 has a number of files for doing
> things that I think were also handled by ppi and userspace.
> 
> I guess the question is where does the line get drawn. My exporting the
> major version of the tpm probably could've been handled instead with a
> pr_info spitting it out for people to grab out of dmesg.
> 
> 
> Jerry

TPM protocol version is a different case tha dumping all the PCRs as
ASCII. It fairly unintrusive feature for the kernel, kernel has this
knowledge stored already and it is constant for a boot cycle.

/Jarkko
