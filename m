Return-Path: <linux-integrity+bounces-3529-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B2E0D975266
	for <lists+linux-integrity@lfdr.de>; Wed, 11 Sep 2024 14:33:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 75624281CF1
	for <lists+linux-integrity@lfdr.de>; Wed, 11 Sep 2024 12:33:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95602193073;
	Wed, 11 Sep 2024 12:30:40 +0000 (UTC)
X-Original-To: linux-integrity@vger.kernel.org
Received: from frasgout11.his.huawei.com (frasgout11.his.huawei.com [14.137.139.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EE6D191F82;
	Wed, 11 Sep 2024 12:30:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=14.137.139.23
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726057840; cv=none; b=rfCvPZgit64gBgFe4vmsjZPCUbLxZyTH5ejVuuYoRMKJQBuh8oz+VWpZuD0Sf+ebx6iUw48lWriHba9j2veShinfqILWUArWrTG3CpMGmeSKPnDFUvVFnHdXiGpZkjm+4d+9OgSKITA5hvs+qol4veRY8rUaqYxn2hE1omk47po=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726057840; c=relaxed/simple;
	bh=QSWW0uOl6XHXEqmztTA7fQh5BzSULZPfrrSVF/tNx+8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=UdK+XjpgWK58sfAz5zqExczWidFoa/V6mLSkpWpfM2tIue+4uyv4OLv5ISVz9WwI22al5ZtuoS2b8OKs6ZACzb24Qxmz2NG+9dgaHuwre27uCN/fvxlR8xEztO7ujD47FegPrydODSg+3EaXInq9u+Yh7f7kO4IOe4URzzCBDOM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=14.137.139.23
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.18.186.29])
	by frasgout11.his.huawei.com (SkyGuard) with ESMTP id 4X3fYQ5Yxzz9v7Hk;
	Wed, 11 Sep 2024 20:11:06 +0800 (CST)
Received: from mail02.huawei.com (unknown [7.182.16.27])
	by mail.maildlp.com (Postfix) with ESMTP id 5403814093A;
	Wed, 11 Sep 2024 20:30:27 +0800 (CST)
Received: from huaweicloud.com (unknown [10.204.63.22])
	by APP2 (Coremail) with SMTP id GxC2BwD3pscjjeFmDBG3AA--.60453S11;
	Wed, 11 Sep 2024 13:30:26 +0100 (CET)
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
	torvalds@linux-foundation.org,
	Roberto Sassu <roberto.sassu@huawei.com>
Subject: [PATCH v3 09/14] KEYS: Retry asym key search with partial ID in restrict_link_by_signature()
Date: Wed, 11 Sep 2024 14:29:06 +0200
Message-Id: <20240911122911.1381864-10-roberto.sassu@huaweicloud.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240911122911.1381864-1-roberto.sassu@huaweicloud.com>
References: <20240911122911.1381864-1-roberto.sassu@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:GxC2BwD3pscjjeFmDBG3AA--.60453S11
X-Coremail-Antispam: 1UD129KBjvJXoW7tF13Xr4kZryxWF1xWFyfJFb_yoW8GrW5pa
	y8CryFgry8K347Cay5Aw47W3yfCFs5Ar1fGrs3GwnxC3s0qFs8trWIvF47ury5Cr4IvryS
	vrWjgr1Ykw4UAF7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUPlb4IE77IF4wAFF20E14v26rWj6s0DM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28IrcIa0xkI8VA2jI8067AKxVWUAV
	Cq3wA2048vs2IY020Ec7CjxVAFwI0_Xr0E3s1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0
	rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVWUCVW8JwA2z4x0Y4vE2Ix0cI8IcVCY1x0267
	AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVAFwI0_Gr0_Cr1l84ACjcxK6I8E87Iv6xkF7I0E
	14v26r4UJVWxJr1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrV
	C2j2WlYx0E2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE
	7xkEbVWUJVW8JwACjcxG0xvY0x0EwIxGrwACI402YVCY1x02628vn2kIc2xKxwCY1x0262
	kKe7AKxVWUtVW8ZwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s02
	6c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw
	0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUCVW8JwCI42IY6xIIjxv20xvE
	c7CjxVAFwI0_Gr1j6F4UJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aV
	AFwI0_Gr0_Cr1lIxAIcVC2z280aVCY1x0267AKxVW8Jr0_Cr1UYxBIdaVFxhVjvjDU0xZF
	pf9x07UZTmfUUUUU=
X-CM-SenderInfo: purev21wro2thvvxqx5xdzvxpfor3voofrz/1tbiAgADBGbg-PsHuwABs5

From: Roberto Sassu <roberto.sassu@huawei.com>

Retry asymmetric key search in restrict_link_by_signature() to support the
case of partial IDs, provided by PGP signatures (only the last 8 bytes).

Although RFC 9580 supports the signature subpacket type 33, which contains
the full issuer fingerprint, we cannot rely on existing signatures to
support it.

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


