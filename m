Return-Path: <linux-integrity+bounces-8193-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F4B8CFEC4A
	for <lists+linux-integrity@lfdr.de>; Wed, 07 Jan 2026 17:04:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 336C630ABA8A
	for <lists+linux-integrity@lfdr.de>; Wed,  7 Jan 2026 15:57:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9B2238804E;
	Wed,  7 Jan 2026 15:57:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="x/oZaCg8";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="+3wgXU4F";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="x/oZaCg8";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="+3wgXU4F"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 935A138B985
	for <linux-integrity@vger.kernel.org>; Wed,  7 Jan 2026 15:57:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767801466; cv=none; b=CrvYBVv3xM7DW7YSJJtViM2HAYXP+cwbtvTd90CmQIP+pySr6xyVj35J6GFBq8k2RdSSOvVAOof08WHusRcA8AtyBckLZH0gk3KyNxOlf6DonNAeS03tg2XfH+BFKfazYMXwzxrZO3l+1Qw+A/+0qRiw1pzCYJuXmaFAgoA5NtE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767801466; c=relaxed/simple;
	bh=Mz8QaaFod0z5a9CO/uQhOkxktwwkVWs1aIyl2luhAc4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Zi9iTlaElTSCa+roSS2ttMhQP16htEfDQTinMXranehDl1ddhRAuvcJIMMEKhoTHl9+uabcj6UssQTFPOdLApVlGWWK7tuHg08weGoM4FagGBsPfoWpckhHtCwnosXf+nMozKNOrwmZNsX4VHBx/Uhu+d3aojlBDjF36JjrwEhM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=x/oZaCg8; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=+3wgXU4F; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=x/oZaCg8; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=+3wgXU4F; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 6B2685C1E5;
	Wed,  7 Jan 2026 15:57:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1767801460; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=sQ5YAFSHlfq3pMQbXbjIJxX9rfXQL3Q34iK01hGHpWg=;
	b=x/oZaCg8RLunLEe3543B6Q0TvbaNJUfpKpuIweWRvv2HW5v+t1pauQ7rIlH6cnyE78v7tC
	zJAaersM96ogyAIUB93jjVoMdIpP2C60iSYnmXyfcJ8OeZlBY31ZsOMw/nA2ZjUa0kjlcZ
	Hfhop4IidhOmVi8HGuUZkYEiUzuG0PY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1767801460;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=sQ5YAFSHlfq3pMQbXbjIJxX9rfXQL3Q34iK01hGHpWg=;
	b=+3wgXU4FV0qw5mZND1xAQo2E/4cuW723OSIkN2VWv8cQJDTDo2gHF03cyWA68W0DDqzYan
	81LfHcrHrfHOqWCA==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b="x/oZaCg8";
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=+3wgXU4F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1767801460; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=sQ5YAFSHlfq3pMQbXbjIJxX9rfXQL3Q34iK01hGHpWg=;
	b=x/oZaCg8RLunLEe3543B6Q0TvbaNJUfpKpuIweWRvv2HW5v+t1pauQ7rIlH6cnyE78v7tC
	zJAaersM96ogyAIUB93jjVoMdIpP2C60iSYnmXyfcJ8OeZlBY31ZsOMw/nA2ZjUa0kjlcZ
	Hfhop4IidhOmVi8HGuUZkYEiUzuG0PY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1767801460;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=sQ5YAFSHlfq3pMQbXbjIJxX9rfXQL3Q34iK01hGHpWg=;
	b=+3wgXU4FV0qw5mZND1xAQo2E/4cuW723OSIkN2VWv8cQJDTDo2gHF03cyWA68W0DDqzYan
	81LfHcrHrfHOqWCA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 07D1E3EA63;
	Wed,  7 Jan 2026 15:57:39 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id GUDlOHOCXmm9HQAAD6G6ig
	(envelope-from <pvorel@suse.cz>); Wed, 07 Jan 2026 15:57:39 +0000
From: Petr Vorel <pvorel@suse.cz>
To: ltp@lists.linux.it
Cc: Petr Vorel <pvorel@suse.cz>,
	Mimi Zohar <zohar@linux.ibm.com>,
	linux-integrity@vger.kernel.org
Subject: [PATCH 1/2] ima_kexec.sh: Detect kernel image
Date: Wed,  7 Jan 2026 16:57:35 +0100
Message-ID: <20260107155737.791588-1-pvorel@suse.cz>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-3.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RCVD_TLS_ALL(0.00)[];
	DKIM_TRACE(0.00)[suse.cz:+];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DWL_DNSWL_BLOCKED(0.00)[suse.cz:dkim];
	RCPT_COUNT_THREE(0.00)[4];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.cz:email,suse.cz:dkim,suse.cz:mid]
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spam-Level: 
X-Rspamd-Queue-Id: 6B2685C1E5
X-Spam-Flag: NO
X-Spam-Score: -3.01

Sometimes BOOT_IMAGE contains partition which does not point to /boot
e.g. BOOT_IMAGE=(hd0,gpt1)/opensuse-tumbleweed/6.18.3-1-default/linux-30afdbce3ab6d0eff8f42b71df1a66f4baf2daf8
on Tumbleweed aarch64. Therefore detect common kernel image paths.

Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
 .../security/integrity/ima/tests/ima_kexec.sh | 28 ++++++++++++++++++-
 1 file changed, 27 insertions(+), 1 deletion(-)

diff --git a/testcases/kernel/security/integrity/ima/tests/ima_kexec.sh b/testcases/kernel/security/integrity/ima/tests/ima_kexec.sh
index d6eb0829d8..7688690af2 100755
--- a/testcases/kernel/security/integrity/ima/tests/ima_kexec.sh
+++ b/testcases/kernel/security/integrity/ima/tests/ima_kexec.sh
@@ -42,7 +42,7 @@ measure()
 
 setup()
 {
-	local arch
+	local arch f uname
 
 	if [ ! -f "$IMA_KEXEC_IMAGE" ]; then
 		for arg in $(cat /proc/cmdline); do
@@ -63,6 +63,32 @@ setup()
 		fi
 	fi
 
+	if [ ! -f "$IMA_KEXEC_IMAGE" ]; then
+		uname="$(uname -r)"
+
+		# x86_64
+		f="/boot/vmlinuz-$uname"
+
+		# ppc64le, s390x
+		if [ ! -f "$f" ]; then
+			f="/boot/vmlinux-$uname"
+		fi
+
+		# aarch64
+		if [ ! -f "$f" ]; then
+			f="/boot/Image-$uname"
+		fi
+
+		# aarch64 often uses compression
+		if [ ! -f "$f" ]; then
+			f="$(ls /boot/Image-$uname.* || true)"
+		fi
+
+		if [ -f "$f" ]; then
+			IMA_KEXEC_IMAGE="$f"
+		fi
+	fi
+
 	if [ ! -f "$IMA_KEXEC_IMAGE" ]; then
 		tst_brk TCONF "kernel image not found, specify path in \$IMA_KEXEC_IMAGE"
 	fi
-- 
2.51.0


