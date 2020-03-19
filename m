Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E633818C0DD
	for <lists+linux-integrity@lfdr.de>; Thu, 19 Mar 2020 20:55:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725787AbgCSTzJ (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 19 Mar 2020 15:55:09 -0400
Received: from mga01.intel.com ([192.55.52.88]:56449 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725747AbgCSTzJ (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 19 Mar 2020 15:55:09 -0400
IronPort-SDR: HR7R7w28ssEecq4MNt8MIttR/pXL5nuxMO8CWOaGj2Umt1CrhNGeiVutvODeyRUhexLvTQe0jP
 AKLr22AUe9TQ==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Mar 2020 12:55:08 -0700
IronPort-SDR: chqlSejf0He0yBvfkA797q9TyWNMoteUr35AZKINcoOwAURNnbKVUEAndL+KYA5p0K6uo46lB3
 6g2kMYb/ZZ/A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,572,1574150400"; 
   d="scan'208";a="418467825"
Received: from oamor-mobl1.ger.corp.intel.com (HELO localhost) ([10.251.182.181])
  by orsmga005.jf.intel.com with ESMTP; 19 Mar 2020 12:55:05 -0700
Date:   Thu, 19 Mar 2020 21:55:03 +0200
From:   Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To:     George Wilson <gcwilson@linux.ibm.com>
Cc:     linux-integrity@vger.kernel.org,
        Alexey Kardashevskiy <aik@ozlabs.ru>,
        Stefan Berger <stefanb@linux.ibm.com>,
        Nayna Jain <nayna@linux.vnet.ibm.com>,
        Jason Gunthorpe <jgg@ziepe.ca>, linux-kernel@vger.kernel.org,
        Linh Pham <phaml@us.ibm.com>
Subject: Re: [PATCH v3] tpm: ibmvtpm: retry on H_CLOSED in tpm_ibmvtpm_send()
Message-ID: <20200319195503.GC24804@linux.intel.com>
References: <20200318234927.206075-1-gcwilson@linux.ibm.com>
 <20200319195011.GB24804@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200319195011.GB24804@linux.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Thu, Mar 19, 2020 at 09:50:16PM +0200, Jarkko Sakkinen wrote:
> On Wed, Mar 18, 2020 at 07:49:27PM -0400, George Wilson wrote:
> > tpm_ibmvtpm_send() can fail during PowerVM Live Partition Mobility resume
> > with an H_CLOSED return from ibmvtpm_send_crq().  The PAPR says, 'The
> > “partner partition suspended” transport event disables the associated CRQ
> > such that any H_SEND_CRQ hcall() to the associated CRQ returns H_Closed
> > until the CRQ has been explicitly enabled using the H_ENABLE_CRQ hcall.'
> > This patch adds a check in tpm_ibmvtpm_send() for an H_CLOSED return from
> > ibmvtpm_send_crq() and in that case calls tpm_ibmvtpm_resume() and
> > retries the ibmvtpm_send_crq() once.
> > 
> > Reported-by: Linh Pham <phaml@us.ibm.com>
> > Reviewed-by: Stefan Berger <stefanb@linux.ibm.com>
> > Signed-off-by: George Wilson <gcwilson@linux.ibm.com>
> > Tested-by: Linh Pham <phaml@us.ibm.com>
> > Fixes: 132f76294744 ("Add new device driver to support IBM vTPM")
> 
> Reviewed-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>

Unfortunately have to take that back because it has checkpatch
errors:

$ scripts/checkpatch.pl 0001-tpm-ibmvtpm-retry-on-H_CLOSED-in-tpm_ibmvtpm_send.patch
WARNING: Possible unwrapped commit description (prefer a maximum 75 chars per line)
#11:
“partner partition suspended” transport event disables the associated CRQ

WARNING: Prefer using '"%s...", __func__' to using 'ibmvtpm_crq_send_init', this function's name, in a string
#61: FILE: drivers/char/tpm/tpm_ibmvtpm.c:152:
+			"ibmvtpm_crq_send_init failed rc=%d\n", rc);

Also the fixes tag is incorrect. Should be:

Fixes: 132f76294744 ("drivers/char/tpm: Add new device driver to support IBM vTPM")

/Jarkko
