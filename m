Return-Path: <linux-integrity+bounces-4385-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A8239F1902
	for <lists+linux-integrity@lfdr.de>; Fri, 13 Dec 2024 23:27:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A7F5F162F27
	for <lists+linux-integrity@lfdr.de>; Fri, 13 Dec 2024 22:26:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC6011EE01F;
	Fri, 13 Dec 2024 22:20:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="YlUfEUYR";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="B4Q80ktE";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="YlUfEUYR";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="B4Q80ktE"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48A951A8F98
	for <linux-integrity@vger.kernel.org>; Fri, 13 Dec 2024 22:20:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734128422; cv=none; b=F7K5XdZQk6SMxgi+eaKjo+/cFtHD43Bx1xU1DoYAawm0aVU2GkJRLeDvxWMdF/JGm8n9A1Ou6S8pxmuaVC8cjCjxuius0ltJHdgfViz+3k1NO+a+VpgiPHFPnRVdgUKbFCMVp+Qnn3inTcgD4CoC7l/Tw0xZLovR0jba7SLAScM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734128422; c=relaxed/simple;
	bh=GKsFzih+l6AdtxQDZ4mFgNwA1R7L87B1aNnQT2MDg7Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qhA+FjozTDidriVQyKhitAE6NG5hoDboQv2W+QNPlCQ9/r7o+wuml4/j6xe80VPE9dhqMLUidexVuPWt4aMNkgEPWKFrK0YAUUZ2NKlQiny6+x2dT5VGtqOLay0bSyPjtUtesJ8bOzoydKGBZTCa+gDuU+pPot1hUN9UTFK5m9E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=YlUfEUYR; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=B4Q80ktE; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=YlUfEUYR; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=B4Q80ktE; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 5DB0821137;
	Fri, 13 Dec 2024 22:20:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1734128418; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=WydU/QQar/N9B7tlfpvzCBpnM6HuAvTIztO6LfvbG4k=;
	b=YlUfEUYR3aXte9qAeNQtPswuPAXz7lOMhVHNjFJ2q9BD3lM6zLet9OFsM9l2mtyjz6Yl4D
	gxoGHxkQ1Bemc1q7Q1N04H9L49ABH2/mebjL7iIiM3tKlsJYc4hWDLrW6v2pUkOesStnIs
	zxTQCayM3tNm/bb3ycJqplxnYpY40xA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1734128418;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=WydU/QQar/N9B7tlfpvzCBpnM6HuAvTIztO6LfvbG4k=;
	b=B4Q80ktEBGYZQRaqdcj1YpX0fEbGth4IYjdzo5syh8wRYN0DKYmtvz32vMFlqcbOxNcADf
	18xCG0Xgaro0iwBA==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1734128418; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=WydU/QQar/N9B7tlfpvzCBpnM6HuAvTIztO6LfvbG4k=;
	b=YlUfEUYR3aXte9qAeNQtPswuPAXz7lOMhVHNjFJ2q9BD3lM6zLet9OFsM9l2mtyjz6Yl4D
	gxoGHxkQ1Bemc1q7Q1N04H9L49ABH2/mebjL7iIiM3tKlsJYc4hWDLrW6v2pUkOesStnIs
	zxTQCayM3tNm/bb3ycJqplxnYpY40xA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1734128418;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=WydU/QQar/N9B7tlfpvzCBpnM6HuAvTIztO6LfvbG4k=;
	b=B4Q80ktEBGYZQRaqdcj1YpX0fEbGth4IYjdzo5syh8wRYN0DKYmtvz32vMFlqcbOxNcADf
	18xCG0Xgaro0iwBA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 31BD313AD6;
	Fri, 13 Dec 2024 22:20:18 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id qOQ6CyKzXGf5QQAAD6G6ig
	(envelope-from <pvorel@suse.cz>); Fri, 13 Dec 2024 22:20:18 +0000
From: Petr Vorel <pvorel@suse.cz>
To: ltp@lists.linux.it
Cc: Petr Vorel <pvorel@suse.cz>,
	Mimi Zohar <zohar@linux.ibm.com>,
	linux-integrity@vger.kernel.org
Subject: [PATCH v2 4/8] ima_setup: Print warning when policy not readable
Date: Fri, 13 Dec 2024 23:20:10 +0100
Message-ID: <20241213222014.1580991-5-pvorel@suse.cz>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241213222014.1580991-1-pvorel@suse.cz>
References: <20241213222014.1580991-1-pvorel@suse.cz>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Level: 
X-Spamd-Result: default: False [-6.80 / 50.00];
	REPLY(-4.00)[];
	BAYES_HAM(-3.00)[99.99%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_TLS_ALL(0.00)[]
X-Spam-Score: -6.80
X-Spam-Flag: NO

check_ima_policy_content() now prints TINFO message when policy is not
readable and it does not return 1 in this case. Therefore
"'func=KEXEC_KERNEL_CHECK' appraise policy loaded, kernel image may not
be signed" TWARN message in ima_kexec.sh is not printed when policy is
not readable.

This is better because in previous case test always failed due TWARN but
result is actually unknown (e.g. don't expect missing policy, return 1
as failure only when policy is readable and checking with grep failed).

Fixes: 3843e2d6fb ("IMA: Add policy related helpers")
Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
 testcases/kernel/security/integrity/ima/tests/ima_setup.sh | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/testcases/kernel/security/integrity/ima/tests/ima_setup.sh b/testcases/kernel/security/integrity/ima/tests/ima_setup.sh
index cf769ac751..e958dd3334 100644
--- a/testcases/kernel/security/integrity/ima/tests/ima_setup.sh
+++ b/testcases/kernel/security/integrity/ima/tests/ima_setup.sh
@@ -94,8 +94,11 @@ check_ima_policy_content()
 	local pattern="$1"
 	local grep_params="${2--q}"
 
-	check_policy_readable || return 1
-	grep $grep_params "$pattern" $IMA_POLICY
+	if check_policy_readable; then
+		grep $grep_params "$pattern" $IMA_POLICY
+	else
+		tst_res TINFO "WARNING: policy not readable, can't check policy for '$pattern' (possible false positives)"
+	fi
 }
 
 require_ima_policy_content()
-- 
2.47.1


