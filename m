Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1FE5D27DC83
	for <lists+linux-integrity@lfdr.de>; Wed, 30 Sep 2020 01:11:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728291AbgI2XLW (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 29 Sep 2020 19:11:22 -0400
Received: from mga12.intel.com ([192.55.52.136]:26381 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728223AbgI2XLW (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 29 Sep 2020 19:11:22 -0400
IronPort-SDR: 5tHYP3RA9xPF/MsMt0yJeg8QB8cugyQ5b9RUZwAbfDLIwHVsZ9KkGh/Aq0DSE0MsEGWBr/0def
 Pg+idrYYqKkw==
X-IronPort-AV: E=McAfee;i="6000,8403,9759"; a="141717544"
X-IronPort-AV: E=Sophos;i="5.77,320,1596524400"; 
   d="scan'208";a="141717544"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Sep 2020 16:11:21 -0700
IronPort-SDR: B4c9sdqzY0JVcPVwYExbSzR3fB09BzjPHQf1xyrbQZIHs0r4Oea6LtWS/8TZ2N3dvDv8djyahB
 OIzssPJ0l7vQ==
X-IronPort-AV: E=Sophos;i="5.77,320,1596524400"; 
   d="scan'208";a="494057606"
Received: from jwilliam-mobl.ger.corp.intel.com (HELO localhost) ([10.252.47.189])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Sep 2020 16:11:20 -0700
Date:   Wed, 30 Sep 2020 02:11:18 +0300
From:   Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To:     Petr Vorel <pvorel@suse.cz>
Cc:     ltp@lists.linux.it,
        Lakshmi Ramasubramanian <nramas@linux.microsoft.com>,
        Mimi Zohar <zohar@linux.vnet.ibm.com>,
        linux-integrity@vger.kernel.org
Subject: Re: [PATCH v3 0/4] TPM 2.0 fixes in IMA tests
Message-ID: <20200929231118.GA805493@linux.intel.com>
References: <20200929165021.11731-1-pvorel@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200929165021.11731-1-pvorel@suse.cz>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Tue, Sep 29, 2020 at 06:50:17PM +0200, Petr Vorel wrote:
> Hi,
> 
> few more fixes, mostly touching older kernels or evmctl versions.
> Changes in 3rd and 4th commit.
> 
> Kind regards,
> Petr
> 
> Petr Vorel (4):
>   IMA: Move get_algorithm_digest(), set_digest_index() to ima_setup.sh
>   IMA: Rewrite ima_boot_aggregate.c to new API
>   ima_tpm.sh: Fix calculating boot aggregate
>   ima_tpm.sh: Fix calculating PCR aggregate
> 
>  .../integrity/ima/src/ima_boot_aggregate.c    | 113 ++++----
>  .../integrity/ima/tests/ima_measurements.sh   |  62 +---
>  .../security/integrity/ima/tests/ima_setup.sh |  70 +++++
>  .../security/integrity/ima/tests/ima_tpm.sh   | 265 ++++++++++++++----
>  4 files changed, 341 insertions(+), 169 deletions(-)
> 
> -- 
> 2.28.0
> 

Hi, is there something specific I should look at in this patch set?

/Jarkko
