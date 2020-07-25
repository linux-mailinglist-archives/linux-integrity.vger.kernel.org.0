Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 54D9E22D626
	for <lists+linux-integrity@lfdr.de>; Sat, 25 Jul 2020 10:43:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726841AbgGYInQ (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Sat, 25 Jul 2020 04:43:16 -0400
Received: from mga05.intel.com ([192.55.52.43]:6917 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726701AbgGYInQ (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Sat, 25 Jul 2020 04:43:16 -0400
IronPort-SDR: 8Y1WqxwVuJIxDVP9LFn/l29G7UGdRtVAdjVAjUq4Nv3VhyUBYs5u/dMJI+Gvb3FUA+kkTFmJZ+
 ZCLOf2NNjuqQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9692"; a="235696429"
X-IronPort-AV: E=Sophos;i="5.75,394,1589266800"; 
   d="scan'208";a="235696429"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jul 2020 01:43:15 -0700
IronPort-SDR: 99Tkatq8mDKYd+FXvicYss998RdsGcL1dIB29A4jIEkeY95tnaUxwrYAc9WcnHOCmDyFrICrUh
 kXZh1PNIfMiQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,394,1589266800"; 
   d="scan'208";a="289227845"
Received: from lkp-server01.sh.intel.com (HELO df0563f96c37) ([10.239.97.150])
  by orsmga006.jf.intel.com with ESMTP; 25 Jul 2020 01:43:13 -0700
Received: from kbuild by df0563f96c37 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1jzFlw-0000qG-GP; Sat, 25 Jul 2020 08:43:12 +0000
Date:   Sat, 25 Jul 2020 16:42:32 +0800
From:   kernel test robot <lkp@intel.com>
To:     Sasha Levin <alexander.levin@microsoft.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        Thirupathaiah Annapureddy <thiruan@microsoft.com>,
        Peter Huewe <peterhuewe@gmx.de>,
        Jason Gunthorpe <jgg@ziepe.ca>, Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-integrity@vger.kernel.org
Subject: [PATCH] tpm/tpm_ftpm_tee: fix boolreturn.cocci warnings
Message-ID: <20200725084231.GA130732@a14d157e9177>
References: <202007251622.LcFCsv8T%lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202007251622.LcFCsv8T%lkp@intel.com>
X-Patchwork-Hint: ignore
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

From: kernel test robot <lkp@intel.com>

drivers/char/tpm/tpm_ftpm_tee.c:180:8-9: WARNING: return of 0/1 in function 'ftpm_tee_tpm_req_canceled' with return type bool

 Return statements in functions returning bool should use
 true/false instead of 1/0.
Generated by: scripts/coccinelle/misc/boolreturn.cocci

Fixes: 09e574831b27 ("tpm/tpm_ftpm_tee: A driver for firmware TPM running inside TEE")
CC: Sasha Levin <sashal@kernel.org>
Signed-off-by: kernel test robot <lkp@intel.com>
---

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   23ee3e4e5bd27bdbc0f1785eef7209ce872794c7
commit: 09e574831b277a3f77d78ceadd08a3859a84fdb3 tpm/tpm_ftpm_tee: A driver for firmware TPM running inside TEE

 tpm_ftpm_tee.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/char/tpm/tpm_ftpm_tee.c
+++ b/drivers/char/tpm/tpm_ftpm_tee.c
@@ -177,7 +177,7 @@ static u8 ftpm_tee_tpm_op_status(struct
 
 static bool ftpm_tee_tpm_req_canceled(struct tpm_chip *chip, u8 status)
 {
-	return 0;
+	return false;
 }
 
 static const struct tpm_class_ops ftpm_tee_tpm_ops = {
