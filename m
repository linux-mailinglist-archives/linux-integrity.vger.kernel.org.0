Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5697C24A256
	for <lists+linux-integrity@lfdr.de>; Wed, 19 Aug 2020 17:01:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726632AbgHSPBr (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 19 Aug 2020 11:01:47 -0400
Received: from mail.hallyn.com ([178.63.66.53]:59044 "EHLO mail.hallyn.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726187AbgHSPBq (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 19 Aug 2020 11:01:46 -0400
X-Greylist: delayed 320 seconds by postgrey-1.27 at vger.kernel.org; Wed, 19 Aug 2020 11:01:46 EDT
Received: by mail.hallyn.com (Postfix, from userid 1001)
        id 51F8AF0A; Wed, 19 Aug 2020 09:56:24 -0500 (CDT)
Date:   Wed, 19 Aug 2020 09:56:24 -0500
From:   "Serge E. Hallyn" <serge@hallyn.com>
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     Mimi Zohar <zohar@linux.ibm.com>,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        James Bottomley <James.Bottomley@HansenPartnership.com>,
        linux-integrity@vger.kernel.org
Subject: Re: [PATCH v4 1/1] tpm: add sysfs exports for all banks of PCR
 registers
Message-ID: <20200819145624.GA11771@mail.hallyn.com>
References: <20200818161207.GC137138@linux.intel.com>
 <20200818161955.GD137138@linux.intel.com>
 <20200818162630.GE137138@linux.intel.com>
 <20200818164602.GZ1152540@nvidia.com>
 <39eb6b408e7f060ab241954102d06f97d1f99611.camel@linux.ibm.com>
 <20200818183603.GC1152540@nvidia.com>
 <14eaf21a808e333ca414c954d8f3a2f7b6dbf2ca.camel@linux.ibm.com>
 <20200819120238.GD1152540@nvidia.com>
 <59f983156fed466d568c324de72ef733c1a15d76.camel@linux.ibm.com>
 <20200819140943.GH1152540@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200819140943.GH1152540@nvidia.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Wed, Aug 19, 2020 at 11:09:43AM -0300, Jason Gunthorpe wrote:
> On Wed, Aug 19, 2020 at 09:27:33AM -0400, Mimi Zohar wrote:
> > On Wed, 2020-08-19 at 09:02 -0300, Jason Gunthorpe wrote:
> > > On Tue, Aug 18, 2020 at 02:55:50PM -0400, Mimi Zohar wrote:
> > > 
> > > > The problem is that there isn't just one single userspace library or
> > > > application for reading PCRs.  So now not only is there the kernel
> > > > "boot_aggregate" regression testing, but regression testing of the tool
> > > > itself to support multiple methods of reading the PCRs.
> > > 
> > > I was thinking just open code 
> > >   open("/dev/tpm")
> > >   write(read_pcrs_cmd)
> > >   read(read_pcrs_cmd)
> > >  
> > > It isn't particularly hard to retrive the PCRs, don't really need to
> > > depend on a library.
> > 
> > Ok, do you want to contribute it to ima-evm-utils?  While you're at it,
> > do you also have code to parse the TPM 2.0 event log that you could
> > contribute?
> > 
> > Seriously, we shouldn't be (re-)writing code to do this.
> 
> The kernel should not be used a dumping ground to work around a
> dysfunctional userspace either. :(
> 
> You've basicaly said you can't rely on a sane userspace library
> because *reasons* so we need to dump stuff in the kernel instead.
> 
> It is not a good justification to add new uAPI.
> 
> James seems to have the same basic conclusion too, unfortunately.

It seems to me the point is that we often want to do these things in
very early and/or stripped-down userspaces.

I'm definately also in favor of having sysfs provide these.
