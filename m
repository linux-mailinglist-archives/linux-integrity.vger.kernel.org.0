Return-Path: <linux-integrity+bounces-8291-lists+linux-integrity=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-integrity@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +HikIX/gcWk+MgAAu9opvQ
	(envelope-from <linux-integrity+bounces-8291-lists+linux-integrity=lfdr.de@vger.kernel.org>)
	for <lists+linux-integrity@lfdr.de>; Thu, 22 Jan 2026 09:31:59 +0100
X-Original-To: lists+linux-integrity@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id D4E04631BB
	for <lists+linux-integrity@lfdr.de>; Thu, 22 Jan 2026 09:31:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 3A7827C340A
	for <lists+linux-integrity@lfdr.de>; Thu, 22 Jan 2026 08:26:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFEA435CB90;
	Thu, 22 Jan 2026 08:24:22 +0000 (UTC)
X-Original-To: linux-integrity@vger.kernel.org
Received: from frasgout11.his.huawei.com (frasgout11.his.huawei.com [14.137.139.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4ADA32E0413;
	Thu, 22 Jan 2026 08:24:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=14.137.139.23
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769070262; cv=none; b=u0oqaIaFPoqCsUdNeSwiFtac8wR/k8D5uiE33vlPsaZNWheyZlq/zUKcaGo23INe3kJplRZhQcSIzD1QTObZZf8+cO6+LRL3ACctlZSZhdq/s+lAZ/9UNzKyaqXXp4+g5+4FNlWGAni8FT1I98mJ01tsMn4TV8glC1IdTWRxWBA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769070262; c=relaxed/simple;
	bh=OctmKsbB8Gsigmr5VTmRPUYlLVO98zXW8Lq6Wh4hPJQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=i3S/9ucdu7V08auJXNyIo6uGJQsK36dCGXwXJTpj5U2J8GIYt3ojurnh0Yhe00jqJ66eBELg023ruQNvspw+ObBb2iro1ZNTiWIf5rUJyRInv6u7Vb2shTvF9W5rlj2yhY4CEtmhFCMCipZsTN4wIP1J/yivmXrg7XhCuqcKKB8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=14.137.139.23
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.18.224.235])
	by frasgout11.his.huawei.com (SkyGuard) with ESMTPS id 4dxYWt0GqQz1HBLc;
	Thu, 22 Jan 2026 16:05:14 +0800 (CST)
Received: from mail02.huawei.com (unknown [7.182.16.47])
	by mail.maildlp.com (Postfix) with ESMTP id 1AB614056C;
	Thu, 22 Jan 2026 16:07:42 +0800 (CST)
Received: from huaweicloud.com (unknown [10.204.63.22])
	by APP1 (Coremail) with SMTP id LxC2BwC38gTF2nFpYGxqAg--.21556S2;
	Thu, 22 Jan 2026 09:07:41 +0100 (CET)
From: Roberto Sassu <roberto.sassu@huaweicloud.com>
To: zohar@linux.ibm.com,
	dmitry.kasatkin@gmail.com,
	eric.snowberg@oracle.com,
	paul@paul-moore.com,
	jmorris@namei.org,
	serge@hallyn.com
Cc: linux-integrity@vger.kernel.org,
	linux-security-module@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Roberto Sassu <roberto.sassu@huawei.com>
Subject: [PATCH] evm: Use ordered xattrs list to calculate HMAC in evm_init_hmac()
Date: Thu, 22 Jan 2026 09:07:17 +0100
Message-ID: <20260122080717.1772063-1-roberto.sassu@huaweicloud.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:LxC2BwC38gTF2nFpYGxqAg--.21556S2
X-Coremail-Antispam: 1UD129KBjvJXoW7tw4fAFy5Zr4kJw43ArWxXrb_yoW8KF15pF
	W5Kay7Jrn5JF48GFZ3ta18u34a9rW8Cr4Ygr1kAr10yFn8Cr1IvryxAr1ruF98XrWkArn5
	tw4jvw15Zwn0q3DanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUv0b4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Jr0_JF4l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Jr0_Gr1l84ACjcxK6I8E87Iv67AKxVWUJVW8JwA2z4x0Y4vEx4A2jsIEc7CjxV
	AFwI0_Jr0_Gr1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2
	j2WlYx0E2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7x
	kEbVWUJVW8JwACjcxG0xvY0x0EwIxGrwACI402YVCY1x02628vn2kIc2xKxwCY1x0262kK
	e7AKxVWUtVW8ZwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c
	02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_
	GFylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7
	CjxVAFwI0_Jr0_Gr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v2
	6r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Jr0_GrUvcSsGvfC2KfnxnUUI43ZEXa7IU1
	7KsUUUUUU==
X-CM-SenderInfo: purev21wro2thvvxqx5xdzvxpfor3voofrz/1tbiAQABBGlxl5gKPgAAsn
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.74 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	TAGGED_FROM(0.00)[bounces-8291-lists,linux-integrity=lfdr.de];
	DMARC_NA(0.00)[huaweicloud.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[linux.ibm.com,gmail.com,oracle.com,paul-moore.com,namei.org,hallyn.com];
	MIME_TRACE(0.00)[0:+];
	FROM_NEQ_ENVFROM(0.00)[roberto.sassu@huaweicloud.com,linux-integrity@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:7979, ipnet:142.0.200.0/24, country:US];
	R_DKIM_NA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	TO_DN_SOME(0.00)[];
	TAGGED_RCPT(0.00)[linux-integrity];
	DBL_BLOCKED_OPENRESOLVER(0.00)[huaweicloud.com:mid,huawei.com:email,dfw.mirrors.kernel.org:helo,dfw.mirrors.kernel.org:rdns]
X-Rspamd-Queue-Id: D4E04631BB
X-Rspamd-Action: no action

From: Roberto Sassu <roberto.sassu@huawei.com>

Commit 8e5d9f916a96 ("smack: deduplicate xattr setting in
smack_inode_init_security()") introduced xattr_dupval() to simplify setting
the xattrs to be provided by the SMACK LSM on inode creation, in the
smack_inode_init_security().

Unfortunately, moving lsm_get_xattr_slot() caused the SMACK64TRANSMUTE
xattr be added in the array of new xattrs before SMACK64. This causes the
HMAC of xattrs calculated by evm_init_hmac() for new files to diverge from
the one calculated by both evm_calc_hmac_or_hash() and evmctl.

evm_init_hmac() calculates the HMAC of the xattrs of new files based on the
order LSMs provide them, while evm_calc_hmac_or_hash() and evmctl calculate
the HMAC based on an ordered xattrs list.

Fix the issue by making evm_init_hmac() calculate the HMAC of new files
based on the ordered xattrs list too.

Fixes: 8e5d9f916a96 ("smack: deduplicate xattr setting in smack_inode_init_security()")
Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>
---
 security/integrity/evm/evm_crypto.c | 14 ++++++++++----
 1 file changed, 10 insertions(+), 4 deletions(-)

diff --git a/security/integrity/evm/evm_crypto.c b/security/integrity/evm/evm_crypto.c
index a5e730ffda57..5a8cef45bacf 100644
--- a/security/integrity/evm/evm_crypto.c
+++ b/security/integrity/evm/evm_crypto.c
@@ -401,6 +401,7 @@ int evm_init_hmac(struct inode *inode, const struct xattr *xattrs,
 {
 	struct shash_desc *desc;
 	const struct xattr *xattr;
+	struct xattr_list *xattr_entry;
 
 	desc = init_desc(EVM_XATTR_HMAC, HASH_ALGO_SHA1);
 	if (IS_ERR(desc)) {
@@ -408,11 +409,16 @@ int evm_init_hmac(struct inode *inode, const struct xattr *xattrs,
 		return PTR_ERR(desc);
 	}
 
-	for (xattr = xattrs; xattr->name; xattr++) {
-		if (!evm_protected_xattr(xattr->name))
-			continue;
+	list_for_each_entry_lockless(xattr_entry, &evm_config_xattrnames,
+				     list) {
+		for (xattr = xattrs; xattr->name; xattr++) {
+			if (strcmp(xattr_entry->name +
+				   XATTR_SECURITY_PREFIX_LEN, xattr->name) != 0)
+				continue;
 
-		crypto_shash_update(desc, xattr->value, xattr->value_len);
+			crypto_shash_update(desc, xattr->value,
+					    xattr->value_len);
+		}
 	}
 
 	hmac_add_misc(desc, inode, EVM_XATTR_HMAC, hmac_val);
-- 
2.43.0


