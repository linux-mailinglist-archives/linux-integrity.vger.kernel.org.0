Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 582EEABF12
	for <lists+linux-integrity@lfdr.de>; Fri,  6 Sep 2019 19:59:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730957AbfIFR7V (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 6 Sep 2019 13:59:21 -0400
Received: from mail.hallyn.com ([178.63.66.53]:60844 "EHLO mail.hallyn.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730881AbfIFR7V (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 6 Sep 2019 13:59:21 -0400
X-Greylist: delayed 367 seconds by postgrey-1.27 at vger.kernel.org; Fri, 06 Sep 2019 13:59:20 EDT
Received: by mail.hallyn.com (Postfix, from userid 1001)
        id A50461042; Fri,  6 Sep 2019 12:53:12 -0500 (CDT)
Date:   Fri, 6 Sep 2019 12:53:12 -0500
From:   "Serge E. Hallyn" <serge@hallyn.com>
To:     Jason Gunthorpe <jgg@ziepe.ca>
Cc:     Mimi Zohar <zohar@linux.ibm.com>,
        Jordan Hand <jorhand@linux.microsoft.com>,
        Tadeusz Struk <tadeusz.struk@intel.com>,
        Piotr =?iso-8859-1?Q?Kr=F3l?= <piotr.krol@3mdeb.com>,
        linux-integrity@vger.kernel.org,
        Alexey Dobriyan <adobriyan@gmail.com>
Subject: Re: TPM 2.0 Linux sysfs interface
Message-ID: <20190906175312.GA14535@mail.hallyn.com>
References: <f7e1f25a-8b2d-1e0e-e784-0908161c3c99@intel.com>
 <20190902192632.GB5393@ziepe.ca>
 <1567460118.10024.316.camel@linux.ibm.com>
 <20190903055523.GA4500@ziepe.ca>
 <bc9ab35e-997c-b107-3073-d5150de063d0@intel.com>
 <fe908209-3752-19b2-2652-79fb75f69e2b@linux.microsoft.com>
 <1567553383.4937.29.camel@linux.ibm.com>
 <20190904055829.GA3936@ziepe.ca>
 <1567596658.4937.40.camel@linux.ibm.com>
 <20190904194348.GA3757@ziepe.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190904194348.GA3757@ziepe.ca>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Wed, Sep 04, 2019 at 04:43:48PM -0300, Jason Gunthorpe wrote:
> On Wed, Sep 04, 2019 at 07:30:58AM -0400, Mimi Zohar wrote:
> > On Wed, 2019-09-04 at 02:58 -0300, Jason Gunthorpe wrote:
> > > On Tue, Sep 03, 2019 at 07:29:43PM -0400, Mimi Zohar wrote:
> > > 
> > > > This discussion is going around in circles.  There are enough people
> > > > asking that the kernel provide at least the TPM version (eg. TPM 1.2
> > > > or TPM 2.0).  Userspace applications/regression tests shouldn't have
> > > > to figure out the TPM version by sending a TPM command and seeing if
> > > > it fails.  That really isn't asking a lot.
> > > 
> > > A single version number could be appropriate for sysfs
> > >  
> > > > I would also prefer not having to be dependent on a userspace
> > > > application to read the TPM PCRs in order to verify the IMA
> > > > measurement list.
> > > 
> > > Why?
> > 
> > Being dependent on a userspace application implies a level of trust,
> > that might not be warranted, depending on the system's
> > configuration.
> 
> Surely if you can trust 'cat' you can trust something that does ioctl?

Being dependent on a userspace application also means more to stuff into
an initramfs if you want to do this during dracut early boot.
