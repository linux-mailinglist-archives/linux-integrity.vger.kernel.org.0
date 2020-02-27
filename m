Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2B90A17233E
	for <lists+linux-integrity@lfdr.de>; Thu, 27 Feb 2020 17:25:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729987AbgB0QXn (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 27 Feb 2020 11:23:43 -0500
Received: from mga05.intel.com ([192.55.52.43]:19249 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729447AbgB0QXn (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 27 Feb 2020 11:23:43 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 27 Feb 2020 08:23:42 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,492,1574150400"; 
   d="scan'208";a="317834296"
Received: from mchodson-mobl.ger.corp.intel.com (HELO localhost) ([10.252.26.84])
  by orsmga001.jf.intel.com with ESMTP; 27 Feb 2020 08:23:40 -0800
Date:   Thu, 27 Feb 2020 18:23:39 +0200
From:   Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To:     George Wilson <gcwilson@linux.ibm.com>
Cc:     linux-integrity@vger.kernel.org,
        Alexey Kardashevskiy <aik@ozlabs.ru>,
        Stefan Berger <stefanb@linux.ibm.com>,
        Nayna Jain <nayna@linux.vnet.ibm.com>,
        Jason Gunthorpe <jgg@ziepe.ca>, linux-kernel@vger.kernel.org,
        Linh Pham <phaml@us.ibm.com>
Subject: Re: [PATCH] tpm: ibmvtpm: retry on H_CLOSED in tpm_ibmvtpm_send()
Message-ID: <20200227162339.GF5140@linux.intel.com>
References: <20200227155003.592321-1-gcwilson@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200227155003.592321-1-gcwilson@linux.ibm.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Thu, Feb 27, 2020 at 10:50:03AM -0500, George Wilson wrote:
> tpm_ibmvtpm_send() can fail during LPM resume with an H_CLOSED return
> from ibmvtpm_send_crq().  The PAPR says, 'The “partner partition
> suspended” transport event disables the associated CRQ such that any
> H_SEND_CRQ hcall() to the associated CRQ returns H_Closed until the CRQ
> has been explicitly enabled using the H_ENABLE_CRQ hcall.' This patch
> adds a check in tpm_ibmvtpm_send() for an H_CLOSED return from
> ibmvtpm_send_crq() and in that case calls tpm_ibmvtpm_resume() and
> retries the ibmvtpm_send_crq() once.
> 
> Reported-by: Linh Pham <phaml@us.ibm.com>
> Reviewed-by: Stefan Berger <stefanb@linux.ibm.com>
> Signed-off-by: George Wilson <gcwilson@linux.ibm.com>

What is LPM anyway?

/Jarkko
