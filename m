Return-Path: <linux-integrity+bounces-4383-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C698B9F18FD
	for <lists+linux-integrity@lfdr.de>; Fri, 13 Dec 2024 23:27:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1A756188F29E
	for <lists+linux-integrity@lfdr.de>; Fri, 13 Dec 2024 22:26:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A3991A7060;
	Fri, 13 Dec 2024 22:20:22 +0000 (UTC)
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 473141A8F97
	for <linux-integrity@vger.kernel.org>; Fri, 13 Dec 2024 22:20:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734128422; cv=none; b=GqUAY8klIK5dPCBg8CFU+a71CF80v0BwO+ETKqSZVolzAVYmtxH9Jqqa+VS0SxfJ4xruopK4gqbfGciuVqgkZ63ZhyOeTyk1cikSXGiBqlD8ofYJc5M5N5XWv3srTE41RAEUQ3z341uHXZ9WkIYIXJGyso2J65YdCuZM4kTvtm8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734128422; c=relaxed/simple;
	bh=Bv7zPhNapWqzQFrQYGGqk8hVQOXOiKWw3WlUonaG0KE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aL+PuhL/mAn6QUvUjVz9q1CL7qI2x7ookYHoCVq1bxj/cQKqGByBXHE3pry+XZVQ5SQL8JDDlIShWXngXTJSoNp7X78qmSdKDa2Vpb4HRZQuAmlW0iNlMiadEH6r64Hxx0ExoNle4o+9yBYufMX5nxQsD7qdi01kR6F901ZH4pc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 931722117F;
	Fri, 13 Dec 2024 22:20:18 +0000 (UTC)
Authentication-Results: smtp-out1.suse.de;
	none
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 5FCED13AD7;
	Fri, 13 Dec 2024 22:20:18 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 4N1EFiKzXGf5QQAAD6G6ig
	(envelope-from <pvorel@suse.cz>); Fri, 13 Dec 2024 22:20:18 +0000
From: Petr Vorel <pvorel@suse.cz>
To: ltp@lists.linux.it
Cc: Petr Vorel <pvorel@suse.cz>,
	Mimi Zohar <zohar@linux.ibm.com>,
	linux-integrity@vger.kernel.org
Subject: [PATCH v2 5/8] ima_kexec.sh: Move checking policy if readable to ima_setup.sh
Date: Fri, 13 Dec 2024 23:20:11 +0100
Message-ID: <20241213222014.1580991-6-pvorel@suse.cz>
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
X-Rspamd-Pre-Result: action=no action;
	module=replies;
	Message is reply to one we originated
X-Spam-Level: 
X-Spamd-Result: default: False [-4.00 / 50.00];
	REPLY(-4.00)[];
	ASN(0.00)[asn:25478, ipnet:::/0, country:RU]
X-Spam-Score: -4.00
X-Spam-Flag: NO
X-Rspamd-Queue-Id: 931722117F
X-Rspamd-Pre-Result: action=no action;
	module=replies;
	Message is reply to one we originated
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org

It will be reused.

Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
 .../kernel/security/integrity/ima/tests/ima_kexec.sh   |  8 ++------
 .../kernel/security/integrity/ima/tests/ima_setup.sh   | 10 ++++++++++
 2 files changed, 12 insertions(+), 6 deletions(-)

diff --git a/testcases/kernel/security/integrity/ima/tests/ima_kexec.sh b/testcases/kernel/security/integrity/ima/tests/ima_kexec.sh
index 3446bc24bf..df8658655d 100755
--- a/testcases/kernel/security/integrity/ima/tests/ima_kexec.sh
+++ b/testcases/kernel/security/integrity/ima/tests/ima_kexec.sh
@@ -47,10 +47,7 @@ setup()
 		tst_brk TCONF "kernel image not found, specify path in \$IMA_KEXEC_IMAGE"
 	fi
 
-	if check_policy_readable; then
-		require_ima_policy_content "$REQUIRED_POLICY"
-		policy_readable=1
-	fi
+	require_ima_policy_content_if_readable "$REQUIRED_POLICY"
 }
 
 kexec_failure_hint()
@@ -97,8 +94,7 @@ kexec_test()
 
 	ROD kexec -su
 	if ! measure "$cmdline"; then
-		if [ "$policy_readable" != 1 ]; then
-			tst_res TWARN "policy not readable, it might not contain required policy '$REQUIRED_POLICY'"
+		if ! check_policy_readable; then
 			res=TBROK
 		fi
 		tst_brk $res "unable to find a correct measurement"
diff --git a/testcases/kernel/security/integrity/ima/tests/ima_setup.sh b/testcases/kernel/security/integrity/ima/tests/ima_setup.sh
index e958dd3334..9a05a31c31 100644
--- a/testcases/kernel/security/integrity/ima/tests/ima_setup.sh
+++ b/testcases/kernel/security/integrity/ima/tests/ima_setup.sh
@@ -101,6 +101,16 @@ check_ima_policy_content()
 	fi
 }
 
+require_ima_policy_content_if_readable()
+{
+	local pattern="$1"
+	local grep_params="${2--q}"
+
+	if ! check_ima_policy_content "$pattern" "$grep_params"; then
+		tst_brk TCONF "IMA policy does not specify '$pattern'"
+	fi
+}
+
 require_ima_policy_content()
 {
 	local pattern="$1"
-- 
2.47.1


