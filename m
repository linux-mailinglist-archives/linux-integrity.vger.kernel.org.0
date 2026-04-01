Return-Path: <linux-integrity+bounces-9115-lists+linux-integrity=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-integrity@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oOWkOeFazWkRcQYAu9opvQ
	(envelope-from <linux-integrity+bounces-9115-lists+linux-integrity=lfdr.de@vger.kernel.org>)
	for <lists+linux-integrity@lfdr.de>; Wed, 01 Apr 2026 19:50:25 +0200
X-Original-To: lists+linux-integrity@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C46937ED32
	for <lists+linux-integrity@lfdr.de>; Wed, 01 Apr 2026 19:50:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 659D43066422
	for <lists+linux-integrity@lfdr.de>; Wed,  1 Apr 2026 17:35:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 400DE47DD6D;
	Wed,  1 Apr 2026 17:35:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="LDto73WR"
X-Original-To: linux-integrity@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4007947DD6A;
	Wed,  1 Apr 2026 17:35:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775064930; cv=none; b=qhiS0CTvoXF51eENjEPeqxPxkYSEVV1zl2wEyPbrMnn2B8X5acZi8RljokS5WyXNfXYJMNtSZUjkWrpNM+OjmwosvRf1w+ZBZWyvMm843gQIaPd3HmFtAvILzminDlfXcOfJ7o6VpvsIupaWJ6tGgnNNIXQx41oi6Mh3xOhzl4A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775064930; c=relaxed/simple;
	bh=uEdAi/q2w/uICb1811cr1u5dW7GRk4kuE/VIl5aKpJw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jsUazWuh5R2ls0X5sSgNFzAU+Bl43JwGqw9iexHdTP1H9eXrEGadWEXmlrEj7UHhVv73n64eXcVZFxby4P+7QY2LNY3ajcCzqBKxO1usVjvWa/aHHwjS8A2S2oq7XOOMYgWEFMPW+1W603EtrTtkssKh2wDViyiJ+poYA2Qe/ro=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=LDto73WR; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from chenste-Virtual-Machine.mshome.net (unknown [131.107.174.223])
	by linux.microsoft.com (Postfix) with ESMTPSA id 71A4E20B712B;
	Wed,  1 Apr 2026 10:35:27 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 71A4E20B712B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1775064927;
	bh=R8W+w2KFxnOkxbLBEaZrTMbaD4VNoL/glA1naoWLZIY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=LDto73WRPO9aqKKXnz3EJIwTQKgbvOmvvGXWEGxox+H2p1UkRatvcqhoB8XywiZHL
	 v2MhjYzePkRB5pZcDLC6Jrd704XXsFgsNNCbUg9sVis9OwT6wRuc6mKRKXsWNFQ0YW
	 DmYyGvMPYqk+OjnZPgwQzd2I3WjG7lu7YGUpITI0=
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
Subject: [PATCH v5 1/3] ima: make ima event log trimming configurable
Date: Wed,  1 Apr 2026 10:29:53 -0700
Message-ID: <20260401172956.4581-2-chenste@linux.microsoft.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260401172956.4581-1-chenste@linux.microsoft.com>
References: <20260401172956.4581-1-chenste@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linux.microsoft.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[linux.microsoft.com:s=default];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[linux.ibm.com,huawei.com,gmail.com,oracle.com,lwn.net,hallyn.com,paul-moore.com,namei.org,vger.kernel.org,linux.microsoft.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-9115-lists,linux-integrity=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[chenste@linux.microsoft.com,linux-integrity@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[linux.microsoft.com:+];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[linux-integrity];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_TWELVE(0.00)[16];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.microsoft.com:dkim,linux.microsoft.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 4C46937ED32
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Make ima event log trimming function configurable.

Suggested-by: Mimi Zohar <zohar@linux.ibm.com>
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


