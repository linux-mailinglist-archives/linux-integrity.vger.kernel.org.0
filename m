Return-Path: <linux-integrity+bounces-6671-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 05C40B0CDD9
	for <lists+linux-integrity@lfdr.de>; Tue, 22 Jul 2025 01:24:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EEB601894729
	for <lists+linux-integrity@lfdr.de>; Mon, 21 Jul 2025 23:24:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C11671D63E8;
	Mon, 21 Jul 2025 23:24:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="H4hcAC/N"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mail-qk1-f176.google.com (mail-qk1-f176.google.com [209.85.222.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C00423B622
	for <linux-integrity@vger.kernel.org>; Mon, 21 Jul 2025 23:24:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753140252; cv=none; b=XhQtROMX78ZSBnIiScXnNXb2L9rZ6e/4SVK6dxBsL3XjPVZCAJJBsg++/cyDs/1hJfPl01KgsR0yp/XQgc0R9GthebzXHdiIckhJOhVyMbpXggT3OpWLW8hronMJUyJA0PTEsBhk8gR47pQjy4EpapjC3IJu7vmPde/9qiP13dQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753140252; c=relaxed/simple;
	bh=HCh9v8FXwNoH2o+J6NBb02fZ22PTdaa9s/gHlIzShOE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=H0nDpA2XelmFmbWhb+eAoeySn2xL+2aFVz3QI8DQO6GLEHpIaCKvOMLsjsikfEM6BGVgM8TFgEY7aGphwVMngUEXC5oU6kOP600R+vlLqG6G+R/bnwx9O7gtSOq+NGi+zuXQikz0FpmhTakbVXWIrQs2ydIjiMXWcJXievcKBGw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=H4hcAC/N; arc=none smtp.client-ip=209.85.222.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Received: by mail-qk1-f176.google.com with SMTP id af79cd13be357-7dfc604107eso461788185a.2
        for <linux-integrity@vger.kernel.org>; Mon, 21 Jul 2025 16:24:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1753140250; x=1753745050; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MFxrtXIv4+uoW9eouX73/aB+3doQjTft486+v5IMTc8=;
        b=H4hcAC/NXTqwa3ziS+xDloHIG3bJajKDLMK8JspBYAg/4ijTq4Rrc8EEhX/o38Z3jR
         K0DIFwz8H25ke7Mhq3zI0y6Hcc7jMvAvmj0PU70DO0JzbAw9IQJh5z0r5K5sRZu775c0
         CqcBUjYaz4K1tVbZtWeDBnBBvTnEbCj7efDSmAsNrOjCuAvDkNbLbCBrZzmRXxTVhT3S
         AvB88BOpWs3wNRmYS3wVZ9YmUTYsIoaUAHhd9k+XlDcur8OeVms1Ro77V00dg0M/RC2Q
         TYlz8B/1pgQl48+YjoYGKx1E9RKrkQtRhhxSSBPzjuLO8oTDHBtS8CGpCHAT8inZ5c4n
         xHHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753140250; x=1753745050;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MFxrtXIv4+uoW9eouX73/aB+3doQjTft486+v5IMTc8=;
        b=Vam8O0PAismG/ZXqzicdB9Wy+kSfiZ62UPRVuDoXHKRKe4nyxdeqDG9VlvmCFYyJEU
         SJRmiXDStynqMOSA6Ht/St0nztA7dy260rFzexKlzU3rpnb4KsNrISm0FPB3pbcZWQDs
         v67hCQ4SDud7QgOgQws3ZfD9ISzu2ym19GmW3aEt4DAgQD82gWmp39c22Jnt385MA2zC
         TFxrg5OJBC1alABd134MwEv2T0al14MSjjOlQ6pwWjhbjU4EephF4AMeZTp7V3UeA2CY
         GfeBuDOL+z9ndhIItSXyQOfmQ3twD4m6uTCnEhBoCzzvVBp6LhJ+pdZBGuflrWiMmi9S
         yTPA==
X-Forwarded-Encrypted: i=1; AJvYcCUsJ7Ww6sbTu5emu1//8HOxE3p4nE/EhAi2LnhW9YZoZ2J7A/HT1ausmBV0rPRiGTXQ0vnvhHsjTZLP5CdCx98=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxf2eU/MZMBjsWFYauXRFp82o+jhhpI8vDh604tKlCU5JFlvSte
	DhEE1GOSUfZVkL/rOZTyF75Tg5lt/U32OrRjmR1yekKRDm8pw69tWBJKD0js3Le/Ig==
X-Gm-Gg: ASbGncuug6L9bG0ytjlor9cRc1iSNeD3mEkiI37JFVQ6LZnfQBoW9x88gNbwZwI6xBa
	hywvMlN5Rmcd1TzP4sUZUg2JKNwhfyepxQlN+PT4wqTjj3Hkqf2ChTq26ejoaY8IHCwU2F6pSdh
	noFfWKB0PQHU2wJgmPQQwCxAwvIYoDoySVseVjQstpQ31xEIqdeq/PNtxH39LXYLUFrle+Tia71
	kgTr7UmcY8dBah4qcF0ZclJdqV38DI9pbTOkdRL0oR6thocqKREGit1Fgo6VcOezFi/PZP1Sx/4
	m+2K00O4s2P7hlG3dAhr5P0SQuKqzlonWXYH21p8brHg3sT7cuSIKE7qBH6gmZpcPNJxe0avSzg
	5G0QhUdb9Sg3GUY1PcEGA+B1ED+arLXj+4TgTtBxRvqZrod5FUGwhpxL5+oQLnejsMWg=
X-Google-Smtp-Source: AGHT+IEaWV9DqNldq1DtZpY2l6IrTfev9H+s78qRFzN5rJeJrCXC4lRt8iMeJK65BvS+4jyMqdsQdQ==
X-Received: by 2002:a05:620a:63c2:b0:7d5:dbdc:ceef with SMTP id af79cd13be357-7e34356f48cmr2547224585a.18.1753140249971;
        Mon, 21 Jul 2025 16:24:09 -0700 (PDT)
Received: from localhost (pool-71-126-255-178.bstnma.fios.verizon.net. [71.126.255.178])
        by smtp.gmail.com with UTF8SMTPSA id d75a77b69052e-4abb4b491c2sm47740981cf.69.2025.07.21.16.24.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Jul 2025 16:24:09 -0700 (PDT)
From: Paul Moore <paul@paul-moore.com>
To: linux-security-module@vger.kernel.org,
	linux-integrity@vger.kernel.org,
	selinux@vger.kernel.org
Cc: John Johansen <john.johansen@canonical.com>,
	Mimi Zohar <zohar@linux.ibm.com>,
	Roberto Sassu <roberto.sassu@huawei.com>,
	Fan Wu <wufan@kernel.org>,
	=?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>,
	=?UTF-8?q?G=C3=BCnther=20Noack?= <gnoack@google.com>,
	Kees Cook <kees@kernel.org>,
	Micah Morton <mortonm@chromium.org>,
	Casey Schaufler <casey@schaufler-ca.com>,
	Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>,
	Nicolas Bouchinet <nicolas.bouchinet@oss.cyber.gouv.fr>,
	Xiu Jianfeng <xiujianfeng@huawei.com>
Subject: [RFC PATCH v2 10/34] lsm: rework lsm_active_cnt and lsm_idlist[]
Date: Mon, 21 Jul 2025 19:21:13 -0400
Message-ID: <20250721232142.77224-46-paul@paul-moore.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250721232142.77224-36-paul@paul-moore.com>
References: <20250721232142.77224-36-paul@paul-moore.com>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3343; i=paul@paul-moore.com; h=from:subject; bh=HCh9v8FXwNoH2o+J6NBb02fZ22PTdaa9s/gHlIzShOE=; b=owEBbQKS/ZANAwAKAeog8tqXN4lzAcsmYgBofsutsmWBK4qA4LK3BIgxUyjbNqA657sK6bGyf CSqJTtdDoOJAjMEAAEKAB0WIQRLQqjPB/KZ1VSXfu/qIPLalzeJcwUCaH7LrQAKCRDqIPLalzeJ c4Y9D/94ZXF/OMq3d8GsY9lPj6c77UvDMUr7KvfKVytN1w1oVMFy+Ze3BurSWw/HKmk95PvkPB6 l8lz3R0Fv0R5mLV+urW0BvMlPMozyLPgjdZkbfqMc/zqkdWGWvmTEDEOuPMvWOAHJjzlec5sGdm aPmXva2nKVIHSqACZc5tVEDm5MI2GP2YUU8jojmG7eMsmwRpSEuGlmjUaiKIhWCzzJLk/FQ86SN 3CmtVeXd92avevvXYqS7Je1lIraFgIg+viYKoF0olH16qO992XcgIRGsaAHRl9xwUYFViZLwrCj Ylf1flnAan6jPDUVU5yKRBLB1bZ9n7FgFCFz8gVi0ksH6ZUc9QqUDVkNewd+HaMVrSZWfjAIsEC To5mJjnp+/IsdqBgZFPGR6dM89vNGPwzgw6iUFkEHY8H9aj99XZI+IeicZOhbIBd74Beuue0Cia SNNIF2GA0CytB94BWmFj/fMp7PonPEmSirNPU8egLKAIHgJ5GIlwx8JZvBeBe3EqW4hUJxGwnGf ukpruJ5zFRuITLi6jYNoJ87t5fe+AJdypY4trzGX9S4G42qhQNeUusyMGQUgr5W4P0mcrkn7yKG RiEUPsJ3131Ki4rN85252ZI12CIjq+nCystTiL+08de5pTGO7/kYLoq2bR64A3X1a2nfSVWxPfQ EWQnA+4AGk2d01g==
X-Developer-Key: i=paul@paul-moore.com; a=openpgp; fpr=7100AADFAE6E6E940D2E0AD655E45A5AE8CA7C8A
Content-Transfer-Encoding: 8bit

Move the LSM active count and lsm_id list declarations out of a header
that is visible across the kernel and into a header that is limited to
the LSM framework.  This not only helps keep the include/linux headers
smaller and cleaner, it helps prevent misuse of these variables.

Signed-off-by: Paul Moore <paul@paul-moore.com>
---
 include/linux/security.h | 2 --
 security/lsm.h           | 5 +++++
 security/lsm_init.c      | 8 +-------
 security/lsm_syscalls.c  | 2 ++
 security/security.c      | 3 +++
 5 files changed, 11 insertions(+), 9 deletions(-)

diff --git a/include/linux/security.h b/include/linux/security.h
index e8d9f6069f0c..c57a9a7499ea 100644
--- a/include/linux/security.h
+++ b/include/linux/security.h
@@ -167,8 +167,6 @@ struct lsm_prop {
 };
 
 extern const char *const lockdown_reasons[LOCKDOWN_CONFIDENTIALITY_MAX+1];
-extern u32 lsm_active_cnt;
-extern const struct lsm_id *lsm_idlist[];
 
 /* These functions are in security/commoncap.c */
 extern int cap_capable(const struct cred *cred, struct user_namespace *ns,
diff --git a/security/lsm.h b/security/lsm.h
index 0e1731bad4a7..dbe755c45e57 100644
--- a/security/lsm.h
+++ b/security/lsm.h
@@ -7,6 +7,11 @@
 #define _LSM_H_
 
 #include <linux/lsm_hooks.h>
+#include <linux/lsm_count.h>
+
+/* List of configured LSMs */
+extern unsigned int lsm_active_cnt;
+extern const struct lsm_id *lsm_idlist[];
 
 /* LSM blob configuration */
 extern struct lsm_blob_sizes blob_sizes;
diff --git a/security/lsm_init.c b/security/lsm_init.c
index cbdfac31ede4..03d3e140e0b1 100644
--- a/security/lsm_init.c
+++ b/security/lsm_init.c
@@ -22,8 +22,8 @@ static __initdata const char *lsm_order_cmdline;
 static __initdata const char *lsm_order_legacy;
 
 /* Ordered list of LSMs to initialize. */
-static __initdata struct lsm_info *lsm_order[MAX_LSM_COUNT + 1];
 static __initdata struct lsm_info *lsm_exclusive;
+static __initdata struct lsm_info *lsm_order[MAX_LSM_COUNT + 1];
 
 static __initdata bool debug;
 #define init_debug(...)							\
@@ -214,12 +214,6 @@ static void __init initialize_lsm(struct lsm_info *lsm)
 	}
 }
 
-/*
- * Current index to use while initializing the lsm id list.
- */
-u32 lsm_active_cnt __ro_after_init;
-const struct lsm_id *lsm_idlist[MAX_LSM_COUNT];
-
 /* Populate ordered LSMs list from comma-separated LSM name list. */
 static void __init ordered_lsm_parse(const char *order, const char *origin)
 {
diff --git a/security/lsm_syscalls.c b/security/lsm_syscalls.c
index 8440948a690c..5648b1f0ce9c 100644
--- a/security/lsm_syscalls.c
+++ b/security/lsm_syscalls.c
@@ -17,6 +17,8 @@
 #include <linux/lsm_hooks.h>
 #include <uapi/linux/lsm.h>
 
+#include "lsm.h"
+
 /**
  * lsm_name_to_attr - map an LSM attribute name to its ID
  * @name: name of the attribute
diff --git a/security/security.c b/security/security.c
index e77791058086..106f225f4a80 100644
--- a/security/security.c
+++ b/security/security.c
@@ -73,6 +73,9 @@ const char *const lockdown_reasons[LOCKDOWN_CONFIDENTIALITY_MAX + 1] = {
 	[LOCKDOWN_CONFIDENTIALITY_MAX] = "confidentiality",
 };
 
+unsigned int lsm_active_cnt __ro_after_init;
+const struct lsm_id *lsm_idlist[MAX_LSM_COUNT];
+
 struct lsm_blob_sizes blob_sizes;
 
 struct kmem_cache *lsm_file_cache;
-- 
2.50.1


