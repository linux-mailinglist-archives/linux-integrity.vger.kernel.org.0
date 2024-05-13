Return-Path: <linux-integrity+bounces-2379-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 031978C46F5
	for <lists+linux-integrity@lfdr.de>; Mon, 13 May 2024 20:35:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 82E8AB21A87
	for <lists+linux-integrity@lfdr.de>; Mon, 13 May 2024 18:35:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3A47381C6;
	Mon, 13 May 2024 18:35:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kdUm4mLd"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABA0A2E631;
	Mon, 13 May 2024 18:35:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715625328; cv=none; b=IYby7TbTNFjVUhBQwADROvk27K64T2+oqbvGONBjLv5NwkrIwaYfrENOckQ8s3yLJh/THXs46pGck7WZvWNuFEYOvkSRfXU52Sj94VIoBsogU2sus8foGr08SzybwF7q+6qdbqYRFXv/fNFiIOJA6e2hL3DAz7Ps3pNXCsUJK4M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715625328; c=relaxed/simple;
	bh=YKbPkKlqAwoRaNZqki6fpfGRkig5wtpfRBksExN/W+4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=GyEn7lw523Mjm3Sf1bd5N0EHQrexyruyxNfoM/BYPjTmgG7Gs6jwbgWSHSRt26O1vPCYBWHe2ZufXgxZ5337Py3OyYXI4/Wfe4kswyNKIZmV5vusSTW64ovuFGaiFuo+XCSDygThhL37V+DE6/9u/v2WWAibnKLO1Mkbw0PkeA0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kdUm4mLd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BE3E4C113CC;
	Mon, 13 May 2024 18:35:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715625328;
	bh=YKbPkKlqAwoRaNZqki6fpfGRkig5wtpfRBksExN/W+4=;
	h=From:To:Cc:Subject:Date:From;
	b=kdUm4mLdt6zonDi2uj1fC/4yvUuFv7+8Yf1ocwHVZVTXuoGnZ1WetV+VPrITiJ00/
	 0ArlywI8B0iDrEvkfZaMVc+Gd6cDtnD3nnlD2sT3ut3tfJ+gjzgtRXlvI0DhQ2N1Wb
	 yRcv/KFQUloyZ6eDmhGQlKxZHP/TVwagCOVArll6rUlUWcaz2yxxjgcnvtwxkOtG8C
	 4M1v47TFLU8EKmW9BDwdDkzpn29CqRZoCnXbFJH3G4t9zDP2r98iHWvQhPHHLPF9Qf
	 ckas1s2zW6jNAP0wWeqNsNxt90ijUwYzEuz92SyUmAkM6vhY/naqjDZhZQfi9rX6eG
	 9BobUVT2+XpDg==
From: Jarkko Sakkinen <jarkko@kernel.org>
To: linux-integrity@vger.kernel.org
Cc: Jarkko Sakkinen <jarkko@kernel.org>,
	stable@vger.kernel.org,
	James Bottomley <James.Bottomley@HansenPartnership.com>,
	Mimi Zohar <zohar@linux.ibm.com>,
	David Howells <dhowells@redhat.com>,
	Paul Moore <paul@paul-moore.com>,
	James Morris <jmorris@namei.org>,
	"Serge E. Hallyn" <serge@hallyn.com>,
	keyrings@vger.kernel.org (open list:KEYS-TRUSTED),
	linux-security-module@vger.kernel.org (open list:SECURITY SUBSYSTEM),
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH] KEYS: trusted: Do not use WARN when encode fails
Date: Mon, 13 May 2024 21:35:17 +0300
Message-ID: <20240513183518.10922-1-jarkko@kernel.org>
X-Mailer: git-send-email 2.45.0
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Error on asn1_encode_sequence() is handled with a WARN incorrectly
because:

1. asn1_encode_sequence() is not an internal function (located
   in lib/asn1_encode.c).
2. Location on known, which makes the stack trace useless.
3. Results a crash if panic_on_warn is set.

It is also noteworthy that the use of WARN is undocumented, and it
should be avoided unless there is carefully considered rationale to use
it, which is now non-existent.

Replace WARN with pr_err, and print the return value instead, which is
only useful piece of information (and was not printed).

Cc: stable@vger.kernel.org # v5.13+
Fixes: f2219745250f ("security: keys: trusted: use ASN.1 TPM2 key format for the blobs")
Signed-off-by: Jarkko Sakkinen <jarkko@kernel.org>
---
 security/keys/trusted-keys/trusted_tpm2.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/security/keys/trusted-keys/trusted_tpm2.c b/security/keys/trusted-keys/trusted_tpm2.c
index c8d8fdefbd8d..e31fe53822a1 100644
--- a/security/keys/trusted-keys/trusted_tpm2.c
+++ b/security/keys/trusted-keys/trusted_tpm2.c
@@ -39,6 +39,7 @@ static int tpm2_key_encode(struct trusted_key_payload *payload,
 	u8 *end_work = scratch + SCRATCH_SIZE;
 	u8 *priv, *pub;
 	u16 priv_len, pub_len;
+	int ret;
 
 	priv_len = get_unaligned_be16(src) + 2;
 	priv = src;
@@ -80,8 +81,11 @@ static int tpm2_key_encode(struct trusted_key_payload *payload,
 	work1 = payload->blob;
 	work1 = asn1_encode_sequence(work1, work1 + sizeof(payload->blob),
 				     scratch, work - scratch);
-	if (WARN(IS_ERR(work1), "BUG: ASN.1 encoder failed"))
-		return PTR_ERR(work1);
+	if (IS_ERR(work1)) {
+		ret = PTR_ERR(work1);
+		pr_err("ASN.1 encode error %d\n", ret);
+		return ret;
+	}
 
 	return work1 - payload->blob;
 }
-- 
2.45.0


