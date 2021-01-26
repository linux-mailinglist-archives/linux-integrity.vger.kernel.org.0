Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1C6CD304A36
	for <lists+linux-integrity@lfdr.de>; Tue, 26 Jan 2021 21:37:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728743AbhAZFLz (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 26 Jan 2021 00:11:55 -0500
Received: from linux.microsoft.com ([13.77.154.182]:59810 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727010AbhAZBf6 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 25 Jan 2021 20:35:58 -0500
Received: from rapha-Virtual-Machine.mshome.net (unknown [131.107.160.57])
        by linux.microsoft.com (Postfix) with ESMTPSA id 8FA7A20B7192;
        Mon, 25 Jan 2021 16:50:51 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 8FA7A20B7192
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1611622251;
        bh=moqku2tkY4SiJt7zT3t8TjRoMyMCVZ4Ccw5Yo30J5dc=;
        h=From:To:Cc:Subject:Date:From;
        b=l+XzbsKo6flGDWVfzzZAlbIENJWyYi8fpNDqCZ4E2cONJFWrUZjjQANMoNiWfEK5x
         TYsFNrKzHj3cxuHTC6sFqvhIiBtgZXNRDj06oqJIzl5gRH2O6YBQdj6JikZZ2wK4NY
         bLLi0Eg+FyvhIasc147M/7FBNhhnext5z8Cgo7/E=
From:   Raphael Gianotti <raphgi@linux.microsoft.com>
To:     zohar@linux.ibm.com
Cc:     linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org,
        tusharsu@linux.microsoft.com, nramas@linux.microsoft.com,
        tyhicks@linux.microsoft.com
Subject: [PATCH v3] IMA: Measure kernel version in early boot
Date:   Mon, 25 Jan 2021 16:50:44 -0800
Message-Id: <20210126005044.2010-1-raphgi@linux.microsoft.com>
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

        measure func=CRITICAL_DATA label=kernel_info

To extract the measured data after boot, the following command can be used:

        grep -m 1 "kernel_version" \
        /sys/kernel/security/integrity/ima/ascii_runtime_measurements

Sample output from the command above:

        10 a8297d408e9d5155728b619761d0dd4cedf5ef5f ima-buf
        sha256:5660e19945be0119bc19cbbf8d9c33a09935ab5d30dad48aa11f879c67d70988
        kernel_version 352e31312e302d7263332d31363138372d676564623634666537383234342d6469727479

The above corresponds to the following (decoded) version string:

        5.11.0-rc3-16187-gedb64fe78244-dirty

Signed-off-by: Raphael Gianotti <raphgi@linux.microsoft.com>
---
Change Log v3:
        - Updated critical data label as kernel_info in
          Documentation/ABI/testing/ima_policy
        - Moved the ima_measure_critical_data() call to ima_init()

Change Log v2:
        - Changed the measurement to align with the latest version of
          ima_measure_critical_data(), without the need for queueing
        - Scoped the measurement to only measure the kernel version,
          found in UTS_RELEASE, instead of the entire linux_banner
          string

This patch is based on
commit e58bb688f2e4 "Merge branch 'measure-critical-data' into next-integrity"
in "next-integrity-testing" branch

 Documentation/ABI/testing/ima_policy | 2 +-
 security/integrity/ima/ima_init.c    | 5 +++++
 2 files changed, 6 insertions(+), 1 deletion(-)

diff --git a/Documentation/ABI/testing/ima_policy b/Documentation/ABI/testing/ima_policy
index 8365596cb42b..bc8e1cbe5e61 100644
--- a/Documentation/ABI/testing/ima_policy
+++ b/Documentation/ABI/testing/ima_policy
@@ -52,7 +52,7 @@ Description:
 			template:= name of a defined IMA template type
 			(eg, ima-ng). Only valid when action is "measure".
 			pcr:= decimal value
-			label:= [selinux]|[data_label]
+			label:= [selinux]|[kernel_info]|[data_label]
 			data_label:= a unique string used for grouping and limiting critical data.
 			For example, "selinux" to measure critical data for SELinux.
 
diff --git a/security/integrity/ima/ima_init.c b/security/integrity/ima/ima_init.c
index 4902fe7bd570..6e8742916d1d 100644
--- a/security/integrity/ima/ima_init.c
+++ b/security/integrity/ima/ima_init.c
@@ -15,6 +15,8 @@
 #include <linux/scatterlist.h>
 #include <linux/slab.h>
 #include <linux/err.h>
+#include <linux/ima.h>
+#include <generated/utsrelease.h>
 
 #include "ima.h"
 
@@ -147,5 +149,8 @@ int __init ima_init(void)
 
 	ima_init_key_queue();
 
+	ima_measure_critical_data("kernel_info", "kernel_version",
+				  UTS_RELEASE, strlen(UTS_RELEASE), false);
+
 	return rc;
 }
-- 
2.28.0

