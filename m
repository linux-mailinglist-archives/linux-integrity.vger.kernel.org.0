Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5ABC6E3BE2
	for <lists+linux-integrity@lfdr.de>; Thu, 24 Oct 2019 21:14:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392926AbfJXTOH (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 24 Oct 2019 15:14:07 -0400
Received: from mga09.intel.com ([134.134.136.24]:63210 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2392923AbfJXTOG (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 24 Oct 2019 15:14:06 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga102.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 24 Oct 2019 12:14:06 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.68,225,1569308400"; 
   d="scan'208";a="399871937"
Received: from nesterov-mobl1.ccr.corp.intel.com (HELO localhost) ([10.252.8.153])
  by fmsmga006.fm.intel.com with ESMTP; 24 Oct 2019 12:14:02 -0700
Date:   Thu, 24 Oct 2019 22:14:02 +0300
From:   Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To:     Jason Gunthorpe <jgg@ziepe.ca>
Cc:     Petr Vorel <pvorel@suse.cz>, Nayna <nayna@linux.vnet.ibm.com>,
        Mimi Zohar <zohar@linux.ibm.com>,
        linux-integrity <linux-integrity@vger.kernel.org>,
        ltp@lists.linux.it,
        Piotr =?iso-8859-1?Q?Kr=F3l?= <piotr.krol@3mdeb.com>,
        Peter Huewe <peterhuewe@gmx.de>
Subject: Re: [LTP] [PATCH] ima: skip verifying TPM 2.0 PCR values
Message-ID: <20191024191402.GB12038@linux.intel.com>
References: <1558041162.3971.2.camel@linux.ibm.com>
 <fccc3abd-f3ce-fdb1-55d7-c18ce116446c@linux.vnet.ibm.com>
 <20190517150456.GA11796@dell5510>
 <20191024121848.GA5908@dell5510>
 <20191024172023.GA7948@linux.intel.com>
 <20191024182005.GZ23952@ziepe.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191024182005.GZ23952@ziepe.ca>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Thu, Oct 24, 2019 at 03:20:05PM -0300, Jason Gunthorpe wrote:
> On Thu, Oct 24, 2019 at 08:20:23PM +0300, Jarkko Sakkinen wrote:
> > Also replicants for durations and timeouts files would make sense for
> > TPM 2.0.
> 
> These ones don't meet the sysfs standard of one value per file, which
> is why they didn't make it to tpm2

They would be still useful to have available in some form as there is
no way deduce them from the user space.

I'd prioritize in this particular case the compatibility with the legacy
files over sysfs standard with a clear note in the commit message.

/Jarkko
