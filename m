Return-Path: <linux-integrity+bounces-4211-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E8409D9CAF
	for <lists+linux-integrity@lfdr.de>; Tue, 26 Nov 2024 18:38:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E6350283798
	for <lists+linux-integrity@lfdr.de>; Tue, 26 Nov 2024 17:38:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0B031DB95D;
	Tue, 26 Nov 2024 17:38:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="JQIKK73h";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="pVHJUYKJ";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="ExgUgwuu";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="yBM65ZHw"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB4831D5177
	for <linux-integrity@vger.kernel.org>; Tue, 26 Nov 2024 17:38:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732642716; cv=none; b=a+jcuAOBWNRKFdzdRtO94LrzZ05ehYKrIKs0aOhvd4Eycnv9w+w51JEFRqkXdUr2jJWA9PpL6ONz3Vd24A9802Jrh7As/t80X1HSH7JfxM5qxT6mj3uDi9ecIJBSH5DmYxDRBGLa2NJJ66HOmVsCcxYYf703YJHAHW1KN8R2oZo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732642716; c=relaxed/simple;
	bh=+mr5mtAcgEm6ms/dnecSHHHodfq3/SXHZsVJE+35qHo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=hcxgtLguq9Q45wrfaF9JskdDCIixfFC88KGJ/00BkKmen/Byy1SH9aX3E2PcFB2Muk3S0rv5udu9UeVRxGx76xsEoG420O3p//Rm98wGxGvhlEVIIQ2HE5v6omjChWOdpTtlM3LH/cEbMSCnINnFQyphSZbIxLOTaTAMbhqGqNc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=JQIKK73h; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=pVHJUYKJ; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=ExgUgwuu; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=yBM65ZHw; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id E83321F74D;
	Tue, 26 Nov 2024 17:38:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1732642713; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=fx6DRM8qIUzT8avrFzQ2pTwHoO30bEvRwWkQP/XWKrE=;
	b=JQIKK73hLP4QT8cbgvvvE04fmJVniSDF37wuBHOIZrmFoTswkiaZrW6OPJjMnI+7hJHFC3
	GpFmKcO2wnuLwTDP2YBUfOtTnQFzAUsKLJ2BG6PH136+4yI6VFxmLKACLP26nRg8bNJH7q
	DMx0QHZHzVHyJRehKFB5T57HMQ9YBdg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1732642713;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=fx6DRM8qIUzT8avrFzQ2pTwHoO30bEvRwWkQP/XWKrE=;
	b=pVHJUYKJvnuwJTRU6x9VWFSxufNCkH7m7maOdru1PNq0ASRkFHMvVFHaF17eKh2w+61V1/
	ng21h39mQUMrpWBg==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1732642712; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=fx6DRM8qIUzT8avrFzQ2pTwHoO30bEvRwWkQP/XWKrE=;
	b=ExgUgwuuuII29GFMzdZO0R6UJq449K5lqA6Y/s56l9palfKh6RFHFUTaj18M7Nwy3R1R31
	VEGLi3xXotU4vPruKZzVF+QpLDpzwChQT/doDKxM+KIp1vUfzzqqm/YQrdfUMkAIv6FTLA
	p0MOlYyv6TEJGT447W3uwb0fkVh4g8U=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1732642712;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=fx6DRM8qIUzT8avrFzQ2pTwHoO30bEvRwWkQP/XWKrE=;
	b=yBM65ZHwD6AuVnTXZu7k2GK822INQ4kDsH74A53Q9vAPYDZH3AaRW9C0A8jQ2aGGFuKspL
	wAFeyH4AEm1+FxCA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id C2E6C13890;
	Tue, 26 Nov 2024 17:38:32 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 5A4/LpgHRmf2OAAAD6G6ig
	(envelope-from <pvorel@suse.cz>); Tue, 26 Nov 2024 17:38:32 +0000
From: Petr Vorel <pvorel@suse.cz>
To: ltp@lists.linux.it
Cc: Petr Vorel <petr.vorel@gmail.com>,
	Mimi Zohar <zohar@linux.ibm.com>,
	linux-integrity@vger.kernel.org
Subject: [PATCH 0/3] LTP tests: load predefined policy
Date: Tue, 26 Nov 2024 18:38:27 +0100
Message-ID: <20241126173830.98960-1-pvorel@suse.cz>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Level: 
X-Spamd-Result: default: False [-1.30 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.cz:mid];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[];
	ARC_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[gmail.com,linux.ibm.com,vger.kernel.org];
	RCVD_TLS_ALL(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCPT_COUNT_THREE(0.00)[4];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FREEMAIL_ENVRCPT(0.00)[gmail.com]
X-Spam-Score: -1.30
X-Spam-Flag: NO

From: Petr Vorel <petr.vorel@gmail.com>

Hi Mimi, all,

this effort allows to load policy LTP provides as example
via LTP_IMA_LOAD_POLICY=1 environment variable (off by default).

This should allow better coverage for these who just run runtest/ima.
But it requires tooling which runs LTP to do the restart after each
test.

Kind regards,
Petr

Petr Vorel (3):
  ima: Add TCB policy as an example
  ima_setup.sh: Allow to load predefined policy
  ima_{kexec,keys,selinux}: Set minimal kernel version

 .../kernel/security/integrity/ima/README.md   |  6 +++
 .../ima/datafiles/ima_measurements/tcb.policy | 20 +++++++
 .../security/integrity/ima/tests/ima_kexec.sh |  1 +
 .../security/integrity/ima/tests/ima_keys.sh  |  1 +
 .../integrity/ima/tests/ima_measurements.sh   | 17 +++++-
 .../integrity/ima/tests/ima_selinux.sh        |  1 +
 .../security/integrity/ima/tests/ima_setup.sh | 52 ++++++++++++++++---
 7 files changed, 89 insertions(+), 9 deletions(-)
 create mode 100644 testcases/kernel/security/integrity/ima/datafiles/ima_measurements/tcb.policy

-- 
2.45.2


