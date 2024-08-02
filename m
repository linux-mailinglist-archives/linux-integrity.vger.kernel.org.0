Return-Path: <linux-integrity+bounces-3254-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DD1694645D
	for <lists+linux-integrity@lfdr.de>; Fri,  2 Aug 2024 22:27:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DC8FC28193B
	for <lists+linux-integrity@lfdr.de>; Fri,  2 Aug 2024 20:27:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98F8133DF;
	Fri,  2 Aug 2024 20:27:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b="iigZhOXW"
X-Original-To: linux-integrity@vger.kernel.org
Received: from bedivere.hansenpartnership.com (bedivere.hansenpartnership.com [96.44.175.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 103BA335C0
	for <linux-integrity@vger.kernel.org>; Fri,  2 Aug 2024 20:27:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=96.44.175.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722630458; cv=none; b=LLlxnj0+WDcj7k+ZFGqsnLCZY/KsE/SUM8u8tf0xJ9FAmetAhNYiV8rmdwnZXqzdwsOHD6bub7wwSGBnOnBFLdYRas55qexdliLvzfEb6IfPHIWurbq8gUxuaoUxNp4IUN4HBd6wNNVgtAw0lvn+oX1grzomt31iHyeAz+dWubQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722630458; c=relaxed/simple;
	bh=ByhhAf6fSfJ3HhoOdGTjoMruS4DwqOoGivFFdWqOKaQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=dfDImUmu3kC9jW4BUeBJtHpbGjV/zwfvGF61xGAm0vl7Z1SwffwsRQKW5SQ1FKVK2uC+9JTvjXsrrgcjuiU9Oz9/VGnvype/1ZbjUJQBW7SSXsI01k9iulq60IwbEfNYKDc1DGRzuA2SGDaH12vQEP5jHakmAuVDufl/cS4QfEk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=HansenPartnership.com; spf=pass smtp.mailfrom=HansenPartnership.com; dkim=pass (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b=iigZhOXW; arc=none smtp.client-ip=96.44.175.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=HansenPartnership.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=HansenPartnership.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=hansenpartnership.com; s=20151216; t=1722630456;
	bh=ByhhAf6fSfJ3HhoOdGTjoMruS4DwqOoGivFFdWqOKaQ=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:From;
	b=iigZhOXWBm50F3/G17zSUfPzKkdgVc2SYGyerBWi9452SVnvGnw+zfNMf8oxJ7eqj
	 +dAwPI2dkQakGA+fYjP/2QsXyvhKTN8LEvkZV6wXvmNQn0uS+O4KaJJZ78oZyGkNj6
	 N41z//d/rxyH017tX+s+TRkdxvhPQzfZtq1CCvxc=
Received: from localhost (localhost [127.0.0.1])
	by bedivere.hansenpartnership.com (Postfix) with ESMTP id 595501286AF9;
	Fri, 02 Aug 2024 16:27:36 -0400 (EDT)
Received: from bedivere.hansenpartnership.com ([127.0.0.1])
 by localhost (bedivere.hansenpartnership.com [127.0.0.1]) (amavis, port 10024)
 with ESMTP id X6gLxksNq6Qe; Fri,  2 Aug 2024 16:27:36 -0400 (EDT)
Received: from lingrow.int.hansenpartnership.com (unknown [153.66.160.227])
	by bedivere.hansenpartnership.com (Postfix) with ESMTP id D513812860B6;
	Fri, 02 Aug 2024 16:27:35 -0400 (EDT)
From: James Bottomley <James.Bottomley@HansenPartnership.com>
To: openssl-tpm2-engine@groups.io
Cc: linux-integrity@vger.kernel.org,
	Jarkko Sakkinen <jarkko@kernel.org>
Subject: [PATCH 8/8] tests: add tests for attest_tpm2_primary
Date: Fri,  2 Aug 2024 16:26:06 -0400
Message-Id: <20240802202606.12767-9-James.Bottomley@HansenPartnership.com>
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
 tests/attestation.sh       | 30 ++++++++++++++++++++++++++++++
 tests/check_importable.sh  |  3 +--
 tests/engine/Makefile.am   |  3 ++-
 tests/provider/Makefile.am |  3 ++-
 tests/seal_unseal.sh       |  3 +--
 tests/start_sw_tpm.sh      |  2 ++
 6 files changed, 38 insertions(+), 6 deletions(-)
 create mode 100755 tests/attestation.sh

diff --git a/tests/attestation.sh b/tests/attestation.sh
new file mode 100755
index 0000000..bd927fa
--- /dev/null
+++ b/tests/attestation.sh
@@ -0,0 +1,30 @@
+#!/bin/bash
+set -x
+
+##
+# We already created eksign.name and null.name, so check them first
+##
+${bindir}/attest_tpm2_primary --eksign --name ${testdir}/eksign.name || exit 1
+${bindir}/attest_tpm2_primary --eksign --name ${testdir}/null.name && exit 1
+${bindir}/attest_tpm2_primary --certify null --name ${testdir}/eksign.name ${testdir}/null.name || exit 1
+##
+# Run through certification of all the keys (already done null above
+##
+for h in owner endorsement platform; do
+    rm -f tmp.name
+    ${bindir}/attest_tpm2_primary -C ${h} -n ${testdir}/eksign.name -o > tmp.name || exit 1
+    ${bindir}/attest_tpm2_primary -C ${h} -n ${testdir}/eksign.name tmp.name || exit 1
+    ${bindir}/attest_tpm2_primary -C ${h} -n ${testdir}/eksign.name null.name && exit 1
+done
+##
+# attestation tests
+# 1. create both P-256 and RSA2048 attestation certs
+##
+openssl genrsa 2048 > ca.key || exit 1
+# several EK templates exist, so try RSA and EC for each
+for high in "" "-high"; do
+    for alg in "-rsa 2048" "-ecc nistp256"; do
+	tsscreateekcert ${high} ${alg} -cakey ca.key -of cert.der || exit 1
+	${bindir}/attest_tpm2_primary --attest cert.der --name ${testdir}/eksign.name || exit 1
+    done
+done
diff --git a/tests/check_importable.sh b/tests/check_importable.sh
index eeafe03..ee84f16 100755
--- a/tests/check_importable.sh
+++ b/tests/check_importable.sh
@@ -2,8 +2,7 @@
 
 
 # export the parent key as a EC and RSA public key
-prim=$(tsscreateprimary -ecc nistp256 -hi o -opem srk.pub | sed 's/Handle //') || exit 1
-tssflushcontext -ha ${prim} || exit 1
+${bindir}/attest_tpm2_primary --certify owner --name ${testdir}/eksign.name --file srk.pub || exit 1
 prim=$(tsscreateprimary -rsa 2048 -hi o -opem srkrsa.pub | sed 's/Handle //') || exit 1
 tssflushcontext -ha ${prim} || exit 1
 
diff --git a/tests/engine/Makefile.am b/tests/engine/Makefile.am
index ec6f321..7bade2b 100644
--- a/tests/engine/Makefile.am
+++ b/tests/engine/Makefile.am
@@ -30,6 +30,7 @@ TESTS += ../check_curves.sh \
 	../check_locality.sh \
 	../check_secret_policies.sh \
 	../dynamic_engine.sh \
+	../attestation.sh \
 	../stop_sw_tpm.sh
 
 fail_connect.sh: tpm_server_found
@@ -53,6 +54,6 @@ AM_TESTS_ENVIRONMENT = TPM_INTERFACE_TYPE=socsim; export TPM_INTERFACE_TYPE; \
 
 TEST_EXTENSIONS = .sh
 
-CLEANFILES = key*.tpm key*.pub key*.priv tmp.* NVChip h*.bin key*.der seal.* fifo tss2.*
+CLEANFILES = key*.tpm key*.pub key*.priv tmp.* NVChip h*.bin key*.der seal.* fifo tss2.* *.name
 clean-local:
 	rm -fr testdir
diff --git a/tests/provider/Makefile.am b/tests/provider/Makefile.am
index 1080036..05bbee1 100644
--- a/tests/provider/Makefile.am
+++ b/tests/provider/Makefile.am
@@ -31,6 +31,7 @@ TESTS += ../check_curves.sh \
 	../check_signed_policies.sh \
 	../check_locality.sh \
 	../check_secret_policies.sh \
+	../attestation.sh \
 	../stop_sw_tpm.sh
 
 fail_connect.sh: tpm_server_found
@@ -56,7 +57,7 @@ endif
 
 TEST_EXTENSIONS = .sh
 
-CLEANFILES = key*.tpm key*.pub key*.priv tmp.* NVChip h*.bin key*.der seal.* fifo tss2.*
+CLEANFILES = key*.tpm key*.pub key*.priv tmp.* NVChip h*.bin key*.der seal.* fifo tss2.* *.name
 clean-local:
 	rm -fr testdir
 
diff --git a/tests/seal_unseal.sh b/tests/seal_unseal.sh
index 6d05a4c..2df3aa8 100755
--- a/tests/seal_unseal.sh
+++ b/tests/seal_unseal.sh
@@ -48,8 +48,7 @@ for n in sha1 sha256 sha384; do
     else
 	POLICYFILE="${testdir}/policies/policy_pcr${n}.txt"
     fi
-    prim=$(tsscreateprimary -hi o -st -ecc nistp256 -opem srk.pub | sed 's/Handle //') || exit 1
-    tssflushcontext -ha $prim
+    ${bindir}/attest_tpm2_primary -C owner -n ${testdir}/eksign.name -f srk.pub || exit 1
     TPM_INTERFACE_TYPE= echo $DATA | ${bindir}/seal_tpm2_data -n ${n} -a -k ${AUTH} --import srk.pub seal.tpm || exit 1;
     ${bindir}/unseal_tpm2_data -k ${AUTH} seal.tpm | grep -q "${DATA}" || exit 1;
     rm seal.tpm
diff --git a/tests/start_sw_tpm.sh b/tests/start_sw_tpm.sh
index 5f249a5..1e0e4db 100755
--- a/tests/start_sw_tpm.sh
+++ b/tests/start_sw_tpm.sh
@@ -56,3 +56,5 @@ key=$(tsscreateprimary -hi o -st -rsa|sed 's/Handle //') && \
 tssevictcontrol -hi o -ho ${key} -hp 81000001 && \
 tssflushcontext -ha ${key}
 
+${bindir}/attest_tpm2_primary --ek > ${testdir}/eksign.name || exit 1
+${bindir}/attest_tpm2_primary --certify null --outname --name ${testdir}/eksign.name > ${testdir}/null.name || exit 1
-- 
2.35.3


