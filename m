Return-Path: <linux-integrity+bounces-5386-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 45D56A6CF9C
	for <lists+linux-integrity@lfdr.de>; Sun, 23 Mar 2025 15:11:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D4D071898CAC
	for <lists+linux-integrity@lfdr.de>; Sun, 23 Mar 2025 14:10:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 282E35D8F0;
	Sun, 23 Mar 2025 14:10:08 +0000 (UTC)
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D580EEA8
	for <linux-integrity@vger.kernel.org>; Sun, 23 Mar 2025 14:10:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742739008; cv=none; b=Fw3NTAORnjiEFkViOcBj9z3BQkwOjV1pKk2T+1JdTeA0thRSEoXLW2lRrpJjTj/GHZGjV9FqIyT+owhx6iWt5+bAXuYKdSns/3X/JdH4OcKEKu+DqdU9r3PUvLLi+gBSESvFH0ITDuz7SbsqZ1jy4SSnyk3ojfQId7Ljyo6zSv4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742739008; c=relaxed/simple;
	bh=PUpwA3nhwZdwqXKivSydzyS3A4qMsnQtuTuuQGus5BA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=X59fI2z0kQOF3oV+nTsdSmnIIvDwmkCYjcNKtsfJatrnUApBCVId84krMiBsLV/UNvpWM7UNfJfns8v5oomcnr+OJxxTUTSGc0EVPkzGiN2VLkdqayZDgOBb4Qgoc/DkaUiWUi4xlfSAnnWCzG82okvLviaIpFZoscPl+JNniTA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id A6C291F445;
	Sun, 23 Mar 2025 14:10:04 +0000 (UTC)
Authentication-Results: smtp-out2.suse.de;
	none
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 93C6C1339F;
	Sun, 23 Mar 2025 14:10:04 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id KTzjIjwW4GeUPAAAD6G6ig
	(envelope-from <nstange@suse.de>); Sun, 23 Mar 2025 14:10:04 +0000
From: Nicolai Stange <nstange@suse.de>
To: Mimi Zohar <zohar@linux.ibm.com>,
	Roberto Sassu <roberto.sassu@huawei.com>,
	Dmitry Kasatkin <dmitry.kasatkin@gmail.com>
Cc: Eric Snowberg <eric.snowberg@oracle.com>,
	Jarkko Sakkinen <jarkko@kernel.org>,
	James Bottomley <James.Bottomley@HansenPartnership.com>,
	linux-integrity@vger.kernel.org,
	linux-security-module@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Nicolai Stange <nstange@suse.de>
Subject: [RFC PATCH v2 02/13] ima: always create runtime_measurements sysfs file for ima_hash
Date: Sun, 23 Mar 2025 15:09:00 +0100
Message-ID: <20250323140911.226137-3-nstange@suse.de>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250323140911.226137-1-nstange@suse.de>
References: <20250323140911.226137-1-nstange@suse.de>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Pre-Result: action=no action;
	module=replies;
	Message is reply to one we originated
X-Spamd-Result: default: False [-4.00 / 50.00];
	REPLY(-4.00)[];
	TAGGED_RCPT(0.00)[]
X-Spam-Flag: NO
X-Spam-Score: -4.00
X-Rspamd-Queue-Id: A6C291F445
X-Rspamd-Pre-Result: action=no action;
	module=replies;
	Message is reply to one we originated
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Level: 

runtime_measurements_<hash-algo> sysfs files are getting created for
each PCR bank + for SHA-1.

Now that runtime_measurements_<hash-algo> sysfs file creation is being
skipped for unsupported hash algorithms, it will become possible that no
such file would be provided at all once SHA-1 is made optional in a
later patch.

Always create the file for the 'ima_hash' algorithm, even if it's not
associated with any of the PCR banks. As IMA initialization will
continue to fail if the ima_hash algorithm is not available to the
kernel, this guarantees that at least one such file will always be
there.

Signed-off-by: Nicolai Stange <nstange@suse.de>
---
 security/integrity/ima/ima_fs.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/security/integrity/ima/ima_fs.c b/security/integrity/ima/ima_fs.c
index a8df2fe5f4cb..f030ff7f56da 100644
--- a/security/integrity/ima/ima_fs.c
+++ b/security/integrity/ima/ima_fs.c
@@ -436,10 +436,8 @@ static int __init create_securityfs_measurement_lists(void)
 	u16 algo;
 	int i;
 
-	securityfs_measurement_list_count = NR_BANKS(ima_tpm_chip);
-
-	if (ima_sha1_idx >= NR_BANKS(ima_tpm_chip))
-		securityfs_measurement_list_count++;
+	securityfs_measurement_list_count =
+		NR_BANKS(ima_tpm_chip) + ima_extra_slots;
 
 	ascii_securityfs_measurement_lists =
 	    kcalloc(securityfs_measurement_list_count, sizeof(struct dentry *),
-- 
2.49.0


