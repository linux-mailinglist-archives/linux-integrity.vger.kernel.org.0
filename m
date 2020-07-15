Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AE4AB220D89
	for <lists+linux-integrity@lfdr.de>; Wed, 15 Jul 2020 15:00:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729900AbgGONAo (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 15 Jul 2020 09:00:44 -0400
Received: from [195.135.220.15] ([195.135.220.15]:59386 "EHLO mx2.suse.de"
        rhost-flags-FAIL-FAIL-OK-OK) by vger.kernel.org with ESMTP
        id S1726335AbgGONAo (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 15 Jul 2020 09:00:44 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id DBF74B053;
        Wed, 15 Jul 2020 13:00:45 +0000 (UTC)
Date:   Wed, 15 Jul 2020 15:00:41 +0200
From:   Petr Vorel <pvorel@suse.cz>
To:     Lachlan Sneff <t-josne@linux.microsoft.com>
Cc:     zohar@linux.ibm.com, ltp@lists.linux.it,
        nramas@linux.microsoft.com, balajib@linux.microsoft.com,
        linux-integrity@vger.kernel.org
Subject: Re: [PATCH v5 1/2] IMA: Add a test to verify measurment of keys
Message-ID: <20200715130041.GA32414@dell5510>
Reply-To: Petr Vorel <pvorel@suse.cz>
References: <20200714181703.6374-1-t-josne@linux.microsoft.com>
 <20200714181703.6374-2-t-josne@linux.microsoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200714181703.6374-2-t-josne@linux.microsoft.com>
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Hi Lachlan, Mimi,

> Add a testcase that verifies that the IMA subsystem has correctly
> measured keys added to keyrings specified in the IMA policy file.

> Additionally, add support for handling a new IMA template descriptor,
> namely ima-buf[1], in the IMA measurement tests.

To speedup things, based on Mimi's comments and review of v4 I pushed this first
commit with few changes (below diff, only ima_keys.sh part)
* simplify error handling ($fail is not needed; I used tst_res and return
  because there will be second test, otherwise I'd use tst_brk)
* added modified docs into this commit
* fix commit title

TODO
* I'll send a patch to read CONFIG_IMA_X509_PATH (I've amended the commit
already enough)

* @Lachlan: expect you send another version for test2.

* @Lachlan: would you also implement Mimi's suggestion? [1]:
An additional test might be to verify that only the keys in the
measurement list are actually on the specified keyring and nothing
else.

Kind regards,
Petr

[1] http://lists.linux.it/pipermail/ltp/2020-July/018018.html

diff --git testcases/kernel/security/integrity/ima/tests/ima_keys.sh testcases/kernel/security/integrity/ima/tests/ima_keys.sh
index 4d53cd04f..904b7515b 100755
--- testcases/kernel/security/integrity/ima/tests/ima_keys.sh
+++ testcases/kernel/security/integrity/ima/tests/ima_keys.sh
@@ -15,7 +15,7 @@ TST_NEEDS_DEVICE=1
 # (450d0fd51564 - "IMA: Call workqueue functions to measure queued keys")
 test1()
 {
-	local keyrings keycheck_lines keycheck_line templates test_file="file.txt" fail
+	local keyrings keycheck_lines keycheck_line templates test_file="file.txt"
 
 	tst_res TINFO "verifying key measurement for keyrings and templates specified in IMA policy file"
 
@@ -57,15 +57,12 @@ test1()
 			tst_brk TCONF "cannot compute digest for $algorithm"
 
 		if [ "$digest" != "$expected_digest" ]; then
-			fail=1
 			tst_res TFAIL "incorrect digest was found for the ($keyring) keyring"
-			break
+			return
 		fi
 	done
 
-	if [ "$fail" ]; then
-		tst_res TPASS "specified keyrings were measured correctly"
-	fi
+	tst_res TPASS "specified keyrings were measured correctly"
 }
 
 tst_run
