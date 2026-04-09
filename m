Return-Path: <linux-integrity+bounces-9152-lists+linux-integrity=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-integrity@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uHdvKe7g12kVUQgAu9opvQ
	(envelope-from <linux-integrity+bounces-9152-lists+linux-integrity=lfdr.de@vger.kernel.org>)
	for <lists+linux-integrity@lfdr.de>; Thu, 09 Apr 2026 19:25:02 +0200
X-Original-To: lists+linux-integrity@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 00E223CE15A
	for <lists+linux-integrity@lfdr.de>; Thu, 09 Apr 2026 19:25:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D5FA9301FD72
	for <lists+linux-integrity@lfdr.de>; Thu,  9 Apr 2026 17:21:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 347DD2E2EF9;
	Thu,  9 Apr 2026 17:21:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b="ay7P69eS"
X-Original-To: linux-integrity@vger.kernel.org
Received: from pdx-out-008.esa.us-west-2.outbound.mail-perimeter.amazon.com (pdx-out-008.esa.us-west-2.outbound.mail-perimeter.amazon.com [52.42.203.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F038E2882BE;
	Thu,  9 Apr 2026 17:21:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.42.203.116
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775755276; cv=none; b=ohCj8afVwlDjSk+3eS051+V7Th92X6yg90w6JizLQjgItL/pKEIpctZMkh4CvgQgLDvrUZvNRcN5UVoBj9S0bwt1OKkuSJ9ciunOR4RtFJU+ui03Nhzb4ZO82M06cvp9zy/x3a6UKNV3iRhUjbPpJkFlFLU7Fs5UeHFHhxpYi8E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775755276; c=relaxed/simple;
	bh=5tG1EPi0VxoqW3reqQEG+XZqNRNDxOLXl03a722CBlE=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=YVskeNbmVj2Fbu9K+kJroXgg/6ieR+1CMsQo5K7vci3kM5ZxvwE7R5bIKDiIxXTWlQiK6EKpcJSMi702vCmZ/q7npbfLBKUv6baUz5wmxV1HPCuJubm0FegYQUkpK5ONnV4vWEd+J0YqpIHmca86jHXGrFnNwvU/n2E0ettppk8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.com; dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b=ay7P69eS; arc=none smtp.client-ip=52.42.203.116
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazoncorp2;
  t=1775755275; x=1807291275;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=FjHKaKQGEs72xcYsL6Jb1W0JgeM498XsI45jj3ZndfQ=;
  b=ay7P69eS6RrYKeh/zl2M2lJy6dcUlbivbw+huSi+gp415gzR+dE0LWRV
   m3UV7AMl/XeocEODZH1ux3VnOUzB0Y3S66zCKrenpwaMTRG/1NB1p4deY
   3QoWGPEmzF6BE/t03OMjBXiRfkwuweN2JrBP1SvHpMtsIcJ5kk+BrQ007
   pSy1RD3ErLrq18GPNVxnjV2mJoMvS+4PJp5LPz9t0w2i3A3uAAx0KDucg
   t09lx2pEbM35Ed7P1HXz+QODBH7GbJk2h5FQ0JM6rnmFqdtX5xqkICGaJ
   YipMzt8UeWUDfkZovr9AJbunQ7TI8s/cwoOh5IShMlKlCaiTn0AQaFMQy
   w==;
X-CSE-ConnectionGUID: DLafZoozQ3CNkuWiLb8Q3w==
X-CSE-MsgGUID: J9n4cW5sTxCkfgNYSg1EjA==
X-IronPort-AV: E=Sophos;i="6.23,170,1770595200"; 
   d="scan'208";a="16950480"
Received: from ip-10-5-12-219.us-west-2.compute.internal (HELO smtpout.naws.us-west-2.prod.farcaster.email.amazon.dev) ([10.5.12.219])
  by internal-pdx-out-008.esa.us-west-2.outbound.mail-perimeter.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Apr 2026 17:21:14 +0000
Received: from EX19MTAUWC002.ant.amazon.com [205.251.233.111:12962]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.1.88:2525] with esmtp (Farcaster)
 id 7d38fb97-8f97-46a7-a9dd-191a0b5236d8; Thu, 9 Apr 2026 17:21:14 +0000 (UTC)
X-Farcaster-Flow-ID: 7d38fb97-8f97-46a7-a9dd-191a0b5236d8
Received: from EX19D001UWA001.ant.amazon.com (10.13.138.214) by
 EX19MTAUWC002.ant.amazon.com (10.250.64.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.37;
 Thu, 9 Apr 2026 17:21:13 +0000
Received: from dev-dsk-gunnarku-2c-36117f29.us-west-2.amazon.com
 (172.23.139.22) by EX19D001UWA001.ant.amazon.com (10.13.138.214) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.37; Thu, 9 Apr 2026
 17:21:13 +0000
From: Gunnar Kudrjavets <gunnarku@amazon.com>
To: <peterhuewe@gmx.de>, <jarkko@kernel.org>
CC: <jgg@ziepe.ca>, <James.Bottomley@HansenPartnership.com>,
	<ardb@kernel.org>, <linux-integrity@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Justinien Bouron <jbouron@amazon.com>
Subject: [PATCH] tpm: Use kfree_sensitive() to free auth session in tpm_dev_release()
Date: Thu, 9 Apr 2026 17:20:54 +0000
Message-ID: <20260409172108.11600-1-gunnarku@amazon.com>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D043UWA004.ant.amazon.com (10.13.139.41) To
 EX19D001UWA001.ant.amazon.com (10.13.138.214)
X-Spamd-Result: default: False [-7.66 / 15.00];
	WHITELIST_DMARC(-7.00)[amazon.com:D:+];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[amazon.com,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[amazon.com:s=amazoncorp2];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-9152-lists,linux-integrity=lfdr.de];
	FREEMAIL_TO(0.00)[gmx.de,kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_NEQ_ENVFROM(0.00)[gunnarku@amazon.com,linux-integrity@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns];
	RCPT_COUNT_SEVEN(0.00)[8];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[amazon.com:+];
	TAGGED_RCPT(0.00)[linux-integrity];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 00E223CE15A
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

tpm_dev_release() uses plain kfree() to free chip->auth, which contains
sensitive cryptographic material including HMAC session keys, nonces,
and passphrase data (struct tpm2_auth).

Every other code path that frees this structure uses kfree_sensitive()
to zero the memory before releasing it: both tpm2_end_auth_session()
and tpm_buf_check_hmac_response() do so. The tpm_dev_release() path
is the only one that does not, leaving key material in freed slab
memory until it is eventually overwritten.

Use kfree_sensitive() for consistency with the rest of the driver and
to ensure session keys are scrubbed during device teardown.

Fixes: 699e3efd6c64 ("tpm: Add HMAC session start and end functions")
Signed-off-by: Gunnar Kudrjavets <gunnarku@amazon.com>
Reviewed-by: Justinien Bouron <jbouron@amazon.com>
---
 drivers/char/tpm/tpm-chip.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/char/tpm/tpm-chip.c b/drivers/char/tpm/tpm-chip.c
index 082b910ddf0d..17d9d71774ec 100644
--- a/drivers/char/tpm/tpm-chip.c
+++ b/drivers/char/tpm/tpm-chip.c
@@ -247,7 +247,7 @@ static void tpm_dev_release(struct device *dev)
 	kfree(chip->work_space.context_buf);
 	kfree(chip->work_space.session_buf);
 #ifdef CONFIG_TCG_TPM2_HMAC
-	kfree(chip->auth);
+	kfree_sensitive(chip->auth);
 #endif
 	kfree(chip);
 }

base-commit: 03e5553f5fb99cb47c315e167a604a9c69e6f724
-- 
2.47.3


