Return-Path: <linux-integrity+bounces-5274-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 15BBEA5FDE5
	for <lists+linux-integrity@lfdr.de>; Thu, 13 Mar 2025 18:35:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4178616F00E
	for <lists+linux-integrity@lfdr.de>; Thu, 13 Mar 2025 17:35:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 394C11DB154;
	Thu, 13 Mar 2025 17:35:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="yYZgIEcS";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="npLhIGwW";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="yYZgIEcS";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="npLhIGwW"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 758231D5173
	for <linux-integrity@vger.kernel.org>; Thu, 13 Mar 2025 17:35:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741887304; cv=none; b=oYOYanySgLHKDoZ6IG2X8lK5mj+eSZy4+mpWgiXgAM6NIzfHhxV4WTmJtT8c6JVqn1LF6GLyDBCCt87lu3fVGIwxBJYnrMnQjM4JBuEnK3MaPWlleZUCAIxZrJ0Ysb/lvcrbueJ2VP6FlHH9IzDT9cuwFIjAxbsNJj1/Ew6mdJ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741887304; c=relaxed/simple;
	bh=ofk0dyiGJGUPbX7KRZbBwqReFP1t2mJ0ikjz0JZiPHg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HFoGbTrhNjgO8yaA2KdRNTIF1E17SEoiw5Y2lGOc+tIfwCVeouf0BdXvdHzlZzFVInfugQvv9pS9YXAZ5uIAnAu+OkyOTS7E+zDYhBHFaaDjmrqCm4ncBbb1PDWZYwNe6tQs9rQkldTZ1p80Py/jMWkMfVSHY/2IlbRJOnlFW94=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=yYZgIEcS; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=npLhIGwW; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=yYZgIEcS; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=npLhIGwW; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 98F371F769;
	Thu, 13 Mar 2025 17:35:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1741887300; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=USlxaMFieu/+hsrqsfqIHnzxT/feUUlitxBTpJXrB0A=;
	b=yYZgIEcSLtOx0ewkStIVSpei4aI/h2rg7Cd2fJABZjV8oAg3gCpga9bLnA9sg8RfF5Uw1D
	9SUzAzgRzYQ0FKiO413dI2WH0pcK55689D7UXSC7dLVFnazvanUkUJeXvicp1voTykXG60
	bg5RQoA4OH5wg7Hpu7LCx3YpeEt2nig=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1741887300;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=USlxaMFieu/+hsrqsfqIHnzxT/feUUlitxBTpJXrB0A=;
	b=npLhIGwWRHukPgeghFs+Ofeb/dKs1vyAZkY46PpxpBYPkhOjcbfx+RoEC5NDAGrS0P3QVE
	qgpGSAeoWZNpoyAA==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1741887300; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=USlxaMFieu/+hsrqsfqIHnzxT/feUUlitxBTpJXrB0A=;
	b=yYZgIEcSLtOx0ewkStIVSpei4aI/h2rg7Cd2fJABZjV8oAg3gCpga9bLnA9sg8RfF5Uw1D
	9SUzAzgRzYQ0FKiO413dI2WH0pcK55689D7UXSC7dLVFnazvanUkUJeXvicp1voTykXG60
	bg5RQoA4OH5wg7Hpu7LCx3YpeEt2nig=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1741887300;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=USlxaMFieu/+hsrqsfqIHnzxT/feUUlitxBTpJXrB0A=;
	b=npLhIGwWRHukPgeghFs+Ofeb/dKs1vyAZkY46PpxpBYPkhOjcbfx+RoEC5NDAGrS0P3QVE
	qgpGSAeoWZNpoyAA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 8847B137BA;
	Thu, 13 Mar 2025 17:35:00 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id QycUIEQX02cLQwAAD6G6ig
	(envelope-from <nstange@suse.de>); Thu, 13 Mar 2025 17:35:00 +0000
From: Nicolai Stange <nstange@suse.de>
To: Mimi Zohar <zohar@linux.ibm.com>,
	Roberto Sassu <roberto.sassu@huawei.com>,
	Dmitry Kasatkin <dmitry.kasatkin@gmail.com>
Cc: Eric Snowberg <eric.snowberg@oracle.com>,
	linux-integrity@vger.kernel.org,
	linux-security-module@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Nicolai Stange <nstange@suse.de>
Subject: [RFC PATCH v1 2/7] ima: always create runtime_measurements sysfs file for ima_hash
Date: Thu, 13 Mar 2025 18:33:34 +0100
Message-ID: <20250313173339.3815589-3-nstange@suse.de>
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
X-Spam-Level: 
X-Spamd-Result: default: False [-5.30 / 50.00];
	REPLY(-4.00)[];
	BAYES_HAM(-3.00)[99.99%];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MIME_TRACE(0.00)[0:+];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	ARC_NA(0.00)[];
	FREEMAIL_TO(0.00)[linux.ibm.com,huawei.com,gmail.com];
	RCVD_TLS_ALL(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	RCPT_COUNT_SEVEN(0.00)[8];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo];
	TAGGED_RCPT(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com]
X-Spam-Score: -5.30
X-Spam-Flag: NO

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
2.47.1


