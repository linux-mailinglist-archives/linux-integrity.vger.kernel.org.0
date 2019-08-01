Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 17DBD7E03B
	for <lists+linux-integrity@lfdr.de>; Thu,  1 Aug 2019 18:32:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732998AbfHAQcX (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 1 Aug 2019 12:32:23 -0400
Received: from mga02.intel.com ([134.134.136.20]:28142 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727024AbfHAQcX (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 1 Aug 2019 12:32:23 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 01 Aug 2019 09:32:21 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,334,1559545200"; 
   d="scan'208";a="201353113"
Received: from criesing-mobl1.ger.corp.intel.com (HELO localhost) ([10.252.51.57])
  by fmsmga002.fm.intel.com with ESMTP; 01 Aug 2019 09:32:16 -0700
Date:   Thu, 1 Aug 2019 19:32:15 +0300
From:   Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To:     Roberto Sassu <roberto.sassu@huawei.com>
Cc:     jejb@linux.ibm.com, zohar@linux.ibm.com, jgg@ziepe.ca,
        linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org, keyrings@vger.kernel.org,
        linux-kernel@vger.kernel.org, crazyt2019+lml@gmail.com,
        tyhicks@canonical.com, nayna@linux.vnet.ibm.com,
        silviu.vlasceanu@huawei.com
Subject: Re: [PATCH] KEYS: trusted: allow module init if TPM is inactive or
 deactivated
Message-ID: <20190801163215.mfkagoafkxscesne@linux.intel.com>
References: <20190705163735.11539-1-roberto.sassu@huawei.com>
 <20190711194811.rfsohbfc3a7carpa@linux.intel.com>
 <b4454a78-1f1b-cc75-114a-99926e097b05@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b4454a78-1f1b-cc75-114a-99926e097b05@huawei.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: NeoMutt/20180716
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Mon, Jul 15, 2019 at 06:44:28PM +0200, Roberto Sassu wrote:
> According to the bug report at https://bugs.archlinux.org/task/62678,
> the trusted module is a dependency of the ecryptfs module. We should
> load the trusted module even if the TPM is inactive or deactivated.
> 
> Given that commit 782779b60faa ("tpm: Actually fail on TPM errors during
> "get random"") changes the return code of tpm_get_random(), the patch
> should be modified to ignore the -EIO error. I will send a new version.

Do you have information where this dependency comes from?

/Jarkko
