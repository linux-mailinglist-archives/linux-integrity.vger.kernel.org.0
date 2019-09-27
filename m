Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8705FC08CE
	for <lists+linux-integrity@lfdr.de>; Fri, 27 Sep 2019 17:43:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727866AbfI0PnL (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 27 Sep 2019 11:43:11 -0400
Received: from mga03.intel.com ([134.134.136.65]:2799 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727207AbfI0PnL (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 27 Sep 2019 11:43:11 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 27 Sep 2019 08:43:10 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,556,1559545200"; 
   d="scan'208";a="214871594"
Received: from mdauner2-mobl2.ger.corp.intel.com (HELO localhost) ([10.249.39.118])
  by fmsmga004.fm.intel.com with ESMTP; 27 Sep 2019 08:42:46 -0700
Date:   Fri, 27 Sep 2019 18:42:45 +0300
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
Message-ID: <20190927154245.GG10545@linux.intel.com>
References: <20190926172324.3405-1-jarkko.sakkinen@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190926172324.3405-1-jarkko.sakkinen@linux.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Thu, Sep 26, 2019 at 08:23:24PM +0300, Jarkko Sakkinen wrote:
> As has been seen recently, binding the buffer allocation and tpm_buf
> together is sometimes far from optimal. The buffer might come from the
> caller namely when tpm_send() is used by another subsystem. In addition we
> can stability in call sites w/o rollback (e.g. power events)>
> 
> Take allocation out of the tpm_buf framework and make it purely a wrapper
> for the data buffer.
> 
> Link: https://patchwork.kernel.org/patch/11146585/
> Cc: Mimi Zohar <zohar@linux.ibm.com>
> Cc: Jerry Snitselaar <jsnitsel@redhat.com>
> Cc: James Bottomley <James.Bottomley@HansenPartnership.com>
> Cc: Sumit Garg <sumit.garg@linaro.org>
> Cc: Stefan Berger <stefanb@linux.vnet.ibm.com>
> Signed-off-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
> ---
> v2:
> * In tpm2_get_random(), TPM2_CC_GET_RANDOM was accidently switch to
>   TPM2_CC_PCR_EXTEND. Now it has been switched back.
Forgot --subject-prefix="PATCH v2".

/Jarkko
