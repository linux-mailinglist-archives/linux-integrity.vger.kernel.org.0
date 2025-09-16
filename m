Return-Path: <linux-integrity+bounces-7112-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 19B05B7D73D
	for <lists+linux-integrity@lfdr.de>; Wed, 17 Sep 2025 14:28:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0E37C7A57A8
	for <lists+linux-integrity@lfdr.de>; Tue, 16 Sep 2025 22:12:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCFF92E611B;
	Tue, 16 Sep 2025 22:13:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="EcuVuFsR"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mail-qk1-f169.google.com (mail-qk1-f169.google.com [209.85.222.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 073802C0270
	for <linux-integrity@vger.kernel.org>; Tue, 16 Sep 2025 22:13:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758060830; cv=none; b=WDI8TphyHiSta0EZEtp3Ho0uHPZQUkQ7xxKcrmApIYP/ObAS9iPJsdxWVM27nVChQnz6qekLRW5cPEd/zpYm82jYOgBXNPuqMPK3ByeCXReGCJ9caqlM95s3UxTGWzq7sf/8/zT1BEvHr8lRhbcrsDALmeaZMdLSAAGTPXTFGJw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758060830; c=relaxed/simple;
	bh=TzxbWMzJ8IVnloDxfDvAgfdeVprPOL6CVtEZr+w26Kg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=L1HFUFzC7uuAFWnXLa9UZeCMBJCND7yL/CtD824BRdkTD20oLMgA9KyrnSOYpnMQ4HE8aBlhpzaKg5NiXZIwPPeKXVJ7ya3vVRnhMiSt035jo2aZjhqRlMvvXBZUBC8sYzANV0M7dl5nV0r8UAHwcZr1YMXFn5YGkHS+4kR3ako=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=EcuVuFsR; arc=none smtp.client-ip=209.85.222.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Received: by mail-qk1-f169.google.com with SMTP id af79cd13be357-8072bb631daso566599685a.1
        for <linux-integrity@vger.kernel.org>; Tue, 16 Sep 2025 15:13:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1758060828; x=1758665628; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=p7VijEH6O1uxeyoPa4WBGEvDZafel6Lc9vEdN1yelH4=;
        b=EcuVuFsRCUuhX+fG1sRkERvA8f3ftl3WmzmmxtJQ8ymDpjjzX2a1JICwSfrDBM/iKk
         wLjMEjlcnS7guNuxzfQA91C4g1KcvA3eq/Jvk7TypFiAmBKbXDuSqG+8e0Q1qx1igV7y
         7tmkngYFGCLtp5fLnMojlYKlNflpVH3omwqPNjBenpq5UrUwKFPhv/kHmSeCkjFOJIZJ
         ngXUuHSIPKKtTIJfSboJtetRAh+B8jQWYZp20RmiAch2VSU6nYwMqyCaIIHji0X6isZr
         89BIDnyDHOzhp0i2lVGgvLabCRmA5vNrVklwxd6Q6MzjWygAxihClORlilwGlYY1tqoR
         Q9pQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758060828; x=1758665628;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=p7VijEH6O1uxeyoPa4WBGEvDZafel6Lc9vEdN1yelH4=;
        b=YNhbivq3gZVUapbmRB2Fe2nvv/VvHWmxP4foDgiXt7l9rucq2+upccXEgaPhoqvXgB
         VXHwrW77dhdgDhkELs1PRaMESpHpu0bdubeX41iDTNgSj8AmycAZP5bKO2oQMyheC350
         r9ajZnocpftgrYnqBYDg2WoFLdRSdLWCLDdKRva7sMkTF2+C0QsyulMExdyr5GivCmWK
         5qWkLh0Tf/+OnJGQAWmzVKYjoWap0WPkDFm3LEd/96bZKD8/S70o8YQHYFOlNpftDpwX
         yJwBsT+6/WVH/qDwqIJ4MnmHELr8UEVu6rzGgYei4TpTgEfFqboedNcdYlADcaJ+bVLH
         zXrQ==
X-Forwarded-Encrypted: i=1; AJvYcCUPqiQhnaQTxVVGH1MNPFvsSTJ+t+9A9O5Bsi6tKhkXsp1btgoLE/9dZ0VMfRVQd9zEGPJNsTrj3U5yJVM/MaY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzsYGxmiI8ukgGX2u2JJca89ezLtG3p24GERuCVfBSxoNUrUXa1
	ryYzxN/gO2SDExuO6zYBWVHsJEWjIBkl1Ucl2SHFtDYE+b/ZrNmRDjl26Qer8yx5lg==
X-Gm-Gg: ASbGncsCiw2tAogO1MB/gfO3y8va/8VYogDFbdWvCl5WcmJppefnhhgXlDRf2eo6dZR
	J48u1+QeZdDzIdycZ/0O+TR72nH+5sORay8K/RfwBxHY6WGxEafqYzbADnirvcj1cXkHly7Vd/O
	evZKiexywaH6md39RMb4xCns7FUo5FgkW1OmKts8vshesTlK0Vf/rmSh3RyDLZotZ7LlwUqkax9
	ZIbNc2yWJmcLyezCxNfPMnFUJmTPrg2G/g1fsAQLn+QuhRU4GF2LXfz3p64G3yG/olyFaVtxf4K
	JJJzd+YObPJ5l8ELQ318dbUYqlL1I1apV7Y8ac8rt2BoRq0q0+IXzZCPJXQIyJMGUglrAmBbzx4
	6q0QmLQetRzChqnEnykvLajlyfqDy06CtK0HOErfDrtM3nkVwzKhjCMSqDZcRKEURxm0Z
X-Google-Smtp-Source: AGHT+IE+KYVDJBdEEU6ufIjx3bAoiUKh87hE/SGF39FCtnyEaxhgkXDDoJgJDZaFv9qN9kKYkTO/yw==
X-Received: by 2002:a05:620a:574c:b0:7e8:324e:c7e8 with SMTP id af79cd13be357-823ffcb1bdamr1939521985a.44.1758060827712;
        Tue, 16 Sep 2025 15:13:47 -0700 (PDT)
Received: from localhost (pool-71-126-255-178.bstnma.fios.verizon.net. [71.126.255.178])
        by smtp.gmail.com with UTF8SMTPSA id af79cd13be357-82885187d80sm603851185a.8.2025.09.16.15.13.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Sep 2025 15:13:46 -0700 (PDT)
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
Subject: [PATCH v4 07/34] lsm: rename ordered_lsm_init() to lsm_init_ordered()
Date: Tue, 16 Sep 2025 18:03:34 -0400
Message-ID: <20250916220355.252592-43-paul@paul-moore.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250916220355.252592-36-paul@paul-moore.com>
References: <20250916220355.252592-36-paul@paul-moore.com>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1468; i=paul@paul-moore.com; h=from:subject; bh=TzxbWMzJ8IVnloDxfDvAgfdeVprPOL6CVtEZr+w26Kg=; b=owEBbQKS/ZANAwAKAeog8tqXN4lzAcsmYgBoyd7fyeTtos1GrS53QdVxFHpsUK2UGPsfVutsH iFky9eq/CyJAjMEAAEKAB0WIQRLQqjPB/KZ1VSXfu/qIPLalzeJcwUCaMne3wAKCRDqIPLalzeJ c6YiEACXRaXzB0N/1Q1WbTE/ZgV4y5FgHVjNCK49/I89+/nEVvK8ssrXC836U8a94gG+OXsPi4v jSpGT80Q4nQUAQGxU8Fh0PKpwORYLEJLqvVyjaHHBss6/F1KEvnBAegIbc5olPDXzXYRAMP+ztk WVURGr2xRpftEhpN7799yIH8B2vrsMOg/03DdIb3ZUZFX0G5c/FGiwQKHM3FT1Gx8zQPeY0Xp4F JOXFOO9qZTAe8vpD3WGc1e6s5rS28nxAWL1yUet059b/agLqVJvhVSso8srMEI5TKl1eMrx3mmn uD5hJrujUAXQreCDVuNBTKTEDc3womP+EBT/kHMVJD5kFlcVAkWY1WJgj6HRPzfn/zIL9lOGTmf /6AoHPYt27c1YlOjXrRfcAehjsL3FvNODWQ91V6EGP13s42qwmWwYkrFtnuZDhcpmYNG/jd5r50 SGVBQ8w42iQcf1t9mNMCCujE7RlqFpiX7dXhTFsarfYetd2ZQuEOBEb+GbLKfCvT+Qs1v5E34n/ jvWHE86U44UsjmGGbrzzbFzxpLFTdzDES7GR+syWjquHC1F2pt9GlJ0BDJZuZ0bkZZEf7Evf4BD wKrtM1jNO9PEeKC/EwVJC2vPO8siqrsZ9Tx5xeherFUY6so7iHdqZ243eO9korFbJa4DTbwWOMe 2LoS4IlcdxaHMQw==
X-Developer-Key: i=paul@paul-moore.com; a=openpgp; fpr=7100AADFAE6E6E940D2E0AD655E45A5AE8CA7C8A
Content-Transfer-Encoding: 8bit

The new name more closely fits the rest of the naming scheme in
security/lsm_init.c.  This patch also adds a trivial comment block to
the top of the function.

Reviewed-by: Casey Schaufler <casey@schaufler-ca.com>
Reviewed-by: John Johansen <john.johhansen@canonical.com>
Signed-off-by: Paul Moore <paul@paul-moore.com>
---
 security/lsm_init.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/security/lsm_init.c b/security/lsm_init.c
index a8b82329c76a..4a108b03c23d 100644
--- a/security/lsm_init.c
+++ b/security/lsm_init.c
@@ -291,7 +291,10 @@ static void __init ordered_lsm_parse(const char *order, const char *origin)
 	kfree(sep);
 }
 
-static void __init ordered_lsm_init(void)
+/**
+ * lsm_init_ordered - Initialize the ordered LSMs
+ */
+static void __init lsm_init_ordered(void)
 {
 	unsigned int first = 0;
 	struct lsm_info **lsm;
@@ -342,9 +345,6 @@ static void __init ordered_lsm_init(void)
 	init_debug("bpf prog blob size   = %d\n", blob_sizes.lbs_bpf_prog);
 	init_debug("bpf token blob size  = %d\n", blob_sizes.lbs_bpf_token);
 
-	/*
-	 * Create any kmem_caches needed for blobs
-	 */
 	if (blob_sizes.lbs_file)
 		lsm_file_cache = kmem_cache_create("lsm_file_cache",
 						   blob_sizes.lbs_file, 0,
@@ -498,7 +498,7 @@ int __init security_init(void)
 	}
 
 	/* Load LSMs in specified order. */
-	ordered_lsm_init();
+	lsm_init_ordered();
 
 	return 0;
 }
-- 
2.51.0


