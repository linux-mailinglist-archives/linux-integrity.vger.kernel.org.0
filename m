Return-Path: <linux-integrity+bounces-3633-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 948B997C0CA
	for <lists+linux-integrity@lfdr.de>; Wed, 18 Sep 2024 22:36:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5697A2838E0
	for <lists+linux-integrity@lfdr.de>; Wed, 18 Sep 2024 20:36:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A58311CB320;
	Wed, 18 Sep 2024 20:36:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ke3PSDuu"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F18417E019;
	Wed, 18 Sep 2024 20:36:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726691774; cv=none; b=h7+OApRggVvEnd4tWXhiuWKkYLm/OS13RukDChk0atT+E/u1P6Db8tXzjBIiWmcVhPi/Xu2QXIKP1ciiZ4wqojkvtuNgnMQR/gl1iThdpnRNJfbB0LFqGadaYd+bTz3vz2CV2M+Gy3ssB+PYocyxKTe5XYE25I75jvtscCWdrKo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726691774; c=relaxed/simple;
	bh=TvUdzspAQaz6C2R6RF1Y+KyYSdkWOqy1X74m1OujPCc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HroGzt9U9njuCK8l6WGBBvHS2AekWYWzulWjd2RIROkrDxLYZONABow88NUDEGz+xULFFoo/S/phAoqmAh53eCxvAHsoQWD4wrURGssir4gkQkUdTLdGwmxh4WeYKoME9Z42VZJ09qNccyyFJYAHWWBbxPh5Xl70zZfI6HSPQZc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ke3PSDuu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 69264C4CED3;
	Wed, 18 Sep 2024 20:36:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726691774;
	bh=TvUdzspAQaz6C2R6RF1Y+KyYSdkWOqy1X74m1OujPCc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Ke3PSDuuEou00Gz7bk61dWlz2sdBuQ91//vPiDUnCPZBxXvJvEnt8UEbpqVQFm/oq
	 myDwGR4KQvigZZ0X033+OjxVJfWjg/zc4RlaA7sFLCXPek2Rz0/FWRKcVxc7upSQvI
	 FrDTZ3FPFEDdCmnhybKbCVoaa4DczT0Xh72SJf3Pnb3tqrVYdam3aI0Nm17s+vG//v
	 dUiuaJUXqsDkwtGcWihP88O9QIqMqYwhXr91YdAMZRkDA2uY/D/XcFrMjRkQOVaGFr
	 fWk8bmoOcB8RY6TBmpsO0/b5dPPRZMjwXUsneLkLSrLHN39siMZVekowNW7AMMY42E
	 0ZfdDWFlIgZTQ==
From: Jarkko Sakkinen <jarkko@kernel.org>
To: linux-integrity@vger.kernel.org
Cc: James.Bottomley@HansenPartnership.com,
	roberto.sassu@huawei.com,
	mapengyu@gmail.com,
	Jarkko Sakkinen <jarkko@kernel.org>,
	stable@vger.kernel.org,
	Mimi Zohar <zohar@linux.ibm.com>,
	David Howells <dhowells@redhat.com>,
	Paul Moore <paul@paul-moore.com>,
	James Morris <jmorris@namei.org>,
	"Serge E. Hallyn" <serge@hallyn.com>,
	keyrings@vger.kernel.org,
	linux-security-module@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v4 1/5] tpm: Return on tpm2_create_null_primary() failure
Date: Wed, 18 Sep 2024 23:35:45 +0300
Message-ID: <20240918203559.192605-2-jarkko@kernel.org>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240918203559.192605-1-jarkko@kernel.org>
References: <20240918203559.192605-1-jarkko@kernel.org>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

tpm2_sessions_init() does not ignores the result of saving the null key.
Address this by printing either TPM or POSIX error code, and returning
-ENODEV back to the caller.

Cc: stable@vger.kernel.org # v6.10+
Fixes: d2add27cf2b8 ("tpm: Add NULL primary creation")
Signed-off-by: Jarkko Sakkinen <jarkko@kernel.org>
---
v4:
- Fixed up stable version.
v3:
- Handle TPM and POSIX error separately and return -ENODEV always back
  to the caller.
v2:
- Refined the commit message.
---
 drivers/char/tpm/tpm2-sessions.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/drivers/char/tpm/tpm2-sessions.c b/drivers/char/tpm/tpm2-sessions.c
index d3521aadd43e..795f4c7c6adb 100644
--- a/drivers/char/tpm/tpm2-sessions.c
+++ b/drivers/char/tpm/tpm2-sessions.c
@@ -1338,7 +1338,13 @@ static int tpm2_create_null_primary(struct tpm_chip *chip)
 		tpm2_flush_context(chip, null_key);
 	}
 
-	return rc;
+	if (rc < 0)
+		dev_err(&chip->dev, "saving the null key failed with error %d\n", rc);
+	else if (rc > 0)
+		dev_err(&chip->dev, "saving the null key failed with TPM error 0x%04X\n", rc);
+
+	/* Map all errors to -ENODEV: */
+	return rc ? -ENODEV : rc;
 }
 
 /**
@@ -1354,7 +1360,7 @@ int tpm2_sessions_init(struct tpm_chip *chip)
 
 	rc = tpm2_create_null_primary(chip);
 	if (rc)
-		dev_err(&chip->dev, "TPM: security failed (NULL seed derivation): %d\n", rc);
+		return rc;
 
 	chip->auth = kmalloc(sizeof(*chip->auth), GFP_KERNEL);
 	if (!chip->auth)
-- 
2.46.0


