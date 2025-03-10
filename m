Return-Path: <linux-integrity+bounces-5213-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D771CA59A30
	for <lists+linux-integrity@lfdr.de>; Mon, 10 Mar 2025 16:41:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 81DC11885ABE
	for <lists+linux-integrity@lfdr.de>; Mon, 10 Mar 2025 15:41:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7747922D7BE;
	Mon, 10 Mar 2025 15:40:54 +0000 (UTC)
X-Original-To: linux-integrity@vger.kernel.org
Received: from alt2.a-painless.mh.aa.net.uk (alt2.a-painless.mh.aa.net.uk [81.187.30.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 192D41DD0E7;
	Mon, 10 Mar 2025 15:40:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=81.187.30.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741621254; cv=none; b=PJhR258rx9HaHX2DhBoLRPcCP4BqzhH/2sM3TFTAtB78C6D2uZBF8wZK9n4w3681/sEgfDHTM9IH2eYi4k5tMFLnTgHvhb6LrdxfVUQRUWSiPjjL4/JioyL3uTYAcAALOCKnsDCD6aoRDiS0Tj9rZzAGIp1sljQGPMmM56FUBCQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741621254; c=relaxed/simple;
	bh=dvSUqYFo4lRq2EwnVVeBa6H1f2LPDhODymal1c22wbg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=qXsSnZWQ+8UReJxe5WXq0IeLOAthJhQ5mP2RgeVMlKUvdoCr8AQC/+1Ii5NHHDWH4p+vmhDdtmI21b7Wqyn6E3X2bQw3dEu1Rbww6ua8PqE/VQikjOnP1lpiR4u9I3O8eRZi43GE+Hwqx2O4HIp5wrX2kmRcmVc6A/Kz+HDPNOc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pileofstuff.org; spf=pass smtp.mailfrom=pileofstuff.org; arc=none smtp.client-ip=81.187.30.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pileofstuff.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pileofstuff.org
Received: from 0.9.9.0.0.0.0.0.0.0.0.0.0.0.0.0.0.5.8.0.9.1.8.0.0.b.8.0.1.0.0.2.ip6.arpa ([2001:8b0:819:850::990] helo=andrews-2024-laptop.lan)
	by painless-a.thn.aa.net.uk with esmtp (Exim 4.96)
	(envelope-from <kernel.org@pileofstuff.org>)
	id 1trfFJ-00Ew1Y-11;
	Mon, 10 Mar 2025 15:40:49 +0000
From: Andrew Sayers <kernel.org@pileofstuff.org>
To: Peter Huewe <peterhuewe@gmx.de>,
	Jarkko Sakkinen <jarkko@kernel.org>,
	Jason Gunthorpe <jgg@ziepe.ca>
Cc: Andrew Sayers <kernel.org@pileofstuff.org>,
	linux-integrity@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] tpm: Clarify "auth session active" message
Date: Mon, 10 Mar 2025 15:39:41 +0000
Message-ID: <20250310153942.15038-1-kernel.org@pileofstuff.org>
X-Mailer: git-send-email 2.47.2
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Without context, the obvious reading of "auth session is active" is
"auth session successfully activated".  In fact, this message means
"redundant extra attempt to activate auth session".

Signed-off-by: Andrew Sayers <kernel.org@pileofstuff.org>
---
 drivers/char/tpm/tpm2-sessions.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/char/tpm/tpm2-sessions.c b/drivers/char/tpm/tpm2-sessions.c
index 3f89635ba5e8..21589a75ed04 100644
--- a/drivers/char/tpm/tpm2-sessions.c
+++ b/drivers/char/tpm/tpm2-sessions.c
@@ -982,7 +982,7 @@ int tpm2_start_auth_session(struct tpm_chip *chip)
 	int rc;
 
 	if (chip->auth) {
-		dev_dbg_once(&chip->dev, "auth session is active\n");
+		dev_dbg_once(&chip->dev, "auth session already active\n");
 		return 0;
 	}
 
-- 
2.47.2


