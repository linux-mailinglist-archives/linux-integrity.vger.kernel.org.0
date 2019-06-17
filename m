Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5770548167
	for <lists+linux-integrity@lfdr.de>; Mon, 17 Jun 2019 13:59:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726091AbfFQL7S (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 17 Jun 2019 07:59:18 -0400
Received: from mout.kundenserver.de ([212.227.17.10]:33899 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725763AbfFQL7S (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 17 Jun 2019 07:59:18 -0400
Received: from threadripper.lan ([149.172.19.189]) by mrelayeu.kundenserver.de
 (mreue109 [212.227.15.145]) with ESMTPA (Nemesis) id
 1N1Oft-1idn5x173T-012p0I; Mon, 17 Jun 2019 13:58:46 +0200
From:   Arnd Bergmann <arnd@arndb.de>
To:     Mimi Zohar <zohar@linux.ibm.com>,
        Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        Stefan Berger <stefanb@linux.vnet.ibm.com>,
        linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] ima: dynamically allocate shash_desc
Date:   Mon, 17 Jun 2019 13:20:37 +0200
Message-Id: <20190617115838.2397872-1-arnd@arndb.de>
X-Mailer: git-send-email 2.20.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:Aok4LcHbJEGe4AaznFIfACC7Rx178p41ovN43L+MyVducbpJUmo
 Ks3nYiQFYUumaQQDtFktb7FASBDgNt0aWrEmebIaB2QKuW7eKXp/C3mpmUcUcD6KVf3YWcB
 cHciwJcVESXqtHG5EZm3ls+ZpDxsTRQTdcm0F/UvIc6M6Ypeq63DAIUrs/oUOxrkLyMFvCw
 XFmMdwOf5uOdyLU9P5gpA==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:jHvm8xVNDAg=:2tQYUYi5EHZK8Jj9NnbR8R
 Eo7gZUfrH0IV231kubqyOXrM2KIdTUI7lkeT64oWq+/f71gkLCOBA3NzPI6XwDwGl8OwX+/5w
 yVDiKGLnOGCxf+S0vbTYzsRNBq76ZlUCUzWuIjpHVVGjeN5SAyE6MywStp8xA1h/cRWcK3cSx
 Bwgbt7JUQDgtp4jOKoxHjqlrVcLSbpbu8rpnkIYtSBmEobq2yDokeJyj1QugUmAg+hNXmMcM4
 pVvePhrtr24jnquz/odgNTRAHaD5VQY3uTcDpF6QdL9zrmy6UCL8SCxFf5EeaJeTzSiiW+uPk
 bCVCbyUWrELjuHEt22u1i1oJ2sBS1ldJ9xecgj7l+X+Sj5Jouj+A+Zbi5xcgrU/ngnLRiabOU
 5TLlpJZgM7xeHyJcibAzzh034agXYUkyVbw0mEZZW8Tjq5nL6IkBWYphrpAfGzFQ946pBaF1p
 nPVIq+92AGgeXZ3Cv0v7IQ2bLUq3YUj5fsawacZO1BG8fAaSf+EgYJsPg6RYip3gbP5uDLPyF
 Gi7rVAPX3uwg04Pe4uBMsw41abY2iVQBULvYBbFi9ohYBnVty966idrZjgx+Pyg3inltOFtVj
 M/fpwbgM2WhO2KGKKzFiiOs+uajZha0drkVdDo1ZbPf2NM+4BAb+90WhFspBAfibbneJlHCMx
 kakkUzVCB2p/ES21GFZU+Q2++wdThYh8RzHe6rYlRywsa2B879EEe/j1On0RzPHJxZa/QOEFJ
 3HYbjkqetrngw4zwpfpkit5NhMMqT6RJEFSXnA==
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On 32-bit ARM, we get a warning about excessive stack usage when
building with clang.

security/integrity/ima/ima_crypto.c:504:5: error: stack frame size of 1152 bytes in function 'ima_calc_field_array_hash' [-Werror,-Wframe-larger-than=]

Using kmalloc to get the descriptor reduces this to 320 bytes.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 security/integrity/ima/ima_crypto.c | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/security/integrity/ima/ima_crypto.c b/security/integrity/ima/ima_crypto.c
index d4c7b8e1b083..8a66bab4c435 100644
--- a/security/integrity/ima/ima_crypto.c
+++ b/security/integrity/ima/ima_crypto.c
@@ -461,16 +461,21 @@ static int ima_calc_field_array_hash_tfm(struct ima_field_data *field_data,
 					 struct ima_digest_data *hash,
 					 struct crypto_shash *tfm)
 {
-	SHASH_DESC_ON_STACK(shash, tfm);
+	struct shash_desc *shash;
 	int rc, i;
 
+	shash = kmalloc(sizeof(struct shash_desc) + crypto_shash_descsize(tfm),
+			GFP_KERNEL);
+	if (!shash)
+		return -ENOMEM;
+
 	shash->tfm = tfm;
 
 	hash->length = crypto_shash_digestsize(tfm);
 
 	rc = crypto_shash_init(shash);
 	if (rc != 0)
-		return rc;
+		goto out;
 
 	for (i = 0; i < num_fields; i++) {
 		u8 buffer[IMA_EVENT_NAME_LEN_MAX + 1] = { 0 };
@@ -497,7 +502,8 @@ static int ima_calc_field_array_hash_tfm(struct ima_field_data *field_data,
 
 	if (!rc)
 		rc = crypto_shash_final(shash, hash->digest);
-
+out:
+	kfree(shash);
 	return rc;
 }
 
-- 
2.20.0

