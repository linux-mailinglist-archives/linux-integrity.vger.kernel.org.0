Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7FE1DBF3CC
	for <lists+linux-integrity@lfdr.de>; Thu, 26 Sep 2019 15:12:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726767AbfIZNMc (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 26 Sep 2019 09:12:32 -0400
Received: from mga01.intel.com ([192.55.52.88]:31304 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725836AbfIZNMc (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 26 Sep 2019 09:12:32 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 26 Sep 2019 06:12:31 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,552,1559545200"; 
   d="scan'208";a="341238010"
Received: from jsakkine-mobl1.tm.intel.com (HELO localhost) ([10.237.50.168])
  by orsmga004.jf.intel.com with ESMTP; 26 Sep 2019 06:12:27 -0700
Date:   Thu, 26 Sep 2019 16:12:27 +0300
From:   Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To:     linux-integrity@vger.kernel.org
Cc:     Mimi Zohar <zohar@linux.ibm.com>,
        Jerry Snitselaar <jsnitsel@redhat.com>,
        James Bottomley <James.Bottomley@HansenPartnership.com>,
        Sumit Garg <sumit.garg@linaro.org>,
        Stefan Berger <stefanb@linux.vnet.ibm.com>,
        Peter Huewe <peterhuewe@gmx.de>,
        Jason Gunthorpe <jgg@ziepe.ca>, Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] tpm: Detach page allocation from tpm_buf
Message-ID: <20190926131227.GA6582@linux.intel.com>
References: <20190925134842.19305-1-jarkko.sakkinen@linux.intel.com>
 <20190926124635.GA6040@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190926124635.GA6040@linux.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Thu, Sep 26, 2019 at 03:46:35PM +0300, Jarkko Sakkinen wrote:
> On Wed, Sep 25, 2019 at 04:48:41PM +0300, Jarkko Sakkinen wrote:
> > -		tpm_buf_reset(&buf, TPM2_ST_NO_SESSIONS, TPM2_CC_GET_RANDOM);
> > +		tpm_buf_reset(&buf, data_ptr, PAGE_SIZE,
> > +			      TPM2_ST_NO_SESSIONS, TPM2_CC_PCR_EXTEND);
> 
> Oops.

Maybe we could use random as the probe for TPM version since we anyway
send a TPM command as a probe for TPM version:

1. Try TPM2 get random.
2. If fail, try TPM1 get random.
3. Output random number to klog.

Something like 8 bytes would be sufficient. This would make sure that
no new change breaks tpm_get_random() and also this would give some
feedback that TPM is at least somewhat working.

/Jarkko
