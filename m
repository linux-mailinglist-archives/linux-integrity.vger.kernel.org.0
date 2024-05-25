Return-Path: <linux-integrity+bounces-2644-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 60B358CEEE4
	for <lists+linux-integrity@lfdr.de>; Sat, 25 May 2024 14:36:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5700B1C20AC6
	for <lists+linux-integrity@lfdr.de>; Sat, 25 May 2024 12:36:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD5F33A1BC;
	Sat, 25 May 2024 12:36:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ubWj447c"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 836AFDF62;
	Sat, 25 May 2024 12:36:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716640606; cv=none; b=d37LBzim/SfW1RCHSb2+IdEWlhPvK9W5QLRRghE+UW812n72ch17Cany4NdNmYHZDSeUowFhx2J+/Jg6M61Gk4Zcq61DzljbL7XZxxOrXY24vCSNS4ioR7Cbht5K1VZ2BOROmz/46qmAqyAEY/OqaPjwe32rtOVX1BZuI/TAl+s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716640606; c=relaxed/simple;
	bh=iYJiwZkq202sbFOQmZ/InspF352DafABToYi4GRr+ps=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=S87TlXO1XQ3xCG/hsTEV+JKWy5iOONh6wARkAexl33yRIJV5K9gOYmoRbG9G68xqYBhRPxP8sWjYsIus7sc2QxeNn/jCFQSSzOlJzWBQkg6N6B8iPb011E3P28My1EdqJUgjLkX1dDRAGj4WKSfLZvsUgw6SFElKW4Fvy9tSM6w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ubWj447c; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D1CC4C2BD11;
	Sat, 25 May 2024 12:36:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716640605;
	bh=iYJiwZkq202sbFOQmZ/InspF352DafABToYi4GRr+ps=;
	h=From:To:Cc:Subject:Date:From;
	b=ubWj447cpnppasdvMyvq08tvBeJD4k495DIDLj5VpV7XZXppojROdM94TAKzujuvb
	 bIhwbPJ2BQHa9TSWAFMNaEW0xOimICXZ6i0aWHc62jNFw+T3l9b4IWTsnwREX3H81J
	 aKLyPMBhXF6VZQSoTr+5xkl8ia+6YaWMmCiF/6WXIDjPX2J7ByQG+FNxmdTCI3dQCe
	 NU38ASVM37vlftlIWZr1BAgsNNJKy0v1VVr4F6Ei4/s1P5XQeCugJBX5ndJGNFfzW/
	 S2tryxDtyKrrlL8pmyBbPireptWqei0qzSC79MnxmTOcN/vYcJzsWa5c41osn2gq8d
	 SfT+ONdUOof9w==
From: Jarkko Sakkinen <jarkko@kernel.org>
To: linux-integrity@vger.kernel.org
Cc: keyrings@vger.kernel.org,
	James.Bottomley@HansenPartnership.com,
	Jarkko Sakkinen <jarkko@kernel.org>,
	stable@vger.kernel.org,
	Mimi Zohar <zohar@linux.ibm.com>,
	David Howells <dhowells@redhat.com>,
	Paul Moore <paul@paul-moore.com>,
	James Morris <jmorris@namei.org>,
	"Serge E. Hallyn" <serge@hallyn.com>,
	linux-security-module@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] KEYS: trusted_tpm2: Only check options->keyhandle for ASN.1
Date: Sat, 25 May 2024 15:36:33 +0300
Message-ID: <20240525123634.3396-1-jarkko@kernel.org>
X-Mailer: git-send-email 2.45.1
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

tpm2_load_cmd incorrectly checks options->keyhandle also for the legacy
format, as also implied by the inline comment. Check options->keyhandle
when ASN.1 is loaded.

Cc: James Bottomey <James.Bottomley@HansenPartnership.com>
Cc: stable@vger.kernel.org # v5.13+
Fixes: f2219745250f ("security: keys: trusted: use ASN.1 TPM2 key format for the blobs")
Signed-off-by: Jarkko Sakkinen <jarkko@kernel.org>
---
 security/keys/trusted-keys/trusted_tpm2.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/security/keys/trusted-keys/trusted_tpm2.c b/security/keys/trusted-keys/trusted_tpm2.c
index 8b7dd73d94c1..4f8207bf52a7 100644
--- a/security/keys/trusted-keys/trusted_tpm2.c
+++ b/security/keys/trusted-keys/trusted_tpm2.c
@@ -400,12 +400,11 @@ static int tpm2_load_cmd(struct tpm_chip *chip,
 		/* old form */
 		blob = payload->blob;
 		payload->old_format = 1;
+	} else {
+		if (!options->keyhandle)
+			return -EINVAL;
 	}
 
-	/* new format carries keyhandle but old format doesn't */
-	if (!options->keyhandle)
-		return -EINVAL;
-
 	/* must be big enough for at least the two be16 size counts */
 	if (payload->blob_len < 4)
 		return -EINVAL;
-- 
2.45.1


