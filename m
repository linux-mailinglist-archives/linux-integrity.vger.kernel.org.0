Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8D503E7A83
	for <lists+linux-integrity@lfdr.de>; Mon, 28 Oct 2019 21:51:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388402AbfJ1Uv2 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 28 Oct 2019 16:51:28 -0400
Received: from mga04.intel.com ([192.55.52.120]:49029 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725867AbfJ1Uv1 (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 28 Oct 2019 16:51:27 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga104.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 28 Oct 2019 13:51:26 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.68,241,1569308400"; 
   d="scan'208";a="210955246"
Received: from shrehore-mobl1.ti.intel.com (HELO localhost) ([10.251.82.5])
  by fmsmga001.fm.intel.com with ESMTP; 28 Oct 2019 13:51:23 -0700
Date:   Mon, 28 Oct 2019 22:51:22 +0200
From:   Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To:     Jason Gunthorpe <jgg@ziepe.ca>
Cc:     Petr Vorel <pvorel@suse.cz>, Nayna <nayna@linux.vnet.ibm.com>,
        Mimi Zohar <zohar@linux.ibm.com>,
        linux-integrity <linux-integrity@vger.kernel.org>,
        ltp@lists.linux.it,
        Piotr =?iso-8859-1?Q?Kr=F3l?= <piotr.krol@3mdeb.com>,
        Peter Huewe <peterhuewe@gmx.de>
Subject: Re: [LTP] [PATCH] ima: skip verifying TPM 2.0 PCR values
Message-ID: <20191028205122.GG8279@linux.intel.com>
References: <1558041162.3971.2.camel@linux.ibm.com>
 <fccc3abd-f3ce-fdb1-55d7-c18ce116446c@linux.vnet.ibm.com>
 <20190517150456.GA11796@dell5510>
 <20191024121848.GA5908@dell5510>
 <20191024172023.GA7948@linux.intel.com>
 <20191024182005.GZ23952@ziepe.ca>
 <20191024191402.GB12038@linux.intel.com>
 <20191024233602.GF23952@ziepe.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191024233602.GF23952@ziepe.ca>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Thu, Oct 24, 2019 at 08:36:02PM -0300, Jason Gunthorpe wrote:
> On Thu, Oct 24, 2019 at 10:14:02PM +0300, Jarkko Sakkinen wrote:
> > On Thu, Oct 24, 2019 at 03:20:05PM -0300, Jason Gunthorpe wrote:
> > > On Thu, Oct 24, 2019 at 08:20:23PM +0300, Jarkko Sakkinen wrote:
> > > > Also replicants for durations and timeouts files would make sense for
> > > > TPM 2.0.
> > > 
> > > These ones don't meet the sysfs standard of one value per file, which
> > > is why they didn't make it to tpm2
> > 
> > They would be still useful to have available in some form as there is
> > no way deduce them from the user space.
> 
> Why? Userspace doesn't refer to these values since the kernel handles
> all the timeouts, right?

For debugging at least would be definitely a nice to have what
values the driver ended up setting.

/Jarkko
