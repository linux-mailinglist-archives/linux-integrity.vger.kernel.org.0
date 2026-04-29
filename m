Return-Path: <linux-integrity+bounces-9367-lists+linux-integrity=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-integrity@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oHQCKkks8mlvogEAu9opvQ
	(envelope-from <linux-integrity+bounces-9367-lists+linux-integrity=lfdr.de@vger.kernel.org>)
	for <lists+linux-integrity@lfdr.de>; Wed, 29 Apr 2026 18:05:29 +0200
X-Original-To: lists+linux-integrity@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 753C749770E
	for <lists+linux-integrity@lfdr.de>; Wed, 29 Apr 2026 18:05:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 4DADF3014687
	for <lists+linux-integrity@lfdr.de>; Wed, 29 Apr 2026 16:05:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07C5E382F18;
	Wed, 29 Apr 2026 16:04:56 +0000 (UTC)
X-Original-To: linux-integrity@vger.kernel.org
Received: from frasgout11.his.huawei.com (frasgout11.his.huawei.com [14.137.139.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C3C9329C66;
	Wed, 29 Apr 2026 16:04:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=14.137.139.23
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777478695; cv=none; b=T9/jBQMzdXs73scMB7cxqnHZ2cYpUB9pL+TaFTUWwZBZ+IAGEGVHynZP8qplTtj95zxs8Mms3RAJnFOJaCp/ZLQ9ATDEgUO2/Pu7bJ7l4OffZkCiq8l9amrurpc871xcBlOyQdZko/LXHDHfqJ3TtZrHUxOmhFrh2+ONKp7vjwg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777478695; c=relaxed/simple;
	bh=lTEMSdWntKFwJ7UZj396vRRLvGqDKzB88Vh6/ciMCuk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=siMOCRurHoTg0n8tJ8/LVNsjcTdbLkANftAHT+rgzLScujKMt2S6LJjK0FVWGpk4Py2Z80BbUiY+HNf7NcYoO0ram633MhORPQVmi3ln5vaOe91RaJ0XSTTCwXvxUGSauh9WwWeYOfnlqUfiGW9q2zFKvFWP+lcbjF6mIuSjlYM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=14.137.139.23
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.18.224.196])
	by frasgout11.his.huawei.com (SkyGuard) with ESMTPS id 4g5MTJ3wWZz1HCXJ;
	Thu, 30 Apr 2026 00:00:20 +0800 (CST)
Received: from mail02.huawei.com (unknown [7.182.16.27])
	by mail.maildlp.com (Postfix) with ESMTP id 6624D40565;
	Thu, 30 Apr 2026 00:04:51 +0800 (CST)
Received: from huaweicloud.com (unknown [10.204.63.22])
	by APP2 (Coremail) with SMTP id GxC2BwBHPmrYK_JpRQ1BAA--.12298S10;
	Wed, 29 Apr 2026 17:04:50 +0100 (CET)
From: Roberto Sassu <roberto.sassu@huaweicloud.com>
To: corbet@lwn.net,
	skhan@linuxfoundation.org,
	zohar@linux.ibm.com,
	dmitry.kasatkin@gmail.com,
	eric.snowberg@oracle.com,
	paul@paul-moore.com,
	jmorris@namei.org,
	serge@hallyn.com
Cc: linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-integrity@vger.kernel.org,
	linux-security-module@vger.kernel.org,
	gregorylumen@linux.microsoft.com,
	chenste@linux.microsoft.com,
	nramas@linux.microsoft.com,
	Roberto Sassu <roberto.sassu@huawei.com>
Subject: [PATCH v5 08/13] ima: Introduce ima_dump_measurement()
Date: Wed, 29 Apr 2026 18:03:14 +0200
Message-ID: <20260429160319.4162918-9-roberto.sassu@huaweicloud.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260429160319.4162918-1-roberto.sassu@huaweicloud.com>
References: <20260429160319.4162918-1-roberto.sassu@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:GxC2BwBHPmrYK_JpRQ1BAA--.12298S10
X-Coremail-Antispam: 1UD129KBjvJXoW7CFyfXryDAw1rKFyfCFy7trb_yoW8AF43pa
	9IgFy8Cr18tFyxKrn3GF98Ja1F93y8AF1UW3yDWwn3XF1DJr1Dur95Cr1IvrZ8GrZayF1x
	tw4agF4ruan0yaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUPlb4IE77IF4wAFF20E14v26rWj6s0DM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28IrcIa0xkI8VA2jI8067AKxVWUAV
	Cq3wA2048vs2IY020Ec7CjxVAFwI0_Xr0E3s1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0
	rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVWUCVW8JwA2z4x0Y4vE2Ix0cI8IcVCY1x0267
	AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVAFwI0_Jr0_Gr1l84ACjcxK6I8E87Iv6xkF7I0E
	14v26r4UJVWxJr1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrV
	C2j2WlYx0E2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE
	7xkEbVWUJVW8JwACjcxG0xvY0x0EwIxGrwACI402YVCY1x02628vn2kIc2xKxwCY1x0262
	kKe7AKxVWUtVW8ZwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s02
	6c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_GF
	v_WrylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUCVW8JwCI42IY6xIIjxv20xvE
	c7CjxVAFwI0_Gr1j6F4UJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aV
	AFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8Jr0_Cr1UYxBIdaVFxhVjvjDU0xZF
	pf9x07UZTmfUUUUU=
X-CM-SenderInfo: purev21wro2thvvxqx5xdzvxpfor3voofrz/1tbiAgASBGnx6jEGFwAAsG
X-Rspamd-Queue-Id: 753C749770E
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.54 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-9367-lists,linux-integrity=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[16];
	RCVD_TLS_LAST(0.00)[];
	DMARC_NA(0.00)[huaweicloud.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[lwn.net,linuxfoundation.org,linux.ibm.com,gmail.com,oracle.com,paul-moore.com,namei.org,hallyn.com];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	NEURAL_SPAM(0.00)[0.879];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[roberto.sassu@huaweicloud.com,linux-integrity@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	TAGGED_RCPT(0.00)[linux-integrity];
	R_DKIM_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[huaweicloud.com:mid,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,huawei.com:email]

From: Roberto Sassu <roberto.sassu@huawei.com>

Introduce ima_dump_measurement() to simplify the code of
ima_dump_measurement_list() and to avoid repeating the
ima_dump_measurement() code block if iteration occurs on multiple lists.

No functional change: only code moved to a separate function.

Link: https://github.com/linux-integrity/linux/issues/1
Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>
---
 security/integrity/ima/ima_kexec.c | 19 +++++++++++++------
 1 file changed, 13 insertions(+), 6 deletions(-)

diff --git a/security/integrity/ima/ima_kexec.c b/security/integrity/ima/ima_kexec.c
index 44ebefbdcab0..d7d0fb639d99 100644
--- a/security/integrity/ima/ima_kexec.c
+++ b/security/integrity/ima/ima_kexec.c
@@ -80,6 +80,17 @@ static int ima_alloc_kexec_file_buf(size_t segment_size)
 	return 0;
 }
 
+static int ima_dump_measurement(struct ima_kexec_hdr *khdr,
+				struct ima_queue_entry *qe)
+{
+	if (ima_kexec_file.count >= ima_kexec_file.size)
+		return -EINVAL;
+
+	khdr->count++;
+	ima_measurements_show(&ima_kexec_file, qe);
+	return 0;
+}
+
 static int ima_dump_measurement_list(unsigned long *buffer_size, void **buffer,
 				     unsigned long segment_size)
 {
@@ -97,13 +108,9 @@ static int ima_dump_measurement_list(unsigned long *buffer_size, void **buffer,
 	khdr.version = 1;
 	/* This is an append-only list, no need to hold the RCU read lock */
 	list_for_each_entry_rcu(qe, &ima_measurements, later, true) {
-		if (ima_kexec_file.count < ima_kexec_file.size) {
-			khdr.count++;
-			ima_measurements_show(&ima_kexec_file, qe);
-		} else {
-			ret = -EINVAL;
+		ret = ima_dump_measurement(&khdr, qe);
+		if (ret < 0)
 			break;
-		}
 	}
 
 	/*
-- 
2.43.0


