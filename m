Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 36BB11FC405
	for <lists+linux-integrity@lfdr.de>; Wed, 17 Jun 2020 04:11:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726505AbgFQCKf (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 16 Jun 2020 22:10:35 -0400
Received: from mga05.intel.com ([192.55.52.43]:21806 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726497AbgFQCKe (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 16 Jun 2020 22:10:34 -0400
IronPort-SDR: mJN7DgKEG2bfJO+UfTG5XD7Zvi5Uv2BDjQbScyQl+AaqOb/rwPO3kruxuYqz4B9mbT+ZeG+lfM
 yR5Sb2A8tINg==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jun 2020 19:10:34 -0700
IronPort-SDR: VqD0Fhtskk40Ak5PFSjG+cgJ8ViO2CEjkERAxXZl3t9ylVOXKWm8RNtPDiguz7FzAfIaAH0U5h
 4eeOBKq51rqQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,520,1583222400"; 
   d="scan'208";a="291270683"
Received: from vchernon-mobl1.ccr.corp.intel.com (HELO localhost) ([10.252.50.149])
  by orsmga002.jf.intel.com with ESMTP; 16 Jun 2020 19:10:31 -0700
Date:   Wed, 17 Jun 2020 05:10:29 +0300
From:   Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To:     Vasily Averin <vvs@virtuozzo.com>
Cc:     linux-integrity@vger.kernel.org, Peter Huewe <peterhuewe@gmx.de>,
        Jason Gunthorpe <jgg@ziepe.ca>
Subject: Re: [PATCH] tpm_tis: extra chip->ops check on error path in
 tpm_tis_core_init
Message-ID: <20200617021029.GC7215@linux.intel.com>
References: <8d6e3656-1662-dc71-8876-c7f0f11a11b1@virtuozzo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8d6e3656-1662-dc71-8876-c7f0f11a11b1@virtuozzo.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Sat, Jun 13, 2020 at 05:18:33PM +0300, Vasily Averin wrote:
> Found by smatch:
> drivers/char/tpm/tpm_tis_core.c:1088 tpm_tis_core_init() warn:
>  variable dereferenced before check 'chip->ops' (see line 979)
> 
> 'chip->ops' is assigned in the beginning of function
> in tpmm_chip_alloc->tpm_chip_alloc
> and is used before first possible goto to error path.
> 
> Signed-off-by: Vasily Averin <vvs@virtuozzo.com>
 
Reviewed-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>

/Jarkko
