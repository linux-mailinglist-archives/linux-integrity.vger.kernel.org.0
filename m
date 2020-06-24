Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B89B4207E6E
	for <lists+linux-integrity@lfdr.de>; Wed, 24 Jun 2020 23:24:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390669AbgFXVYj (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 24 Jun 2020 17:24:39 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:46708 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S2390601AbgFXVYj (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 24 Jun 2020 17:24:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1593033878;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=z/HOX6zk4sQjsiuGp+il4qqxNWvlmASSYsaIyj9dtoY=;
        b=cvMldFALZAt2Ub4KrkNInGo73gyqnuzPbd+a3gHVVTjXicXvz/H+wrk4AOGCVbAd8IGRZQ
        iu72IMoA5bSabITl5OvPD8Qok5NH4E/JtD84NhczI0dhMSPR7qHVzVx8Y04XFLxZiPM2aW
        KzHS06PRrj+ToK0mRCp4q0IhNlL3vmw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-334-aHFaUy3hPnig-dWS3gT-nQ-1; Wed, 24 Jun 2020 17:24:36 -0400
X-MC-Unique: aHFaUy3hPnig-dWS3gT-nQ-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 83CAD800C60;
        Wed, 24 Jun 2020 21:24:35 +0000 (UTC)
Received: from localhost (ovpn-116-62.gru2.redhat.com [10.97.116.62])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 70F46579A3;
        Wed, 24 Jun 2020 21:24:32 +0000 (UTC)
From:   Bruno Meneguele <bmeneg@redhat.com>
To:     linux-integrity@vger.kernel.org
Cc:     zohar@linux.ibm.com, Bruno Meneguele <bmeneg@redhat.com>
Subject: [PATCH] ima-evm-utils: skip test for discrete TPM 1.2 and exec'd as normal user
Date:   Wed, 24 Jun 2020 18:24:20 -0300
Message-Id: <20200624212420.3300-1-bmeneg@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

boot_aggregate test make use of a software TPM 2.0 in case it doesn't find
any /dev/tpm0 in the system or if the test is ran as a normal user. However,
when the system has a discrete TPM 1.2 and the user runs the test with a
non-root user evmctl fails to return the software TPM 2.0 boot aggregate
value because it tries to access the sysfs PCRs file and, consequently, the
test fails.

Supporting a software TPM 1.2 involved some more work and new dependency in
other programs to extend the PCRs accordingly. Because of that, just drop
support for this scenario for now.

Signed-off-by: Bruno Meneguele <bmeneg@redhat.com>
---
 tests/boot_aggregate.test | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/tests/boot_aggregate.test b/tests/boot_aggregate.test
index fe0c9aa..43de67d 100755
--- a/tests/boot_aggregate.test
+++ b/tests/boot_aggregate.test
@@ -23,6 +23,8 @@ export LD_LIBRARY_PATH=$LD_LIBRARY_PATH
 . ./functions.sh
 _require evmctl
 TSSDIR="$(dirname -- "$(which tssstartup)")"
+PCRFILE="/sys/class/tpm/tpm0/device/pcrs"
+MISC_PCRFILE="/sys/class/misc/tpm0/device/pcrs"
 
 if [ "$(id -u)" = 0 ] && [ -c "/dev/tpm0" ]; then
 	ASCII_RUNTIME_MEASUREMENTS="/sys/kernel/security/ima/ascii_runtime_measurements"
@@ -133,6 +135,11 @@ check() {
 
 # Start and initialize a software TPM as needed
 if [ "$(id -u)" != 0 ] || [ ! -c "/dev/tpm0" ]; then
+	if [ -f "$PCRFILE" ] || [ -f "$MISC_PCRFILE" ]; then
+		echo "${CYAN}SKIP: system has discrete TPM 1.2, sample TPM 2.0 event log test not supported.${NORM}"
+		exit "$SKIP"
+	fi
+
 	swtpm_start
 	error=$?
 	if [ $error -eq "$SKIP" ]; then
-- 
2.26.2

