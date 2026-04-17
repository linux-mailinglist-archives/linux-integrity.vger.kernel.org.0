Return-Path: <linux-integrity+bounces-9215-lists+linux-integrity=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-integrity@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eAAIDIzH4WllyAAAu9opvQ
	(envelope-from <linux-integrity+bounces-9215-lists+linux-integrity=lfdr.de@vger.kernel.org>)
	for <lists+linux-integrity@lfdr.de>; Fri, 17 Apr 2026 07:39:24 +0200
X-Original-To: lists+linux-integrity@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 92C81417241
	for <lists+linux-integrity@lfdr.de>; Fri, 17 Apr 2026 07:39:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id CF8EB31AE3CC
	for <lists+linux-integrity@lfdr.de>; Fri, 17 Apr 2026 05:26:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9CB8C36D513;
	Fri, 17 Apr 2026 05:26:33 +0000 (UTC)
X-Original-To: linux-integrity@vger.kernel.org
Received: from cstnet.cn (smtp81.cstnet.cn [159.226.251.81])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 625FF36CDEF;
	Fri, 17 Apr 2026 05:26:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776403593; cv=none; b=Kh8Sqvkpfj5wIDRzOoXi9pJtEEdYjPKgG0WifXiFggKglj6c8qL0QaOaj82+N5vAU1GxI8m5zvw7NZ7Mt5KRuJz8YXTFs9LwRungX709E8FajmbXOhK/8PH4NGzjcMMhdWvMs9BivY2MbQts/xRrjT6SQhAMLY8nMLs9uRfFT0c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776403593; c=relaxed/simple;
	bh=xG508dr5BJFMsH4r4rWRLUThGgCTgTt4gAPmAf7gydg=;
	h=From:Date:Message-ID:To:Cc:In-Reply-To:References:Subject; b=UeclxMW+wm3W6XRhMk2c1lo7///KJolkHKlIjkvbw85kxjwpCinvybX9dL3VDMveTn4bqa0ya81O+jxQ6S0IucUMcxpZKU4M7dZBVPJVP0lsPRUrHAPEQlO4o+ahKyq1xSHjko5zX0ePsan0PKArc3TZtANyTakfxu8rD+PjhYw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from 0006-evm-v2.eml (unknown [111.196.245.116])
	by APP-03 (Coremail) with SMTP id rQCowAD3F997xOFpEThZDg--.34327S2;
	Fri, 17 Apr 2026 13:26:19 +0800 (CST)
From: Pengpeng Hou <pengpeng@iscas.ac.cn>
Date: Fri, 17 Apr 2026 20:44:00 +0800
Message-ID: <20260417223004.1-evm-xattrs-v2-pengpeng@iscas.ac.cn>
To: Mimi Zohar <zohar@linux.ibm.com>, Roberto Sassu <roberto.sassu@huawei.com>
Cc: Dmitry Kasatkin <dmitry.kasatkin@gmail.com>, Eric Snowberg <eric.snowberg@oracle.com>, Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>, Serge Hallyn <serge@hallyn.com>, linux-integrity@vger.kernel.org, linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org, pengpeng@iscas.ac.cn
In-Reply-To: <20260407153002.2-evm-xattrs-pengpeng@iscas.ac.cn>
References: <20260407153002.2-evm-xattrs-pengpeng@iscas.ac.cn>
Subject: [PATCH v2] evm: terminate and bound the evm_xattrs read buffer
X-CM-TRANSID:rQCowAD3F997xOFpEThZDg--.34327S2
X-Coremail-Antispam: 1UD129KBjvJXoW7KF4DJr1xXFWkZF4fJFWxXrb_yoW8ZFWrpF
	ZxKa4Dtrn5ZrykGrWUJ3W7u3s5G395WF4UGrZ3Gw12yanIqrWSqF95CFyrWr95XrW0yw1a
	q3s09rnI9F15X3DanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUB214x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2jI8I6cxK62vIxIIY0VWUZVW8XwA2ocxC64kIII
	0Yj41l84x0c7CEw4AK67xGY2AK021l84ACjcxK6xIIjxv20xvE14v26ryj6F1UM28EF7xv
	wVC0I7IYx2IY6xkF7I0E14v26F4j6r4UJwA2z4x0Y4vEx4A2jsIE14v26F4UJVW0owA2z4
	x0Y4vEx4A2jsIEc7CjxVAFwI0_GcCE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG
	64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_JF0_Jw1lYx0Ex4A2jsIE14v26r
	4j6F4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvEwIxGrwACjI8F5VA0II8E6IAqYI8I
	648v4I1lFIxGxcIEc7CjxVA2Y2ka0xkIwI1lc7CjxVAaw2AFwI0_Jw0_GFyl42xK82IYc2
	Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s02
	6x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0x
	vE2Ix0cI8IcVAFwI0_JFI_Gr1lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE
	42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVW8JVWxJwCI42IY6I8E87Iv6x
	kF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjTRC9aBDUUUU
X-CM-SenderInfo: pshqw1xhqjqxpvfd2hldfou0/
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
X-Spamd-Result: default: False [5.54 / 15.00];
	DATE_IN_FUTURE(4.00)[7];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-9215-lists,linux-integrity=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	GREYLIST(0.00)[pass,body];
	DMARC_NA(0.00)[iscas.ac.cn];
	FREEMAIL_CC(0.00)[gmail.com,oracle.com,paul-moore.com,namei.org,hallyn.com,vger.kernel.org,iscas.ac.cn];
	RCVD_COUNT_THREE(0.00)[4];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pengpeng@iscas.ac.cn,linux-integrity@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.986];
	RCPT_COUNT_SEVEN(0.00)[11];
	R_DKIM_NA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-integrity];
	DBL_BLOCKED_OPENRESOLVER(0.00)[iscas.ac.cn:mid,iscas.ac.cn:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 92C81417241
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

evm_read_xattrs() allocates size + 1 bytes, fills them from the list of
enabled xattrs, and then passes strlen(temp) to
simple_read_from_buffer(). When no configured xattrs are enabled, the
fill loop stores nothing and temp[0] remains uninitialized, so strlen()
reads beyond initialized memory.

Explicitly terminate the buffer after allocation, use snprintf() for
each formatted line, and pass the accumulated length to
simple_read_from_buffer().

Fixes: fa516b66a1bf ("EVM: Allow runtime modification of the set of verified xattrs")
Signed-off-by: Pengpeng Hou <pengpeng@iscas.ac.cn>
---
Changes since v1:
- add the Fixes tag
- replace sprintf() with snprintf()
- explicitly terminate the buffer instead of switching to kzalloc()

 security/integrity/evm/evm_secfs.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/security/integrity/evm/evm_secfs.c b/security/integrity/evm/evm_secfs.c
index acd840461902..b7882a4ce9d0 100644
--- a/security/integrity/evm/evm_secfs.c
+++ b/security/integrity/evm/evm_secfs.c
@@ -127,8 +127,8 @@ static ssize_t evm_read_xattrs(struct file *filp, char __user *buf,
 			       size_t count, loff_t *ppos)
 {
 	char *temp;
-	int offset = 0;
-	ssize_t rc, size = 0;
+	size_t offset = 0, size = 0;
+	ssize_t rc;
 	struct xattr_list *xattr;
 
 	if (*ppos != 0)
@@ -150,17 +150,18 @@ static ssize_t evm_read_xattrs(struct file *filp, char __user *buf,
 		mutex_unlock(&xattr_list_mutex);
 		return -ENOMEM;
 	}
+	temp[size] = '\0';
 
 	list_for_each_entry(xattr, &evm_config_xattrnames, list) {
 		if (!xattr->enabled)
 			continue;
 
-		sprintf(temp + offset, "%s\n", xattr->name);
-		offset += strlen(xattr->name) + 1;
+		offset += snprintf(temp + offset, size + 1 - offset, "%s\n",
+				   xattr->name);
 	}
 
 	mutex_unlock(&xattr_list_mutex);
-	rc = simple_read_from_buffer(buf, count, ppos, temp, strlen(temp));
+	rc = simple_read_from_buffer(buf, count, ppos, temp, offset);
 
 	kfree(temp);
 
-- 
2.50.1 (Apple Git-155)


