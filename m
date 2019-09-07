Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F1CEBAC8EC
	for <lists+linux-integrity@lfdr.de>; Sat,  7 Sep 2019 21:03:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2395240AbfIGTDf (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Sat, 7 Sep 2019 15:03:35 -0400
Received: from mga17.intel.com ([192.55.52.151]:44094 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2395216AbfIGTDf (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Sat, 7 Sep 2019 15:03:35 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga107.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 07 Sep 2019 12:03:34 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,478,1559545200"; 
   d="scan'208";a="186098490"
Received: from bemmett-mobl.amr.corp.intel.com ([10.249.37.206])
  by orsmga003.jf.intel.com with ESMTP; 07 Sep 2019 12:03:32 -0700
Message-ID: <0220e8a41b62cc169b21fe9e2e58467a43232e53.camel@linux.intel.com>
Subject: Re: [PATCH v2] KEYS: trusted: correctly initialize digests and fix
 locking issue
From:   Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To:     Roberto Sassu <roberto.sassu@huawei.com>, zohar@linux.ibm.com
Cc:     linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org, keyrings@vger.kernel.org,
        linux-kernel@vger.kernel.org, silviu.vlasceanu@huawei.com
Date:   Sat, 07 Sep 2019 22:03:30 +0300
In-Reply-To: <10abf6bea8b2612a40eae338e94704d152f53825.camel@linux.intel.com>
References: <20190904185057.8400-1-roberto.sassu@huawei.com>
         <10abf6bea8b2612a40eae338e94704d152f53825.camel@linux.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.32.2-1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Sat, 2019-09-07 at 22:02 +0300, Jarkko Sakkinen wrote:
> On Wed, 2019-09-04 at 20:50 +0200, Roberto Sassu wrote:
> > This patch fixes two issues introduced with commit 0b6cf6b97b7e ("tpm: pass
> > an array of tpm_extend_digest structures to tpm_pcr_extend()").
> > 
> > It initializes the algorithm in init_digests() for trusted keys, and moves
> > the algorithm check in tpm_pcr_extend() before locks are taken in
> > tpm_find_get_ops().
> > 
> > Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>
> > Fixes: 0b6cf6b97b7e ("tpm: pass an array of tpm_extend_digest structures to tpm_pcr_extend()")
> > ---
> 
> The changelog is missing. You should place it right after these three
> dashes before diffstat. So, why did you do v2?
> 
> I don't see any description of the two issues. The commit messages
> goes on explaining right away what this patch does. Would be nice
> to have one paragraph describing both of the issues at first before
> striving into solutions.
> 
> Also, the granularity should be one patch per one issue so this will
> require two patches in total.

Actually taking my words back as far as the last paragraph goes. Since
the fixes tag is the same I'm cool with one patch as long as the commit
message describes better what you're doing and why.

/Jarkko


