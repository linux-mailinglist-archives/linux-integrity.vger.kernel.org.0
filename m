Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6447B489AA5
	for <lists+linux-integrity@lfdr.de>; Mon, 10 Jan 2022 14:50:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234069AbiAJNuJ (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 10 Jan 2022 08:50:09 -0500
Received: from smtp-out1.suse.de ([195.135.220.28]:36562 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230451AbiAJNuI (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 10 Jan 2022 08:50:08 -0500
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 84BB52113D;
        Mon, 10 Jan 2022 13:50:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1641822606; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=IrWBD7TI68EgG0wGR5MEbMvcsfaxaq2AlRDdyvro99A=;
        b=ER1Ig+kbKfqELKLQrCGR4puUWqX6nCfeVapfUC/iwt8mKZSH5Eb5QxJkzoCz349hh+vda3
        ND0UIkio8l1y074bT+8Cx3bcYBYAk/3A9t5OBSZcuoTb9iY1d9oxCMN+ZWXhQ7ucYrmOrT
        Susl5as4RKjIOsQf356SIK5FmFphnc4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1641822606;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=IrWBD7TI68EgG0wGR5MEbMvcsfaxaq2AlRDdyvro99A=;
        b=kfcNRT7fN0cSjMRFNOlh5Fuwd3Ka9aRohhgvnb0dWnDJZ7eLXBC64pNyypsWLev+JfRBMo
        jw9CVIqrPigKGuDQ==
Received: from kitsune.suse.cz (kitsune.suse.cz [10.100.12.127])
        by relay2.suse.de (Postfix) with ESMTP id 40348A3B81;
        Mon, 10 Jan 2022 13:50:06 +0000 (UTC)
From:   Michal Suchanek <msuchanek@suse.de>
To:     keyrings@vger.kernel.org, linux-crypto@vger.kernel.org,
        linux-integrity@vger.kernel.org
Cc:     Michal Suchanek <msuchanek@suse.de>, kexec@lists.infradead.org,
        Philipp Rudo <prudo@redhat.com>,
        Mimi Zohar <zohar@linux.ibm.com>,
        Nayna <nayna@linux.vnet.ibm.com>, Rob Herring <robh@kernel.org>,
        linux-s390@vger.kernel.org, Vasily Gorbik <gor@linux.ibm.com>,
        Lakshmi Ramasubramanian <nramas@linux.microsoft.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        Jessica Yu <jeyu@kernel.org>, linux-kernel@vger.kernel.org,
        David Howells <dhowells@redhat.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Paul Mackerras <paulus@samba.org>,
        Hari Bathini <hbathini@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        linuxppc-dev@lists.ozlabs.org,
        Frank van der Linden <fllinden@amazon.com>,
        Thiago Jung Bauermann <bauerman@linux.ibm.com>,
        Daniel Axtens <dja@axtens.net>, buendgen@de.ibm.com,
        Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>,
        Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        Baoquan He <bhe@redhat.com>,
        linux-security-module@vger.kernel.org
Subject: [PATCH v4 1/6] s390/kexec_file: Don't opencode appended signature check.
Date:   Mon, 10 Jan 2022 14:49:53 +0100
Message-Id: <940cd6a0e88793060cdf5ddb7880c03564b38bdd.1641822505.git.msuchanek@suse.de>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1641822505.git.msuchanek@suse.de>
References: <cover.1641822505.git.msuchanek@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Module verification already implements appeded signature check.

Reuse it for kexec_file.

The kexec_file implementation uses EKEYREJECTED error in some cases when
there is no key and the common implementation uses ENOPKG or EBADMSG
instead.

Signed-off-by: Michal Suchanek <msuchanek@suse.de>
Acked-by: Heiko Carstens <hca@linux.ibm.com>
---
v3: Philipp Rudo <prudo@redhat.com>: Update the commit with note about
change of return value
---
 arch/s390/kernel/machine_kexec_file.c | 22 +++++-----------------
 1 file changed, 5 insertions(+), 17 deletions(-)

diff --git a/arch/s390/kernel/machine_kexec_file.c b/arch/s390/kernel/machine_kexec_file.c
index 8f43575a4dd3..c944d71316c7 100644
--- a/arch/s390/kernel/machine_kexec_file.c
+++ b/arch/s390/kernel/machine_kexec_file.c
@@ -31,6 +31,7 @@ int s390_verify_sig(const char *kernel, unsigned long kernel_len)
 	const unsigned long marker_len = sizeof(MODULE_SIG_STRING) - 1;
 	struct module_signature *ms;
 	unsigned long sig_len;
+	int ret;
 
 	/* Skip signature verification when not secure IPLed. */
 	if (!ipl_secure_flag)
@@ -45,25 +46,12 @@ int s390_verify_sig(const char *kernel, unsigned long kernel_len)
 	kernel_len -= marker_len;
 
 	ms = (void *)kernel + kernel_len - sizeof(*ms);
-	kernel_len -= sizeof(*ms);
+	ret = mod_check_sig(ms, kernel_len, "kexec");
+	if (ret)
+		return ret;
 
 	sig_len = be32_to_cpu(ms->sig_len);
-	if (sig_len >= kernel_len)
-		return -EKEYREJECTED;
-	kernel_len -= sig_len;
-
-	if (ms->id_type != PKEY_ID_PKCS7)
-		return -EKEYREJECTED;
-
-	if (ms->algo != 0 ||
-	    ms->hash != 0 ||
-	    ms->signer_len != 0 ||
-	    ms->key_id_len != 0 ||
-	    ms->__pad[0] != 0 ||
-	    ms->__pad[1] != 0 ||
-	    ms->__pad[2] != 0) {
-		return -EBADMSG;
-	}
+	kernel_len -= sizeof(*ms) + sig_len;
 
 	return verify_pkcs7_signature(kernel, kernel_len,
 				      kernel + kernel_len, sig_len,
-- 
2.31.1

