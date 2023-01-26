Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0505B67CD1F
	for <lists+linux-integrity@lfdr.de>; Thu, 26 Jan 2023 15:00:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231633AbjAZOAK (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 26 Jan 2023 09:00:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231971AbjAZN75 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 26 Jan 2023 08:59:57 -0500
Received: from frasgout11.his.huawei.com (frasgout11.his.huawei.com [14.137.139.23])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DDFBD6DFE8
        for <linux-integrity@vger.kernel.org>; Thu, 26 Jan 2023 05:59:39 -0800 (PST)
Received: from mail02.huawei.com (unknown [172.18.147.227])
        by frasgout11.his.huawei.com (SkyGuard) with ESMTP id 4P2hvF3J9hz9xFQP
        for <linux-integrity@vger.kernel.org>; Thu, 26 Jan 2023 21:51:21 +0800 (CST)
Received: from huaweicloud.com (unknown [10.204.63.22])
        by APP1 (Coremail) with SMTP id LxC2BwB39P_4htJj+ajLAA--.553S12;
        Thu, 26 Jan 2023 14:59:12 +0100 (CET)
From:   Roberto Sassu <roberto.sassu@huaweicloud.com>
To:     zohar@linux.ibm.com, dmitry.kasatkin@gmail.com
Cc:     linux-integrity@vger.kernel.org, vt@altlinux.org, pvorel@suse.cz,
        stefanb@linux.ibm.com, Roberto Sassu <roberto.sassu@huawei.com>
Subject: [PATCH ima-evm-utils v4 10/11] ci: haveged requires EPEL on CentOS stream:8
Date:   Thu, 26 Jan 2023 14:58:06 +0100
Message-Id: <20230126135807.1848668-11-roberto.sassu@huaweicloud.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230126135807.1848668-1-roberto.sassu@huaweicloud.com>
References: <20230126135807.1848668-1-roberto.sassu@huaweicloud.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: LxC2BwB39P_4htJj+ajLAA--.553S12
X-Coremail-Antispam: 1UD129KBjvdXoW7GFyfAF1xKFy7Wry3Ww15Jwb_yoWDGrgE93
        yIgr43Ar45Ar13Xr1rCFZYqr4FgrW2gw4Ygw1UXFy3Z347Arn3Kan3uw4vyan5WrWDurZr
        JF1kJryFkr17WjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUIcSsGvfJTRUUUb3xYFVCjjxCrM7AC8VAFwI0_Wr0E3s1l1xkIjI8I6I8E6xAIw20E
        Y4v20xvaj40_Wr0E3s1l1IIY67AEw4v_Jr0_Jr4l82xGYIkIc2x26280x7IE14v26r126s
        0DM28IrcIa0xkI8VCY1x0267AKxVW5JVCq3wA2ocxC64kIII0Yj41l84x0c7CEw4AK67xG
        Y2AK021l84ACjcxK6xIIjxv20xvE14v26r4j6ryUM28EF7xvwVC0I7IYx2IY6xkF7I0E14
        v26F4j6r4UJwA2z4x0Y4vEx4A2jsIE14v26r4j6F4UM28EF7xvwVC2z280aVCY1x0267AK
        xVW8Jr0_Cr1UM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7
        xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Y
        z7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7
        v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF
        1VAY17CE14v26r126r1DMIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Gr0_Xr1lIx
        AIcVC0I7IYx2IY6xkF7I0E14v26F4j6r4UJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4l
        IxAIcVC2z280aVAFwI0_Gr0_Cr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvf
        C2KfnxnUUI43ZEXa7IU13l1DUUUUU==
X-CM-SenderInfo: purev21wro2thvvxqx5xdzvxpfor3voofrz/1tbiAgAJBF1jj4Qi9AABst
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

From: Mimi Zohar <zohar@linux.ibm.com>

The travis "fedora:latest" matrix rule fails due to not finding
"haveged".  Install "haveged" after enabling EPEL.

Fixes: 992f60d573bc ("Add support for creating a new testing environment in functions.sh")
Reviewed-by: Stefan Berger <stefanb@linux.ibm.com>
Signed-off-by: Mimi Zohar <zohar@linux.ibm.com>
Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>
---
 ci/fedora.sh | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/ci/fedora.sh b/ci/fedora.sh
index 3f75d2e1ddbd..1d17c6bfb89d 100755
--- a/ci/fedora.sh
+++ b/ci/fedora.sh
@@ -46,7 +46,6 @@ yum -y install \
 	wget \
 	which \
 	zstd \
-	haveged \
 	systemd \
 	keyutils \
 	e2fsprogs \
@@ -62,5 +61,8 @@ if [ -f /etc/centos-release ]; then
 fi
 yum -y install softhsm || true
 
+# haveged is available via EPEL on CentOS stream8.
+yum -y install haveged || true
+
 ./tests/install-fsverity.sh
 ./tests/install-mount-idmapped.sh
-- 
2.25.1

