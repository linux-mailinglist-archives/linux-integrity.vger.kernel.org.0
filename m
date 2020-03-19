Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 13F9918C0B8
	for <lists+linux-integrity@lfdr.de>; Thu, 19 Mar 2020 20:50:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726934AbgCSTuQ (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 19 Mar 2020 15:50:16 -0400
Received: from mga09.intel.com ([134.134.136.24]:56609 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725747AbgCSTuQ (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 19 Mar 2020 15:50:16 -0400
IronPort-SDR: hKfHissdjwBklOU32ObzkksMfw+FH9z1yKa0Ci4Mslf/qPnet8r/lz7PXbJfxAtHdUbZPHcb8O
 WvMxqxygJC8Q==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Mar 2020 12:50:15 -0700
IronPort-SDR: BYxoJ7jptfyU+TPIae5+d54PIcg3caerdEfPmOY8aOHzDUqK9S5WCGbr3R+pS29zweUNwyX2qA
 yLwsjb+mLcJA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,572,1574150400"; 
   d="scan'208";a="418466982"
Received: from oamor-mobl1.ger.corp.intel.com (HELO localhost) ([10.251.182.181])
  by orsmga005.jf.intel.com with ESMTP; 19 Mar 2020 12:50:12 -0700
Date:   Thu, 19 Mar 2020 21:50:11 +0200
From:   Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To:     George Wilson <gcwilson@linux.ibm.com>
Cc:     linux-integrity@vger.kernel.org,
        Alexey Kardashevskiy <aik@ozlabs.ru>,
        Stefan Berger <stefanb@linux.ibm.com>,
        Nayna Jain <nayna@linux.vnet.ibm.com>,
        Jason Gunthorpe <jgg@ziepe.ca>, linux-kernel@vger.kernel.org,
        Linh Pham <phaml@us.ibm.com>
Subject: Re: [PATCH v3] tpm: ibmvtpm: retry on H_CLOSED in tpm_ibmvtpm_send()
Message-ID: <20200319195011.GB24804@linux.intel.com>
References: <20200318234927.206075-1-gcwilson@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200318234927.206075-1-gcwilson@linux.ibm.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Wed, Mar 18, 2020 at 07:49:27PM -0400, George Wilson wrote:
> tpm_ibmvtpm_send() can fail during PowerVM Live Partition Mobility resume
> with an H_CLOSED return from ibmvtpm_send_crq().  The PAPR says, 'The
> “partner partition suspended” transport event disables the associated CRQ
> such that any H_SEND_CRQ hcall() to the associated CRQ returns H_Closed
> until the CRQ has been explicitly enabled using the H_ENABLE_CRQ hcall.'
> This patch adds a check in tpm_ibmvtpm_send() for an H_CLOSED return from
> ibmvtpm_send_crq() and in that case calls tpm_ibmvtpm_resume() and
> retries the ibmvtpm_send_crq() once.
> 
> Reported-by: Linh Pham <phaml@us.ibm.com>
> Reviewed-by: Stefan Berger <stefanb@linux.ibm.com>
> Signed-off-by: George Wilson <gcwilson@linux.ibm.com>
> Tested-by: Linh Pham <phaml@us.ibm.com>
> Fixes: 132f76294744 ("Add new device driver to support IBM vTPM")

Reviewed-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>

Thank you.

/Jarkko
