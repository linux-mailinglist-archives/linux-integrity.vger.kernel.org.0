Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E03772F05E2
	for <lists+linux-integrity@lfdr.de>; Sun, 10 Jan 2021 09:04:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725807AbhAJIEI (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Sun, 10 Jan 2021 03:04:08 -0500
Received: from mail.zju.edu.cn ([61.164.42.155]:14318 "EHLO zju.edu.cn"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725783AbhAJIEH (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Sun, 10 Jan 2021 03:04:07 -0500
Received: from localhost.localdomain (unknown [222.205.25.254])
        by mail-app3 (Coremail) with SMTP id cC_KCgB3fyewtPpf7l49AA--.62276S4;
        Sun, 10 Jan 2021 16:03:02 +0800 (CST)
From:   Dinghao Liu <dinghao.liu@zju.edu.cn>
To:     dinghao.liu@zju.edu.cn, kjlu@umn.edu
Cc:     Mimi Zohar <zohar@linux.ibm.com>, James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        Dmitry Kasatkin <dmitry.kasatkin@nokia.com>,
        linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] [v2] evm: Fix memleak in init_desc
Date:   Sun, 10 Jan 2021 16:02:53 +0800
Message-Id: <20210110080253.32345-1-dinghao.liu@zju.edu.cn>
X-Mailer: git-send-email 2.17.1
X-CM-TRANSID: cC_KCgB3fyewtPpf7l49AA--.62276S4
X-Coremail-Antispam: 1UD129KBjvJXoW7tFWrurW3WFyDGw4kXrW5Jrb_yoW8Jw47pF
        15tayxJrZ5AFy8Gr97AFs5Cry3GayYyrW3t3y3Zw1ayF15Xr4ktrs7ArW8uFn8Jay8Ar1S
        y3ySvw13A3WjvaDanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUvI1xkIjI8I6I8E6xAIw20EY4v20xvaj40_Wr0E3s1l1IIY67AE
        w4v_Jr0_Jr4l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxSw2x7M28EF7xvwVC0I7IYx2
        IY67AKxVWDJVCq3wA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxVW8Jr0_Cr1UM28EF7xvwVC2
        z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E14v26rxl6s0DM2AIxVAIcxkEcV
        Aq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1j
        6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64
        vIr41lF7I21c0EjII2zVCS5cI20VAGYxC7MxkIecxEwVAFwVW8ZwCF04k20xvY0x0EwIxG
        rwCF04k20xvE74AGY7Cv6cx26r4fKr1UJr1l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxV
        Aqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q
        6r43MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6x
        kF7I0E14v26r1j6r4UMIIF0xvE42xK8VAvwI8IcIk0rVWrZr1j6s0DMIIF0xvEx4A2jsIE
        14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf
        9x0JUhdbbUUUUU=
X-CM-SenderInfo: qrrzjiaqtzq6lmxovvfxof0/1tbiAgoBBlZdtR6iiAAEsB
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

When kmalloc() fails, tmp_tfm allocated by
crypto_alloc_shash() has not been freed, which
leads to memleak.

Fixes: d46eb3699502b ("evm: crypto hash replaced by shash")
Signed-off-by: Dinghao Liu <dinghao.liu@zju.edu.cn>
---

Changelog:

v2: - Remove checks against tmp_tfm before freeing.
---
 security/integrity/evm/evm_crypto.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/security/integrity/evm/evm_crypto.c b/security/integrity/evm/evm_crypto.c
index 168c3b78ac47..a6dd47eb086d 100644
--- a/security/integrity/evm/evm_crypto.c
+++ b/security/integrity/evm/evm_crypto.c
@@ -73,7 +73,7 @@ static struct shash_desc *init_desc(char type, uint8_t hash_algo)
 {
 	long rc;
 	const char *algo;
-	struct crypto_shash **tfm, *tmp_tfm;
+	struct crypto_shash **tfm, *tmp_tfm = NULL;
 	struct shash_desc *desc;
 
 	if (type == EVM_XATTR_HMAC) {
@@ -118,13 +118,16 @@ static struct shash_desc *init_desc(char type, uint8_t hash_algo)
 alloc:
 	desc = kmalloc(sizeof(*desc) + crypto_shash_descsize(*tfm),
 			GFP_KERNEL);
-	if (!desc)
+	if (!desc) {
+		crypto_free_shash(tmp_tfm);
 		return ERR_PTR(-ENOMEM);
+	}
 
 	desc->tfm = *tfm;
 
 	rc = crypto_shash_init(desc);
 	if (rc) {
+		crypto_free_shash(tmp_tfm);
 		kfree(desc);
 		return ERR_PTR(rc);
 	}
-- 
2.17.1

