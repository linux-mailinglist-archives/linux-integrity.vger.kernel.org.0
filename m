Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 96E9156D6AB
	for <lists+linux-integrity@lfdr.de>; Mon, 11 Jul 2022 09:22:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230081AbiGKHWv (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 11 Jul 2022 03:22:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229978AbiGKHWv (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 11 Jul 2022 03:22:51 -0400
Received: from mail-m971.mail.163.com (mail-m971.mail.163.com [123.126.97.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 5DCB41055F;
        Mon, 11 Jul 2022 00:22:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=AH2Ez
        WZfnJV6fIlvat5MXanKCwJ4URf7qbM1gSDXMpI=; b=G4RNUrAD7r0CRtlLAAib5
        sRtXfps0BpUR+wIHr92y0A5J5zsfltOS2VKQQGYk9gTvfR2I3zmInh+PokMhzJqK
        I+4InpAN1vrUyHIi2hIg6hKRQG1j8AAPJNZdU6yxdyJl9y2eacwJB8ez1bNf2Fc3
        BhxNPLKsTa2yzSn66+MtZA=
Received: from localhost.localdomain (unknown [123.112.69.106])
        by smtp1 (Coremail) with SMTP id GdxpCgBnpeabz8tisz21Ng--.19861S4;
        Mon, 11 Jul 2022 15:22:16 +0800 (CST)
From:   Jianglei Nie <niejianglei2021@163.com>
To:     zohar@linux.ibm.com, dmitry.kasatkin@gmail.com, jmorris@namei.org,
        serge@hallyn.com
Cc:     linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Jianglei Nie <niejianglei2021@163.com>
Subject: [PATCH] ima/evm: Fix potential memory leak in ima_init_crypto()
Date:   Mon, 11 Jul 2022 15:22:02 +0800
Message-Id: <20220711072202.2319030-1-niejianglei2021@163.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: GdxpCgBnpeabz8tisz21Ng--.19861S4
X-Coremail-Antispam: 1Uf129KBjvdXoWrtFWfKFy8ZF1fCw48CFWxJFb_yoWxuFgE9a
        s0934xW3W7Zan3ZayjvFZ7ZF4vgrZ5XFyFgr9IywnruFy3Cr45Xa47Xrs3Jry8AryUAF4q
        ga98JFW2kwnFgjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUvcSsGvfC2KfnxnUUI43ZEXa7xREs2-3UUUUU==
X-Originating-IP: [123.112.69.106]
X-CM-SenderInfo: xqlhyxxdqjzvrlsqjii6rwjhhfrp/xtbBOQg7jF-PObrQ9QAAsw
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

This patch adds the missing kfree() for ima_algo_array allocated by
kcalloc() to avoid potential memory leak.

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

