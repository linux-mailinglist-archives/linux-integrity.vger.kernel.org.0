Return-Path: <linux-integrity+bounces-5709-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 339A8A82F6C
	for <lists+linux-integrity@lfdr.de>; Wed,  9 Apr 2025 20:55:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8865E461D37
	for <lists+linux-integrity@lfdr.de>; Wed,  9 Apr 2025 18:54:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 996CD27C16D;
	Wed,  9 Apr 2025 18:53:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="d4u5oiYb"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mail-qv1-f47.google.com (mail-qv1-f47.google.com [209.85.219.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6FCD27C15F
	for <linux-integrity@vger.kernel.org>; Wed,  9 Apr 2025 18:53:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744224825; cv=none; b=c1lItKfE2UQDhxM4XqJvrH1J4T0GMcgwrIyyPKdHOfWMdsK694KUbjJ9bIV3DIkR/aKTxDc/saYAVFcms8eOuITGuQ6rfMSPKlBl8838tJeYtM4FElle5ZDWqTZxTpoRCftsmRv61hqd2Aka4JEwxog8ujz4oBnOaqBYmO6+ME0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744224825; c=relaxed/simple;
	bh=J8s0MQCX1rti68StIWFgrsqpocBfi5qZEsksUWpZxis=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lNsT7i2GxbHOlJ4tkYvpaRJT29lS+kMePzmtHUxFCiEQoQvb6q9gRVcj3TemVMSE3GSxQvoN2l6BGr8Y1/AC65vNU5c4KN46FSMjPkwa012XtMTm54VQ9dIf2DxZOvJDTgIKMaw1OQLOvXWudU7Vjlo/pP6m4ain832M6F533wk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=d4u5oiYb; arc=none smtp.client-ip=209.85.219.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Received: by mail-qv1-f47.google.com with SMTP id 6a1803df08f44-6f0c30a1cb6so23164626d6.2
        for <linux-integrity@vger.kernel.org>; Wed, 09 Apr 2025 11:53:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1744224823; x=1744829623; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HeZKybOSs8+NFkJZkOorGpVfvMZ0pYJDZjai2pWJ8pA=;
        b=d4u5oiYb5SBvHvUMBDPwTcHp5dsXnnhQyvkK+mKqQc3tZvxKUjuit8ZydID7xmjsbj
         ka7vrQ5AuOBA3abOYtz9wjOFYXvpL3+AkWgQlhecSCFesxT4pTOfnOL4cINX8II8tFhx
         y8q/mpN3AWuv3yR/YfUz6X3ucZQ4vwiOcTzSF3lA6Y3FOb4X4KljlIdP5po9kqHVnnzl
         rwgP+lHc2AG3mzOPXw5z/WJRhhe/JwB8K4aBxbojClvqal4edvJ4ddFM3vE1Q6D/pRow
         YvMD3Uf/xwGbwA7OcNdMCJ6fHqQW2tpjmfgjG4wy2Ec2AFM0OSua9oZ7SGf3fLkkAgNA
         vjsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744224823; x=1744829623;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HeZKybOSs8+NFkJZkOorGpVfvMZ0pYJDZjai2pWJ8pA=;
        b=T8V0w2oW6OCp5P7QrNC3+Q/xTe6nZd8pZRurzD5ndJyYNXHHSya6tXr1aCW8853u/c
         Y6OjVmu5keV67w2mmyIf000OrnM4e6YFEy1VjbaK5XZJfFoibuDVlftJyQJTULDDBC6O
         2jy5uL2cWjPRZe+rkldivObdeyJmAqX37T63uk4IHqYc5SjymkRA0hwEItwZEyiwAQnl
         LtlGQS+vxkD9q1a+2GRcn+M6UbMjvfJFMCOUovweD986W2b0tORJghtb/gcQoHAt0Ogv
         ezvQUE5am975/+9bmzGtSL4X9qFXqgj8CdADYTcUNt2280oCKUEiisMi29uwsenzDBHa
         ZD5w==
X-Forwarded-Encrypted: i=1; AJvYcCVzRRt1iRU9QXPmDqGMsqgZCRKrPkF/ptDpgiwbGjl1HQwwQR6Zoe1KyyEqBcxisw/F0jPzZ7eHftNA8xLCo2w=@vger.kernel.org
X-Gm-Message-State: AOJu0YzGSXBUpBW+YChQ6wK8prdyEoIMLVlJXGxVEe82plN9MkzbToSC
	Nl83DK+2xqSgKmuWZm9d2JJyn3dyKmBNPps7Q+A6LWsGLKbIROk1gj9106Citw==
X-Gm-Gg: ASbGncs64e63HZCEjlf3WnB9uXU9YLOZqGwvBEpoivsCR7sEdbuHbmQ0TZvYYEfr16H
	h1j01JaDA1D3CRAoKh7esgV8cgZ+ih5fKzRLI1Y6gkqumyv7aVmvHFcqePUJ09jCYyL79ZAurCc
	CVrIlCJ7DXlioV2zQkdcPQUJXGAqLtbMTu5vDJlJcbGPMyqdWhWPi4AMw4+fHJFAOKqJ4C78Hgu
	4CUnCcUWY4s9iIgkyJIv2y/9fOeHyGGl+zht961lGWivP5ak8GXjoHfhYbkFJHBNi6J7iFZIpgA
	desmkSLFj6DZSBt6UdMByzWtjfx7cUiRD/n2DZNmTF1sJmvh6zB0qJ1d9uEJZorM5mTto4umNB2
	wV6a/ghMrnw==
X-Google-Smtp-Source: AGHT+IESHnGzNmRVVfPacCj/vkxRHpaeuMhAwSPmcfan8bf0MsKhilZAB1P0leX7AFd/wHfREf45Ng==
X-Received: by 2002:a05:6214:500f:b0:6e8:fad6:7104 with SMTP id 6a1803df08f44-6f0e5bf7a6bmr258306d6.35.1744224822725;
        Wed, 09 Apr 2025 11:53:42 -0700 (PDT)
Received: from localhost (pool-71-126-255-178.bstnma.fios.verizon.net. [71.126.255.178])
        by smtp.gmail.com with UTF8SMTPSA id 6a1803df08f44-6f0de970d77sm10619256d6.28.2025.04.09.11.53.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Apr 2025 11:53:42 -0700 (PDT)
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
Subject: [RFC PATCH 14/29] lsm: add missing function header comment blocks in lsm_init.c
Date: Wed,  9 Apr 2025 14:49:59 -0400
Message-ID: <20250409185019.238841-45-paul@paul-moore.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250409185019.238841-31-paul@paul-moore.com>
References: <20250409185019.238841-31-paul@paul-moore.com>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=903; i=paul@paul-moore.com; h=from:subject; bh=J8s0MQCX1rti68StIWFgrsqpocBfi5qZEsksUWpZxis=; b=owEBbQKS/ZANAwAIAeog8tqXN4lzAcsmYgBn9sG+swr7AIcKgsrGNx3b01lMOqA9ckaYbHdkB tLPkjbIOgqJAjMEAAEIAB0WIQRLQqjPB/KZ1VSXfu/qIPLalzeJcwUCZ/bBvgAKCRDqIPLalzeJ c4pOD/4iwZ5xEcGorjH8fqDkC59PW1O43qMZWH+uIU1ASOYZSRvLBdrI9VWc5pmswdaw+LgRNWj 3/4F65Osb4v+kK/qHueTrOgEJLjnhhiDANNtGTrgDRHCRSVSStyACKJCYnpJSgfFYLkGMWegURP CtsszZ/hlTxAI+kH2NYeV01p2H1w/bq2c8zq00xS127hDmPBNJ13L2ZWRF//pdUL2W+ixSAKeFB KThZCVFxS2/4sk6s+LBz6Z/D7D8MsQOPvw1bhVWnQP9Ro6jwKo/sYz7fOZnxraMY9yzgyczCVhE I+JkJ3WhDmD9MWdDPWZIZtRqT+AatuEATTHNaml/tvcEKw336cYdSYz/Yoz5e5StQD/C9rLyDAq YVvdXkJEbYN2zlFOJi7oc9STtDQjEzM5DFzIu8aZa7H5RoeRNfdAEiHr+iIZN25Enx5AWjGXEwu OkYLvDxCS4LyJQJ5sKMHN9g0yPlFaRezAdmxGOAjBKWxNaI5bbooB/Fjt9HAHXh2J84IHctuf6Z AjzQ3WnlfZH3xU7kvRhXhkE6ilZdaJQk/JlDTqWlJAaMigj9O84wJ9BU+6z2bgyLbfqWTAS8KnR dA4T+Ohu5ibbuaAgW18KQRbiQIZda+/B0gA8xQ0ooXUz1vyxM+y18jVW2pT7czR8AyHvrUWvc3S jE9TGSeQuAzCq7A==
X-Developer-Key: i=paul@paul-moore.com; a=openpgp; fpr=7100AADFAE6E6E940D2E0AD655E45A5AE8CA7C8A
Content-Transfer-Encoding: 8bit

Signed-off-by: Paul Moore <paul@paul-moore.com>
---
 security/lsm_init.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/security/lsm_init.c b/security/lsm_init.c
index 55b3fa82db76..04b1f5e760b1 100644
--- a/security/lsm_init.c
+++ b/security/lsm_init.c
@@ -313,6 +313,10 @@ static void __init lsm_init_single(struct lsm_info *lsm)
 	WARN(ret, "%s failed to initialize: %d\n", lsm->id->name, ret);
 }
 
+/**
+ * lsm_static_call_init - Initialize a LSM's static calls
+ * @hl: LSM hook list
+ */
 static void __init lsm_static_call_init(struct security_hook_list *hl)
 {
 	struct lsm_static_call *scall = hl->scalls;
@@ -351,6 +355,9 @@ void __init security_add_hooks(struct security_hook_list *hooks, int count,
 	}
 }
 
+/**
+ * early_security_init - Initialize the early LSMs
+ */
 int __init early_security_init(void)
 {
 	struct lsm_info *lsm;
-- 
2.49.0


