Return-Path: <linux-integrity+bounces-4547-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 964EAA10560
	for <lists+linux-integrity@lfdr.de>; Tue, 14 Jan 2025 12:29:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B3035167B1B
	for <lists+linux-integrity@lfdr.de>; Tue, 14 Jan 2025 11:29:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35218284A6B;
	Tue, 14 Jan 2025 11:29:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="e87wnBD0";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="n+Ey4BbV";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="e87wnBD0";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="n+Ey4BbV"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 788E1284A48
	for <linux-integrity@vger.kernel.org>; Tue, 14 Jan 2025 11:29:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736854169; cv=none; b=b1k1LhTlyWrZd/Hv6GWku/oXkvSiqJRSjgFQ2hJO+zrn5dPAAHkEcSgpXJhYOb8nc7yBoBiwPWBsgsqahCXkO08df/h7o+BWDF3eiB1rSjHI+2v1DhLAza9y1vMWbKW7kGfkfjRKibLFOaZT2tiESGqBfVKFzLGBErnU1QaWDJ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736854169; c=relaxed/simple;
	bh=VSpXkU5xVa9eqJVA9qotmIG+zbKOdFuw71zN01bCQEg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LQwNdkxHi0MQ9wL4kttkpfqJcSEf8Yz3vtkVxXGsxZcFFGK91pwnGF6ixOWgXIzIOTmlb5FZdDjCgKmwzOIQzK+dP+KojrZggpAp5oWPu4CX08K7MPmvJILv1yFIXNhb64hKcEnpzZke+IG2VvF2C3dQdGw4fZTXQdMj8nZ+zPU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=e87wnBD0; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=n+Ey4BbV; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=e87wnBD0; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=n+Ey4BbV; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id A08B71F441;
	Tue, 14 Jan 2025 11:29:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1736854165; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=wbSNLSUZ3waUTk6RAkd2Tl7h7KSHJSs2a5nCnCUFWqo=;
	b=e87wnBD069QGVRv73KQIsk4y3icyNsTJconDpXiPk/1ylsP3cH66XT6sameoHomuJ72CUq
	f1AI6d0KL1l42J+zaTNN8aJiERYwmwlBhquT5uIQMzHPuunvCIVSN6aPXB6b62LjrYtYP2
	7p8QG8pedBLYw64thcJnhjFwHK6Nqc8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1736854165;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=wbSNLSUZ3waUTk6RAkd2Tl7h7KSHJSs2a5nCnCUFWqo=;
	b=n+Ey4BbVP7wUzXHvXJypFgPOPL8zKUpnrxciYlIEIEsgWuVxkkL6Wf8xpSzFDe6aRiprn9
	yVL3iJ65xcdfRRAw==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1736854165; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=wbSNLSUZ3waUTk6RAkd2Tl7h7KSHJSs2a5nCnCUFWqo=;
	b=e87wnBD069QGVRv73KQIsk4y3icyNsTJconDpXiPk/1ylsP3cH66XT6sameoHomuJ72CUq
	f1AI6d0KL1l42J+zaTNN8aJiERYwmwlBhquT5uIQMzHPuunvCIVSN6aPXB6b62LjrYtYP2
	7p8QG8pedBLYw64thcJnhjFwHK6Nqc8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1736854165;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=wbSNLSUZ3waUTk6RAkd2Tl7h7KSHJSs2a5nCnCUFWqo=;
	b=n+Ey4BbVP7wUzXHvXJypFgPOPL8zKUpnrxciYlIEIEsgWuVxkkL6Wf8xpSzFDe6aRiprn9
	yVL3iJ65xcdfRRAw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 77FCD139CB;
	Tue, 14 Jan 2025 11:29:25 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id QDX7G5VKhmeMIAAAD6G6ig
	(envelope-from <pvorel@suse.cz>); Tue, 14 Jan 2025 11:29:25 +0000
From: Petr Vorel <pvorel@suse.cz>
To: ltp@lists.linux.it
Cc: Petr Vorel <pvorel@suse.cz>,
	Mimi Zohar <zohar@linux.ibm.com>,
	linux-integrity@vger.kernel.org
Subject: [PATCH v3 09/10] ima_measurements.sh: Check policy for test3
Date: Tue, 14 Jan 2025 12:29:14 +0100
Message-ID: <20250114112915.610297-10-pvorel@suse.cz>
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
X-Spam-Score: -6.80
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:mid,suse.cz:email];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FROM_EQ_ENVFROM(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RCPT_COUNT_THREE(0.00)[4];
	RCVD_TLS_ALL(0.00)[]
X-Spam-Flag: NO
X-Spam-Level: 

First two tests are working with ima_policy=tcb,
but 3rd test requires more specific policy.

Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
 .../kernel/security/integrity/ima/tests/ima_measurements.sh  | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/testcases/kernel/security/integrity/ima/tests/ima_measurements.sh b/testcases/kernel/security/integrity/ima/tests/ima_measurements.sh
index c42c31c898..35acc6ea78 100755
--- a/testcases/kernel/security/integrity/ima/tests/ima_measurements.sh
+++ b/testcases/kernel/security/integrity/ima/tests/ima_measurements.sh
@@ -77,6 +77,11 @@ test3()
 	tst_res TINFO "verify not measuring user files"
 	tst_check_cmds sudo || return
 
+	if [ "$IMA_POLICY_CHECKED" != 1 ]; then
+		tst_res TCONF "test requires specific policy, try load it with LTP_IMA_LOAD_POLICY=1"
+		return
+	fi
+
 	if ! id $user >/dev/null 2>/dev/null; then
 		tst_res TCONF "missing system user $user (wrong installation)"
 		return
-- 
2.47.1


