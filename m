Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A697BCAE21
	for <lists+linux-integrity@lfdr.de>; Thu,  3 Oct 2019 20:26:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730869AbfJCS0v (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 3 Oct 2019 14:26:51 -0400
Received: from mga12.intel.com ([192.55.52.136]:12625 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729199AbfJCS0v (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 3 Oct 2019 14:26:51 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 03 Oct 2019 11:26:50 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.67,253,1566889200"; 
   d="scan'208";a="275795994"
Received: from okiselev-mobl1.ccr.corp.intel.com (HELO localhost) ([10.251.93.117])
  by orsmga001.jf.intel.com with ESMTP; 03 Oct 2019 11:26:46 -0700
Date:   Thu, 3 Oct 2019 21:26:44 +0300
From:   Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To:     Mimi Zohar <zohar@linux.ibm.com>
Cc:     James Bottomley <James.Bottomley@HansenPartnership.com>,
        linux-integrity@vger.kernel.org,
        Jerry Snitselaar <jsnitsel@redhat.com>,
        Sumit Garg <sumit.garg@linaro.org>,
        Stefan Berger <stefanb@linux.vnet.ibm.com>,
        Peter Huewe <peterhuewe@gmx.de>,
        Jason Gunthorpe <jgg@ziepe.ca>, Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] tpm: Detach page allocation from tpm_buf
Message-ID: <20191003182644.GA20683@linux.intel.com>
References: <20190925134842.19305-1-jarkko.sakkinen@linux.intel.com>
 <1569420226.3642.24.camel@HansenPartnership.com>
 <20190927130657.GA5556@linux.intel.com>
 <1570020105.4999.106.camel@linux.ibm.com>
 <20191003113506.GE8933@linux.intel.com>
 <1570107054.4421.174.camel@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1570107054.4421.174.camel@linux.ibm.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Thu, Oct 03, 2019 at 08:50:54AM -0400, Mimi Zohar wrote:
> On Thu, 2019-10-03 at 14:35 +0300, Jarkko Sakkinen wrote:
> > On Wed, Oct 02, 2019 at 08:41:45AM -0400, Mimi Zohar wrote:
> > > On Fri, 2019-09-27 at 16:06 +0300, Jarkko Sakkinen wrote:
> > > > On Wed, Sep 25, 2019 at 10:03:46AM -0400, James Bottomley wrote:
> > > > > On Wed, 2019-09-25 at 16:48 +0300, Jarkko Sakkinen wrote:
> > > > > [...]
> > > > > > +	data_page = alloc_page(GFP_HIGHUSER);
> > > > > > +	if (!data_page)
> > > > > > +		return -ENOMEM;
> > > > > > +
> > > > > > +	data_ptr = kmap(data_page);
> > > > > 
> > > > > I don't think this is such a good idea.  On 64 bit it's no different
> > > > > from GFP_KERNEL and on 32 bit where we do have highmem, kmap space is
> > > > > at a premium, so doing a highmem allocation + kmap is more wasteful of
> > > > > resources than simply doing GFP_KERNEL.  In general, you should only do
> > > > > GFP_HIGHMEM if the page is going to be mostly used by userspace, which
> > > > > really isn't the case here.
> > > > 
> > > > Changing that in this commit would be wrong even if you are right.
> > > > After this commit has been applied it is somewhat easier to make
> > > > best choices for allocation in each call site (probably most will
> > > > end up using stack).
> > > 
> > > Agreed, but it could be a separate patch, prior to this one.  Why
> > > duplicate the problem all over only to change it later?
> > 
> > What problem exactly it is duplicating? The existing allocation
> > scheme here works correctly.
> 
> In the current code "alloc_page(GFP_HIGHUSER)" exists in a single
> function.  With this patch, "alloc_page(GFP_HIGHUSER)" is duplicated
> 24 times.  If it is incorrect and we shouldn't be using GFP_HIGHUSER,
> as James said, then why duplicate it 24 times?  Fix it as a separate
> patch first, that could be backported if needed, and then make the
> change.

Sorry I mixed this with Jerry's proposal :-) I can do that of course.

/Jarkko
