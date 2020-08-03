Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3F1E123AC97
	for <lists+linux-integrity@lfdr.de>; Mon,  3 Aug 2020 20:47:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726847AbgHCSrj (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 3 Aug 2020 14:47:39 -0400
Received: from linux.microsoft.com ([13.77.154.182]:35710 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725945AbgHCSri (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 3 Aug 2020 14:47:38 -0400
Received: from localhost.localdomain (c-73-187-218-229.hsd1.pa.comcast.net [73.187.218.229])
        by linux.microsoft.com (Postfix) with ESMTPSA id 24B1620B490A;
        Mon,  3 Aug 2020 11:47:37 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 24B1620B490A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1596480458;
        bh=+dFj7dCuj0185ShJTiqY0XRK9Voy3eIJ3vAQPDuPtos=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=kaZTpnPbHnpMMqb8G6dPIzsQ6J7Ajbsy2aqI2Iqzn7bmJDF8tiHYVBI/BOYRc87yP
         /PmE277/2Zf3agQO0mBOLEbB1Q0Nx/AIF6Ozzdj6ajAxBGOpvgWng07qQeca5tABIr
         OHk+1WiFDqsgca5uK3wVXdt8hqzRnF35oKWpzm4w=
From:   Lachlan Sneff <t-josne@linux.microsoft.com>
To:     pvorel@suse.cz, zohar@linux.ibm.com, ltp@lists.linux.it
Cc:     nramas@linux.microsoft.com, balajib@linux.microsoft.com,
        linux-integrity@vger.kernel.org, tyhicks@linux.microsoft.com,
        yaneurabeya@gmail.com, zhang.jia@linux.alibaba.com
Subject: [PATCH 1/3] IMA: Update key test documentation
Date:   Mon,  3 Aug 2020 14:47:24 -0400
Message-Id: <20200803184726.2416-2-t-josne@linux.microsoft.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200803184726.2416-1-t-josne@linux.microsoft.com>
References: <20200803184726.2416-1-t-josne@linux.microsoft.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

The current documentation for the existing IMA key test was
left in by accident by a previous merge. It does not apply
to the test that is currently included in the LTP.

Update the documentation for the IMA key test.

Signed-off-by: Lachlan Sneff <t-josne@linux.microsoft.com>
---
 .../kernel/security/integrity/ima/README.md   | 22 +++++--------------
 1 file changed, 5 insertions(+), 17 deletions(-)

diff --git a/testcases/kernel/security/integrity/ima/README.md b/testcases/kernel/security/integrity/ima/README.md
index d4644ba39..2956ac7fd 100644
--- a/testcases/kernel/security/integrity/ima/README.md
+++ b/testcases/kernel/security/integrity/ima/README.md
@@ -15,27 +15,15 @@ Although a custom policy, loaded via dracut, systemd or manually from user
 space, may contain equivalent measurement tcb rules, detecting them would
 require `IMA_READ_POLICY=y` therefore ignore this option.
 
-### IMA key import test
-`ima_keys.sh` requires a x509 public key, by default in `/etc/keys/x509_ima.der`
-(defined in `CONFIG_IMA_X509_PATH` kernel config option).
-The key must be signed by the private key you generate. Follow these instructions:
-https://manpages.ubuntu.com/manpages/disco/man1/evmctl.1.html#generate%20trusted%20keys
-
-The test cannot be set-up automatically because the x509 public key must be
-built into the kernel and loaded onto a trusted keyring
-(e.g. `.builtin_trusted_keys`, `.secondary_trusted_keyring`).
-
-As well as what's required for the IMA tests, the following are also required
-in the kernel configuration:
+### IMA key test
+`ima_keys.sh` requires a readable IMA policy, as well as a loaded policy
+with `func=KEY_CHECK keyrings=...`, see example in `keycheck.policy`.
+
+Mandatory kernel configuration for IMA:
 ```
 CONFIG_IMA_READ_POLICY=y
-CONFIG_IMA_X509_PATH="/etc/keys/x509_ima.der"
-CONFIG_SYSTEM_TRUSTED_KEYRING=y
-CONFIG_SYSTEM_TRUSTED_KEYS="/etc/keys/ima-local-ca.pem"
 ```
 
-Test also requires loaded policy with `func=KEY_CHECK`, see example in `keycheck.policy`.
-
 ### IMA kexec test
 
 `ima_kexec.sh` requires loaded policy which contains `measure func=KEXEC_CMDLINE`,
-- 
2.25.1

