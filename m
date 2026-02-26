Return-Path: <linux-integrity+bounces-8565-lists+linux-integrity=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-integrity@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4EdiKpT0n2kyfAQAu9opvQ
	(envelope-from <linux-integrity+bounces-8565-lists+linux-integrity=lfdr.de@vger.kernel.org>)
	for <lists+linux-integrity@lfdr.de>; Thu, 26 Feb 2026 08:21:56 +0100
X-Original-To: lists+linux-integrity@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6466F1A1CC1
	for <lists+linux-integrity@lfdr.de>; Thu, 26 Feb 2026 08:21:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 0F20D309A2E4
	for <lists+linux-integrity@lfdr.de>; Thu, 26 Feb 2026 07:20:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 450FD38F936;
	Thu, 26 Feb 2026 07:20:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b="R6xSeAbN"
X-Original-To: linux-integrity@vger.kernel.org
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E289338E5E6;
	Thu, 26 Feb 2026 07:20:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.126.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772090428; cv=none; b=KdgrhTBgLnFJN38AWUbfzA+E956f8I2MWXRdGGIaFZgB7xEBglxRiMDZMxKSXzca4XIvtE2iB9EOMszwQKuI9x7+Vfa1r8dt+/8ttebGRSEw9t06yGDVrbcudul49Gpz/E5I5P8QCxIH1kIp2Ykkw/W8iieLUyvT2q4l6Qq7mlk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772090428; c=relaxed/simple;
	bh=+xNhFMCr+AwJ4R2ewthyRXsYeAS6MRC+DvkGWiz2Xy4=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=o9x2mTh/rrdYxqxazzPhYEiRA4LfFiEuAOBZKQpaZNjXIx7BaSWXtHELxi3dUzRs9O1lMpdpqfS0nSBPeAiktCrHbDTGqYKJBKOgZA1OKhHlKUvuGSIxUPVFGu5N50yU38tV/lSGh4sKOEd9NSWg8Bnad7bTiT4nc04agu2izGA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net; spf=pass smtp.mailfrom=weissschuh.net; dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b=R6xSeAbN; arc=none smtp.client-ip=159.69.126.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=weissschuh.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1772090423;
	bh=+xNhFMCr+AwJ4R2ewthyRXsYeAS6MRC+DvkGWiz2Xy4=;
	h=From:Subject:Date:To:Cc:From;
	b=R6xSeAbNDvMGPqDU/utIhb/xu3nrrNnDjkWNlPyAeHVnpu6/xjE3pJJp/5RdXJ0uh
	 0D1nEPT/c9CPZOpLaU+O638k1ZA67qY3tpeXETdU1a1p0jcqd1vc4bq14cxFVIOi5h
	 jMbu0SfjRphv5Oj0K35ErXJuKmFna+F5rBR8wqBU=
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Subject: [PATCH 0/2] efi: Drop unnecessary check for
 CONFIG_MODULE_SIG/CONFIG_KEXEC_SIG
Date: Thu, 26 Feb 2026 08:20:11 +0100
Message-Id: <20260226-ima-ifdef-v1-0-8b9613edbbdb@weissschuh.net>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIzMDIyNT3czcRN3MtJTUNF1LcwtLM4NkgzQDg1QloPqCotS0zAqwWdGxtbU
 ADAsehFsAAAA=
X-Change-ID: 20260225-ima-ifdef-978960c0f00e
To: Mimi Zohar <zohar@linux.ibm.com>, 
 Roberto Sassu <roberto.sassu@huawei.com>, 
 Dmitry Kasatkin <dmitry.kasatkin@gmail.com>, 
 Eric Snowberg <eric.snowberg@oracle.com>, Paul Moore <paul@paul-moore.com>, 
 James Morris <jmorris@namei.org>, "Serge E. Hallyn" <serge@hallyn.com>, 
 Madhavan Srinivasan <maddy@linux.ibm.com>, 
 Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>, 
 "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>
Cc: linux-integrity@vger.kernel.org, linux-security-module@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>, 
 Aaron Tomlin <atomlin@atomlin.com>, Nicolas Schier <nsc@kernel.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1772090423; l=912;
 i=linux@weissschuh.net; s=20221212; h=from:subject:message-id;
 bh=+xNhFMCr+AwJ4R2ewthyRXsYeAS6MRC+DvkGWiz2Xy4=;
 b=EXmDSldrQjH9k7r0b85aygGNholtTe9az0eoaO840iqEpDnHsz3NlQbbpTApT7423xZ3w9rGu
 uRSsU+wItAJBD1UaM5biNqLgvm3cHWR5LUeC4k6Vl70QwDNFXQQ0QmZ
X-Developer-Key: i=linux@weissschuh.net; a=ed25519;
 pk=KcycQgFPX2wGR5azS7RhpBqedglOZVgRPfdFSPB1LNw=
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[weissschuh.net,quarantine];
	R_DKIM_ALLOW(-0.20)[weissschuh.net:s=mail];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-8565-lists,linux-integrity=lfdr.de];
	FREEMAIL_TO(0.00)[linux.ibm.com,huawei.com,gmail.com,oracle.com,paul-moore.com,namei.org,hallyn.com,ellerman.id.au,kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	RCPT_COUNT_TWELVE(0.00)[18];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[linux@weissschuh.net,linux-integrity@vger.kernel.org];
	DKIM_TRACE(0.00)[weissschuh.net:+];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[linux-integrity];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,weissschuh.net:mid,weissschuh.net:dkim,weissschuh.net:email]
X-Rspamd-Queue-Id: 6466F1A1CC1
X-Rspamd-Action: no action

When configuration settings are disabled the guarded functions are
defined as empty stubs, so the check is unnecessary.

This was originally part of my CONFIG_MODULE_HASHES[0] series,
but as I am dropping IMA compatibility for now, these patches
can go in independently.

[0] https://lore.kernel.org/lkml/20260113-module-hashes-v4-0-0b932db9b56b@weissschuh.net/

Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
---
Thomas Weißschuh (2):
      ima: efi: Drop unnecessary check for CONFIG_MODULE_SIG/CONFIG_KEXEC_SIG
      powerpc/ima: Drop unnecessary check for CONFIG_MODULE_SIG

 arch/powerpc/kernel/ima_arch.c   | 3 +--
 security/integrity/ima/ima_efi.c | 6 ++----
 2 files changed, 3 insertions(+), 6 deletions(-)
---
base-commit: 6de23f81a5e08be8fbf5e8d7e9febc72a5b5f27f
change-id: 20260225-ima-ifdef-978960c0f00e

Best regards,
-- 
Thomas Weißschuh <linux@weissschuh.net>


