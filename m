Return-Path: <linux-integrity+bounces-8982-lists+linux-integrity=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-integrity@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2DItBK6Jsml4NQAAu9opvQ
	(envelope-from <linux-integrity+bounces-8982-lists+linux-integrity=lfdr.de@vger.kernel.org>)
	for <lists+linux-integrity@lfdr.de>; Thu, 12 Mar 2026 10:38:54 +0100
X-Original-To: lists+linux-integrity@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 10B1026FB3B
	for <lists+linux-integrity@lfdr.de>; Thu, 12 Mar 2026 10:38:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 96FCC301A698
	for <lists+linux-integrity@lfdr.de>; Thu, 12 Mar 2026 09:38:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4645A3B4EB5;
	Thu, 12 Mar 2026 09:38:33 +0000 (UTC)
X-Original-To: linux-integrity@vger.kernel.org
Received: from mail.avm.de (mail.avm.de [212.42.244.120])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C9F23B9DBD;
	Thu, 12 Mar 2026 09:38:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.42.244.120
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773308313; cv=none; b=K1ZdumkOOLMSpk52ZaEKzYtxumFSjLpud/MgXz4A2ss8tCJpu4KnobqbXNKNeNqDmL4wN1Z00N0yFOSgj0FsbQoMMZta2qdLh0aSE0txXJC0Wd94wU5N7diMON9gdy3WEL+k1FnCto+SURgi2mz9UIeUPyJ4BZVktiS3iuXDQfI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773308313; c=relaxed/simple;
	bh=k6Cc1C8dyUH0st8JHqXMGzxC1H+AbW3PQfBuhV55l3U=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=FjD7ZWkVe1tN7LIfKZ/OP4oiZZU4RY9KpheSVIjTZJboIWw7nXCpum/APgy1stI57FONspW/qCj0YHCNsv+vWoHGxL7KPyOTpvFl2HOhP4GY4Qd8Hwnzggd9KW+7rTdyZoTRcSOAr4x145Z9bwVlxpjbWwJNXurIra/dln61f8w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=avm.de; spf=pass smtp.mailfrom=avm.de; arc=none smtp.client-ip=212.42.244.120
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=avm.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=avm.de
Received: from [212.42.244.71] (helo=mail.avm.de)
	by mail.avm.de with ESMTP (eXpurgate 4.55.2)
	(envelope-from <phahn-oss@avm.de>)
	id 69b2898b-b734-7f0000032729-7f0000019a5c-1
	for <multiple-recipients>; Thu, 12 Mar 2026 10:38:19 +0100
Received: from mail-auth.avm.de (dovecot-mx-01.avm.de [212.42.244.71])
	by mail.avm.de (Postfix) with ESMTPS;
	Thu, 12 Mar 2026 10:38:19 +0100 (CET)
From: Philipp Hahn <phahn-oss@avm.de>
To: Mimi Zohar <zohar@linux.ibm.com>,
	Roberto Sassu <roberto.sassu@huawei.com>,
	Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
	Eric Snowberg <eric.snowberg@oracle.com>
Cc: Philipp Hahn <phahn-oss@avm.de>,
	linux-integrity@vger.kernel.org,
	linux-security-module@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] integrity: Fix spelling mistake TRUSTED_KEYRING
Date: Thu, 12 Mar 2026 10:35:58 +0100
Message-ID: <b4b205be8e2bd845c834ddb17517ca9e02d5820d.1773308088.git.phahn-oss@avm.de>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: FRITZ! Technology GmbH, Berlin, Germany
Content-Transfer-Encoding: 8bit
X-purgate-ID: 149429::1773308299-02DC0A3D-DACBDE97/0/0
X-purgate-type: clean
X-purgate-size: 886
X-purgate-Ad: Categorized by eleven eXpurgate (R) https://www.eleven.de
X-purgate: This mail is considered clean (visit https://www.eleven.de for further information)
X-purgate: clean
X-Spamd-Result: default: False [3.04 / 15.00];
	DMARC_POLICY_QUARANTINE(1.50)[avm.de : SPF not aligned (relaxed), No valid DKIM,quarantine];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-8982-lists,linux-integrity=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[linux.ibm.com,huawei.com,gmail.com,oracle.com];
	HAS_ORG_HEADER(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[phahn-oss@avm.de,linux-integrity@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	MISSING_XM_UA(0.00)[];
	R_DKIM_NA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_SEVEN(0.00)[8];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_RCPT(0.00)[linux-integrity];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,avm.de:email,avm.de:mid]
X-Rspamd-Queue-Id: 10B1026FB3B
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Fix minor spelling mistake "kerne{d -> l}".

Fixes: 9dc92c45177ab ("integrity: Define a trusted platform keyring")
Signed-off-by: Philipp Hahn <phahn-oss@avm.de>
---
 security/integrity/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/security/integrity/Kconfig b/security/integrity/Kconfig
index 916d4f2bfc441..328ea9f32035a 100644
--- a/security/integrity/Kconfig
+++ b/security/integrity/Kconfig
@@ -60,7 +60,7 @@ config INTEGRITY_PLATFORM_KEYRING
 	help
 	  Provide a separate, distinct keyring for platform trusted keys, which
 	  the kernel automatically populates during initialization from values
-	  provided by the platform for verifying the kexec'ed kerned image
+	  provided by the platform for verifying the kexec'ed kernel image
 	  and, possibly, the initramfs signature.
 
 config INTEGRITY_MACHINE_KEYRING
-- 
2.43.0


