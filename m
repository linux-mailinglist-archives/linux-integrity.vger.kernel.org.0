Return-Path: <linux-integrity+bounces-7476-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 85B71BEBBD0
	for <lists+linux-integrity@lfdr.de>; Fri, 17 Oct 2025 22:49:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 81F08588175
	for <lists+linux-integrity@lfdr.de>; Fri, 17 Oct 2025 20:49:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5268827CB35;
	Fri, 17 Oct 2025 20:49:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="Up3Id0MX"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mail-qk1-f176.google.com (mail-qk1-f176.google.com [209.85.222.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72329277C98
	for <linux-integrity@vger.kernel.org>; Fri, 17 Oct 2025 20:49:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760734147; cv=none; b=iogrGefOCGpnpeqoQ2eY/Z9o8ub+5Bfi1Y3IRfQBFQbzEyehs3U1mpnqAGXrxSsScKfE2Q1V3HcW7fgzc4km3y1UUemwL1k14bo4SmNd3na7cOg1HewTTU1+tNOGBoANZOlSD5OcwoW/9/aXjRJTmzmmQOZ9C4vGt34qu+cgNiQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760734147; c=relaxed/simple;
	bh=OLELdDFfhMbHi0pVm5NnWQWxFQFlODpkZDMVPFQ4JEA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=a5uHs+9ZMKD6Lz9WttXh6fGQHs+Ksl3chHMnLaExI4fxQsffjghOwPeJCmjC2wTp+AisqRQ3kb+wBZuuaMm5bY5piOYVCTGQKiZ8jThkkg203/7OqUbv5XLm7TplBswGL5gpBCR6egckjMb3uWyXjhqLhVeG56yafoxDBvcBwH0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=Up3Id0MX; arc=none smtp.client-ip=209.85.222.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Received: by mail-qk1-f176.google.com with SMTP id af79cd13be357-890cc9b6bbbso218463385a.3
        for <linux-integrity@vger.kernel.org>; Fri, 17 Oct 2025 13:49:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1760734142; x=1761338942; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+mPR5Z2Gcc0qWocHencxRkWKoEfhfiz98yuE4PxUUj0=;
        b=Up3Id0MXQaFZcUopKknIjzOGON1uskV2rnU13nSso9haNBJsX8lrBbehjsK4jbhawQ
         eguPR2B8tSAYKJ/RQIfHZv1yZEyGl7zH0PkaZdFIjTVIbgkwrMq0EDerjUvzdtht/MIW
         pgT4fg16Xy1e4CpxpILkSzWR+7WBq3UQSsYtHMYsstwkUCGkdb7gSdn7oXevGQ20cXZ+
         OPAga/lqracHFFsMYuQQVGG2F5reCHxHdvr35pHvIx2NgEUr+rwASj3uazSHt8lEqxvs
         jamm/cJybmQtSVA4/aXn/vl7fBLp1QtE9KeoRMiFxxA+sgufVyXa36e6yOesIgWBlrLk
         aWgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760734142; x=1761338942;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+mPR5Z2Gcc0qWocHencxRkWKoEfhfiz98yuE4PxUUj0=;
        b=MmD/JdgF2sxb4EkZKwMHeMavqzKCbqJdvzoJU/ycSWRAsKl6C2EKT4y5VsmI91cJEf
         t/gIet/HqYeAsxn1K52Gik+A9QPz/UvcOnQQtbs5833cXIvDf32o3tCNCiH9L+Bf7YCW
         qUwydIVxJ937lYn5cqFwiF74S6Ua2u1AFNtzLtsFskzxL3i6k2Vl6TGNX/3Sz0cHNMPY
         BKzekvE6MaSitLHY1Q2/xJ8T+n+z9mWsO6RowmggEezgzbfa3gVByohpfCGu/yrK/r7w
         5I2fjy9wOookVw373wtgmwDtWWhHT+qGQmUWJ9KWIPk3BPy/hRrXCjC+3M6icwcSqYmu
         KaHA==
X-Forwarded-Encrypted: i=1; AJvYcCVNgp+zFtOm100ZdFdw7fxFvrWMavf0Pj34HQkzbm62Gmh0hXt6BX4DJezNWR9TNTlWkTHdmLsalEigvZsArNM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxsEm49gAM5F5VEGvowCCbc1JxTJ+Inqp9CidgbJvpp/rZiZI6D
	yydLDoVUyfy9zUcYKcXVsiOXLzoqAKkdxbLjzhsuyWWQgge2ygtem+1yYUbOg+MTMw==
X-Gm-Gg: ASbGnctKQF7TIW4f1c0D9cX6xPLzezEbwDHxOoz96BYr2XalhEQ09SSNO3nhiral3aR
	i5YNRhASVHt94fC9deSo7kM7L0niHQdkIzsun1bqKGwZA+lwxk2R46S6Mag41sNtMf3/Edp5H5o
	YlsCuoimjaZw01WKy5TY/LmNpiG7b4Ae6afzOrGO1gbAJd/6dOIcg28S6kAwugUMZLtLX1xaAaT
	//u9gqvoEnMlz40Sp/amQPSRjKmfb2haBEz3QDsUmVtRc9gQJ1Y8FZaI1lDyC15MZfZCo+wN/R/
	X6fExFGn9BaM3R5NzDt3pM4Y0Rf3cGfo3arFyHEJCJKbNqAH2Lj3eNP5l2eaM6EU6Qb++JH0rVd
	8q2wxrCuKYoVlX3YZY0PbncqsNwQ6RYovN08s6u61jKMKRXhU2JNyz08EBldX6o6pG7MvIhJkEn
	uyqh+wpITC9iZeaj5G4nF5QGZeLD8rHwkDs0eaGKV2IH1lpg==
X-Google-Smtp-Source: AGHT+IFgGvDKMg2kdGEzMfJ1PJCEdg2a1D2Jw5VT8/dDH35M3p3PY8ya206z/fh4X16Z1L5b1IQMgA==
X-Received: by 2002:a05:622a:11c7:b0:4e5:8cc4:4784 with SMTP id d75a77b69052e-4e89d29a9b9mr64829751cf.37.1760734142403;
        Fri, 17 Oct 2025 13:49:02 -0700 (PDT)
Received: from localhost (pool-71-126-255-178.bstnma.fios.verizon.net. [71.126.255.178])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4e8ab10da83sm5063521cf.39.2025.10.17.13.49.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Oct 2025 13:49:01 -0700 (PDT)
From: Paul Moore <paul@paul-moore.com>
To: linux-security-module@vger.kernel.org,
	linux-integrity@vger.kernel.org,
	selinux@vger.kernel.org
Cc: john.johansen@canonical.com,
	zohar@linux.ibm.com,
	roberto.sassu@huawei.com,
	wufan@kernel.org,
	mic@digikod.net,
	gnoack@google.com,
	kees@kernel.org,
	mortonm@chromium.org,
	casey@schaufler-ca.com,
	penguin-kernel@I-love.SAKURA.ne.jp,
	nicolas.bouchinet@oss.cyber.gouv.fr,
	xiujianfeng@huawei.com
Subject: [PATCH v5 06/11] apparmor: move initcalls to the LSM framework
Date: Fri, 17 Oct 2025 16:48:20 -0400
Message-ID: <20251017204815.505363-17-paul@paul-moore.com>
X-Mailer: git-send-email 2.51.1.dirty
In-Reply-To: <20251017204815.505363-12-paul@paul-moore.com>
References: <20251017202456.484010-36-paul@paul-moore.com>
 <20251017204815.505363-12-paul@paul-moore.com>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3625; i=paul@paul-moore.com; h=from:subject; bh=OLELdDFfhMbHi0pVm5NnWQWxFQFlODpkZDMVPFQ4JEA=; b=owEBbQKS/ZANAwAKAeog8tqXN4lzAcsmYgBo8quftjQ7TZEQi0O8JLfy9rNLVJEY0sRKSwolN 0fKCQ+45nmJAjMEAAEKAB0WIQRLQqjPB/KZ1VSXfu/qIPLalzeJcwUCaPKrnwAKCRDqIPLalzeJ c7vpEACwZZ0pEDFYUcAO3OdvT28s/OiFsoZ+CPvGzGRLhAyA8SKMt2U2khiP7IJgMY20xlYyNap p3N0qP9h8xAW0gWWIWSdjUTOMzG5Hhok74pULPNq3ESQsOmwBhwBQByMdKTN8ZeBTLyJfaSlpT1 QoQe/Bxic8Uem/VYGZTXns5TD2J/hgjUEKeynjgm4fr+vm5ufmXRG4gVI21oIW7UvhkVEvnEROO g9PsuXvs65NmfBjVPgpRmiq/UqccwlDlyqcmPCP6bpQ1F1E8YxapEzCksEjhRCLg4B064YUPYJ5 /7zor320pg6TiYVbpFbk7rMlByWdD75/CqKS8R1/tv60FTnoASVjtMqtWLN2n631XKQAn4bXDI8 mIcB9wfdBk5QQW4xOAeyZlJB1hm9tPSTO3oLzy8ox6tYHIs/pmoRbyOAUnddzZ3HHgAUYTBZ7n8 eZ3FO6CCXlQOJg7iCqIFzVZemeWfuqvh+JQp3OmU2bYacHzFKeFYu5gWutl8u5qyOxHAQPk4feM OCRU8LTHHPHEi80sYYgn7xc0ju1N6ARa8ZFpn+h3hKsC4dcRVjlLioeeM56RLaopIC66/AQYLgO 2q3mJa4pltRUlbtvKH+ad2nOeGibAHbNToXNmTBOA+cXn/fia++txcEqupGuWH0R3as6Tu65K9K 5lI4X/9Cw66Z4Lw==
X-Developer-Key: i=paul@paul-moore.com; a=openpgp; fpr=7100AADFAE6E6E940D2E0AD655E45A5AE8CA7C8A
Content-Transfer-Encoding: 8bit

Reviewed-by: Kees Cook <kees@kernel.org>
Acked-by: John Johansen <john.johansen@canonical.com>
Signed-off-by: Paul Moore <paul@paul-moore.com>
---
 security/apparmor/apparmorfs.c         | 4 +---
 security/apparmor/crypto.c             | 3 +--
 security/apparmor/include/apparmorfs.h | 2 ++
 security/apparmor/include/crypto.h     | 1 +
 security/apparmor/lsm.c                | 9 ++++++++-
 5 files changed, 13 insertions(+), 6 deletions(-)

diff --git a/security/apparmor/apparmorfs.c b/security/apparmor/apparmorfs.c
index 391a586d0557..ee04c1ac9d6e 100644
--- a/security/apparmor/apparmorfs.c
+++ b/security/apparmor/apparmorfs.c
@@ -2649,7 +2649,7 @@ static const struct inode_operations policy_link_iops = {
  *
  * Returns: error on failure
  */
-static int __init aa_create_aafs(void)
+int __init aa_create_aafs(void)
 {
 	struct dentry *dent;
 	int error;
@@ -2728,5 +2728,3 @@ static int __init aa_create_aafs(void)
 	AA_ERROR("Error creating AppArmor securityfs\n");
 	return error;
 }
-
-fs_initcall(aa_create_aafs);
diff --git a/security/apparmor/crypto.c b/security/apparmor/crypto.c
index 227d47c14907..d8a7bde94d79 100644
--- a/security/apparmor/crypto.c
+++ b/security/apparmor/crypto.c
@@ -53,10 +53,9 @@ int aa_calc_profile_hash(struct aa_profile *profile, u32 version, void *start,
 	return 0;
 }
 
-static int __init init_profile_hash(void)
+int __init init_profile_hash(void)
 {
 	if (apparmor_initialized)
 		aa_info_message("AppArmor sha256 policy hashing enabled");
 	return 0;
 }
-late_initcall(init_profile_hash);
diff --git a/security/apparmor/include/apparmorfs.h b/security/apparmor/include/apparmorfs.h
index 1e94904f68d9..dd580594dfb7 100644
--- a/security/apparmor/include/apparmorfs.h
+++ b/security/apparmor/include/apparmorfs.h
@@ -104,6 +104,8 @@ enum aafs_prof_type {
 #define prof_dir(X) ((X)->dents[AAFS_PROF_DIR])
 #define prof_child_dir(X) ((X)->dents[AAFS_PROF_PROFS])
 
+int aa_create_aafs(void);
+
 void __aa_bump_ns_revision(struct aa_ns *ns);
 void __aafs_profile_rmdir(struct aa_profile *profile);
 void __aafs_profile_migrate_dents(struct aa_profile *old,
diff --git a/security/apparmor/include/crypto.h b/security/apparmor/include/crypto.h
index 636a04e20d91..f3ffd388cc58 100644
--- a/security/apparmor/include/crypto.h
+++ b/security/apparmor/include/crypto.h
@@ -13,6 +13,7 @@
 #include "policy.h"
 
 #ifdef CONFIG_SECURITY_APPARMOR_HASH
+int init_profile_hash(void);
 unsigned int aa_hash_size(void);
 char *aa_calc_hash(void *data, size_t len);
 int aa_calc_profile_hash(struct aa_profile *profile, u32 version, void *start,
diff --git a/security/apparmor/lsm.c b/security/apparmor/lsm.c
index f6798144234b..a87cd60ed206 100644
--- a/security/apparmor/lsm.c
+++ b/security/apparmor/lsm.c
@@ -32,6 +32,7 @@
 #include "include/audit.h"
 #include "include/capability.h"
 #include "include/cred.h"
+#include "include/crypto.h"
 #include "include/file.h"
 #include "include/ipc.h"
 #include "include/net.h"
@@ -2426,7 +2427,6 @@ static int __init apparmor_nf_ip_init(void)
 
 	return 0;
 }
-__initcall(apparmor_nf_ip_init);
 #endif
 
 static char nulldfa_src[] __aligned(8) = {
@@ -2560,4 +2560,11 @@ DEFINE_LSM(apparmor) = {
 	.enabled = &apparmor_enabled,
 	.blobs = &apparmor_blob_sizes,
 	.init = apparmor_init,
+	.initcall_fs = aa_create_aafs,
+#if defined(CONFIG_NETFILTER) && defined(CONFIG_NETWORK_SECMARK)
+	.initcall_device = apparmor_nf_ip_init,
+#endif
+#ifdef CONFIG_SECURITY_APPARMOR_HASH
+	.initcall_late = init_profile_hash,
+#endif
 };
-- 
2.51.1.dirty


