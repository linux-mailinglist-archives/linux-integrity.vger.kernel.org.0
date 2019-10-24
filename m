Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E7864E39AE
	for <lists+linux-integrity@lfdr.de>; Thu, 24 Oct 2019 19:20:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2440000AbfJXRU2 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 24 Oct 2019 13:20:28 -0400
Received: from mga14.intel.com ([192.55.52.115]:40506 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727036AbfJXRU2 (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 24 Oct 2019 13:20:28 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 24 Oct 2019 10:20:25 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.68,225,1569308400"; 
   d="scan'208";a="399837335"
Received: from nesterov-mobl1.ccr.corp.intel.com (HELO localhost) ([10.252.8.153])
  by fmsmga006.fm.intel.com with ESMTP; 24 Oct 2019 10:20:24 -0700
Date:   Thu, 24 Oct 2019 20:20:23 +0300
From:   Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To:     Petr Vorel <pvorel@suse.cz>
Cc:     Nayna <nayna@linux.vnet.ibm.com>, Mimi Zohar <zohar@linux.ibm.com>,
        linux-integrity <linux-integrity@vger.kernel.org>,
        ltp@lists.linux.it,
        Piotr =?iso-8859-1?Q?Kr=F3l?= <piotr.krol@3mdeb.com>,
        Peter Huewe <peterhuewe@gmx.de>, Jason Gunthorpe <jgg@ziepe.ca>
Subject: Re: [LTP] [PATCH] ima: skip verifying TPM 2.0 PCR values
Message-ID: <20191024172023.GA7948@linux.intel.com>
References: <1558041162.3971.2.camel@linux.ibm.com>
 <fccc3abd-f3ce-fdb1-55d7-c18ce116446c@linux.vnet.ibm.com>
 <20190517150456.GA11796@dell5510>
 <20191024121848.GA5908@dell5510>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191024121848.GA5908@dell5510>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Thu, Oct 24, 2019 at 02:18:48PM +0200, Petr Vorel wrote:
> Hi all,
> 
> I wonder what to do with this patch "ima: skip verifying TPM 2.0 PCR values" [1].
> Is it a correct way to differentiate between TPM 1.2 and TPM 2.0?
> Or something else should be applied?
> 
> How is the work on TPM 2.0 Linux sysfs interface?
> But even it's done in near future, we'd still need some way for older kernels.
> 
> Kind regards,
> Petr
> 
> [1] https://patchwork.ozlabs.org/patch/1100733/

version_major sysfs file would be acceptable if someone wants to proceed
and send such patch.

Also replicants for durations and timeouts files would make sense for
TPM 2.0.

/Jarkko
