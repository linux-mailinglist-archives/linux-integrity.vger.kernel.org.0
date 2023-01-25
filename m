Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD6C767ACD9
	for <lists+linux-integrity@lfdr.de>; Wed, 25 Jan 2023 09:52:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234768AbjAYIwd (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 25 Jan 2023 03:52:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234745AbjAYIwc (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 25 Jan 2023 03:52:32 -0500
Received: from frasgout11.his.huawei.com (frasgout11.his.huawei.com [14.137.139.23])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B20F4116
        for <linux-integrity@vger.kernel.org>; Wed, 25 Jan 2023 00:52:31 -0800 (PST)
Received: from mail02.huawei.com (unknown [172.18.147.228])
        by frasgout11.his.huawei.com (SkyGuard) with ESMTP id 4P1y7d2mV3z9xHvZ
        for <linux-integrity@vger.kernel.org>; Wed, 25 Jan 2023 16:44:29 +0800 (CST)
Received: from huaweicloud.com (unknown [10.204.63.22])
        by APP1 (Coremail) with SMTP id LxC2BwD3fQmG7dBjf2fGAA--.15976S13;
        Wed, 25 Jan 2023 09:52:18 +0100 (CET)
From:   Roberto Sassu <roberto.sassu@huaweicloud.com>
To:     zohar@linux.ibm.com, dmitry.kasatkin@gmail.com
Cc:     linux-integrity@vger.kernel.org, vt@altlinux.org, pvorel@suse.cz,
        stefanb@linux.ibm.com, Roberto Sassu <roberto.sassu@huawei.com>
Subject: [PATCH ima-evm-utils v3 11/11] Temporarily remove CONFIG_DEBUG_SG to test portable signatures
Date:   Wed, 25 Jan 2023 09:50:30 +0100
Message-Id: <20230125085030.1568256-12-roberto.sassu@huaweicloud.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230125085030.1568256-1-roberto.sassu@huaweicloud.com>
References: <20230125085030.1568256-1-roberto.sassu@huaweicloud.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: LxC2BwD3fQmG7dBjf2fGAA--.15976S13
X-Coremail-Antispam: 1UD129KBjvdXoW7Xr4fWFWDKr4UAFWfZrWfGrg_yoWxKFb_Zr
        4fCw48Ar4UJr1xuF4fW3yxX3s2va4kXr1rWF15JF1aqF47KrWDWws5Gr45Ww45W3WUW3y3
        ZayrAF9IyryjqjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUIcSsGvfJTRUUUb38YFVCjjxCrM7AC8VAFwI0_Wr0E3s1l1xkIjI8I6I8E6xAIw20E
        Y4v20xvaj40_Wr0E3s1l1IIY67AEw4v_Jr0_Jr4l82xGYIkIc2x26280x7IE14v26r126s
        0DM28IrcIa0xkI8VCY1x0267AKxVW5JVCq3wA2ocxC64kIII0Yj41l84x0c7CEw4AK67xG
        Y2AK021l84ACjcxK6xIIjxv20xvE14v26r4j6ryUM28EF7xvwVC0I7IYx2IY6xkF7I0E14
        v26F4j6r4UJwA2z4x0Y4vEx4A2jsIE14v26r4j6F4UM28EF7xvwVC2z280aVCY1x0267AK
        xVW8JVW8Jr1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2
        WlYx0E2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkE
        bVWUJVW8JwACjcxG0xvY0x0EwIxGrwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbV
        WUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF
        67kF1VAFwI0_JF0_Jw1lIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVW8JVW5JwCI42
        IY6xIIjxv20xvEc7CjxVAFwI0_Cr0_Gr1UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI
        42IY6I8E87Iv67AKxVW8JVWxJwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWI
        evJa73UjIFyTuYvjxUFgAwUUUUU
X-CM-SenderInfo: purev21wro2thvvxqx5xdzvxpfor3voofrz/1tbiAQAIBF1jj4gLOQABsH
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

From: Mimi Zohar <zohar@linux.ibm.com>

Enabling CONFIG_DEBUG_SG requires two kernel fixes. For now don't
enable CONFIG_DEBUG_SG.

Fixes: 62b0afd25f38 ("Add config for UML kernel")
Signed-off-by: Mimi Zohar <zohar@linux.ibm.com>
Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>
---
 config-uml | 1 -
 1 file changed, 1 deletion(-)

diff --git a/config-uml b/config-uml
index 2d3bb8ba8edb..fcf2da7d2626 100644
--- a/config-uml
+++ b/config-uml
@@ -221,7 +221,6 @@ CONFIG_TRACE_IRQFLAGS=y
 CONFIG_DEBUG_IRQFLAGS=y
 CONFIG_DEBUG_LIST=y
 CONFIG_DEBUG_PLIST=y
-CONFIG_DEBUG_SG=y
 CONFIG_DEBUG_NOTIFIERS=y
 CONFIG_BUG_ON_DATA_CORRUPTION=y
 CONFIG_PROVE_RCU=y
-- 
2.25.1

