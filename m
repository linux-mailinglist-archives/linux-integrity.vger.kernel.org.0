Return-Path: <linux-integrity+bounces-9075-lists+linux-integrity=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-integrity@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sPVBHacKw2lKnwQAu9opvQ
	(envelope-from <linux-integrity+bounces-9075-lists+linux-integrity=lfdr.de@vger.kernel.org>)
	for <lists+linux-integrity@lfdr.de>; Tue, 24 Mar 2026 23:05:27 +0100
X-Original-To: lists+linux-integrity@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id CC19131D187
	for <lists+linux-integrity@lfdr.de>; Tue, 24 Mar 2026 23:05:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id BC2D430180AC
	for <lists+linux-integrity@lfdr.de>; Tue, 24 Mar 2026 22:03:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE034333442;
	Tue, 24 Mar 2026 22:03:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="m0cffcK5"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85CCB23B612
	for <linux-integrity@vger.kernel.org>; Tue, 24 Mar 2026 22:03:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774389808; cv=none; b=i5q9DG9EMzpoQyKecA9hKapXdMqMZ/OA6Ro50LBfcZXs1BM3+dyZfpvD1XU4Mqh6kgxSi7dg9dIKOKASrobFBrmREZSjJLG2ZZHJuuEtrOoSwo/JClWQrmsDpY3D7EeEx4G6x+t9RqBiQIaGfQTZk5kGW+qXn8Wj0W3kRmjrKac=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774389808; c=relaxed/simple;
	bh=9GPpD7McS7FbL3qy9tDFw3VR1lA4waswoFgblGhxDyU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WuWED7ZSRO+0BLVM66e8s/7Hyd0wrs2jZoVULLJuJ6+uSWeD6qWhFgKrb0rWGt3KUorjVbgvxmWz8m3zimaAmV/NBufcbvoxllI19r1Xi2rYnVVD+87h3me9kv5ZaXcZxd3FdyNbSDXW/8mmPcvl8VGVp4h6SRb69Cy48EKuC+o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=m0cffcK5; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62OKbCpS666646;
	Tue, 24 Mar 2026 22:03:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=4xF+6+lEyGdWsvsVV
	ApH6hb1BO2zvZd7uHYJS5MR/wQ=; b=m0cffcK5F6ypuP/FDU59lJRdlD5039fRP
	/8pLPDo79ZJKbjBPTAp4Bt6cMSWWQJDCYuh4uNUTC2Kwx0QpoYbxJPv6XI/fW/cb
	Bs6kfAauYzDSqX5hvLmeDgsh+cOiqBwegZ4XX7lTmDfnNMI3ZU/99VKEl9Zks5c0
	bdcPvtvLsS6estY17Bn1qkfgaf9ki6XUxYvUzlmHKONsulCAj3fcfXGadBS7YibS
	HPGSa+J/WfrZcPsN7Gi1N3NqlTE/SxxS4SaPPZ93t9KDte3NoUGtOEVv92HvhpaS
	tTFuVHndIBQMoOkjfPsn3F7ZgZiv7ejjaI3TxM3Jwr2y8Vmq5Jx5Q==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4d1ktxww81-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 24 Mar 2026 22:03:21 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 62OItDn0031592;
	Tue, 24 Mar 2026 22:03:21 GMT
Received: from smtprelay06.dal12v.mail.ibm.com ([172.16.1.8])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4d25nsv5pq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 24 Mar 2026 22:03:21 +0000
Received: from smtpav04.dal12v.mail.ibm.com (smtpav04.dal12v.mail.ibm.com [10.241.53.103])
	by smtprelay06.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 62OM3KWq22741720
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 24 Mar 2026 22:03:20 GMT
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id EE1A058056;
	Tue, 24 Mar 2026 22:03:19 +0000 (GMT)
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A146658052;
	Tue, 24 Mar 2026 22:03:19 +0000 (GMT)
Received: from sbct-3.pok.ibm.com (unknown [9.47.158.153])
	by smtpav04.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 24 Mar 2026 22:03:19 +0000 (GMT)
From: Stefan Berger <stefanb@linux.ibm.com>
To: linux-integrity@vger.kernel.org
Cc: zohar@linux.ibm.com, roberto.sassu@huawei.com,
        Stefan Berger <stefanb@linux.ibm.com>
Subject: [ima-evm-utils: PATCH 6/8] tests: Add new --v3 option to sign_verify tests
Date: Tue, 24 Mar 2026 18:03:12 -0400
Message-ID: <20260324220314.743709-7-stefanb@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260324220314.743709-1-stefanb@linux.ibm.com>
References: <20260324220314.743709-1-stefanb@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=IqITsb/g c=1 sm=1 tr=0 ts=69c30a29 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=uAbxVGIbfxUO_5tXvNgY:22 a=VnNF1IyMAAAA:8 a=E3jwDswNOdico4QOt1cA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzI0MDE2OCBTYWx0ZWRfX1BwfoYBzh+JH
 /3cibFrL0B51okXHMn78Ro74o5vFwB+F2wF102Ob304/ytXGGImqH1JVYH05Ty+FX7xQAtJC2BP
 Rdo8X2CFayF8Y2HSwHnHKt2o6dokMyZqGsVr8TBSOx9Kb3eQ1HD05UQYvQ1WN1UFFcadOeyZhSe
 /M+B1ofuhoxf54ZgH92+YOf6e1AhNI+jlE6OADauF3+i/RpiGP4cxkLPT4vavpVBZbte8BxfS7C
 J2G1qv2ozDx+DynZs5EmZSSnNRFAfzi9QTOV+Nrbk8PBRzSvmqEdb15ISiHEj9vVPDdtS3TDW//
 ZiJYGLHAB9sBIaR+sxI7e4RH2SI6MCb85uWuhu01xBK8k7qSy6tVr7uf9odA2VhgMpGuinG40pO
 zZ5o3VxK3Fv7oXcp2QonywzS5gzAkVYt2YXddj2shUt2X4qoP6mF8yY3m76JMPTac6g7P1ia0EQ
 vhJn7Fc7ECojMUT9vCQ==
X-Proofpoint-GUID: d7crvLa-7bfyRvR2psrKRQtxaVHBdz9B
X-Proofpoint-ORIG-GUID: d7crvLa-7bfyRvR2psrKRQtxaVHBdz9B
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-24_03,2026-03-24_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 clxscore=1015 spamscore=0 impostorscore=0 suspectscore=0
 phishscore=0 bulkscore=0 adultscore=0 priorityscore=1501 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2603240168
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[ibm.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[ibm.com:s=pp1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[ibm.com:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-9075-lists,linux-integrity=lfdr.de];
	RCPT_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[stefanb@linux.ibm.com,linux-integrity@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.ibm.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns];
	TAGGED_RCPT(0.00)[linux-integrity];
	RCVD_COUNT_SEVEN(0.00)[11]
X-Rspamd-Queue-Id: CC19131D187
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Add the new --v3 option to the sign_verify test cases.

For --v3, adjust openssl signature verification to build an ima_file_id
structure in a file that is then used for signature verification rather
than the plain file (as before).

Signed-off-by: Stefan Berger <stefanb@linux.ibm.com>
---
 tests/sign_verify.test | 31 +++++++++++++++++++++++++------
 1 file changed, 25 insertions(+), 6 deletions(-)

diff --git a/tests/sign_verify.test b/tests/sign_verify.test
index c94de24..9319123 100755
--- a/tests/sign_verify.test
+++ b/tests/sign_verify.test
@@ -128,7 +128,7 @@ check_sign() {
   # OPTS (additional options for evmctl),
   # FILE (working file to sign).
   local "$@"
-  local key verifykey
+  local key verifykey sigver
   local FILE=${FILE:-$ALG.txt}
 
   # Normalize key filename if it's not a pkcs11 URI
@@ -213,18 +213,30 @@ check_sign() {
       verifykey=${key}
   fi
 
-  cmd="openssl dgst $OPENSSL_ENGINE $OPENSSL_KEYFORM -$ALG -verify ${verifykey} \
-	-signature $FILE.sig2 $FILE"
+  if [[ "$OPTS" =~ "--v3" ]]; then
+    # In case of v3 signatures we need to create ima_file_id now.
+    # All data for it can be found in PREFIX and by hashing $FILE.
+    echo -en "\x${PREFIX:2:2}\x${PREFIX:6:2}" > "$FILE.tmp"
+    # shellcheck disable=SC2086
+    openssl dgst $OPENSSL_ENGINE $OPENSSL_KEYFORM -"$ALG" -binary "$FILE" >> "$FILE.tmp"
+    cmd="openssl dgst $OPENSSL_ENGINE $OPENSSL_KEYFORM -$ALG -verify ${verifykey} \
+	  -signature $FILE.sig2 $FILE.tmp"
+    sigver=3
+  else
+    cmd="openssl dgst $OPENSSL_ENGINE $OPENSSL_KEYFORM -$ALG -verify ${verifykey} \
+	  -signature $FILE.sig2 $FILE"
+    sigver=2
+  fi
   echo - "$cmd"
   if ! $cmd; then
     color_red_on_failure
-    echo "Signature v2 verification with openssl is failed."
+    echo "Signature v${sigver} verification with openssl is failed."
     color_restore
-    rm "$FILE.sig2"
+    rm "$FILE.sig2" "$FILE.tmp"
     return "$FAIL"
   fi
 
-  rm "$FILE.sig2"
+  rm "$FILE.sig2" "$FILE.tmp"
   return "$OK"
 }
 
@@ -390,6 +402,9 @@ sign_verify  rsa1024  sha384  0x030205:K:0080
 sign_verify  rsa1024  sha512  0x030206:K:0080
 sign_verify  rsa1024  rmd160  0x030203:K:0080
 
+sign_verify rsa1024  sha384  0x030305:K:0080 --v3
+sign_verify rsa1024  sha512  0x030306:K:0080 --v3
+
 # Test v2 signatures with ECDSA
 # Signature length is typically 0x34-0x38 bytes long, very rarely 0x33
 sign_verify  prime192v1 sha1   0x030202:K:003[345678]
@@ -405,6 +420,10 @@ sign_verify  prime256v1 sha256 0x030204:K:004[345678]
 sign_verify  prime256v1 sha384 0x030205:K:004[345678]
 sign_verify  prime256v1 sha512 0x030206:K:004[345678]
 
+sign_verify  prime256v1 sha256   0x030304:K:004[345678] --v3
+sign_verify  prime256v1 sha384   0x030305:K:004[345678] --v3
+sign_verify  prime256v1 sha512   0x030306:K:004[345678] --v3
+
 # If openssl 3.0 is installed, test the SM2/3 algorithm combination
 ssl_major_version=$(openssl version | sed -n 's/^OpenSSL \([^\.]\).*/\1/p')
 if [ "${ssl_major_version}" = 3 ]; then
-- 
2.53.0


