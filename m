Return-Path: <linux-integrity+bounces-5713-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DE8F9A82FAD
	for <lists+linux-integrity@lfdr.de>; Wed,  9 Apr 2025 20:57:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CADEC8A46DA
	for <lists+linux-integrity@lfdr.de>; Wed,  9 Apr 2025 18:54:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B65E27C175;
	Wed,  9 Apr 2025 18:53:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="MlUMReY1"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mail-qk1-f171.google.com (mail-qk1-f171.google.com [209.85.222.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB7D327C178
	for <linux-integrity@vger.kernel.org>; Wed,  9 Apr 2025 18:53:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744224829; cv=none; b=bm4jTsk1Kcot4PFhE+bwIyQDohvMqNkEtlunzCmNbUhjX4isMTeEksIGREtnTCZhzL8DW/HzhCXt7twVu2Y6Y++Hox3G6ifL2d628JFJM3pNPCZA6pJ+YvxyvNkHd/dfWY3jv6y6YLxUlgq2OuVgwK8dmQ/OFZlSYxvwuDkH8s0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744224829; c=relaxed/simple;
	bh=U0J8daT5qbdY0XH0/6KwMZfXF6KoGXdJq3T5B3kThVs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EZ2JGuR83KIIH2CzRU39d7IH12vJKtcTYEg9Xwp6bzdwAfBjVnOwV8JTFD/82DXofzochTvxIdJ3mZi1FbOopn5zopnTOfS+69YY2L1byfbs47QiBx9ocmnM4RX6O4qwj0QSyh4a6Y+6fy9w2PuRehWJjMWkqi6W7XgjC20UGEM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=MlUMReY1; arc=none smtp.client-ip=209.85.222.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Received: by mail-qk1-f171.google.com with SMTP id af79cd13be357-7c54f67db99so113480185a.1
        for <linux-integrity@vger.kernel.org>; Wed, 09 Apr 2025 11:53:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1744224826; x=1744829626; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XOHKz9d/qjT2CE9duhaUIeD9jISgOoKf1CYvh/h5rto=;
        b=MlUMReY1lCgQD/eolgpi9Nr2raLx8fyK/f/5UFvFpjgpC+ghisy+6p8O9hvspmDe7h
         ZxD2q9eEHqdyI4QOCghfzrj9w5sqG3+Bpl9jFIhbYI+msYw9pLQdV9CxYdkQ77QE3AkP
         uKoU6SFRCvV38f6t1iv5r/MncgpusEajtdgBYvgIE8UePHbsaMyIsJD+maZ9fd2pepIb
         iYIQDO6q3xBPNHRG+FiqNyGVrqkTDlguV5JOk7b8zAwmTBz3OWuUVX4dF02YU4dOYNiR
         QWf3wJMVAtivjAyvIEy2xf9IpB2Q6Yr4mYdo0FEBlBqj0sm+tzkuoRdoqTDj01kn44k6
         MY7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744224826; x=1744829626;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XOHKz9d/qjT2CE9duhaUIeD9jISgOoKf1CYvh/h5rto=;
        b=sfvOtB/9vAf6AcOrvo6/Ik2eel//PES9meea59oLA6/BVvwd0LegLBhQ3evOkUGBpE
         +8Pg6OXCr2l7/oQzBNDM69Mixa1+9XkYH0Glj5yS32sHkD2ovX+dsWh1/S7A0z5hNx4i
         CLQht2Rrnuaqxojb0lKgOWDuz2Bu/DczcGo2O/DhvtOh2sh7xSHp/dbcr4ObSTI/HCyL
         SbPKGtkhJDvgrHNoSIbqJ4+z5ZcxPqsOKdrmbSb6PaA59Qf2XzaQUXFnIBYq1qH2NdTQ
         fvdwNMIbRHl52V4oYS0+6qhGDH2D/wDx0tZUhmrTSven2lSBWVV1vPYETIfVkcU71UfK
         /DNQ==
X-Forwarded-Encrypted: i=1; AJvYcCXwFTy89wpitZKMzDXMjA7FvIXU1z/hKzgyTmY5O3Sts++xTwdjG8Pa1CYThpXsJL2l6+JvLFqGi9WvB7YA9ec=@vger.kernel.org
X-Gm-Message-State: AOJu0YzA5M4M74nfYsYbeMwKTYhpLwm3V5qo2evI1VZxqwmedUFl6tYW
	9DMT12Shsb81sl77orH16FdgHsqIIYqtMErzgdPZ+PqkY52X/FlZKNOXcPx/Iw==
X-Gm-Gg: ASbGncvcHW0Ft6qdxnWu055PT/67Un4bX4VpmCePYAoCum3pDJRnGmjvJoyxqYKCri3
	I317N8282EKiGCUj1Qe7fNDiGXZYGIPgjAJQIGQ0rNTBGuwN/OaE5XXDcxPR5sbzWMeAAOWyRs6
	p17On+AD045SNDp/YJoxuqOGuEGEkKlx68Viz66AcM98LTMygV/40ya7UlQR7xtg8t0XwjqtyCX
	oF8GqSblpfknqqCO9JW9acEI7TSNSn72c0ReDtp4HYw+A6zy/QU0AVoOhK6P2frGpRmh30WPJXm
	S34yFQgq7lgpcdAgxdvq64MyQU7BV1p/R7X9NZc58UmVSzqMkDzbFBXLegIxcOgHNoB6j7g8nfC
	TPmzyBRhIcA==
X-Google-Smtp-Source: AGHT+IG+c6drXp3nozaPsjXztwAoOvjGgCaW6rE/tB4NQI4PpZiDxVdOYrpKlKJ0q3cSZYNhC4QBsQ==
X-Received: by 2002:a05:620a:258d:b0:7c0:b384:77bb with SMTP id af79cd13be357-7c7a65e1ce2mr100060285a.14.1744224826739;
        Wed, 09 Apr 2025 11:53:46 -0700 (PDT)
Received: from localhost (pool-71-126-255-178.bstnma.fios.verizon.net. [71.126.255.178])
        by smtp.gmail.com with UTF8SMTPSA id af79cd13be357-7c7a11c9bd0sm105448885a.85.2025.04.09.11.53.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Apr 2025 11:53:46 -0700 (PDT)
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
	Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Subject: [RFC PATCH 18/29] loadpin: move initcalls to the LSM framework
Date: Wed,  9 Apr 2025 14:50:03 -0400
Message-ID: <20250409185019.238841-49-paul@paul-moore.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250409185019.238841-31-paul@paul-moore.com>
References: <20250409185019.238841-31-paul@paul-moore.com>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1169; i=paul@paul-moore.com; h=from:subject; bh=U0J8daT5qbdY0XH0/6KwMZfXF6KoGXdJq3T5B3kThVs=; b=owEBbQKS/ZANAwAIAeog8tqXN4lzAcsmYgBn9sHWJoStLswLfKePDDr3dsFYxt6C8v3Zk7goC HEKVxevRFKJAjMEAAEIAB0WIQRLQqjPB/KZ1VSXfu/qIPLalzeJcwUCZ/bB1gAKCRDqIPLalzeJ c2KMEACm7+2OCx2kQ5fG7StRMJW/3n1wX/suF7NH5uiAbGUkQgRDyX3aohGr/TNR1vI0WuBxcxd iKIdGrsFiPSGjQVFKWdgQmAA3zJYwHttMd+uS5G03hIGriID5uLDqrsS0x6/jkN9X1IrTgMWXNd 17OyZ6e4fOYvenc0FEn7YTz5Z1RIBC6zdeMSw8A9U1FFGzWltu8mkyQlTnwBBxQonW7ZZ5TLER+ t40CYiSURQJOBUllsApcrEz5+N64liy92cl726YpbmPrw159omGFxwf5WBG1rn11ERliOAlCRxZ qBo/r24HBp56gtHYSSLiVtKUziOqdVTPKEnhCRXJSx1U5ilJF1Sp1wMa+Biem4oqq1ujXQsK/Km 9Ezmy1vpGCuwmTeoZbWXfJO0K8iq2RSRD9RwpaTvcekvWqCbjOJb6AzQ5aaGAs+NI5QulV59d7J QnQrF2hKccrPBWm9TZrQi8k2S2oAstftdKSDzu57BCqJHT1QweyWXYUhN2TUneUPDNLJXfQ2xX3 IJXNGatmzo6V8malwATvZD5r8vEkCJlosykEOhY1nye5NsnenufsZPDWX7fEBy97J1T3oxhmTTP dUpVwCuOnSmTvsyqvwMopHrPMGloXaQBXAtRfVLJSbkgyDmaYBBntNgyOGRo2Y18lN5XoXHL/gG hT8O2jpwYddoTog==
X-Developer-Key: i=paul@paul-moore.com; a=openpgp; fpr=7100AADFAE6E6E940D2E0AD655E45A5AE8CA7C8A
Content-Transfer-Encoding: 8bit

Signed-off-by: Paul Moore <paul@paul-moore.com>
---
 security/loadpin/loadpin.c | 15 ++++++++-------
 1 file changed, 8 insertions(+), 7 deletions(-)

diff --git a/security/loadpin/loadpin.c b/security/loadpin/loadpin.c
index b9ddf05c5c16..273ffbd6defe 100644
--- a/security/loadpin/loadpin.c
+++ b/security/loadpin/loadpin.c
@@ -270,11 +270,6 @@ static int __init loadpin_init(void)
 	return 0;
 }
 
-DEFINE_LSM(loadpin) = {
-	.id = &loadpin_lsmid,
-	.init = loadpin_init,
-};
-
 #ifdef CONFIG_SECURITY_LOADPIN_VERITY
 
 enum loadpin_securityfs_interface_index {
@@ -434,10 +429,16 @@ static int __init init_loadpin_securityfs(void)
 	return 0;
 }
 
-fs_initcall(init_loadpin_securityfs);
-
 #endif /* CONFIG_SECURITY_LOADPIN_VERITY */
 
+DEFINE_LSM(loadpin) = {
+	.id = &loadpin_lsmid,
+	.init = loadpin_init,
+#ifdef CONFIG_SECURITY_LOADPIN_VERITY
+	.initcall_fs = init_loadpin_securityfs,
+#endif /* CONFIG_SECURITY_LOADPIN_VERITY */
+};
+
 /* Should not be mutable after boot, so not listed in sysfs (perm == 0). */
 module_param(enforce, int, 0);
 MODULE_PARM_DESC(enforce, "Enforce module/firmware pinning");
-- 
2.49.0


