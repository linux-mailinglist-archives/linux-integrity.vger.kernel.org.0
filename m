Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9AAA31FC095
	for <lists+linux-integrity@lfdr.de>; Tue, 16 Jun 2020 23:03:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728067AbgFPVDQ (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 16 Jun 2020 17:03:16 -0400
Received: from mga12.intel.com ([192.55.52.136]:48510 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726296AbgFPVDQ (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 16 Jun 2020 17:03:16 -0400
IronPort-SDR: n9EsqQAETgt3HoHLKIaGkhgE8jd3ZOC17YQkP4YzW4eedd0VRKLc6p3FSClbYp+i0mHlKqhwZf
 8k09UgoV9QNw==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jun 2020 14:03:15 -0700
IronPort-SDR: Szv+I4fWjyT9MINr0vZ3TjatV90mqMHrXECHJRBgHpRqE63jZ0mTIVMIGEU/MYIm3759OHOtIx
 lw1QNVn8rukg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,519,1583222400"; 
   d="scan'208";a="261534604"
Received: from gosinald-mobl2.ger.corp.intel.com (HELO localhost) ([10.249.36.106])
  by fmsmga007.fm.intel.com with ESMTP; 16 Jun 2020 14:03:12 -0700
Date:   Wed, 17 Jun 2020 00:03:11 +0300
From:   Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To:     Binbin Zhou <zhoubinbin@uniontech.com>
Cc:     peterhuewe@gmx.de, jgg@ziepe.ca, linux-integrity@vger.kernel.org,
        christophe.ricard@gmail.com, zhoubb.aaron@gmail.com
Subject: Re: [PATCH] tpm/st33zp24: fix spelling mistake "drescription" ->
 "description"
Message-ID: <20200616210311.GI20943@linux.intel.com>
References: <20200605033415.8586-1-zhoubinbin@uniontech.com>
 <20200616210042.GH20943@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200616210042.GH20943@linux.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Wed, Jun 17, 2020 at 12:00:46AM +0300, Jarkko Sakkinen wrote:
> On Fri, Jun 05, 2020 at 11:34:15AM +0800, Binbin Zhou wrote:
> > Trivial fix, the spelling of "drescription" is incorrect in function comment.
> > Fix this.
> > 
> > Signed-off-by: Binbin Zhou <zhoubinbin@uniontech.com>
> 
> Acked-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>

Please run your patch with scripts/checkpatch.pl before sending:

» scripts/checkpatch.pl
0001-tpm-st33zp24-fix-spelling-mistake-drescription-descr.patch 
WARNING: Possible unwrapped commit description (prefer a maximum 75
chars per line)
#7: 
Trivial fix, the spelling of "drescription" is incorrect in function
comment.

total: 0 errors, 1 warnings, 32 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or
      --fix-inplace.

      0001-tpm-st33zp24-fix-spelling-mistake-drescription-descr.patch
      has style problems, please review.

      NOTE: If any of the errors are false positives, please report
            them to the maintainer, see CHECKPATCH in MAINTAINERS.

Fix the checkpatch issue and send v2. Thanks.

/Jarkko
