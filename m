Return-Path: <linux-integrity+bounces-8170-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id DDD0FCF66A8
	for <lists+linux-integrity@lfdr.de>; Tue, 06 Jan 2026 03:08:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B45DF3031954
	for <lists+linux-integrity@lfdr.de>; Tue,  6 Jan 2026 02:07:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72016233149;
	Tue,  6 Jan 2026 02:07:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="Xixws/P+"
X-Original-To: linux-integrity@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 083B3224AF2;
	Tue,  6 Jan 2026 02:07:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767665246; cv=none; b=GtVJrM0cqN/7/lh1+fUXPGlriDLyoXIB6fUSYMYavN+wCYCUnLSU4JQBegbwfB8HInp6rVX8LJrSlnNCzlmRKHiyCvOagJY33cagvknf1CM7o66RV3gqoIPOUIWU2XHlndG6GS3hJkHeA51GtrvZmoqjFbUuj6n4c9fhOJ9Gpz8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767665246; c=relaxed/simple;
	bh=YUD3J5MXuMneut3LxQPJj/RLUponcb/JRKdfZQYKlhs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Jg4jrwjnQL/2ah0u4C/g1vm3wKACTETkUAWToXwvxzjGavQVQhl+WTxK7/7XOjjUBnsd+e1JmlR28/is/VzQnD1bq//xzyGOBoffUrd44gtKRWELlhNk+Ne8nLEp8P9jwSAlNyrJseQFSstn97cuuPv4x/8whVi6eRDfkz4e6o4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=Xixws/P+; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from chenste-Virtual-Machine.mshome.net (unknown [50.168.180.218])
	by linux.microsoft.com (Postfix) with ESMTPSA id 57D7C21260F3;
	Mon,  5 Jan 2026 18:07:23 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 57D7C21260F3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1767665244;
	bh=yWletEREOJw5mTRt5nZsCm5HLIu3eUuKfdetxO9j5xc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Xixws/P+pV6QQNXTo51A8cG8toiZ7y9S0u0MKPLS6lLhWB1GY4+nurgqlDLLvmlLy
	 ITyLdU8mMuWyQoxjGrX67IoFlK2TONvshBZJ0+4P7gCL3TRL5lfRPGEgJnKyoGyHEC
	 ld3KV2l82EXPxlfltlxRYJkS6QX9H2s7CkAoyx6c=
From: steven chen <chenste@linux.microsoft.com>
To: linux-integrity@vger.kernel.org
Cc: zohar@linux.ibm.com,
	roberto.sassu@huawei.com,
	dmitry.kasatkin@gmail.com,
	eric.snowberg@oracle.com,
	corbet@lwn.net,
	serge@hallyn.com,
	paul@paul-moore.com,
	jmorris@namei.org,
	linux-security-module@vger.kernel.org,
	anirudhve@linux.microsoft.com,
	chenste@linux.microsoft.com,
	gregorylumen@linux.microsoft.com,
	nramas@linux.microsoft.com,
	sushring@linux.microsoft.com,
	linux-doc@vger.kernel.org
Subject: [PATCH v3 1/3] ima: make ima event log trimming configurable
Date: Mon,  5 Jan 2026 18:07:10 -0800
Message-ID: <20260106020713.3994-2-chenste@linux.microsoft.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260106020713.3994-1-chenste@linux.microsoft.com>
References: <20260106020713.3994-1-chenste@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Make ima event log trimming function configurable.

Signed-off-by: steven chen <chenste@linux.microsoft.com>
---
 security/integrity/ima/Kconfig | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/security/integrity/ima/Kconfig b/security/integrity/ima/Kconfig
index 976e75f9b9ba..322964ae4772 100644
--- a/security/integrity/ima/Kconfig
+++ b/security/integrity/ima/Kconfig
@@ -332,4 +332,16 @@ config IMA_KEXEC_EXTRA_MEMORY_KB
 	  If set to the default value of 0, an extra half page of memory for those
 	  additional measurements will be allocated.
 
+config IMA_LOG_TRIMMING
+	bool "IMA Event Log Trimming"
+	default n
+	help
+	  Say Y here if you want support for IMA Event Log Trimming.
+		This creates the file /sys/kernel/security/integrity/ima/ima_trim_log.
+		Userspace
+		  - writes to this file to trigger IMA event log trimming
+		  - reads this file to get number of entried trimming last time
+
+	  If unsure, say N.
+
 endif
-- 
2.43.0


