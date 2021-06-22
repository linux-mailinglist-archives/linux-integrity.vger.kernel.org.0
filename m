Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 47F043B0723
	for <lists+linux-integrity@lfdr.de>; Tue, 22 Jun 2021 16:12:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231558AbhFVOO5 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 22 Jun 2021 10:14:57 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:35094 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231904AbhFVOO4 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 22 Jun 2021 10:14:56 -0400
Received: from imap.suse.de (imap-alt.suse-dmz.suse.de [192.168.254.47])
        (using TLSv1.2 with cipher ECDHE-ECDSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 951781FD70;
        Tue, 22 Jun 2021 14:12:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1624371159; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=QbRfcH+DeQMZvLrh/qht5MhB3BOBs1r6WfTDuqG2s08=;
        b=CWVKuhu/PpenY5aOgMyITqGMCAZcxM0Jgxdc77oybuA6IbcygyKjyfCpw6PshKAkVuvvng
        +27W1trW0pC5kmcfnXOZhQb8t4yJgZgLY1Ui0JlPtr7gBmqxpF94Ny3ucdEb32wveHQ/Xk
        Ym66r2DuGWzHjxrIvtMUFg4ZrRh8bOc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1624371159;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=QbRfcH+DeQMZvLrh/qht5MhB3BOBs1r6WfTDuqG2s08=;
        b=DK2aKmr/XEj334QxnHMxt79Hf4MMiRXI0NWhr+pZnCi43fhzQfQgUCKr7eA6KQx3eC/tx2
        628iNqELdnUozgAw==
Received: from imap3-int (imap-alt.suse-dmz.suse.de [192.168.254.47])
        by imap.suse.de (Postfix) with ESMTP id 5E242118DD;
        Tue, 22 Jun 2021 14:12:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1624371159; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=QbRfcH+DeQMZvLrh/qht5MhB3BOBs1r6WfTDuqG2s08=;
        b=CWVKuhu/PpenY5aOgMyITqGMCAZcxM0Jgxdc77oybuA6IbcygyKjyfCpw6PshKAkVuvvng
        +27W1trW0pC5kmcfnXOZhQb8t4yJgZgLY1Ui0JlPtr7gBmqxpF94Ny3ucdEb32wveHQ/Xk
        Ym66r2DuGWzHjxrIvtMUFg4ZrRh8bOc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1624371159;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=QbRfcH+DeQMZvLrh/qht5MhB3BOBs1r6WfTDuqG2s08=;
        b=DK2aKmr/XEj334QxnHMxt79Hf4MMiRXI0NWhr+pZnCi43fhzQfQgUCKr7eA6KQx3eC/tx2
        628iNqELdnUozgAw==
Received: from director2.suse.de ([192.168.254.72])
        by imap3-int with ESMTPSA
        id ANQvFdfv0WBRUgAALh3uQQ
        (envelope-from <pvorel@suse.cz>); Tue, 22 Jun 2021 14:12:39 +0000
From:   Petr Vorel <pvorel@suse.cz>
To:     linux-integrity@vger.kernel.org
Cc:     Petr Vorel <pvorel@suse.cz>, Mimi Zohar <zohar@linux.vnet.ibm.com>
Subject: [PATCH 3/3] CI: Introduce GitHub Actions setup
Date:   Tue, 22 Jun 2021 16:12:24 +0200
Message-Id: <20210622141224.25006-4-pvorel@suse.cz>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210622141224.25006-1-pvorel@suse.cz>
References: <20210622141224.25006-1-pvorel@suse.cz>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Travis is unreliable due "pull rate limit" issue, workaround does not
work any more. Also GitHub Actions is a recommended way for projects
hosted on GitHub.

Nice bonus is that manual podman activation for distros using glibc >=
2.33 (e.g. openSUSE Tumbleweed, Fedora) it's not needed in GitHub.

Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
 .github/workflows/ci.yml | 121 +++++++++++++++++++++++++++++++++++++++
 1 file changed, 121 insertions(+)
 create mode 100644 .github/workflows/ci.yml

diff --git a/.github/workflows/ci.yml b/.github/workflows/ci.yml
new file mode 100644
index 0000000..f08733a
--- /dev/null
+++ b/.github/workflows/ci.yml
@@ -0,0 +1,121 @@
+# Copyright (c) 2021 Petr Vorel <pvorel@suse.cz>
+name: "distros"
+on: [push, pull_request]
+
+jobs:
+  job:
+    runs-on: ubuntu-latest
+
+    strategy:
+      fail-fast: false
+      matrix:
+        include:
+          # 32bit build
+          - container: "debian:stable"
+            env:
+              CC: gcc
+              ARCH: i386
+              TSS: tpm2-tss
+              VARIANT: i386
+
+          # cross compilation builds
+          - container: "debian:stable"
+            env:
+              ARCH: ppc64el
+              CC: powerpc64le-linux-gnu-gcc
+              TSS: ibmtss
+              VARIANT: cross-compile
+
+          - container: "debian:stable"
+            env:
+              ARCH: arm64
+              CC: aarch64-linux-gnu-gcc
+              TSS: tpm2-tss
+              VARIANT: cross-compile
+
+          - container: "debian:stable"
+            env:
+              ARCH: s390x
+              CC: s390x-linux-gnu-gcc
+              TSS: ibmtss
+              VARIANT: cross-compile
+
+          # musl (native)
+          - container: "alpine:latest"
+            env:
+              CC: gcc
+              TSS: tpm2-tss
+
+          # glibc (gcc/clang)
+          - container: "opensuse/tumbleweed"
+            env:
+              CC: clang
+              TSS: ibmtss
+
+          - container: "opensuse/leap"
+            env:
+              CC: gcc
+              TSS: tpm2-tss
+
+          - container: "ubuntu:groovy"
+            env:
+              CC: gcc
+              TSS: ibmtss
+
+          - container: "ubuntu:xenial"
+            env:
+              CC: clang
+              TSS: tpm2-tss
+
+          - container: "fedora:latest"
+            env:
+              CC: clang
+              TSS: ibmtss
+
+          - container: "centos:7"
+            env:
+              CC: gcc
+              TSS: tpm2-tss
+
+          - container: "centos:latest"
+            env:
+              CC: gcc
+              TSS: tpm2-tss
+
+          - container: "debian:testing"
+            env:
+              CC: clang
+              TSS: tpm2-tss
+
+          - container: "debian:stable"
+            env:
+              CC: clang
+              TSS: ibmtss
+
+    container:
+      image: ${{ matrix.container }}
+      env: ${{ matrix.env }}
+
+    steps:
+    - name: Show OS
+      run: cat /etc/os-release
+
+    - name: Git checkout
+      uses: actions/checkout@v1
+
+    - name: Install additional packages
+      run: |
+        INSTALL=${{ matrix.container }}
+        INSTALL="${INSTALL%%:*}"
+        INSTALL="${INSTALL%%/*}"
+        if [ "$VARIANT" ]; then ARCH="$ARCH" ./ci/$INSTALL.$VARIANT.sh; fi
+        ARCH="$ARCH" CC="$CC" TSS="$TSS" ./ci/$INSTALL.sh
+
+    - name: Build swtpm
+      run: if [ ! "$VARIANT" ]; then which tpm_server || which swtpm || ./tests/install-swtpm.sh; fi
+
+    - name: Compiler version
+      run: $CC --version
+
+    - name: Compile
+      run: CC="$CC" VARIANT="$VARIANT" ./build.sh
-- 
2.32.0

