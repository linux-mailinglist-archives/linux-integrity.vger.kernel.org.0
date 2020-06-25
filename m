Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 30AA620991F
	for <lists+linux-integrity@lfdr.de>; Thu, 25 Jun 2020 06:33:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726732AbgFYEdq (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 25 Jun 2020 00:33:46 -0400
Received: from mga07.intel.com ([134.134.136.100]:18134 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726400AbgFYEdq (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 25 Jun 2020 00:33:46 -0400
IronPort-SDR: jw8q1uFIaky7UEEoyY2xCm4fzHl+mnOMV0JItyhpNfJp507TcSWOcDhLDBKoY5c8SzXdrZ1Gy2
 5yj/y2M/HY0A==
X-IronPort-AV: E=McAfee;i="6000,8403,9662"; a="209882181"
X-IronPort-AV: E=Sophos;i="5.75,277,1589266800"; 
   d="scan'208";a="209882181"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jun 2020 21:33:45 -0700
IronPort-SDR: t5ceNEFFRaX3ndctuaOlqIxwjNG1sABH+ft7vt3s3t8UzFVTablnrxHm7SQuYSCccHwvF7Mfxs
 9BlP4NBSTvxw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,278,1589266800"; 
   d="scan'208";a="265253125"
Received: from skurzyno-mobl2.ger.corp.intel.com (HELO localhost) ([10.249.40.230])
  by fmsmga008.fm.intel.com with ESMTP; 24 Jun 2020 21:33:40 -0700
Date:   Thu, 25 Jun 2020 07:33:38 +0300
From:   Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To:     linux-integrity@vger.kernel.org
Cc:     James Bottomley <James.Bottomley@HansenPartnership.com>,
        Stefan Berger <stefanb@linux.ibm.com>,
        Peter Huewe <peterhuewe@gmx.de>,
        Jason Gunthorpe <jgg@ziepe.ca>, Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jerry Snitselaar <jsnitsel@redhat.com>,
        Sumit Garg <sumit.garg@linaro.org>,
        Alexey Klimov <aklimov@redhat.com>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] tpm: tpm2-space: Resize session and context buffers
 dynamically
Message-ID: <20200625043338.GA370462@linux.intel.com>
References: <20200625042424.370072-1-jarkko.sakkinen@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200625042424.370072-1-jarkko.sakkinen@linux.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Thu, Jun 25, 2020 at 07:24:20AM +0300, Jarkko Sakkinen wrote:
> Re-allocate context and session buffers when needed. Scale them in page
> increments so that the reallocation is only seldomly required, and thus
> causes minimal stress to the system. Add a static maximum limit of four
> pages for buffer sizes.
> 
> Cc: James Bottomley <James.Bottomley@HansenPartnership.com>
> Suggested-by: Stefan Berger <stefanb@linux.ibm.com>
> Signed-off-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>

I'd actually consider

#define TPM2_SPACE_DEFAULT_BUFFER_SIZE	PAGE_SIZE
#define TPM2_SPACE_MAX_BUFFER_SIZE	(4 * PAGE_SIZE)

/JQ4KKO
