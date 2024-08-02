Return-Path: <linux-integrity+bounces-3253-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BDCA94645C
	for <lists+linux-integrity@lfdr.de>; Fri,  2 Aug 2024 22:27:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BFE511C20B8A
	for <lists+linux-integrity@lfdr.de>; Fri,  2 Aug 2024 20:27:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54FFE46B91;
	Fri,  2 Aug 2024 20:27:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b="dpzEChRN"
X-Original-To: linux-integrity@vger.kernel.org
Received: from bedivere.hansenpartnership.com (bedivere.hansenpartnership.com [96.44.175.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF98733DF
	for <linux-integrity@vger.kernel.org>; Fri,  2 Aug 2024 20:27:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=96.44.175.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722630457; cv=none; b=Bk6EpMX5mZM7Ewjx+5u1tw8X+h/EUa2JQrCbipOkZ/w1/CtTEkDBjLPFFob3DZnQiQWJW/rJhAhVKgMDPyVzvGZZlWgN9yBxgHkvhsgeLhk0Sa+i7PSBHQze7ba3T+p7oBf2/vzgvJdFHKz22GftxWlzAxhZJditaDOiUosPock=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722630457; c=relaxed/simple;
	bh=cU7MirEjue3zg6BCHr7QHRptOhzsj5tQgKiZMt610y4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=H8oGppv9UV5rQV6VOoHVGINkcttlHnedfPqhViBSp9uPNxe/1vAx28yet5nQKtgdawlp9clbpzlc7GOm27CR7zMHLS9WFvybkJp1YICI5VmzOS4N7t1D3wvxynncYN/azr3iDAuT5RMMRFOR/9wWwfGEbS2NZVLV8E3BQEPTa9w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=HansenPartnership.com; spf=pass smtp.mailfrom=HansenPartnership.com; dkim=pass (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b=dpzEChRN; arc=none smtp.client-ip=96.44.175.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=HansenPartnership.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=HansenPartnership.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=hansenpartnership.com; s=20151216; t=1722630455;
	bh=cU7MirEjue3zg6BCHr7QHRptOhzsj5tQgKiZMt610y4=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:From;
	b=dpzEChRNgTYcYPduyzX/fPscWYDlx15bCnemXmAujDg2ZPZBI7wLhBVXiVwBy+d0H
	 VJZNJFmLTnrHq0M5H4u3t/TLw3qXqVMK6ns+KA+82OzrScjCa83dAjA8+ivu0w9WBc
	 f8XuLGruTXBosQbKDdkhskqKobWFBQNXEMQh3+yI=
Received: from localhost (localhost [127.0.0.1])
	by bedivere.hansenpartnership.com (Postfix) with ESMTP id 38E2D1286A6B;
	Fri, 02 Aug 2024 16:27:35 -0400 (EDT)
Received: from bedivere.hansenpartnership.com ([127.0.0.1])
 by localhost (bedivere.hansenpartnership.com [127.0.0.1]) (amavis, port 10024)
 with ESMTP id pmEJ-w4RAkkr; Fri,  2 Aug 2024 16:27:35 -0400 (EDT)
Received: from lingrow.int.hansenpartnership.com (unknown [153.66.160.227])
	by bedivere.hansenpartnership.com (Postfix) with ESMTP id 990CB12860B6;
	Fri, 02 Aug 2024 16:27:34 -0400 (EDT)
From: James Bottomley <James.Bottomley@HansenPartnership.com>
To: openssl-tpm2-engine@groups.io
Cc: linux-integrity@vger.kernel.org,
	Jarkko Sakkinen <jarkko@kernel.org>
Subject: [PATCH 7/8] attest_tpm2_primary: add man page
Date: Fri,  2 Aug 2024 16:26:05 -0400
Message-Id: <20240802202606.12767-8-James.Bottomley@HansenPartnership.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20240802202606.12767-1-James.Bottomley@HansenPartnership.com>
References: <20240802202606.12767-1-James.Bottomley@HansenPartnership.com>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Signed-off-by: James Bottomley <James.Bottomley@HansenPartnership.com>
---
 src/tools/Makefile.am              |   5 +-
 src/tools/attest_tpm2_primary.1.in | 103 +++++++++++++++++++++++++++++
 2 files changed, 106 insertions(+), 2 deletions(-)
 create mode 100644 src/tools/attest_tpm2_primary.1.in

diff --git a/src/tools/Makefile.am b/src/tools/Makefile.am
index 7cca442..3012411 100644
--- a/src/tools/Makefile.am
+++ b/src/tools/Makefile.am
@@ -1,9 +1,10 @@
 if NATIVE_BUILD
 EXTRA_DIST = create_tpm2_key.1 load_tpm2_key.1 seal_tpm2_data.1 \
-	unseal_tpm2_data.1 signed_tpm2_policy.1 openssl_tpm2_engine.7
+	unseal_tpm2_data.1 signed_tpm2_policy.1 openssl_tpm2_engine.7 \
+	attest_tpm2_primary.1
 
 man1_MANS = create_tpm2_key.1 load_tpm2_key.1 seal_tpm2_data.1 \
-	unseal_tpm2_data.1 signed_tpm2_policy.1
+	unseal_tpm2_data.1 signed_tpm2_policy.1 attest_tpm2_primary.1
 man7_MANS = openssl_tpm2_engine.7
 
 CLEANFILES = $(man1_MANS)
diff --git a/src/tools/attest_tpm2_primary.1.in b/src/tools/attest_tpm2_primary.1.in
new file mode 100644
index 0000000..59476f7
--- /dev/null
+++ b/src/tools/attest_tpm2_primary.1.in
@@ -0,0 +1,103 @@
+[name]
+attest_tpm2_primary - perform certification and attestation operations for primary keys
+
+[description]
+
+TPMs have a complex set of commands for verifying primary keys.  Any
+TPM created signing key can be used to produce a "certification" of
+another key (a signed proof that key is present in the TPM).  However,
+the way this signing key is generated from a TPM X.509 certificate
+involves a complicated challenge/response round trip.  This tool is
+designed to present a simple way to perform the mechanics of these
+commands.
+
+[threat model]
+
+TPMs are vulnerable to man in the middle type attacks known as
+interposer attacks.  The first line of defence against them is to use
+TPM sessions for encryption and HMAC checking.  However, even after
+this is done, several other possible attacks remain including a reset
+based attack and a public key deception attack.  For more details see
+the Linux Kernel TPM security document:
+
+https://docs.kernel.org/security/tpm/tpm-security.html
+
+Public key deception is a problem because when salting sessions most
+TPM applications simply ask the TPM for a public key to encrypt the
+salt to.  So, if the interposer returns a key of its choosing, to
+which it has the private part, it can intercept and decrypt the
+session salt (and re-encrypt it with the correct key to pass on to the
+underlying TPM), significantly reducing or eliminating the security
+provided by sessions.  The solution to this problem is to verify the
+TPM provided key before it is used.
+
+[Attestation Keys]
+
+The original design of the TPM was to derive many disposable
+attestation keys (AKs) to frustrate tracking when used online.  This
+scheme involved a trusted PrivacyCA which would take the TPM EK,
+certificate and Attestation Key and return an Attestation Key
+Certificate if it all checked out.  The way this worked is that the
+PrivacyCA would construct a packet that could only be decrypted by a
+TPM2_ActivateCredential command, which involved a decryption operation
+that would only succeed if the TPM possessed the private parts of both
+the EK and the AK.  If this succeeded, the TPM could return the
+decrypted challenge to the PrivacyCA which would then issue the
+certificate.
+
+Unfortunately, no PrivacyCA was ever stood up and the threat model
+above really requires us to verify the TPM locally (so no privacy
+issues are involved).  The quick fix is to get the TPM to derive a
+signing EK key and attest it once with the TPMs EK certificate using
+the MakeCredential/ActivateCredential round trip locally.
+
+Ideally the name (unique hash) of this signing key should be
+permanently stored in the filesystem, say at /etc/eksign.name for use
+across boots.  Since this signing key is derived from the endorsement
+seed, which never changes even across TPM ownership changes it should
+be stable.
+
+For TPMs which don't have attestation certificates, this key should be
+collected when a laptop is first powered on with:
+
+  $ attest_tpm2_primary --eksign > /etc/eksign.name
+
+Which will derive the signing key and output it's name.
+
+If you do have an attestation certificate for your TPM, you should
+verify this signing key using the MakeCredential/ActivateCredential
+sequence thus:
+
+  $ attest_tpm2_primary --attest tpm-certificate.crt \\
+      --name /etc/eksign.name
+
+You should also verify tpm-certificate.crt chains back to the
+manufacturer.
+
+[kernel TPM verification]
+
+From version 6.10 onward, the Linux kernel uses sessions encrypted to
+the TPM NULL key to defeat interposer reset attacks.  Since the kernel
+exports the name of the NULL key it found, you can certify this key
+against your signing EK on every boot to be sure of the fidelity of
+the boot.
+
+  $ attest_tpm2_primary --certify null --name /etc/eksign.name \\
+      /sys/class/tpm/tpm0/null_name
+
+Which can be done via a systemd or other init system script.
+
+[Secure Import key]
+
+For importable keys and sealed objects, you need to be completely sure
+that the parent public key is correct.  Since most objects are stored
+in the owner hierarchy under the Storage Root Key (SRK), you can
+generate a verified public key to give out as an import key using
+
+  $ attest_tpm2_primary --certify --owner --name /etc/eksign.name \\
+      --file srk.pub
+
+Which will generate a PEM public key corresponding to the storage root
+only if the public part of the storage key can be certified against
+the signing EK, which ensures an interposer didn't give you the wrong
+public key to use for import.
-- 
2.35.3


