Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BA394CC33A
	for <lists+linux-integrity@lfdr.de>; Fri,  4 Oct 2019 21:01:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726119AbfJDTBL (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 4 Oct 2019 15:01:11 -0400
Received: from mga02.intel.com ([134.134.136.20]:60581 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725932AbfJDTBK (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 4 Oct 2019 15:01:10 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 04 Oct 2019 12:01:09 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.67,257,1566889200"; 
   d="scan'208";a="191673088"
Received: from nzaki1-mobl1.ger.corp.intel.com (HELO localhost) ([10.252.4.57])
  by fmsmga008.fm.intel.com with ESMTP; 04 Oct 2019 12:01:05 -0700
Date:   Fri, 4 Oct 2019 22:01:04 +0300
From:   Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To:     James Bottomley <James.Bottomley@HansenPartnership.com>
Cc:     linux-integrity@vger.kernel.org, Mimi Zohar <zohar@linux.ibm.com>,
        Jerry Snitselaar <jsnitsel@redhat.com>,
        Sumit Garg <sumit.garg@linaro.org>,
        Stefan Berger <stefanb@linux.vnet.ibm.com>,
        Peter Huewe <peterhuewe@gmx.de>,
        Jason Gunthorpe <jgg@ziepe.ca>, Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 2/2] tpm: Detach page allocation from tpm_buf
Message-ID: <20191004190104.GK6945@linux.intel.com>
References: <20191003185103.26347-1-jarkko.sakkinen@linux.intel.com>
 <20191003185103.26347-3-jarkko.sakkinen@linux.intel.com>
 <1570207062.3563.17.camel@HansenPartnership.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1570207062.3563.17.camel@HansenPartnership.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Fri, Oct 04, 2019 at 09:37:42AM -0700, James Bottomley wrote:
> On Thu, 2019-10-03 at 21:51 +0300, Jarkko Sakkinen wrote:
> > As has been seen recently, binding the buffer allocation and tpm_buf
> > together is sometimes far from optimal.
> 
> Can you elaborate on this a bit more?  I must have missed the
> discussion.
> 
> >  The buffer might come from the caller namely when tpm_send() is used
> > by another subsystem. In addition we can stability in call sites w/o
> > rollback (e.g. power events)>
> > 
> > Take allocation out of the tpm_buf framework and make it purely a
> > wrapper for the data buffer.
> 
> What you're doing here is taking a single object with a single lifetime
> and creating two separate objects with separate lifetimes and a
> dependency.  The problem with doing that is that it always creates
> subtle and hard to debug corner cases where the dependency gets
> violated, so it's usually better to simplify the object lifetimes by
> reducing the dependencies and combining as many dependent objects as
> possible into a single object with one lifetime.  Bucking this trend
> for a good reason is OK, but I think a better reason than "is sometimes
> far from optimal" is needed.

Right, I see your point. We can just say instead in a comment that
tpm_buf_init() is optional if you need to allocate the buffer and
do not provide your own.

Thanks for the remark. I have to agree with this.

/Jarkko
