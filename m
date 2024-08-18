Return-Path: <linux-integrity+bounces-3345-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E2D7955DAE
	for <lists+linux-integrity@lfdr.de>; Sun, 18 Aug 2024 19:01:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 51B981C21509
	for <lists+linux-integrity@lfdr.de>; Sun, 18 Aug 2024 17:01:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2089E153801;
	Sun, 18 Aug 2024 17:00:28 +0000 (UTC)
X-Original-To: linux-integrity@vger.kernel.org
Received: from frasgout12.his.huawei.com (frasgout12.his.huawei.com [14.137.139.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FB0A153808;
	Sun, 18 Aug 2024 17:00:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=14.137.139.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724000428; cv=none; b=hLOdsie4luDY5xgt9Dg5k5IuVOxbdcA6DkwGoYpslJ8/oSpwwMrkmwiV00JkdgGlupc0fBOpYqTCz6r+qgXJBse8emUjFmB373iLZBna7enG7jiIhiA0fAQQC2sRzgBNCBOw3ir4fYg6fRLDwRtPM0deSawQoVL5af3m6dfnaJM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724000428; c=relaxed/simple;
	bh=cPhy/a3GqMIBddkPxq8lUP5ZGXsGoXchDekDHW2+9YE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=JUpIRFz7beumw+WOvbrj9BxvvOoxf7tkwZ1YzZ8mZLfia9vdwP8Gl0PX4980sgz8B+lBUrnq1Lc28v4y+Mzm6qrxPctPK8qQUe7kVSYAKRzQmr3Mt7UU7JBseIJWcaQaMptDS0vsPcWFohcN9JRTBHRI0AI7pixtGE1AAvzYyDc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=14.137.139.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.18.186.29])
	by frasgout12.his.huawei.com (SkyGuard) with ESMTP id 4Wn1Z10pKRz9v7Jg;
	Mon, 19 Aug 2024 00:35:53 +0800 (CST)
Received: from mail02.huawei.com (unknown [7.182.16.47])
	by mail.maildlp.com (Postfix) with ESMTP id 3B68A1400E3;
	Mon, 19 Aug 2024 01:00:23 +0800 (CST)
Received: from huaweicloud.com (unknown [10.204.63.22])
	by APP1 (Coremail) with SMTP id LxC2BwAXm4VpKMJm+zZxAQ--.21009S11;
	Sun, 18 Aug 2024 18:00:22 +0100 (CET)
From: Roberto Sassu <roberto.sassu@huaweicloud.com>
To: dhowells@redhat.com,
	dwmw2@infradead.org,
	herbert@gondor.apana.org.au,
	davem@davemloft.net
Cc: linux-kernel@vger.kernel.org,
	keyrings@vger.kernel.org,
	linux-crypto@vger.kernel.org,
	zohar@linux.ibm.com,
	linux-integrity@vger.kernel.org,
	Roberto Sassu <roberto.sassu@huawei.com>
Subject: [PATCH v2 09/14] KEYS: Retry asym key search with partial ID in restrict_link_by_signature()
Date: Sun, 18 Aug 2024 18:57:51 +0200
Message-Id: <20240818165756.629203-10-roberto.sassu@huaweicloud.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240818165756.629203-1-roberto.sassu@huaweicloud.com>
References: <20240818165756.629203-1-roberto.sassu@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:LxC2BwAXm4VpKMJm+zZxAQ--.21009S11
X-Coremail-Antispam: 1UD129KBjvJXoW7tF13Xr4kZryxWF1xWFyfJFb_yoW8GFyxpa
	y8CryFkry8K347Cay5Aw47W3yfCFZ5Zr1fGrs3Gwn8A34qqFs8KrWIvF17Wry5Cr4IvryS
	vrWjgr1Ykw4UAaUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUPvb4IE77IF4wAFF20E14v26rWj6s0DM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28IrcIa0xkI8VA2jI8067AKxVWUAV
	Cq3wA2048vs2IY020Ec7CjxVAFwI0_Xr0E3s1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0
	rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVWUCVW8JwA2z4x0Y4vE2Ix0cI8IcVCY1x0267
	AKxVWxJVW8Jr1l84ACjcxK6I8E87Iv67AKxVW8JVWxJwA2z4x0Y4vEx4A2jsIEc7CjxVAF
	wI0_Gr1j6F4UJwAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I
	80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCj
	c4AY6r1j6r4UM4x0Y48IcxkI7VAKI48JM4IIrI8v6xkF7I0E8cxan2IY04v7MxkF7I0En4
	kS14v26r1q6r43MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E
	5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUtV
	W8ZwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1I6r4UMIIF0xvE2Ix0cI8IcVCY
	1x0267AKxVWxJVW8Jr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14
	v26r4j6F4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr1j6F4UJbIYCTnIWIevJa73UjIFyTuY
	vjxUF9NVUUUUU
X-CM-SenderInfo: purev21wro2thvvxqx5xdzvxpfor3voofrz/1tbiAgATBGbBWPgB7AAAs-

From: Roberto Sassu <roberto.sassu@huawei.com>

Retry asymmetric key search in restrict_link_by_signature() to support the
case of partial IDs, provided by PGP signatures (only the last 8 bytes).

Although recently draft-ietf-openpgp-rfc4880bis-10 supports the signature
subpacket type 33, which contains the full issuer fingerprint, we cannot
rely on existing signatures to support it.

Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>
Signed-off-by: David Howells <dhowells@redhat.com>
---
 crypto/asymmetric_keys/restrict.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/crypto/asymmetric_keys/restrict.c b/crypto/asymmetric_keys/restrict.c
index afcd4d101ac5..dd3d4b3405f7 100644
--- a/crypto/asymmetric_keys/restrict.c
+++ b/crypto/asymmetric_keys/restrict.c
@@ -97,8 +97,14 @@ int restrict_link_by_signature(struct key *dest_keyring,
 	key = find_asymmetric_key(trust_keyring,
 				  sig->auth_ids[0], sig->auth_ids[1],
 				  sig->auth_ids[2], false);
-	if (IS_ERR(key))
-		return -ENOKEY;
+	if (IS_ERR(key)) {
+		/* Retry with a partial ID. */
+		key = find_asymmetric_key(trust_keyring,
+					  sig->auth_ids[0], sig->auth_ids[1],
+					  sig->auth_ids[2], true);
+		if (IS_ERR(key))
+			return -ENOKEY;
+	}
 
 	if (use_builtin_keys && !test_bit(KEY_FLAG_BUILTIN, &key->flags))
 		ret = -ENOKEY;
-- 
2.34.1


