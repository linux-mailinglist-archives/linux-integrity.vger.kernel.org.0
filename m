Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9FEFD6609B
	for <lists+linux-integrity@lfdr.de>; Thu, 11 Jul 2019 22:28:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728413AbfGKU2e (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 11 Jul 2019 16:28:34 -0400
Received: from mga14.intel.com ([192.55.52.115]:13610 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728405AbfGKU2d (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 11 Jul 2019 16:28:33 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 11 Jul 2019 13:28:33 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.63,479,1557212400"; 
   d="scan'208";a="317789876"
Received: from mmoerth-mobl6.ger.corp.intel.com (HELO localhost) ([10.249.35.82])
  by orsmga004.jf.intel.com with ESMTP; 11 Jul 2019 13:28:25 -0700
Date:   Thu, 11 Jul 2019 23:28:24 +0300
From:   Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To:     Nayna Jain <nayna@linux.ibm.com>
Cc:     linux-integrity@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-kernel@vger.kernel.org, Jason Gunthorpe <jgg@ziepe.ca>,
        Sachin Sant <sachinp@linux.vnet.ibm.com>,
        George Wilson <gcwilson@linux.ibm.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Michal Suchanek <msuchanek@suse.de>,
        Peter Huewe <peterhuewe@gmx.de>,
        Mimi Zohar <zohar@linux.ibm.com>
Subject: Re: [PATCH v3] tpm: tpm_ibm_vtpm: Fix unallocated banks
Message-ID: <20190711202824.dfhzxcqtk5ouud5n@linux.intel.com>
References: <1562861615-11391-1-git-send-email-nayna@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1562861615-11391-1-git-send-email-nayna@linux.ibm.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: NeoMutt/20180716
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Thu, Jul 11, 2019 at 12:13:35PM -0400, Nayna Jain wrote:
> The nr_allocated_banks and allocated banks are initialized as part of
> tpm_chip_register. Currently, this is done as part of auto startup
> function. However, some drivers, like the ibm vtpm driver, do not run
> auto startup during initialization. This results in uninitialized memory
> issue and causes a kernel panic during boot.
> 
> This patch moves the pcr allocation outside the auto startup function
> into tpm_chip_register. This ensures that allocated banks are initialized
> in any case.
> 
> Fixes: 879b589210a9 ("tpm: retrieve digest size of unknown algorithms with
> PCR read")
> Reported-by: Michal Suchanek <msuchanek@suse.de>
> Signed-off-by: Nayna Jain <nayna@linux.ibm.com>
> Reviewed-by: Mimi Zohar <zohar@linux.ibm.com>
> Tested-by: Sachin Sant <sachinp@linux.vnet.ibm.com>
> Tested-by: Michal Suchánek <msuchanek@suse.de>

Reviewed-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>

/Jarkko
