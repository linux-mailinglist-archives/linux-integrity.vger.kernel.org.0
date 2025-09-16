Return-Path: <linux-integrity+bounces-7124-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5094EB7D475
	for <lists+linux-integrity@lfdr.de>; Wed, 17 Sep 2025 14:23:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8519017FA28
	for <lists+linux-integrity@lfdr.de>; Tue, 16 Sep 2025 22:14:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 772EE2DAFDD;
	Tue, 16 Sep 2025 22:14:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="a3vkNC/u"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mail-qv1-f50.google.com (mail-qv1-f50.google.com [209.85.219.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7CEE2F83B1
	for <linux-integrity@vger.kernel.org>; Tue, 16 Sep 2025 22:14:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758060853; cv=none; b=Q1UEfPHcah9t1I2+W2BIt7b4A0We2y5f2cY/rEwcUn6Pd0G8BLPNra8qscvjp9ramKFDTlc8kQAPUe/aAgYWXouvPLoDs7+MQ0FxsLvs/BpSfbGVmEj2ntx7Eunjc7B2jqfCufDZkt32wJTG0Uy+zkizDY3Hx8MgIeYce2vDOGY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758060853; c=relaxed/simple;
	bh=mbrtZf9bOS9pgfXCSv71LdHYNEXgUh6LnTJt3ijKQe0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rUx79JgYMXFPQ643+BnHTSRNbkoH6pd/PIGuCh7p8DTNh7d2LeU4ijPgq5kCGiWxY7MS56FsT0ThtUDPpB/Tbof6roqrF9XugiNIeKYW115CaPcJ4DpUazs/LBDVErvcEIfBAEw010/2USMxbQN2WjDdMeuuw1FQGsmiKhDF1qU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=a3vkNC/u; arc=none smtp.client-ip=209.85.219.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Received: by mail-qv1-f50.google.com with SMTP id 6a1803df08f44-776aee67e8dso19711546d6.3
        for <linux-integrity@vger.kernel.org>; Tue, 16 Sep 2025 15:14:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1758060851; x=1758665651; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wcl2fixASQNkgI+qWy3dVn05HBYvzj4aNmOOyaBFBoA=;
        b=a3vkNC/u26duPApRIlTqxQ9RZFg6IG4t2IzK7OVWdbK5gFvZk2jwTpWHvytzO57zBB
         y3F3EkfCNSIJo35r4hceNV9QVxIQn3rFrqkMCFmxICVSBTQDnW4LMEbuME9PAQzUiVZ7
         PO8KbuUdadmkevCGpwGnOpkDYoUwr4htmJ7tJyjHED4A4cBOiFVWyhQg17mAjF/Ht1iz
         TujGPnQMUJQT7xBPj4wAfxnrrRheykX5ADXkLNlYJaw6EOAu2r46YfJzskHPdNkHMNWU
         /PmtY7u0H1Fv3FxMn+KtFl10aiIJWvgG9ZRQqDNuQUZ6HOWxuhKiKbHtbdZ8vkdJmyjn
         65gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758060851; x=1758665651;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wcl2fixASQNkgI+qWy3dVn05HBYvzj4aNmOOyaBFBoA=;
        b=j12hPkxPsSXD1CiFdzIkVfDHPulRjuEVU5u3z+VHfe4LNuHtokPxVwekEvTq8kHv8d
         Yspvqkl1wb5cun872sVPNahbEMf/CzgDV7q9KJVvPPRW/1Stoi2Xt2OUyLt6Goxjby3X
         6sIr4g5qJRoxkWFofGkB+D8Xeij6wyIlqBE/8fdOGCwoKQPrjqrCFenPoZwVIBGMWd3/
         6eW59m8gBKozvN/P1kPtpFb+U+GimBGpPvpk2NjdXYu1xAu409g6mECwq2FZCVMjbMn1
         jqrY7rIluoFJkmCLov+jBoYMJfJeU1Lj0AoO+8THfxv+H29VlRkq16yvS34IuMpzooaW
         4nSw==
X-Forwarded-Encrypted: i=1; AJvYcCV6gp7qGCZiDrYU4hbzo7r9rArLEevCChAgMjmgK9GSkz7R824rKQmmSGGlcqDiDi/OOAQg6la1DMT17LdzXQI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxOB81aholVziKFyGYIaCfshq4CtSmsbQX/HHttz5ylwcjIJQzq
	4UxCTkRm9M58erq+TEJSY7E+A/usnKxoKsXwbO9aTj7zGd3xBq5H2dIx2CuQEmiPZg==
X-Gm-Gg: ASbGncuj2hu9BpzMBUlgiGHafUSqXMiFcrPlc0FcSMDYbtCaOUSuHatn4UkbYdtSpXT
	0P+WVn/22/ZVwNcrfNBlZqbK+wdk8qBtnLKIHjtle9o4cyUOMgEaN9HSV+nvy7BCCBF0omVf4JI
	VMPGs6ZXsHYNGQfgwdXkpteQWQ7jZO6waoRY3sIGyDzcf3nAcTwC4p4dMvXxerm015sp2FJdQXy
	5InNmS8/kTrAF2Ianj799Okw7/mqmChq36rFGJpSVsXY0iRfV2MeTK0WD4F14otnO8Z7uVUtbUI
	Cb1XDksYojuELzwnxCId4puN5E5/LZp+SVJuNJnw80HQkhgSIFP94fvVEtsGyb2MLhWIBEWEL3U
	TwxP/gFkD3fyuGEdgzTYrdsYjWMpaZxAN0Cbxd31mG46NTpiZgrE25HWUS0u78TbqeNzR
X-Google-Smtp-Source: AGHT+IE7VDyQwt0iMpZDr/QXQ64UR1zTCi+6UpxLl8UGMq8XLQV4GtnegPot0P5ZpAhQpcBY4vO8Ww==
X-Received: by 2002:ad4:5741:0:b0:709:cf54:2cb6 with SMTP id 6a1803df08f44-767bc8d551amr229823596d6.16.1758060850800;
        Tue, 16 Sep 2025 15:14:10 -0700 (PDT)
Received: from localhost (pool-71-126-255-178.bstnma.fios.verizon.net. [71.126.255.178])
        by smtp.gmail.com with UTF8SMTPSA id 6a1803df08f44-763b54a1f09sm100450106d6.16.2025.09.16.15.14.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Sep 2025 15:14:10 -0700 (PDT)
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
Subject: [PATCH v4 19/34] lsm: add/tweak function header comment blocks in lsm_init.c
Date: Tue, 16 Sep 2025 18:03:46 -0400
Message-ID: <20250916220355.252592-55-paul@paul-moore.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250916220355.252592-36-paul@paul-moore.com>
References: <20250916220355.252592-36-paul@paul-moore.com>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1907; i=paul@paul-moore.com; h=from:subject; bh=mbrtZf9bOS9pgfXCSv71LdHYNEXgUh6LnTJt3ijKQe0=; b=owEBbQKS/ZANAwAKAeog8tqXN4lzAcsmYgBoyd8HiCjAkevQZjJQISZc5FQ1r5Yh+jkW+dVO7 P6GrLD5YXKJAjMEAAEKAB0WIQRLQqjPB/KZ1VSXfu/qIPLalzeJcwUCaMnfBwAKCRDqIPLalzeJ c4+tEADYP6tM4QJ2IXfgMtnvka2DvTHO5w/u/w4tgbdTjOw4W2NBYYL8IPe3OxF2LUVoGr6WoUi TAIYO+okDNuXN6nYq3Y+bzhqZE5FZqhu7ylD8rrsG34LXHqfwc1kn97qKgzNCeQfkAdFfWeSuc1 91CdHMgrrgKgBcqMvqqjWN1eYH4re8licR6/UAxVnTCAyZrnva2LnMuWN/MtzxlCtPLlAuVbO+4 IkOJyKIFyvMktBJYd5orCjydtv0c3qkpoPsUq6OgPOTMnwopZh0qEoIIg23yHrLGOthYYFRkjaw tWVehOVlTagcH13ZXKehFUWbsffhFn5CaAA4Ic/qWtx2REkdz6PsCZkavquY/VRVFfJ6lshBGfF Rjmdji/U/7OkMtuNinxKSVCtYugfsRhAPmQ/I8jx2RX7Y3BSWvBVHz5QmeCzSSDzHSaqS8vvogd +ZKFATwoe6AsCU/jIh5l3c4sRYMSLgTmfGbkp+cxh8wRj5VHWRHZKBajv+cJ1+q3eFS0SM091Zw w1r3YKWcTR8WuOjDYd+RhOUZA9wt8l8hP+c9J3uDnk332PStxvD/p/WAOdKuqOBQICwNid8AbxA CbR7EXYqqj5E5qUSOQYhb2Kh7FygaT3ck27oSX+wDLcDlpuTUCujrCtNzgA3sJJabr+p9tpvQX6 +UptfXiBBuWRkaw==
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
index f87f5441617b..37593805ba9e 100644
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
2.51.0


