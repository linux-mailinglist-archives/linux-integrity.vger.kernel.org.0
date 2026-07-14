Return-Path: <linux-integrity+bounces-9935-lists+linux-integrity=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-integrity@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id gFwnHfn/VWrCxgAAu9opvQ
	(envelope-from <linux-integrity+bounces-9935-lists+linux-integrity=lfdr.de@vger.kernel.org>)
	for <lists+linux-integrity@lfdr.de>; Tue, 14 Jul 2026 11:23:05 +0200
X-Original-To: lists+linux-integrity@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D2BB752CD2
	for <lists+linux-integrity@lfdr.de>; Tue, 14 Jul 2026 11:23:04 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=huawei.com header.s=dkim header.b=sVLUpkPD;
	spf=pass (mail.lfdr.de: domain of "linux-integrity+bounces-9935-lists+linux-integrity=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="linux-integrity+bounces-9935-lists+linux-integrity=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=huawei.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B6F873039385
	for <lists+linux-integrity@lfdr.de>; Tue, 14 Jul 2026 09:19:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 490F043D4FB;
	Tue, 14 Jul 2026 09:19:26 +0000 (UTC)
X-Original-To: linux-integrity@vger.kernel.org
Received: from canpmsgout05.his.huawei.com (canpmsgout05.his.huawei.com [113.46.200.220])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3EEC353A93;
	Tue, 14 Jul 2026 09:19:21 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784020766; cv=none; b=ITYeiZQtdCoTcCZKcdUdwlnFWMEjrJePFAvGEvaxBO6btoNn6m3swVaeDyK4v9n8XxOpSpYjfEoX1VW646+fU9pC9AC7pwPE7Hux11L30n/BWu0z5ZWlgP7ok6LGKYqUq630Kxsdw/NoFNUP5kelc6i1uUq3qPo7rTOCvsmH2RE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784020766; c=relaxed/simple;
	bh=PoZsny19t3HXLnadhIjAqcOpnMVaTXtp8camwODkiVI=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=FnbSuL04JdFddaQQJ6q2CfigguJbNGqZ7wNr/DYu0RQsoK1pxQmV2j/KkAKrOVh0T4imk4ysY/OSXqleRk4ecSmdWsZYOaO9pYhGpQUcsASJHZDHaq5INH3EfkEd6MRy9YMfUaa9eTC3rE62XdEFcn+EDWV7cuXr78eEyOaJzzA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=sVLUpkPD; arc=none smtp.client-ip=113.46.200.220
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=MHEhbSOgQT/iKyz5tYf5hbfXc1knUbfwbScpd4zGG2s=;
	b=sVLUpkPDv/tc0R5R4DBQzRcaB/ramhEY1AVRioARfsfZkNJdYFP9gGrLDksko8eo5QNNWsu6o
	4KG9jbqjNK6Qg7Swq/F69rW2vuZHL8+bKhQQoMwPlDNSXrQg1NFgC9/DijJtlsnQENnWb7NanRp
	hMb+MhcW7qeQUEzpfvAmTUA=
Received: from mail.maildlp.com (unknown [172.19.162.197])
	by canpmsgout05.his.huawei.com (SkyGuard) with ESMTPS id 4gztmN4XWsz12LCc;
	Tue, 14 Jul 2026 17:09:40 +0800 (CST)
Received: from dggemv712-chm.china.huawei.com (unknown [10.1.198.32])
	by mail.maildlp.com (Postfix) with ESMTPS id 01BD240579;
	Tue, 14 Jul 2026 17:19:19 +0800 (CST)
Received: from kwepemq500013.china.huawei.com (7.202.195.103) by
 dggemv712-chm.china.huawei.com (10.1.198.32) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Tue, 14 Jul 2026 17:19:18 +0800
Received: from dggphis33418.huawei.com (10.244.148.83) by
 kwepemq500013.china.huawei.com (7.202.195.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Tue, 14 Jul 2026 17:19:18 +0800
From: Gaosheng Cui <cuigaosheng1@huawei.com>
To: <cuigaosheng1@huawei.com>, <lujialin4@huawei.com>, <zohar@linux.ibm.com>,
	<roberto.sassu@huawei.com>, <dmitry.kasatkin@gmail.com>,
	<eric.snowberg@oracle.com>, <paul@paul-moore.com>, <jmorris@namei.org>,
	<serge@hallyn.com>
CC: <linux-integrity@vger.kernel.org>, <linux-security-module@vger.kernel.org>
Subject: [PATCH -next,v2] ima: add cond_resched() in ima_calc_file_hash_tfm loop
Date: Tue, 14 Jul 2026 17:17:08 +0800
Message-ID: <20260714091708.2802272-1-cuigaosheng1@huawei.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: kwepems100001.china.huawei.com (7.221.188.238) To
 kwepemq500013.china.huawei.com (7.202.195.103)
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-6.16 / 15.00];
	WHITELIST_DMARC(-7.00)[huawei.com:D:+];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[huawei.com,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[huawei.com:s=dkim];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-9935-lists,linux-integrity=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:cuigaosheng1@huawei.com,m:lujialin4@huawei.com,m:zohar@linux.ibm.com,m:roberto.sassu@huawei.com,m:dmitry.kasatkin@gmail.com,m:eric.snowberg@oracle.com,m:paul@paul-moore.com,m:jmorris@namei.org,m:serge@hallyn.com,m:linux-integrity@vger.kernel.org,m:linux-security-module@vger.kernel.org,m:dmitrykasatkin@gmail.com,s:lists@lfdr.de];
	FREEMAIL_TO(0.00)[huawei.com,linux.ibm.com,gmail.com,oracle.com,paul-moore.com,namei.org,hallyn.com];
	FORWARDED(0.00)[lists@lfdr.de];
	FROM_NEQ_ENVFROM(0.00)[cuigaosheng1@huawei.com,linux-integrity@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[cuigaosheng1@huawei.com,linux-integrity@vger.kernel.org];
	PRECEDENCE_BULK(0.00)[];
	DKIM_TRACE(0.00)[huawei.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	ALIAS_RESOLVED(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[huawei.com:from_mime,huawei.com:mid,huawei.com:email,huawei.com:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,vger.kernel.org:from_smtp];
	TO_DN_NONE(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	TAGGED_RCPT(0.00)[linux-integrity];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 4D2BB752CD2

When hashing large files, the while loop in ima_calc_file_hash_tfm
processes PAGE_SIZE chunks without any scheduling point, which can
cause soft lockup warnings:
watchdog: BUG: soft lockup - CPU#0 stuck for 50s!
Call Trace:
  _sha256_update+0x12d/0x1a0
  ima_calc_file_hash_tfm+0xfb/0x150
  ima_calc_file_hash+0x6e/0x160
  ima_collect_measurement+0x202/0x340
  process_measurement+0x3a9/0xb30
  ima_file_check+0x56/0xa0
  do_open+0x11b/0x250
  path_openat+0x10b/0x1d0
  do_filp_open+0xa9/0x150
  do_sys_openat2+0x223/0x2a0
  __x64_sys_openat+0x54/0xa0
  do_syscall_64+0x59/0x110
  entry_SYSCALL_64_after_hwframe+0x78/0xe2

Call cond_resched() every 4MB to yield the CPU when needed, rather
than at every loop iteration, to reduce overhead.

Fixes: 3323eec921ef ("integrity: IMA as an integrity service provider")
Signed-off-by: Gaosheng Cui <cuigaosheng1@huawei.com>
---
v2: call cond_resched() every 4MB to yield the CPU when needed
 security/integrity/ima/ima_crypto.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/security/integrity/ima/ima_crypto.c b/security/integrity/ima/ima_crypto.c
index 0d72b48249ee..aab2349c0c33 100644
--- a/security/integrity/ima/ima_crypto.c
+++ b/security/integrity/ima/ima_crypto.c
@@ -233,6 +233,9 @@ static int ima_calc_file_hash_tfm(struct file *file,
 		rc = crypto_shash_update(shash, rbuf, rbuf_len);
 		if (rc)
 			break;
+
+		if (IS_ALIGNED(offset, SZ_4M))
+			cond_resched();
 	}
 	kfree(rbuf);
 out:
-- 
2.43.0


