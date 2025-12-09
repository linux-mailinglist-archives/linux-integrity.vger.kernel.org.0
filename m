Return-Path: <linux-integrity+bounces-7883-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 21206CB0E16
	for <lists+linux-integrity@lfdr.de>; Tue, 09 Dec 2025 19:56:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id C09C73018ECF
	for <lists+linux-integrity@lfdr.de>; Tue,  9 Dec 2025 18:56:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83D63303C81;
	Tue,  9 Dec 2025 18:56:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="RM+k6U33";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="++IE5Z/k";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="S/G0eneY";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="4Iu5UMnX"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EB11303A04
	for <linux-integrity@vger.kernel.org>; Tue,  9 Dec 2025 18:56:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765306574; cv=none; b=G1fcf0lL74bJUj9brZsn1DgOdvnvhEQF8RIeNKTprEidYFyuxidoKhqyvK8j+3+7PB+AKomOwbmRqnwPJLwplyuo9QjtGM9xIv0miaV8Gp6o3dn4o/BJnx7wqUw9ohhCgp/XOQrL9V7as53yEPh9hENB6pBQ6i3XHYxJReSEdjk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765306574; c=relaxed/simple;
	bh=sbjHm2eHVcfi0XPl6DW7vBAB/IQncwHMQGXAgmQW8aM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=qaIHnC1lkyqYrW1oN+2iYG2q+bFEIAd0o+GLju8gZxt49Br4wL87C70RTe1DwRzxEp9bv0x3ZnnSMQiyMLxcc6ylo8sfR4D7RyalyL1E35xdIj0JHruD9A2JfWcI33ipkAnC9l75MiCTzEJsPctQfRzaQB4xCp8fEQAoae1hphE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=RM+k6U33; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=++IE5Z/k; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=S/G0eneY; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=4Iu5UMnX; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 5FEEA337D2;
	Tue,  9 Dec 2025 18:56:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1765306562; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=UbIiy/SdTMvK5EYrsBSznOLZxuEtmtnvL1HuRjCemA4=;
	b=RM+k6U33UoH+miMtU+D+5q8EoqLQyICXbk7XQLQKf6YwYBc59fqyrjcmxGl9W4VwtCj1rs
	6VmXViOWF5NLTR30/jBS/jRzICCNFiL0iaiQF/tbg92TmP26he1ODshT0Rgs0wQGu5T/fW
	tCvR4LXabI3FbzvZqVpw1cSYmnK2+sM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1765306562;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=UbIiy/SdTMvK5EYrsBSznOLZxuEtmtnvL1HuRjCemA4=;
	b=++IE5Z/kpM+kPlUt+CuS51aXKTZURVbeWF5M7mVw4LKmXQDiidocDW2LAHESYuxd3MGAEx
	UuxWQ5YfS5wLDdBA==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b="S/G0eneY";
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=4Iu5UMnX
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1765306561; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=UbIiy/SdTMvK5EYrsBSznOLZxuEtmtnvL1HuRjCemA4=;
	b=S/G0eneYRlsZvvanOlTaPD1hVxYkgttp1uz++bSxphbRl9W4FVftOFbpPFmJFEzZNOEbzQ
	yfWN/Cr0Sty+a6qZs/+eDQyhzMxA70mvThshKJOhdC920yDcaoYJYE0AYU+W48W9QHOaEl
	5nU/8ZiF5Ehgf10candKv7Qnhg2fWIw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1765306561;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=UbIiy/SdTMvK5EYrsBSznOLZxuEtmtnvL1HuRjCemA4=;
	b=4Iu5UMnXR/o4nd7p8x6zgX8GUiYuGylsSZVrdxDriZLmCImThLyAedt+1PQOhOLchZLt7i
	qiMHasShqEpISSDw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 09BDA3EA63;
	Tue,  9 Dec 2025 18:56:01 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id gavLAMFwOGnSSAAAD6G6ig
	(envelope-from <pvorel@suse.cz>); Tue, 09 Dec 2025 18:56:01 +0000
From: Petr Vorel <pvorel@suse.cz>
To: ltp@lists.linux.it
Cc: Petr Vorel <pvorel@suse.cz>,
	Mimi Zohar <zohar@linux.ibm.com>,
	linux-integrity@vger.kernel.org,
	selinux@vger.kernel.org,
	Cyril Hrubis <chrubis@suse.cz>,
	Jan Stancek <jstancek@redhat.com>,
	Li Wang <liwang@redhat.com>
Subject: [PATCH v4 0/4] tst_runas.c, ima_{conditionals, measurements}.sh enhancements
Date: Tue,  9 Dec 2025 19:55:53 +0100
Message-ID: <20251209185557.20598-1-pvorel@suse.cz>
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
X-Rspamd-Queue-Id: 5FEEA337D2
X-Spamd-Result: default: False [-3.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,suse.cz:dkim,suse.cz:mid];
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
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Level: 

v3->v4:
Rename tst_sudo.c => tst_runas.c (Li, Cyril)

Link to v3:
https://lore.kernel.org/ltp/20251127082638.224110-1-pvorel@suse.cz/T/#t
https://patchwork.ozlabs.org/project/ltp/list/?series=483681&state=*

Kind regards,
Petr

Petr Vorel (4):
  shell: Add tst_runas.c helper
  tst_test.sh: Add TST_USR_{G,U}ID variables
  ima_{conditionals,measurements}.sh: Use tst_runas
  ima_conditionals.sh: Split test by request

 doc/users/setup_tests.rst                     |  4 +
 runtest/ima                                   |  5 +-
 .../integrity/ima/tests/ima_conditionals.sh   | 78 +++++++++++--------
 .../integrity/ima/tests/ima_measurements.sh   | 11 +--
 testcases/lib/.gitignore                      |  1 +
 testcases/lib/Makefile                        |  2 +-
 testcases/lib/tst_runas.c                     | 51 ++++++++++++
 testcases/lib/tst_test.sh                     |  6 +-
 8 files changed, 115 insertions(+), 43 deletions(-)
 create mode 100644 testcases/lib/tst_runas.c

-- 
2.51.0


