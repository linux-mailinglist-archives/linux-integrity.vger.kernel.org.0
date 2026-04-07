Return-Path: <linux-integrity+bounces-9134-lists+linux-integrity=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-integrity@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IK5OGluh1GlEwAcAu9opvQ
	(envelope-from <linux-integrity+bounces-9134-lists+linux-integrity=lfdr.de@vger.kernel.org>)
	for <lists+linux-integrity@lfdr.de>; Tue, 07 Apr 2026 08:16:59 +0200
X-Original-To: lists+linux-integrity@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 713613AA2D5
	for <lists+linux-integrity@lfdr.de>; Tue, 07 Apr 2026 08:16:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 52892301259E
	for <lists+linux-integrity@lfdr.de>; Tue,  7 Apr 2026 06:16:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B424381AEA;
	Tue,  7 Apr 2026 06:16:20 +0000 (UTC)
X-Original-To: linux-integrity@vger.kernel.org
Received: from cstnet.cn (smtp21.cstnet.cn [159.226.251.21])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9011137FF4D;
	Tue,  7 Apr 2026 06:16:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775542580; cv=none; b=a8USMzpNtL/hFmgO7R/y3kh+NZQ+qOzyJURkXKTZ0kvNjpv0khI1sxIZGWWobcs4XllWJ9KsYMkRwXWj+RtL/3bd+27e+wLj6QVKzN7rTs3WDeN72eFUoJvIuDxZkLsRv2FgJ6Xj/u523aGS1rvuV/+1ejqneClIPBW7HacL9ZI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775542580; c=relaxed/simple;
	bh=8ul8Wz+M2WkJ8EA74fRJVMF98hUrlwwyE/zmR0ezHEY=;
	h=From:Date:Message-ID:To:Cc:Subject; b=jB0mJshaF7kACubHXSHRY9dnG7otzYoiOmFVufqJ74w9kcCIuAmO9XSEe7O3Tp0v/XhYB3cVeOK3x30+iCad7qLWbO2j7k7G5Jvgz2noZnH5BxcYOlZWxHBdHxof7sFz6HmwmwsjqVfWs93m8BvtFt1g/D0bJq3wumRl+HIdnbI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from 0001-evm.eml (unknown [111.196.245.197])
	by APP-01 (Coremail) with SMTP id qwCowACHMGwkodRpteh7DA--.38939S2;
	Tue, 07 Apr 2026 14:16:04 +0800 (CST)
From: Pengpeng Hou <pengpeng@iscas.ac.cn>
Date: Tue, 7 Apr 2026 14:09:10 +0800
Message-ID: <20260407153002.2-evm-xattrs-pengpeng@iscas.ac.cn>
To: Mimi Zohar <zohar@linux.ibm.com>, Roberto Sassu <roberto.sassu@huawei.com>
Cc: Dmitry Kasatkin <dmitry.kasatkin@gmail.com>, Eric Snowberg <eric.snowberg@oracle.com>, Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>, Serge Hallyn <serge@hallyn.com>, linux-integrity@vger.kernel.org, linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org, pengpeng@iscas.ac.cn
Subject: [PATCH] evm: zero-initialize the evm_xattrs read buffer
X-CM-TRANSID:qwCowACHMGwkodRpteh7DA--.38939S2
X-Coremail-Antispam: 1UD129KBjvdXoWruryUtw17Jr1Dur13Zr43Wrg_yoWDtrb_Ca
	4qvw4DAw4rXws7X347ArWSvry0gr97ur1kGa47twnxua43WF45J397urn3XrWDWrs7Kryq
	vwnrtr9xt3sY9jkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUbVkFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k26cxKx2IYs7xG
	6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8w
	A2z4x0Y4vE2Ix0cI8IcVAFwI0_Xr0_Ar1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Cr0_
	Gr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E14v26rxl6s
	0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xII
	jxv20xvE14v26r106r15McIj6I8E87Iv67AKxVW8JVWxJwAm72CE4IkC6x0Yz7v_Jr0_Gr
	1lF7xvr2IY64vIr41lF7I21c0EjII2zVCS5cI20VAGYxC7M4IIrI8v6xkF7I0E8cxan2IY
	04v7MxkF7I0En4kS14v26r1q6r43MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r
	1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CE
	b7AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0x
	vE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAI
	cVC2z280aVAFwI0_Gr0_Cr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2Kf
	nxnUUI43ZEXa7VUbHa0JUUUUU==
X-CM-SenderInfo: pshqw1xhqjqxpvfd2hldfou0/
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
X-Spamd-Result: default: False [1.54 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[gmail.com,oracle.com,paul-moore.com,namei.org,hallyn.com,vger.kernel.org,iscas.ac.cn];
	TAGGED_FROM(0.00)[bounces-9134-lists,linux-integrity=lfdr.de];
	DMARC_NA(0.00)[iscas.ac.cn];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pengpeng@iscas.ac.cn,linux-integrity@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	NEURAL_SPAM(0.00)[0.213];
	R_DKIM_NA(0.00)[];
	TAGGED_RCPT(0.00)[linux-integrity];
	RCPT_COUNT_SEVEN(0.00)[11];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[iscas.ac.cn:email,iscas.ac.cn:mid,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 713613AA2D5
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

evm_read_xattrs() allocates size + 1 bytes, fills them from the list of
enabled xattrs and then passes strlen(temp) to simple_read_from_buffer().
When no configured xattrs are enabled, the fill loop stores nothing and
temp[0] remains uninitialized, so strlen() reads beyond initialized
memory.

Use kzalloc() so the empty-list case stays a valid empty C string.

Signed-off-by: Pengpeng Hou <pengpeng@iscas.ac.cn>
---
 security/integrity/evm/evm_secfs.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/security/integrity/evm/evm_secfs.c b/security/integrity/evm/evm_secfs.c
index acd840461902..03d376fa36c2 100644
--- a/security/integrity/evm/evm_secfs.c
+++ b/security/integrity/evm/evm_secfs.c
@@ -145,7 +145,7 @@ static ssize_t evm_read_xattrs(struct file *filp, char __user *buf,
 		size += strlen(xattr->name) + 1;
 	}
 
-	temp = kmalloc(size + 1, GFP_KERNEL);
+	temp = kzalloc(size + 1, GFP_KERNEL);
 	if (!temp) {
 		mutex_unlock(&xattr_list_mutex);
 		return -ENOMEM;
-- 
2.50.1 (Apple Git-155)



