Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AF203482602
	for <lists+linux-integrity@lfdr.de>; Fri, 31 Dec 2021 23:29:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231858AbhLaW3b (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 31 Dec 2021 17:29:31 -0500
Received: from smtp-out1.suse.de ([195.135.220.28]:40448 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231847AbhLaW3b (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 31 Dec 2021 17:29:31 -0500
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 2A0DA210FF;
        Fri, 31 Dec 2021 22:29:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1640989770; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=Zqz/nLv4xy1k6FLgWNgvIY7O4BNh3elKyAnzN+T4YXU=;
        b=AaAYM/6Lji3G5AcBW4kdGj2Y2TcKuU2gGm04ic1iGWJFs0YyF43jaFoGGXlNJDhsNTDGzX
        JNx4u1oRnFaJZezkyWWVun/SZ2h8jJVooA5MNnEE36e00pzxu+LshovUz1dntiN+muHBLG
        LVRl+7vW0XRjfHprWLKIlQT0pbMCtpI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1640989770;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=Zqz/nLv4xy1k6FLgWNgvIY7O4BNh3elKyAnzN+T4YXU=;
        b=SWfzY4RI1qRxqYC2iBMgTGM2isWYFnzs1S6jiMpN/iOy3IhJQ8acsziy4ETPvWKVcAYllD
        D1HeI27SKkob+yAg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 004321346E;
        Fri, 31 Dec 2021 22:29:29 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id iJTdOUmEz2F1ZQAAMHmgww
        (envelope-from <pvorel@suse.cz>); Fri, 31 Dec 2021 22:29:29 +0000
From:   Petr Vorel <pvorel@suse.cz>
To:     linux-integrity@vger.kernel.org
Cc:     Petr Vorel <petr.vorel@gmail.com>, Mimi Zohar <zohar@linux.ibm.com>
Subject: [PATCH ima-evm-utils] ci: Replace groovy -> impish
Date:   Fri, 31 Dec 2021 23:29:16 +0100
Message-Id: <20211231222916.12994-1-pvorel@suse.cz>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

From: Petr Vorel <petr.vorel@gmail.com>

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
---
 .github/workflows/ci.yml | 2 +-
 ci/debian.sh             | 3 +++
 2 files changed, 4 insertions(+), 1 deletion(-)

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

