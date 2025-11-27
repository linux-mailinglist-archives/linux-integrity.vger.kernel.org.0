Return-Path: <linux-integrity+bounces-7682-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id D706BC8D558
	for <lists+linux-integrity@lfdr.de>; Thu, 27 Nov 2025 09:26:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 4540E34B40D
	for <lists+linux-integrity@lfdr.de>; Thu, 27 Nov 2025 08:26:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 041193233FA;
	Thu, 27 Nov 2025 08:26:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="UBnDinFF";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="YwyXzHWG";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="t7DlTfMe";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="my395Ul5"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39DAC322C6D
	for <linux-integrity@vger.kernel.org>; Thu, 27 Nov 2025 08:26:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764232008; cv=none; b=UBHGxE74G7i8b54Bt6vgPPEuRf/LWbQjGlOMVDDmN8tET6avqxSJtokoKPpkUJ0us9ZHACPb/CNLhdH0ThnoOKAoZfZPp/q/z1pMPGJ5DIgc9jSwu9FEIWW9Ps3xbHn4HU50wrlpmx8VNzWzs7NYWHt1xnxyMVYmrnFqTZJOOS0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764232008; c=relaxed/simple;
	bh=e33A4caZiTtYkb+Vz1nPtf8OT7a2/eQmOZTpuNvDNxs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=IXs8NRMmEEud+V3n3tjyQ3hlmVu9vrZAlkrwhT6sQKKBSMQWFknJaEsnoC8LIoJVS7xT/LO2HXBNj/oKGyGH0+67qB4Oox4moTnppmf22eSuqomcogXF9QvuGDRgfPz84vH8U+P5Wc8g4mYZTzl3jtoypU3VpWDS9cqM30MSBUU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=UBnDinFF; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=YwyXzHWG; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=t7DlTfMe; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=my395Ul5; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 65A1433696;
	Thu, 27 Nov 2025 08:26:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1764232005; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=MRh597Uvyolcc0CW0Pb2hTRUtRPoMsb7Tfu6bhz2sTI=;
	b=UBnDinFFoYpVtYBgFpjzZB8guv496xZeByWyiI9xpZjzhpaarayDmqkdxlA/Hd/NnoV+lf
	vcSeUAfQg/HnPogHu5C/ZRFp1W9hKitijGiFj/S3wBvfeo7mxPrncuT6e2TCyLWrzK5tBQ
	rTn8Jy2V2xZffVDTK/t7jOgecQwN8lw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1764232005;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=MRh597Uvyolcc0CW0Pb2hTRUtRPoMsb7Tfu6bhz2sTI=;
	b=YwyXzHWGkBVosxl/ArJSWiyoL3gLZgOYwjQyjN/xPkK7X6pKm512y3T0bWLsyGKC9Vv2LB
	S5gY8LBMTsPuc7Bg==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=t7DlTfMe;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=my395Ul5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1764232004; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=MRh597Uvyolcc0CW0Pb2hTRUtRPoMsb7Tfu6bhz2sTI=;
	b=t7DlTfMeDnMJZkiROV8Z4PdvRosUSxJ06QUhFt5Uv1Gdxx5D092koY56G7UElAzl7cNv+9
	5B2eiGu0F2rxEqb3uwZYNbWIKYS4OyCxrpI1ByMYmIVPxe/5rtyi9moTLp2HqUSj/HTU0y
	VaVl7IBaq5tFe6z508fZhSEqKWl4TIo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1764232004;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=MRh597Uvyolcc0CW0Pb2hTRUtRPoMsb7Tfu6bhz2sTI=;
	b=my395Ul5BgZ5csAL3Ibctavzazk5TOMTCY1IJ6aGmFGPrk0zWmgswYx60pQ1eK6SSXLxLS
	LodR1J4bhKIqY5Ag==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id D32BA3EA63;
	Thu, 27 Nov 2025 08:26:43 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id UiO/MkMLKGmNJgAAD6G6ig
	(envelope-from <pvorel@suse.cz>); Thu, 27 Nov 2025 08:26:43 +0000
From: Petr Vorel <pvorel@suse.cz>
To: ltp@lists.linux.it
Cc: Petr Vorel <petr.vorel@gmail.com>,
	Mimi Zohar <zohar@linux.ibm.com>,
	linux-integrity@vger.kernel.org,
	selinux@vger.kernel.org,
	Cyril Hrubis <chrubis@suse.cz>,
	Jan Stancek <jstancek@redhat.com>,
	Li Wang <liwang@redhat.com>
Subject: [PATCH v3 0/4] tst_sudo.c, ima_{conditionals, measurements}.sh enhancements
Date: Thu, 27 Nov 2025 09:26:34 +0100
Message-ID: <20251127082638.224110-1-pvorel@suse.cz>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-1.51 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	TO_DN_SOME(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FREEMAIL_CC(0.00)[gmail.com,linux.ibm.com,vger.kernel.org,suse.cz,redhat.com];
	RCVD_TLS_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.cz:mid,suse.cz:dkim];
	TAGGED_RCPT(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	DKIM_TRACE(0.00)[suse.cz:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com]
X-Rspamd-Action: no action
X-Spam-Flag: NO
X-Spam-Score: -1.51
X-Spam-Level: 
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Queue-Id: 65A1433696

From: Petr Vorel <petr.vorel@gmail.com>

Changes v2->v3:
Rebased due conflict when 69b28f1f78 ("shell: Add support for runtime")
was merged.

Links to v2:
https://lore.kernel.org/ltp/20251121152111.10419-1-pvorel@suse.cz/
https://patchwork.ozlabs.org/project/ltp/list/?series=483104&state=*

Changes v1->v2:
Main change is implementing LTP binary tst_sudo.c as suggested by Jan
Stancek [1] instead of creating new user.

Links to v1:
https://lore.kernel.org/ltp/20251002083701.315334-1-pvorel@suse.cz/
https://patchwork.ozlabs.org/project/ltp/list/?series=476004&state=*

[1] https://lore.kernel.org/ltp/CAASaF6yjdrLLVnehESx1TjsrB_z48nmN_2i585GPfkG3Vvg15Q@mail.gmail.com/

Petr Vorel (4):
  shell: Add tst_sudo.c helper
  tst_test.sh: Add TST_USR_{G,U}ID variables
  ima_{conditionals,measurements}.sh: Use tst_sudo
  ima_conditionals.sh: Split test by request

 doc/users/setup_tests.rst                     |  4 +
 runtest/ima                                   |  5 +-
 .../integrity/ima/tests/ima_conditionals.sh   | 78 +++++++++++--------
 .../integrity/ima/tests/ima_measurements.sh   | 11 +--
 testcases/lib/.gitignore                      |  1 +
 testcases/lib/Makefile                        |  2 +-
 testcases/lib/tst_sudo.c                      | 51 ++++++++++++
 testcases/lib/tst_test.sh                     |  6 +-
 8 files changed, 115 insertions(+), 43 deletions(-)
 create mode 100644 testcases/lib/tst_sudo.c

-- 
2.51.0


