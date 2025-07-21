Return-Path: <linux-integrity+bounces-6684-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 81972B0CE09
	for <lists+linux-integrity@lfdr.de>; Tue, 22 Jul 2025 01:25:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8DCB3188F07F
	for <lists+linux-integrity@lfdr.de>; Mon, 21 Jul 2025 23:25:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2306124C068;
	Mon, 21 Jul 2025 23:24:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="Y789R92M"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mail-qk1-f170.google.com (mail-qk1-f170.google.com [209.85.222.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75D972459C8
	for <linux-integrity@vger.kernel.org>; Mon, 21 Jul 2025 23:24:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753140268; cv=none; b=oUfgScLnUWuReIkBTqruxrUiwPXV3LgsxFGWm5yRH6rUy07a1c9wvEpsmgqQExllzyHgbJ/3xdfDKjYXdAl7wAJsud5LAsbPU042dX9lvgsItFCcQKdwETkiihm+JBX/+5mBw5PC4OAzZvgSbFlYsgoc+xLGoxN9mYFcIS9U31g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753140268; c=relaxed/simple;
	bh=rWEpVkUy2dqvcxYudz5qcZe6+gmqE6zjJ4LDoy/uBwo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gyyA35PXLZ81QqwUdF+DsI6jreYFXUxRezxRg47rPenL6Z1+HpMuZd5++/2mhatHvKv3rwTAIUx85HOxz8GScZ0nAraASdvrz7oJDwWasZVCXOC2uAiiWBBthhei9/wqbRNsvRDibFS3RyXKCt0OaylOW+5ZLKmc6DpwYjVgTpQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=Y789R92M; arc=none smtp.client-ip=209.85.222.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Received: by mail-qk1-f170.google.com with SMTP id af79cd13be357-7dfff5327fbso659565085a.1
        for <linux-integrity@vger.kernel.org>; Mon, 21 Jul 2025 16:24:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1753140265; x=1753745065; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=k8Sty0Yvm47AQW1EJnnfuH7Z9BMi8jqNRxSa5V1vvEM=;
        b=Y789R92MI9v5iTdMpXWvAXF8os9ym7VB0mbAb/NuRqR4eoxocKiOyQEHyJM547kE+J
         Ug/HN/vMocNE8K/qZ/446nSTVQmhUPlkE6y+AApNyc77VPFZ63cNa8skDprsmCMoQgiV
         SPqitpciRRHsHtuQ2mEB7DRy4x1Hc97nXyAMMxIB3mjFhMOT3T5AaifkWxpr/MiW8R03
         UpC2mMpudKbX3asBSvDdnVQFwxKZeBNyUMcK13CHwOr2XqSYeccRrY1yjjzJCWtA8OKh
         S0iL1Knh754+UOkghNd8Infk5su6cKV6SKGFXW+cjmHtaz9xGl/2yDfR+0u4jVEE49QE
         m5QQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753140265; x=1753745065;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=k8Sty0Yvm47AQW1EJnnfuH7Z9BMi8jqNRxSa5V1vvEM=;
        b=N5LO+5WTSx2r7x5ok4dCluQAYDbPmQ2uPVXbiDmF//55+c631TxNd3oSyqZUr0pY5f
         KoqbOp9p0aU0dpwhF5uelvzuN1pDnanfeytYFRVGBqw0beAG2tJ0rEmFp1cAIjbaImtl
         C70ZTxGnCePMvUjKIihc57BeHCiYRzOVQ5xt82zJgMkbcCblb9p/5lNvGcsbCnDFUFSh
         +CGXLiIdmSfUXPRWDGIecokdD5ZbbEx4mILvtezc8E8JVyq+p/lSKEGmEi0ZyX8qF3na
         VX+GmkYDkmeC404+FBOUvymmbqKHvHyvewXWSUS0/FjVkeEl/Bd1o4UPBOLcSmj48Kky
         Wi7A==
X-Forwarded-Encrypted: i=1; AJvYcCVuvHDDhSQs/mnjVwhOHKoxAfR7MMUrBYfhKBIEIix4jvwETTlGkQnYv6AWFM4YMr+glmgLwusgnsmvukIb600=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz9BvD2tjx1NQ7/jSvVTGMoNQxib30doJmi0RPjIq89qzrv8Y/K
	n7VKuCSnE9QyS4lW90+7rpDNo8pAJG6XmJECZmf/Md0QRo6qEfEVd1BQNpE1ldLmXA==
X-Gm-Gg: ASbGnctdt4jHVDcUn575E9Sl1IB5pk/d5NVoV8b5UlhJKTX+tmdYVE0T1kiBUv6Z3Ml
	s78ZuGUDgN7zHO7Uc6VwTqKoU9bpI9S13/PlJgFcJHKHWCRQPdbUd4FpRjs0bwn5lpj6EdYTPzR
	WyZQcU5MPHHIJ23b07Ter6fk340PL5k+skg/lgqzaPtsERZy2qjYiELG7PYDCP4tQgz/Yb89m9t
	yMvXyUFukYLo+0UnCILFQa3lNDdUkerxAB0uaSOT2AdkMq4UdvD5OrY9M7yueGaOdFlueNLcPEq
	9xf9de+zDk90yJXnOvIGNohAelOO8l3Xyh/UgFyRaCM5+0f4Xp08rXH3Y5TKgjBx+N9JTBurFSR
	qj5eN8xy9zxU0xgvjZ1a0tTOEciJVQTle394GJx7bdKBFjB14ST4h8c8qSek4bw7d5M4oNA+BTw
	16AQ==
X-Google-Smtp-Source: AGHT+IF/ioivwywFnfqvSdVSQPN2IuSOsLoxM3Pn/Esma3d8AWNt592DU32kYyoZH7edPzQc0a4ppQ==
X-Received: by 2002:a05:620a:640c:b0:7e0:93bc:bf85 with SMTP id af79cd13be357-7e3435ea691mr2055145885a.34.1753140265431;
        Mon, 21 Jul 2025 16:24:25 -0700 (PDT)
Received: from localhost (pool-71-126-255-178.bstnma.fios.verizon.net. [71.126.255.178])
        by smtp.gmail.com with UTF8SMTPSA id af79cd13be357-7e356c61497sm469325685a.80.2025.07.21.16.24.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Jul 2025 16:24:25 -0700 (PDT)
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
Subject: [RFC PATCH v2 24/34] loadpin: move initcalls to the LSM framework
Date: Mon, 21 Jul 2025 19:21:27 -0400
Message-ID: <20250721232142.77224-60-paul@paul-moore.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250721232142.77224-36-paul@paul-moore.com>
References: <20250721232142.77224-36-paul@paul-moore.com>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1208; i=paul@paul-moore.com; h=from:subject; bh=rWEpVkUy2dqvcxYudz5qcZe6+gmqE6zjJ4LDoy/uBwo=; b=owEBbQKS/ZANAwAKAeog8tqXN4lzAcsmYgBofsvdw9cl5BakIq0sgYNW3sKStdr6PBZN5MsfO tor3qOK3D6JAjMEAAEKAB0WIQRLQqjPB/KZ1VSXfu/qIPLalzeJcwUCaH7L3QAKCRDqIPLalzeJ c8s2EACbdNoRMoV1ijwd+tIrou5uhKrAbPTm1eUdlY9Y3KW7u36R/O84iXs6x9oOpDQ9BRRV+md F6D9xCnJrjAjpfxJ6A9d6LcAl2hqduX0YWJG0soTu28cUKfqzh/QeuH/5z5gcjw2zbET1zkXPcf oC82iIM9TihffYbqtPLM6TqsO6dbhzVOYtx3mf7DOTmO9Sze+IoGpmw77uYhj5tR1h6jDUqX6z2 eD2QjGhPUdkm5vb3+TwMlZ9QD8CJU+F0ivc/WV4w6FaHqKGIUyVkvSQClj1MR/tI+KN4o6sVstF HvLAYxxmP4xQlG067metVdGZ4mI8qsxvaY/rPujg5M5jD7EFNSNpxWT0wVOr+EfzGUbQe6E+xf/ jv0bBQ86lqOTSoiY+GuAvmThrOw4iZ1MVDv9af74g7huwYb5dlRj5Mhtad+uXk2XJXdUpU2bfad Swij3hEkyVLI5rJlwlEs0ULL5LcL8KvlrAqzDMI/t3ocXGUH//xfOhHHzkdCdhc5DhmOjPr5Sog DCuNTAFJjJL5n4ZWwceUUNK39itsukM9akAkq2cixKlsiDa4zk4BHAJVhWFbgSRXvnmwyxgBGhi 94usN44A03+7/LCXYS0vVDmafaKQ2BK4eNxUXoiI+yPNW3Dx9k0qSYp7ur4OERG4FLI0capFtze Tx5Lcl2+y37zC4Q==
X-Developer-Key: i=paul@paul-moore.com; a=openpgp; fpr=7100AADFAE6E6E940D2E0AD655E45A5AE8CA7C8A
Content-Transfer-Encoding: 8bit

Acked-by: Kees Cook <kees@kernel.org>
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
2.50.1


