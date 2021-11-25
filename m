Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7D96245E045
	for <lists+linux-integrity@lfdr.de>; Thu, 25 Nov 2021 19:06:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351170AbhKYSIu (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 25 Nov 2021 13:08:50 -0500
Received: from smtp-out2.suse.de ([195.135.220.29]:57242 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233741AbhKYSGq (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 25 Nov 2021 13:06:46 -0500
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 42D491FD3C;
        Thu, 25 Nov 2021 18:03:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1637863413; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=l0S/rnnLVvNbU+CCOjj4LWqQa7IdIcdMPBDgplAns6U=;
        b=RKhgYgumwvJoAQSsGPnYDj+iUVI8D4UZ40tFmowliQAdb+89lTJC7fINQv+liE3oLpVdZq
        YWyf4GXI5PKsipvnNP50uqYRLdawaTMeuVaUdHSBeoIgikhELwOd+UyGUoyHE3JVXhoV4g
        Q6/6rzZKN12y3pGVkKq4HxT/rLs5MOM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1637863413;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=l0S/rnnLVvNbU+CCOjj4LWqQa7IdIcdMPBDgplAns6U=;
        b=uHz1kBfG6gD9l+Me+xoTs0h/Oult6KQZ0g+sXgatAGa3xXpm5190+t5RLzh1Pqhu85Rr3n
        6hfHDRALXl8O44BQ==
Received: from kitsune.suse.cz (kitsune.suse.cz [10.100.12.127])
        by relay2.suse.de (Postfix) with ESMTP id EC8B9A3B87;
        Thu, 25 Nov 2021 18:03:32 +0000 (UTC)
From:   Michal Suchanek <msuchanek@suse.de>
To:     keyrings@vger.kernel.org
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
        Baoquan He <bhe@redhat.com>, linux-crypto@vger.kernel.org,
        linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org
Subject: [PATCH v2 2/6] powerpc/kexec_file: Add KEXEC_SIG support.
Date:   Thu, 25 Nov 2021 19:02:40 +0100
Message-Id: <8b30a3c6a4e845eb77f276298424811897efdebf.1637862358.git.msuchanek@suse.de>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1637862358.git.msuchanek@suse.de>
References: <cover.1637862358.git.msuchanek@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Copy the code from s390x

Signed-off-by: Michal Suchanek <msuchanek@suse.de>
---
 arch/powerpc/Kconfig        | 11 +++++++++++
 arch/powerpc/kexec/elf_64.c | 36 ++++++++++++++++++++++++++++++++++++
 2 files changed, 47 insertions(+)

diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
index ac0c515552fd..ecc1227a77f1 100644
--- a/arch/powerpc/Kconfig
+++ b/arch/powerpc/Kconfig
@@ -561,6 +561,17 @@ config KEXEC_FILE
 config ARCH_HAS_KEXEC_PURGATORY
 	def_bool KEXEC_FILE
 
+config KEXEC_SIG
+	bool "Verify kernel signature during kexec_file_load() syscall"
+	depends on KEXEC_FILE && MODULE_SIG_FORMAT
+	help
+	  This option makes kernel signature verification mandatory for
+	  the kexec_file_load() syscall.
+
+	  In addition to that option, you need to enable signature
+	  verification for the corresponding kernel image type being
+	  loaded in order for this to work.
+
 config PPC64_BUILD_ELF_V2_ABI
 	bool
 
diff --git a/arch/powerpc/kexec/elf_64.c b/arch/powerpc/kexec/elf_64.c
index eeb258002d1e..25dc1071feec 100644
--- a/arch/powerpc/kexec/elf_64.c
+++ b/arch/powerpc/kexec/elf_64.c
@@ -23,6 +23,7 @@
 #include <linux/of_fdt.h>
 #include <linux/slab.h>
 #include <linux/types.h>
+#include <linux/verification.h>
 
 static void *elf64_load(struct kimage *image, char *kernel_buf,
 			unsigned long kernel_len, char *initrd,
@@ -151,7 +152,42 @@ static void *elf64_load(struct kimage *image, char *kernel_buf,
 	return ret ? ERR_PTR(ret) : NULL;
 }
 
+#ifdef CONFIG_KEXEC_SIG
+int elf64_verify_sig(const char *kernel, unsigned long kernel_len)
+{
+	const unsigned long marker_len = sizeof(MODULE_SIG_STRING) - 1;
+	struct module_signature *ms;
+	unsigned long sig_len;
+	int ret;
+
+	if (marker_len > kernel_len)
+		return -EKEYREJECTED;
+
+	if (memcmp(kernel + kernel_len - marker_len, MODULE_SIG_STRING,
+		   marker_len))
+		return -EKEYREJECTED;
+	kernel_len -= marker_len;
+
+	ms = (void *)kernel + kernel_len - sizeof(*ms);
+	ret = mod_check_sig(ms, kernel_len, "kexec");
+	if (ret)
+		return ret;
+
+	sig_len = be32_to_cpu(ms->sig_len);
+	kernel_len -= sizeof(*ms) + sig_len;
+
+	return verify_pkcs7_signature(kernel, kernel_len,
+				      kernel + kernel_len, sig_len,
+				      VERIFY_USE_PLATFORM_KEYRING,
+				      VERIFYING_MODULE_SIGNATURE,
+				      NULL, NULL);
+}
+#endif /* CONFIG_KEXEC_SIG */
+
 const struct kexec_file_ops kexec_elf64_ops = {
 	.probe = kexec_elf_probe,
 	.load = elf64_load,
+#ifdef CONFIG_KEXEC_SIG
+	.verify_sig = elf64_verify_sig,
+#endif
 };
-- 
2.31.1

