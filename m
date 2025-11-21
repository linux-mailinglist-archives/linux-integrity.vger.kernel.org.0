Return-Path: <linux-integrity+bounces-7654-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0087AC7A894
	for <lists+linux-integrity@lfdr.de>; Fri, 21 Nov 2025 16:26:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2F29C3A4DFB
	for <lists+linux-integrity@lfdr.de>; Fri, 21 Nov 2025 15:21:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 470182C08C4;
	Fri, 21 Nov 2025 15:21:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="u6eNCcne";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="gmUO7tNz";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="u6eNCcne";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="gmUO7tNz"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A82651F09AC
	for <linux-integrity@vger.kernel.org>; Fri, 21 Nov 2025 15:21:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763738479; cv=none; b=lQWdRvPcMEc6boe0663LT8fe4iDGwYPh/Soa9spuqY4KvkdOY05itw+/+m2YqmpyOoWrXX7zzkqae7eOVspMG9/0RaoaV72DxpofBJkRTEfO0UbQVFyJrNhGI47Knu21E46CEA6hfWq/ruJHlx+wv5SfekAJFK3/BbdT19MoMZw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763738479; c=relaxed/simple;
	bh=MAOidNui5VAYqhgmkyrHFFXqluwc01w57GqY97f64Fk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=l+8C5iYsubzfzXsdAFMCpnPTw1ENIzVTnwdnhH0xYSIGOcFgQ/xk7pT+WOsGNUNL2GaKkyYesQ5VqaZGVLK/4RTM3pLj9A5O3CEdqcC5R2G6o03onWMYbMudwK4I2DVld6Ylz9u4J7Sl59Mv6a3KUU8EEaNGoe47WrMH9HNjRLY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=u6eNCcne; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=gmUO7tNz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=u6eNCcne; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=gmUO7tNz; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 7A5622109C;
	Fri, 21 Nov 2025 15:21:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1763738474; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=MBlEWYwUDZM3H9sd/N+Uho15xgfBa1GHhJwIlVU/Yt8=;
	b=u6eNCcnerIDWtvUq+Tk8JxPvmUEIkqoqo/7FtTGBpqsVIiMcdxlhBUKZ0hM8tBBRKYlfXF
	BXaWyvaF1MUrOMXJCVbEvwHibZqsQQHSyibQYVoJ6HiZWr6fzgrX0Ee8ua8au9Fd/UpE/k
	KhATSUwGL/Rgnq9UTtRyzgGdw/7BuQs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1763738474;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=MBlEWYwUDZM3H9sd/N+Uho15xgfBa1GHhJwIlVU/Yt8=;
	b=gmUO7tNzVJqHGrhjAF9mFWJJw6/mShJa34cP1YQhUssFARKsxNLITZATqNqR4ez9NArJyM
	fOXxB3IwsAMg5EDw==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=u6eNCcne;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=gmUO7tNz
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1763738474; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=MBlEWYwUDZM3H9sd/N+Uho15xgfBa1GHhJwIlVU/Yt8=;
	b=u6eNCcnerIDWtvUq+Tk8JxPvmUEIkqoqo/7FtTGBpqsVIiMcdxlhBUKZ0hM8tBBRKYlfXF
	BXaWyvaF1MUrOMXJCVbEvwHibZqsQQHSyibQYVoJ6HiZWr6fzgrX0Ee8ua8au9Fd/UpE/k
	KhATSUwGL/Rgnq9UTtRyzgGdw/7BuQs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1763738474;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=MBlEWYwUDZM3H9sd/N+Uho15xgfBa1GHhJwIlVU/Yt8=;
	b=gmUO7tNzVJqHGrhjAF9mFWJJw6/mShJa34cP1YQhUssFARKsxNLITZATqNqR4ez9NArJyM
	fOXxB3IwsAMg5EDw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 3D6E53EA61;
	Fri, 21 Nov 2025 15:21:14 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id g+EVDmqDIGndSQAAD6G6ig
	(envelope-from <pvorel@suse.cz>); Fri, 21 Nov 2025 15:21:14 +0000
From: Petr Vorel <pvorel@suse.cz>
To: ltp@lists.linux.it
Cc: Petr Vorel <pvorel@suse.cz>,
	Mimi Zohar <zohar@linux.ibm.com>,
	linux-integrity@vger.kernel.org,
	selinux@vger.kernel.org,
	Cyril Hrubis <chrubis@suse.cz>,
	Jan Stancek <jstancek@redhat.com>,
	Li Wang <liwang@redhat.com>
Subject: [PATCH v2 0/4] tst_sudo.c, ima_{conditionals,measurements}.sh enhancements
Date: Fri, 21 Nov 2025 16:21:07 +0100
Message-ID: <20251121152111.10419-1-pvorel@suse.cz>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 7A5622109C
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-3.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	MIME_TRACE(0.00)[0:+];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	ARC_NA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.cz:mid,suse.cz:dkim];
	RCPT_COUNT_SEVEN(0.00)[8];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_TRACE(0.00)[suse.cz:+];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RCVD_TLS_ALL(0.00)[]
X-Rspamd-Action: no action
X-Spam-Flag: NO
X-Spam-Score: -3.01
X-Spam-Level: 

Hi,

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


