Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8C979570F3E
	for <lists+linux-integrity@lfdr.de>; Tue, 12 Jul 2022 03:11:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232137AbiGLBLW (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 11 Jul 2022 21:11:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231867AbiGLBLP (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 11 Jul 2022 21:11:15 -0400
Received: from mail-m974.mail.163.com (mail-m974.mail.163.com [123.126.97.4])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 7E79D2E685;
        Mon, 11 Jul 2022 18:11:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=KSCsx
        S2NdmSWWyRj4KxVCEpGTrIOLyeLRya+rvx2MKY=; b=ODEGnA0fZHxJX9fD3rh2i
        AZHpqjEcXbpFvxIvoebZR96iMenRDPOg9mbGPp/zl1AfsxIDxFcu0MoM4QtaW8L+
        Jtmhzm4+dynmWF8Geom2M0qg8Q7W+Hnnppgq//jG2Emc2ijSdFfnfMYlZvRCeraw
        6nhuhC0fO+kWT7tZMwQ5kU=
Received: from localhost.localdomain (unknown [123.112.69.106])
        by smtp4 (Coremail) with SMTP id HNxpCgCnkdkQysxil69dOA--.12930S4;
        Tue, 12 Jul 2022 09:10:55 +0800 (CST)
From:   Jianglei Nie <niejianglei2021@163.com>
To:     zohar@linux.ibm.com, dmitry.kasatkin@gmail.com, jmorris@namei.org,
        serge@hallyn.com
Cc:     linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Jianglei Nie <niejianglei2021@163.com>
Subject: [PATCH v2] ima/evm: Fix potential memory leak in ima_init_crypto()
Date:   Tue, 12 Jul 2022 09:10:37 +0800
Message-Id: <20220712011037.2328591-1-niejianglei2021@163.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: HNxpCgCnkdkQysxil69dOA--.12930S4
X-Coremail-Antispam: 1Uf129KBjvdXoW7Jry8WF4UtF18ur15GFyfJFb_yoW3WwcE9a
        s0934xXw17Zan5XayjvFZ7ZF4vgrZ5XFyFgryaywnrua43Cr45XFy7Xrs3JFy8uryUtF4q
        gws8JFW2kwnF9jkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUvcSsGvfC2KfnxnUUI43ZEXa7xREF1vPUUUUU==
X-Originating-IP: [123.112.69.106]
X-CM-SenderInfo: xqlhyxxdqjzvrlsqjii6rwjhhfrp/1tbiQxA8jFc7ajzTIAAAsq
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On failure to allocate the SHA1 tfm, IMA fails to initialize and exits
without freeing the ima_algo_array. Add the missing kfree() for
ima_algo_array to avoid the potential memory leak.

Signed-off-by: Jianglei Nie <niejianglei2021@163.com>
---
 security/integrity/ima/ima_crypto.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/security/integrity/ima/ima_crypto.c b/security/integrity/ima/ima_crypto.c
index a7206cc1d7d1..64499056648a 100644
--- a/security/integrity/ima/ima_crypto.c
+++ b/security/integrity/ima/ima_crypto.c
@@ -205,6 +205,7 @@ int __init ima_init_crypto(void)
 
 		crypto_free_shash(ima_algo_array[i].tfm);
 	}
+	kfree(ima_algo_array);
 out:
 	crypto_free_shash(ima_shash_tfm);
 	return rc;
-- 
2.25.1

