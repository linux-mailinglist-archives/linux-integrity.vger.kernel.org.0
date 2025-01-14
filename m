Return-Path: <linux-integrity+bounces-4550-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 82B5BA10563
	for <lists+linux-integrity@lfdr.de>; Tue, 14 Jan 2025 12:29:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9F5EF167A34
	for <lists+linux-integrity@lfdr.de>; Tue, 14 Jan 2025 11:29:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DB9A24335A;
	Tue, 14 Jan 2025 11:29:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="ng9bttMe";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="ExThOX6I";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="ng9bttMe";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="ExThOX6I"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDF1D284A4A
	for <linux-integrity@vger.kernel.org>; Tue, 14 Jan 2025 11:29:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736854170; cv=none; b=iqzgmz5V+IZwg2REVL5VYNbBl6rDRviJIxfpIqfYSRNWjpB8M8KChYgcqT38kH2fyD3U5FgA2woLlIe8+d1sSpcQq77HqD68TmSZGY9c1lkZz76Y+Xdlq58SUw8sI78C8t3RfvCa1UpUw/aGf8vtnIQSDCJCr28sFqkvm3iPvEs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736854170; c=relaxed/simple;
	bh=hMblFic8hCYZGTfwWEGk+4w65rgby5ycLuZOLeOpUgY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=D5FKk/Kwcfqc9gYOHMLYRL9REQDowkKU1o11C8a2ySIt7R684nUVziY4eN+6qqU5/HADt6Miu9Wd3LplvtUOGO94uPXol4UMlT6d/cJ417zjwcgqwgAtqHPfvN5NdBAZ/b0Cev0YrTRVNfeaiPKq1cce7aOhT4bU+nVN6Q3Ett8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=ng9bttMe; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=ExThOX6I; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=ng9bttMe; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=ExThOX6I; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 3EFCC21183;
	Tue, 14 Jan 2025 11:29:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1736854165; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=y1IjH6eEOqfGyRDirMP4HvZHR5QtV4DoWONGfmX5Kt8=;
	b=ng9bttMewAQhLaUZECQQ/c5yKM8XXFpXwkwbOvo9gT5WVnQsGv6HQdQm9WEjFX1UfoImrY
	9mX2wSIfQ5d5YH23HPJkvn+qIzTi5aHlnDog/KX+prKGa5otWtNyvvW+G9wIa3pLSBgI4Y
	yacZcjvmzgHU58KoCnNaGZMhd9i0YIw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1736854165;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=y1IjH6eEOqfGyRDirMP4HvZHR5QtV4DoWONGfmX5Kt8=;
	b=ExThOX6IiPA/zbk+uCjRcChgYqYSCz0LvD8T/JaNUYVKzD4tLxIoO7foxunTT7fpVPP4VF
	vezFYSuj86jf90Aw==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1736854165; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=y1IjH6eEOqfGyRDirMP4HvZHR5QtV4DoWONGfmX5Kt8=;
	b=ng9bttMewAQhLaUZECQQ/c5yKM8XXFpXwkwbOvo9gT5WVnQsGv6HQdQm9WEjFX1UfoImrY
	9mX2wSIfQ5d5YH23HPJkvn+qIzTi5aHlnDog/KX+prKGa5otWtNyvvW+G9wIa3pLSBgI4Y
	yacZcjvmzgHU58KoCnNaGZMhd9i0YIw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1736854165;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=y1IjH6eEOqfGyRDirMP4HvZHR5QtV4DoWONGfmX5Kt8=;
	b=ExThOX6IiPA/zbk+uCjRcChgYqYSCz0LvD8T/JaNUYVKzD4tLxIoO7foxunTT7fpVPP4VF
	vezFYSuj86jf90Aw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 0A45013A86;
	Tue, 14 Jan 2025 11:29:25 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id mE5KAZVKhmeMIAAAD6G6ig
	(envelope-from <pvorel@suse.cz>); Tue, 14 Jan 2025 11:29:25 +0000
From: Petr Vorel <pvorel@suse.cz>
To: ltp@lists.linux.it
Cc: Petr Vorel <pvorel@suse.cz>,
	Mimi Zohar <zohar@linux.ibm.com>,
	linux-integrity@vger.kernel.org
Subject: [PATCH v3 07/10] ima_setup.sh: Add digest index detection for ima-buf format
Date: Tue, 14 Jan 2025 12:29:12 +0100
Message-ID: <20250114112915.610297-8-pvorel@suse.cz>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250114112915.610297-1-pvorel@suse.cz>
References: <20250114112915.610297-1-pvorel@suse.cz>
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
	NEURAL_HAM_SHORT(-0.20)[-0.999];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:mid,suse.cz:email];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_TLS_ALL(0.00)[]
X-Spam-Flag: NO
X-Spam-Level: 

ima-buf format might be loaded via loading policy in the next commit.

Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
 testcases/kernel/security/integrity/ima/tests/ima_setup.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/testcases/kernel/security/integrity/ima/tests/ima_setup.sh b/testcases/kernel/security/integrity/ima/tests/ima_setup.sh
index af5584951c..1f01f18cf6 100644
--- a/testcases/kernel/security/integrity/ima/tests/ima_setup.sh
+++ b/testcases/kernel/security/integrity/ima/tests/ima_setup.sh
@@ -242,7 +242,7 @@ set_digest_index()
 	# parse digest index
 	# https://www.kernel.org/doc/html/latest/security/IMA-templates.html#use
 	case "$template" in
-	ima|ima-ng|ima-sig) DIGEST_INDEX=4 ;;
+	ima|ima-buf|ima-ng|ima-sig) DIGEST_INDEX=4 ;;
 	*)
 		# using ima_template_fmt kernel parameter
 		local IFS="|"
-- 
2.47.1


