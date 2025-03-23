Return-Path: <linux-integrity+bounces-5392-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CF98EA6CFA3
	for <lists+linux-integrity@lfdr.de>; Sun, 23 Mar 2025 15:11:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 452A63B5A54
	for <lists+linux-integrity@lfdr.de>; Sun, 23 Mar 2025 14:11:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57F281519BE;
	Sun, 23 Mar 2025 14:10:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="af9Skywd";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="fEaqYM7p";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="af9Skywd";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="fEaqYM7p"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8411484D08
	for <linux-integrity@vger.kernel.org>; Sun, 23 Mar 2025 14:10:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742739027; cv=none; b=deihdt8WDCZV/P1mgU1D98nVi546JOkqG4YJVPM3nO8YHXLSSRmPGcbo3NoqhvDSh7sj1ZPoDxgJgL1CeQd/S6Oyo2Tgr3nZCY39MGbHOQfyda4HxxievW3SLkRhMHkYjQXdSLK3fOdbs8vSYvVjInU0PzuFSVuNsvxDdFzmBPU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742739027; c=relaxed/simple;
	bh=T0PoZeJmBgvjPiLh0/yVeEy/YsIJz7XgpipDRZ7o+xA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=roO4cV2Dk1P7exXob3+E+9/wG/FZ5e4m3qyIdqLezAF8rv7ur6b8G+asS8/aI6HhKBrLk+NzUfYiCeEOvOlmGUIm61R8s9XAiIdpMj2d8CtvOtI0IkLH//89SsbyOO876foVA6KtG3+ahHAmpwGi89RDfaYzrXgXqUgsffasGKM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=af9Skywd; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=fEaqYM7p; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=af9Skywd; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=fEaqYM7p; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 73DA51F45B;
	Sun, 23 Mar 2025 14:10:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1742739010; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6Gqo9YcEkZlK70DQeUhxU0UqBpCo/yuzbSGr69XBndA=;
	b=af9SkywdZnsxzeiMGsZrJEsgiFMJioTSuNYeImu9XsRw10ozI47azfiqA3WZdHwMkgx9Gd
	8b3xTKjUgH7iPgS+LTDZESPZbHFWBn5LdonlPyMNkdVJX+2XtyL/HNEr1neaoduhjWRzt8
	7HmFkfnBboG/oApyQIr7r3Qbzy6yOas=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1742739010;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6Gqo9YcEkZlK70DQeUhxU0UqBpCo/yuzbSGr69XBndA=;
	b=fEaqYM7pa2WkjdfntrjHQedwlt5ukTkZkKJ67L63U6onJxlhVgrk6WdcKrU2R2dR2Axb/7
	WMeQXwr8VeFrydDw==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1742739010; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6Gqo9YcEkZlK70DQeUhxU0UqBpCo/yuzbSGr69XBndA=;
	b=af9SkywdZnsxzeiMGsZrJEsgiFMJioTSuNYeImu9XsRw10ozI47azfiqA3WZdHwMkgx9Gd
	8b3xTKjUgH7iPgS+LTDZESPZbHFWBn5LdonlPyMNkdVJX+2XtyL/HNEr1neaoduhjWRzt8
	7HmFkfnBboG/oApyQIr7r3Qbzy6yOas=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1742739010;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6Gqo9YcEkZlK70DQeUhxU0UqBpCo/yuzbSGr69XBndA=;
	b=fEaqYM7pa2WkjdfntrjHQedwlt5ukTkZkKJ67L63U6onJxlhVgrk6WdcKrU2R2dR2Axb/7
	WMeQXwr8VeFrydDw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 61F9B1339F;
	Sun, 23 Mar 2025 14:10:10 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 97S6FkIW4GeiPAAAD6G6ig
	(envelope-from <nstange@suse.de>); Sun, 23 Mar 2025 14:10:10 +0000
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
Subject: [RFC PATCH v2 06/13] ima: move INVALID_PCR() to ima.h
Date: Sun, 23 Mar 2025 15:09:04 +0100
Message-ID: <20250323140911.226137-7-nstange@suse.de>
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
X-Spam-Score: -5.30
X-Spamd-Result: default: False [-5.30 / 50.00];
	REPLY(-4.00)[];
	BAYES_HAM(-3.00)[100.00%];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-0.998];
	MIME_GOOD(-0.10)[text/plain];
	URIBL_BLOCKED(0.00)[imap1.dmz-prg2.suse.org:helo,suse.de:mid,suse.de:email];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	ARC_NA(0.00)[];
	FREEMAIL_TO(0.00)[linux.ibm.com,huawei.com,gmail.com];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	RCVD_TLS_ALL(0.00)[];
	R_RATELIMIT(0.00)[to_ip_from(RL6owce66jwsk5yhus1j8gn7jo)];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	TAGGED_RCPT(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:mid,suse.de:email]
X-Spam-Flag: NO
X-Spam-Level: 

Make the INVALID_PCR() #define available to other compilation units
by moving it from ima_policy.c to ima.h and renaming it to
IMA_INVALID_PCR() in the course.

Signed-off-by: Nicolai Stange <nstange@suse.de>
---
 security/integrity/ima/ima.h        | 4 ++++
 security/integrity/ima/ima_policy.c | 5 +----
 2 files changed, 5 insertions(+), 4 deletions(-)

diff --git a/security/integrity/ima/ima.h b/security/integrity/ima/ima.h
index a4f284bd846c..1158a7b8bf6b 100644
--- a/security/integrity/ima/ima.h
+++ b/security/integrity/ima/ima.h
@@ -198,6 +198,10 @@ struct ima_iint_cache {
 	struct ima_digest_data *ima_hash;
 };
 
+#define IMA_INVALID_PCR(a) (((a) < 0) || \
+	(a) >= (sizeof_field(struct ima_iint_cache, measured_pcrs) * 8))
+
+
 extern struct lsm_blob_sizes ima_blob_sizes;
 
 static inline struct ima_iint_cache *
diff --git a/security/integrity/ima/ima_policy.c b/security/integrity/ima/ima_policy.c
index 128fab897930..d9e4210ea814 100644
--- a/security/integrity/ima/ima_policy.c
+++ b/security/integrity/ima/ima_policy.c
@@ -48,9 +48,6 @@
 #define HASH		0x0100
 #define DONT_HASH	0x0200
 
-#define INVALID_PCR(a) (((a) < 0) || \
-	(a) >= (sizeof_field(struct ima_iint_cache, measured_pcrs) * 8))
-
 int ima_policy_flag;
 static int temp_ima_appraise;
 static int build_ima_appraise __ro_after_init;
@@ -1855,7 +1852,7 @@ static int ima_parse_rule(char *rule, struct ima_rule_entry *entry)
 			ima_log_string(ab, "pcr", args[0].from);
 
 			result = kstrtoint(args[0].from, 10, &entry->pcr);
-			if (result || INVALID_PCR(entry->pcr))
+			if (result || IMA_INVALID_PCR(entry->pcr))
 				result = -EINVAL;
 			else
 				entry->flags |= IMA_PCR;
-- 
2.49.0


