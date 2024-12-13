Return-Path: <linux-integrity+bounces-4389-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D8F1D9F1903
	for <lists+linux-integrity@lfdr.de>; Fri, 13 Dec 2024 23:27:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B3815188F2FF
	for <lists+linux-integrity@lfdr.de>; Fri, 13 Dec 2024 22:27:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 481201A8F9C;
	Fri, 13 Dec 2024 22:20:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="I2KBoSRU";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="ezCxDRs3";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="ZqoDs/3M";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="6dIbI435"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42D871A8F8F
	for <linux-integrity@vger.kernel.org>; Fri, 13 Dec 2024 22:20:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734128423; cv=none; b=GDx+k1hAqByfgpw4oeRYkOdcAH9di77wPJarSVbtfbie7XD5z6Bss3GU3mF0cEx6WGbq9qopTRq2E0oUMj8iaT/b3Um5qzE3OkFtxSl89dXumih9wJZASJBUe/C+ixAzfgiZXHS0zrpmvBHwmprMiUrY3ZcikUNI1JD4hzj5hxY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734128423; c=relaxed/simple;
	bh=2j47SL2xdfmfoTQwUxRGq8LY9+6SOl/r/n+rmtThisE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QOlpzo+fCQ9X6hH2BMHxClrXO1wTw2m3Sb8VFZgrW/XPKrU4RWvMpTFRmiytfMSm3Nw/2nBFPlqPVXLTZ5KHHuzcmn/wHKP4cSNePxUe1Vh8GYTTfbzmOuBmIKZySX/n/PwY4E8TlIBFefTjyRfGQpPFbMItIPPTwDjDaU6Ior4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=I2KBoSRU; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=ezCxDRs3; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=ZqoDs/3M; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=6dIbI435; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 7D7C41F394;
	Fri, 13 Dec 2024 22:20:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1734128418; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=v8/U+Ch2bJ8t8VQWtTlo5ySV+zmxuP8YmkpK5rGFIEU=;
	b=I2KBoSRU3A28VjUmCtweUXPQtKD8kw3s0X3tYQQ7zRe00S8BhPIS/3o8PaoFN5k01vOzb1
	mjh2DIGsEPVq68/EDPmrV7M3mZowcBOOwQR61Yv7XuK+Whykqg0lBHL5AX8/U64EVrlRQC
	ag9KiVJ20njVVMunaRVCLNRJJ5G4jTA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1734128418;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=v8/U+Ch2bJ8t8VQWtTlo5ySV+zmxuP8YmkpK5rGFIEU=;
	b=ezCxDRs3P3b0AWXOUMfgCb4lTyOH2zV47vrUVUcS7U57vW65EoHPSY8mRNxVPP7h7PWBbr
	8YSYfynZeDFOVUAA==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1734128417; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=v8/U+Ch2bJ8t8VQWtTlo5ySV+zmxuP8YmkpK5rGFIEU=;
	b=ZqoDs/3MkizEcuKjrbV+FD2IPEzm5bBZiMEM2K8Mbr9vZ56oHSuFypN4uUNDrS20YSjM06
	mz6JYXT7OGUQY5Faj5rlulMDTQUQdeTsX7gfpSJTrJlv1yFBtShQPEM+EomRQlrwGh1hpV
	LMjzrzuHXvCltc5XvlMlW1G9xBwF8Nk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1734128417;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=v8/U+Ch2bJ8t8VQWtTlo5ySV+zmxuP8YmkpK5rGFIEU=;
	b=6dIbI435E4eXn3Z8DtuW0sc3j2wFUVG92zKEzzYx99HqTW+CT2bqu7bpPrwEnN8J19dwHN
	nB2vKfQMrn+3A0BQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 4D4B813939;
	Fri, 13 Dec 2024 22:20:17 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id CEUuESGzXGf5QQAAD6G6ig
	(envelope-from <pvorel@suse.cz>); Fri, 13 Dec 2024 22:20:17 +0000
From: Petr Vorel <pvorel@suse.cz>
To: ltp@lists.linux.it
Cc: Petr Vorel <pvorel@suse.cz>,
	Mimi Zohar <zohar@linux.ibm.com>,
	linux-integrity@vger.kernel.org
Subject: [PATCH v2 1/8] IMA: Add TCB policy as an example for ima_measurements.sh
Date: Fri, 13 Dec 2024 23:20:07 +0100
Message-ID: <20241213222014.1580991-2-pvorel@suse.cz>
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
X-Spam-Score: -6.80
X-Spamd-Result: default: False [-6.80 / 50.00];
	REPLY(-4.00)[];
	BAYES_HAM(-3.00)[100.00%];
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
X-Spam-Flag: NO
X-Spam-Level: 

Taken from IMA docs [1], removed dont_measure fsmagic=0x1021994 (tmpfs)
as suggested by Mimi.

[1] https://ima-doc.readthedocs.io/en/latest/ima-policy.html#ima-tcb

Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
I would like to check in ima_measurements.sh for this policy as an
variant to ima_policy=tcb command line parameter. Do I need to check for
all of these (suppose all are in ima_policy=tcb).

 .../ima/datafiles/ima_measurements/tcb.policy | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)
 create mode 100644 testcases/kernel/security/integrity/ima/datafiles/ima_measurements/tcb.policy

diff --git a/testcases/kernel/security/integrity/ima/datafiles/ima_measurements/tcb.policy b/testcases/kernel/security/integrity/ima/datafiles/ima_measurements/tcb.policy
new file mode 100644
index 0000000000..1c919f7260
--- /dev/null
+++ b/testcases/kernel/security/integrity/ima/datafiles/ima_measurements/tcb.policy
@@ -0,0 +1,19 @@
+dont_measure fsmagic=0x9fa0
+dont_measure fsmagic=0x62656572
+dont_measure fsmagic=0x64626720
+dont_measure fsmagic=0x1cd1
+dont_measure fsmagic=0x42494e4d
+dont_measure fsmagic=0x73636673
+dont_measure fsmagic=0xf97cff8c
+dont_measure fsmagic=0x43415d53
+dont_measure fsmagic=0x27e0eb
+dont_measure fsmagic=0x63677270
+dont_measure fsmagic=0x6e736673
+dont_measure fsmagic=0xde5e81e4
+measure func=MMAP_CHECK mask=MAY_EXEC
+measure func=BPRM_CHECK mask=MAY_EXEC
+measure func=FILE_CHECK mask=^MAY_READ euid=0
+measure func=FILE_CHECK mask=^MAY_READ uid=0
+measure func=MODULE_CHECK
+measure func=FIRMWARE_CHECK
+measure func=POLICY_CHECK
-- 
2.47.1


