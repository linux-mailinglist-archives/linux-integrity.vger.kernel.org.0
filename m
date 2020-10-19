Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CF21D292F28
	for <lists+linux-integrity@lfdr.de>; Mon, 19 Oct 2020 22:08:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726385AbgJSUIL (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 19 Oct 2020 16:08:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727068AbgJSUIK (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 19 Oct 2020 16:08:10 -0400
Received: from mail-ej1-x644.google.com (mail-ej1-x644.google.com [IPv6:2a00:1450:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8AF8AC0613CE
        for <linux-integrity@vger.kernel.org>; Mon, 19 Oct 2020 13:08:10 -0700 (PDT)
Received: by mail-ej1-x644.google.com with SMTP id lw21so833956ejb.6
        for <linux-integrity@vger.kernel.org>; Mon, 19 Oct 2020 13:08:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=xCuhw+811hASXLA1wyA9GmjeifMuFY9pro39Bio+VmU=;
        b=nEnyaibcXVl2VqwDmeGIV6CNyoc/5cm2/MIoiTNI9wkMyr4tQnsrHj/lCAUPbu8d4S
         m/WY6iZ9eYZllONBox6lKa6fU25YtPG7sQ2bpwGQqG8LsIIsNAA+T3DUEDUzZSNCTYFa
         R/0VyZH6xYPsrC9CNhv3wW6qTQLW6qVxdDEj4/69Pzk5W2Xusm6L8GsANU9bFjUbpKHl
         PXMNq/TkRN+jUv1lVSDpxF6nJRNP8A0NOzmEBITydrYAUALITcZt9Uj9KNsbygYKtij0
         IC+/cDqYWc2RdouYi4lM04Ir3+jrkEDiYBeZI19pYBnXc4OZVltgX8veJRyqjMIBDRNO
         r/Jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=xCuhw+811hASXLA1wyA9GmjeifMuFY9pro39Bio+VmU=;
        b=CXKMknvkHNM4enF/xuGJc43Mc/2iZzq/nWSXgl7G12DY7tA0DOuiz9P9t4p+xoj6qk
         temwyjQjDrFHAbhNw9cQNkfz975I07uyA6RiZmwTwvP4Gl3vFoBnHMp9xnf8akXr7esN
         dP7GAl1Hfg0bSBSBVZM78CXTxxXQXdsXFCa0j0t3I2i7iCfvoJq1T9D9HXMPfP5jZPVN
         DaUnE5gietAHbCXqI2mpXaY+jn4GsIpMiiHsTF7boxIyo3Z3/IIais4536WoMk3LKp4H
         wWBAhaTkvbgkVjjYv/ot/W8uk4JMZvXOjznG4r3sBql5LAdB2WM2y1EnkvR2EEed2X0v
         E2Qg==
X-Gm-Message-State: AOAM531MOuNRYuvYBeQCCJVOZCwSN2wHJKOutW4A0btEol93MQbfO3Gt
        ei0UKN0j+4OoH6JNmuY8JJd69PdtzxT2qQ==
X-Google-Smtp-Source: ABdhPJxdGKz3sq+tECZMv7N8S8kr/NHGvmNUH9eVk4bFviHvhPwYPZv64qb2Z3EaMGZWR+HhWA0Odw==
X-Received: by 2002:a17:906:d964:: with SMTP id rp4mr1599182ejb.110.1603138089064;
        Mon, 19 Oct 2020 13:08:09 -0700 (PDT)
Received: from localhost.localdomain ([62.201.25.198])
        by smtp.gmail.com with ESMTPSA id f28sm807943edc.94.2020.10.19.13.08.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Oct 2020 13:08:08 -0700 (PDT)
From:   Petr Vorel <petr.vorel@gmail.com>
To:     linux-integrity@vger.kernel.org
Cc:     Petr Vorel <petr.vorel@gmail.com>,
        Mimi Zohar <zohar@linux.vnet.ibm.com>
Subject: [PATCH ima-evm-utils] boot_aggregate.test: Skip if CONFIG_IMA not enabled
Date:   Mon, 19 Oct 2020 22:08:03 +0200
Message-Id: <20201019200803.35255-1-petr.vorel@gmail.com>
X-Mailer: git-send-email 2.27.0.rc0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

This is required, because when TPM HW available (i.e. -c /dev/tpm0),
evmctl ima_boot_aggregate returns sha1:xxxx.

skip requires to move cleanup().

Signed-off-by: Petr Vorel <petr.vorel@gmail.com>
---
Hi Mimi,

this Fixes problems on current Debian, which has still disabled CONFIG_IMA
(FYI [1]). I was not able to figure out how to get it working with
sample-* files, but maybe there is a way.

Although it sound strange, people may want to build and check evmctl
even on a system with disabled CONFIG_IMA (both Debian and Ubuntu have
outdated ima-evm-utils (1.1)).

Kind regards,
Petr

[1] https://bugs.debian.org/972459 linux: Reenable CONFIG_IMA

 tests/boot_aggregate.test | 35 ++++++++++++++++++++---------------
 1 file changed, 20 insertions(+), 15 deletions(-)

diff --git a/tests/boot_aggregate.test b/tests/boot_aggregate.test
index 42ed7b4..5fd4204 100755
--- a/tests/boot_aggregate.test
+++ b/tests/boot_aggregate.test
@@ -26,21 +26,6 @@ TSSDIR="$(dirname -- "$(which tssstartup)")"
 PCRFILE="/sys/class/tpm/tpm0/device/pcrs"
 MISC_PCRFILE="/sys/class/misc/tpm0/device/pcrs"
 
-if [ "$(id -u)" = 0 ] && [ -c "/dev/tpm0" ]; then
-	ASCII_RUNTIME_MEASUREMENTS="/sys/kernel/security/ima/ascii_runtime_measurements"
-else
-	BINARY_BIOS_MEASUREMENTS="./sample-binary_bios_measurements-pcrs-8-9"
-	ASCII_RUNTIME_MEASUREMENTS="./sample-ascii_runtime_measurements-pcrs-8-9"
-	export TPM_INTERFACE_TYPE="socsim"
-	export TPM_COMMAND_PORT=2321
-	export TPM_PLATFORM_PORT=2322
-	export TPM_SERVER_NAME="localhost"
-
-	# swtpm uses the raw, unencapsulated packet format
-	export TPM_SERVER_TYPE="raw"
-
-fi
-
 # Only stop this test's software TPM
 cleanup() {
 	if [ -n "${SWTPM_PID}" ]; then
@@ -165,6 +150,26 @@ check() {
 	return "$FAIL"
 }
 
+if [ ! -d "/sys/kernel/security/ima" ]; then
+	echo "${CYAN}SKIP: CONFIG_IMA not enabled${NORM}"
+	exit "$SKIP"
+fi
+
+if [ "$(id -u)" = 0 ] && [ -c "/dev/tpm0" ]; then
+	ASCII_RUNTIME_MEASUREMENTS="/sys/kernel/security/ima/ascii_runtime_measurements"
+else
+	BINARY_BIOS_MEASUREMENTS="./sample-binary_bios_measurements-pcrs-8-9"
+	ASCII_RUNTIME_MEASUREMENTS="./sample-ascii_runtime_measurements-pcrs-8-9"
+	export TPM_INTERFACE_TYPE="socsim"
+	export TPM_COMMAND_PORT=2321
+	export TPM_PLATFORM_PORT=2322
+	export TPM_SERVER_NAME="localhost"
+
+	# swtpm uses the raw, unencapsulated packet format
+	export TPM_SERVER_TYPE="raw"
+
+fi
+
 # Start and initialize a software TPM as needed
 if [ "$(id -u)" != 0 ] || [ ! -c "/dev/tpm0" ]; then
 	if [ -f "$PCRFILE" ] || [ -f "$MISC_PCRFILE" ]; then
-- 
2.27.0.rc0

