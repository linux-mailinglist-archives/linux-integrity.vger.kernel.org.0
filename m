Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0C2EB297974
	for <lists+linux-integrity@lfdr.de>; Sat, 24 Oct 2020 00:59:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1758421AbgJWW74 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 23 Oct 2020 18:59:56 -0400
Received: from linux.microsoft.com ([13.77.154.182]:36428 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1758420AbgJWW74 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 23 Oct 2020 18:59:56 -0400
Received: from rapha-Virtual-Machine.mshome.net (unknown [131.107.160.57])
        by linux.microsoft.com (Postfix) with ESMTPSA id EF8D920B4905;
        Fri, 23 Oct 2020 15:59:54 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com EF8D920B4905
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1603493995;
        bh=NkvA3zzIjzHi98u3ccl1u1EIxYHkMKtijpdvdJHbL5A=;
        h=From:To:Cc:Subject:Date:From;
        b=oOCHZFnuh58FK79Drp0/q4ui8llOA9dRrIBoWvHwjlpKGx/6bMC/vBLmmY2czUEfc
         dy/2lVXaoI04/zEbZ/dvHqEvmLJRcZ1ybKomLbTAJa7wJKDzsfz37S91IK9OXYGvR8
         smFGwj8xqVO2Cirz3gwfuE85glsMS8w0ndGPHRUA=
From:   Raphael Gianotti <raphgi@linux.microsoft.com>
To:     zohar@linux.ibm.com
Cc:     linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] IMA: Measure kernel version in early boot
Date:   Fri, 23 Oct 2020 15:59:47 -0700
Message-Id: <20201023225947.8710-1-raphgi@linux.microsoft.com>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

The digital integrity of a kernel can be verified by the boot loader on
cold boot, and during kexec, by the current running kernel, before it is
loaded. However, it is still possible that the new kernel being loaded is
older then the current kernel, and/or has known vulnerabilities.
Therefore, it is imperative that an attestation service be able to verify
the version of the kernel being loaded on the client, from cold boot and
subsequent kexec system calls, ensuring that only kernels with versions
known to be good are loaded.

Measure the kernel version using ima_measure_critical_data() early on in
the boot sequence, reducing the chances of known kernel vulnerabilities
being exploited. With IMA being part of the kernel, this overall approach
makes the measurement itself more trustworthy. ima_measure_critical_data()
also makes use of queuing, thus the version string stored in linux_banner
can queued for measuring in ima_init, with the actual measurement taking
place as soon as the IMA subsystem is ready.

Adding the following line to the ima policy file (/etc/ima/ima-policy)
will enable this measurement:

        measure func=CRITICAL_DATA data_sources=kernel_version template=ima-buf

To extract the measured data after boot, the following command can be used:

        grep -m 1 "kernel_version" \
        /sys/kernel/security/integrity/ima/ascii_runtime_measurements

Sample output from the command above:

        10 355335b64c90d5810cf0d869d84a4076ebcabd89 ima-buf sha256:05260b2
        ddf63284697f9448898d9466e4ce26d409a6e2ec357f0ce0b7425695b
        kernel_version 4c696e75782076657273696f6e20352e392e302d7263322d313
        63236372d676338623364356165346231612d64697274792028726170686140726
        17068612d5669727475616c2d4d616368696e65292028616172636836342d6c696
        e75782d676e752d67636320285562756e74752f4c696e61726f20372e352e302d3
        37562756e7475317e31382e30342920372e352e302c20474e55206c642028474e5
        52042696e7574696c7320666f72205562756e74752920322e33302920233136205
        34d5020576564204f63742031342031353a35313a3339205044542032303230

The above corresponds to the following (decoded) version string:

        Linux version 5.9.0-rc2-16267-gc8b3d5ae4b1a-dirty (rapha@rapha
        -Virtual-Machine) (aarch64-linux-gnu-gcc (Ubuntu/Linaro 7.5.0-
        3ubuntu1~18.04) 7.5.0, GNU ld (GNU Binutils for Ubuntu) 2.30)
        #16 SMP Wed Oct 14 15:51:39 PDT 2020

Signed-off-by: Raphael Gianotti <raphgi@linux.microsoft.com>
---
 security/integrity/ima/Kconfig          | 10 ++++++++++
 security/integrity/ima/ima.h            |  1 +
 security/integrity/ima/ima_main.c       |  5 ++++-
 security/integrity/ima/ima_queue_data.c |  5 +++--
 4 files changed, 18 insertions(+), 3 deletions(-)

diff --git a/security/integrity/ima/Kconfig b/security/integrity/ima/Kconfig
index fec7e74978ed..7ad3ddb83c06 100644
--- a/security/integrity/ima/Kconfig
+++ b/security/integrity/ima/Kconfig
@@ -328,3 +328,13 @@ config IMA_SECURE_AND_OR_TRUSTED_BOOT
        help
           This option is selected by architectures to enable secure and/or
           trusted boot based on IMA runtime policies.
+
+config IMA_MEASURE_KERNEL_VERSION
+       bool
+       depends on IMA
+       default y
+       help
+	  This option enables measuring the kernel version and causes it to
+	  be measured during kernel boot.
+	  This option requires the following IMA rule to be set:
+	  measure func=CRITICAL_DATA data_sources=kernel_version template=ima-buf
diff --git a/security/integrity/ima/ima.h b/security/integrity/ima/ima.h
index e99e5e0db720..9d4b4a6027db 100644
--- a/security/integrity/ima/ima.h
+++ b/security/integrity/ima/ima.h
@@ -230,6 +230,7 @@ struct modsig;
 
 #define __ima_supported_kernel_data_sources(source)	\
 	source(MIN_SOURCE, min_source)			\
+	source(KERNEL_VERSION, kernel_version)		\
 	source(MAX_SOURCE, max_source)
 
 #define __ima_enum_stringify(ENUM, str) (#str),
diff --git a/security/integrity/ima/ima_main.c b/security/integrity/ima/ima_main.c
index 5162917e6bf2..e128b27776e2 100644
--- a/security/integrity/ima/ima_main.c
+++ b/security/integrity/ima/ima_main.c
@@ -948,8 +948,11 @@ static int __init init_ima(void)
 	if (error)
 		pr_warn("Couldn't register LSM notifier, error %d\n", error);
 
-	if (!error)
+	if (!error) {
 		ima_update_policy_flag();
+		ima_measure_critical_data("kernel_version", "kernel_version",
+					  linux_banner, strlen(linux_banner), false);
+	}
 
 	return error;
 }
diff --git a/security/integrity/ima/ima_queue_data.c b/security/integrity/ima/ima_queue_data.c
index 4871ed3af436..fbd0a7bf668e 100644
--- a/security/integrity/ima/ima_queue_data.c
+++ b/security/integrity/ima/ima_queue_data.c
@@ -35,8 +35,9 @@ static bool timer_expired;
 
 static inline bool ima_queuing_enabled(void)
 {
-	return (IS_ENABLED(CONFIG_IMA_MEASURE_ASYMMETRIC_KEYS) &&
-		IS_ENABLED(CONFIG_SYSTEM_TRUSTED_KEYRING));
+	return ((IS_ENABLED(CONFIG_IMA_MEASURE_ASYMMETRIC_KEYS) &&
+		IS_ENABLED(CONFIG_SYSTEM_TRUSTED_KEYRING)) ||
+		IS_ENABLED(CONFIG_IMA_MEASURE_KERNEL_VERSION));
 }
 
 /*
-- 
2.28.0

