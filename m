Return-Path: <linux-integrity+bounces-7356-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 89CE3BB346D
	for <lists+linux-integrity@lfdr.de>; Thu, 02 Oct 2025 10:45:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0ACC418857F0
	for <lists+linux-integrity@lfdr.de>; Thu,  2 Oct 2025 08:43:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B34992FC022;
	Thu,  2 Oct 2025 08:37:11 +0000 (UTC)
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD9D12FBDE1
	for <linux-integrity@vger.kernel.org>; Thu,  2 Oct 2025 08:37:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759394231; cv=none; b=a1dl8Et76YDdyDlg+Jt8GLMyt+fjJw+87jOWwgh54kJK/mhYGkDFG1jRogHE8W/h3U0DB2CP3/EiQoHnV6wrkgwHcExtKwOR2a7AsuKaBY0k5TKeBDAtG8o4QC3tpNTQ0XmTs9/9N0KphlZmdIxE8KOG5t26H2MvRA8tuOMkJbM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759394231; c=relaxed/simple;
	bh=bprcWUjOsS3elGI+dc9bs9rHjfVOG2DLxVm6crNFSso=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mtOM/9NGCZBFkfwyDFuuxZWDnK5/eP93wUJod8b9CrvpVpk+Tqi8FQm+54V5Hc7UArVcSsMnz7+4dTuU6/8GcBLCDRaDnx9WrfzKYrlegwiTROviucQ3MhLcZCRMcWJomQqMnErVQKg+pmyngOnKMpm1QwavkH4lszjPI5Mp3c4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 142FC33812;
	Thu,  2 Oct 2025 08:37:06 +0000 (UTC)
Authentication-Results: smtp-out1.suse.de;
	none
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id B882E13990;
	Thu,  2 Oct 2025 08:37:05 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id iIKnKrE53miCWQAAD6G6ig
	(envelope-from <pvorel@suse.cz>); Thu, 02 Oct 2025 08:37:05 +0000
From: Petr Vorel <pvorel@suse.cz>
To: ltp@lists.linux.it
Cc: Petr Vorel <pvorel@suse.cz>,
	Mimi Zohar <zohar@linux.ibm.com>,
	linux-integrity@vger.kernel.org,
	Cyril Hrubis <chrubis@suse.cz>,
	Martin Doucha <mdoucha@suse.cz>
Subject: [PATCH 3/4] ima_conditionals.sh: Use 'sg' without 'sudo'
Date: Thu,  2 Oct 2025 10:37:00 +0200
Message-ID: <20251002083701.315334-4-pvorel@suse.cz>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251002083701.315334-1-pvorel@suse.cz>
References: <20251002083701.315334-1-pvorel@suse.cz>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Pre-Result: action=no action;
	module=replies;
	Message is reply to one we originated
X-Rspamd-Action: no action
X-Spam-Flag: NO
X-Spam-Level: 
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-4.00 / 50.00];
	REPLY(-4.00)[]
X-Rspamd-Queue-Id: 142FC33812
X-Rspamd-Pre-Result: action=no action;
	module=replies;
	Message is reply to one we originated
X-Spam-Score: -4.00

We run as root, therefore 'sg' can be run without 'sudo'.

Fixes: 5734da5f11 ("IMA: Add tests for uid, gid, fowner, and fgroup options")
Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
 .../kernel/security/integrity/ima/tests/ima_conditionals.sh     | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/testcases/kernel/security/integrity/ima/tests/ima_conditionals.sh b/testcases/kernel/security/integrity/ima/tests/ima_conditionals.sh
index afa2ae05da..f4ee79b2bc 100755
--- a/testcases/kernel/security/integrity/ima/tests/ima_conditionals.sh
+++ b/testcases/kernel/security/integrity/ima/tests/ima_conditionals.sh
@@ -81,7 +81,7 @@ test()
 		chown $IMA_USER $test_file
 		sh -c "$cmd"
 		;;
-	gid) sudo sg $IMA_USER "sh -c '$cmd'";;
+	gid) sg $IMA_USER "sh -c '$cmd'";;
 	uid) sudo -n -u $IMA_USER sh -c "$cmd";;
 	esac
 
-- 
2.51.0


