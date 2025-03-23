Return-Path: <linux-integrity+bounces-5390-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 18B44A6CF99
	for <lists+linux-integrity@lfdr.de>; Sun, 23 Mar 2025 15:11:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CFED63B429A
	for <lists+linux-integrity@lfdr.de>; Sun, 23 Mar 2025 14:10:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D22C114884C;
	Sun, 23 Mar 2025 14:10:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="SmB4NETP";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="SiI+EYuY";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="aSwIKQ5c";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="4IFCt1nL"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A014142E86
	for <linux-integrity@vger.kernel.org>; Sun, 23 Mar 2025 14:10:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742739021; cv=none; b=boj79pKGbHnC0oo/8o6pkl6Q8Nn/b1JgIE6NftWR3hzqQHZhXTPfHnKuMjN1uzWjT6k8aYRjl5qIwYdNRxbBoCRNRnSfBVZD7EjuIADKFDYM7CVE18wfseIAH930n8Ias9GSWiWYKKcCwAtdnDi23PL+sOiy4A63THA5Ye7NwIc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742739021; c=relaxed/simple;
	bh=aZgDOZteqtNB2LWsQj+sAqYVWYwsREihcCBt3EKYs7g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lZym1MX247Zqz83kUQBbGEmRMFy/06/+WslBn0L1RVj61VquZ+/FTRKo7lZY1LN2yxJ9yX7O8lDexIRIXmYCg0rwGrmtQ4YErL+YVS00ZWgSAbDHr4c23qIRHWDtTd0CX8wEeUliKEXoPmTir/kVb5l7zv8F2VAQBBRwV3//Qlo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=SmB4NETP; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=SiI+EYuY; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=aSwIKQ5c; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=4IFCt1nL; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id F0F141F45A;
	Sun, 23 Mar 2025 14:10:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1742739009; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6aPUpL5BmfCGVFe96Yt0mlxardWQteHrb5+eH77hyXI=;
	b=SmB4NETPf36o0Te3DAlhdP4UvUGqq80Jz2IfVp7ir2MJm/q01zzRE6YYov9WVDW6lekadb
	z6NGS1RLRz/0OVNAsPDEn+srScwspN1ebTUe5jwpEQOcuKEut3u6LHQdzgeMLgp+nVx85y
	asyno+rAmrvkUWBx+GNiaVwvZ6eZPKo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1742739009;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6aPUpL5BmfCGVFe96Yt0mlxardWQteHrb5+eH77hyXI=;
	b=SiI+EYuY6aS3QW619pWScVFYCksjllL4B9kzk+2W4ZJRvv3EHGD65Tn974ObsN7/Fj7OJU
	PxqTHIeZ2xqTbrDA==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1742739008; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6aPUpL5BmfCGVFe96Yt0mlxardWQteHrb5+eH77hyXI=;
	b=aSwIKQ5c+5WjgwxLmYTQkswQADFG4xPkbgURCovF0JrC8dEkMh8KTIcWjrW/J1NGm9H1YC
	qdEaCQWQd2HTsQBBtPZYa1h+Q8DZg5F7OzkfwDOCWbzlpko/GrAYmlmYAXfggV1t0TUu8v
	wvrwx0gSSLzMyQ+WJ+N2fyIElgPwEtY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1742739008;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6aPUpL5BmfCGVFe96Yt0mlxardWQteHrb5+eH77hyXI=;
	b=4IFCt1nLYkNWarIeLpvzr44zGy+T2JYYTvXYwmMuyWuGZoK9Ai57/0wePyg+F3VKmSTkjx
	iLWrIWAUm4DaIPCw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id E19DE1339F;
	Sun, 23 Mar 2025 14:10:08 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id MLbkNUAW4GedPAAAD6G6ig
	(envelope-from <nstange@suse.de>); Sun, 23 Mar 2025 14:10:08 +0000
From: Nicolai Stange <nstange@suse.de>
To: Mimi Zohar <zohar@linux.ibm.com>,
	Roberto Sassu <roberto.sassu@huawei.com>,
	Dmitry Kasatkin <dmitry.kasatkin@gmail.com>
Cc: Eric Snowberg <eric.snowberg@oracle.com>,
	Jarkko Sakkinen <jarkko@kernel.org>,
	James Bottomley <James.Bottomley@HansenPartnership.com>,
	linux-integrity@vger.kernel.org,
	linux-security-module@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Nicolai Stange <nstange@suse.de>
Subject: [RFC PATCH v2 05/13] ima: select CRYPTO_SHA256 from Kconfig
Date: Sun, 23 Mar 2025 15:09:03 +0100
Message-ID: <20250323140911.226137-6-nstange@suse.de>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250323140911.226137-1-nstange@suse.de>
References: <20250323140911.226137-1-nstange@suse.de>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Level: 
X-Spamd-Result: default: False [-5.30 / 50.00];
	REPLY(-4.00)[];
	BAYES_HAM(-3.00)[99.99%];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-0.998];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_HAS_DN(0.00)[];
	ARC_NA(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_RCPT(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email,suse.de:mid];
	RCVD_COUNT_TWO(0.00)[2];
	FREEMAIL_TO(0.00)[linux.ibm.com,huawei.com,gmail.com];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	R_RATELIMIT(0.00)[to_ip_from(RL6owce66jwsk5yhus1j8gn7jo)];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FREEMAIL_ENVRCPT(0.00)[gmail.com]
X-Spam-Score: -5.30
X-Spam-Flag: NO

Since recently, IMA would not record measurement list entries into PCR
banks for which it doesn't have a corresponding in-kernel hash algorithm
implementation available anymore (for
CONFIG_IMA_COMPAT_FALLBACK_TPM_EXTEND=n).

With TPM 2.0, the only hash algorithms guaranteed to be implemented on a
TPM are SHA-256/384, c.f. "TCG PC Client Platform TPM Profile
Specification for TPM 2.0", sec. 4.6 "PCR Requirements".

In particular, sha1 is not mandatory, and thus, the CRYPTO_SHA1 dependency
of IMA is not sufficient anymore for ensuring that IMA would find at least
one usable PCR bank.

So, in order to make sure that IMA has access to at least one usable bank
on platforms featuring a TPM 2.0 device, make it depend on CRYPTO_SHA256.

Keep the dependency on CRYPTO_SHA1 for the TPM 1 case.

Signed-off-by: Nicolai Stange <nstange@suse.de>
---
 security/integrity/ima/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/security/integrity/ima/Kconfig b/security/integrity/ima/Kconfig
index c8f12a4a4edf..8a7e74dc1477 100644
--- a/security/integrity/ima/Kconfig
+++ b/security/integrity/ima/Kconfig
@@ -7,6 +7,7 @@ config IMA
 	select CRYPTO
 	select CRYPTO_HMAC
 	select CRYPTO_SHA1
+	select CRYPTO_SHA256
 	select CRYPTO_HASH_INFO
 	select SECURITY_PATH
 	select TCG_TPM if HAS_IOMEM
-- 
2.49.0


