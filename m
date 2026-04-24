Return-Path: <linux-integrity+bounces-9322-lists+linux-integrity=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-integrity@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SB8RN6Nv62mMMwAAu9opvQ
	(envelope-from <linux-integrity+bounces-9322-lists+linux-integrity=lfdr.de@vger.kernel.org>)
	for <lists+linux-integrity@lfdr.de>; Fri, 24 Apr 2026 15:26:59 +0200
X-Original-To: lists+linux-integrity@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 9087545EFE2
	for <lists+linux-integrity@lfdr.de>; Fri, 24 Apr 2026 15:26:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 1B13E302429B
	for <lists+linux-integrity@lfdr.de>; Fri, 24 Apr 2026 13:24:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 648FA3D6494;
	Fri, 24 Apr 2026 13:24:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=earth.li header.i=@earth.li header.b="fVdQo7DL"
X-Original-To: linux-integrity@vger.kernel.org
Received: from the.earth.li (the.earth.li [93.93.131.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E2B73D34B7;
	Fri, 24 Apr 2026 13:24:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.93.131.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777037085; cv=none; b=ZaFjU5Ep7ivjA34gdyEd6He3CJ1kMdgTBdZO+SH3Ko3C2XurOT5REg27oUlCF7ogMLopSCugKjAiCF+tHXqfJfjvLASahAMwC4UMseuHwH99iCqVQ9AkfVLwZ0wJ3ifWgz/bdCBOEnReyAZyspvyoo5whbHvfm8yJuzSRCqeQ0E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777037085; c=relaxed/simple;
	bh=cxYa9iowJWVapjxFQbjiCF+rrArexlK4NdNqtnwE7Vs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XeIoQ3kuJyAtsMDtXd1MR4jyEM50gnPu4W0w5TCgcRFuI/LGWavk+rcaIgtJZyx7VnGy5A6TQKJabp7I/dJT2nk9XI5kHvE0RDg3QNcV+vHL4mzpE5v7L+XRBTt5qDJC7Sd/DJOex5VOpg3Low8wL68idKdcBIvkYX+EilX2Nt4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=earth.li; spf=pass smtp.mailfrom=earth.li; dkim=pass (2048-bit key) header.d=earth.li header.i=@earth.li header.b=fVdQo7DL; arc=none smtp.client-ip=93.93.131.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=earth.li
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=earth.li
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=earth.li;
	s=the; h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:
	Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=NdNIwlr6EYICEoRxPpG8gr4dUMgZUbywrW3X2KQCWS4=; b=fVdQo7DLwhvnr8LSwWr0AJgZ9n
	NnI+PRLs1iSPv/FGWFsYSEao3/izs4kRQtMLdis1TKFt50zUAyE5xICfYJCmwGHpsFveq00Dt2TX3
	m+4ESjKmlE39lccShEg1XoCAMafp69xOHODZMqgaIHad4Ch38lGOPwqQ8EMM9bmswkbiH8M+H1Riw
	Cv3u+USuE2tB5zISVKWmGR6r7S/Kh2M3FU7P/XGy5e4d23IYEN9oN9cb6WB1VFYt18/kyLF5d44aw
	EgKFVBNGuc17CJh1a0xMJFcEsngOtw3oscgmmNwsaj5B1462QWjcg810U42GBfLEZ2NFdFnrRlQe6
	wN5EgjpA==;
Received: from noodles by the.earth.li with local (Exim 4.98.2)
	(envelope-from <noodles@earth.li>)
	id 1wGGWQ-0000000556r-0aRd;
	Fri, 24 Apr 2026 14:24:42 +0100
Date: Fri, 24 Apr 2026 14:24:42 +0100
From: Jonathan McDowell <noodles@earth.li>
To: linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-integrity@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev
Cc: paul@paul-moore.com, jmorris@namei.org, serge@hallyn.com,
	zohar@linux.ibm.com, roberto.sassu@huawei.com,
	dmitry.kasatkin@gmail.com, eric.snowberg@oracle.com,
	jarkko@kernel.org, jgg@ziepe.ca, sudeep.holla@kernel.org,
	maz@kernel.org, oupton@kernel.org, joey.gouly@arm.com,
	suzuki.poulose@arm.com, yuzenghui@huawei.com,
	catalin.marinas@arm.com, will@kernel.org, noodles@meta.com,
	sebastianene@google.com, Yeoreum Yun <yeoreum.yun@arm.com>
Subject: [RFC PATCH v3 4/4] Revert "firmware: arm_ffa: Change initcall level
 of ffa_init() to rootfs_initcall"
Message-ID: <2e7b4dc552b45ddf14cc43bc449cbebb4ade0027.1777036497.git.noodles@meta.com>
References: <cover.1777036497.git.noodles@meta.com>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1777036497.git.noodles@meta.com>
X-Rspamd-Queue-Id: 9087545EFE2
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.04 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	R_DKIM_REJECT(1.00)[earth.li:s=the];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-9322-lists,linux-integrity=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DMARC_NA(0.00)[earth.li];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[25];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[earth.li:-];
	NEURAL_HAM(-0.00)[-0.987];
	FROM_NEQ_ENVFROM(0.00)[noodles@earth.li,linux-integrity@vger.kernel.org];
	PRECEDENCE_BULK(0.00)[];
	FREEMAIL_CC(0.00)[paul-moore.com,namei.org,hallyn.com,linux.ibm.com,huawei.com,gmail.com,oracle.com,kernel.org,ziepe.ca,arm.com,meta.com,google.com];
	TAGGED_RCPT(0.00)[linux-integrity];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,meta.com:mid,meta.com:email,arm.com:email]

From: Yeoreum Yun <yeoreum.yun@arm.com>

This reverts commit 0e0546eabcd6c19765a8dbf5b5db3723e7b0ea75, which was
added to address ordering issues with the IMA LSM initialisation where
the TPM would not be fully ready by the time IMA wanted it. This has
been resolved within IMA by retrying setup during late_initcall_sync if
the TPM is not available at first.

Signed-off-by: Yeoreum Yun <yeoreum.yun@arm.com>
Signed-off-by: Jonathan McDowell <noodles@meta.com>
---
 drivers/firmware/arm_ffa/driver.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/firmware/arm_ffa/driver.c b/drivers/firmware/arm_ffa/driver.c
index f2f94d4d533e..01547c5c0e38 100644
--- a/drivers/firmware/arm_ffa/driver.c
+++ b/drivers/firmware/arm_ffa/driver.c
@@ -2106,7 +2106,7 @@ static int __init ffa_init(void)
 	kfree(drv_info);
 	return ret;
 }
-rootfs_initcall(ffa_init);
+module_init(ffa_init);
 
 static void __exit ffa_exit(void)
 {
-- 
2.53.0


