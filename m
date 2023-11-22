Return-Path: <linux-integrity+bounces-180-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 71F237F3E75
	for <lists+linux-integrity@lfdr.de>; Wed, 22 Nov 2023 07:57:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A37E61C20A8C
	for <lists+linux-integrity@lfdr.de>; Wed, 22 Nov 2023 06:57:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81523154B3;
	Wed, 22 Nov 2023 06:57:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=alliedtelesis.co.nz header.i=@alliedtelesis.co.nz header.b="ZRT9wru4"
X-Original-To: linux-integrity@vger.kernel.org
Received: from gate2.alliedtelesis.co.nz (gate2.alliedtelesis.co.nz [IPv6:2001:df5:b000:5::4])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20E2C1AA
	for <linux-integrity@vger.kernel.org>; Tue, 21 Nov 2023 22:57:29 -0800 (PST)
Received: from svr-chch-seg1.atlnz.lc (mmarshal3.atlnz.lc [10.32.18.43])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by gate2.alliedtelesis.co.nz (Postfix) with ESMTPS id AAF2A2C0240;
	Wed, 22 Nov 2023 19:57:26 +1300 (NZDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alliedtelesis.co.nz;
	s=mail181024; t=1700636246;
	bh=UUf0sol4MXR6E29PQDMqjrVE54IEFrYzEFPblgiH5pk=;
	h=From:To:Cc:Subject:Date:From;
	b=ZRT9wru4qojBDGFtQ6OJYF4V6fOwr3mXK2BvNqzAs3NuL+vLdPVsf1aQ7WT9pSJ1B
	 qRnqeJmCBDWmx9vrxiBS0gTElbbvJsSxExzRHyU9AUudarO/07ngML9UzvvNcCWSQh
	 YrBNaxgcMdT1sQTNa17YnsTn5i6davGXCIAL2WxLnK5ekk/qWZJbdJHZAwU4Rtsa/C
	 fy22V1T3NgMaDaY44mR0fDVsB/qZ6XaU1IZnBkcYwzSK4dLT6iVHgj43b5f5CFeK7f
	 tyw5CmkC134DRSNOMaL32RHGJpEs48zsgVX2jXt0h2xxZ6ldrbF++C8YGrloGgY3K2
	 RjvIrkIGmEmzQ==
Received: from pat.atlnz.lc (Not Verified[10.32.16.33]) by svr-chch-seg1.atlnz.lc with Trustwave SEG (v8,2,6,11305)
	id <B655da6560000>; Wed, 22 Nov 2023 19:57:26 +1300
Received: from angga-dl.ws.atlnz.lc (angga-dl.ws.atlnz.lc [10.33.22.36])
	by pat.atlnz.lc (Postfix) with ESMTP id 74B5313EDD7;
	Wed, 22 Nov 2023 19:57:26 +1300 (NZDT)
Received: by angga-dl.ws.atlnz.lc (Postfix, from userid 1025)
	id 6F0DD5639F4; Wed, 22 Nov 2023 19:57:26 +1300 (NZDT)
From: Hermin Anggawijaya <hermin.anggawijaya@alliedtelesis.co.nz>
To: peterhuewe@gmx.de,
	jarkko@kernel.org,
	jgg@ziepe.ca
Cc: linux-integrity@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Hermin Anggawijaya <hermin.anggawijaya@alliedtelesis.co.nz>
Subject: [PATCH] tpm: Start the tpm2 before running a self test.
Date: Wed, 22 Nov 2023 19:55:28 +1300
Message-ID: <20231122065528.1049819-1-hermin.anggawijaya@alliedtelesis.co.nz>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-SEG-SpamProfiler-Analysis: v=2.3 cv=AZXP4EfG c=1 sm=1 tr=0 a=KLBiSEs5mFS1a/PbTCJxuA==:117 a=BNY50KLci1gA:10 a=rJFBBZ_W6pJUP7hz3OAA:9 a=ZXulRonScM0A:10 a=zZCYzV9kfG8A:10
X-SEG-SpamProfiler-Score: 0
x-atlnz-ls: pat

Before sending a command to attempt the self test, the TPM
may need to be started, otherwise the self test returns
TPM2_RC_INITIALIZE value causing a log as follows:
"tpm tpm0: A TPM error (256) occurred attempting the self test".

Signed-off-by: Hermin Anggawijaya <hermin.anggawijaya@alliedtelesis.co.nz=
>
---
 drivers/char/tpm/tpm2-cmd.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/char/tpm/tpm2-cmd.c b/drivers/char/tpm/tpm2-cmd.c
index 93545be190a5..0530f3b5f86a 100644
--- a/drivers/char/tpm/tpm2-cmd.c
+++ b/drivers/char/tpm/tpm2-cmd.c
@@ -737,15 +737,15 @@ int tpm2_auto_startup(struct tpm_chip *chip)
 	if (rc)
 		goto out;
=20
+	rc =3D tpm2_startup(chip);
+	if (rc && rc !=3D TPM2_RC_INITIALIZE)
+		goto out;
+
 	rc =3D tpm2_do_selftest(chip);
 	if (rc && rc !=3D TPM2_RC_INITIALIZE)
 		goto out;
=20
 	if (rc =3D=3D TPM2_RC_INITIALIZE) {
-		rc =3D tpm2_startup(chip);
-		if (rc)
-			goto out;
-
 		rc =3D tpm2_do_selftest(chip);
 		if (rc)
 			goto out;
--=20
2.43.0


