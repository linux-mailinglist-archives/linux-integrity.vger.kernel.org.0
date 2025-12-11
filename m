Return-Path: <linux-integrity+bounces-7912-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4831FCB59B8
	for <lists+linux-integrity@lfdr.de>; Thu, 11 Dec 2025 12:11:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 62C1330007B2
	for <lists+linux-integrity@lfdr.de>; Thu, 11 Dec 2025 11:11:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F7E02FFDDD;
	Thu, 11 Dec 2025 11:11:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="lp9C2s5O";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="t8GsSA2g";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="HJTtzRJB";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="9NWDTKvz"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24E7820C463
	for <linux-integrity@vger.kernel.org>; Thu, 11 Dec 2025 11:11:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765451468; cv=none; b=B4B8G8yUaS7ifDLOCPwR1ZmhBvZcyqCpf/Kz2ZUGdTEOvVLPoVJ95+mlV+tpPuTwTaMR4DGP58DIn3lE51U706LAIs5f/P2Jvsqm/XgcE46Ss+XONnzaUYj1zVrHwNmUzM9MNZefgc14Z0GdOJh85UH9dPNv02OeTiodetTa4rM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765451468; c=relaxed/simple;
	bh=Nj+ydEHMBs+PgxMlj10ceTJatnHGO8WRL5r3zivfrWk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Pi2Ht/J3/5eyKIbi6Dm+k+WjCdls9hO19ufwTg1QtpoabkDAOGV7ahNGUhxaQUUc4sxarJaZqvYWGVRilVZtc2KeGCRla8MkhK1ih7qJE38f8jIqglVZKFEhvR0OKL54H7EJE2vgeBXVSD03yPjpCbY9oCu9XMmFGYO7GsSwEis=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=lp9C2s5O; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=t8GsSA2g; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=HJTtzRJB; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=9NWDTKvz; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id CF32133698;
	Thu, 11 Dec 2025 11:10:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1765451455; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=4VcFZzLxxY1PWRh3+JVS+4B3u6aYNLdujssB422DXhI=;
	b=lp9C2s5Oek/sbYrIIFoSFPRrpF5bX/ir0/ljgBYrBqRbifBRVVqaf/mFhyNyWRRwsjHpHq
	dXQaEZ5E+jsNnpJLkSAnJOTToYL13bemA84lnCauzyvL8Ht5BMTzrzw7L7fEOipiGdOOcz
	8u3ac8huXAVLkufl6cxHuxcrfA6IFMs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1765451455;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=4VcFZzLxxY1PWRh3+JVS+4B3u6aYNLdujssB422DXhI=;
	b=t8GsSA2gtF4+dA/Ipf5OM8kI1YKSHZRoeaAfUVVqjCiheO7GTOfIUS6PM5jJ4iLwZu84uS
	XrLPtf628De5O9AA==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=HJTtzRJB;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=9NWDTKvz
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1765451453; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=4VcFZzLxxY1PWRh3+JVS+4B3u6aYNLdujssB422DXhI=;
	b=HJTtzRJBVk6Bi6UX+Padkil8OAtF06FsXh0nnUqFhf2pDVr/4Sps8e2opORubo4HPNSxn+
	Z+aet224MiWxYJ6y4jbbNoRNd3NjZHTWT/HC4F9vY4fYSdndj9Lo78K0aaWnNc55zGoYRr
	SQZpiiQR1ztb9NdG3MREJjLg0Uw4Jo0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1765451453;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=4VcFZzLxxY1PWRh3+JVS+4B3u6aYNLdujssB422DXhI=;
	b=9NWDTKvz2kqcl0X9QFdsQqzn7qrV1rV+Pw6+AuDhBn1w38VzGFb75knhDz7mai9hTZ6OJS
	1PeSHydvhn28GMBA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 637A83EA63;
	Thu, 11 Dec 2025 11:10:52 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id zgRVDrymOmndWAAAD6G6ig
	(envelope-from <pvorel@suse.cz>); Thu, 11 Dec 2025 11:10:52 +0000
From: Petr Vorel <pvorel@suse.cz>
To: ltp@lists.linux.it
Cc: Petr Vorel <pvorel@suse.cz>,
	Mimi Zohar <zohar@linux.ibm.com>,
	linux-integrity@vger.kernel.org,
	Martin Doucha <mdoucha@suse.cz>
Subject: [PATCH] ima_violations.sh: Another fix of condition evaluation
Date: Thu, 11 Dec 2025 12:10:46 +0100
Message-ID: <20251211111046.87297-1-pvorel@suse.cz>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Flag: NO
X-Spam-Score: -3.01
X-Rspamd-Queue-Id: CF32133698
X-Spamd-Result: default: False [-3.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	TO_DN_SOME(0.00)[];
	ARC_NA(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	MIME_TRACE(0.00)[0:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	RCVD_TLS_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:mid,suse.cz:dkim,suse.cz:email,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_TRACE(0.00)[suse.cz:+]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Level: 

c0c35509f9 was not enough to fix evaluation against empty
$expected_violations:

ima_violations 1 TINFO: verify open writers violation
/opt/ltp/testcases/bin/ima_violations.sh: line 96: [: 0: unary operator expected

Therefore split checks into two if.

Also improvements (readability)
* shorten line length with saving subtraction into variable
* evaluate empty variable with ${:-}

Fixes: 726ed71905 ("ima_violations.sh: Update validate() to support multiple violations")
Reported-by: Martin Doucha <mdoucha@suse.cz>
Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
NOTE: this was found on old SLES 4.4 based kernel which does not log
validations. But missing validations might be just a Secure Boot related
setup problem:

$ mokutil --sb-state
Secure Boot: EFI variables not supported on SUT

Events are logged when Secure Boot is off:
$ mokutil --sb-state
SecureBoot disabled

Or maybe violations worked differently on the old kernel (I remember
only 6.15 change).

Kind regards,
Petr

 .../integrity/ima/tests/ima_violations.sh     | 21 ++++++++++++-------
 1 file changed, 14 insertions(+), 7 deletions(-)

diff --git a/testcases/kernel/security/integrity/ima/tests/ima_violations.sh b/testcases/kernel/security/integrity/ima/tests/ima_violations.sh
index 1d2f1d9447..a8476e6b59 100755
--- a/testcases/kernel/security/integrity/ima/tests/ima_violations.sh
+++ b/testcases/kernel/security/integrity/ima/tests/ima_violations.sh
@@ -87,23 +87,30 @@ validate()
 	local search="$3"
 	local expected_violations="$4"
 	local max_attempt=3
-	local count2 i num_violations_new
+	local count2 diff i num_violations_new pass
 
 	for i in $(seq 1 $max_attempt); do
 		read num_violations_new < $IMA_VIOLATIONS
 		count2="$(get_count $search)"
-		if [ -z "$expected_violations" -a $(($num_violations_new - $num_violations)) -gt 0 ] || \
-		   [ $(($num_violations_new - $num_violations)) -eq $expected_violations ]; then
-			[ -z "$expected_violations" ] && expected_violations=1
+		diff=$(($num_violations_new - $num_violations))
+
+		if [ "$expected_violations" ] && [ $diff -eq $expected_violations ]; then
+			pass=1
+		fi
+		if [ -z "$expected_violations" ] && [ $diff -gt 0 ]; then
+			pass=1
+		fi
+
+		if [ "$pass" = 1 ]; then
 			if [ $count2 -gt $count ]; then
-				tst_res TPASS "$expected_violations $search violation(s) added"
+				tst_res TPASS "${expected_violations:-1} $search violation(s) added"
 				return
 			else
 				tst_res TINFO "$search not found in $LOG ($i/$max_attempt attempt)..."
 				tst_sleep 1s
 			fi
-		elif [ $(($num_violations_new - $num_violations)) -gt 0 ]; then
-			tst_res $IMA_FAIL "$search too many violations added: $num_violations_new - $num_violations"
+		elif [ $diff -gt 0 ]; then
+			tst_res $IMA_FAIL "$search too many violations added: $diff ($num_violations_new - $num_violations)"
 			return
 		else
 			tst_res $IMA_FAIL "$search violation not added"
-- 
2.51.0


