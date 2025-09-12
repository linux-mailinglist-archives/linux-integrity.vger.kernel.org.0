Return-Path: <linux-integrity+bounces-7058-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BB34DB543EC
	for <lists+linux-integrity@lfdr.de>; Fri, 12 Sep 2025 09:32:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6273E3A6EE5
	for <lists+linux-integrity@lfdr.de>; Fri, 12 Sep 2025 07:32:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A707C2AD20;
	Fri, 12 Sep 2025 07:32:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="ITpDUNSR";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="UeZ2JiDf";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="ITpDUNSR";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="UeZ2JiDf"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8394B2CCC5
	for <linux-integrity@vger.kernel.org>; Fri, 12 Sep 2025 07:32:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757662338; cv=none; b=FrmTthf86r3wFAUSUe+uu2Wvwz7nMV8tsQt38JQVUnGWPyEn4jaHNI7llvL3BtNeSwYFkQSW/i2Kqgytg0zvqmrr8Xw4D0m4Nq1JA7giTjpxvIS+H2IaPW5q3I0wQ1K7rLZ2i+i+YZ7uziMPsLDqzgUhhR8jw33Q7dpcZu2RwCM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757662338; c=relaxed/simple;
	bh=mVJNM8dHgAyM3oG5I+geCSFbDCnMCOthyfzNfi0vq3Y=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=rSzKadW93iRkJbr0+pvy2ZxXZ8fkLmyS6hYbdUXlrV5/6a5VK4Uiq8BqZi1nBE6B+xd3bxDexnzclnUtTyofJGDksqL4abGqichmKqMFPBEtT2RPctKIRcJfmy1xjZFhyIz3k2rV/1H8LBjHVV8gBoEDMqaV2e1sxcg8IvnL2vg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=ITpDUNSR; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=UeZ2JiDf; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=ITpDUNSR; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=UeZ2JiDf; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 2A9983F121;
	Fri, 12 Sep 2025 07:32:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1757662333; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=OveaFbmmCbW51d+hljl/KpbVsnuyOCv2Ca/ZyilCq1A=;
	b=ITpDUNSRMd4U4WIJXe5ll8DZt0+vfUAT2uocMpQLPjnF0Jm2PUAHJbiaTYeVivgGSgkIO3
	MjWVWCa0RuJLSyBKBEhHmu9v+NbEYei4mqMxaCbNTQk+xBg0wCSZ6p0+MIOvOfA42EkyWj
	43vqxDQpEwJUyxeQMsDz9oVPD2n6bBA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1757662333;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=OveaFbmmCbW51d+hljl/KpbVsnuyOCv2Ca/ZyilCq1A=;
	b=UeZ2JiDf6TqDjO+HEWHhQLFpf2vCI3+GxDRe2fzmVZ4mp/vv1Dpc+v5YL+7FyQms21APJv
	MOSt0enni6QGfPBA==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1757662333; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=OveaFbmmCbW51d+hljl/KpbVsnuyOCv2Ca/ZyilCq1A=;
	b=ITpDUNSRMd4U4WIJXe5ll8DZt0+vfUAT2uocMpQLPjnF0Jm2PUAHJbiaTYeVivgGSgkIO3
	MjWVWCa0RuJLSyBKBEhHmu9v+NbEYei4mqMxaCbNTQk+xBg0wCSZ6p0+MIOvOfA42EkyWj
	43vqxDQpEwJUyxeQMsDz9oVPD2n6bBA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1757662333;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=OveaFbmmCbW51d+hljl/KpbVsnuyOCv2Ca/ZyilCq1A=;
	b=UeZ2JiDf6TqDjO+HEWHhQLFpf2vCI3+GxDRe2fzmVZ4mp/vv1Dpc+v5YL+7FyQms21APJv
	MOSt0enni6QGfPBA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id DF951136DB;
	Fri, 12 Sep 2025 07:32:12 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id Jn/MNXzMw2g7GgAAD6G6ig
	(envelope-from <pvorel@suse.cz>); Fri, 12 Sep 2025 07:32:12 +0000
From: Petr Vorel <pvorel@suse.cz>
To: ltp@lists.linux.it
Cc: Petr Vorel <pvorel@suse.cz>,
	Mimi Zohar <zohar@linux.ibm.com>,
	linux-integrity@vger.kernel.org,
	selinux@vger.kernel.org,
	Cyril Hrubis <chrubis@suse.cz>,
	Coiby Xu <coxu@redhat.com>
Subject: [PATCH 0/2] LTP IMA pre-release fixes
Date: Fri, 12 Sep 2025 09:32:07 +0200
Message-ID: <20250912073210.47637-1-pvorel@suse.cz>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Level: 
X-Spamd-Result: default: False [-2.80 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-0.999];
	MIME_GOOD(-0.10)[text/plain];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	ARC_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:mid];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_ALL(0.00)[]
X-Spam-Flag: NO
X-Spam-Score: -2.80

Hi,

important is the second patch. It'd be good to merge it before upcoming
LTP release (1-2 weeks).

Kind regards,
Petr

Petr Vorel (2):
  ima_policy.sh: Optimize check for policy writable
  ima_{conditionals,policy}: Handle policy required to be signed

 .../security/integrity/ima/tests/ima_conditionals.sh | 11 ++++++++++-
 .../security/integrity/ima/tests/ima_policy.sh       | 12 ++++++------
 .../kernel/security/integrity/ima/tests/ima_setup.sh |  7 +++++++
 3 files changed, 23 insertions(+), 7 deletions(-)

-- 
2.51.0


