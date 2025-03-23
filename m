Return-Path: <linux-integrity+bounces-5385-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C531A6CF90
	for <lists+linux-integrity@lfdr.de>; Sun, 23 Mar 2025 15:10:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8E35D3B0B34
	for <lists+linux-integrity@lfdr.de>; Sun, 23 Mar 2025 14:09:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D2C0134AB;
	Sun, 23 Mar 2025 14:10:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="Msp+r5hv";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="qTC2GHtz";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="fg7rPlzo";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="91MZuBoe"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D2FB38F82
	for <linux-integrity@vger.kernel.org>; Sun, 23 Mar 2025 14:10:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742739007; cv=none; b=SZaws+w4nQqu+3rlLwhyoJh+P6An9N6MEIa5WQHAEdjETVyHrxMtO14qY87h8o4Du/x3n0Mn6JifSZUfOqQ6UctS3XHxlQ+ccGNG+BRFyPh4h9gjwJ1XaTib+3caWoAvzMk/QC9z5JL5c34G0Ds5T8f1DsnpdOWuwmI/KZm2Ta8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742739007; c=relaxed/simple;
	bh=GrpZgBg9X31Q08DVZDNHHA9FFHFSziClFTOti4a+eOI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OZZ7OeA2/HaPzI8VG+sL6i2YnTfqxKTGOdiXLStRpRTIUli9QPPswuEZhhe4IFLfZJIPtNARg3cAl+aeaSCa0DGyej/6nTgyZATLd7BUppsKPHiHRQdb/JRqJHfQ7p4g/1Vh84eKtOMlhO+uojWuGnKXtFavYBqMgo0oq9AT3SU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=Msp+r5hv; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=qTC2GHtz; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=fg7rPlzo; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=91MZuBoe; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id B35B6211A7;
	Sun, 23 Mar 2025 14:10:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1742739003; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/JiaCkjwv9/bflnepr5RWyBmkqWpeSpFXriQoiCmfWU=;
	b=Msp+r5hvvYBcjJHYoQ++4HMEdsUB8C9qYg40uMgGLz6t45jRGHXUm6iUEh55QRcqbaXTWN
	lndxAfcedINzWV2Xl6qnQ6PlMiRsTq6m2LiF1+x06etB4/AtzDT3kpHZ2EYhWBrRZfstZ8
	9bFn3qQMr0tKvcgw5KOoLCylaOvvHxw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1742739003;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/JiaCkjwv9/bflnepr5RWyBmkqWpeSpFXriQoiCmfWU=;
	b=qTC2GHtzosmLPYrRF3k1tKDgEuLuy1FlOzni1nYB75rNhtn0EO1eosY6WYaDQouCZ40QML
	gviV957qAIkCGHAA==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1742739002; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/JiaCkjwv9/bflnepr5RWyBmkqWpeSpFXriQoiCmfWU=;
	b=fg7rPlzoIdiMzxvGsaDy3AnbIzzZqakCI6MnfEo1Q3b1LDgsrWNywg4UWlew4K+xchKQeM
	eO3q5W0OlSIGMKCo6I8I7CEX96+WuAqRloAk0Uw54Qbjuw7Fvr7U9eWXOsRBVw2RLbJH2k
	g44HfRd8rlfTaQZkTY55+XNWY/kh1Zg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1742739002;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/JiaCkjwv9/bflnepr5RWyBmkqWpeSpFXriQoiCmfWU=;
	b=91MZuBoedm5OcUjVGlU0/ycs/p6NWfea+p6EzhUjrxDccHJIu22s+I+CVQEQTNjAQxxAhk
	WP05ArbAfRGvn5Cw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id A332C1339F;
	Sun, 23 Mar 2025 14:10:02 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id wbmpJjoW4GeQPAAAD6G6ig
	(envelope-from <nstange@suse.de>); Sun, 23 Mar 2025 14:10:02 +0000
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
Subject: [RFC PATCH v2 01/13] ima: don't expose runtime_measurements for unsupported hashes
Date: Sun, 23 Mar 2025 15:08:59 +0100
Message-ID: <20250323140911.226137-2-nstange@suse.de>
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
	NEURAL_HAM_SHORT(-0.20)[-0.997];
	MIME_GOOD(-0.10)[text/plain];
	RCPT_COUNT_SEVEN(0.00)[10];
	FREEMAIL_TO(0.00)[linux.ibm.com,huawei.com,gmail.com];
	MIME_TRACE(0.00)[0:+];
	TAGGED_RCPT(0.00)[];
	ARC_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	RCVD_TLS_ALL(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	URIBL_BLOCKED(0.00)[imap1.dmz-prg2.suse.org:helo,suse.de:mid,suse.de:email];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:mid,suse.de:email];
	FREEMAIL_ENVRCPT(0.00)[gmail.com]
X-Spam-Flag: NO
X-Spam-Level: 

IMA creates one runtime_measurements_<hash-algo> sysfs file for every TPM
bank + for SHA1 if not covered by any such. These differ only in that the
template hash value for each record is of the file's associated algorithm
each.

The kernel does not necessarily support each hash algorithm associated
with some TPM bank though -- the most common case probably being that the
algorithm is not built-in, but provided as a module, if at all, and thus
not available at IMA init time yet.

If that happens to be the case, the behavior is a bit counter-intuitive:
probably for historic reasons and to still extend the TPM bank with
something, a record's template hash is filled with the padded SHA1 value.
That is, it is perfectly possible that runtime_measurements_sha256 contains
padded SHA1 template hashes if SHA-256 was unavailable at IMA init.

I would argue that it's likely that no existing userspace tool is relying
on this fallback logic -- they either wouldn't consume the hash value from
the measurement list directly but recreate it by themselves, as is required
for verification against PCRs, or, if they did, they would somehow assume a
hash algorithm and expect the hashes in the measurement list to be of that
type. If of the latter kind, this could even lead to hard to debug
verification failures. For example, from looking at keylime's current
code, the verifier logic seems to assume that the template hashes found
in the provided measurement list are of the configured 'ima_log_hash_alg'
type. In particular, it does not check against padded SHA1 upon
mismatch.

That being said, there's also another dimension: currently IMA has a
hard requirement on SHA-1 and subsequent patches in this series will
attempt to get rid of that. If SHA-1 is not available at IMA init though,
it would also mean that padded SHA-1 values cannot get filled in as a
fallback for other unsupported algorithms. Substituting something like
hard coded all-zeroes or all-ones would be dangerous, because some
application or user scripts could perhaps (ab)use the template hashes from
the exported measurement lists for some kind of fingerprinting scheme or
so.

In conclusion, I think it's best to not create the
runtime_measurements_<hash-algo> sysfs files for hash algorithms not
supported by the kernel. That way, applications expecting a certain
hash algorithm for the measurement list and which are not able to handle
the padded-SHA1 fallback scheme would fail with a clear indication on what
the problem is. Furthermore, as digests for unsupported banks are not
getting exposed to userspace anymore, we'll have all flexibility to
set it to any value internally, including all-ones as will be needed in
a subsequent patch when addressing PCR extend for unsupported banks.

So, do not create runtime_measurements_<hash-algo> sysfs files for
unsupported hash algorithms. Likewise for their ascii counterparts.

Note that at this point, SHA-1 is still mandatory, and thus,
runtime_measurements_sha1 as well as the "runtime_measurements" will
remain there, even though the code has provisions already to skip their
creation as well in case SHA-1 was unavailable.

Signed-off-by: Nicolai Stange <nstange@suse.de>
---
 security/integrity/ima/ima_fs.c | 35 +++++++++++++++++++++------------
 1 file changed, 22 insertions(+), 13 deletions(-)

diff --git a/security/integrity/ima/ima_fs.c b/security/integrity/ima/ima_fs.c
index e4a79a9b2d58..a8df2fe5f4cb 100644
--- a/security/integrity/ima/ima_fs.c
+++ b/security/integrity/ima/ima_fs.c
@@ -454,6 +454,9 @@ static int __init create_securityfs_measurement_lists(void)
 		return -ENOMEM;
 
 	for (i = 0; i < securityfs_measurement_list_count; i++) {
+		if (!ima_algo_array[i].tfm)
+			continue;
+
 		algo = ima_algo_array[i].algo;
 
 		sprintf(file_name, "ascii_runtime_measurements_%s",
@@ -573,20 +576,26 @@ int __init ima_fs_init(void)
 	if (ret != 0)
 		goto out;
 
-	binary_runtime_measurements =
-	    securityfs_create_symlink("binary_runtime_measurements", ima_dir,
-				      "binary_runtime_measurements_sha1", NULL);
-	if (IS_ERR(binary_runtime_measurements)) {
-		ret = PTR_ERR(binary_runtime_measurements);
-		goto out;
-	}
+	if (ima_algo_array[ima_sha1_idx].tfm) {
+		binary_runtime_measurements =
+		    securityfs_create_symlink("binary_runtime_measurements",
+					      ima_dir,
+					      "binary_runtime_measurements_sha1",
+					      NULL);
+		if (IS_ERR(binary_runtime_measurements)) {
+			ret = PTR_ERR(binary_runtime_measurements);
+			goto out;
+		}
 
-	ascii_runtime_measurements =
-	    securityfs_create_symlink("ascii_runtime_measurements", ima_dir,
-				      "ascii_runtime_measurements_sha1", NULL);
-	if (IS_ERR(ascii_runtime_measurements)) {
-		ret = PTR_ERR(ascii_runtime_measurements);
-		goto out;
+		ascii_runtime_measurements =
+		    securityfs_create_symlink("ascii_runtime_measurements",
+					      ima_dir,
+					      "ascii_runtime_measurements_sha1",
+					      NULL);
+		if (IS_ERR(ascii_runtime_measurements)) {
+			ret = PTR_ERR(ascii_runtime_measurements);
+			goto out;
+		}
 	}
 
 	runtime_measurements_count =
-- 
2.49.0


