Return-Path: <linux-integrity+bounces-7466-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 3546BBEBAAF
	for <lists+linux-integrity@lfdr.de>; Fri, 17 Oct 2025 22:29:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id E67D850156F
	for <lists+linux-integrity@lfdr.de>; Fri, 17 Oct 2025 20:29:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8DB3354ADC;
	Fri, 17 Oct 2025 20:29:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="FQdv77JF"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mail-qv1-f46.google.com (mail-qv1-f46.google.com [209.85.219.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22FA3354AEE
	for <linux-integrity@vger.kernel.org>; Fri, 17 Oct 2025 20:29:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760732964; cv=none; b=ud10OglJGmFouvoO/juNQbw/EMwveuO9ydL2mLWh7O9+wqR8hCEhDpD/cUoKkxR6wPTrn3Grp4s16DxE6bcjCRActT7Z9dMVfu3W4aTKpUVou8+aVSwWSu1u+jXWN+yNOQefPbCUu049eWpw0AMkxYkE6G1SBWg24VQk2MM22jM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760732964; c=relaxed/simple;
	bh=XmQ/87kzJs96r4NbkdSkX/zZx58dSt43FGVp52ONh4o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=T9Q/3mC0RpG9mRy4MVuSuUnvqjClyOcMqGWifuYl3EaElBDxzxENJACkorniAmnJBEjLXA/XI5iH9V6xkwpP0nCvYOnN0fROv1ANzUOdvbd54L7jDmatKI2GlAYsUQsiSf/9NipLEOeyvKFbVElR/1gEpn7ydbArd0TKSTImxRo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=FQdv77JF; arc=none smtp.client-ip=209.85.219.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Received: by mail-qv1-f46.google.com with SMTP id 6a1803df08f44-7f7835f4478so26026386d6.1
        for <linux-integrity@vger.kernel.org>; Fri, 17 Oct 2025 13:29:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1760732961; x=1761337761; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fjZIch91eH7dpI1wbio56JsoreU6c5SbVK10Nwe8/KA=;
        b=FQdv77JFiKpeJIjZiX4HUjIvGNAqpQk3/v40m1va5ferAqWKk1lV3JNF7irs/m5NJ5
         PDbavS7B7fGe0w7SlRPR8t9KTtPtLEKP3RMuWm/+p/vQ1Jegws1gFglyATeM6kOuciuz
         a/U7IQqOEXEnobRO+boZSjXvMJuoYwOyR3Ahwq9BJYQZ/uW7yGfXelrJK/1/iReKrijG
         cXiD3tIrZlkqr0d0AS5YyOQUnzyUqAusya9H1Csj+Wg41KS47yLkCe4AxPrZWK9Uo66F
         scVRTXyCD6y7xnjJEOlV/YHGutpL6mPBOQwdgymzt2hvtLMJHK+QgLt1L7NDGVONLO7Y
         +QPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760732961; x=1761337761;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fjZIch91eH7dpI1wbio56JsoreU6c5SbVK10Nwe8/KA=;
        b=kmPzy1SDyPlI8cqyBwigPg5A74xfPycCBYB6MNHpcADmOzCCLCCIt5x82Z09imYGsm
         Wsk1BfDWeU0KI+jmmJqwWVwbZ3j/edmRBJLYqJ0Sx/7UAskbYe2CwGCF2ftgHY5duvHk
         E+JRDVVDDRPFxLCPcytgILD/Qpv298/4t34BNjNGTXMXLFAW9+bhxdvjv5QlqNrdlrSY
         vrKToFTlHNHzZs0OjBCPf7TAmiomhM34Hofy3RAx0GH2Y9JMfDGpbO7+U0jkxglolWMG
         Jj3ITEtREKplEo88OMI+bGJjUrbWnLSYURBmyp7y5FVOI12vKPIEetvSGcTKKaMRuHRx
         hdRw==
X-Forwarded-Encrypted: i=1; AJvYcCWtojP7IsAoc4EBMezxJS12P85IXlvxMXVCrYpaEOPjR20YvICST+QcoD6oSOpW3OZ7x9eQuaCClmr+eqt4LF8=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywsp/FCT1Lrva70QgGPiN+CvV2XtX5K8icKCRriJBBTx8Aoo1Ol
	6lZfXRoix55cg3O/nrtHZ5uc7atEp032LWtsBCiKgM8athGPzGdvjBTvxeUt/jvLoQ==
X-Gm-Gg: ASbGnct+yoI9IgAPGO05iK4dYnWaSRyhpEClV/zaZLGWAahUsLDV5TsgO/rIemHSeFx
	/4FBcrRiPwzkHZFi3iRhjQ0H4r7Uyw6nIbaTebBvsR+XhxdpQIMX9nnuP8w451BpkiyYg4e0ovN
	Ie6z7QHPvk9ltUPdmVO41uMkNi3SY0N/LCNFIXi427viI87Pn4uVGq0GoHs52ifaSzCILHZU9iw
	7Dl8kVxFd66M24ls9aHQ/q/6g2j+EDLwmyQFNAMaQF/uONFBDVCs4VcbbDpX5cSzffcFeM4HriI
	gZBB2FAXABTal2LSkFMCb+BORUHnYGm332/ZdRGsdB7XcwI9elUhAREKibDYviFJW/txE5PWEFb
	T4Q7/TrQf2kj6+o9Prc/xJjthJOdgujxCBkPv208var3zsJ9EhHIpJpnbJdiBXXDKl3O7Za/CyS
	3/vtoJq+o5Xc5qZ37gDCC/KwBar4+eQfxfUJvfLnKhMohbIHPaUj5cqwGE
X-Google-Smtp-Source: AGHT+IGR/k3h5EomUp7Dxt8rS7FuDGUqBmqszNScqQV9KZ0xHt66w3sTR77AY2444e9lel1A1NVvvQ==
X-Received: by 2002:a05:6214:da3:b0:820:8fa6:130e with SMTP id 6a1803df08f44-87c20409f88mr67114766d6.0.1760732961420;
        Fri, 17 Oct 2025 13:29:21 -0700 (PDT)
Received: from localhost (pool-71-126-255-178.bstnma.fios.verizon.net. [71.126.255.178])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-87d028aef65sm4813376d6.50.2025.10.17.13.29.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Oct 2025 13:29:20 -0700 (PDT)
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
Subject: [PATCH v5 19/34] lsm: add/tweak function header comment blocks in lsm_init.c
Date: Fri, 17 Oct 2025 16:24:47 -0400
Message-ID: <20251017202456.484010-55-paul@paul-moore.com>
X-Mailer: git-send-email 2.51.1.dirty
In-Reply-To: <20251017202456.484010-36-paul@paul-moore.com>
References: <20251017202456.484010-36-paul@paul-moore.com>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1913; i=paul@paul-moore.com; h=from:subject; bh=XmQ/87kzJs96r4NbkdSkX/zZx58dSt43FGVp52ONh4o=; b=owEBbQKS/ZANAwAKAeog8tqXN4lzAcsmYgBo8qZTnotLsvfdOU9+MMsorwoFVkXQLwPLnLD+P 9GJrzAwP+CJAjMEAAEKAB0WIQRLQqjPB/KZ1VSXfu/qIPLalzeJcwUCaPKmUwAKCRDqIPLalzeJ c8z6D/9/BQa6DtscTpgKcJG7pz2zQ+4uFKd9O0RQSvpHn6CmS3glm2nyffixGd27JzIF/3SX4QL Qv0Rfiq4b5RKvnGofoEkxMgNgDpLvpE4z/bVqF9vp3Ek5I+6YAeQ49wtsa1SDbihm827WwolE68 5NgBMO8FnaR0e3lFplufGf/pZqkzFZl3eZb5w4iutNGxjcPgBxAr4RhihWMAEfUaXHHRS3JOlYw aC8+PFK07kng6IFLcp/3/RbkFGm1Iri0m+4v3be6lcmq7fT7kPQgl9qIBlVNVTLY4YXGIWr+IMB Bk7EX786LQO7fvLGl98CMD+pGdDvdscN0DaWfDYAregIp9Md1Y12sppjX5xHlAPdKdBlsmRY1V2 kje6sTM5o8lxlEH6AhRF9MRmMkipQg4s1UI4yqYIJpsj1Z5RChkTQJCx//QOHbTzSLeuUmPcQcr AMt2pHSDOdtULHX50ySsaHZ6weXR2KCg1XghRpKHGw0Gw8iHhSAnl0E4dkLVfiuU+7Ra+QK44TJ KqAHVHk2L8/N766XCpYaoTIVCuI3aIdlqjEF4YEIwHx0qZ7v4EpVcNe6FEqW4Tz377v8rjpPhdt fWyLOnnp2bC3qqKPtg/AZmHBbdiaGdySpDegtnPETb4znuWqQN6P+tMET+yTYx+psgy7UoI7an0 9gT7g8TBwYX8ZMw==
X-Developer-Key: i=paul@paul-moore.com; a=openpgp; fpr=7100AADFAE6E6E940D2E0AD655E45A5AE8CA7C8A
Content-Transfer-Encoding: 8bit

Add function header comments for lsm_static_call_init() and
early_security_init(), tweak the existing comment block for
security_add_hooks().

Reviewed-by: Casey Schaufler <casey@schaufler-ca.com>
Reviewed-by: John Johansen <john.johhansen@canonical.com>
Signed-off-by: Paul Moore <paul@paul-moore.com>
---
 security/lsm_init.c | 17 ++++++++++++-----
 1 file changed, 12 insertions(+), 5 deletions(-)

diff --git a/security/lsm_init.c b/security/lsm_init.c
index 9cbb10c42e38..bf861081d592 100644
--- a/security/lsm_init.c
+++ b/security/lsm_init.c
@@ -315,6 +315,10 @@ static void __init lsm_order_parse(const char *list, const char *src)
 	}
 }
 
+/**
+ * lsm_static_call_init - Initialize a LSM's static calls
+ * @hl: LSM hook list
+ */
 static void __init lsm_static_call_init(struct security_hook_list *hl)
 {
 	struct lsm_static_call *scall = hl->scalls;
@@ -335,12 +339,12 @@ static void __init lsm_static_call_init(struct security_hook_list *hl)
 }
 
 /**
- * security_add_hooks - Add a modules hooks to the hook lists.
- * @hooks: the hooks to add
- * @count: the number of hooks to add
- * @lsmid: the identification information for the security module
+ * security_add_hooks - Add a LSM's hooks to the LSM framework's hook lists
+ * @hooks: LSM hooks to add
+ * @count: number of hooks to add
+ * @lsmid: identification information for the LSM
  *
- * Each LSM has to register its hooks with the infrastructure.
+ * Each LSM has to register its hooks with the LSM framework.
  */
 void __init security_add_hooks(struct security_hook_list *hooks, int count,
 			       const struct lsm_id *lsmid)
@@ -353,6 +357,9 @@ void __init security_add_hooks(struct security_hook_list *hooks, int count,
 	}
 }
 
+/**
+ * early_security_init - Initialize the early LSMs
+ */
 int __init early_security_init(void)
 {
 	struct lsm_info *lsm;
-- 
2.51.1.dirty


