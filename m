Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 532001B3120
	for <lists+linux-integrity@lfdr.de>; Tue, 21 Apr 2020 22:25:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726050AbgDUUZX (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 21 Apr 2020 16:25:23 -0400
Received: from mga02.intel.com ([134.134.136.20]:24584 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725930AbgDUUZX (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 21 Apr 2020 16:25:23 -0400
IronPort-SDR: wZvBX/QUL3ag9cfwW5FiVpJdfRbkvDdp2L8rhhmjJeTS/blngDWjr+Qtss58dktDJMshpli1fP
 bsAm+FlTN2Bg==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Apr 2020 13:25:22 -0700
IronPort-SDR: WOGUGKT4+Iqbi0O4JIFGwGUrQuOtBhBeBY8gl6IhkS9Q33LF9oFsK1ovOJJHfGqaYLPqgbAKV6
 5U5BXr5jTDpA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,411,1580803200"; 
   d="scan'208";a="245778923"
Received: from mnchalux-mobl2.gar.corp.intel.com (HELO localhost) ([10.252.44.234])
  by fmsmga007.fm.intel.com with ESMTP; 21 Apr 2020 13:25:20 -0700
Date:   Tue, 21 Apr 2020 23:25:20 +0300
From:   Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To:     Mimi Zohar <zohar@linux.ibm.com>
Cc:     James Bottomley <James.Bottomley@HansenPartnership.com>,
        Omar Sandoval <osandov@osandov.com>,
        Peter Huewe <peterhuewe@gmx.de>,
        Jason Gunthorpe <jgg@ziepe.ca>, linux-integrity@vger.kernel.org
Subject: Re: [PATCH] tpm_tis: work around status register bug in
 STMicroelectronics TPM
Message-ID: <20200421202520.GD46589@linux.intel.com>
References: <6c55d7c1fb84e5bf2ace9f05ec816ef67bd873e1.1586990595.git.osandov@fb.com>
 <1586994699.3931.18.camel@HansenPartnership.com>
 <20200416001605.GA673482@vader>
 <20200416002442.GB673482@vader>
 <1587060171.15329.7.camel@HansenPartnership.com>
 <20200417235527.GB85230@linux.intel.com>
 <1587168748.5867.2.camel@HansenPartnership.com>
 <20200420204641.GA14637@linux.intel.com>
 <1587421686.3493.2.camel@HansenPartnership.com>
 <1587479764.5149.27.camel@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1587479764.5149.27.camel@linux.ibm.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Tue, Apr 21, 2020 at 10:36:04AM -0400, Mimi Zohar wrote:
> On Mon, 2020-04-20 at 15:28 -0700, James Bottomley wrote:
> > On Mon, 2020-04-20 at 23:46 +0300, Jarkko Sakkinen wrote:
> 
> <snip>
> 
> > But more seriously: Nayna Jain did a series of patches improving the
> > time it takes to poll the TPM for operations precisely because the TPM
> > PCR extend was going so slowly:
> > 
> > https://lore.kernel.org/linux-integrity/20180516055125.5685-1-nayna@linux.vnet.ibm.com/
> 
> The original reason for us needing to improve the TPM performance was
> due to the kernel scheduler change.  Refer to commit a233a0289cf9
> ("tpm: msleep() delays - replace with usleep_range() in i2c nuvoton
> driver").  That scheduler change prevented systems from booting.
>  Bisecting the kernel to figure out the problem wasn't very
> productive.
> 
> At least any TPM changes that affect the TPM performance really need
> to take into account IMA requirements.

Thanks Mimi.

With my dynamic proposal it would work as it works now for system
where it worked anyway, and would fix the systems where timeouts
were too short.

/Jarkko
