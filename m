Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B31EA3010FE
	for <lists+linux-integrity@lfdr.de>; Sat, 23 Jan 2021 00:29:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728236AbhAVX3V (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 22 Jan 2021 18:29:21 -0500
Received: from linux.microsoft.com ([13.77.154.182]:56220 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728164AbhAVX3T (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 22 Jan 2021 18:29:19 -0500
Received: from rapha-Virtual-Machine.mshome.net (unknown [131.107.160.57])
        by linux.microsoft.com (Postfix) with ESMTPSA id A2CE220B7192;
        Fri, 22 Jan 2021 15:28:38 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com A2CE220B7192
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1611358118;
        bh=gR+E6J/KWkeDvBUKGVIOIRFzbUvo3l+XqkwRbUylShY=;
        h=From:To:Cc:Subject:Date:From;
        b=cJpz6cfjkhbrFP40Q2e7ZBMISQNOUwwTdJqxZWE5qiTfeSLhLc4AoN3Rtz6iiJcnM
         zn+sR4ZBgqxiAvHmqtaMPkEJjJT88/tWHOzbmza6W/vOQ6RYteObtD5TADHxAiZsXB
         T+iEmNGYAndBv4cV20T1RCiVLwPGBDG7t5VMh1Rs=
From:   Raphael Gianotti <raphgi@linux.microsoft.com>
To:     zohar@linux.ibm.com
Cc:     linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org,
        tusharsu@linux.microsoft.com, nramas@linux.microsoft.com,
        tyhicks@linux.microsoft.com
Subject: [PATCH v2] IMA: Measure kernel version in early boot
Date:   Fri, 22 Jan 2021 15:28:27 -0800
Message-Id: <20210122232827.12840-1-raphgi@linux.microsoft.com>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

The integrity of a kernel can be verified by the boot loader on cold
boot, and during kexec, by the current running kernel, before it is
loaded. However, it is still possible that the new kernel being
loaded is older than the current kernel, and/or has known
vulnerabilities. Therefore, it is imperative that an attestation
service be able to verify the version of the kernel being loaded on
the client, from cold boot and subsequent kexec system calls,
ensuring that only kernels with versions known to be good are loaded.

Measure the kernel version using ima_measure_critical_data() early on
in the boot sequence, reducing the chances of known kernel
vulnerabilities being exploited. With IMA being part of the kernel,
this overall approach makes the measurement itself more trustworthy.

To enable measuring the kernel version "ima_policy=critical_data"
needs to be added to the kernel command line arguments.
For example,
	BOOT_IMAGE=/boot/vmlinuz-5.11.0-rc3+ root=UUID=fd643309-a5d2-4ed3-b10d-3c579a5fab2f ro nomodeset ima_policy=critical_data

If runtime measurement of the kernel version is ever needed, the
following should be added to /etc/ima/ima-policy:

	measure func=CRITICAL_DATA label=kernel_version

To extract the measured data after boot, the following command can be used:

        grep -m 1 "kernel_version" \
        /sys/kernel/security/integrity/ima/ascii_runtime_measurements

Sample output from the command above:

	10 a8297d408e9d5155728b619761d0dd4cedf5ef5f ima-buf
	sha256:5660e19945be0119bc19cbbf8d9c33a09935ab5d30dad48aa11f879c67d70988
	kernel_version 352e31312e302d7263332d31363138372d676564623634666537383234342d6469727479

The above corresponds to the following (decoded) version string:

	5.11.0-rc3-16187-gedb64fe78244-dirty

This patch is based on
commit e58bb688f2e4 "Merge branch 'measure-critical-data' into next-integrity"
in "next-integrity-testing" branch

Change Log v2:
	- Changed the measurement to align with the latest version of
	  ima_measure_critical_data(), without the need for queueing
	- Scoped the measurement to only measure the kernel version,
	  found in UTS_RELEASE, instead of the entire linux_banner
	  string

Signed-off-by: Raphael Gianotti <raphgi@linux.microsoft.com>
---
 security/integrity/ima/ima_main.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/security/integrity/ima/ima_main.c b/security/integrity/ima/ima_main.c
index 6a429846f90a..0a33f570725c 100644
--- a/security/integrity/ima/ima_main.c
+++ b/security/integrity/ima/ima_main.c
@@ -26,6 +26,7 @@
 #include <linux/ima.h>
 #include <linux/iversion.h>
 #include <linux/fs.h>
+#include <generated/utsrelease.h>
 
 #include "ima.h"
 
@@ -994,8 +995,11 @@ static int __init init_ima(void)
 	if (error)
 		pr_warn("Couldn't register LSM notifier, error %d\n", error);
 
-	if (!error)
+	if (!error) {
 		ima_update_policy_flag();
+		ima_measure_critical_data("kernel_version", "kernel_version",
+					  UTS_RELEASE, strlen(UTS_RELEASE), false);
+	}
 
 	return error;
 }
-- 
2.28.0

