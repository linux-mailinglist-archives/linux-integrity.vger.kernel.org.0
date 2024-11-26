Return-Path: <linux-integrity+bounces-4212-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DF349D9CB0
	for <lists+linux-integrity@lfdr.de>; Tue, 26 Nov 2024 18:38:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5DD0916768F
	for <lists+linux-integrity@lfdr.de>; Tue, 26 Nov 2024 17:38:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C4E61DBB3A;
	Tue, 26 Nov 2024 17:38:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="vAlX49PK";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="5PkQNldE";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="vAlX49PK";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="5PkQNldE"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EBAB1DACB4
	for <linux-integrity@vger.kernel.org>; Tue, 26 Nov 2024 17:38:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732642717; cv=none; b=T4/dcYVffMooXx74uL6uDImtNkU0aqDc92eVIa+kfz/xUJZkYlgfCBx8oxvPF/CO8hIUP7F6onNUrEhAe+mSA/K+mD9KRkV0C+3En9ud5Rd+vhmbzhW2EYCwcWjrryLArCs9ZBrbWmpFQAe8NBdD/UHtjdE/Eacv9hte3IJp/5M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732642717; c=relaxed/simple;
	bh=vSja6F8EcgjJssXnwBf57gR/N1WqsSC4TR58nLHI0Ts=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FyVP8gUJKV3UvvHbamdhSX4bDN+0llqkniT2uzhQVuieAd+/GxhxqHBEztiaC6acIJJC5gfLnCR2ZtJiKo2jPzw9CapodGx5u5vA7UuFUTQaXbFDKfIHXS4Nh0nPb0gt0i6Bf0xdhfH7LGOCfQpXmasLYh7GYyxD35WylTen0g4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=vAlX49PK; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=5PkQNldE; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=vAlX49PK; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=5PkQNldE; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 8D2211F76B;
	Tue, 26 Nov 2024 17:38:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1732642713; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9jTWjmXCHuK6Ahz2oKzGpurmcrrhxSCvvi9Fa5ogJJw=;
	b=vAlX49PKhhJAOM2Dpdt+IE+REd9+dypYY4CsNQItLbAlKUPsSinCCkQ5exOioLQJmnNhqO
	CRG+jvZyUTvsH4qNhN6nrS1rKZLDt0waLAtXdXMw5xrdoGcZDXXHp/e7SUGM4uXCvT6rEO
	e76aA8jkVcy2iaybjdIq6tSOcYrdFw8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1732642713;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9jTWjmXCHuK6Ahz2oKzGpurmcrrhxSCvvi9Fa5ogJJw=;
	b=5PkQNldE4hVv3F8xzATk7lS15qWVbH+LZW73h/kLqwQ9Ch3Wdw/tspMiQgCtvBIp1w+3ng
	7lxMJ9hscnRm6GBg==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1732642713; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9jTWjmXCHuK6Ahz2oKzGpurmcrrhxSCvvi9Fa5ogJJw=;
	b=vAlX49PKhhJAOM2Dpdt+IE+REd9+dypYY4CsNQItLbAlKUPsSinCCkQ5exOioLQJmnNhqO
	CRG+jvZyUTvsH4qNhN6nrS1rKZLDt0waLAtXdXMw5xrdoGcZDXXHp/e7SUGM4uXCvT6rEO
	e76aA8jkVcy2iaybjdIq6tSOcYrdFw8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1732642713;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9jTWjmXCHuK6Ahz2oKzGpurmcrrhxSCvvi9Fa5ogJJw=;
	b=5PkQNldE4hVv3F8xzATk7lS15qWVbH+LZW73h/kLqwQ9Ch3Wdw/tspMiQgCtvBIp1w+3ng
	7lxMJ9hscnRm6GBg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 5F53613A27;
	Tue, 26 Nov 2024 17:38:33 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 4H8wFZkHRmf2OAAAD6G6ig
	(envelope-from <pvorel@suse.cz>); Tue, 26 Nov 2024 17:38:33 +0000
From: Petr Vorel <pvorel@suse.cz>
To: ltp@lists.linux.it
Cc: Petr Vorel <pvorel@suse.cz>,
	Mimi Zohar <zohar@linux.ibm.com>,
	linux-integrity@vger.kernel.org
Subject: [PATCH 3/3] ima_{kexec,keys,selinux}: Set minimal kernel version
Date: Tue, 26 Nov 2024 18:38:30 +0100
Message-ID: <20241126173830.98960-4-pvorel@suse.cz>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241126173830.98960-1-pvorel@suse.cz>
References: <20241126173830.98960-1-pvorel@suse.cz>
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
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:mid,suse.cz:email,imap1.dmz-prg2.suse.org:helo];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_TLS_ALL(0.00)[]
X-Spam-Flag: NO
X-Spam-Level: 

The functionality IMHO was not backported to the enterprise kernels.

This helps to avoid false positive in ima_kexec.sh:
ima_kexec 1 TWARN: policy not readable, it might not contain required
policy '^measure.*func=KEXEC_CMDLINE'
ima_kexec 1 TBROK: unable to find a correct measurement

Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
 testcases/kernel/security/integrity/ima/tests/ima_kexec.sh   | 1 +
 testcases/kernel/security/integrity/ima/tests/ima_keys.sh    | 1 +
 testcases/kernel/security/integrity/ima/tests/ima_selinux.sh | 1 +
 3 files changed, 3 insertions(+)

diff --git a/testcases/kernel/security/integrity/ima/tests/ima_kexec.sh b/testcases/kernel/security/integrity/ima/tests/ima_kexec.sh
index 62f05f5361..3446bc24bf 100755
--- a/testcases/kernel/security/integrity/ima/tests/ima_kexec.sh
+++ b/testcases/kernel/security/integrity/ima/tests/ima_kexec.sh
@@ -11,6 +11,7 @@
 TST_NEEDS_CMDS="grep kexec sed"
 TST_CNT=3
 TST_SETUP="setup"
+TST_MIN_KVER="5.3"
 
 IMA_KEXEC_IMAGE="${IMA_KEXEC_IMAGE:-/boot/vmlinuz-$(uname -r)}"
 REQUIRED_POLICY='^measure.*func=KEXEC_CMDLINE'
diff --git a/testcases/kernel/security/integrity/ima/tests/ima_keys.sh b/testcases/kernel/security/integrity/ima/tests/ima_keys.sh
index 793908d44a..ff32eb6c43 100755
--- a/testcases/kernel/security/integrity/ima/tests/ima_keys.sh
+++ b/testcases/kernel/security/integrity/ima/tests/ima_keys.sh
@@ -10,6 +10,7 @@ TST_NEEDS_CMDS="cmp cut grep sed"
 TST_CNT=2
 TST_SETUP=setup
 TST_CLEANUP=cleanup
+TST_MIN_KVER="5.6"
 
 FUNC_KEYCHECK='func=KEY_CHECK'
 REQUIRED_POLICY="^measure.*$FUNC_KEYCHECK"
diff --git a/testcases/kernel/security/integrity/ima/tests/ima_selinux.sh b/testcases/kernel/security/integrity/ima/tests/ima_selinux.sh
index f6e392822a..75f9ba84e4 100755
--- a/testcases/kernel/security/integrity/ima/tests/ima_selinux.sh
+++ b/testcases/kernel/security/integrity/ima/tests/ima_selinux.sh
@@ -12,6 +12,7 @@
 TST_NEEDS_CMDS="awk cut grep tail"
 TST_CNT=2
 TST_SETUP="setup"
+TST_MIN_KVER="5.12"
 
 FUNC_CRITICAL_DATA='func=CRITICAL_DATA'
 REQUIRED_POLICY="^measure.*$FUNC_CRITICAL_DATA"
-- 
2.45.2


