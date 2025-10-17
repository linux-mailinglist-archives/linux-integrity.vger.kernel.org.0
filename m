Return-Path: <linux-integrity+bounces-7460-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BD178BEBB01
	for <lists+linux-integrity@lfdr.de>; Fri, 17 Oct 2025 22:30:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6C997745513
	for <lists+linux-integrity@lfdr.de>; Fri, 17 Oct 2025 20:29:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0110224234;
	Fri, 17 Oct 2025 20:29:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="XwTH/m4m"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mail-qk1-f182.google.com (mail-qk1-f182.google.com [209.85.222.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07BE3354AF6
	for <linux-integrity@vger.kernel.org>; Fri, 17 Oct 2025 20:29:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760732952; cv=none; b=bljZvF37SVIQpJc8F3b75ZmcexxSa0lo5K9Tm8YTkJxKVchV7ZxNkP4SagBe8TzH37ksAVcpYIm1g9dsIi4Uce1p7ngGxzmOG7qY1TV4dosIFSa2eBjtoopmKUj722r5a2kQptiN9YuHD+Z+QSCdplid+4twUaA+/OAXMP0iVzU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760732952; c=relaxed/simple;
	bh=Hkdj0OI5JGvnXUWu3kZ7e6LcKqeJJ0y+zTjBis11uXk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nokkHstAknQlW+R24qFNPIzI121SJwVaRvHMLHe+o6nOHP3FGL1eDotfRZ/Wr1rXTd2aPUmrNzVHJzbq29RxHiLNvunrbP+6sm10sqpt2/w/SEn/r7PmCFwkqhJcpcTNfgYMwK0k7sbKuIFicLogEkIaezd3OMcDkrq1/F0tBRM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=XwTH/m4m; arc=none smtp.client-ip=209.85.222.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Received: by mail-qk1-f182.google.com with SMTP id af79cd13be357-88e525f912fso346869085a.1
        for <linux-integrity@vger.kernel.org>; Fri, 17 Oct 2025 13:29:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1760732950; x=1761337750; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7jaiQLqTK88O3hgkSrlCVkxlRCh5w9zQGBkzoo50mK0=;
        b=XwTH/m4myY+YLtJyIBVH2mmqchK6vECTBMA72swMoyGS6c2eI/zBpiIAcETu9wqXut
         +fZihhqXpiAO9jWw/26CGRy/laFScTMxpfae5sw8AghMxOSzU5gcAGS97wuDTYikCAMc
         NUq1tmr0U9GXK2M105rx6FinVKS8rCdxfXAWBeJci5S1qOstbKqw2q1RxZwya9tSQGHV
         E9LXoPknyAxJiy/LZmwMp9Uvh6uobeOupwnMqENTFxCEJfN3KbsYG5H323R8WRaTK9am
         QV28x/15n/Nm6/dcaJjDkwu7wdT7X/RPaLKqJgETZav/VULB0T95zoFK4Tyd4fUx8Mys
         l10w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760732950; x=1761337750;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7jaiQLqTK88O3hgkSrlCVkxlRCh5w9zQGBkzoo50mK0=;
        b=mRTlchDxLpQbsqLCkUw2gbyU5B63uLFZy5UoA+2AKTkClSvKxE3fneu3ClUjsdcLR0
         /GHez4Ec2euN/VQmVjh6818/abbs215ax1FNnDwAbHpPjZdI87JSf/IzNxUGfrOuZvHo
         Y8lebzBVU1JofdosugQy0od+Y3wtMWJXXm7j8ZbP2emKc1XjaLPFugZQIGl7RczcUa9Z
         X/pb2xFlAnPB38mpznlR/JgJbaMsQJmV890eziXfq5AzB6qyzA+bAsGycQlLObS1OOw8
         dnFJZT3wI2pAg2deNrKyPkcilHOBtqUChnaoG8CzU+mXOHL14LjBvNvSDSYZNmuow0Sr
         ywHw==
X-Forwarded-Encrypted: i=1; AJvYcCWV18MzwC6Ts0cGx1tIUsivDK9Bb1vY+vGzCO7jtaST75bjWow3HAr9VOdOa+3ig/Y2i72GunrOAfCHtEOoHGA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxThrqoFQ3dE6CRpb+7ZgNKF2BUAM8a+GL2jvlLTqT2+P+nWmeu
	+hmSpJq9zGFH65VvAaYlQSokjkPcd/k6rZqooK2FSPJ1SJSJLfb1gPIz4oS22QMhSg==
X-Gm-Gg: ASbGnctacH4kd80Mhh7aAbKLt0LWTVQlOiAa4/o/OUI3W+lcOhTroVWGrT9DHUNozop
	64pNDAem+okit7sDaefQbnOLDHgg2xM8V9EP+s25LKSZ9tJC2RNbhW0IphiO/M+OuNAByrn8ZBB
	bU9UJFpVqjbbS0ml9VYWiRxkmyi/jjMSEOYZGVavekspSHhrVhdtQzdXK1MxOwfLycVKM2PxS1p
	coGbNdMX8swRQJy0o91uvhnV9z4rsG+1cSJ+s5GTokmEd8cQbk5wIeUx3tbRlwM9+BwasVYIAbY
	cueYOF0YwB1e3FOeQ4RVqUKHin79iwq+4P2qCAmLwJBNb5utCjyM+s5vNo2hXohY32DvVvbrX4o
	pDrdSV7TkylC183IU+U0dluYywbnZiGDfBgVBVlm9sGtlIsO6drfT1ycbt8Aw7XUI6cyAgCNMt+
	rcsHY+CqnOyXCOOzWn4xKS0Olvbg2CY+uE6HGMRFVJrbbAeA==
X-Google-Smtp-Source: AGHT+IEtw775NA3ah7SYtQxU+JuV7pz7Eynz3OO4GnJm+Qc7/WwYCJ5of7onDXeNlNj49WNAEvKm/Q==
X-Received: by 2002:a05:620a:a1d8:20b0:891:2289:c8b0 with SMTP id af79cd13be357-8912289cb99mr403826785a.28.1760732949855;
        Fri, 17 Oct 2025 13:29:09 -0700 (PDT)
Received: from localhost (pool-71-126-255-178.bstnma.fios.verizon.net. [71.126.255.178])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-891cd57c825sm40664185a.28.2025.10.17.13.29.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Oct 2025 13:29:08 -0700 (PDT)
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
Subject: [PATCH v5 13/34] lsm: rename exists_ordered_lsm() to lsm_order_exists()
Date: Fri, 17 Oct 2025 16:24:41 -0400
Message-ID: <20251017202456.484010-49-paul@paul-moore.com>
X-Mailer: git-send-email 2.51.1.dirty
In-Reply-To: <20251017202456.484010-36-paul@paul-moore.com>
References: <20251017202456.484010-36-paul@paul-moore.com>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2045; i=paul@paul-moore.com; h=from:subject; bh=Hkdj0OI5JGvnXUWu3kZ7e6LcKqeJJ0y+zTjBis11uXk=; b=owEBbQKS/ZANAwAKAeog8tqXN4lzAcsmYgBo8qY/bpHjwlAYnGvTqNUcCI4NGr7OliF9vSWzN NQ6D11MM2eJAjMEAAEKAB0WIQRLQqjPB/KZ1VSXfu/qIPLalzeJcwUCaPKmPwAKCRDqIPLalzeJ c/W3D/988hhqWa5zZ5Lj4EZdjriGAY55Mrc7utuuQn4GAZ4+2C4p3LPU7XnpFBiY0vPqx6/M/Wa W8Ius3I2Qu/we/faYbCpoJ3kWQGwzriAUQst/5QSvagG7kuX81jw6TBrTMa+wwYGC01EEJc9Pu8 u+jPEDsglk4n9bZBWRaHq0eke5N/kDP5SoEyuf2sUf4DHyMuLnHUCpmtb3mRw6EY+qvX2wOU6fs qkFYk5bHZTTlaAHBKm1gq6zlCLf9OzgMYtS8eEL0WK9Jt08MdlqtOkQaX3OPVbSFRMyWAWIoGNc pxFsmbgiP/HHS/hC/p/1kiMOAgVqmO0ouk6Y3VaWxmOvkLfvFeqKPBMMBOFNkOKZEFQMFzWEr2/ b8envEFd4b3edHdrK8pP9RN6ahuepbuloELYyM6RDoT7OuU4W5m5oeqDD32kERL+IvxElN3d3yz s7I5jOFOn/7tD4RRzPCkM7/aEomfj5EwaEMCcptvhXnkiNhzB4HTRB2BxXBDqvI3SCKwaedwxPw R6gRzZmK7U7Yq/0gs2is01+rZBtWTBYz6FDbHgYGPajkwSyKRYMx/fBr/vt9iFE+TLNzoqx5Ykn KiMX8jy3XFIAls2pawT+zOMBtOJqC75XwF2c+YETB9TH36UGvMgJuwEYc1pYcwtHZFConahM0wb 7QMgflWFovfPURQ==
X-Developer-Key: i=paul@paul-moore.com; a=openpgp; fpr=7100AADFAE6E6E940D2E0AD655E45A5AE8CA7C8A
Content-Transfer-Encoding: 8bit

Also add a header comment block to the function.

Reviewed-by: Casey Schaufler <casey@schaufler-ca.com>
Reviewed-by: John Johansen <john.johhansen@canonical.com>
Reviewed-by: Mimi Zohar <zohar@linux.ibm.com>
Signed-off-by: Paul Moore <paul@paul-moore.com>
---
 security/lsm_init.c | 13 ++++++++-----
 1 file changed, 8 insertions(+), 5 deletions(-)

diff --git a/security/lsm_init.c b/security/lsm_init.c
index 9bfc35b44b63..4b66a8cfe8eb 100644
--- a/security/lsm_init.c
+++ b/security/lsm_init.c
@@ -108,8 +108,11 @@ static inline bool lsm_is_enabled(struct lsm_info *lsm)
 	return (lsm->enabled ? *lsm->enabled : false);
 }
 
-/* Is an LSM already listed in the ordered LSMs list? */
-static bool __init exists_ordered_lsm(struct lsm_info *lsm)
+/**
+ * lsm_order_exists - Determine if a LSM exists in the ordered list
+ * @lsm: LSM definition
+ */
+static bool __init lsm_order_exists(struct lsm_info *lsm)
 {
 	struct lsm_info **check;
 
@@ -126,7 +129,7 @@ static int last_lsm __initdata;
 static void __init append_ordered_lsm(struct lsm_info *lsm, const char *from)
 {
 	/* Ignore duplicate selections. */
-	if (exists_ordered_lsm(lsm))
+	if (lsm_order_exists(lsm))
 		return;
 
 	if (WARN(last_lsm == MAX_LSM_COUNT, "%s: out of LSM static calls!?\n", from))
@@ -269,7 +272,7 @@ static void __init ordered_lsm_parse(const char *order, const char *origin)
 	/* Process "security=", if given. */
 	if (lsm_order_legacy) {
 		lsm_for_each_raw(lsm) {
-			if (exists_ordered_lsm(lsm))
+			if (lsm_order_exists(lsm))
 				continue;
 			if (strcmp(lsm->id->name, lsm_order_legacy) == 0)
 				append_ordered_lsm(lsm, "security=");
@@ -284,7 +287,7 @@ static void __init ordered_lsm_parse(const char *order, const char *origin)
 
 	/* Disable all LSMs not in the ordered list. */
 	lsm_for_each_raw(lsm) {
-		if (exists_ordered_lsm(lsm))
+		if (lsm_order_exists(lsm))
 			continue;
 		lsm_enabled_set(lsm, false);
 		init_debug("%s skipped: %s (not in requested order)\n",
-- 
2.51.1.dirty


