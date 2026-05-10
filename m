Return-Path: <linux-integrity+bounces-9515-lists+linux-integrity=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-integrity@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eP8zHWu8AGpGMAEAu9opvQ
	(envelope-from <linux-integrity+bounces-9515-lists+linux-integrity=lfdr.de@vger.kernel.org>)
	for <lists+linux-integrity@lfdr.de>; Sun, 10 May 2026 19:12:11 +0200
X-Original-To: lists+linux-integrity@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id CC276505587
	for <lists+linux-integrity@lfdr.de>; Sun, 10 May 2026 19:12:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 08BE0300638F
	for <lists+linux-integrity@lfdr.de>; Sun, 10 May 2026 17:12:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07035388E72;
	Sun, 10 May 2026 17:12:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b="dqDIUKGq"
X-Original-To: linux-integrity@vger.kernel.org
Received: from pdx-out-011.esa.us-west-2.outbound.mail-perimeter.amazon.com (pdx-out-011.esa.us-west-2.outbound.mail-perimeter.amazon.com [52.35.192.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94A713B27FC;
	Sun, 10 May 2026 17:12:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.35.192.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778433127; cv=none; b=I1wopcm9cW5SNM4tvH7dOHf1D7xdlrFdSNFCmb+CFWlhMMlaqYc8M8HVU7JiV1D7uPnJxi7HWOlmBklgYaxv5WLbmxu+6ABdIwFury+eDlq4+AnOgtHlvb2Ll3wXdvZjMG7+LG70w9oY2nAQtF91DBOnTmhayVlqhE2CIK8XYa8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778433127; c=relaxed/simple;
	bh=AUH17FvoK6dWFJ+g16BI10LOlzZJOR3K8M/1lGCyOcM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ADKlfOzYiokdhI8Yw0wmPQXgj78QpHBzZdwCu/2gs8zi8Jdb/OGwjNgJkU+vj6hgZUJ/IwujHu5SKBAdzJiPwFbCAhAWpwloW/Jh8REXjEGJAaCeabYvWxZwAiUeXg6sfPvhArPeAUWZqyQ1bIVoakhB3qdJPxdqPG07FrIQsbU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.com; dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b=dqDIUKGq; arc=none smtp.client-ip=52.35.192.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazoncorp2;
  t=1778433126; x=1809969126;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=ZJknJJaSGB7gCArGDDao150Uo9ZuK5Qdfc6e5IiDpW8=;
  b=dqDIUKGqFfc+XGuNb163p/NcDnSCFYm5jGyMv6FPO+eYqy0BWt/GEMJ4
   68WodF4nVSQzEvsKDKIf9CH303UanCOTXjUbGz5aJD4jNq+p6ZJlaKvT6
   UlJUcGBfta9NF3e0VsEIdnRYWZmWfErCElXt4qSQQzDTCsWxB2nfpaweq
   YYN3GuXQi6rwlWoudPupdwOrXI7bj/t0g02DAnL4K5chXfBUmuyGXe8va
   DoxecysGqwFzaq4I8tD8Ktju6PQ8YqwClGr+eOX7Ifnd1U9MvmNYucT8I
   Z9uQ1ao1s5W0p/mBN5skgKxPpG7oMRUTxrR1XwsPwQPgO8YCGJh0Sn6In
   w==;
X-CSE-ConnectionGUID: K+Nw5BT2SsKGxdLY5drJEA==
X-CSE-MsgGUID: 2yWRH6l4Q82v7bl7gL5kVw==
X-IronPort-AV: E=Sophos;i="6.23,227,1770595200"; 
   d="scan'208";a="19076162"
Received: from ip-10-5-0-115.us-west-2.compute.internal (HELO smtpout.naws.us-west-2.prod.farcaster.email.amazon.dev) ([10.5.0.115])
  by internal-pdx-out-011.esa.us-west-2.outbound.mail-perimeter.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 May 2026 17:12:06 +0000
Received: from EX19MTAUWA002.ant.amazon.com [205.251.233.178:18148]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.4.227:2525] with esmtp (Farcaster)
 id 55a5fa4a-ef8a-41b8-ae38-f0a52c70cadc; Sun, 10 May 2026 17:12:05 +0000 (UTC)
X-Farcaster-Flow-ID: 55a5fa4a-ef8a-41b8-ae38-f0a52c70cadc
Received: from EX19D001UWA001.ant.amazon.com (10.13.138.214) by
 EX19MTAUWA002.ant.amazon.com (10.250.64.202) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.37;
 Sun, 10 May 2026 17:12:03 +0000
Received: from dev-dsk-gunnarku-2c-36117f29.us-west-2.amazon.com
 (172.23.139.22) by EX19D001UWA001.ant.amazon.com (10.13.138.214) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.37; Sun, 10 May 2026
 17:12:02 +0000
From: Gunnar Kudrjavets <gunnarku@amazon.com>
To: <jarkko@kernel.org>
CC: <gunnarku@amazon.com>, <jbouron@amazon.com>, <jgg@ziepe.ca>,
	<linux-integrity@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<mhijaz@amazon.com>, <noodles@meta.com>, <peterhuewe@gmx.de>
Subject: [PATCH v2] tpm: Initialize name_size_alg for non-NULL name in tpm_buf_append_name()
Date: Sun, 10 May 2026 17:11:27 +0000
Message-ID: <20260510171152.4607-1-gunnarku@amazon.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <af_imAiZEQ7WEe5W@kernel.org>
References: <af_imAiZEQ7WEe5W@kernel.org>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D039UWB004.ant.amazon.com (10.13.138.57) To
 EX19D001UWA001.ant.amazon.com (10.13.138.214)
X-Rspamd-Queue-Id: CC276505587
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-7.66 / 15.00];
	WHITELIST_DMARC(-7.00)[amazon.com:D:+];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[amazon.com,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[amazon.com:s=amazoncorp2];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[amazon.com,ziepe.ca,vger.kernel.org,meta.com,gmx.de];
	FROM_NEQ_ENVFROM(0.00)[gunnarku@amazon.com,linux-integrity@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-9515-lists,linux-integrity=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	DKIM_TRACE(0.00)[amazon.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCPT_COUNT_SEVEN(0.00)[9];
	NEURAL_HAM(-0.00)[-1.000];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns];
	TAGGED_RCPT(0.00)[linux-integrity];
	TO_DN_NONE(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Action: no action

tpm_buf_append_name() supports callers passing a pre-computed name
for handles. When name is non-NULL, the code skips the
tpm2_read_public() path but leaves name_size_alg uninitialized
before it is used as the memcpy size argument.

No current in-tree caller passes a non-NULL name, but future use
cases such as name caching would exercise this path. Initialize
name_size_alg by calling name_size() on the caller-provided name,
sharing the error check and assignment with the existing
tpm2_read_public() path. This prevents unmasking a latent bug when
the non-NULL name path is eventually used.

Assisted-by: Kiro:claude-opus-4.6
Reviewed-by: Justinien Bouron <jbouron@amazon.com>
Reviewed-by: Muhammad Hammad Ijaz <mhijaz@amazon.com>
Signed-off-by: Gunnar Kudrjavets <gunnarku@amazon.com>
---
 drivers/char/tpm/tpm2-sessions.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/drivers/char/tpm/tpm2-sessions.c b/drivers/char/tpm/tpm2-sessions.c
index c4da6fde748f..795cd99dc6fe 100644
--- a/drivers/char/tpm/tpm2-sessions.c
+++ b/drivers/char/tpm/tpm2-sessions.c
@@ -285,11 +285,14 @@ int tpm_buf_append_name(struct tpm_chip *chip, struct tpm_buf *buf,
 	    mso == TPM2_MSO_NVRAM) {
 		if (!name) {
 			ret = tpm2_read_public(chip, handle, auth->name[slot]);
-			if (ret < 0)
-				goto err;
-
-			name_size_alg = ret;
+		} else {
+			ret = name_size(name);
 		}
+
+		if (ret < 0)
+			goto err;
+
+		name_size_alg = ret;
 	} else {
 		if (name) {
 			dev_err(&chip->dev, "handle 0x%08x does not use a name\n",

base-commit: 44bd97559c26bb4d7abac09d29e58a4152d88567
--
2.47.3


