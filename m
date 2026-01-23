Return-Path: <linux-integrity+bounces-8294-lists+linux-integrity=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-integrity@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6CyoENJdc2l3vAAAu9opvQ
	(envelope-from <linux-integrity+bounces-8294-lists+linux-integrity=lfdr.de@vger.kernel.org>)
	for <lists+linux-integrity@lfdr.de>; Fri, 23 Jan 2026 12:38:58 +0100
X-Original-To: lists+linux-integrity@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 79A7E752E8
	for <lists+linux-integrity@lfdr.de>; Fri, 23 Jan 2026 12:38:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id AC0DD3065B07
	for <lists+linux-integrity@lfdr.de>; Fri, 23 Jan 2026 11:37:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72FE6342C80;
	Fri, 23 Jan 2026 11:37:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="jRzRWqEs";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="RS2ahJvm"
X-Original-To: linux-integrity@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D377B31A7F3;
	Fri, 23 Jan 2026 11:37:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769168243; cv=none; b=MB4YmSff+txHpMcVmIPlVwJaOqsM8pt6OFOWmPqcvDU7matWOs0EIAiFKKf2REXjF4paYAcZMBLQEB4GC3Cn0Yc6ZCYZpLdXPMm71jfhaK5OQXKEJ8cads+p+Mftg3ZGXsaixJqzZp3Q4AOppe8CIc4+jIz06mmF04udX8sGbss=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769168243; c=relaxed/simple;
	bh=BvOe0n0O3fEnxsIu8XLjoGVkrNv6ygwKM1JjrkTdmxs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=u2KeLTvlDVPQdEOyow5q8LqdveT84Rjki3ZLgsh3XdzHbyy5gWAaCsTgdcqruVggTrD+Ay8+OEMdmot9gU2itLvtqEoi0y/oy2QLatxG7q9eZRh6bOLFCDrFUd0l30i8opAAHczLuoGbjg3vMJBy1vnnp8Hov5kZ6nluWopjJDo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=jRzRWqEs; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=RS2ahJvm; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1769168236;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=n+P2moe5wzk8LRVHukc5mSlFSGY5TZY+eBi1aBHfZZs=;
	b=jRzRWqEs+1UHDABQxWvpOcSiePWZ7aBRgE+gas1fCLx7SMu4d2ayl8tHp8WlGw0RSlZFbJ
	ARgoSlhgmqxElyelzzm+OMXG0mR9GKMC1hnhonAEMYF6AZ79m40KFz1RDzOpkgjRdGrSpx
	112RJbLRJisAzeONPgOYX4ZyJT5P93DK1P/C6YRDqgBEFO1l5SOCK1jdYfvnpvZJAcwrw/
	PTYRrTL8f4t9VkkeDd7X4LHMXNgKHuYJP4WTWBDF3upcGpk9XzvyLSolt5agsKkWonZdym
	Be8Hqus3JnM2eX9ZSncLldKVcYKCJNd+O5rD3pu0ykYbB2p5IxyrFEwu1tQMww==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1769168236;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=n+P2moe5wzk8LRVHukc5mSlFSGY5TZY+eBi1aBHfZZs=;
	b=RS2ahJvmBQ08rqHwJV7WuqdTWNBdXb5J67V8PxIPWuBHyEz8vUJKxLWm4PPEvOxo0YKqEv
	f9X8FJCacfLAsDBw==
To: linux-kernel@vger.kernel.org
Cc: linux-rt-devel@lists.linux.dev,
	Thomas Gleixner <tglx@kernel.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Peter Huewe <peterhuewe@gmx.de>,
	Jarkko Sakkinen <jarkko@kernel.org>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	linux-integrity@vger.kernel.org
Subject: [PATCH 09/21] char: tpm: cr50: Remove IRQF_ONESHOT
Date: Fri, 23 Jan 2026 12:36:55 +0100
Message-ID: <20260123113708.416727-10-bigeasy@linutronix.de>
In-Reply-To: <20260123113708.416727-1-bigeasy@linutronix.de>
References: <20260123113708.416727-1-bigeasy@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linutronix.de,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[linutronix.de:s=2020,linutronix.de:s=2020e];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[lists.linux.dev,kernel.org,linutronix.de,gmx.de,ziepe.ca,vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-8294-lists,linux-integrity=lfdr.de];
	DKIM_TRACE(0.00)[linutronix.de:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bigeasy@linutronix.de,linux-integrity@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.924];
	TAGGED_RCPT(0.00)[linux-integrity];
	RCPT_COUNT_SEVEN(0.00)[8];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linutronix.de:email,linutronix.de:dkim,linutronix.de:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,gmx.de:email]
X-Rspamd-Queue-Id: 79A7E752E8
X-Rspamd-Action: no action

Passing IRQF_ONESHOT ensures that the interrupt source is masked until
the secondary (threaded) handler is done. If only a primary handler is
used then the flag makes no sense because the interrupt can not fire
(again) while its handler is running.
The flag also disallows force-threading of the primary handler and the
irq-core will warn about this.

Remove IRQF_ONESHOT from irqflags.

Cc: Peter Huewe <peterhuewe@gmx.de>
Cc: Jarkko Sakkinen <jarkko@kernel.org>
Cc: Jason Gunthorpe <jgg@ziepe.ca>
Cc: linux-integrity@vger.kernel.org
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 drivers/char/tpm/tpm_tis_i2c_cr50.c | 3 +--
 drivers/char/tpm/tpm_tis_spi_cr50.c | 2 +-
 2 files changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/char/tpm/tpm_tis_i2c_cr50.c b/drivers/char/tpm/tpm_tis=
_i2c_cr50.c
index fc6891a0b6936..b48cacacc0664 100644
--- a/drivers/char/tpm/tpm_tis_i2c_cr50.c
+++ b/drivers/char/tpm/tpm_tis_i2c_cr50.c
@@ -749,8 +749,7 @@ static int tpm_cr50_i2c_probe(struct i2c_client *client)
=20
 	if (client->irq > 0) {
 		rc =3D devm_request_irq(dev, client->irq, tpm_cr50_i2c_int_handler,
-				      IRQF_TRIGGER_FALLING | IRQF_ONESHOT |
-				      IRQF_NO_AUTOEN,
+				      IRQF_TRIGGER_FALLING | IRQF_NO_AUTOEN,
 				      dev->driver->name, chip);
 		if (rc < 0) {
 			dev_err(dev, "Failed to probe IRQ %d\n", client->irq);
diff --git a/drivers/char/tpm/tpm_tis_spi_cr50.c b/drivers/char/tpm/tpm_tis=
_spi_cr50.c
index f4937280e9406..32920b4cecfb4 100644
--- a/drivers/char/tpm/tpm_tis_spi_cr50.c
+++ b/drivers/char/tpm/tpm_tis_spi_cr50.c
@@ -287,7 +287,7 @@ int cr50_spi_probe(struct spi_device *spi)
 	if (spi->irq > 0) {
 		ret =3D devm_request_irq(&spi->dev, spi->irq,
 				       cr50_spi_irq_handler,
-				       IRQF_TRIGGER_RISING | IRQF_ONESHOT,
+				       IRQF_TRIGGER_RISING,
 				       "cr50_spi", cr50_phy);
 		if (ret < 0) {
 			if (ret =3D=3D -EPROBE_DEFER)
--=20
2.51.0


