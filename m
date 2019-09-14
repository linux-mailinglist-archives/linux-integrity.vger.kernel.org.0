Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C2CD5B2B51
	for <lists+linux-integrity@lfdr.de>; Sat, 14 Sep 2019 15:04:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388586AbfINNEr (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Sat, 14 Sep 2019 09:04:47 -0400
Received: from mga06.intel.com ([134.134.136.31]:18258 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388575AbfINNEr (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Sat, 14 Sep 2019 09:04:47 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 14 Sep 2019 06:04:46 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,492,1559545200"; 
   d="scan'208";a="188149021"
Received: from krusocki-mobl.ger.corp.intel.com (HELO localhost) ([10.252.40.34])
  by orsmga003.jf.intel.com with ESMTP; 14 Sep 2019 06:04:42 -0700
Date:   Sat, 14 Sep 2019 14:04:41 +0100
From:   Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To:     Roberto Sassu <roberto.sassu@huawei.com>
Cc:     zohar@linux.ibm.com, jsnitsel@redhat.com,
        linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org, keyrings@vger.kernel.org,
        linux-kernel@vger.kernel.org, silviu.vlasceanu@huawei.com
Subject: Re: [PATCH v4] KEYS: trusted: correctly initialize digests and fix
 locking issue
Message-ID: <20190914130441.GE9560@linux.intel.com>
References: <20190913185136.780-1-roberto.sassu@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190913185136.780-1-roberto.sassu@huawei.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Fri, Sep 13, 2019 at 08:51:36PM +0200, Roberto Sassu wrote:
> Commit 0b6cf6b97b7e ("tpm: pass an array of tpm_extend_digest structures to
> tpm_pcr_extend()") modifies tpm_pcr_extend() to accept a digest for each
> PCR bank. After modification, tpm_pcr_extend() expects that digests are
> passed in the same order as the algorithms set in chip->allocated_banks.
> 
> This patch fixes two issues introduced in the last iterations of the patch
> set: missing initialization of the TPM algorithm ID in the tpm_digest
> structures passed to tpm_pcr_extend() by the trusted key module, and
> unreleased locks in the TPM driver due to returning from tpm_pcr_extend()
> without calling tpm_put_ops().
> 
> Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>
> Suggested-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
> Reviewed-by: Jerry Snitselaar <jsnitsel@redhat.com>
> Fixes: 0b6cf6b97b7e ("tpm: pass an array of tpm_extend_digest structures to tpm_pcr_extend()")

Reviewed-by:  <jarkko.sakkinen@linux.intel.com>

I picked up this patch to my tree.

/Jarkko
