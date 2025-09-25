Return-Path: <linux-integrity+bounces-7280-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2FA48BA1FDD
	for <lists+linux-integrity@lfdr.de>; Fri, 26 Sep 2025 01:45:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 384D7741F63
	for <lists+linux-integrity@lfdr.de>; Thu, 25 Sep 2025 23:45:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B19012EFD8E;
	Thu, 25 Sep 2025 23:45:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="wsUcBhCT"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5CFF2727FD
	for <linux-integrity@vger.kernel.org>; Thu, 25 Sep 2025 23:45:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758843926; cv=none; b=Zu+u2HyRSHYRgVUYTC+8xEuk18txXHLlFHWeCqHeQgk9LQ+MuJJqnJMwbr0LLfd3ErRBH1mqv5c5ZvNSfLSk51jgsPuZCexzf7AmKrllLQ/lQdu6tUyL+d/1DmHahay5MF0FEi6xZFzSclTi9ngTIx9dqXXhT3cTLuVUA3O73Js=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758843926; c=relaxed/simple;
	bh=zc5PDYPZ7GdBtFvuYFvu8FWqBQP+b/s/g+l/C+lBL/A=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=fMBkul4IiTrZauqVGW/jqA6p+f4jhpLGhSSiUyR8mF4QWzgtWOPqrz0ZYMpP4J9fKEbqthiHs9yDQzqLtzb2G5jCCsQMkw2Oby+aorklwA6+09P9lHee7Fajw1ruYK+N9yL3suTAIwNVPwtanEeqfZZ7ca749O/lrwTnChEnOdI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=wsUcBhCT; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-46e32c0e273so15415e9.1
        for <linux-integrity@vger.kernel.org>; Thu, 25 Sep 2025 16:45:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1758843923; x=1759448723; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Ol0A50kwMXAn/GaWuyEx9F/yDfrD7aKDcgThOlWqa7k=;
        b=wsUcBhCT1oZnj1txTqtlOvc7p5CO0IqzefuZ3SyKFGLb2Eqt2VNb2dG9MkwTdnCX53
         tR0O+cujtfrqUMOWU8jdrMIFNJEkwhQwbqzp7T+tv4xolIG63GrS7xWPwgiyMgVttNbj
         IdifOcPEFLYeF2wNyJujtz91pbITuiA7EfeS/vFg4xxv5Ut6NHY3cmRRdGwJZlPVC11v
         dqe6PQBPzp7xPPQYYXAFTo/UGGpuTiaVIn2U26xbfIDUE+VhtnJnPA/UCq/nhaum3N9e
         za60WYQtM4ScgeNffqShIskHnVMdPuGqB0X3muKOPAhvCttX1DG4BCxyYDmAqahH+iz8
         HUYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758843923; x=1759448723;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ol0A50kwMXAn/GaWuyEx9F/yDfrD7aKDcgThOlWqa7k=;
        b=N7m6b2S2TopUDRFNVqWgtBGDZ8RUi8ozi/DntwlUl7YQ/AbpmpkgOyap/1E+7yyiFA
         q+MillFieDqSAXzTz78djYz+2Se7nw1S2DOYV/ItPCxpyPv/ROZoLMfNe0Y5JSGmgq11
         AlBAoS3wx+FE+WeODReZc9zRGMkznCjjOJagWBmL/0QhI+5GWpAlR6+1PF6FuVJbbIAc
         MsD5eThaIU7gNLqlcF2CgsoVvVXCaLydBl339OjJI3xBM5l0l4o4YWgrgnR1EE6A8Hnj
         c8AQu4H4Ox490Ooc5MMbHQ0ikhJDE1KxWVd6xKme+KgBdzj+EvhlNfvdmAAVzhw5EwUh
         dg8Q==
X-Forwarded-Encrypted: i=1; AJvYcCXEOWN2IHpCoIbXwjfynRVNg/TT+g0KRf6NiORrG6aUnTDL0/w5XDlcrQYoqICg9qxcA9EwKLIecAlQ+0TFtyM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx5zuXqRdY0nqxgWCsr+VUhBmtdw9Sh1HLFpExtKlYTYPZLLcq4
	WGu3BpKzO1udCZuTgmYyEzdZYhw0jqVoTKsOaLsuQQoc6HF6fvj9tRrOZwqW1+FHL+88HGWKxhF
	9rdzBiooj
X-Gm-Gg: ASbGncs3UY7bUiVYlzPdC6upaXS4YhptVpPljjc2Y5ReNHpgM83P+YymDYtlxFMD3O0
	30whAoyo7O9t9TlCHsrv4hL+bZW5PakhLezDZ7h+Obb3hKuboG5UoPfKJ3bsbMnIAJKl0vsLAxE
	p0O1ECn2bpjzHlB4CzlCpBXr9w4DzIPqyp17ut692AiZwXlu4UcLdgf4McG8/0B2CkAhTeJAc2C
	qH4SluxwXKANoqD+ONC8vrvtWLsegWDPOiudfg8GbUvakzkgodjFSQ1gtNdDIAqH60P/ogkduex
	5weC8y+Klg0/qsEr7vSnlAr+sefeX2c8pexrLcmwOAiGA3ijVkjkRO3gXY6WGUT61vry72OhOFp
	d87hlzVoFWcujktbOkiIRVdbkisI4
X-Google-Smtp-Source: AGHT+IEeVIekGoQsa4rT2uNuLKasNfOTdtHTfwRcmmtPgJYSMssBKLy/KQ1C+vnJw/xi7QWtaEQg/w==
X-Received: by 2002:a05:600c:6219:b0:45f:2940:d194 with SMTP id 5b1f17b1804b1-46e3af7cb37mr783415e9.2.1758843922890;
        Thu, 25 Sep 2025 16:45:22 -0700 (PDT)
Received: from localhost ([2a00:79e0:9d:4:802b:ac1b:7bf0:4c9a])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-46e33be359dsm49540085e9.13.2025.09.25.16.45.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Sep 2025 16:45:22 -0700 (PDT)
From: Jann Horn <jannh@google.com>
Date: Fri, 26 Sep 2025 01:45:07 +0200
Subject: [PATCH 2/2] ima: add fs_subtype condition for distinguishing FUSE
 instances
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250926-ima-audit-v1-2-64d75fdc8fdc@google.com>
References: <20250926-ima-audit-v1-0-64d75fdc8fdc@google.com>
In-Reply-To: <20250926-ima-audit-v1-0-64d75fdc8fdc@google.com>
To: Mimi Zohar <zohar@linux.ibm.com>, 
 Roberto Sassu <roberto.sassu@huawei.com>, 
 Dmitry Kasatkin <dmitry.kasatkin@gmail.com>, 
 Eric Snowberg <eric.snowberg@oracle.com>
Cc: Frank Dinoff <fdinoff@google.com>, linux-kernel@vger.kernel.org, 
 linux-integrity@vger.kernel.org, Jann Horn <jannh@google.com>
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=ed25519-sha256; t=1758843915; l=5956;
 i=jannh@google.com; s=20240730; h=from:subject:message-id;
 bh=zc5PDYPZ7GdBtFvuYFvu8FWqBQP+b/s/g+l/C+lBL/A=;
 b=I1cM55SBW7Rg1+33aO8Wo7b0pVoP0LwvprwmWHcQ9HccOEFM5xfURqglA10HBLMb4yAyj+/XM
 9/0Y5HO09OqCsOcWqz/AfcZloR9j8Iy1QjGxY7Wo9qM6pC/rT5mIg4K
X-Developer-Key: i=jannh@google.com; a=ed25519;
 pk=AljNtGOzXeF6khBXDJVVvwSEkVDGnnZZYqfWhP1V+C8=

Linux systems often use FUSE for several different purposes, where the
contents of some FUSE instances can be of more interest for auditing
than others.

Allow distinguishing between them based on the filesystem subtype
(s_subtype) using the new condition "fs_subtype".

The subtype string is supplied by userspace FUSE daemons
when a FUSE connection is initialized, so policy authors who want to
filter based on subtype need to ensure that FUSE mount operations are
sufficiently audited or restricted.

Signed-off-by: Jann Horn <jannh@google.com>
---
 Documentation/ABI/testing/ima_policy |  1 +
 security/integrity/ima/ima_policy.c  | 43 ++++++++++++++++++++++++++++++++----
 2 files changed, 40 insertions(+), 4 deletions(-)

diff --git a/Documentation/ABI/testing/ima_policy b/Documentation/ABI/testing/ima_policy
index 5d548dd2c6e7..d4b3696a9efb 100644
--- a/Documentation/ABI/testing/ima_policy
+++ b/Documentation/ABI/testing/ima_policy
@@ -23,6 +23,7 @@ Description:
 			  audit | dont_audit | hash | dont_hash
 		  condition:= base | lsm  [option]
 			base:	[[func=] [mask=] [fsmagic=] [fsuuid=] [fsname=]
+				[fs_subtype=]
 				[uid=] [euid=] [gid=] [egid=]
 				[fowner=] [fgroup=]]
 			lsm:	[[subj_user=] [subj_role=] [subj_type=]
diff --git a/security/integrity/ima/ima_policy.c b/security/integrity/ima/ima_policy.c
index c5bad3a0c43a..164d62832f8e 100644
--- a/security/integrity/ima/ima_policy.c
+++ b/security/integrity/ima/ima_policy.c
@@ -38,6 +38,7 @@
 #define IMA_GID		0x2000
 #define IMA_EGID	0x4000
 #define IMA_FGROUP	0x8000
+#define IMA_FS_SUBTYPE	0x10000
 
 #define UNKNOWN		0
 #define MEASURE		0x0001	/* same as IMA_MEASURE */
@@ -120,6 +121,7 @@ struct ima_rule_entry {
 		int type;	/* audit type */
 	} lsm[MAX_LSM_RULES];
 	char *fsname;
+	char *fs_subtype;
 	struct ima_rule_opt_list *keyrings; /* Measure keys added to these keyrings */
 	struct ima_rule_opt_list *label; /* Measure data grouped under this label */
 	struct ima_template_desc *template;
@@ -398,6 +400,7 @@ static void ima_free_rule(struct ima_rule_entry *entry)
 	 * the defined_templates list and cannot be freed here
 	 */
 	kfree(entry->fsname);
+	kfree(entry->fs_subtype);
 	ima_free_rule_opt_list(entry->keyrings);
 	ima_lsm_free_rule(entry);
 	kfree(entry);
@@ -602,6 +605,12 @@ static bool ima_match_rules(struct ima_rule_entry *rule,
 	if ((rule->flags & IMA_FSNAME)
 	    && strcmp(rule->fsname, inode->i_sb->s_type->name))
 		return false;
+	if (rule->flags & IMA_FS_SUBTYPE) {
+		if (!inode->i_sb->s_subtype)
+			return false;
+		if (strcmp(rule->fs_subtype, inode->i_sb->s_subtype))
+			return false;
+	}
 	if ((rule->flags & IMA_FSUUID) &&
 	    !uuid_equal(&rule->fsuuid, &inode->i_sb->s_uuid))
 		return false;
@@ -1068,7 +1077,7 @@ enum policy_opt {
 	Opt_audit, Opt_dont_audit, Opt_hash, Opt_dont_hash,
 	Opt_obj_user, Opt_obj_role, Opt_obj_type,
 	Opt_subj_user, Opt_subj_role, Opt_subj_type,
-	Opt_func, Opt_mask, Opt_fsmagic, Opt_fsname, Opt_fsuuid,
+	Opt_func, Opt_mask, Opt_fsmagic, Opt_fsname, Opt_fs_subtype, Opt_fsuuid,
 	Opt_uid_eq, Opt_euid_eq, Opt_gid_eq, Opt_egid_eq,
 	Opt_fowner_eq, Opt_fgroup_eq,
 	Opt_uid_gt, Opt_euid_gt, Opt_gid_gt, Opt_egid_gt,
@@ -1100,6 +1109,7 @@ static const match_table_t policy_tokens = {
 	{Opt_mask, "mask=%s"},
 	{Opt_fsmagic, "fsmagic=%s"},
 	{Opt_fsname, "fsname=%s"},
+	{Opt_fs_subtype, "fs_subtype=%s"},
 	{Opt_fsuuid, "fsuuid=%s"},
 	{Opt_uid_eq, "uid=%s"},
 	{Opt_euid_eq, "euid=%s"},
@@ -1284,7 +1294,8 @@ static bool ima_validate_rule(struct ima_rule_entry *entry)
 		if (entry->flags & ~(IMA_FUNC | IMA_MASK | IMA_FSMAGIC |
 				     IMA_UID | IMA_FOWNER | IMA_FSUUID |
 				     IMA_INMASK | IMA_EUID | IMA_PCR |
-				     IMA_FSNAME | IMA_GID | IMA_EGID |
+				     IMA_FSNAME | IMA_FS_SUBTYPE |
+				     IMA_GID | IMA_EGID |
 				     IMA_FGROUP | IMA_DIGSIG_REQUIRED |
 				     IMA_PERMIT_DIRECTIO | IMA_VALIDATE_ALGOS |
 				     IMA_CHECK_BLACKLIST | IMA_VERITY_REQUIRED))
@@ -1297,7 +1308,8 @@ static bool ima_validate_rule(struct ima_rule_entry *entry)
 		if (entry->flags & ~(IMA_FUNC | IMA_MASK | IMA_FSMAGIC |
 				     IMA_UID | IMA_FOWNER | IMA_FSUUID |
 				     IMA_INMASK | IMA_EUID | IMA_PCR |
-				     IMA_FSNAME | IMA_GID | IMA_EGID |
+				     IMA_FSNAME | IMA_FS_SUBTYPE |
+				     IMA_GID | IMA_EGID |
 				     IMA_FGROUP | IMA_DIGSIG_REQUIRED |
 				     IMA_PERMIT_DIRECTIO | IMA_MODSIG_ALLOWED |
 				     IMA_CHECK_BLACKLIST | IMA_VALIDATE_ALGOS))
@@ -1310,7 +1322,8 @@ static bool ima_validate_rule(struct ima_rule_entry *entry)
 
 		if (entry->flags & ~(IMA_FUNC | IMA_FSMAGIC | IMA_UID |
 				     IMA_FOWNER | IMA_FSUUID | IMA_EUID |
-				     IMA_PCR | IMA_FSNAME | IMA_GID | IMA_EGID |
+				     IMA_PCR | IMA_FSNAME | IMA_FS_SUBTYPE |
+				     IMA_GID | IMA_EGID |
 				     IMA_FGROUP))
 			return false;
 
@@ -1597,6 +1610,22 @@ static int ima_parse_rule(char *rule, struct ima_rule_entry *entry)
 			result = 0;
 			entry->flags |= IMA_FSNAME;
 			break;
+		case Opt_fs_subtype:
+			ima_log_string(ab, "fs_subtype", args[0].from);
+
+			if (entry->fs_subtype) {
+				result = -EINVAL;
+				break;
+			}
+
+			entry->fs_subtype = kstrdup(args[0].from, GFP_KERNEL);
+			if (!entry->fs_subtype) {
+				result = -ENOMEM;
+				break;
+			}
+			result = 0;
+			entry->flags |= IMA_FS_SUBTYPE;
+			break;
 		case Opt_keyrings:
 			ima_log_string(ab, "keyrings", args[0].from);
 
@@ -2145,6 +2174,12 @@ int ima_policy_show(struct seq_file *m, void *v)
 		seq_puts(m, " ");
 	}
 
+	if (entry->flags & IMA_FS_SUBTYPE) {
+		snprintf(tbuf, sizeof(tbuf), "%s", entry->fs_subtype);
+		seq_printf(m, pt(Opt_fs_subtype), tbuf);
+		seq_puts(m, " ");
+	}
+
 	if (entry->flags & IMA_KEYRINGS) {
 		seq_puts(m, "keyrings=");
 		ima_show_rule_opt_list(m, entry->keyrings);

-- 
2.51.0.536.g15c5d4f767-goog


