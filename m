Return-Path: <linux-integrity+bounces-4548-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2EA8AA10561
	for <lists+linux-integrity@lfdr.de>; Tue, 14 Jan 2025 12:29:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3DA1A1677ED
	for <lists+linux-integrity@lfdr.de>; Tue, 14 Jan 2025 11:29:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4EC5124025B;
	Tue, 14 Jan 2025 11:29:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="2MgnJVZ3";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="C4AOhQ3J";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="2MgnJVZ3";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="C4AOhQ3J"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91227224B07
	for <linux-integrity@vger.kernel.org>; Tue, 14 Jan 2025 11:29:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736854169; cv=none; b=cQDsWsaFU2BHxkEAsjUBdwj2jTKtYvvDNrYiN3joNs9U3657vsJsv+hsdfRuf1kGIIRyD02PBoGuanhi2RCdM+rWNbUaLRrwg8Hx0QwUWJ2cM/AWn9mnSg8UpApC/rEwtYSyYxkStbx1rqcMY6evfWBMWtVhIe3H2/lwyKTlo5M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736854169; c=relaxed/simple;
	bh=+ayin8Bpi891FlWLcawQ+2XO0N0cUnmTzoVlLuaj9dU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ut7qqMvKn8qmbd7iRNfxW9a6U1w87Az4DR2GlgG5NO1X1ucmpVC+5+kcZiTUY5nGrKCXmSrocOTkajWcKChA6RToiVT8aloSBmcfIP6gybJPbMy/KLwetWxitfhASJkpNsFJ9rIS4jO2F7VVxsdDgMvPQSVJ5/tKALS+UIilE/w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=2MgnJVZ3; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=C4AOhQ3J; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=2MgnJVZ3; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=C4AOhQ3J; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id E91C91F444;
	Tue, 14 Jan 2025 11:29:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1736854165; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=bzAZdL6SpzR9L3j+WjgIxlFgcFnJ7UNJPMzET7xpXyk=;
	b=2MgnJVZ3NiqHPpaJ6jv3OISxTipYEl8Z5y+/mok+CAW8N6b06vyT3u6rOlQUO5t8Rypokn
	bGRXWLreIzdarS1dOLGDfwtQEwAy0tfVIh8PDWaxj8aEWkbpBpewpBIFQxn1DKuz/2A5Nb
	qtZFKWglZccCQCDOIaig1b5Zo8ePQfA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1736854165;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=bzAZdL6SpzR9L3j+WjgIxlFgcFnJ7UNJPMzET7xpXyk=;
	b=C4AOhQ3JywhXBHE+cVoFNKZaYzn7zfTxjrj0ZizrktGV6joTpiSRXJP0TIkndd2U1a3NsB
	CnI7pM6p1PVofDDA==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1736854165; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=bzAZdL6SpzR9L3j+WjgIxlFgcFnJ7UNJPMzET7xpXyk=;
	b=2MgnJVZ3NiqHPpaJ6jv3OISxTipYEl8Z5y+/mok+CAW8N6b06vyT3u6rOlQUO5t8Rypokn
	bGRXWLreIzdarS1dOLGDfwtQEwAy0tfVIh8PDWaxj8aEWkbpBpewpBIFQxn1DKuz/2A5Nb
	qtZFKWglZccCQCDOIaig1b5Zo8ePQfA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1736854165;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=bzAZdL6SpzR9L3j+WjgIxlFgcFnJ7UNJPMzET7xpXyk=;
	b=C4AOhQ3JywhXBHE+cVoFNKZaYzn7zfTxjrj0ZizrktGV6joTpiSRXJP0TIkndd2U1a3NsB
	CnI7pM6p1PVofDDA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id AB8D613A86;
	Tue, 14 Jan 2025 11:29:25 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id YGWyKJVKhmeMIAAAD6G6ig
	(envelope-from <pvorel@suse.cz>); Tue, 14 Jan 2025 11:29:25 +0000
From: Petr Vorel <pvorel@suse.cz>
To: ltp@lists.linux.it
Cc: Petr Vorel <pvorel@suse.cz>,
	Mimi Zohar <zohar@linux.ibm.com>,
	linux-integrity@vger.kernel.org
Subject: [PATCH v3 10/10] tst_test.sh: IMA: Allow to disable LSM warnings and use it for IMA
Date: Tue, 14 Jan 2025 12:29:15 +0100
Message-ID: <20250114112915.610297-11-pvorel@suse.cz>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250114112915.610297-1-pvorel@suse.cz>
References: <20250114112915.610297-1-pvorel@suse.cz>
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
	BAYES_HAM(-3.00)[100.00%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-0.999];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_HAS_DN(0.00)[];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	R_RATELIMIT(0.00)[to_ip_from(RLqxawhspxxs4naamnp9m5ipny)];
	TO_DN_SOME(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:email,suse.cz:mid];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FROM_EQ_ENVFROM(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RCPT_COUNT_THREE(0.00)[4];
	RCVD_TLS_ALL(0.00)[]
X-Spam-Score: -6.80
X-Spam-Flag: NO

Suggested-by: Mimi Zohar <zohar@linux.ibm.com>
Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
 testcases/kernel/security/integrity/ima/tests/ima_setup.sh | 1 +
 testcases/lib/tst_test.sh                                  | 4 ++--
 2 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/testcases/kernel/security/integrity/ima/tests/ima_setup.sh b/testcases/kernel/security/integrity/ima/tests/ima_setup.sh
index 5213763ee0..69ee5a3d65 100644
--- a/testcases/kernel/security/integrity/ima/tests/ima_setup.sh
+++ b/testcases/kernel/security/integrity/ima/tests/ima_setup.sh
@@ -11,6 +11,7 @@ TST_CLEANUP_CALLER="$TST_CLEANUP"
 TST_CLEANUP="ima_cleanup"
 TST_NEEDS_ROOT=1
 TST_MOUNT_DEVICE=1
+TST_SKIP_LSM_WARNINGS=1
 
 # TST_MOUNT_DEVICE can be unset, therefore specify explicitly
 TST_NEEDS_TMPDIR=1
diff --git a/testcases/lib/tst_test.sh b/testcases/lib/tst_test.sh
index cfdae02300..2b797705e3 100644
--- a/testcases/lib/tst_test.sh
+++ b/testcases/lib/tst_test.sh
@@ -1,6 +1,6 @@
 #!/bin/sh
 # SPDX-License-Identifier: GPL-2.0-or-later
-# Copyright (c) Linux Test Project, 2014-2022
+# Copyright (c) Linux Test Project, 2014-2025
 # Author: Cyril Hrubis <chrubis@suse.cz>
 #
 # LTP test library for shell.
@@ -81,7 +81,7 @@ _tst_do_exit()
 	fi
 
 	if [ $TST_BROK -gt 0 -o $TST_FAIL -gt 0 -o $TST_WARN -gt 0 ]; then
-		_tst_check_security_modules
+		[ -z "$TST_SKIP_LSM_WARNINGS" ] && _tst_check_security_modules
 	fi
 
 	cat >&2 << EOF
-- 
2.47.1


