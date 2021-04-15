Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0DBF33609DE
	for <lists+linux-integrity@lfdr.de>; Thu, 15 Apr 2021 14:56:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230260AbhDOM5A (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 15 Apr 2021 08:57:00 -0400
Received: from mx2.suse.de ([195.135.220.15]:59180 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230056AbhDOM5A (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 15 Apr 2021 08:57:00 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 1A292B062;
        Thu, 15 Apr 2021 12:56:37 +0000 (UTC)
From:   Petr Vorel <pvorel@suse.cz>
To:     linux-integrity@vger.kernel.org
Cc:     Petr Vorel <pvorel@suse.cz>, Mimi Zohar <zohar@linux.vnet.ibm.com>
Subject: [PATCH 1/1] travis: Add Docker Hub pull rate limit workaround
Date:   Thu, 15 Apr 2021 14:56:30 +0200
Message-Id: <20210415125630.9672-1-pvorel@suse.cz>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Use mirror.gcr.io mirror for Docker to workaround pull rate limit in
docker registry to avoid common error:
anyrequests: You have reached your pull rate limit.

This still sometimes use docker registry, which can leads to occasional
failures, but less often.

Correct solution would be to migrate to Github Actions.

Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
Hi Mimi,

this expects to be applied after my 2 previous fixes ("travis: Fix
openSUSE Tumbleweed" and "tests/install-swtpm.sh: Add tar option
--no-same-owner"):
https://patchwork.kernel.org/project/linux-integrity/list/?series=467745&state=*

Tested:
https://travis-ci.org/github/pevik/ima-evm-utils/builds/767149815

Kind regards,
Petr

 .travis.yml | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/.travis.yml b/.travis.yml
index ac6b2a5..e96e52a 100644
--- a/.travis.yml
+++ b/.travis.yml
@@ -84,6 +84,17 @@ before_install:
             sudo curl -L https://github.com/opencontainers/runc/releases/download/v1.0.0-rc93/runc.amd64 -o /usr/bin/runc
             sudo chmod +x /usr/bin/runc
         fi
+
+    # Docker Hub pull rate limit workaround for docker
+    - >
+        if [ "$CONTAINER" = "docker" ]; then
+            conf="/etc/docker/daemon.json"
+            tmp=$(mktemp)
+            sudo jq '."registry-mirrors" += ["https://mirror.gcr.io"]' $conf > $tmp
+            sudo mv $tmp $conf
+            sudo systemctl daemon-reload
+            sudo systemctl restart docker
+        fi
     - $CONTAINER info
 
     - DIR="/usr/src/ima-evm-utils"
-- 
2.31.1

