Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 399821CE205
	for <lists+linux-integrity@lfdr.de>; Mon, 11 May 2020 19:49:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726661AbgEKRt2 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 11 May 2020 13:49:28 -0400
Received: from mga12.intel.com ([192.55.52.136]:4902 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726310AbgEKRt2 (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 11 May 2020 13:49:28 -0400
IronPort-SDR: mEQKgvh9XzAxTQA0VtUu/0sR9rhO7PoDlx6TZ1rSefRaL83NbErSLgaawqDl7YRPXqY1Ask7JJ
 u2jesZqGPgZg==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 May 2020 10:49:28 -0700
IronPort-SDR: /Z8i/fuJygarGA6V+3n/cpspDv2ELTSCmULspU9V6zDGbAwPRM7WUXWM4vwtJELMcdmcshokHV
 ISNKmIpLXERQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,380,1583222400"; 
   d="scan'208";a="340624988"
Received: from orsmsx102.amr.corp.intel.com ([10.22.225.129])
  by orsmga001.jf.intel.com with ESMTP; 11 May 2020 10:49:27 -0700
Received: from orsmsx101.amr.corp.intel.com ([169.254.8.204]) by
 ORSMSX102.amr.corp.intel.com ([169.254.3.107]) with mapi id 14.03.0439.000;
 Mon, 11 May 2020 10:49:25 -0700
From:   "Roberts, William C" <william.c.roberts@intel.com>
To:     "linux-integrity@vger.kernel.org" <linux-integrity@vger.kernel.org>
Subject: Questions on SHA1 in ima_init
Thread-Topic: Questions on SHA1 in ima_init
Thread-Index: AdYnu1hfyrMZKMH8Qlu6i128wocGgg==
Date:   Mon, 11 May 2020 17:49:25 +0000
Message-ID: <476DC76E7D1DF2438D32BFADF679FC5649EDCB91@ORSMSX101.amr.corp.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-product: dlpe-windows
dlp-version: 11.0.600.7
dlp-reaction: no-action
x-originating-ip: [10.22.254.138]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Hello,

I'm part of the tpm2 users pace tooling and libraries, and I am trying to track down an issue in where boot aggregate is only extended in the SHA1
bank of PCR10.

You can read the details on the link below, but ill summarize here
  - https://lists.01.org/hyperkitty/list/tpm2@lists.01.org/thread/FUBD3MY5U5YICNUYSF3NE2STO3YAW7Y4/

It looks like ima_add_boot_aggregate() is hardcoded to SHA1, our guess is, that it's so it works between TPM 1.X and TPM2.0 chips. Is that
correct?

I was wondering if that synopsis is correct and if there would be traction to add something like querying the tpm chip and getting the version
And picking SHA256 if its tpm2.0, as a sample to guide the discussion I included the patch below (totally untested/not-compiled). The main
downside would be leaking TPM versions into IMA to make a decisions, so it may be better to have a helper in the tpm code to pick the best
default algorithm where it could pick SHA1 for TPM1.X and SHA256 for TPM2.0. Thoughts?

diff --git a/security/integrity/ima/ima_init.c b/security/integrity/ima/ima_init.c
index 567468188a61..d0513bafeebf 100644
--- a/security/integrity/ima/ima_init.c
+++ b/security/integrity/ima/ima_init.c
@@ -15,6 +15,7 @@
 #include <linux/scatterlist.h>
 #include <linux/slab.h>
 #include <linux/err.h>
+#include <linux/printk.h>
 
 #include "ima.h"
 
@@ -59,6 +60,16 @@ static int __init ima_add_boot_aggregate(void)
        iint->ima_hash->length = SHA1_DIGEST_SIZE;
 
        if (ima_tpm_chip) {
+               result = tpm_is_tpm2(ima_tpm_chip);
+               if (result > 0) {
+                       /* yes it's a TPM2 chipset use sha256 */
+                       iint->ima_hash->algo = HASH_ALGO_SHA256;
+                       iint->ima_hash->length = SHA256_DIGEST_SIZE;
+               } else if (result < 0) {
+                       /* ignore errors here, as we can just move on with SHA1 */
+                       pr_warn("Could not query TPM chip version, got: %d\n", result);
+               }
+
                result = ima_calc_boot_aggregate(&hash.hdr);
                if (result < 0) {
                        audit_cause = "hashing_error";





