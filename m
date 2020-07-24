Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 64E0322BE60
	for <lists+linux-integrity@lfdr.de>; Fri, 24 Jul 2020 08:57:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726726AbgGXG5u (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 24 Jul 2020 02:57:50 -0400
Received: from mga09.intel.com ([134.134.136.24]:7082 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725942AbgGXG5u (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 24 Jul 2020 02:57:50 -0400
IronPort-SDR: c5KsgaJLH/jc7bKDikaBJBJC76siMKjOArWE2cvESGsmMr9jbcBH6pPVTmP4YRKeAu0i2bZB+W
 H0ekTYzkkYOw==
X-IronPort-AV: E=McAfee;i="6000,8403,9691"; a="151958771"
X-IronPort-AV: E=Sophos;i="5.75,389,1589266800"; 
   d="scan'208";a="151958771"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jul 2020 23:57:49 -0700
IronPort-SDR: pu6mwtDM5fGWZWY3XJ/EiMr0rhObOKWGFNs3qw/Qfpry/XeOWE/ZgF5LGC1Od0MGo2AtUmTuCi
 s4L6WXKyPyFQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,389,1589266800"; 
   d="scan'208";a="393230093"
Received: from cbuerkle-mobl1.ger.corp.intel.com (HELO localhost) ([10.249.36.184])
  by fmsmga001.fm.intel.com with ESMTP; 23 Jul 2020 23:57:47 -0700
Date:   Fri, 24 Jul 2020 09:57:45 +0300
From:   Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To:     James Bottomley <James.Bottomley@HansenPartnership.com>
Cc:     linux-integrity@vger.kernel.org, Mimi Zohar <zohar@linux.ibm.com>
Subject: Re: [PATCH v3 1/1] tpm: add sysfs exports for all banks of PCR
 registers
Message-ID: <20200724065745.GB1871046@linux.intel.com>
References: <20200722155739.26957-1-James.Bottomley@HansenPartnership.com>
 <20200722155739.26957-2-James.Bottomley@HansenPartnership.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200722155739.26957-2-James.Bottomley@HansenPartnership.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Wed, Jul 22, 2020 at 08:57:39AM -0700, James Bottomley wrote:
> use macro magic to create sysfs per hash groups with 24 PCR files in

'Use'

Please, just say what the patch does in plain English and dust the magic
away.

> them one for each possible agile hash of the TPM.  The files are
                                                   ~~

I'd prefer a single space.

> plugged in to a read function which is TPM version agnostic, so this
> works also for TPM 1.2 although the hash is only sha1 in that case.
> For every hash the TPM supports, a group named pcr-<hash> is created
> and each of the PCR read files placed under it.

Yeah, the commit message is missing the statement what it does and goes
straight away rationalizing "macro magic".

> Signed-off-by: James Bottomley <James.Bottomley@HansenPartnership.com>
> Reviewed-by: Jerry Snitselaar <jsnitsel@redhat.com>

/Jarkko
