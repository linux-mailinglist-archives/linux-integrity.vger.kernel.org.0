Return-Path: <linux-integrity+bounces-7134-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D3FF7B7D481
	for <lists+linux-integrity@lfdr.de>; Wed, 17 Sep 2025 14:23:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C0ACB2A0620
	for <lists+linux-integrity@lfdr.de>; Tue, 16 Sep 2025 22:15:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E6763294E5;
	Tue, 16 Sep 2025 22:14:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="D/vqa9yj"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mail-qt1-f169.google.com (mail-qt1-f169.google.com [209.85.160.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6D3832B48B
	for <linux-integrity@vger.kernel.org>; Tue, 16 Sep 2025 22:14:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758060874; cv=none; b=foMtjwAkAlLW55cZS5ZrF68WyGWZhQpJ5JhVf7dkPc+IM+kTrdHB3GtFrnEqmuOe/yJhm5rZdgyy41JykNFWzxiBUvhT5p59IhkfZdxQke92cxTzGWx9Ysc7DbF4fV4s5mr412sI5GL+5uSoF6CO942RJ+2Q5KqY6bbBttK/6iw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758060874; c=relaxed/simple;
	bh=ql5+Pc/Tcxt5X2bsPlRUGmu7PmdyNUNLJ0A2/x8cr5U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ng6wjTZUbfl/cj0evsYBi14zdCwEIkoxLHjKXRKYuF1wETYSYDGhNba5F4ddQcQ+ezNkp5oPPpgyqkj1RKR4NQUGF7UE1YrtPbjHIStCQqP5FIZFs7RKxwPYYdy1oAq9xQV/1cfM/EP18ZY8haFHmkFFzuMFUOo5P6E1W9VJ4wQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=D/vqa9yj; arc=none smtp.client-ip=209.85.160.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Received: by mail-qt1-f169.google.com with SMTP id d75a77b69052e-4b5f7fe502dso31693801cf.0
        for <linux-integrity@vger.kernel.org>; Tue, 16 Sep 2025 15:14:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1758060872; x=1758665672; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qiF6q/qc2OvYsPYivTGoF0XMP0CR+2eYNeCKqhmzwI8=;
        b=D/vqa9yjWTLJzy39RwIEhb00weX9BF+HgraxTjSJot/na3BWjIv3vOP5IQHCJZh6QS
         31UDiuolaEIfXKElLVg5JZSZaCkJaEdWG1okeiOfN2cEkEhQeo8B8PpFIeUYbhVz6tOw
         CMkdkmUrNvMSGohIOED4yUWrK36l4lY2StZJcTRdK+9GzXCrNr0yUoSKKYIzYT0E1KG/
         1JetfjxkjKSK5eUdKnUd5CoOXT5GrqSPrqDJKNF1fQhR5cZNXjcBLcHpcGhldWC51cdr
         lG7jphOWDjbucikYzGMFNrwnwfQuI6HVIKSO0qchgeXItKPKhUBRYtITZRoryF4NoCRU
         uw9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758060872; x=1758665672;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qiF6q/qc2OvYsPYivTGoF0XMP0CR+2eYNeCKqhmzwI8=;
        b=DRc4MPA+BbExrE7AW+X+m3bXxD8dvNeKuREubLNyqBGChL/9VPmGaE3QLxpkGdQ+vW
         83q1Xzcl0bNWBCSEtN9J+pQCe7plQOpX1dlPyawzK+CfmRVKG65cwoS6X3BYIBE3QTZv
         +QvpRtGomsVnuqXqZYrh8KKoR+OEWrvSvaKMPKgrdWHZMiHxtJQDrkTRiHpoO8Z+xlDJ
         WYRW+xKKLAQDw5MLm3/NhRq8lP5QGKYFEXuPmCJHq6IceOjQjkQGGlrWS40usHtBrsQj
         QPz0bs2iVcTjdOmg5nAqgErBmX5Flf5AESGTOpj+qB7b8gfKTuDTx+hYlQW4blilfgXR
         Y0Ww==
X-Forwarded-Encrypted: i=1; AJvYcCU40xJcqKYBpCjZmqU5ucwyBA3rmzgzpFg8tBnPfUk3vM5e7+tQ4KahT39RxbLmKP1zuI1FQob8pECyN6zP1TM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz8eqvFgv8NbhasW1w1WdA8DMCpVF6plrN/YtUmY1XayL6o5WGO
	QZw3FmZxcszZ0/dgDB8vA19j8ONIf0fdkhAyD2nyEI2C4pfRcHcWqU3YnJJG2yHagw==
X-Gm-Gg: ASbGnculji97mjk2dOHAquzkKcq03xJhIL2kZus999Eo8Op2WMJz3X4MWBGk91cRMba
	SKPMB863QzmAhRo3cjn8zr9Bsrd2HTnonEG/vM3vzcwRz8Z/i57qJpX88wgX/SNtxQtTZcTn7/G
	O4AdFxrf4s5aLxRmn1BnNrUGKA2eMVBNv0yAWKMKPRLhqfz0kkiFzPuxMgETKrHxN9b2tcdVLPi
	ymtSLlN6Ry8xlryDVGaMIzMLY7aSKdj17ygJbOSZG7+wqALcFNwBM1bQqPjgGII5/Vweh0x+5tc
	+hQKm4k/zESDd8hTkMpOwnoGAtkF2KASUMlAjJpUgShQkoH/ph8GeVY0he09F6wyL3tgXjQ+/rR
	5Ym5wOaRCe9iaKKJhkkrUK8VGUtiY/vneNgx1te8oB+w0zsNh9K94F2M7+N2c5rX9YEvx
X-Google-Smtp-Source: AGHT+IG/SrMeymkGiJbnvOHutykafXtF0BLOCNIvqusoPAPpE3DAoRn9SxXC69phn3pcGbIJZbHQbQ==
X-Received: by 2002:a05:622a:58cc:b0:4b5:4874:4f95 with SMTP id d75a77b69052e-4ba69d34e84mr1169801cf.51.1758060871851;
        Tue, 16 Sep 2025 15:14:31 -0700 (PDT)
Received: from localhost (pool-71-126-255-178.bstnma.fios.verizon.net. [71.126.255.178])
        by smtp.gmail.com with UTF8SMTPSA id 6a1803df08f44-77cb4cf2a35sm53565456d6.51.2025.09.16.15.14.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Sep 2025 15:14:30 -0700 (PDT)
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
Subject: [PATCH v4 29/34] apparmor: move initcalls to the LSM framework
Date: Tue, 16 Sep 2025 18:03:56 -0400
Message-ID: <20250916220355.252592-65-paul@paul-moore.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250916220355.252592-36-paul@paul-moore.com>
References: <20250916220355.252592-36-paul@paul-moore.com>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3619; i=paul@paul-moore.com; h=from:subject; bh=ql5+Pc/Tcxt5X2bsPlRUGmu7PmdyNUNLJ0A2/x8cr5U=; b=owEBbQKS/ZANAwAKAeog8tqXN4lzAcsmYgBoyd8olFvS4swyoPBAQ7g+G7mGcw2x3cVOXZ3lI q+GIMs3cJOJAjMEAAEKAB0WIQRLQqjPB/KZ1VSXfu/qIPLalzeJcwUCaMnfKAAKCRDqIPLalzeJ c2MdEADP2iJ/P+13rnlRxP/bJ7RGnPbWihmAZYFt/Hx0krHTW7Bkwk0mDSzXHbNthaQ1KvVMFdJ 7ToCLV2ej34yMtjweTji6Y2LFlldmPgs1qL9eCqRStiYvtBzDyRsqMThwmm6Um3KzRMrp5NxXql m048qfAYWcGze7LfPNFDZZnQZTB4lD57iJAQPSrziuoU7ff54cqbsqr1lDFSDVNrAVCBy1Jn7wd TAjnlenUdKSYBm1JPwZxw73zsvdhUEKdR7fAXHu2veE/dICuySLoy164g1MsvnVn8pyVr+npF33 jNGThYbunOgS0d8PBIO7feTRwyH9EwdPj8Lf6AVH3CBqwW0xNiBl5c8b68v/iw5QfxpjEp0DFcK oH8QGpYDdQrHS4KOUKYtSZTXN3s0HefhDeCgxPhVcOUfuiZg6/ZVO+K7oDVpYEas1oI7m450c8r 2/cN8/l+/jQ89oeqLEipOHTqVnUi2P0KZ9aWyJ5BUJZSMfdqkjnn+QFz6f8Dor4SIIxnE9DBjGz 0z/ibdiY0kN/Q30XEXgbF8XoEBymz6xxeJ8b5y0OpAV1gUHQKh0Hz+34/tOY+or/lw6KZ7tjKYB ET+aTNkL8HFNVmNlPaTJ922QxnJqTInD9KMxWhTZ1xHCpnRYsgil5jUb2FPWLLz94fen9AIt0+k soCXtkvtF04hSIQ==
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
index 45b3a304d525..647c13e13e63 100644
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
@@ -2557,4 +2557,11 @@ DEFINE_LSM(apparmor) = {
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
2.51.0


