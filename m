Return-Path: <linux-integrity+bounces-7684-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id D450AC8D560
	for <lists+linux-integrity@lfdr.de>; Thu, 27 Nov 2025 09:27:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 4C03234B355
	for <lists+linux-integrity@lfdr.de>; Thu, 27 Nov 2025 08:27:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E23D31E0E6;
	Thu, 27 Nov 2025 08:26:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="VktAw7xU";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="R/Yn4sCq";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="ldIeNu+C";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="xel3wyNO"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3BAA316909
	for <linux-integrity@vger.kernel.org>; Thu, 27 Nov 2025 08:26:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764232015; cv=none; b=Rs0Cxr1x5m2uOhbH002xBKInoJ7tKygew7ZaG4GuYPPFC9OjdmztL/RMTgl1S15pEB2MeAFpBLd+tlP+/0tgPKOZHk3SZSPI8qyxZReOwn5hhtwgZBL+q23hmzDRQt4rgGOEeByOPX7/m/i9jYddaX/YwhjeY4nZvl3l+p/Ssc4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764232015; c=relaxed/simple;
	bh=rNOyV5qOlU9HQJW7ohflc1P2Mu6f9YZbx/2cNnr5Sa8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uKYl3Lyb2RN7D7S7QGVgJhUkOdos9zZ5SEhdxfE3j6qsaz6ArPBNTO+wvJerUintKiNB3CqxzygJKHuNa3PI4Hn1XRgUXvoGw/SKejkDaE627HaCZSgU2qzqY5HXJJt2sFec3JlWggHN5oNURjLb9LEI0SE7iJ0yZvp/6tOi0SA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=VktAw7xU; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=R/Yn4sCq; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=ldIeNu+C; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=xel3wyNO; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id E16055BCCC;
	Thu, 27 Nov 2025 08:26:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1764232005; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=m+Q4h01pOwT/SuGvCKHCL7aml1Q5v7LKgKOgHkDeg4o=;
	b=VktAw7xURAmKP2EjFTaTCCWYwAKtggoQ+31sh0BQv16A6f6+oWabLuAI56wTyJwpEiFER4
	Vxzas99NcfeRg/0oOP0YQknKlrfp/0jU7gM6GZ07Q4OMEWfLLvMxWQQEDHXZhUyZbz4abh
	qqi0inD4R4pt9c64828ZEeHd5+hxWcM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1764232005;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=m+Q4h01pOwT/SuGvCKHCL7aml1Q5v7LKgKOgHkDeg4o=;
	b=R/Yn4sCq2Y/Kqg3qjA2b2Sf4nbyJ75tWkSUGa2vsP6z5gIR/bUlWA66UauovvcnHi6HxJj
	hSPXX+4b/BdDjjDA==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=ldIeNu+C;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=xel3wyNO
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1764232004; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=m+Q4h01pOwT/SuGvCKHCL7aml1Q5v7LKgKOgHkDeg4o=;
	b=ldIeNu+CyWoKJqRavSt6buq9Qhcy9A5E5vc/JUUPGpBa1qO3Qv5PGgpA7Uf7D1g5Rt95OV
	FU4CY7nwWid+FN1lANUtLPzelNKA11fH2QH6sCTUXL2GAbhZrlP+LwA7h/N9sXyeG5sHyo
	r6KIIpECnW+WjVCvC6IIyZSp4iBLH34=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1764232004;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=m+Q4h01pOwT/SuGvCKHCL7aml1Q5v7LKgKOgHkDeg4o=;
	b=xel3wyNOIk+MMXJ6todwq9VEJYdBstty+d3wq6J5BJiPBh2DMkMqSFbgGPOF5VO5MEzXpR
	Ij9ngLYl/0ztzZCA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id B52573EA66;
	Thu, 27 Nov 2025 08:26:44 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id UFJzK0QLKGmNJgAAD6G6ig
	(envelope-from <pvorel@suse.cz>); Thu, 27 Nov 2025 08:26:44 +0000
From: Petr Vorel <pvorel@suse.cz>
To: ltp@lists.linux.it
Cc: Petr Vorel <pvorel@suse.cz>,
	Mimi Zohar <zohar@linux.ibm.com>,
	linux-integrity@vger.kernel.org,
	selinux@vger.kernel.org,
	Cyril Hrubis <chrubis@suse.cz>,
	Jan Stancek <jstancek@redhat.com>,
	Li Wang <liwang@redhat.com>
Subject: [PATCH v3 2/4] tst_test.sh: Add TST_USR_{G,U}ID variables
Date: Thu, 27 Nov 2025 09:26:36 +0100
Message-ID: <20251127082638.224110-3-pvorel@suse.cz>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251127082638.224110-1-pvorel@suse.cz>
References: <20251127082638.224110-1-pvorel@suse.cz>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-3.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.cz:mid,suse.cz:email,suse.cz:dkim];
	ARC_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCPT_COUNT_SEVEN(0.00)[8];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	RCVD_TLS_ALL(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	DKIM_TRACE(0.00)[suse.cz:+]
X-Rspamd-Action: no action
X-Spam-Flag: NO
X-Spam-Score: -3.01
X-Spam-Level: 
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Queue-Id: E16055BCCC

Add TST_USR_{G,U}ID variables with the default values from tst_sudo.c.

These can be used as a default values for tests which use tst_sudo and
need to know UID/GID for other commands.

It will be used in LTP IMA tests.

Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
 testcases/lib/tst_sudo.c  | 1 +
 testcases/lib/tst_test.sh | 6 +++++-
 2 files changed, 6 insertions(+), 1 deletion(-)

diff --git a/testcases/lib/tst_sudo.c b/testcases/lib/tst_sudo.c
index e8d5d8dd9d..e937828273 100644
--- a/testcases/lib/tst_sudo.c
+++ b/testcases/lib/tst_sudo.c
@@ -3,6 +3,7 @@
  * Copyright (c) 2025 Petr Vorel <pvorel@suse.cz>
  */
 
+/* update also tst_test.sh */
 #define LTP_USR_UID 65534
 #define LTP_USR_GID 65534
 
diff --git a/testcases/lib/tst_test.sh b/testcases/lib/tst_test.sh
index 4be10a4f94..49f282d7c8 100644
--- a/testcases/lib/tst_test.sh
+++ b/testcases/lib/tst_test.sh
@@ -17,6 +17,10 @@ export TST_ITERATIONS=1
 export TST_TMPDIR_RHOST=0
 export TST_LIB_LOADED=1
 
+# see testcases/lib/tst_sudo.c
+export TST_USR_UID="${LTP_USR_UID:-65534}"
+export TST_USR_GID="${LTP_USR_GID:-65534}"
+
 . tst_ansi_color.sh
 . tst_security.sh
 
@@ -689,7 +693,7 @@ tst_run()
 			CHECKPOINT_WAKE2|CHECKPOINT_WAKE_AND_WAIT);;
 			DEV_EXTRA_OPTS|DEV_FS_OPTS|FORMAT_DEVICE|MOUNT_DEVICE);;
 			SKIP_FILESYSTEMS|SKIP_IN_LOCKDOWN|SKIP_IN_SECUREBOOT);;
-			DEVICE_SIZE);;
+			DEVICE_SIZE|USR_UID|USR_GID);;
 			*) tst_res TWARN "Reserved variable TST_$_tst_i used!";;
 			esac
 		done
-- 
2.51.0


