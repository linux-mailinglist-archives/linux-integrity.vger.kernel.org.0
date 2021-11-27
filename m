Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C6FF346004E
	for <lists+linux-integrity@lfdr.de>; Sat, 27 Nov 2021 17:49:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238160AbhK0Qwc (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Sat, 27 Nov 2021 11:52:32 -0500
Received: from bedivere.hansenpartnership.com ([96.44.175.130]:36144 "EHLO
        bedivere.hansenpartnership.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233676AbhK0Quc (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Sat, 27 Nov 2021 11:50:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
        d=hansenpartnership.com; s=20151216; t=1638031637;
        bh=BnMaFRu2u9lYF5O/Dz40XEb/zenFZ/1AZ2LtdiU9XmI=;
        h=From:To:Subject:Date:Message-Id:In-Reply-To:References:From;
        b=JMhhAOi63QwMeNZe+ZueSZIv4gf1F6ipxJ04Oqvg8vDo4pzFhXUaFljLPAJPtQJ3x
         XU+J8lI0RVjVAPcKyd/LauYOanV72KgtM97eNybVwvtx/2kSbaO3edf0ln7/00Kkkg
         608WNGvnETk6ShTe2ApJvh9E0gfgkaN1N6Z+RMQE=
Received: from localhost (localhost [127.0.0.1])
        by bedivere.hansenpartnership.com (Postfix) with ESMTP id E766312809ED;
        Sat, 27 Nov 2021 11:47:17 -0500 (EST)
Received: from bedivere.hansenpartnership.com ([127.0.0.1])
        by localhost (bedivere.hansenpartnership.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id bprGBakR3mfb; Sat, 27 Nov 2021 11:47:17 -0500 (EST)
Received: from rainbow.int.hansenpartnership.com (unknown [153.66.140.204])
        by bedivere.hansenpartnership.com (Postfix) with ESMTP id A29E31280693;
        Sat, 27 Nov 2021 11:47:16 -0500 (EST)
From:   James Bottomley <James.Bottomley@HansenPartnership.com>
To:     linux-integrity@vger.kernel.org
Cc:     containers@lists.linux.dev, Mimi Zohar <zohar@linux.ibm.com>,
        Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
        Stefan Berger <stefanb@linux.ibm.com>,
        "Eric W . Biederman" <ebiederm@xmission.com>,
        krzysztof.struczynski@huawei.com,
        Roberto Sassu <roberto.sassu@huawei.com>,
        "Serge E . Hallyn" <serge@hallyn.com>,
        Michael Peters <mpeters@redhat.com>,
        Luke Hinds <lhinds@redhat.com>,
        Lily Sturmann <lsturman@redhat.com>,
        Patrick Uiterwijk <puiterwi@redhat.com>,
        Christian Brauner <christian@brauner.io>
Subject: [RFC 2/3] ima: Namespace IMA
Date:   Sat, 27 Nov 2021 16:45:48 +0000
Message-Id: <20211127164549.2571457-3-James.Bottomley@HansenPartnership.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20211127164549.2571457-1-James.Bottomley@HansenPartnership.com>
References: <20211127164549.2571457-1-James.Bottomley@HansenPartnership.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Use the user namespace as the basis for namespacing IMA.  The
implementation is very simple: add a new template called 'ima-ns'
which exports the uuid of the user namespace into the IMA log.  This
can be used to uniquely separate every container in the IMA log.

Note that the admin of the user namespace still cannot read back the
IMA log because the IMA securityfs entries are not yet namespace
aware.  However, root in the init_user_ns can read the log and see the
containers.

You can get the uuid of init_user_ns from the boot_aggregate entry
which is always the first one recorded in the log.  Any execution with
a different uuid is in a new IMA namespace.

A sample of the log showing entry into a container is:

10 7766c926c9db8dd4c923f96be5635b04593029c1 ima-ns sha256:0000000000000000000000000000000000000000000000000000000000000000 boot_aggregate 6582e360-1354-42b9-a6ef-ee1993d982da
[...]
10 e0355132472d4d0ae1cc044412b4033bd5e1a48a ima-ns sha256:353e4d6b807056757fb5df31bafe7df80605bec20b445d5e9afd949ca4147d49 /usr/bin/unshare 6582e360-1354-42b9-a6ef-ee1993d982da
10 f257f5a12fd6e28d32b367a2e453c3badd0e8774 ima-ns sha256:2a7c66fc7e19acc100ee2b777b71179043fade8b81968828522cf31e6a96eaa7 /usr/bin/bash e496e384-4133-4d57-b93a-1812b83badf2
10 1bb206dbdf18f75e4515aeef378ba50e555a9291 ima-ns sha256:795fb52db49b211450c7242dbcad00d782a7b8174f669c259f74a7ccabe03a90 /usr/bin/id e496e384-4133-4d57-b93a-1812b83badf2

Signed-off-by: James Bottomley <James.Bottomley@HansenPartnership.com>
---
 include/linux/ima.h                       |  1 +
 security/integrity/ima/Kconfig            |  6 +++++-
 security/integrity/ima/ima_template.c     |  6 +++++-
 security/integrity/ima/ima_template_lib.c | 24 ++++++++++++++++++++++-
 security/integrity/ima/ima_template_lib.h |  4 ++++
 5 files changed, 38 insertions(+), 3 deletions(-)

diff --git a/include/linux/ima.h b/include/linux/ima.h
index b6ab66a546ae..09b14b73889e 100644
--- a/include/linux/ima.h
+++ b/include/linux/ima.h
@@ -11,6 +11,7 @@
 #include <linux/fs.h>
 #include <linux/security.h>
 #include <linux/kexec.h>
+#include <linux/user_namespace.h>
 #include <crypto/hash_info.h>
 struct linux_binprm;
 
diff --git a/security/integrity/ima/Kconfig b/security/integrity/ima/Kconfig
index f3a9cc201c8c..4f0ce241b585 100644
--- a/security/integrity/ima/Kconfig
+++ b/security/integrity/ima/Kconfig
@@ -69,7 +69,8 @@ choice
 	  hash, defined as 20 bytes, and a null terminated pathname,
 	  limited to 255 characters.  The 'ima-ng' measurement list
 	  template permits both larger hash digests and longer
-	  pathnames.
+	  pathnames.  The 'ima-ns' adds the namespace uuid to the
+	  'ima-ng' template.
 
 	config IMA_TEMPLATE
 		bool "ima"
@@ -77,6 +78,8 @@ choice
 		bool "ima-ng (default)"
 	config IMA_SIG_TEMPLATE
 		bool "ima-sig"
+	config IMA_NS_TEMPLATE
+		bool "ima-ns"
 endchoice
 
 config IMA_DEFAULT_TEMPLATE
@@ -85,6 +88,7 @@ config IMA_DEFAULT_TEMPLATE
 	default "ima" if IMA_TEMPLATE
 	default "ima-ng" if IMA_NG_TEMPLATE
 	default "ima-sig" if IMA_SIG_TEMPLATE
+	default "ima-ns" if IMA_NS_TEMPLATE
 
 choice
 	prompt "Default integrity hash algorithm"
diff --git a/security/integrity/ima/ima_template.c b/security/integrity/ima/ima_template.c
index 694560396be0..14e02eb3d0f3 100644
--- a/security/integrity/ima/ima_template.c
+++ b/security/integrity/ima/ima_template.c
@@ -24,6 +24,7 @@ static struct ima_template_desc builtin_templates[] = {
 	{.name = "ima-modsig", .fmt = "d-ng|n-ng|sig|d-modsig|modsig"},
 	{.name = "evm-sig",
 	 .fmt = "d-ng|n-ng|evmsig|xattrnames|xattrlengths|xattrvalues|iuid|igid|imode"},
+	{.name = "ima-ns", .fmt = "d-ng|n-ng|ns"},
 	{.name = "", .fmt = ""},	/* placeholder for a custom format */
 };
 
@@ -64,6 +65,9 @@ static const struct ima_template_field supported_fields[] = {
 	{.field_id = "xattrvalues",
 	 .field_init = ima_eventinodexattrvalues_init,
 	 .field_show = ima_show_template_sig},
+	{.field_id = "ns",
+	 .field_init = ima_ns_init,
+	 .field_show = ima_show_template_uuid},
 };
 
 /*
@@ -72,7 +76,7 @@ static const struct ima_template_field supported_fields[] = {
  * description as 'd-ng' and 'n-ng' respectively.
  */
 #define MAX_TEMPLATE_NAME_LEN \
-	sizeof("d-ng|n-ng|evmsig|xattrnames|xattrlengths|xattrvalues|iuid|igid|imode")
+	sizeof("d-ng|n-ng|evmsig|xattrnames|xattrlengths|xattrvalues|iuid|igid|imode|ns")
 
 static struct ima_template_desc *ima_template;
 static struct ima_template_desc *ima_buf_template;
diff --git a/security/integrity/ima/ima_template_lib.c b/security/integrity/ima/ima_template_lib.c
index ca017cae73eb..ebd54c1b5206 100644
--- a/security/integrity/ima/ima_template_lib.c
+++ b/security/integrity/ima/ima_template_lib.c
@@ -26,7 +26,8 @@ enum data_formats {
 	DATA_FMT_DIGEST_WITH_ALGO,
 	DATA_FMT_STRING,
 	DATA_FMT_HEX,
-	DATA_FMT_UINT
+	DATA_FMT_UINT,
+	DATA_FMT_UUID,
 };
 
 static int ima_write_template_field_data(const void *data, const u32 datalen,
@@ -120,6 +121,9 @@ static void ima_show_template_data_ascii(struct seq_file *m,
 			break;
 		}
 		break;
+	case DATA_FMT_UUID:
+		seq_printf(m, "%pU", buf_ptr);
+		break;
 	default:
 		break;
 	}
@@ -202,6 +206,12 @@ void ima_show_template_uint(struct seq_file *m, enum ima_show_type show,
 	ima_show_template_field_data(m, show, DATA_FMT_UINT, field_data);
 }
 
+void ima_show_template_uuid(struct seq_file *m, enum ima_show_type show,
+			    struct ima_field_data *field_data)
+{
+	ima_show_template_field_data(m, show, DATA_FMT_UUID, field_data);
+}
+
 /**
  * ima_parse_buf() - Parses lengths and data from an input buffer
  * @bufstartp:       Buffer start address.
@@ -685,3 +695,15 @@ int ima_eventinodexattrvalues_init(struct ima_event_data *event_data,
 {
 	return ima_eventinodexattrs_init_common(event_data, field_data, 'v');
 }
+
+/*
+ *  ima_ns_init - include the namespace UUID as part of the template
+ *  data
+ */
+int ima_ns_init(struct ima_event_data *event_data,
+		struct ima_field_data *field_data)
+{
+	return ima_write_template_field_data(&current_user_ns()->uuid,
+					     UUID_SIZE, DATA_FMT_UUID,
+					     field_data);
+}
diff --git a/security/integrity/ima/ima_template_lib.h b/security/integrity/ima/ima_template_lib.h
index c71f1de95753..6ea2156271ae 100644
--- a/security/integrity/ima/ima_template_lib.h
+++ b/security/integrity/ima/ima_template_lib.h
@@ -29,6 +29,8 @@ void ima_show_template_buf(struct seq_file *m, enum ima_show_type show,
 			   struct ima_field_data *field_data);
 void ima_show_template_uint(struct seq_file *m, enum ima_show_type show,
 			    struct ima_field_data *field_data);
+void ima_show_template_uuid(struct seq_file *m, enum ima_show_type show,
+			    struct ima_field_data *field_data);
 int ima_parse_buf(void *bufstartp, void *bufendp, void **bufcurp,
 		  int maxfields, struct ima_field_data *fields, int *curfields,
 		  unsigned long *len_mask, int enforce_mask, char *bufname);
@@ -62,4 +64,6 @@ int ima_eventinodexattrlengths_init(struct ima_event_data *event_data,
 				    struct ima_field_data *field_data);
 int ima_eventinodexattrvalues_init(struct ima_event_data *event_data,
 				   struct ima_field_data *field_data);
+int ima_ns_init(struct ima_event_data *event_data,
+		struct ima_field_data *field_data);
 #endif /* __LINUX_IMA_TEMPLATE_LIB_H */
-- 
2.33.0

