Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 23B35564B02
	for <lists+linux-integrity@lfdr.de>; Mon,  4 Jul 2022 03:00:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229471AbiGDBAb (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Sun, 3 Jul 2022 21:00:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229450AbiGDBAb (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Sun, 3 Jul 2022 21:00:31 -0400
Received: from mail-m972.mail.163.com (mail-m972.mail.163.com [123.126.97.2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id CF4FD25F6;
        Sun,  3 Jul 2022 18:00:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=jzC9q
        teMihzoRDzWXOyq7ds47NBYNyeOA6hb71U3VdU=; b=H+NEAKielNlgZocGG050p
        9TuCgpW1y+pR3a0/uYx6PObBwhMEPwuaNCaXE6OTAouFTHxt88+Ki7X6A3Q9EjNI
        B2VSr6BmT19bngDjQLbd3w/WsCPFGYNygVYWbIYDCgtk8BggsJCdseaatnI7YGSc
        6PlwnkoswJdGSV6DpbXrEI=
Received: from localhost.localdomain (unknown [123.112.69.106])
        by smtp2 (Coremail) with SMTP id GtxpCgC3vw95O8Ji6QXPNA--.21733S4;
        Mon, 04 Jul 2022 09:00:07 +0800 (CST)
From:   Jianglei Nie <niejianglei2021@163.com>
To:     zohar@linux.ibm.com, dmitry.kasatkin@gmail.com, jmorris@namei.org,
        serge@hallyn.com
Cc:     linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Jianglei Nie <niejianglei2021@163.com>
Subject: [PATCH] ima/evm: Fix potential memory leak in ima_init_crypto()
Date:   Mon,  4 Jul 2022 08:59:32 +0800
Message-Id: <20220704005932.2217025-1-niejianglei2021@163.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: GtxpCgC3vw95O8Ji6QXPNA--.21733S4
X-Coremail-Antispam: 1Uf129KBjvdXoW7Gw13Xw47KF1DAFWxuF1ftFb_yoWfuwbE93
        90934xX347Za1kX3yjvFZ2vrW0grWkCFy0gry2ywnrCa45Ar45WF17JFs3J34UArWUJr4q
        gws8JFW2ywnFqjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUvcSsGvfC2KfnxnUUI43ZEXa7xREsXoDUUUUU==
X-Originating-IP: [123.112.69.106]
X-CM-SenderInfo: xqlhyxxdqjzvrlsqjii6rwjhhfrp/1tbiFRc0jF5mLnq5LgAAsB
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

ima_init_crypto() allocates a memory chunk for "ima_algo_array" with
kcalloc(). When some errors occur, the function jumps to "out_array"
and releases the "ima_algo_array[i].tfm". But "ima_algo_array" is
not released, which will lead to a memory leak.

We can release the ima_algo_array with kfree() when some errors occur
to fix the memory leak.

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

