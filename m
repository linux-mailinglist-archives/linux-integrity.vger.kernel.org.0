Return-Path: <linux-integrity+bounces-9312-lists+linux-integrity=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-integrity@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id APJZIgGi6mlF1gIAu9opvQ
	(envelope-from <linux-integrity+bounces-9312-lists+linux-integrity=lfdr.de@vger.kernel.org>)
	for <lists+linux-integrity@lfdr.de>; Fri, 24 Apr 2026 00:49:37 +0200
X-Original-To: lists+linux-integrity@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1224C4583B9
	for <lists+linux-integrity@lfdr.de>; Fri, 24 Apr 2026 00:49:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 1FEDB301104E
	for <lists+linux-integrity@lfdr.de>; Thu, 23 Apr 2026 22:49:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88773372698;
	Thu, 23 Apr 2026 22:49:25 +0000 (UTC)
X-Original-To: linux-integrity@vger.kernel.org
Received: from cstnet.cn (smtp25.cstnet.cn [159.226.251.25])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62FB42EC086;
	Thu, 23 Apr 2026 22:49:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776984565; cv=none; b=O2QMqiPzSqxQS8irmvLjAdsnKKrsYOkxa3/nw9vKIKhXZQ1K6pbW61+mOkuJ4s7qWNRmFTDrf9ySkYUNLtjOxeH97Epo/hZ+4bSpmjB0ceobaOIrBKyWNnHxWKpkLNmrw5YjJEJzqIt0GWLoXPCyDnlNvDpZXSG5FPEOw+u9fv4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776984565; c=relaxed/simple;
	bh=rqBQwjO2RiGFR5atuWXVqj5XDse3eXh6V+nTA0MaS/s=;
	h=From:Date:Message-ID:To:Cc:Subject:In-Reply-To:References; b=RrG4sMjd2sYoyhPib5AxyZrl1XuY9tweylAnKyfkKF4y0aATbtJWWXkmJFzxZV15Q2wC1h5eJuLxkm7KPukjx5NtNBMG0EgW6P4PQw9hjQHPJwpHef7vOvBviNvYXumGInA52mLTIr8ZyON1MMGOscPHxmw/ztFvzDoal6peiXA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from 01-evm-v3.eml (unknown [111.196.245.116])
	by APP-05 (Coremail) with SMTP id zQCowAAHlQgjoOppI2psDg--.55726S2;
	Fri, 24 Apr 2026 06:41:40 +0800 (CST)
From: Pengpeng Hou <pengpeng@iscas.ac.cn>
Date: Thu, 23 Apr 2026 23:30:00 +0800
Message-ID: <20260424070101.1-evm-v3-pengpeng@iscas.ac.cn>
To: Mimi Zohar <zohar@linux.ibm.com>, Roberto Sassu <roberto.sassu@huaweicloud.com>
Cc: Roberto Sassu <roberto.sassu@huawei.com>, Dmitry Kasatkin <dmitry.kasatkin@gmail.com>, Eric Snowberg <eric.snowberg@oracle.com>, Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>, Serge Hallyn <serge@hallyn.com>, linux-integrity@vger.kernel.org, linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org, pengpeng@iscas.ac.cn
Subject: [PATCH v3] evm: terminate and bound the evm_xattrs read buffer
In-Reply-To: <20260417223004.1-evm-xattrs-v2-pengpeng@iscas.ac.cn>
References: <20260417223004.1-evm-xattrs-v2-pengpeng@iscas.ac.cn>
X-CM-TRANSID:zQCowAAHlQgjoOppI2psDg--.55726S2
X-Coremail-Antispam: 1UD129KBjvJXoW7KF4DJr1xXFWkZF4fJFWxXrb_yoW8uF4kpF
	sxtasrtw1kXrykGrWUJF47u3s5G3ykGFyUGws3Gw129a9xXrySqFyvka4Y9F95XrW0yw4a
	q3s0kwnIkF15X3DanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUBY14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2jI8I6cxK6x804I0_JFv_Gryl8cAvFVAK0II2c7
	xJM28CjxkF64kEwVA0rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVW8JVW5JwA2z4x0Y4vE
	2Ix0cI8IcVCY1x0267AKxVW8JVWxJwA2z4x0Y4vEx4A2jsIE14v26F4UJVW0owA2z4x0Y4
	vEx4A2jsIEc7CjxVAFwI0_Cr1j6rxdM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVAC
	Y4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJV
	W8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lF7I21c0EjII2zVCS5cI20VAG
	YxC7M4IIrI8v6xkF7I0E8cxan2IY04v7MxkF7I0En4kS14v26r1q6r43MxAIw28IcxkI7V
	AKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCj
	r7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY6x
	IIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwCI42IY6xAI
	w20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x
	0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7VUbGQ6JUUUUU==
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-9312-lists,linux-integrity=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[12];
	RCVD_TLS_LAST(0.00)[];
	DMARC_NA(0.00)[iscas.ac.cn];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[huawei.com,gmail.com,oracle.com,paul-moore.com,namei.org,hallyn.com,vger.kernel.org,iscas.ac.cn];
	RCVD_COUNT_THREE(0.00)[4];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pengpeng@iscas.ac.cn,linux-integrity@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[linux-integrity];
	R_DKIM_NA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,iscas.ac.cn:mid,iscas.ac.cn:email]
X-Rspamd-Queue-Id: 1224C4583B9
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

evm_read_xattrs() allocates size + 1 bytes, fills them from the list of
enabled xattrs, and then passes strlen(temp) to
simple_read_from_buffer(). When no configured xattrs are enabled, the
fill loop stores nothing and temp[0] remains uninitialized, so strlen()
reads beyond initialized memory.

Explicitly terminate the buffer after allocation, use snprintf() for
each formatted line, and pass the accumulated length, without risk of
truncation, to simple_read_from_buffer().

Fixes: fa516b66a1bf ("EVM: Allow runtime modification of the set of verified xattrs")
Signed-off-by: Pengpeng Hou <pengpeng@iscas.ac.cn>
---
Changes since v2:
- adjust the changelog wording to mention why the accumulated length is
  safe
- add the blank line after the allocation error path
- add a comment explaining why snprintf() cannot truncate in the fill loop

diff --git a/security/integrity/evm/evm_secfs.c b/security/integrity/evm/evm_secfs.c
index acd840461902..4baf5e23bc97 100644
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
@@ -151,16 +151,22 @@ static ssize_t evm_read_xattrs(struct file *filp, char __user *buf,
 		return -ENOMEM;
 	}
 
+	temp[size] = '\0';
+
+	/*
+	 * No truncation possible: size is computed over the same enabled
+	 * xattrs under xattr_list_mutex, so offset never exceeds size.
+	 */
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


