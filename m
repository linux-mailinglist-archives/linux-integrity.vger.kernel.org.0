Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7742F4937DB
	for <lists+linux-integrity@lfdr.de>; Wed, 19 Jan 2022 10:59:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240104AbiASJ7i (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 19 Jan 2022 04:59:38 -0500
Received: from smtp-out2.suse.de ([195.135.220.29]:32906 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353398AbiASJ7f (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 19 Jan 2022 04:59:35 -0500
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 775F81F38B;
        Wed, 19 Jan 2022 09:59:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1642586374; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=yJWtzo4oDpj5YUSqXOdZch1U+beZ91913r4yS0RG5+k=;
        b=noDaMF9h4PmHZV7IXLbyJ2JPuwHaRluszG9mW0I+6Sue5duv4FaFDZ7gOnmKsG8zT7LIpF
        Lz9lt0e/3TKnz3BDl1bnNbhyimhXJ7YvP2+1xd3WpWGGAWVMUcytn4hV4u8oVVCyFSTeXU
        eUz+cDPTO17Hblk1JeUgE9RKGuCQ6zM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1642586374;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=yJWtzo4oDpj5YUSqXOdZch1U+beZ91913r4yS0RG5+k=;
        b=SicnGieLiceBTTcANfy0N6jkVCsZSqcXH3OanuDni4W+mOe30w90EgdutwYs0gGlxZYrUA
        aV5mzFzFag3TC5Ag==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 32F3413E11;
        Wed, 19 Jan 2022 09:59:34 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 8raeCQbh52EcOAAAMHmgww
        (envelope-from <pvorel@suse.cz>); Wed, 19 Jan 2022 09:59:34 +0000
From:   Petr Vorel <pvorel@suse.cz>
To:     linux-integrity@vger.kernel.org
Cc:     Petr Vorel <petr.vorel@gmail.com>,
        Mimi Zohar <zohar@linux.ibm.com>, Petr Vorel <pvorel@suse.cz>
Subject: [PATCH v2 1/1] ci: Replace groovy -> impish
Date:   Wed, 19 Jan 2022 10:59:30 +0100
Message-Id: <20220119095930.2742-1-pvorel@suse.cz>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

From: Petr Vorel <petr.vorel@gmail.com>

in both GitHub Actions and Travis.

groovy is EOL, which is probably the reason why it's archives has been
removed:

Ign:1 http://security.ubuntu.com/ubuntu groovy-security InRelease
Ign:2 http://archive.ubuntu.com/ubuntu groovy InRelease
Err:3 http://security.ubuntu.com/ubuntu groovy-security Release
  404  Not Found [IP: 91.189.91.39 80]
Ign:4 http://archive.ubuntu.com/ubuntu groovy-updates InRelease
Ign:5 http://archive.ubuntu.com/ubuntu groovy-backports InRelease
Err:6 http://archive.ubuntu.com/ubuntu groovy Release
  404  Not Found [IP: 91.189.88.142 80]
Err:7 http://archive.ubuntu.com/ubuntu groovy-updates Release
  404  Not Found [IP: 91.189.88.142 80]
Err:8 http://archive.ubuntu.com/ubuntu groovy-backports Release
  404  Not Found [IP: 91.189.88.142 80]
Reading package lists...
E: The repository 'http://security.ubuntu.com/ubuntu groovy-security Release' does not have a Release file.
E: The repository 'http://archive.ubuntu.com/ubuntu groovy Release' does not have a Release file.
E: The repository 'http://archive.ubuntu.com/ubuntu groovy-updates Release' does not have a Release file.
E: The repository 'http://archive.ubuntu.com/ubuntu groovy-backports Release' does not have a Release file.

Using impish requires to use workaround to avoid apt asking to
interactively configure tzdata.

Signed-off-by: Petr Vorel <petr.vorel@gmail.com>
Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
 .github/workflows/ci.yml | 2 +-
 .travis.yml              | 2 +-
 ci/debian.sh             | 3 +++
 3 files changed, 5 insertions(+), 2 deletions(-)

diff --git a/.github/workflows/ci.yml b/.github/workflows/ci.yml
index ad611ad..4316ede 100644
--- a/.github/workflows/ci.yml
+++ b/.github/workflows/ci.yml
@@ -59,7 +59,7 @@ jobs:
               CC: gcc
               TSS: tpm2-tss
 
-          - container: "ubuntu:groovy"
+          - container: "ubuntu:impish"
             env:
               CC: gcc
               TSS: ibmtss
diff --git a/.travis.yml b/.travis.yml
index 534c41d..bdf78a1 100644
--- a/.travis.yml
+++ b/.travis.yml
@@ -40,7 +40,7 @@ matrix:
           compiler: gcc
 
         - os: linux
-          env: DISTRO=ubuntu:groovy TSS=ibmtss COMPILE_SSL=openssl-3.0.0-beta1
+          env: DISTRO=ubuntu:impish TSS=ibmtss COMPILE_SSL=openssl-3.0.0-beta1
           compiler: gcc
 
         - os: linux
diff --git a/ci/debian.sh b/ci/debian.sh
index ae5c9c1..005b1f6 100755
--- a/ci/debian.sh
+++ b/ci/debian.sh
@@ -2,6 +2,9 @@
 # Copyright (c) 2020 Petr Vorel <pvorel@suse.cz>
 set -ex
 
+# workaround for Ubuntu impish asking to interactively configure tzdata
+export DEBIAN_FRONTEND="noninteractive"
+
 if [ -z "$CC" ]; then
 	echo "missing \$CC!" >&2
 	exit 1
-- 
2.34.1

