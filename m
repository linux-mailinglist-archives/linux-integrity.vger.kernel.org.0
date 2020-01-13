Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7B2BF138909
	for <lists+linux-integrity@lfdr.de>; Mon, 13 Jan 2020 01:08:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387519AbgAMAI2 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Sun, 12 Jan 2020 19:08:28 -0500
Received: from mga11.intel.com ([192.55.52.93]:52692 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387460AbgAMAI2 (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Sun, 12 Jan 2020 19:08:28 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 12 Jan 2020 16:08:27 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,426,1571727600"; 
   d="scan'208";a="247554545"
Received: from akurtz1-mobl.ger.corp.intel.com (HELO localhost) ([10.252.10.99])
  by fmsmga004.fm.intel.com with ESMTP; 12 Jan 2020 16:08:25 -0800
Date:   Mon, 13 Jan 2020 02:08:24 +0200
From:   Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To:     linux-kernel@vger.kernel.org, Mimi Zohar <zohar@linux.ibm.com>,
        Peter Huewe <peterhuewe@gmx.de>,
        Jason Gunthorpe <jgg@ziepe.ca>, linux-integrity@vger.kernel.org
Subject: Re: [PATCH v4] tpm: Add tpm_version_major sysfs file
Message-ID: <20200113000824.GC16145@linux.intel.com>
References: <20191030225843.23366-1-jsnitsel@redhat.com>
 <20191128010826.w4ixlix3s3ovta3m@cantor>
 <20191129235131.GA21546@linux.intel.com>
 <20200109214935.ud7p7uwjimilxvi7@cantor>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200109214935.ud7p7uwjimilxvi7@cantor>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Thu, Jan 09, 2020 at 02:49:35PM -0700, Jerry Snitselaar wrote:
> On Sat Nov 30 19, Jarkko Sakkinen wrote:
> > On Wed, Nov 27, 2019 at 06:08:26PM -0700, Jerry Snitselaar wrote:
> > > On Wed Oct 30 19, Jerry Snitselaar wrote:
> > > > Easily determining what TCG version a tpm device implements
> > > > has been a pain point for userspace for a long time, so
> > > > add a sysfs file to report the TCG major version of a tpm device.
> > > >
> > > > Also add an entry to Documentation/ABI/stable/sysfs-class-tpm
> > > > describing the new file.
> > > >
> > > > Cc: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
> > > > Cc: Mimi Zohar <zohar@linux.ibm.com>
> > > > Cc: Peter Huewe <peterhuewe@gmx.de>
> > > > Cc: Jason Gunthorpe <jgg@ziepe.ca>
> > > > Cc: linux-integrity@vger.kernel.org
> > > > Signed-off-by: Jerry Snitselaar <jsnitsel@redhat.com>
> > > > ---
> > > > v4: - Change file name to tpm_version_major
> > > >    - Actually display just the major version.
> > > >    - change structs to tpm1_* & tpm2_*
> > > >      instead of tpm12_* tpm20_*.
> > > > v3: - Change file name to version_major.
> > > > v2: - Fix TCG usage in commit message.
> > > >    - Add entry to sysfs-class-tpm in Documentation/ABI/stable
> > > >
> > > > Documentation/ABI/stable/sysfs-class-tpm | 11 ++++++++
> > > > drivers/char/tpm/tpm-sysfs.c             | 34 +++++++++++++++++++-----
> > > > 2 files changed, 38 insertions(+), 7 deletions(-)
> > > >
> > > 
> > > Anyone else have feedback?
> > 
> > I can apply this after the issues on hand have been sorted out.
> > 
> > /Jarkko
> > 
> 
> Hi Jarkko,
> 
> Will this get queued up for 5.6?

Thanks for reminding and apologies for forgetting this!

I'll see what I can do.

/Jarkko
