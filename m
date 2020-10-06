Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A73BF284F7C
	for <lists+linux-integrity@lfdr.de>; Tue,  6 Oct 2020 18:07:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725947AbgJFQHv (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 6 Oct 2020 12:07:51 -0400
Received: from mga05.intel.com ([192.55.52.43]:42114 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725946AbgJFQHv (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 6 Oct 2020 12:07:51 -0400
IronPort-SDR: xPWyJHW5barquar2g4BdHxgiVQUYSwIkIaSzhlBeX2jBjvWvN8ftRs4hSb8PGeXSJOEj/2gZNA
 NyA8D79j026g==
X-IronPort-AV: E=McAfee;i="6000,8403,9765"; a="249257749"
X-IronPort-AV: E=Sophos;i="5.77,343,1596524400"; 
   d="scan'208";a="249257749"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Oct 2020 08:55:15 -0700
IronPort-SDR: rS/c1tKmpb1DPRA1F/1fDDXf47avdGNwbd8cOpIwl8Xzm6sWkE3AEaqHkJcLfZL/quIVzbf8d4
 g070pU/l0eTQ==
X-IronPort-AV: E=Sophos;i="5.77,343,1596524400"; 
   d="scan'208";a="460856662"
Received: from thijsmet-mobl.ger.corp.intel.com (HELO localhost) ([10.249.34.36])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Oct 2020 08:55:14 -0700
Date:   Tue, 6 Oct 2020 18:55:05 +0300
From:   Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To:     Petr Vorel <pvorel@suse.cz>
Cc:     Lakshmi Ramasubramanian <nramas@linux.microsoft.com>,
        Mimi Zohar <zohar@linux.vnet.ibm.com>,
        linux-integrity@vger.kernel.org
Subject: Re: [PATCH v3 0/4] TPM 2.0 fixes in IMA tests
Message-ID: <20201006155505.GB111447@linux.intel.com>
References: <20200929165021.11731-1-pvorel@suse.cz>
 <20200929231118.GA805493@linux.intel.com>
 <20200930055314.GA21664@dell5510>
 <20200930115939.GB7612@linux.intel.com>
 <20201001120125.GE32109@dell5510>
 <20201001183104.GA15664@linux.intel.com>
 <20201006100130.GA14868@dell5510>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201006100130.GA14868@dell5510>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Tue, Oct 06, 2020 at 12:01:30PM +0200, Petr Vorel wrote:
> If I understand James's commit fdc915f7f719 ("tpm: expose spaces via a device link /dev/tpmrm<n>")
> from v4.12-rc1 correctly /dev/tpmrm0 is really for TPM 2.0. But how to detect it
> for v4.0 - v4.11 when /sys/class/tpm detection fails?

I'd send an idempotent TPM2 command to /dev/tpm0. I.e. if it works,
it does not change the state. If it doesn't, you know that it is
not TPM2 device.

See the kernel function tpm2_probe() as an example of this approach.

/Jarkko
