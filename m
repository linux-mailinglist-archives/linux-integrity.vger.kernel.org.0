Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0B1D25F2F9
	for <lists+linux-integrity@lfdr.de>; Thu,  4 Jul 2019 08:43:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727328AbfGDGnV (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 4 Jul 2019 02:43:21 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:19878 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727044AbfGDGnV (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 4 Jul 2019 02:43:21 -0400
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x646gTYN088943
        for <linux-integrity@vger.kernel.org>; Thu, 4 Jul 2019 02:43:19 -0400
Received: from e14.ny.us.ibm.com (e14.ny.us.ibm.com [129.33.205.204])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2th7t2891d-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-integrity@vger.kernel.org>; Thu, 04 Jul 2019 02:43:19 -0400
Received: from localhost
        by e14.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-integrity@vger.kernel.org> from <bauerman@linux.ibm.com>;
        Thu, 4 Jul 2019 07:43:18 +0100
Received: from b01cxnp22033.gho.pok.ibm.com (9.57.198.23)
        by e14.ny.us.ibm.com (146.89.104.201) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Thu, 4 Jul 2019 07:43:13 +0100
Received: from b01ledav005.gho.pok.ibm.com (b01ledav005.gho.pok.ibm.com [9.57.199.110])
        by b01cxnp22033.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x646hCHZ46399926
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 4 Jul 2019 06:43:12 GMT
Received: from b01ledav005.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 795ECAE05C;
        Thu,  4 Jul 2019 06:43:12 +0000 (GMT)
Received: from b01ledav005.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 97D51AE05F;
        Thu,  4 Jul 2019 06:43:07 +0000 (GMT)
Received: from morokweng.localdomain (unknown [9.85.146.222])
        by b01ledav005.gho.pok.ibm.com (Postfix) with ESMTPS;
        Thu,  4 Jul 2019 06:43:07 +0000 (GMT)
References: <20190628021934.4260-1-bauerman@linux.ibm.com> <20190628021934.4260-2-bauerman@linux.ibm.com> <20190701144752.GC25484@linux-8ccs>
User-agent: mu4e 1.2.0; emacs 26.2
From:   Thiago Jung Bauermann <bauerman@linux.ibm.com>
To:     Jessica Yu <jeyu@kernel.org>
Cc:     linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org, keyrings@vger.kernel.org,
        linux-crypto@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Mimi Zohar <zohar@linux.ibm.com>,
        Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        David Howells <dhowells@redhat.com>,
        David Woodhouse <dwmw2@infradead.org>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>,
        Jonathan Corbet <corbet@lwn.net>,
        "AKASHI\, Takahiro" <takahiro.akashi@linaro.org>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        Philipp Rudo <prudo@linux.ibm.com>, linux-s390@vger.kernel.org
Subject: Re: [PATCH v12 01/11] MODSIGN: Export module signature definitions
In-reply-to: <20190701144752.GC25484@linux-8ccs>
Date:   Thu, 04 Jul 2019 03:42:57 -0300
MIME-Version: 1.0
Content-Type: text/plain
X-TM-AS-GCONF: 00
x-cbid: 19070406-0052-0000-0000-000003DA4435
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00011376; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000286; SDB=6.01227187; UDB=6.00646127; IPR=6.01008424;
 MB=3.00027580; MTD=3.00000008; XFM=3.00000015; UTC=2019-07-04 06:43:18
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19070406-0053-0000-0000-000061901700
Message-Id: <87lfxel2q6.fsf@morokweng.localdomain>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-07-04_03:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1907040087
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org


Jessica Yu <jeyu@kernel.org> writes:

> +++ Thiago Jung Bauermann [27/06/19 23:19 -0300]:
>>IMA will use the module_signature format for append signatures, so export
>>the relevant definitions and factor out the code which verifies that the
>>appended signature trailer is valid.
>>
>>Also, create a CONFIG_MODULE_SIG_FORMAT option so that IMA can select it
>>and be able to use mod_check_sig() without having to depend on either
>>CONFIG_MODULE_SIG or CONFIG_MODULES.
>>
>>Signed-off-by: Thiago Jung Bauermann <bauerman@linux.ibm.com>
>>Reviewed-by: Mimi Zohar <zohar@linux.ibm.com>
>>Cc: Jessica Yu <jeyu@kernel.org>
>>---
>> include/linux/module.h           |  3 --
>> include/linux/module_signature.h | 44 +++++++++++++++++++++++++
>> init/Kconfig                     |  6 +++-
>> kernel/Makefile                  |  1 +
>> kernel/module.c                  |  1 +
>> kernel/module_signature.c        | 46 ++++++++++++++++++++++++++
>> kernel/module_signing.c          | 56 +++++---------------------------
>> scripts/Makefile                 |  2 +-
>> 8 files changed, 106 insertions(+), 53 deletions(-)
>>
>>diff --git a/include/linux/module.h b/include/linux/module.h
>>index 188998d3dca9..aa56f531cf1e 100644
>>--- a/include/linux/module.h
>>+++ b/include/linux/module.h
>>@@ -25,9 +25,6 @@
>> #include <linux/percpu.h>
>> #include <asm/module.h>
>>
>>-/* In stripped ARM and x86-64 modules, ~ is surprisingly rare. */
>>-#define MODULE_SIG_STRING "~Module signature appended~\n"
>>-
>
> Hi Thiago, apologies for the delay.

Hello Jessica, thanks for reviewing the patch!

> It looks like arch/s390/kernel/machine_kexec_file.c also relies on
> MODULE_SIG_STRING being defined, so module_signature.h will need to be
> included there too, otherwise we'll run into a compilation error.

Indeed. Thanks for spotting that. The patch below fixes it. It's
identical to the previous version except for the changes in 
arch/s390/kernel/machine_kexec_file.c and their description in the
commit message. I'm also copying some s390 people in this email.

> Other than that, the module-related changes look good to me:
>
> Acked-by: Jessica Yu <jeyu@kernel.org>

Thank you very much!

-- 
Thiago Jung Bauermann
IBM Linux Technology Center


From 0ca180c66f4cff8b1fcd51f3457cc06dac2f0e81 Mon Sep 17 00:00:00 2001
From: Thiago Jung Bauermann <bauerman@linux.ibm.com>
Date: Thu, 17 May 2018 21:46:12 -0300
Subject: [PATCH 1/1] MODSIGN: Export module signature definitions

IMA will use the module_signature format for append signatures, so export
the relevant definitions and factor out the code which verifies that the
appended signature trailer is valid.

Also, create a CONFIG_MODULE_SIG_FORMAT option so that IMA can select it
and be able to use mod_check_sig() without having to depend on either
CONFIG_MODULE_SIG or CONFIG_MODULES.

s390 duplicated the definition of struct module_signature so now they can
use the new <linux/module_signature.h> header instead.

Signed-off-by: Thiago Jung Bauermann <bauerman@linux.ibm.com>
Reviewed-by: Mimi Zohar <zohar@linux.ibm.com>
Acked-by: Jessica Yu <jeyu@kernel.org>
Cc: Heiko Carstens <heiko.carstens@de.ibm.com>
Cc: Philipp Rudo <prudo@linux.ibm.com>
---
 arch/s390/kernel/machine_kexec_file.c | 24 +-----------
 include/linux/module.h                |  3 --
 include/linux/module_signature.h      | 44 +++++++++++++++++++++
 init/Kconfig                          |  6 ++-
 kernel/Makefile                       |  1 +
 kernel/module.c                       |  1 +
 kernel/module_signature.c             | 46 ++++++++++++++++++++++
 kernel/module_signing.c               | 56 ++++-----------------------
 scripts/Makefile                      |  2 +-
 9 files changed, 107 insertions(+), 76 deletions(-)
 create mode 100644 include/linux/module_signature.h
 create mode 100644 kernel/module_signature.c

diff --git a/arch/s390/kernel/machine_kexec_file.c b/arch/s390/kernel/machine_kexec_file.c
index fbdd3ea73667..1ac9fbc6e01e 100644
--- a/arch/s390/kernel/machine_kexec_file.c
+++ b/arch/s390/kernel/machine_kexec_file.c
@@ -10,7 +10,7 @@
 #include <linux/elf.h>
 #include <linux/errno.h>
 #include <linux/kexec.h>
-#include <linux/module.h>
+#include <linux/module_signature.h>
 #include <linux/verification.h>
 #include <asm/boot_data.h>
 #include <asm/ipl.h>
@@ -23,28 +23,6 @@ const struct kexec_file_ops * const kexec_file_loaders[] = {
 };
 
 #ifdef CONFIG_KEXEC_VERIFY_SIG
-/*
- * Module signature information block.
- *
- * The constituents of the signature section are, in order:
- *
- *	- Signer's name
- *	- Key identifier
- *	- Signature data
- *	- Information block
- */
-struct module_signature {
-	u8	algo;		/* Public-key crypto algorithm [0] */
-	u8	hash;		/* Digest algorithm [0] */
-	u8	id_type;	/* Key identifier type [PKEY_ID_PKCS7] */
-	u8	signer_len;	/* Length of signer's name [0] */
-	u8	key_id_len;	/* Length of key identifier [0] */
-	u8	__pad[3];
-	__be32	sig_len;	/* Length of signature data */
-};
-
-#define PKEY_ID_PKCS7 2
-
 int s390_verify_sig(const char *kernel, unsigned long kernel_len)
 {
 	const unsigned long marker_len = sizeof(MODULE_SIG_STRING) - 1;
diff --git a/include/linux/module.h b/include/linux/module.h
index 188998d3dca9..aa56f531cf1e 100644
--- a/include/linux/module.h
+++ b/include/linux/module.h
@@ -25,9 +25,6 @@
 #include <linux/percpu.h>
 #include <asm/module.h>
 
-/* In stripped ARM and x86-64 modules, ~ is surprisingly rare. */
-#define MODULE_SIG_STRING "~Module signature appended~\n"
-
 /* Not Yet Implemented */
 #define MODULE_SUPPORTED_DEVICE(name)
 
diff --git a/include/linux/module_signature.h b/include/linux/module_signature.h
new file mode 100644
index 000000000000..523617fc5b6a
--- /dev/null
+++ b/include/linux/module_signature.h
@@ -0,0 +1,44 @@
+/* SPDX-License-Identifier: GPL-2.0+ */
+/*
+ * Module signature handling.
+ *
+ * Copyright (C) 2012 Red Hat, Inc. All Rights Reserved.
+ * Written by David Howells (dhowells@redhat.com)
+ */
+
+#ifndef _LINUX_MODULE_SIGNATURE_H
+#define _LINUX_MODULE_SIGNATURE_H
+
+/* In stripped ARM and x86-64 modules, ~ is surprisingly rare. */
+#define MODULE_SIG_STRING "~Module signature appended~\n"
+
+enum pkey_id_type {
+	PKEY_ID_PGP,		/* OpenPGP generated key ID */
+	PKEY_ID_X509,		/* X.509 arbitrary subjectKeyIdentifier */
+	PKEY_ID_PKCS7,		/* Signature in PKCS#7 message */
+};
+
+/*
+ * Module signature information block.
+ *
+ * The constituents of the signature section are, in order:
+ *
+ *	- Signer's name
+ *	- Key identifier
+ *	- Signature data
+ *	- Information block
+ */
+struct module_signature {
+	u8	algo;		/* Public-key crypto algorithm [0] */
+	u8	hash;		/* Digest algorithm [0] */
+	u8	id_type;	/* Key identifier type [PKEY_ID_PKCS7] */
+	u8	signer_len;	/* Length of signer's name [0] */
+	u8	key_id_len;	/* Length of key identifier [0] */
+	u8	__pad[3];
+	__be32	sig_len;	/* Length of signature data */
+};
+
+int mod_check_sig(const struct module_signature *ms, size_t file_len,
+		  const char *name);
+
+#endif /* _LINUX_MODULE_SIGNATURE_H */
diff --git a/init/Kconfig b/init/Kconfig
index 8b9ffe236e4f..c2286a3c74c5 100644
--- a/init/Kconfig
+++ b/init/Kconfig
@@ -1852,6 +1852,10 @@ config BASE_SMALL
 	default 0 if BASE_FULL
 	default 1 if !BASE_FULL
 
+config MODULE_SIG_FORMAT
+	def_bool n
+	select SYSTEM_DATA_VERIFICATION
+
 menuconfig MODULES
 	bool "Enable loadable module support"
 	option modules
@@ -1929,7 +1933,7 @@ config MODULE_SRCVERSION_ALL
 config MODULE_SIG
 	bool "Module signature verification"
 	depends on MODULES
-	select SYSTEM_DATA_VERIFICATION
+	select MODULE_SIG_FORMAT
 	help
 	  Check modules for valid signatures upon load: the signature
 	  is simply appended to the module. For more information see
diff --git a/kernel/Makefile b/kernel/Makefile
index 33824f0385b3..f29ae2997a43 100644
--- a/kernel/Makefile
+++ b/kernel/Makefile
@@ -58,6 +58,7 @@ endif
 obj-$(CONFIG_UID16) += uid16.o
 obj-$(CONFIG_MODULES) += module.o
 obj-$(CONFIG_MODULE_SIG) += module_signing.o
+obj-$(CONFIG_MODULE_SIG_FORMAT) += module_signature.o
 obj-$(CONFIG_KALLSYMS) += kallsyms.o
 obj-$(CONFIG_BSD_PROCESS_ACCT) += acct.o
 obj-$(CONFIG_CRASH_CORE) += crash_core.o
diff --git a/kernel/module.c b/kernel/module.c
index 6e6712b3aaf5..2712f4d217f5 100644
--- a/kernel/module.c
+++ b/kernel/module.c
@@ -19,6 +19,7 @@
 #include <linux/export.h>
 #include <linux/extable.h>
 #include <linux/moduleloader.h>
+#include <linux/module_signature.h>
 #include <linux/trace_events.h>
 #include <linux/init.h>
 #include <linux/kallsyms.h>
diff --git a/kernel/module_signature.c b/kernel/module_signature.c
new file mode 100644
index 000000000000..4224a1086b7d
--- /dev/null
+++ b/kernel/module_signature.c
@@ -0,0 +1,46 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Module signature checker
+ *
+ * Copyright (C) 2012 Red Hat, Inc. All Rights Reserved.
+ * Written by David Howells (dhowells@redhat.com)
+ */
+
+#include <linux/errno.h>
+#include <linux/printk.h>
+#include <linux/module_signature.h>
+#include <asm/byteorder.h>
+
+/**
+ * mod_check_sig - check that the given signature is sane
+ *
+ * @ms:		Signature to check.
+ * @file_len:	Size of the file to which @ms is appended.
+ * @name:	What is being checked. Used for error messages.
+ */
+int mod_check_sig(const struct module_signature *ms, size_t file_len,
+		  const char *name)
+{
+	if (be32_to_cpu(ms->sig_len) >= file_len - sizeof(*ms))
+		return -EBADMSG;
+
+	if (ms->id_type != PKEY_ID_PKCS7) {
+		pr_err("%s: Module is not signed with expected PKCS#7 message\n",
+		       name);
+		return -ENOPKG;
+	}
+
+	if (ms->algo != 0 ||
+	    ms->hash != 0 ||
+	    ms->signer_len != 0 ||
+	    ms->key_id_len != 0 ||
+	    ms->__pad[0] != 0 ||
+	    ms->__pad[1] != 0 ||
+	    ms->__pad[2] != 0) {
+		pr_err("%s: PKCS#7 signature info has unexpected non-zero params\n",
+		       name);
+		return -EBADMSG;
+	}
+
+	return 0;
+}
diff --git a/kernel/module_signing.c b/kernel/module_signing.c
index 6b9a926fd86b..cdd04a6b8074 100644
--- a/kernel/module_signing.c
+++ b/kernel/module_signing.c
@@ -11,37 +11,13 @@
 
 #include <linux/kernel.h>
 #include <linux/errno.h>
+#include <linux/module.h>
+#include <linux/module_signature.h>
 #include <linux/string.h>
 #include <linux/verification.h>
 #include <crypto/public_key.h>
 #include "module-internal.h"
 
-enum pkey_id_type {
-	PKEY_ID_PGP,		/* OpenPGP generated key ID */
-	PKEY_ID_X509,		/* X.509 arbitrary subjectKeyIdentifier */
-	PKEY_ID_PKCS7,		/* Signature in PKCS#7 message */
-};
-
-/*
- * Module signature information block.
- *
- * The constituents of the signature section are, in order:
- *
- *	- Signer's name
- *	- Key identifier
- *	- Signature data
- *	- Information block
- */
-struct module_signature {
-	u8	algo;		/* Public-key crypto algorithm [0] */
-	u8	hash;		/* Digest algorithm [0] */
-	u8	id_type;	/* Key identifier type [PKEY_ID_PKCS7] */
-	u8	signer_len;	/* Length of signer's name [0] */
-	u8	key_id_len;	/* Length of key identifier [0] */
-	u8	__pad[3];
-	__be32	sig_len;	/* Length of signature data */
-};
-
 /*
  * Verify the signature on a module.
  */
@@ -49,6 +25,7 @@ int mod_verify_sig(const void *mod, struct load_info *info)
 {
 	struct module_signature ms;
 	size_t sig_len, modlen = info->len;
+	int ret;
 
 	pr_devel("==>%s(,%zu)\n", __func__, modlen);
 
@@ -56,32 +33,15 @@ int mod_verify_sig(const void *mod, struct load_info *info)
 		return -EBADMSG;
 
 	memcpy(&ms, mod + (modlen - sizeof(ms)), sizeof(ms));
-	modlen -= sizeof(ms);
+
+	ret = mod_check_sig(&ms, modlen, info->name);
+	if (ret)
+		return ret;
 
 	sig_len = be32_to_cpu(ms.sig_len);
-	if (sig_len >= modlen)
-		return -EBADMSG;
-	modlen -= sig_len;
+	modlen -= sig_len + sizeof(ms);
 	info->len = modlen;
 
-	if (ms.id_type != PKEY_ID_PKCS7) {
-		pr_err("%s: Module is not signed with expected PKCS#7 message\n",
-		       info->name);
-		return -ENOPKG;
-	}
-
-	if (ms.algo != 0 ||
-	    ms.hash != 0 ||
-	    ms.signer_len != 0 ||
-	    ms.key_id_len != 0 ||
-	    ms.__pad[0] != 0 ||
-	    ms.__pad[1] != 0 ||
-	    ms.__pad[2] != 0) {
-		pr_err("%s: PKCS#7 signature info has unexpected non-zero params\n",
-		       info->name);
-		return -EBADMSG;
-	}
-
 	return verify_pkcs7_signature(mod, modlen, mod + modlen, sig_len,
 				      VERIFY_USE_SECONDARY_KEYRING,
 				      VERIFYING_MODULE_SIGNATURE,
diff --git a/scripts/Makefile b/scripts/Makefile
index 9d442ee050bd..52098b080ab7 100644
--- a/scripts/Makefile
+++ b/scripts/Makefile
@@ -17,7 +17,7 @@ hostprogs-$(CONFIG_VT)           += conmakehash
 hostprogs-$(BUILD_C_RECORDMCOUNT) += recordmcount
 hostprogs-$(CONFIG_BUILDTIME_EXTABLE_SORT) += sortextable
 hostprogs-$(CONFIG_ASN1)	 += asn1_compiler
-hostprogs-$(CONFIG_MODULE_SIG)	 += sign-file
+hostprogs-$(CONFIG_MODULE_SIG_FORMAT) += sign-file
 hostprogs-$(CONFIG_SYSTEM_TRUSTED_KEYRING) += extract-cert
 hostprogs-$(CONFIG_SYSTEM_EXTRA_CERTIFICATE) += insert-sys-cert
 

