Return-Path: <linux-integrity+bounces-8351-lists+linux-integrity=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-integrity@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OHTUGlUIemkK2AEAu9opvQ
	(envelope-from <linux-integrity+bounces-8351-lists+linux-integrity=lfdr.de@vger.kernel.org>)
	for <lists+linux-integrity@lfdr.de>; Wed, 28 Jan 2026 14:00:05 +0100
X-Original-To: lists+linux-integrity@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C5376A1B8D
	for <lists+linux-integrity@lfdr.de>; Wed, 28 Jan 2026 14:00:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id B0C77304B5F3
	for <lists+linux-integrity@lfdr.de>; Wed, 28 Jan 2026 12:59:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91069353EEC;
	Wed, 28 Jan 2026 12:59:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="3IZ79f0L";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="3RMdmFDx";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="yT6N/Twy";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="7k7MQHIR"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D50E1352935
	for <linux-integrity@vger.kernel.org>; Wed, 28 Jan 2026 12:59:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769605145; cv=none; b=TCePCL//fAGiey+8HJ7aMVsnIJOC2hcVRdg2TaLfJrlmNgOr2/zUJwZ64QcdW3KOI9nJ6U/8kt+Ud4m2pd7MXxu6LkaGthw9ijlfNG/cWS5hMlBQZVSnnljyff7HhmZZwMlIWC4cbQZhFHuhu0WWS9JTKoSNBRhcqi9wR6c/cCg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769605145; c=relaxed/simple;
	bh=wiBAtSb4bnMjtw0y2xH3RBnSgFH3mrT80zEJHTmfqEw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=O8CKbERSiE3O+Cs42qKT6kaMwoKAsh1fxFlHhasJDrb3YoLhh65LYiZcgczpNN9qzKMOGMNlQgpKdOimON4w/LZrHsMHCAjpOjvxv1qvR+44iBa77s2J023zo3L2S6mveLGKDBE/0A/EJA4thV5crVdiLbSkUhKLggw/wcZNDDM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=3IZ79f0L; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=3RMdmFDx; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=yT6N/Twy; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=7k7MQHIR; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 8B3A033BEA;
	Wed, 28 Jan 2026 12:58:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1769605140; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=UspdA0A08w4otm7D1cndDmOsbCC3uMdiAcTOIUW1tpk=;
	b=3IZ79f0L6oJRG5Th0PZLduMMgYBsKSZmwj64PoYyXc+adHGr7sjmd0EZwYHA+tnJsseDyb
	FbF8woU54XU1/xuR690kZURIobHFo1GM1Zgc94Y0MpiIhLtP1x4E/SpRlqcqV1qKO9My6A
	6YGKKVF8byKn3joLFx+iVGtBoq4VBEA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1769605140;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=UspdA0A08w4otm7D1cndDmOsbCC3uMdiAcTOIUW1tpk=;
	b=3RMdmFDxsKScUKqDSBGDj4SWXmwe1svURvl4vYH7cARXFJ+uVsjqiOGqGtCN3kJeuIZrP+
	tJvalz0AtmbQaxDg==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b="yT6N/Twy";
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=7k7MQHIR
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1769605139; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=UspdA0A08w4otm7D1cndDmOsbCC3uMdiAcTOIUW1tpk=;
	b=yT6N/TwytGzRrknNKMO7CCddMEQhGesqmhgL37TQxy+i3EBQUT5TUv8lOkkrgpC83F0lKO
	tkphlNHi5YjBJmGAV2jhEVSFupeiI6xO4hD3Qu7nVPSxpQ/5NwAqTIwPVTMvJI+7L26PxP
	/cDTGWZUqSYaD8+evGIGzqIsMeso0po=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1769605139;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=UspdA0A08w4otm7D1cndDmOsbCC3uMdiAcTOIUW1tpk=;
	b=7k7MQHIRVqrl/v/4aHN72zjuDRV6rkOwT2dCDUWYfUYtiWd4dqf7b8YrpqIvW6yZ7OWrei
	0UFFlntuucdhZuBw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 0F1B73EA61;
	Wed, 28 Jan 2026 12:58:59 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id LNb2ARMIemkNJQAAD6G6ig
	(envelope-from <pvorel@suse.cz>); Wed, 28 Jan 2026 12:58:59 +0000
From: Petr Vorel <pvorel@suse.cz>
To: ltp@lists.linux.it
Cc: Petr Vorel <pvorel@suse.cz>,
	Mimi Zohar <zohar@linux.ibm.com>,
	linux-integrity@vger.kernel.org,
	Li Wang <liwang@redhat.com>,
	Cyril Hrubis <chrubis@suse.cz>
Subject: [PATCH] ima_setup.sh: Fix signed policy requirement check
Date: Wed, 28 Jan 2026 13:58:52 +0100
Message-ID: <20260128125852.37411-1-pvorel@suse.cz>
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
X-Spam-Level: 
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DMARC_NA(0.00)[suse.cz];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-8351-lists,linux-integrity=lfdr.de];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pvorel@suse.cz,linux-integrity@vger.kernel.org];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_FIVE(0.00)[6];
	DKIM_TRACE(0.00)[suse.cz:+];
	TAGGED_RCPT(0.00)[linux-integrity];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,ima_policy.sh:url,ima_conditionals.sh:url]
X-Rspamd-Queue-Id: C5376A1B8D
X-Rspamd-Action: no action

tst_require_kconfigs() quits testing with tst_brk TCONF, but that first
hides the explanation in ima_conditionals.sh (which also calls tst_brk
TCONF) but also quits testing in ima_policy.sh (which calls tst_res
TCONF). Therefore use tst_check_kconfigs binary instead.

Fixes: c38b528783 ("ima_{conditionals, policy}: Handle policy required to be signed")
Reported-by: Mimi Zohar <zohar@linux.ibm.com>
Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
FYI Fix needed before the release.

 testcases/kernel/security/integrity/ima/tests/ima_setup.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/testcases/kernel/security/integrity/ima/tests/ima_setup.sh b/testcases/kernel/security/integrity/ima/tests/ima_setup.sh
index df0b8d1532..b69d7c31d9 100644
--- a/testcases/kernel/security/integrity/ima/tests/ima_setup.sh
+++ b/testcases/kernel/security/integrity/ima/tests/ima_setup.sh
@@ -469,7 +469,7 @@ require_evmctl()
 # d958083a8f640 ("x86/ima: define arch_get_ima_policy() for x86") # v5.0
 check_need_signed_policy()
 {
-	tst_secureboot_enabled && tst_kvcmp -ge '6.5' && tst_require_kconfigs \
+	tst_secureboot_enabled && tst_kvcmp -ge '6.5' && tst_check_kconfigs \
 		'CONFIG_IMA_KEYRINGS_PERMIT_SIGNED_BY_BUILTIN_OR_SECONDARY,CONFIG_IMA_ARCH_POLICY'
 }
 
-- 
2.51.0


