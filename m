Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E9EBA66721F
	for <lists+linux-integrity@lfdr.de>; Thu, 12 Jan 2023 13:26:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231934AbjALM0c (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 12 Jan 2023 07:26:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232498AbjALM0O (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 12 Jan 2023 07:26:14 -0500
Received: from frasgout11.his.huawei.com (frasgout11.his.huawei.com [14.137.139.23])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 022F04BD59
        for <linux-integrity@vger.kernel.org>; Thu, 12 Jan 2023 04:26:05 -0800 (PST)
Received: from mail02.huawei.com (unknown [172.18.147.229])
        by frasgout11.his.huawei.com (SkyGuard) with ESMTP id 4Nt3VK4Lvyz9xFQ7
        for <linux-integrity@vger.kernel.org>; Thu, 12 Jan 2023 20:18:17 +0800 (CST)
Received: from huaweicloud.com (unknown [10.204.63.22])
        by APP1 (Coremail) with SMTP id LxC2BwB3sg0f_L9jKjyOAA--.25294S11;
        Thu, 12 Jan 2023 13:25:53 +0100 (CET)
From:   Roberto Sassu <roberto.sassu@huaweicloud.com>
To:     zohar@linux.ibm.com, dmitry.kasatkin@gmail.com
Cc:     linux-integrity@vger.kernel.org, vt@altlinux.org, pvorel@suse.cz,
        stefanb@linux.ibm.com, Roberto Sassu <roberto.sassu@huawei.com>
Subject: [PATCH ima-evm-utils v2 9/9] ci: haveged requires EPEL on CentOS stream:8
Date:   Thu, 12 Jan 2023 13:24:26 +0100
Message-Id: <20230112122426.3759938-10-roberto.sassu@huaweicloud.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230112122426.3759938-1-roberto.sassu@huaweicloud.com>
References: <20230112122426.3759938-1-roberto.sassu@huaweicloud.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: LxC2BwB3sg0f_L9jKjyOAA--.25294S11
X-Coremail-Antispam: 1UD129KBjvdXoW7GFyfAF1xKF4rGw1kXFW8JFb_yoWfWwbE93
        yIgr4fJrs8Ar13Xrn8GFZaqr4FgrW2vw4Y9w1jqFyag347AFn7Kan3uws3ta1rWrZrWFZr
        WF4kJ34Fkw1SgjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUIcSsGvfJTRUUUb38YFVCjjxCrM7AC8VAFwI0_Wr0E3s1l1xkIjI8I6I8E6xAIw20E
        Y4v20xvaj40_Wr0E3s1l1IIY67AEw4v_Jr0_Jr4l82xGYIkIc2x26280x7IE14v26r126s
        0DM28IrcIa0xkI8VCY1x0267AKxVW5JVCq3wA2ocxC64kIII0Yj41l84x0c7CEw4AK67xG
        Y2AK021l84ACjcxK6xIIjxv20xvE14v26r1I6r4UM28EF7xvwVC0I7IYx2IY6xkF7I0E14
        v26F4j6r4UJwA2z4x0Y4vEx4A2jsIE14v26r4j6F4UM28EF7xvwVC2z280aVCY1x0267AK
        xVW8JVW8Jr1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2
        WlYx0E2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkE
        bVWUJVW8JwACjcxG0xvY0x0EwIxGrwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbV
        WUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF
        67kF1VAFwI0_JF0_Jw1lIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUCVW8JwCI42
        IY6xIIjxv20xvEc7CjxVAFwI0_Cr0_Gr1UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI
        42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWI
        evJa73UjIFyTuYvjxUFgAwUUUUU
X-CM-SenderInfo: purev21wro2thvvxqx5xdzvxpfor3voofrz/1tbiAgAPBF1jj4OGmAABsk
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

Fixes: 1a2d4767a8b1 ("Add support for UML in functions.sh")
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

