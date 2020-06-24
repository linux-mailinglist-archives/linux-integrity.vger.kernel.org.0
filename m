Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B96A3209679
	for <lists+linux-integrity@lfdr.de>; Thu, 25 Jun 2020 00:38:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388743AbgFXWij (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 24 Jun 2020 18:38:39 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:55851 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1732806AbgFXWij (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 24 Jun 2020 18:38:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1593038318;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=C6uCAe0ha3F0Ab+CRH//ftejlKFFT5PPSegvl2JqF2M=;
        b=fn1XtdDVkK3dvnazNBxKVTHZmWzF/V3VsTIGs4jpEZFSzYyfKKfuuZ8rX1j2m3u4Y20CFS
        SNP15M2bmE1nRg4EiDWa0nICdaTy2ACVFJrwgRGE4XLNJyElGGSttrEsbug1n2J05dS6/T
        WcLv7Ol1Ne9ZifBazdLYEjPdufjrujI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-381-FY2zRHriOgeT_5XZxEIgIw-1; Wed, 24 Jun 2020 18:38:36 -0400
X-MC-Unique: FY2zRHriOgeT_5XZxEIgIw-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id BDEC8800D5C;
        Wed, 24 Jun 2020 22:38:35 +0000 (UTC)
Received: from localhost (ovpn-116-62.gru2.redhat.com [10.97.116.62])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 4D50760C80;
        Wed, 24 Jun 2020 22:38:32 +0000 (UTC)
From:   Bruno Meneguele <bmeneg@redhat.com>
To:     linux-integrity@vger.kernel.org
Cc:     zohar@linux.ibm.com, Bruno Meneguele <bmeneg@redhat.com>
Subject: [PATCH v2] ima-evm-utils: skip test for discrete TPM 1.2 and exec'd as normal user
Date:   Wed, 24 Jun 2020 19:38:29 -0300
Message-Id: <20200624223829.6216-1-bmeneg@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

boot_aggregate test make use of a software TPM 2.0 in case it doesn't find
any /dev/tpm0 in the system or if the test is ran as a normal user. However,
when the system has a discrete TPM 1.2 and the user runs the test with a
non-root user evmctl fails to return the software TPM 2.0 boot aggregate
value because it tries to access TPM 1.2 the sysfs PCRs file and,
consequently, the test fails. Thus TPM 2.0 log test is not supported on
systems with a discrete TPM 1.2

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

