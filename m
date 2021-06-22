Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2D6373B0721
	for <lists+linux-integrity@lfdr.de>; Tue, 22 Jun 2021 16:12:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231933AbhFVOOz (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 22 Jun 2021 10:14:55 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:35070 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231883AbhFVOOz (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 22 Jun 2021 10:14:55 -0400
Received: from imap.suse.de (imap-alt.suse-dmz.suse.de [192.168.254.47])
        (using TLSv1.2 with cipher ECDHE-ECDSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 089CD1FD6A;
        Tue, 22 Jun 2021 14:12:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1624371159; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=PaspphYiHj3SI+qd/luii+n9xcQYgL6nh6i8lOBU/Yo=;
        b=lUaKDmGSj7kGzwP1uXAhaAgHy+Mkn6CHaPBW9Tj2fcAkWMaz+TqheYW/Y2htGthSlfyF3s
        GbIOeLwb6VeH6TUFS4f1F5gDSgna3UisQuQxtieJpwRtTeoRFsQfsBX+1/QA9gfiG2FHE9
        rTCMKVPNzWt3jmOw3+Dcg7x+sqC9v4c=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1624371159;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=PaspphYiHj3SI+qd/luii+n9xcQYgL6nh6i8lOBU/Yo=;
        b=l0pAnxgrxSFnDWufcjoUjG6ptwGXhJmPRdb+ZJE7F+cySl/ytBdYSy1lBl8fyL04fkVPUt
        a8NQGYccYTo966Aw==
Received: from imap3-int (imap-alt.suse-dmz.suse.de [192.168.254.47])
        by imap.suse.de (Postfix) with ESMTP id BFDD8118DD;
        Tue, 22 Jun 2021 14:12:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1624371159; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=PaspphYiHj3SI+qd/luii+n9xcQYgL6nh6i8lOBU/Yo=;
        b=lUaKDmGSj7kGzwP1uXAhaAgHy+Mkn6CHaPBW9Tj2fcAkWMaz+TqheYW/Y2htGthSlfyF3s
        GbIOeLwb6VeH6TUFS4f1F5gDSgna3UisQuQxtieJpwRtTeoRFsQfsBX+1/QA9gfiG2FHE9
        rTCMKVPNzWt3jmOw3+Dcg7x+sqC9v4c=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1624371159;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=PaspphYiHj3SI+qd/luii+n9xcQYgL6nh6i8lOBU/Yo=;
        b=l0pAnxgrxSFnDWufcjoUjG6ptwGXhJmPRdb+ZJE7F+cySl/ytBdYSy1lBl8fyL04fkVPUt
        a8NQGYccYTo966Aw==
Received: from director2.suse.de ([192.168.254.72])
        by imap3-int with ESMTPSA
        id qAunLNbv0WBRUgAALh3uQQ
        (envelope-from <pvorel@suse.cz>); Tue, 22 Jun 2021 14:12:38 +0000
From:   Petr Vorel <pvorel@suse.cz>
To:     linux-integrity@vger.kernel.org
Cc:     Petr Vorel <pvorel@suse.cz>, Mimi Zohar <zohar@linux.vnet.ibm.com>
Subject: [PATCH 1/3] CI: Rename travis script directory
Date:   Tue, 22 Jun 2021 16:12:22 +0200
Message-Id: <20210622141224.25006-2-pvorel@suse.cz>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210622141224.25006-1-pvorel@suse.cz>
References: <20210622141224.25006-1-pvorel@suse.cz>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

This is a preparation for adding GitHub Actions support.

Also run from root directory. It's a bit confusing to run from
travis directory.

Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
 .travis.yml                            | 2 +-
 {travis => ci}/alpine.sh               | 0
 {travis => ci}/centos.sh               | 0
 {travis => ci}/debian.cross-compile.sh | 0
 {travis => ci}/debian.i386.sh          | 0
 {travis => ci}/debian.sh               | 0
 {travis => ci}/fedora.sh               | 0
 {travis => ci}/opensuse.sh             | 0
 {travis => ci}/tumbleweed.sh           | 0
 {travis => ci}/ubuntu.sh               | 0
 10 files changed, 1 insertion(+), 1 deletion(-)
 rename {travis => ci}/alpine.sh (100%)
 rename {travis => ci}/centos.sh (100%)
 rename {travis => ci}/debian.cross-compile.sh (100%)
 rename {travis => ci}/debian.i386.sh (100%)
 rename {travis => ci}/debian.sh (100%)
 rename {travis => ci}/fedora.sh (100%)
 rename {travis => ci}/opensuse.sh (100%)
 rename {travis => ci}/tumbleweed.sh (100%)
 rename {travis => ci}/ubuntu.sh (100%)

diff --git a/.travis.yml b/.travis.yml
index fde774e..5b07711 100644
--- a/.travis.yml
+++ b/.travis.yml
@@ -93,4 +93,4 @@ before_install:
 script:
     - INSTALL="${DISTRO%%:*}"
     - INSTALL="${INSTALL%%/*}"
-    - $CONTAINER run $CONTAINER_ARGS -t ima-evm-utils /bin/sh -c "cd travis && if [ \"$VARIANT\" ]; then ARCH=\"$ARCH\" ./$INSTALL.$VARIANT.sh; fi && ARCH=\"$ARCH\" CC=\"$CC\" TSS=\"$TSS\" ./$INSTALL.sh && if [ ! \"$VARIANT\" ]; then which tpm_server || which swtpm || ../tests/install-swtpm.sh; fi && CC=\"$CC\" VARIANT=\"$VARIANT\" ../build.sh"
+    - $CONTAINER run $CONTAINER_ARGS -t ima-evm-utils /bin/sh -c "if [ \"$VARIANT\" ]; then ARCH=\"$ARCH\" ./ci/$INSTALL.$VARIANT.sh; fi && ARCH=\"$ARCH\" CC=\"$CC\" TSS=\"$TSS\" ./ci/$INSTALL.sh && if [ ! \"$VARIANT\" ]; then which tpm_server || which swtpm || ./tests/install-swtpm.sh; fi && CC=\"$CC\" VARIANT=\"$VARIANT\" ./build.sh"
diff --git a/travis/alpine.sh b/ci/alpine.sh
similarity index 100%
rename from travis/alpine.sh
rename to ci/alpine.sh
diff --git a/travis/centos.sh b/ci/centos.sh
similarity index 100%
rename from travis/centos.sh
rename to ci/centos.sh
diff --git a/travis/debian.cross-compile.sh b/ci/debian.cross-compile.sh
similarity index 100%
rename from travis/debian.cross-compile.sh
rename to ci/debian.cross-compile.sh
diff --git a/travis/debian.i386.sh b/ci/debian.i386.sh
similarity index 100%
rename from travis/debian.i386.sh
rename to ci/debian.i386.sh
diff --git a/travis/debian.sh b/ci/debian.sh
similarity index 100%
rename from travis/debian.sh
rename to ci/debian.sh
diff --git a/travis/fedora.sh b/ci/fedora.sh
similarity index 100%
rename from travis/fedora.sh
rename to ci/fedora.sh
diff --git a/travis/opensuse.sh b/ci/opensuse.sh
similarity index 100%
rename from travis/opensuse.sh
rename to ci/opensuse.sh
diff --git a/travis/tumbleweed.sh b/ci/tumbleweed.sh
similarity index 100%
rename from travis/tumbleweed.sh
rename to ci/tumbleweed.sh
diff --git a/travis/ubuntu.sh b/ci/ubuntu.sh
similarity index 100%
rename from travis/ubuntu.sh
rename to ci/ubuntu.sh
-- 
2.32.0

