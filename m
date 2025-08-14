Return-Path: <linux-integrity+bounces-6839-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 85AC1B27285
	for <lists+linux-integrity@lfdr.de>; Fri, 15 Aug 2025 00:55:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2E6947AB196
	for <lists+linux-integrity@lfdr.de>; Thu, 14 Aug 2025 22:53:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F0BB27A906;
	Thu, 14 Aug 2025 22:54:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="HDDweydV"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mail-qt1-f170.google.com (mail-qt1-f170.google.com [209.85.160.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBC6E284B42
	for <linux-integrity@vger.kernel.org>; Thu, 14 Aug 2025 22:54:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755212084; cv=none; b=HMxMIPzTYlRHLp2DHRIZlt9MPaewmOT+tYByxoYRtl0q2RxF5DdtznRbQG2+RJw5QtKXWSbSp2JoogzskvT9XQRhA8/Bt7lo9j3bTTue7XYvq7AtWrHhp8jzhHhmcQvAbYkZf1svR72JulykhG03lcjgpMHDLrqbpnLLOFNuN4E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755212084; c=relaxed/simple;
	bh=EvRj0z3A489OwYu0YhC8iHhEFaTZ6nZVfs50KsVwhjU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cc49kW0yaaiIxU0+/FsyR+9M7GGg6yg9jM5D5rsObDqkLSkXK550V+54oJHugzXVulKHQlUMaXKo2Xq2AETNDUzbgdaPwdwelxsiAEhXMzdB8YbZR1WTRUa4YXwv7rOZzMQm+zYbwCr/eywDhevFOJRrcNcM3JkuTWRKAHsq8u4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=HDDweydV; arc=none smtp.client-ip=209.85.160.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Received: by mail-qt1-f170.google.com with SMTP id d75a77b69052e-4b109ae67fdso19363791cf.1
        for <linux-integrity@vger.kernel.org>; Thu, 14 Aug 2025 15:54:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1755212082; x=1755816882; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Zvm/Kq47q7OtcRC/Hfg6cCBD4lKV7XRKo9j1mbdEctE=;
        b=HDDweydVSDBCePUpNpr9J58YD3OWCsQ/1qSc8KmmtpzB7xwG02FHydz52oAj+dALuU
         lESoDA9ftWCkG1BDu6Wt1GNpan8Nk0htyXhUsY5+d8FMERrlhn+qCUnDvfoEmlgjB3ZU
         4vhnaJOyGOKyQiuJSJXwXod+/3LBUpTIjlZm9zsC7azgRfihi7BGbK07W/yh8untlnmz
         MFSRybYrz7jTPugCHHCDN8QG9LjCX7ARUlqsAAwJstcotTOwaGOvVv26vzrMcDGC9a9h
         au8/Ves5H5n/il8EsEQY9k/B3NZmx/gYO+ki/gohNZ8N30qLDcraNB1BShgN6y8VtxvQ
         VAvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755212082; x=1755816882;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Zvm/Kq47q7OtcRC/Hfg6cCBD4lKV7XRKo9j1mbdEctE=;
        b=dj1stcCVi1HTKie6J9tBwJTMWpytUbFQWRac41QAp45lZWTYbylT/mu45fkvNT61ub
         YugSquBsibI70YNBmRySMsGsfANooqOErVGsQlej/rHPzBzYAGEi5XsTDsgs8Raz054G
         VMeNW9yBqMhv5uqSDB58fM5iyjXxCSAD/VExs1bFq45zKxtnE2/fw8bxS3t2JgtQz7CB
         JEwto4Tw65oZAMGQDCVQPGG9/gCQArgvZxyi9IbjEacwrD7JgQuiqIfiJoaXt9+SKC4S
         gVvAb/q0Z3EuWh8lmfyxHVfb6TBI4SvV0o9b2MjePL8SycZ8Z5L5DErqxy/8wI75ENWE
         JXUA==
X-Forwarded-Encrypted: i=1; AJvYcCVyAmndb/HGpkqPgzJQ4fdEF8lK0zcQ7KtDBUcyKPeqX93B7V6sxhNkzPlM/FQysmqZK25nLmmO2g9DBUqFqoA=@vger.kernel.org
X-Gm-Message-State: AOJu0YyM5qPfroUG93vp5ZjG759ax5LIG8Uh+DoQEqTVzEPLRWfIjrwI
	EuG7/00SoI0QFJbimEM+JLYuDxtGqRCIEGVaLi4z2xygUMS38TgWq3KiKOatfP8W1g==
X-Gm-Gg: ASbGncvnPHmGBoRdR0Dz9b3k0XLj1BrP9bjqO3HtHokkqQOTcTW68H2e7PEZG0IIb6h
	UcYAqNL8x9/Y7PwaKBd9x8wbYcd6zNYc/45peWdA9faPsfDSmgVrfM9mnnRddLylk3kB4p5pv7S
	WiJ1BBnaQRiqf56dkqKn5uvD/SfJae9yNe5e+S5R6bbaZuWpJ+eL7cJC09f78d5BUXNTBJYko+6
	vTY2XEO4aF29Z9eblJ5iTlN29yWh0aIf3a4DwvFshrq6QAOGi0dneCSJ4qAl5PDGxP13ck/d1Q4
	471ESIJIfUowtBNznxWa0W0YO0mQz75Vxd+fveBCi0jvLOgXkTQvt0F2UiRynor9yR4a1vFVA1W
	9w5KFqSNWiqk+4M/loZiDdMcCCShcZkFvPeiLQ9+MS99ws3GNKBdeRNPfrCuyavldsOE=
X-Google-Smtp-Source: AGHT+IHYbz6wO5EzoDxYSgqc7ezt6nnVQVZBpa8Cfj2ETC46lvOPeTyaI7KR7TvlpCvGq/iCZq+Fzw==
X-Received: by 2002:a05:622a:15c7:b0:4b0:7b08:b072 with SMTP id d75a77b69052e-4b11afa04f1mr7707501cf.9.1755212081894;
        Thu, 14 Aug 2025 15:54:41 -0700 (PDT)
Received: from localhost (pool-71-126-255-178.bstnma.fios.verizon.net. [71.126.255.178])
        by smtp.gmail.com with UTF8SMTPSA id d75a77b69052e-4b11aa7cbeesm2336011cf.58.2025.08.14.15.54.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Aug 2025 15:54:40 -0700 (PDT)
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
Subject: [PATCH v3 21/34] lsm: output available LSMs when debugging
Date: Thu, 14 Aug 2025 18:50:30 -0400
Message-ID: <20250814225159.275901-57-paul@paul-moore.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250814225159.275901-36-paul@paul-moore.com>
References: <20250814225159.275901-36-paul@paul-moore.com>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1546; i=paul@paul-moore.com; h=from:subject; bh=EvRj0z3A489OwYu0YhC8iHhEFaTZ6nZVfs50KsVwhjU=; b=owEBbQKS/ZANAwAKAeog8tqXN4lzAcsmYgBonmjQqxLNEVB9FixjO46YYoRTb03zMbFRC8Dvk 5N69+KXHQ+JAjMEAAEKAB0WIQRLQqjPB/KZ1VSXfu/qIPLalzeJcwUCaJ5o0AAKCRDqIPLalzeJ c/NuD/9L42jZjqF34ixMTfTCSI55pHCiIGrqmtLmBUbWjM2M51FLmbT5NmKa5O085XlGsXGK35+ 9k4ODaGVUjP9xFYEuStRMIcQQ8l3L3ed0zqoHe9xKvyk4YpvbOFstEGAPaT0vKWS5BEfaehRo4+ 9DKKlbMd459E0JAVG9qIGzSKw/chQFD317LMyU1jDbE3suj6H1bU3nWndplv6VPa3upPzNcJVwa oHCesuJM1S53ZnlUt21ZwEpKRLN2eV2eSb5Wo2fhhzS9B/Rrfno4ygLVDJwg2OfZJPk9WjcuWW3 g55ZBQGreQmx64zTbe2tZBGSmtLGMN/tMz7+KFcgK47arKPs3p/JFq8Y3vVZ7queAIsqRvljykC GKrpRWwORu8b1jUxIdXE91ERV7zpg/9ZFoWFuf9FMqZkvo163mjWZMQrr3V4Ex+TPq+dfNFvDHb UQrRORJmv5kG9zWoDkA3FToWf4J0653OafIrdrw19wIlww2ZkrnafkhldKvJ6R7aCnQpsHDkJzg B+zuzxOr94axhTaenawYfqDaVQvHh4Sf6B7DpJH4osknZcN8JXjk2287nj9cc9ziF6uYBHJlxgR dtm/aacZf+W3+fTthCShMlK4QOWoeXCICLC9+a0Xk0LrFBEL6m/pVTmVTmjsO9jHibeG/wM7UY1 q5Ddms6aWmQvc/w==
X-Developer-Key: i=paul@paul-moore.com; a=openpgp; fpr=7100AADFAE6E6E940D2E0AD655E45A5AE8CA7C8A
Content-Transfer-Encoding: 8bit

This will display all of the LSMs built into the kernel, regardless
of if they are enabled or not.

Reviewed-by: Casey Schaufler <casey@schaufler-ca.com>
Signed-off-by: Paul Moore <paul@paul-moore.com>
---
 security/lsm_init.c | 19 ++++++++++++++++++-
 1 file changed, 18 insertions(+), 1 deletion(-)

diff --git a/security/lsm_init.c b/security/lsm_init.c
index 2f7ae26fca0f..c6aea57a01e6 100644
--- a/security/lsm_init.c
+++ b/security/lsm_init.c
@@ -363,6 +363,8 @@ int __init early_security_init(void)
 {
 	struct lsm_info *lsm;
 
+	/* NOTE: lsm_pr_dbg() doesn't work here as lsm_debug is not yet set */
+
 	lsm_early_for_each_raw(lsm) {
 		lsm_enabled_set(lsm, true);
 		lsm_order_append(lsm, "early");
@@ -385,9 +387,24 @@ int __init security_init(void)
 	struct lsm_info **lsm;
 
 	if (lsm_debug) {
-		lsm_pr("built-in LSM list: %s\n", lsm_order_builtin);
+		struct lsm_info *i;
+
+		cnt = 0;
+		lsm_pr("available LSMs: ");
+		lsm_early_for_each_raw(i)
+			lsm_pr_cont("%s%s(E)", (cnt++ ? "," : ""), i->id->name);
+		lsm_for_each_raw(i)
+			lsm_pr_cont("%s%s", (cnt++ ? "," : ""), i->id->name);
+		lsm_pr_cont("\n");
+
+		lsm_pr("built-in LSM config: %s\n", lsm_order_builtin);
+
 		lsm_pr("legacy LSM parameter: %s\n", lsm_order_legacy);
 		lsm_pr("boot LSM parameter: %s\n", lsm_order_cmdline);
+
+		/* see the note about lsm_pr_dbg() in early_security_init() */
+		lsm_early_for_each_raw(i)
+			lsm_pr("enabled LSM early:%s\n", i->id->name);
 	}
 
 	if (lsm_order_cmdline) {
-- 
2.50.1


