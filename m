Return-Path: <linux-integrity+bounces-4386-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F7D79F18FE
	for <lists+linux-integrity@lfdr.de>; Fri, 13 Dec 2024 23:27:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 236DF188F37C
	for <lists+linux-integrity@lfdr.de>; Fri, 13 Dec 2024 22:26:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD4011EE026;
	Fri, 13 Dec 2024 22:20:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="WsKHDXun";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="tUHW+Ko4";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="WsKHDXun";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="tUHW+Ko4"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8C171A4F21
	for <linux-integrity@vger.kernel.org>; Fri, 13 Dec 2024 22:20:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734128422; cv=none; b=QjsV/cUejWmkKeigqeA5WK+f7WLmbJjgLux2dCWvuNFE7rWuqgkuf4rkgveUsskY4tnUhqArXiQ4GOdolNs4TL5UUaOq+R+OIQkIRB1DmXzp/k1LiujN8TLYoHtLgfM3g5cqWdZOAYjnwQb+/OaZ9XSPgwexIpIN2LoBL8c3Z1Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734128422; c=relaxed/simple;
	bh=Wz++N/TqtM98ycWjqPsUw0VW1o7NwoXjXbp//v+3Dsc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=H9traOEjCMW5fVr36AlklttvYWbcK/vr96LgcR5UGlHFY4otS1K9E8x+Qg0hfGL05ZmfOVDxoE1gTZdTfvNdcsLobgn5Olfgdh6D72y89im24pVEbkTdsdLAVTfFrESPz2CIkeK7hU/YrN+TcG2LRuMhrcA6SckgPT6m0pMX/d8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=WsKHDXun; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=tUHW+Ko4; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=WsKHDXun; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=tUHW+Ko4; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id DC4801F46E;
	Fri, 13 Dec 2024 22:20:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1734128418; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=DGrabM/RTjYOWG32YCic41PKnBU/k6Nk5QL41lBHGqo=;
	b=WsKHDXunr0pGwiyfDdN0I4Ti56Hhc13TAIfOXhcdDYLqHVb51u9/zyIreO3tc2sa50BWJV
	sHRrDKZUoR72+rf0+gfID0jnXOLscrhpLMXphs1CoQZ2kSf2X/g6qeyL9MkCmzDp2SNaT5
	tg9pLvl0vYMWBVUDQSqf00IhtX1RH0c=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1734128418;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=DGrabM/RTjYOWG32YCic41PKnBU/k6Nk5QL41lBHGqo=;
	b=tUHW+Ko4a97J70ValSNk573aKzzga3AjwGdje4o0at3r9RwJYxnixb+xUcbt2UurTma68L
	MpXy0p4ANYDR1JAQ==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1734128418; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=DGrabM/RTjYOWG32YCic41PKnBU/k6Nk5QL41lBHGqo=;
	b=WsKHDXunr0pGwiyfDdN0I4Ti56Hhc13TAIfOXhcdDYLqHVb51u9/zyIreO3tc2sa50BWJV
	sHRrDKZUoR72+rf0+gfID0jnXOLscrhpLMXphs1CoQZ2kSf2X/g6qeyL9MkCmzDp2SNaT5
	tg9pLvl0vYMWBVUDQSqf00IhtX1RH0c=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1734128418;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=DGrabM/RTjYOWG32YCic41PKnBU/k6Nk5QL41lBHGqo=;
	b=tUHW+Ko4a97J70ValSNk573aKzzga3AjwGdje4o0at3r9RwJYxnixb+xUcbt2UurTma68L
	MpXy0p4ANYDR1JAQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 992F7137CF;
	Fri, 13 Dec 2024 22:20:18 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id WJp7IyKzXGf5QQAAD6G6ig
	(envelope-from <pvorel@suse.cz>); Fri, 13 Dec 2024 22:20:18 +0000
From: Petr Vorel <pvorel@suse.cz>
To: ltp@lists.linux.it
Cc: Petr Vorel <pvorel@suse.cz>,
	Mimi Zohar <zohar@linux.ibm.com>,
	linux-integrity@vger.kernel.org
Subject: [PATCH v2 6/8] IMA: Add example policy for ima_violations.sh
Date: Fri, 13 Dec 2024 23:20:12 +0100
Message-ID: <20241213222014.1580991-7-pvorel@suse.cz>
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
	BAYES_HAM(-3.00)[99.99%];
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

Suggested-by: Mimi Zohar <zohar@linux.ibm.com>
Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
 .../integrity/ima/datafiles/ima_violations/violations.policy     | 1 +
 1 file changed, 1 insertion(+)
 create mode 100644 testcases/kernel/security/integrity/ima/datafiles/ima_violations/violations.policy

diff --git a/testcases/kernel/security/integrity/ima/datafiles/ima_violations/violations.policy b/testcases/kernel/security/integrity/ima/datafiles/ima_violations/violations.policy
new file mode 100644
index 0000000000..5734c7617f
--- /dev/null
+++ b/testcases/kernel/security/integrity/ima/datafiles/ima_violations/violations.policy
@@ -0,0 +1 @@
+func=FILE_CHECK
-- 
2.47.1


