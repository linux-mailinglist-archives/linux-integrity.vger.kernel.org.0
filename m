Return-Path: <linux-integrity+bounces-8112-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A0E1CCB6D2
	for <lists+linux-integrity@lfdr.de>; Thu, 18 Dec 2025 11:37:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id AA0A3303463E
	for <lists+linux-integrity@lfdr.de>; Thu, 18 Dec 2025 10:37:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 997DD332ECC;
	Thu, 18 Dec 2025 10:37:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=avm.de header.i=@avm.de header.b="p4+21kPF"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mail.avm.de (mail.avm.de [212.42.244.94])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE9582ECD32;
	Thu, 18 Dec 2025 10:37:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.42.244.94
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766054266; cv=none; b=LsAWzyfJVaRoxuKpcm6eDoTT38UuK8FhCQXSUKHPc6b5UnsCA6usOO//R2mpuDcH0wlXKfdmtN81f0bwztPyDOHZKH7MV6h8Nq81ayEfVUkWxgpUMToEp2bAd6Dt3HrRuRSiDZQc5NMRXW6PgIGwNmLjQ5wBqDJbAbuftUkpwes=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766054266; c=relaxed/simple;
	bh=2PjZ4/sT6hVD8xEjfsP28DbcgYX9fkJHJwldgG7gODQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=sooxdyApoXRAoj5jXwQ0WD4il29OcaBsNSEqPOQN9Ub1Fox18ys3BiKmsfKsOp6T5wBOjiL0RahAJdzbPGjRXAQynKEmKPuZlzpuryrmJGqa8z3rRJT4JwenZC02sU8escUNZH63Foh4z/OGnbjd06dQmroC/xBGI3z7ohul3vc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=avm.de; spf=pass smtp.mailfrom=avm.de; dkim=pass (1024-bit key) header.d=avm.de header.i=@avm.de header.b=p4+21kPF; arc=none smtp.client-ip=212.42.244.94
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=avm.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=avm.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=avm.de; s=mail;
	t=1766053899; bh=2PjZ4/sT6hVD8xEjfsP28DbcgYX9fkJHJwldgG7gODQ=;
	h=From:To:Cc:Subject:Date:From;
	b=p4+21kPFK0E3swNe6i4Tn4s1VnYm+CCHyxAErd2xNeRoPcgN890g6WORbZe8JBxSR
	 rk/llgKgdv9UmNXuPC8IT7dDjRki/gqNf7foDmtOH2FRO0pXsmRmexrcgPTMwc6Z6z
	 YMkdqWehj2RxObdlNRpFPAA2pM0iVYlTnOCb+JJo=
Received: from [212.42.244.71] (helo=mail.avm.de)
	by mail.avm.de with ESMTP (eXpurgate 4.54.3)
	(envelope-from <phahn-oss@avm.de>)
	id 6943d80b-3a9b-7f0000032729-7f0000019432-1
	for <multiple-recipients>; Thu, 18 Dec 2025 11:31:39 +0100
Received: from mail-auth.avm.de (dovecot-mx-01.avm.de [212.42.244.71])
	by mail.avm.de (Postfix) with ESMTPS;
	Thu, 18 Dec 2025 11:31:39 +0100 (CET)
From: Philipp Hahn <phahn-oss@avm.de>
To: linux-integrity@vger.kernel.org
Cc: Philipp Hahn <phahn-oss@avm.de>,
	linux-kernel@vger.kernel.org,
	Nayna Jain <nayna@linux.ibm.com>,
	Mimi Zohar <zohar@linux.ibm.com>
Subject: [PATCH] integrity: Fix spelling mistake TRUSTED_KEYRING
Date: Thu, 18 Dec 2025 11:31:22 +0100
Message-ID: <4f736ebcd8a80c2e48c274cec027831d2986f792.1766053742.git.p.hahn@avm.de>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: AVM GmbH, Berlin, Germany
Content-Transfer-Encoding: 8bit
X-purgate-ID: 149429::1766053899-65F4A7BC-04ECF510/0/0
X-purgate-type: clean
X-purgate-size: 962
X-purgate-Ad: Categorized by eleven eXpurgate (R) https://www.eleven.de
X-purgate: This mail is considered clean (visit https://www.eleven.de for further information)
X-purgate: clean

Fix minor spelling mistake "kerne{d -> l}".

Cc: Nayna Jain <nayna@linux.ibm.com>
Cc: Mimi Zohar <zohar@linux.ibm.com>
Fixes: 9dc92c45177ab ("integrity: Define a trusted platform keyring")
Signed-off-by: Philipp Hahn <phahn-oss@avm.de>
---
 security/integrity/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/security/integrity/Kconfig b/security/integrity/Kconfig
index 916d4f2bfc441..328ea9f32035a 100644
--- a/security/integrity/Kconfig
+++ b/security/integrity/Kconfig
@@ -60,7 +60,7 @@ config INTEGRITY_PLATFORM_KEYRING
 	help
 	  Provide a separate, distinct keyring for platform trusted keys, which
 	  the kernel automatically populates during initialization from values
-	  provided by the platform for verifying the kexec'ed kerned image
+	  provided by the platform for verifying the kexec'ed kernel image
 	  and, possibly, the initramfs signature.
 
 config INTEGRITY_MACHINE_KEYRING
-- 
2.43.0


