Return-Path: <linux-integrity+bounces-9652-lists+linux-integrity=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-integrity@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QPYCEr4EE2qV6AYAu9opvQ
	(envelope-from <linux-integrity+bounces-9652-lists+linux-integrity=lfdr.de@vger.kernel.org>)
	for <lists+linux-integrity@lfdr.de>; Sun, 24 May 2026 16:01:34 +0200
X-Original-To: lists+linux-integrity@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B6CDF5C2A3B
	for <lists+linux-integrity@lfdr.de>; Sun, 24 May 2026 16:01:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 24FBC3009553
	for <lists+linux-integrity@lfdr.de>; Sun, 24 May 2026 14:01:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8041C21257F;
	Sun, 24 May 2026 14:01:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b="A5wzsjN3"
X-Original-To: linux-integrity@vger.kernel.org
Received: from stravinsky.debian.org (stravinsky.debian.org [82.195.75.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67D183955CE;
	Sun, 24 May 2026 14:01:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=82.195.75.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779631289; cv=none; b=Z2Rqv3lMzWvwGMOWtCYXqCD/T83G8AikvUim6DqbSvN73yQY7IT5abzbdN38dGlo4GPDuJKWBdmcYZwAHekV4Q1JuRUl+MwXnszGQgJX5u2oXUwTpdkXqXRJh+KZT+J6ym52NqbAfblC0RVR48W1lpPyVXqKsuVF07UNTrPUP0s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779631289; c=relaxed/simple;
	bh=5+8M/ANW5WBp18ewmaKD/w/S85f+NDpC2CroWYpXGLw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=t/izXMqaq3s4kJki1iFEg2l/V5E0SUSV6/3VO86QSz7U5Bes39Kc8oInz1GUQY1mvuDH52LRJckjadTswFh4HZddzzeO59ut1o1e3368kKviGDbEe0aLBnQ+XVixNq6kvRtu2mY5KQp1zpStH1TCLNt2ttZawVyKB5fn1JtSX78=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=debian.org; dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b=A5wzsjN3; arc=none smtp.client-ip=82.195.75.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=debian.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
	s=smtpauto.stravinsky; h=X-Debian-User:Cc:To:Message-Id:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:From:
	Reply-To:Content-ID:Content-Description:In-Reply-To:References;
	bh=YAKAHo/3pBwB7ppBKv2Ddkdi5L5KsPDILCOyndfzWdE=; b=A5wzsjN3Mcj13XwprOhrO4ms4f
	iDpTTEE2GXAfLLhg1yFBJWGQbbmsQK5+o8NWm5kTfF8NnIhT9rz4TqLdWW9wWYHY0uIBSNgyBgK5t
	TlRs0F2RFBq/Tgc04Q5IowyFV2z9zN7OELjm2DTOSnxowy2le7HyXmfSHsqKMCiKISRmF4NGEEVqT
	W7FrVOkuhGR5kF0xf26onCSM9GQq+AZesWqzrQRnq+RXNuIkPb4xJ0Z8FlCvRkurzzBYj3lvWfg2t
	YnLdYKSA8qruLtTp2JOdPv4b8qYpBpVEA1wHd/d7MHNex7jXuT0RWIfVC7Jp8lxAp775L6lSffT1+
	AlCUS+6g==;
Received: from authenticated-user
	by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.96)
	(envelope-from <leitao@debian.org>)
	id 1wR9OM-000qfY-1k;
	Sun, 24 May 2026 14:01:22 +0000
From: Breno Leitao <leitao@debian.org>
Date: Sun, 24 May 2026 10:01:17 -0400
Subject: [PATCH] tpm: cap tpm_buf_append() at TPM_BUFSIZE, not PAGE_SIZE
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260524-tpm-v1-1-2420a5977da6@debian.org>
X-B4-Tracking: v=1; b=H4sIAKwEE2oC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIzMDUyMT3ZKCXF0TA6MkCxNzi7TUZEsloMqCotS0zAqwKdGxEH5xaVJWanI
 JSKtSbS0AKfMCA2cAAAA=
X-Change-ID: 20260524-tpm-402b8478fec9
To: Peter Huewe <peterhuewe@gmx.de>, Jarkko Sakkinen <jarkko@kernel.org>, 
 Jason Gunthorpe <jgg@ziepe.ca>
Cc: linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org, 
 noodles@fb.com, James.Bottomley@HansenPartnership.com, kernel-team@meta.com, 
 Breno Leitao <leitao@debian.org>
X-Mailer: b4 0.16-dev-d5d98
X-Developer-Signature: v=1; a=openpgp-sha256; l=1929; i=leitao@debian.org;
 h=from:subject:message-id; bh=5+8M/ANW5WBp18ewmaKD/w/S85f+NDpC2CroWYpXGLw=;
 b=owEBbQKS/ZANAwAKATWjk5/8eHdtAcsmYgBqEwSweEPM1eS7dspK1daq6K+W2t5dCp37vMlyR
 J3EDVj/Hx+JAjMEAAEKAB0WIQSshTmm6PRnAspKQ5s1o5Of/Hh3bQUCahMEsAAKCRA1o5Of/Hh3
 bYDkD/9gxShOeqmhEcFeWos7XlFlxElNl4+Kei7TJyzjMyOFeUAdqR+MEB6m17VoLmqIcssxBX7
 tNiVnanoLAoBZ3H3x1R1GUzmWmLrhDndDbWOwT8BIzDFg7fhdmSsQ/KtkzC6dfuGL8dEjptuNX/
 cbSK77NbQyGIs5zcZH8y6qD62Vf/eupiPX4fw3nrkrd5gt8EM7seB98lAD4HGcwqhCy5CBY+EWG
 e0zgGlC2FbUDzvAzxQk3aonmnHTqkqXZIi+zR7fXYlG4C9uqw4hx7pOWCvu/m+3quVKHkOO8c0k
 N6tEqncd5vQbPScRwIGARni/2gYPJUYHZKcyt/Lni/Ey7zYP6Ig6n/IcOBQZNYUMzrspZCwdT4V
 5kZ5SvOf+ltu39eyxqXiWiGl/NsouGVhyPQcQpTdcg1St19u4HyfuUSyngwPDkK8bZVF3o3nSdH
 oB1C2gApdBisYBnAodbf8/JqmY4h/k8ULtxhxefWLKMjAnQ3/4MLlW4BynBIasLMAIeecpJbuGh
 UA8D97rkjncIxGspRGx5u3xjCbCkOn4DLvjwX+CUMXIJh13AVSrKIJR0j84zB7S8PTViuVBXjgk
 r/GtfgO2U6/lq+eHCe8pPD6TLv8IZab8aLw78mafn55awgTuDCPWa0sr/0k++s/Q+k1AjcxZTZJ
 Vs6+XtPfG3oIL0w==
X-Developer-Key: i=leitao@debian.org; a=openpgp;
 fpr=AC8539A6E8F46702CA4A439B35A3939FFC78776D
X-Debian-User: leitao
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[debian.org,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[debian.org:s=smtpauto.stravinsky];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-9652-lists,linux-integrity=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[gmx.de,kernel.org,ziepe.ca];
	DKIM_TRACE(0.00)[debian.org:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[leitao@debian.org,linux-integrity@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-integrity];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Queue-Id: B6CDF5C2A3B
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

tpm_buf_append() guards against overflow of the underlying buffer by
comparing the running length against PAGE_SIZE. Every other site in the
TPM core uses TPM_BUFSIZE (4096) as the protocol-level cap on TPM
command and response sizes.

On 4K-page kernels PAGE_SIZE == TPM_BUFSIZE, so the two caps coincide
and the inconsistency is invisible. On kernels with a larger base page
size, e.g. CONFIG_ARM64_64K_PAGES=y or 16K pages, PAGE_SIZE exceeds
TPM_BUFSIZE.

This is a latent bug rather than user-visible bug, given most of the
cases PAGE_SIZE = 4096. The mismatch is still worth fixing because
future callers (e.g. the proposed TPM_BUFSIZE increase to 8 KiB, and the
Secure Launch tpm_buf rework) rely on the overflow flag being
authoritative.

Use TPM_BUFSIZE instead of PAGE_SIZE so the append-time check
matches the transmit-time cap on every page size.

Signed-off-by: Breno Leitao <leitao@debian.org>
Fixes: a74f8b36352e ("tpm: introduce tpm_buf")
---
 drivers/char/tpm/tpm-buf.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/char/tpm/tpm-buf.c b/drivers/char/tpm/tpm-buf.c
index dc882fc9fa9e..8da5de0f7159 100644
--- a/drivers/char/tpm/tpm-buf.c
+++ b/drivers/char/tpm/tpm-buf.c
@@ -7,6 +7,8 @@
 #include <linux/module.h>
 #include <linux/tpm.h>
 
+#include "tpm.h"
+
 /**
  * tpm_buf_init() - Allocate and initialize a TPM command
  * @buf:	A &tpm_buf
@@ -108,7 +110,7 @@ void tpm_buf_append(struct tpm_buf *buf, const u8 *new_data, u16 new_length)
 	if (buf->flags & TPM_BUF_OVERFLOW)
 		return;
 
-	if ((buf->length + new_length) > PAGE_SIZE) {
+	if ((buf->length + new_length) > TPM_BUFSIZE) {
 		WARN(1, "tpm_buf: write overflow\n");
 		buf->flags |= TPM_BUF_OVERFLOW;
 		return;

---
base-commit: c1ecb239fa3456529a32255359fc78b69eb9d847
change-id: 20260524-tpm-402b8478fec9

Best regards,
--  
Breno Leitao <leitao@debian.org>


