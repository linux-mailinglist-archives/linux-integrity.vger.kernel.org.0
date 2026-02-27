Return-Path: <linux-integrity+bounces-8672-lists+linux-integrity=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-integrity@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uC2lKaY4oWkbrQQAu9opvQ
	(envelope-from <linux-integrity+bounces-8672-lists+linux-integrity=lfdr.de@vger.kernel.org>)
	for <lists+linux-integrity@lfdr.de>; Fri, 27 Feb 2026 07:24:38 +0100
X-Original-To: lists+linux-integrity@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 220DF1B33A5
	for <lists+linux-integrity@lfdr.de>; Fri, 27 Feb 2026 07:24:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 4BEDC301DD6E
	for <lists+linux-integrity@lfdr.de>; Fri, 27 Feb 2026 06:24:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E221B33B6C3;
	Fri, 27 Feb 2026 06:24:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="DOcxJ88d"
X-Original-To: linux-integrity@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A483368965;
	Fri, 27 Feb 2026 06:24:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.2
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772173475; cv=none; b=jza4kiGArSfYIYDfHBT8SyjajDqXxCFCD0NcwGmUyzHsg3XvL5aRCNwUtPbY+aU9QzDA/dUgr7xtxbfTGvty1o0xV0vJ/5T36ynaRqy27Vo5QxH3HQnim4KIJdPCS9Gf2RV4+GBYVq0pscpxNM4D8eZE8KIs8EhAzpV6qhZSCO8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772173475; c=relaxed/simple;
	bh=qB/q0dvRcyPgB2aoF0iNa02KEJJcdeLWctI0usOtmxA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=OR5OWtkHKtLwrIDTHfv6/IEO2mhBCw//BiAbLbe7TkTDGgwYd2liLRqQQNWlw8LtEoQljvnmod2Ldh0I7b4EEylBOTAOvAskakH5YoJm8y0WxzG4fv0XX3w42LP4AhXqvfK3rpueNlpseRMPd1Dm9/sW/d+dS9Bs//UyLVue8ME=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=DOcxJ88d; arc=none smtp.client-ip=117.135.210.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=yv
	zy/oMN5itcLK9YfRRAQXJRacJLzXRwn6ueq9SDyQw=; b=DOcxJ88dMw2bTx6mAJ
	sYurgfKQAouLLCTAxhdtrJunB+HDf3I2Y2kiOXJnJT38PI2opfVgd9clo/yqTGkf
	h1eZ/KikMQMyP3pvacmSYbG4R0XNRagkRsUdgjD1cbLxJpqMSpUnDqcS6+L10fpf
	SRZbFKLW6xTh7Tqd296KH52IA=
Received: from localhost.localdomain (unknown [])
	by gzga-smtp-mtada-g1-2 (Coremail) with SMTP id _____wCXKwGBOKFp3ZNlNA--.58279S2;
	Fri, 27 Feb 2026 14:24:03 +0800 (CST)
From: Chi Wang <wangchi05@163.com>
To: trivial@kernel.org
Cc: Mimi Zohar <zohar@linux.ibm.com>,
	Roberto Sassu <roberto.sassu@huawei.com>,
	Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
	linux-integrity@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Chi Wang <wangchi@kylinos.cn>
Subject: [PATCH] integrity: digsig: Add blank line after declarations
Date: Fri, 27 Feb 2026 14:23:11 +0800
Message-Id: <20260227062311.140597-1-wangchi05@163.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wCXKwGBOKFp3ZNlNA--.58279S2
X-Coremail-Antispam: 1Uf129KBjvdXoW7XFW7GryUKw4fCF4rGw1xXwb_yoWftwc_Ga
	s5ur4vqry3ZF1Sv3y7uF4fZr9Ygw1v9ryrXFy5Ar1vy3s0yr15Ga48JF1fJr93WFZrKFs8
	CanakFnFkw1DXjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUvcSsGvfC2KfnxnUUI43ZEXa7IU529aDUUUUU==
X-CM-SenderInfo: 5zdqwulklqkqqrwthudrp/xtbC4gPwFGmhOIMX8AAA3R
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[163.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[163.com:s=s110527];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	FREEMAIL_CC(0.00)[linux.ibm.com,huawei.com,gmail.com,vger.kernel.org,kylinos.cn];
	TAGGED_FROM(0.00)[bounces-8672-lists,linux-integrity=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[163.com];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[wangchi05@163.com,linux-integrity@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[163.com:+];
	NEURAL_HAM(-0.00)[-0.995];
	TAGGED_RCPT(0.00)[linux-integrity];
	RCPT_COUNT_SEVEN(0.00)[7];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,kylinos.cn:email]
X-Rspamd-Queue-Id: 220DF1B33A5
X-Rspamd-Action: no action

From: Chi Wang <wangchi@kylinos.cn>

Fixes checkpatch warning:
WARNING: Missing a blank line after declarations
+                       int err = PTR_ERR(keyring[id]);
+                       pr_err("no %s keyring: %d\n", keyring_name[id], err);

Add a blank line after the variable declaration to comply with
the kernel coding style.

Signed-off-by: Chi Wang <wangchi@kylinos.cn>
---
 security/integrity/digsig.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/security/integrity/digsig.c b/security/integrity/digsig.c
index aec350abad86..5e7ba7d3cf99 100644
--- a/security/integrity/digsig.c
+++ b/security/integrity/digsig.c
@@ -49,6 +49,7 @@ static struct key *integrity_keyring_from_id(const unsigned int id)
 			request_key(&key_type_keyring, keyring_name[id], NULL);
 		if (IS_ERR(keyring[id])) {
 			int err = PTR_ERR(keyring[id]);
+
 			pr_err("no %s keyring: %d\n", keyring_name[id], err);
 			keyring[id] = NULL;
 			return ERR_PTR(err);
-- 
2.25.1


