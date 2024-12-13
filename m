Return-Path: <linux-integrity+bounces-4384-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 753519F18FF
	for <lists+linux-integrity@lfdr.de>; Fri, 13 Dec 2024 23:27:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7B19A1622F0
	for <lists+linux-integrity@lfdr.de>; Fri, 13 Dec 2024 22:26:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8AA751EC4E8;
	Fri, 13 Dec 2024 22:20:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="zSeAm1gS";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="BlrtJPdO";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="xLgo2Ts8";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="TOwdJmI4"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45AAB1A8F96
	for <linux-integrity@vger.kernel.org>; Fri, 13 Dec 2024 22:20:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734128422; cv=none; b=e1uD2PpUPjHddIIU3TRmlEysBDq3xCN25cM2kvBjJF02NPdWXMo/kHjEa5mMfEydiVqJ1sa5X7OUd5AT9cKPhlTpmEHaMA138HRnPfLc7CjRm5XxLQIWok2vkuFGgCbLyvEgX5ez+88mApOOVfc6oOe9Ib5ex3IzGzME4YgAirg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734128422; c=relaxed/simple;
	bh=msLRW5OKnX8+Ai41Bi7APLjPLcZPX2UmhnvKby9K/ss=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=EijLGuFmQAnpNJVMXi/q8XFxYZKLlqIMjVfFjxSrhckvTlPPwqFPgJGI2rC5nD0LT0CorqqjTXP5H6oYLN2y50XV/k8+7AJ/ZmJCb0AztnCPTICeWwTktHznXzpeht4HOGMLGXJI35Cb4hde2pbmlh6r5fRmbwn62xcC/Riovy4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=zSeAm1gS; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=BlrtJPdO; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=xLgo2Ts8; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=TOwdJmI4; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 45B6F210F9;
	Fri, 13 Dec 2024 22:20:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1734128418; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=B0rBFqzhoReaaWOAr2v8CgoK1TbJdfJ+f/XaqZXqAoQ=;
	b=zSeAm1gSnu6xtMe/Fv8HVLgEEsxuVcRKrsdj3x4b2B3qt7+C0ppuBlm6ufZC01sUUqoAde
	T+1TkhK5n0rDLvJteMRnopxUj/2/nkNvQU9orINI3QN4l+s9OsPBUkyVAfqLLInL1BcIuT
	Xjd+P44yg9uWZlfMZxvG3wCFxzcyq1c=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1734128418;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=B0rBFqzhoReaaWOAr2v8CgoK1TbJdfJ+f/XaqZXqAoQ=;
	b=BlrtJPdOXYe9NWz6sVLoDCogyhSFF+okA3vnPkC6KmjacftTGBbhMrKNYTjlfTASio74kO
	qHkkMpNvnz/iAsBg==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1734128417; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=B0rBFqzhoReaaWOAr2v8CgoK1TbJdfJ+f/XaqZXqAoQ=;
	b=xLgo2Ts8SPY97EIGLBHmuMv9qNIl1XFzXLt5Re0KKJaR+p9Yi6XOKpzRjy71PYGD/hriv+
	Cvb6AyqSvGdkcyQY3EECGpyGLw4X66tQb3CLdDVmEzWQggCf64PCYEgVJ+q4cQPj+3/+fO
	xsPFF4QR+y4EjS2p/jYsIgQ7KEyKTo4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1734128417;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=B0rBFqzhoReaaWOAr2v8CgoK1TbJdfJ+f/XaqZXqAoQ=;
	b=TOwdJmI4EKGntD7INk4RdVuLk9/ZK9xqWUnqjwwoUzszFGvniRHeNMzJqAAWpeVAMbR4yl
	j82SgU1pi1IqC2Aw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 1E292137CF;
	Fri, 13 Dec 2024 22:20:17 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id OjoBBiGzXGf5QQAAD6G6ig
	(envelope-from <pvorel@suse.cz>); Fri, 13 Dec 2024 22:20:17 +0000
From: Petr Vorel <pvorel@suse.cz>
To: ltp@lists.linux.it
Cc: Petr Vorel <pvorel@suse.cz>,
	Mimi Zohar <zohar@linux.ibm.com>,
	linux-integrity@vger.kernel.org
Subject: [PATCH v2 0/8]	LTP tests: load predefined policy, enhancements
Date: Fri, 13 Dec 2024 23:20:06 +0100
Message-ID: <20241213222014.1580991-1-pvorel@suse.cz>
X-Mailer: git-send-email 2.47.1
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Score: -2.80
X-Spamd-Result: default: False [-2.80 / 50.00];
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
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo];
	RCVD_TLS_ALL(0.00)[]
X-Spam-Flag: NO
X-Spam-Level: 

Changes v1->v2:
* Removed ont_measure fsmagic=0x1021994 from TCB example policy
* More reasons to fail when uploading policy
  (testcases/kernel/security/integrity/ima/README.md)
* New commits:
  - tst_test.sh: IMA: Allow to disable LSM warnings and use it for IMA
  - ima_setup: Print warning when policy not readable
  - ima_kexec.sh: Move checking policy if readable to ima_setup.sh
  - IMA: Add example policy for ima_violations.sh
  - ima_violations.sh: Check for a required policy
  - [RFC] ima_kexec.sh: Relax result on unreadable policy to TCONF

TODO:
* ima_measurements.sh: check for example policy as an variant to
  ima_policy=tcb command line parameter.
* Use LTP shell loader for ima_boot_aggregate.c and ima_mmap.c


Petr Vorel (8):
  IMA: Add TCB policy as an example for ima_measurements.sh
  ima_setup.sh: Allow to load predefined policy
  tst_test.sh: IMA: Allow to disable LSM warnings and use it for IMA
  ima_setup: Print warning when policy not readable
  ima_kexec.sh: Move checking policy if readable to ima_setup.sh
  IMA: Add example policy for ima_violations.sh
  ima_violations.sh: Check for a required policy
  [RFC] ima_kexec.sh: Relax result on unreadable policy to TCONF

 .../kernel/security/integrity/ima/README.md   | 12 ++++
 .../ima/datafiles/ima_measurements/tcb.policy | 19 +++++
 .../ima_violations/violations.policy          |  1 +
 .../security/integrity/ima/tests/ima_kexec.sh | 10 +--
 .../integrity/ima/tests/ima_measurements.sh   | 17 ++++-
 .../security/integrity/ima/tests/ima_setup.sh | 72 ++++++++++++++++---
 .../integrity/ima/tests/ima_violations.sh     |  5 +-
 testcases/lib/tst_test.sh                     |  2 +-
 8 files changed, 118 insertions(+), 20 deletions(-)
 create mode 100644 testcases/kernel/security/integrity/ima/datafiles/ima_measurements/tcb.policy
 create mode 100644 testcases/kernel/security/integrity/ima/datafiles/ima_violations/violations.policy

-- 
2.47.1


