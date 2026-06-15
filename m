Return-Path: <linux-integrity+bounces-9793-lists+linux-integrity=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-integrity@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id AoM/C2aEL2oaBwUAu9opvQ
	(envelope-from <linux-integrity+bounces-9793-lists+linux-integrity=lfdr.de@vger.kernel.org>)
	for <lists+linux-integrity@lfdr.de>; Mon, 15 Jun 2026 06:49:42 +0200
X-Original-To: lists+linux-integrity@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id AA2EF683559
	for <lists+linux-integrity@lfdr.de>; Mon, 15 Jun 2026 06:49:41 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=none;
	dmarc=none;
	spf=pass (mail.lfdr.de: domain of "linux-integrity+bounces-9793-lists+linux-integrity=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="linux-integrity+bounces-9793-lists+linux-integrity=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 48FFD3008D2E
	for <lists+linux-integrity@lfdr.de>; Mon, 15 Jun 2026 04:49:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 775FD2D0606;
	Mon, 15 Jun 2026 04:49:13 +0000 (UTC)
X-Original-To: linux-integrity@vger.kernel.org
Received: from pidgin.makrotopia.org (pidgin.makrotopia.org [185.142.180.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2E31285CBC;
	Mon, 15 Jun 2026 04:49:11 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781498953; cv=none; b=vB9QxjsERCiJuOCkR9zWfVNj6VJNdI39gQ9NgBkFy4R3CnCJ5aYZTCx5wwWtazQro5wo+zN7ZKXVpvhWT70balABgRwZSyLgyT10J9Q/V2j8t9d0YceqY1RG8lengbkAtQv6Y77mRD343plVyRsGXsFS9kUzDnKqiqfnS0IICmc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781498953; c=relaxed/simple;
	bh=J/L5xT5aQww8vWb1GaDhaND6bJ8nV45qb/jqb4nzyUs=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=dEmvagiKDIfJelwL7nmjlWqi0nXUBHoAZEuujuRF/7bw+Pe0RQ6/VxMPvk/WKGJnrHjxXCHJPHVLJl0iWylgj8WL8wMVkPF5n0oExaqn92FDQBEli38Zc4QrGYgQDlx7lWd+32Vgps/Bb5XWhKvLPLQoggKRx1dWSmt1wLrliEA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org; spf=pass smtp.mailfrom=makrotopia.org; arc=none smtp.client-ip=185.142.180.65
Received: from local
	by pidgin.makrotopia.org with esmtpsa (TLS1.3:TLS_AES_256_GCM_SHA384:256)
	 (Exim 4.99)
	(envelope-from <daniel@makrotopia.org>)
	id 1wYzFp-000000000p9-3vZz;
	Mon, 15 Jun 2026 04:48:58 +0000
Date: Mon, 15 Jun 2026 05:48:43 +0100
From: Daniel Golle <daniel@makrotopia.org>
To: Peter Huewe <peterhuewe@gmx.de>, Jarkko Sakkinen <jarkko@kernel.org>,
	Jason Gunthorpe <jgg@ziepe.ca>, Chen Jun <chenjun102@huawei.com>,
	linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] tpm: tpm_tis: add settle delay after releasing locality
Message-ID: <086949bcf2c10bead892b0b4befd98da370cd3ee.1781498837.git.daniel@makrotopia.org>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.46 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS(0.00)[m:peterhuewe@gmx.de,m:jarkko@kernel.org,m:jgg@ziepe.ca,m:chenjun102@huawei.com,m:linux-integrity@vger.kernel.org,m:linux-kernel@vger.kernel.org,s:lists@lfdr.de];
	TO_DN_SOME(0.00)[];
	DMARC_NA(0.00)[makrotopia.org];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[gmx.de,kernel.org,ziepe.ca,huawei.com,vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[daniel@makrotopia.org,linux-integrity@vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-9793-lists,linux-integrity=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[daniel@makrotopia.org,linux-integrity@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	R_DKIM_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-integrity];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,vger.kernel.org:from_smtp,makrotopia.org:email,makrotopia.org:mid,makrotopia.org:from_mime]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: AA2EF683559

tpm_tis_core_init() releases locality 0 then immediately reclaims it via
tpm_chip_start(); some TPMs (e.g. Nuvoton NPCT, TPM 2.0) need a few ms
before granting it again, so probe fails with -1. This back-to-back
release/request was added with the locality claim around TPM_INT_ENABLE.

Wait for the chip to settle after releasing the locality. A delay of
TPM_TIMEOUT (5 ms) in __tpm_tis_relinquish_locality() is reliable; values
below 3 ms are not.

Fixes: 0ef333f5ba7f ("tpm: add request_locality before write TPM_INT_ENABLE")
Cc: stable@vger.kernel.org
Signed-off-by: Daniel Golle <daniel@makrotopia.org>
---
 drivers/char/tpm/tpm_tis_core.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/char/tpm/tpm_tis_core.c b/drivers/char/tpm/tpm_tis_core.c
index 21d79ad3b164..6b90ff50c78d 100644
--- a/drivers/char/tpm/tpm_tis_core.c
+++ b/drivers/char/tpm/tpm_tis_core.c
@@ -171,6 +171,8 @@ static int __tpm_tis_relinquish_locality(struct tpm_tis_data *priv, int l)
 {
 	tpm_tis_write8(priv, TPM_ACCESS(l), TPM_ACCESS_ACTIVE_LOCALITY);
 
+	tpm_msleep(TPM_TIMEOUT);
+
 	return 0;
 }
 
-- 
2.54.0


