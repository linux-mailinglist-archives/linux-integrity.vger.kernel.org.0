Return-Path: <linux-integrity+bounces-9129-lists+linux-integrity=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-integrity@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ONJgCLX50mk3cwcAu9opvQ
	(envelope-from <linux-integrity+bounces-9129-lists+linux-integrity=lfdr.de@vger.kernel.org>)
	for <lists+linux-integrity@lfdr.de>; Mon, 06 Apr 2026 02:09:25 +0200
X-Original-To: lists+linux-integrity@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id B60493A0D09
	for <lists+linux-integrity@lfdr.de>; Mon, 06 Apr 2026 02:09:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A81C330067AD
	for <lists+linux-integrity@lfdr.de>; Mon,  6 Apr 2026 00:08:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DEFFA2030A;
	Mon,  6 Apr 2026 00:08:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="VJmcQmtP"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E734CA45
	for <linux-integrity@vger.kernel.org>; Mon,  6 Apr 2026 00:08:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775434111; cv=none; b=A6+ilpiGMxOSaVfvU3ddz/BWWLYy0rZizBO3JIh3wSAPjiyqQgX/vRvzD/O23AWWx5KJodpzWjNC8TOpBKxcHaGPYY+dlmZWmdbbUCvIgWs5wubr/rCrXklms4EgyBImoU/95zOQmBPRftPbATdnHH8B4sS6itqw0FjV/Lnbh9g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775434111; c=relaxed/simple;
	bh=BtwLE+mp+qYHw/iLmfuEOpeWsr3oHDXnkjTi5hNZzPY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RHJ7s0E1JcGUktTfyoEhWaEY18czrG0TC1DNfCkblYBx/4SusNplZfjeDUcOeOSYoCLFZs+0UxHM1CUM8V9ZZREZvZh+hbHceWogKJNax6LP+sV+jlrx20B1UcH6fPtWGTPscvYw9CF2oMTCPaaeFfZfx76UCjDkewcAZVXih00=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=VJmcQmtP; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 635LdNsH3550590;
	Mon, 6 Apr 2026 00:08:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=+O3RmYiHKSyEdd0Mf
	tF9w3bHqPkkB+o9AoYJHXd7m6k=; b=VJmcQmtPMv0+C8FbrWUOsC9THJnqAxSax
	A6qKKR2TcDuQREfWkwSNpjlPKPpGEnCVkhTvPPh5+oLFj1hxKgY3sJ6hfsKNxbLp
	wsOcID+LUAR0mzkKRuA+xlNgg2xKmm+4PYaf67iZKqTIOHo0noZm1XZHL7s6eBOq
	WLinMXz26WNTQRPpKbGg3GzicTxOTEju2a5Hc+cyYn4/moBNUc6o3+H1yYuxbv6E
	YCvqwVPtX/Am6L0Ii81JfDiXAUJ6auxRftpTYD1aLeYGohip4dZtQtV2OHfluGiY
	QE4q0XKsvL9gHBj93r6+fveM+SdNgQ3t3kc5R3WNATha7p4dONA/g==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4das2bvcbf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 06 Apr 2026 00:08:22 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 635MjKBj020549;
	Mon, 6 Apr 2026 00:08:21 GMT
Received: from smtprelay01.wdc07v.mail.ibm.com ([172.16.1.68])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4dbdynasw9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 06 Apr 2026 00:08:21 +0000
Received: from smtpav01.dal12v.mail.ibm.com (smtpav01.dal12v.mail.ibm.com [10.241.53.100])
	by smtprelay01.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 63608Jhx2229244
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 6 Apr 2026 00:08:20 GMT
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A609E5805D;
	Mon,  6 Apr 2026 00:08:19 +0000 (GMT)
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 4896658057;
	Mon,  6 Apr 2026 00:08:19 +0000 (GMT)
Received: from sbct-3.pok.ibm.com (unknown [9.47.158.153])
	by smtpav01.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Mon,  6 Apr 2026 00:08:19 +0000 (GMT)
From: Stefan Berger <stefanb@linux.ibm.com>
To: linux-integrity@vger.kernel.org
Cc: zohar@linux.ibm.com, roberto.sassu@huawei.com, ebiggers@kernel.org,
        coxu@redhat.com, Stefan Berger <stefanb@linux.ibm.com>
Subject: [ima-evm-utils PATCH 5/5] test: Add tests for signing and verifying with ML-DSA keys
Date: Sun,  5 Apr 2026 20:08:10 -0400
Message-ID: <20260406000810.4013201-6-stefanb@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260406000810.4013201-1-stefanb@linux.ibm.com>
References: <20260406000810.4013201-1-stefanb@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: HbDVRG6pUkguob2pTsaW6MnI3LgbGkR-
X-Proofpoint-GUID: HbDVRG6pUkguob2pTsaW6MnI3LgbGkR-
X-Authority-Analysis: v=2.4 cv=U9qfzOru c=1 sm=1 tr=0 ts=69d2f976 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VnNF1IyMAAAA:8 a=H2TL27a1Tc6UTgU1yToA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDA1MDI0NyBTYWx0ZWRfXznRoccyAb8uL
 UFZOpWIkNI1EZnPnNj6xadsogA+U91E4oBrntC2kQQYXou0kV/D9MBBzJHTCI+z5jisvb34NP4d
 PxGPFLzisJ2mE2qtTTsN5PUDrDQKJHgq4liICZhsGGCqvJIvuVmzD8Bgct3PnuQK5ACpoRSG3Uz
 MC+0jYvgGGZVSqarAI7MP85MVYQhyQcVEb/7+p5RYTN5KfA/J1Clwc7rVT49Xkku7utV/wzJ+tJ
 lkCUAHx9ZIxlCckQ3bbI6VGvlDF9kDirEUo4RNqCFK4/zuNm4LpUqaitpabiuvrChPjsp5Nzp6X
 pNBKwvPDIXJjjbORaVya66LjME3x0v9C2OpJqa164+L13WO0LdAqljQF50rYMhuIMBNXf3XmlJ8
 9h52AMuw0Q9+UqoCzc74LIQVdpTqNXA0y2irLqa2ewrHsGIZGbAgvtQcekIIiv5R0luMJ5gYJLX
 4pugxnfbqrfK/ivJJtg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-05_08,2026-04-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 malwarescore=0 clxscore=1015 adultscore=0 suspectscore=0
 spamscore=0 priorityscore=1501 impostorscore=0 lowpriorityscore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2603050001
 definitions=main-2604050247
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[ibm.com,none];
	R_DKIM_ALLOW(-0.20)[ibm.com:s=pp1];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-9129-lists,linux-integrity=lfdr.de];
	DKIM_TRACE(0.00)[ibm.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCPT_COUNT_FIVE(0.00)[6];
	FROM_NEQ_ENVFROM(0.00)[stefanb@linux.ibm.com,linux-integrity@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,linux.ibm.com:mid];
	TAGGED_RCPT(0.00)[linux-integrity];
	RCVD_COUNT_SEVEN(0.00)[11]
X-Rspamd-Queue-Id: B60493A0D09
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Create ML-DSA-44 & ML-DSA-65 keys if ML-DSA-44 can be created with the
installed version of OpenSSL. Add test cases for signing and verifying with
these types of keys.

Do not test with ML-DSA-87 keys since the signatures they create may be
too large for some filesystems' xattrs. On Btrfs for example it would be
possible to store the large signatures.

Signed-off-by: Stefan Berger <stefanb@linux.ibm.com>
---
 tests/gen-keys.sh      | 22 ++++++++++++++++++++++
 tests/sign_verify.test | 40 ++++++++++++++++++++++++++++++++--------
 2 files changed, 54 insertions(+), 8 deletions(-)

diff --git a/tests/gen-keys.sh b/tests/gen-keys.sh
index db0189a..13e6d77 100755
--- a/tests/gen-keys.sh
+++ b/tests/gen-keys.sh
@@ -148,6 +148,28 @@ if [ -x /opt/openssl3/bin/openssl ]; then
   done)
 fi
 
+# If creating mldsa44 key works, create all ML-DSA sizes
+if openssl genpkey -algorithm mldsa44 &>/dev/null; then
+  for mldsa in mldsa44 mldsa65; do
+    if [ "$1" = clean ] || [ "$1" = force ]; then
+      rm -f test-$mldsa.cer test-$mldsa.key test-$mldsa.pub
+    fi
+    if [ "$1" = clean ]; then
+      continue
+    fi
+    if [ ! -e test-$mldsa.key ]; then
+      log openssl req -verbose -new -nodes -utf8 -sha256 -days 10000 -batch -x509 \
+        -config test-ca.conf \
+        -newkey "$mldsa" \
+        -out test-$mldsa.cer -outform DER \
+        -keyout test-$mldsa.key
+      if [ -s test-$mldsa.key ]; then
+        log openssl pkey -in test-$mldsa.key -out test-$mldsa.pub -pubout
+      fi
+    fi
+  done
+fi
+
 # This script leaves test-ca.conf, *.cer, *.pub, *.key files for sing/verify tests.
 # They are never deleted except by `make distclean'.
 
diff --git a/tests/sign_verify.test b/tests/sign_verify.test
index 9319123..2b94b91 100755
--- a/tests/sign_verify.test
+++ b/tests/sign_verify.test
@@ -166,8 +166,15 @@ check_sign() {
     fi
 
     # Can openssl sign with this digest and key?
-    cmd="openssl dgst $OPENSSL_ENGINE $OPENSSL_KEYFORM -$ALG -sign $key -hex $FILE"
-    echo - "$cmd"
+    case "${KEY:0:10}" in
+    "test-mldsa")
+      cmd="openssl pkeyutl -sign -inkey $key -in $FILE"
+      echo >> "$FILE" # need at least 1 byte in the file for signing to work
+      ;;
+    *)
+      cmd="openssl dgst $OPENSSL_ENGINE $OPENSSL_KEYFORM -$ALG -sign $key -hex $FILE"
+      ;;
+    esac
     if ! $cmd >/dev/null; then
       echo "${CYAN}$ALG ($key) test is skipped (openssl is unable to sign)$NORM"
       return "$SKIP"
@@ -216,11 +223,21 @@ check_sign() {
   if [[ "$OPTS" =~ "--v3" ]]; then
     # In case of v3 signatures we need to create ima_file_id now.
     # All data for it can be found in PREFIX and by hashing $FILE.
-    echo -en "\x${PREFIX:2:2}\x${PREFIX:6:2}" > "$FILE.tmp"
+    echo -en "\x${PREFIX:2:2}\x${PREFIX:6:2}" > "$FILE.ima_file_id"
     # shellcheck disable=SC2086
-    openssl dgst $OPENSSL_ENGINE $OPENSSL_KEYFORM -"$ALG" -binary "$FILE" >> "$FILE.tmp"
-    cmd="openssl dgst $OPENSSL_ENGINE $OPENSSL_KEYFORM -$ALG -verify ${verifykey} \
-	  -signature $FILE.sig2 $FILE.tmp"
+    openssl dgst $OPENSSL_ENGINE $OPENSSL_KEYFORM -"$ALG" -binary "$FILE" \
+        >> "$FILE.ima_file_id"
+
+    case "${KEY:0:10}" in
+    "test-mldsa")
+      # ML-DSA does not accept a hash algorithm on command line
+      cmd="openssl dgst $OPENSSL_ENGINE $OPENSSL_KEYFORM       -verify ${verifykey} \
+	    -signature $FILE.sig2 $FILE.ima_file_id"
+      ;;
+    *)
+      cmd="openssl dgst $OPENSSL_ENGINE $OPENSSL_KEYFORM -$ALG -verify ${verifykey} \
+	    -signature $FILE.sig2 $FILE.ima_file_id"
+    esac
     sigver=3
   else
     cmd="openssl dgst $OPENSSL_ENGINE $OPENSSL_KEYFORM -$ALG -verify ${verifykey} \
@@ -232,11 +249,11 @@ check_sign() {
     color_red_on_failure
     echo "Signature v${sigver} verification with openssl is failed."
     color_restore
-    rm "$FILE.sig2" "$FILE.tmp"
+    rm "$FILE.sig2" "$FILE.ima_file_id"
     return "$FAIL"
   fi
 
-  rm "$FILE.sig2" "$FILE.tmp"
+  rm "$FILE.sig2" "$FILE.ima_file_id"
   return "$OK"
 }
 
@@ -424,6 +441,13 @@ sign_verify  prime256v1 sha256   0x030304:K:004[345678] --v3
 sign_verify  prime256v1 sha384   0x030305:K:004[345678] --v3
 sign_verify  prime256v1 sha512   0x030306:K:004[345678] --v3
 
+sign_verify  mldsa44    sha256   0x030304:K:0974 --v3
+sign_verify  mldsa44    sha384   0x030305:K:0974 --v3
+sign_verify  mldsa44    sha512   0x030306:K:0974 --v3
+sign_verify  mldsa65    sha256   0x030304:K:0ced --v3
+sign_verify  mldsa65    sha384   0x030305:K:0ced --v3
+sign_verify  mldsa65    sha512   0x030306:K:0ced --v3
+
 # If openssl 3.0 is installed, test the SM2/3 algorithm combination
 ssl_major_version=$(openssl version | sed -n 's/^OpenSSL \([^\.]\).*/\1/p')
 if [ "${ssl_major_version}" = 3 ]; then
-- 
2.53.0


