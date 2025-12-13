Return-Path: <linux-integrity+bounces-7963-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 4ABC5CBB372
	for <lists+linux-integrity@lfdr.de>; Sat, 13 Dec 2025 21:34:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id C69C2300BECA
	for <lists+linux-integrity@lfdr.de>; Sat, 13 Dec 2025 20:34:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CAE8D2BD5BF;
	Sat, 13 Dec 2025 20:33:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tOw5vway"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B8282BE7CB;
	Sat, 13 Dec 2025 20:33:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765658022; cv=none; b=ZIZjdaRquGZSYfwng2wwDCHzHOrw5ah+6vFkrxIcwXq+O4G9KKj3ynFY1gs34U3tqeD9NI2wNj6KBEAf4ZuwtTi4H+76/q/r/DYqJ1+Z6qz6NjPJZy01IsLLBrP1dhM/t7RtRgIkY9QHQFfS5jpOVkrlpNgDgfn4YzPS7g1MBfo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765658022; c=relaxed/simple;
	bh=ose2oB/fvx8BkW6CVHK5os3jHRlOiK5rAT97U08pq4o=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=lDIVDLbE2GZA9WNR91A5InxLhEoX4aaGz7EEzcuXsgG8tzOt+APMgW98jVPNoC70izNUzse6+Od+GL7dH5FmXkfAOw/XA2232oPOVsnmRbBkyZ/up5qjF3kYycYz9iHFHzqriZ17nSkdX5OqmTIPKr7H85WGrjbt2mtAsfXKR5s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tOw5vway; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C0957C4CEF7;
	Sat, 13 Dec 2025 20:33:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765658022;
	bh=ose2oB/fvx8BkW6CVHK5os3jHRlOiK5rAT97U08pq4o=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=tOw5vwayEA6Mn3bsgv6IyTGMaUYl1Fn0R8+njXbfLiVBLnVCvRDn77YV2/UfQCSk+
	 sh36qYz2Iq3+fi7iATYT4e5bVRWlQGgjB03YKnQ6pTK5tIK3cxnI1M1naJrN5LOCw3
	 KDTGqbBxDP2wHRhz6O9r3iGRgH7g6UwgnmmRhitYWXCHU6xVk7jneqBN9tIyb5KdvM
	 Icnq1mLaMKx7VvDLgltDRV6KXsq73ayCQmukPFCQFG3+n62ozvzfEWl9F7fifUSEc0
	 AlUWGjX/FYgV9Kg5BkuAID+WpUpNhyVusO6PBzpyX66scrfdlGZQE0BzsfIkGXv6TK
	 ZqBTqFqieLe0Q==
From: Jarkko Sakkinen <jarkko@kernel.org>
To: linux-integrity@vger.kernel.org
Cc: Ross Philipson <ross.philipson@oracle.com>,
	Jarkko Sakkinen <jarkko@kernel.org>,
	Peter Huewe <peterhuewe@gmx.de>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	David Howells <dhowells@redhat.com>,
	Paul Moore <paul@paul-moore.com>,
	James Morris <jmorris@namei.org>,
	"Serge E. Hallyn" <serge@hallyn.com>,
	linux-kernel@vger.kernel.org (open list),
	keyrings@vger.kernel.org (open list:KEYS/KEYRINGS),
	linux-security-module@vger.kernel.org (open list:SECURITY SUBSYSTEM)
Subject: [PATCH v5 12/12] tpm: In tpm_get_random() replace 'retries' with a zero check
Date: Sat, 13 Dec 2025 22:32:19 +0200
Message-Id: <20251213203220.317498-13-jarkko@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20251213203220.317498-1-jarkko@kernel.org>
References: <20251213203220.317498-1-jarkko@kernel.org>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Check for zero byte read instead of having retries counter in order to make
wait flag properly enforcing. Progress is still guaranteed given the zero
check and iterations are capped up to TPM_MAX_RNG_DATA iterations at most
(as per theoretical limit).

Signed-off-by: Jarkko Sakkinen <jarkko@kernel.org>
---
 drivers/char/tpm/tpm-interface.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/drivers/char/tpm/tpm-interface.c b/drivers/char/tpm/tpm-interface.c
index 5cc2bbabd57a..594ad095a90b 100644
--- a/drivers/char/tpm/tpm-interface.c
+++ b/drivers/char/tpm/tpm-interface.c
@@ -620,7 +620,6 @@ int tpm_get_random(struct tpm_chip *chip, u8 *out, size_t max, bool wait)
 {
 	u32 num_bytes = max;
 	u8 *out_ptr = out;
-	int retries = 5;
 	int total = 0;
 	int rc;
 
@@ -646,8 +645,12 @@ int tpm_get_random(struct tpm_chip *chip, u8 *out, size_t max, bool wait)
 		else
 			rc = tpm1_get_random(chip, out_ptr, num_bytes);
 
-		if (rc < 0)
+		if (rc <= 0) {
+			if (!rc)
+				rc = -EIO;
+
 			goto err;
+		}
 
 		if (!wait) {
 			total = rc;
@@ -657,7 +660,7 @@ int tpm_get_random(struct tpm_chip *chip, u8 *out, size_t max, bool wait)
 		out_ptr += rc;
 		total += rc;
 		num_bytes -= rc;
-	} while (retries-- && total < max);
+	} while (total < max);
 
 	tpm_put_ops(chip);
 	return total ? total : -EIO;
-- 
2.39.5


