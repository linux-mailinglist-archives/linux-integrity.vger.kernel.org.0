Return-Path: <linux-integrity+bounces-8243-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C308D21E32
	for <lists+linux-integrity@lfdr.de>; Thu, 15 Jan 2026 01:44:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5289E303197E
	for <lists+linux-integrity@lfdr.de>; Thu, 15 Jan 2026 00:43:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 172B21C5D72;
	Thu, 15 Jan 2026 00:43:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QPt0K3wK";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="mhiTf6vj"
X-Original-To: linux-integrity@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 992021A9F85
	for <linux-integrity@vger.kernel.org>; Thu, 15 Jan 2026 00:43:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768437828; cv=none; b=Dxl0k+A9sIk5GvtaIm2A2nqY2P8SBKlH2fsIDUlPgNo/iyBjsijrAuxsaYsNm8HVaqqTawWUyf0/V1shsmNPmmsq6x6QZhBozQWp6UQksoEtQequ+q2kput7pZ1U5V+wTZ+PUNI412oFiXBn+JqpPBEunfjDEuqG5mQWWDzb9nI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768437828; c=relaxed/simple;
	bh=Uk2NSQPdfgTq0jMeR9dvSjO2NK7HoD4YahlyEpAv2ao=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WT+7Aa1vCUjMdR3qdJ6QSM0H5yONnI+D+vDiet1TRf+0S5fp0xykGUa0iX9/FYDsfC7SjuVhv/5XfoBOO+TbBohBejv+RSu1l5hPz7X3XlwT+3DYq4at5Aa+nF4JgS/Cat/egvY32L4shs+4hShdHxlfxkpaW/5vOww7HVmENgc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=QPt0K3wK; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=mhiTf6vj; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1768437825;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=k4eXF+yg0VGRJrpW2uvJQuHP3qJwRIyGLrzkDgdoUSU=;
	b=QPt0K3wKX6+yL1IFQ/OAp+6G32SC0pbD2muKsOVxJrhSvXgvbrJdnj4K8+zt/v2bzn8qa9
	69LuY2N575SJ99EN0vgzf3SrLiYy+n9CfhLA8NasXISpvX7rrmGxhU0GDWfG/722n6Uoz6
	qQT4uQz9c0LZdF+pUHN/GUQwO/XKSyw=
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com
 [209.85.210.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-442-9zEZNSoIOSKIV6v_pWX8mQ-1; Wed, 14 Jan 2026 19:43:44 -0500
X-MC-Unique: 9zEZNSoIOSKIV6v_pWX8mQ-1
X-Mimecast-MFC-AGG-ID: 9zEZNSoIOSKIV6v_pWX8mQ_1768437823
Received: by mail-pf1-f199.google.com with SMTP id d2e1a72fcca58-81d9b88caf2so249617b3a.1
        for <linux-integrity@vger.kernel.org>; Wed, 14 Jan 2026 16:43:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1768437823; x=1769042623; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=k4eXF+yg0VGRJrpW2uvJQuHP3qJwRIyGLrzkDgdoUSU=;
        b=mhiTf6vjqntaPBUwGX/XrtXlkc0ZT6uyA98HQr9DeTbxumXUvDLZ2Q6jN065wIzU8k
         Gp85pamycz9BBLy1STkgl2k4bT/b/D6qTjeAH+Msr2OirNY5Dg0uoPvpY7CrcJPRsnvj
         W+XLnguwsOG05wqs0v87AVzQKfhMe1zUJXKDLkLAkpYARn+WR2pwbdVdDuPjA+d4zuKx
         9A4DfIytj5eaDXGRBO4akXkFa5D6vJHkNnNCzA/JCSmx8xlQ5rtfgOHJha+3TCdqj/Ft
         zQbuaVq+GiU1W6VjLjDqEK4muXJvr6Mb/kXJOqPB8F0tLbaBuZau/e3uEP6+WBa0Fz+E
         Kdhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768437823; x=1769042623;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=k4eXF+yg0VGRJrpW2uvJQuHP3qJwRIyGLrzkDgdoUSU=;
        b=Gyg7ROj7S91c3EhsBzHW2El6UaMOT7n5J/B1mDsfIMBYUxGD2JVmc/CGIH+4+jVMLc
         WFLklsUPdtHVmgQ+v8ND53QYKxe43U7E5KGGUtGr2YcDPyvODV5X9rnSv+u6kUVgs3yB
         qqYlsPRJ/deOrD3Uas3dR8hClmLo8Wj9IXCEHAJSA8CN0eyBtsJvwz/45G1USVHEp5ws
         2Vrf9r3QPM6veTwG4tWR0FZ4REJDj8Aj0MdxZAgd8ru0WLBWxu5gwrEx7MPm3a5F2yqy
         7Uc5X116vaYd213Ci+dpLUHY6nk+I/mq+JBrANszNEa4R1CvdiaBHgq/Ct6wAl+iKqWh
         Ka1Q==
X-Gm-Message-State: AOJu0YxiA9vgJE80gNtCKuBEaJiE/MuTau8l1TZ25L2ptIXt5n0kPj5F
	twGfXzcwREoe29VbWpg8x0pc0qNUgj9lmA6dl96R/6ZS0UcZaY65DYtICuISlHgczl6/Yjt/ren
	3TREVuvmLw+D9LBDQSL2l0QTQTMkK79V4yHmdE0iXe7Xagwuq2I1fhPjtRD5TXSnfJh339dr3oj
	X1FfaMBC4BGkADs1SvNt1IVFFY8TOkeNWVXc32dXhZBzQysDV6UtQ=
X-Gm-Gg: AY/fxX5OIrqBIz7/WhrpawSyW9koBxPKF8QD4C30hnQOM/jOS+qwCRAMBuqBfGUMsW8
	MPagcRiIclVY/pb0Re16sTZv9rnpGgAl6fHv1wbUqz1FjaAT8KNFord+gtgi8MuC3ctBcOuMDqk
	gg8tFQGWpaq/Bnue/p1wuvjTWR1MnIt4T5msX4xTy9SU6QosDvD+Mh4zZEt4HrXqlFLazGeHLax
	giOhG5qNUXWMglfvtILwNhb6gSQh1dExCfHfg4TH0MzrAYVI3ax6l1JbxGHN4EcK2UjXwfgoMjj
	GugJY12jCnFdR2kyAl1iYblAt634aYIwh3A9uYF9zTd7VXcDrAYuFJlXiSRk0O4CXtItmjltJKk
	A
X-Received: by 2002:a05:6a00:4196:b0:81f:4abd:f15b with SMTP id d2e1a72fcca58-81f8200640amr3916157b3a.58.1768437823075;
        Wed, 14 Jan 2026 16:43:43 -0800 (PST)
X-Received: by 2002:a05:6a00:4196:b0:81f:4abd:f15b with SMTP id d2e1a72fcca58-81f8200640amr3916117b3a.58.1768437822405;
        Wed, 14 Jan 2026 16:43:42 -0800 (PST)
Received: from localhost ([209.132.188.88])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-81f8e4b6ca9sm692388b3a.4.2026.01.14.16.43.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Jan 2026 16:43:42 -0800 (PST)
From: Coiby Xu <coxu@redhat.com>
To: linux-integrity@vger.kernel.org
Cc: Heiko Carstens <hca@linux.ibm.com>,
	Mimi Zohar <zohar@linux.ibm.com>,
	Roberto Sassu <roberto.sassu@huaweicloud.com>,
	Roberto Sassu <roberto.sassu@huawei.com>,
	Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
	Eric Snowberg <eric.snowberg@oracle.com>,
	Paul Moore <paul@paul-moore.com>,
	James Morris <jmorris@namei.org>,
	"Serge E. Hallyn" <serge@hallyn.com>,
	linux-security-module@vger.kernel.org (open list:SECURITY SUBSYSTEM),
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH 2/3] evm: Don't enable fix mode when secure boot is enabled
Date: Thu, 15 Jan 2026 08:43:24 +0800
Message-ID: <20260115004328.194142-3-coxu@redhat.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260115004328.194142-1-coxu@redhat.com>
References: <20260115004328.194142-1-coxu@redhat.com>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Similar to IMA fix mode, forbid EVM fix mode when secure boot is
enabled.

Reported-and-suggested-by: Mimi Zohar <zohar@linux.ibm.com>
Suggested-by: Roberto Sassu <roberto.sassu@huaweicloud.com>
Signed-off-by: Coiby Xu <coxu@redhat.com>
---
 security/integrity/evm/evm_main.c | 24 +++++++++++++++++-------
 1 file changed, 17 insertions(+), 7 deletions(-)

diff --git a/security/integrity/evm/evm_main.c b/security/integrity/evm/evm_main.c
index 73d500a375cb..00bba266231d 100644
--- a/security/integrity/evm/evm_main.c
+++ b/security/integrity/evm/evm_main.c
@@ -72,17 +72,25 @@ static struct xattr_list evm_config_default_xattrnames[] = {
 
 LIST_HEAD(evm_config_xattrnames);
 
+static char *evm_cmdline __initdata;
+core_param(evm, evm_cmdline, charp, 0);
+
 static int evm_fixmode __ro_after_init;
-static int __init evm_set_fixmode(char *str)
+static void __init evm_set_fixmode(void)
 {
-	if (strncmp(str, "fix", 3) == 0)
-		evm_fixmode = 1;
-	else
-		pr_err("invalid \"%s\" mode", str);
+	if (!evm_cmdline)
+		return;
 
-	return 1;
+	if (strncmp(evm_cmdline, "fix", 3) == 0) {
+		if (arch_integrity_get_secureboot()) {
+			pr_info("Secure boot enabled: ignoring evm=fix");
+			return;
+		}
+		evm_fixmode = 1;
+	} else {
+		pr_err("invalid \"%s\" mode", evm_cmdline);
+	}
 }
-__setup("evm=", evm_set_fixmode);
 
 static void __init evm_init_config(void)
 {
@@ -1119,6 +1127,8 @@ static int __init init_evm(void)
 
 	evm_init_config();
 
+	evm_set_fixmode();
+
 	error = integrity_init_keyring(INTEGRITY_KEYRING_EVM);
 	if (error)
 		goto error;
-- 
2.52.0


