Return-Path: <linux-integrity+bounces-7059-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C5A8B543EE
	for <lists+linux-integrity@lfdr.de>; Fri, 12 Sep 2025 09:32:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DC9473A6CFC
	for <lists+linux-integrity@lfdr.de>; Fri, 12 Sep 2025 07:32:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73B38261393;
	Fri, 12 Sep 2025 07:32:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="DveJvBi9";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="HNG22Kxn";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="DveJvBi9";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="HNG22Kxn"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D69D02AD20
	for <linux-integrity@vger.kernel.org>; Fri, 12 Sep 2025 07:32:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757662344; cv=none; b=BSzrfdnWVuS5XdwuqmUufnAop9k9IVugcTeICE53UgoZtuuQkvqnoZHuB4qZ7OAm4n4brUDVGWZbfEv493LeP3oVpQoBmdefBdPKJMO6O8Nk4dUnpLRciHIRNkPoZXwEOKFzN9tYP+CCwtsvFywBjXDIHCRkLOFAWgLiExikIB8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757662344; c=relaxed/simple;
	bh=pfAianYre5G+5XGsSYZycxhkulMwtUOkNMnlOzj2mS4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tzI2+gqLZ88pGiRnFwzVJbigHimBXUMIMBKFkCbN5SNLNk63mW9Qcc8s0tNjKvKpZP6kDWllUqHCsh28V10wuLZ4dba08jJSga6EX8iCn4Xk0OubtH5wfu1w3D7KJ/0V6QLek4krYH3iz8WUNGGC9RweTXejIRoo+CpOvRUtyXQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=DveJvBi9; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=HNG22Kxn; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=DveJvBi9; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=HNG22Kxn; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 7DA773F149;
	Fri, 12 Sep 2025 07:32:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1757662333; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=PQQJofPKWK1hTVoqMkoMgenjkp1SZxtpExRPqxbyRDA=;
	b=DveJvBi9AUKzhGGB2Gvv2cnwIuQ1tV1TQc7SLXv3TSWjIHKbaghNgvIPgWnKSmONTC5qEa
	RIE9e189+4QdCqnTRB1ts3UoHmg6xc3we/MM0q3WZgKJhapjafMYeTf8OFtl42FOLzBWKn
	w5W9Wfj3HX6dho3rECLP4I0Pou10ti4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1757662333;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=PQQJofPKWK1hTVoqMkoMgenjkp1SZxtpExRPqxbyRDA=;
	b=HNG22KxntfUkMBRIAEj5NtT5GRz3CTieRlErrZjHx2NYXUvufkZtyago8/uo9+L+CQeIPE
	Myy9e9woYJKhokBg==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1757662333; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=PQQJofPKWK1hTVoqMkoMgenjkp1SZxtpExRPqxbyRDA=;
	b=DveJvBi9AUKzhGGB2Gvv2cnwIuQ1tV1TQc7SLXv3TSWjIHKbaghNgvIPgWnKSmONTC5qEa
	RIE9e189+4QdCqnTRB1ts3UoHmg6xc3we/MM0q3WZgKJhapjafMYeTf8OFtl42FOLzBWKn
	w5W9Wfj3HX6dho3rECLP4I0Pou10ti4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1757662333;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=PQQJofPKWK1hTVoqMkoMgenjkp1SZxtpExRPqxbyRDA=;
	b=HNG22KxntfUkMBRIAEj5NtT5GRz3CTieRlErrZjHx2NYXUvufkZtyago8/uo9+L+CQeIPE
	Myy9e9woYJKhokBg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 32CDA1398D;
	Fri, 12 Sep 2025 07:32:13 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id kOoQC33Mw2g7GgAAD6G6ig
	(envelope-from <pvorel@suse.cz>); Fri, 12 Sep 2025 07:32:13 +0000
From: Petr Vorel <pvorel@suse.cz>
To: ltp@lists.linux.it
Cc: Petr Vorel <pvorel@suse.cz>,
	Mimi Zohar <zohar@linux.ibm.com>,
	linux-integrity@vger.kernel.org,
	selinux@vger.kernel.org,
	Cyril Hrubis <chrubis@suse.cz>,
	Coiby Xu <coxu@redhat.com>
Subject: [PATCH 1/2] ima_policy.sh: Optimize check for policy writable
Date: Fri, 12 Sep 2025 09:32:08 +0200
Message-ID: <20250912073210.47637-2-pvorel@suse.cz>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250912073210.47637-1-pvorel@suse.cz>
References: <20250912073210.47637-1-pvorel@suse.cz>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-6.80 / 50.00];
	REPLY(-4.00)[];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-0.999];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_COUNT_TWO(0.00)[2];
	ARC_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:mid,suse.cz:email];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	TO_DN_SOME(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_TLS_ALL(0.00)[]
X-Spam-Flag: NO
X-Spam-Level: 
X-Spam-Score: -6.80

Previously policy was checked in setup and in all tests
(redundant in test1). It should be enough to test in setup and after
write in test1, but let's being careful and test before writing the
policy in load_policy().

Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
 .../kernel/security/integrity/ima/tests/ima_policy.sh      | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/testcases/kernel/security/integrity/ima/tests/ima_policy.sh b/testcases/kernel/security/integrity/ima/tests/ima_policy.sh
index af1fb0028c..1c4763d838 100755
--- a/testcases/kernel/security/integrity/ima/tests/ima_policy.sh
+++ b/testcases/kernel/security/integrity/ima/tests/ima_policy.sh
@@ -1,7 +1,7 @@
 #!/bin/sh
 # SPDX-License-Identifier: GPL-2.0-or-later
 # Copyright (c) 2009 IBM Corporation
-# Copyright (c) 2018-2020 Petr Vorel <pvorel@suse.cz>
+# Copyright (c) 2018-2025 Petr Vorel <pvorel@suse.cz>
 # Author: Mimi Zohar <zohar@linux.ibm.com>
 #
 # Test replacing the default integrity measurement policy.
@@ -11,8 +11,6 @@ TST_CNT=2
 
 setup()
 {
-	require_policy_writable
-
 	VALID_POLICY="$TST_DATAROOT/measure.policy"
 	[ -f $VALID_POLICY ] || tst_brk TCONF "missing $VALID_POLICY"
 
@@ -24,6 +22,7 @@ load_policy()
 {
 	local ret
 
+	require_policy_writable
 	exec 2>/dev/null 4>$IMA_POLICY
 	[ $? -eq 0 ] || exit 1
 
@@ -43,7 +42,6 @@ test1()
 
 	local p1
 
-	require_policy_writable
 	load_policy $INVALID_POLICY & p1=$!
 	wait "$p1"
 	if [ $? -ne 0 ]; then
@@ -59,7 +57,6 @@ test2()
 
 	local p1 p2 rc1 rc2
 
-	require_policy_writable
 	load_policy $VALID_POLICY & p1=$!
 	load_policy $VALID_POLICY & p2=$!
 	wait "$p1"; rc1=$?
-- 
2.51.0


