Return-Path: <linux-integrity+bounces-4388-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 90E269F1900
	for <lists+linux-integrity@lfdr.de>; Fri, 13 Dec 2024 23:27:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 32D7A188F096
	for <lists+linux-integrity@lfdr.de>; Fri, 13 Dec 2024 22:27:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10A3E1A8F98;
	Fri, 13 Dec 2024 22:20:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="OsyGGQhM";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="Q7nrjrxi";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="OsyGGQhM";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="Q7nrjrxi"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFFAD1A8F9C
	for <linux-integrity@vger.kernel.org>; Fri, 13 Dec 2024 22:20:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734128423; cv=none; b=aVvVmpE3D3g+UnpuMCDm/9U0v1HnRsNYAbo9F/CsquG2wd38GfpdByK3NNxjZ/vIKcv6JKcwvEY/239pzPuuytuY7+vbMdzbusPxaNfNsHQ9XnRC73O1AhBdDD8WH26vauHfbUoZivy+OovNfI2pBn6aDjVWpXl64JNefAnLYn8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734128423; c=relaxed/simple;
	bh=HoMyYN5J2yL3cx0DpEEfmITCgnrPVSA+rXnLph4fguE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bpg5uHpVZmfvzkJPpWJq6IuvwHxPBvfoLQ9+SNxZw3xNTnIrtmiEhel6qhl+g6PjlJOx2+xOCSGLuKMsw4qO6V1+QVqwApmTdsJTobacKY/WiE8e93PHNbOPhonIBFtaHgYsN0cV+lGluwaS0hVHyuJJ8IyhxBpFmlzgNxDQlT0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=OsyGGQhM; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=Q7nrjrxi; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=OsyGGQhM; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=Q7nrjrxi; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 1B03021196;
	Fri, 13 Dec 2024 22:20:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1734128419; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+IACrbzar+q2gwbFX3a7IyWwyvw/T4otCMTSaJqhvFw=;
	b=OsyGGQhMyqzu69X//ITStD4ftphXU9WtyZZboywVLIhaNVWobxrDY0b+jpbIEcahuaeyXL
	6w6a/oJsegwpw88wTYMexL4eTS6hHhRaHkQ+xbdSJFm60uwQTDZ//cx1C5YRJQlZvA9oRV
	PBlq9fVZlpTDExYNyZXsksTCo7cq5VM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1734128419;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+IACrbzar+q2gwbFX3a7IyWwyvw/T4otCMTSaJqhvFw=;
	b=Q7nrjrxiAT2qFnFfuG44FVyuVGE/dNfqXF61AuK1pYqLOgANhKvxhMvPFLFxq9Gj1HDYMZ
	JKWs+F9KGOIRqAAQ==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1734128419; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+IACrbzar+q2gwbFX3a7IyWwyvw/T4otCMTSaJqhvFw=;
	b=OsyGGQhMyqzu69X//ITStD4ftphXU9WtyZZboywVLIhaNVWobxrDY0b+jpbIEcahuaeyXL
	6w6a/oJsegwpw88wTYMexL4eTS6hHhRaHkQ+xbdSJFm60uwQTDZ//cx1C5YRJQlZvA9oRV
	PBlq9fVZlpTDExYNyZXsksTCo7cq5VM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1734128419;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+IACrbzar+q2gwbFX3a7IyWwyvw/T4otCMTSaJqhvFw=;
	b=Q7nrjrxiAT2qFnFfuG44FVyuVGE/dNfqXF61AuK1pYqLOgANhKvxhMvPFLFxq9Gj1HDYMZ
	JKWs+F9KGOIRqAAQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id E235C13939;
	Fri, 13 Dec 2024 22:20:18 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id GIpRNCKzXGf5QQAAD6G6ig
	(envelope-from <pvorel@suse.cz>); Fri, 13 Dec 2024 22:20:18 +0000
From: Petr Vorel <pvorel@suse.cz>
To: ltp@lists.linux.it
Cc: Petr Vorel <pvorel@suse.cz>,
	Mimi Zohar <zohar@linux.ibm.com>,
	linux-integrity@vger.kernel.org
Subject: [PATCH v2 7/8] ima_violations.sh: Check for a required policy
Date: Fri, 13 Dec 2024 23:20:13 +0100
Message-ID: <20241213222014.1580991-8-pvorel@suse.cz>
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

Add check for ^func=FILE_CHECK'

Signed-off-by: Petr Vorel <pvorel@suse.cz>

Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
 .../kernel/security/integrity/ima/tests/ima_violations.sh    | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/testcases/kernel/security/integrity/ima/tests/ima_violations.sh b/testcases/kernel/security/integrity/ima/tests/ima_violations.sh
index 0f710dea2e..73b9fe6f30 100755
--- a/testcases/kernel/security/integrity/ima/tests/ima_violations.sh
+++ b/testcases/kernel/security/integrity/ima/tests/ima_violations.sh
@@ -1,7 +1,7 @@
 #!/bin/sh
 # SPDX-License-Identifier: GPL-2.0-or-later
 # Copyright (c) 2009 IBM Corporation
-# Copyright (c) 2018-2020 Petr Vorel <pvorel@suse.cz>
+# Copyright (c) 2018-2024 Petr Vorel <pvorel@suse.cz>
 # Author: Mimi Zohar <zohar@linux.ibm.com>
 #
 # Test whether ToMToU and open_writer violations invalidatethe PCR and are logged.
@@ -9,6 +9,7 @@
 TST_SETUP="setup"
 TST_CLEANUP="cleanup"
 TST_CNT=3
+REQUIRED_POLICY='^func=FILE_CHECK'
 
 setup()
 {
@@ -17,6 +18,8 @@ setup()
 	LOG="/var/log/messages"
 	PRINTK_RATE_LIMIT=
 
+	require_ima_policy_content_if_readable "$REQUIRED_POLICY"
+
 	if status_daemon auditd; then
 		LOG="/var/log/audit/audit.log"
 	elif tst_check_cmds sysctl; then
-- 
2.47.1


