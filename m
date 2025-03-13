Return-Path: <linux-integrity+bounces-5275-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 05597A5FDE9
	for <lists+linux-integrity@lfdr.de>; Thu, 13 Mar 2025 18:36:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5B4023B8806
	for <lists+linux-integrity@lfdr.de>; Thu, 13 Mar 2025 17:35:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A79CF14386D;
	Thu, 13 Mar 2025 17:35:10 +0000 (UTC)
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 104781684B4
	for <linux-integrity@vger.kernel.org>; Thu, 13 Mar 2025 17:35:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741887310; cv=none; b=V/KvpP7REYMQf9JjObvFd3t6c8IKpjr2s4oQfv66Fycl61DiMnGLOO9LGW8Ff1Z7H2TZwVLpQ90lkRN+AeBwy2uPzNFw6iVa/1j8eSIRUhFSbJVhxLdW6ucYkC2NAjTq2G9vDMfPTz+UJsDWpIWfNn/dzskqh5dbZpR9aLYikrM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741887310; c=relaxed/simple;
	bh=+/CXGFgCUz0uWuCA+o+zWIoOUsY7OcPsmo/uFiucgO0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aW1ec+CCWtrLNSsUDL07x1D7+5cv8PFGANd4P0v4TpyOtGhUJWUbT37KJu5ub6FKfFE5P8ldN8RUY8dzSBYUI4WGrzU+mHgS8iC4wSFCVI7Xha6bX1dFyNRLSvzu5LRvP62k7tQ0O61zUZCVA0+aOiSMC0WVfwpp54CiPeklF+Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 7612C1F769;
	Thu, 13 Mar 2025 17:35:07 +0000 (UTC)
Authentication-Results: smtp-out2.suse.de;
	none
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 656BB137BA;
	Thu, 13 Mar 2025 17:35:07 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id MAiKF0sX02cXQwAAD6G6ig
	(envelope-from <nstange@suse.de>); Thu, 13 Mar 2025 17:35:07 +0000
From: Nicolai Stange <nstange@suse.de>
To: Mimi Zohar <zohar@linux.ibm.com>,
	Roberto Sassu <roberto.sassu@huawei.com>,
	Dmitry Kasatkin <dmitry.kasatkin@gmail.com>
Cc: Eric Snowberg <eric.snowberg@oracle.com>,
	linux-integrity@vger.kernel.org,
	linux-security-module@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Nicolai Stange <nstange@suse.de>
Subject: [RFC PATCH v1 3/7] ima: move INVALID_PCR() to ima.h
Date: Thu, 13 Mar 2025 18:33:35 +0100
Message-ID: <20250313173339.3815589-4-nstange@suse.de>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250313173339.3815589-1-nstange@suse.de>
References: <20250313173339.3815589-1-nstange@suse.de>
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
X-Rspamd-Queue-Id: 7612C1F769
X-Rspamd-Pre-Result: action=no action;
	module=replies;
	Message is reply to one we originated
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
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
2.47.1


