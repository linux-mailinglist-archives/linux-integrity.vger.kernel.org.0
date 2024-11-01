Return-Path: <linux-integrity+bounces-3967-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 115119B9371
	for <lists+linux-integrity@lfdr.de>; Fri,  1 Nov 2024 15:38:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6FBD6B23EAF
	for <lists+linux-integrity@lfdr.de>; Fri,  1 Nov 2024 14:38:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 449DC1AAE10;
	Fri,  1 Nov 2024 14:37:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="tZW+b8BB";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="0NiI5UVC";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="tZW+b8BB";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="0NiI5UVC"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7AEB1A4F19
	for <linux-integrity@vger.kernel.org>; Fri,  1 Nov 2024 14:37:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730471860; cv=none; b=D3QZEAZV7NLqevKd1Ut49NkEDBc3/Sur1jbnEzO1BZBrC2CG+Fu/tx+VRna9u2GRb10/P3OaTGlAREIXHBHBQNLzoX1ytM9PDG/sS9I431OJGb9Qjouv24sKstypvs0T3dqXVe/XLzubWfKGsx4guJKT0cR93bHwbReItieGmrk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730471860; c=relaxed/simple;
	bh=Nm/LzHFqaAEdnSCt8V7M4IveW/lrWQ++itwRPJNV8Ps=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=RXM4bNIqSQ6nQmcia1MM2iV9Kk3rcSl6Mc2Z+Xap7oZm+PiymxKBt7aI/V81Cb12h8RVh8l2vayVZ389LzMUCahRJSYY/iq6u4bL1v0+AxEKsVVBeTxnWeO4RlAaRX70ww647p7d5BDxoPFV0cpmZf8zBqvrbaFjRrOhRauVRIA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=tZW+b8BB; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=0NiI5UVC; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=tZW+b8BB; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=0NiI5UVC; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 3611421CED;
	Fri,  1 Nov 2024 14:37:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1730471856; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Ck9LSDMaMipvJgF6iuCZtXIr9HtMH0CnwH80XNmU9+Q=;
	b=tZW+b8BBn57rJptZ/DS24vvdVnuUTM5+A5zzAIeg5dZa1tJBxBXZCVKmkkFuEHZ+Zj7A4K
	OFKZqRtnL48ZCztEB7E/DfVYZ0qHAJNQflyhF3kLG6PrLOnZMW5Hgp106scjDI5F/TEJoU
	BuEaE1KsFOtAym9PIvIRMEBh/BiXi1g=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1730471856;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Ck9LSDMaMipvJgF6iuCZtXIr9HtMH0CnwH80XNmU9+Q=;
	b=0NiI5UVCtXqS4AwwlY0AOXN72DtiwTbkyHhj+DO/m75Rf9UgII/8GJ1O8cNB0pZFhCzMne
	0Jp6/69oGYAYpLCA==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1730471856; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Ck9LSDMaMipvJgF6iuCZtXIr9HtMH0CnwH80XNmU9+Q=;
	b=tZW+b8BBn57rJptZ/DS24vvdVnuUTM5+A5zzAIeg5dZa1tJBxBXZCVKmkkFuEHZ+Zj7A4K
	OFKZqRtnL48ZCztEB7E/DfVYZ0qHAJNQflyhF3kLG6PrLOnZMW5Hgp106scjDI5F/TEJoU
	BuEaE1KsFOtAym9PIvIRMEBh/BiXi1g=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1730471856;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Ck9LSDMaMipvJgF6iuCZtXIr9HtMH0CnwH80XNmU9+Q=;
	b=0NiI5UVCtXqS4AwwlY0AOXN72DtiwTbkyHhj+DO/m75Rf9UgII/8GJ1O8cNB0pZFhCzMne
	0Jp6/69oGYAYpLCA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 09B7913ACC;
	Fri,  1 Nov 2024 14:37:36 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id GGnTALDnJGeICwAAD6G6ig
	(envelope-from <pvorel@suse.cz>); Fri, 01 Nov 2024 14:37:36 +0000
From: Petr Vorel <pvorel@suse.cz>
To: ltp@lists.linux.it
Cc: Petr Vorel <pvorel@suse.cz>,
	Mimi Zohar <zohar@linux.ibm.com>,
	linux-integrity@vger.kernel.org
Subject: [PATCH 2/2] ima_boot_aggregate: TBROK on fread() failure
Date: Fri,  1 Nov 2024 15:37:26 +0100
Message-ID: <20241101143726.1278291-2-pvorel@suse.cz>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241101143726.1278291-1-pvorel@suse.cz>
References: <20241101143726.1278291-1-pvorel@suse.cz>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Level: 
X-Spamd-Result: default: False [-3.30 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-0.998];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_TLS_ALL(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	RCPT_COUNT_THREE(0.00)[4]
X-Spam-Score: -3.30
X-Spam-Flag: NO

fread() should read 1 byte, quit when it fails it.

This fixes warning: ignoring return value of ‘fread’ declared with
attribute ‘warn_unused_result’ [-Wunused-result].

Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
 .../kernel/security/integrity/ima/src/ima_boot_aggregate.c     | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/testcases/kernel/security/integrity/ima/src/ima_boot_aggregate.c b/testcases/kernel/security/integrity/ima/src/ima_boot_aggregate.c
index 68d12fc3c2..420b0c736d 100644
--- a/testcases/kernel/security/integrity/ima/src/ima_boot_aggregate.c
+++ b/testcases/kernel/security/integrity/ima/src/ima_boot_aggregate.c
@@ -116,7 +116,8 @@ static void do_test(void)
 			break;
 		}
 #endif
-		fread(event.data, event.header.len, 1, fp);
+		if (fread(event.data, event.header.len, 1, fp) != 1)
+			tst_brk(TBROK, "failed to read 1 byte");
 	}
 
 	SAFE_FCLOSE(fp);
-- 
2.45.2


