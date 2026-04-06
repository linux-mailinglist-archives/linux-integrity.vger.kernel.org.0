Return-Path: <linux-integrity+bounces-9131-lists+linux-integrity=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-integrity@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CONbE7f50mkXcwcAu9opvQ
	(envelope-from <linux-integrity+bounces-9131-lists+linux-integrity=lfdr.de@vger.kernel.org>)
	for <lists+linux-integrity@lfdr.de>; Mon, 06 Apr 2026 02:09:27 +0200
X-Original-To: lists+linux-integrity@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id B9D403A0D10
	for <lists+linux-integrity@lfdr.de>; Mon, 06 Apr 2026 02:09:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id BF8F53007CBD
	for <lists+linux-integrity@lfdr.de>; Mon,  6 Apr 2026 00:08:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0851640DFA3;
	Mon,  6 Apr 2026 00:08:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="UCoJQyAM"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E82D17D6
	for <linux-integrity@vger.kernel.org>; Mon,  6 Apr 2026 00:08:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775434124; cv=none; b=JkrK3z6bKLSYb+TLe86PT2AVwM7+oShRRWTtadupxlwOE7fPf8oUnzhqb1Hm76MGTIASvY67H7UWI0rM8pA8voGCre3wwPqBczKmGEwL1D0ZBnmBho5ZmKoSO2n0B89dJzmuygTt3R1j/iCZqPLuAsTQ4BCpvTDeyg5/q9w+61A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775434124; c=relaxed/simple;
	bh=U1Jsyasc3cJPKETfJqj59bd0OOKg6yMiD0x4swXV6JM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=c0q9FiFrLD8SEoBI4Ge/k4BrvkXhxrdOGhUwTDDDSHS0rhaOOLfam/simHX3D3KQJHat6fN/8w0LaZJWlqrVQqmXQRuAtJt946CwreBDDuA2brCZAIEorMswPbdgmzbXUprltnVirtHRbc6Viv9dknbmajp4OfF1jYo41Se6ZLs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=UCoJQyAM; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 634IMiHr614811;
	Mon, 6 Apr 2026 00:08:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=XjNLJFYU0iNj27zH0
	EHytKTpXapZpFmvGJ+COD2c9P4=; b=UCoJQyAM7aLvISXUiaZR8f/0jBPIrKIIb
	bhFC8A2LrO0vo7f2JniSiA06ZXYhPIQon69UnVmh26F4DuVBhEt7G9rnS2BWH++Y
	P1p9PS/DOCfeWflbYUKmfwbnIYiBA9zkB2ggdEycaS5whWXfWohj6XFGc7Qdm1BM
	ana5II3DEvlDf7S2xwFXlf3biNLbOYeUmPzJeO8RxEvTtyA23inntcNZfegLKZ0Q
	ZMhHdvFHZHPlMrecmPm5TocQOR6z96C+hTewTeoR4/LTJpmQi58dFG2joWOcoDfn
	MbGJD5J16EIMlBrJC7Kue8Ik1aobBjo0JxN29vgDWowI/0p2f7vbg==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4dar2gcgbd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 06 Apr 2026 00:08:22 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 635HbGZZ006360;
	Mon, 6 Apr 2026 00:08:21 GMT
Received: from smtprelay01.wdc07v.mail.ibm.com ([172.16.1.68])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4dbfp1jjp3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 06 Apr 2026 00:08:21 +0000
Received: from smtpav01.dal12v.mail.ibm.com (smtpav01.dal12v.mail.ibm.com [10.241.53.100])
	by smtprelay01.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 63608Jo32229240
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 6 Apr 2026 00:08:19 GMT
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 3214658059;
	Mon,  6 Apr 2026 00:08:19 +0000 (GMT)
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C8C0958057;
	Mon,  6 Apr 2026 00:08:18 +0000 (GMT)
Received: from sbct-3.pok.ibm.com (unknown [9.47.158.153])
	by smtpav01.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Mon,  6 Apr 2026 00:08:18 +0000 (GMT)
From: Stefan Berger <stefanb@linux.ibm.com>
To: linux-integrity@vger.kernel.org
Cc: zohar@linux.ibm.com, roberto.sassu@huawei.com, ebiggers@kernel.org,
        coxu@redhat.com, Stefan Berger <stefanb@linux.ibm.com>
Subject: [ima-evm-utils PATCH 4/5] examples: Implement script to create ML-DSA-65 CA and signing keys
Date: Sun,  5 Apr 2026 20:08:09 -0400
Message-ID: <20260406000810.4013201-5-stefanb@linux.ibm.com>
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
X-Proofpoint-GUID: lVs3QeMSlbm73t_iemHoD8SAcHiLZ5JZ
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDA1MDI0NyBTYWx0ZWRfX3X/4aweo8+zJ
 tmnYlWwZS9zYncaA8eqiuz9cYZjh/jdD7M3HYNDabXJf5PFcobfjcm5Yse9oZZ5fe3cYJsY3lM5
 4Hb4EmT4SQhcJeU3nkUMIzu5eq5vzgH1Xg55pp0OBLtIn2xOl6oScPivQhGxPUWe0N+UGMXi66R
 +t4fOqUMppKa0pMq43TxMr7mXLAANUyU9auA8GPPuxaogfzzFlfmPHiib44U23gUvB9xebvM+AL
 voYF4zyBMCOuX0ixbxDXvpEPH/np9RmGPOdV2RYXFp0WJRkqpOLd16yuOLy8ktKjlwqsBtkydNc
 jQgJXwDHtsfrPsMNSPrmJcqFV8yHxBwunkBHL4iVGBboqOXgnaEaoTdBfa6oQ9h4W9jLrkMUlOt
 cwGTGr6PbQMwvm2mKeuxBP3hpXi/a82WJabiOu6YqN/Q0l2E9p/aejbBe3GOB6tbMtweayHbFYe
 Yi8Vb7bycm0Q4DQ5liA==
X-Authority-Analysis: v=2.4 cv=b+u/I9Gx c=1 sm=1 tr=0 ts=69d2f976 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VnNF1IyMAAAA:8 a=GnB_NaH4Y8p_GKf6GlsA:9
X-Proofpoint-ORIG-GUID: lVs3QeMSlbm73t_iemHoD8SAcHiLZ5JZ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-05_08,2026-04-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 phishscore=0 bulkscore=0 adultscore=0 lowpriorityscore=0
 impostorscore=0 malwarescore=0 spamscore=0 priorityscore=1501 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2604050247
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
	TAGGED_FROM(0.00)[bounces-9131-lists,linux-integrity=lfdr.de];
	DKIM_TRACE(0.00)[ibm.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCPT_COUNT_FIVE(0.00)[6];
	FROM_NEQ_ENVFROM(0.00)[stefanb@linux.ibm.com,linux-integrity@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,linux.ibm.com:mid,ima-genkey-mldsa65.sh:url];
	TAGGED_RCPT(0.00)[linux-integrity];
	RCVD_COUNT_SEVEN(0.00)[11]
X-Rspamd-Queue-Id: B9D403A0D10
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

ima-gen-local-ca-mldsa65.sh creates a CA with an ML-DSA-65 key and
ima-genkey-mldsa65.sh creates an ML-DSA-65 IMA file signing key along with
its certificate.

Also add a script for creating an ML-DSA-87 IMA file signing key. This key
type is good for local testing with the largest possible signature.

Signed-off-by: Stefan Berger <stefanb@linux.ibm.com>
---
 examples/ima-gen-local-ca-mldsa65.sh | 29 ++++++++++++++++++++++++
 examples/ima-genkey-mldsa65.sh       | 34 ++++++++++++++++++++++++++++
 examples/ima-genkey-mldsa87.sh       | 34 ++++++++++++++++++++++++++++
 3 files changed, 97 insertions(+)
 create mode 100755 examples/ima-gen-local-ca-mldsa65.sh
 create mode 100755 examples/ima-genkey-mldsa65.sh
 create mode 100755 examples/ima-genkey-mldsa87.sh

diff --git a/examples/ima-gen-local-ca-mldsa65.sh b/examples/ima-gen-local-ca-mldsa65.sh
new file mode 100755
index 0000000..e2b54cd
--- /dev/null
+++ b/examples/ima-gen-local-ca-mldsa65.sh
@@ -0,0 +1,29 @@
+#!/bin/sh
+# SPDX-License-Identifier: GPL-2.0-or-later
+
+GENKEY=ima-local-ca.genkey
+
+cat << __EOF__ >$GENKEY
+[ req ]
+distinguished_name = req_distinguished_name
+prompt = no
+string_mask = utf8only
+x509_extensions = v3_ca
+
+[ req_distinguished_name ]
+O = IMA-CA
+CN = IMA/EVM certificate signing key
+emailAddress = ca@ima-ca
+
+[ v3_ca ]
+basicConstraints=CA:TRUE
+subjectKeyIdentifier=hash
+authorityKeyIdentifier=keyid:always,issuer
+keyUsage = cRLSign, keyCertSign
+__EOF__
+
+openssl req -new -x509 -utf8 -sha256 -days 3650 -batch -config $GENKEY \
+		-outform DER -out ima-local-ca.x509 -keyout ima-local-ca.priv \
+		-newkey mldsa65
+
+openssl x509 -inform DER -in ima-local-ca.x509 -out ima-local-ca.pem
diff --git a/examples/ima-genkey-mldsa65.sh b/examples/ima-genkey-mldsa65.sh
new file mode 100755
index 0000000..b1aaf41
--- /dev/null
+++ b/examples/ima-genkey-mldsa65.sh
@@ -0,0 +1,34 @@
+#!/bin/sh
+# SPDX-License-Identifier: GPL-2.0-or-later
+
+GENKEY=ima.genkey
+
+cat << __EOF__ >$GENKEY
+[ req ]
+distinguished_name = req_distinguished_name
+prompt = no
+string_mask = utf8only
+x509_extensions = v3_usr
+
+[ req_distinguished_name ]
+O = `hostname`
+CN = `whoami` signing key
+emailAddress = `whoami`@`hostname`
+
+[ v3_usr ]
+basicConstraints=critical,CA:FALSE
+#basicConstraints=CA:FALSE
+keyUsage=digitalSignature
+#keyUsage = nonRepudiation, digitalSignature, keyEncipherment
+extendedKeyUsage=critical,codeSigning
+subjectKeyIdentifier=hash
+authorityKeyIdentifier=keyid
+#authorityKeyIdentifier=keyid,issuer
+__EOF__
+
+openssl req -new -nodes -utf8 -sha256 -days 365 -batch -config $GENKEY \
+		-out csr_ima.pem -keyout privkey_ima.pem \
+		-newkey mldsa65
+openssl x509 -req -in csr_ima.pem -days 365 -extfile $GENKEY -extensions v3_usr \
+		-CA ima-local-ca.pem -CAkey ima-local-ca.priv -CAcreateserial \
+		-outform DER -out x509_ima.der
diff --git a/examples/ima-genkey-mldsa87.sh b/examples/ima-genkey-mldsa87.sh
new file mode 100755
index 0000000..347ff91
--- /dev/null
+++ b/examples/ima-genkey-mldsa87.sh
@@ -0,0 +1,34 @@
+#!/bin/sh
+# SPDX-License-Identifier: GPL-2.0-or-later
+
+GENKEY=ima.genkey
+
+cat << __EOF__ >$GENKEY
+[ req ]
+distinguished_name = req_distinguished_name
+prompt = no
+string_mask = utf8only
+x509_extensions = v3_usr
+
+[ req_distinguished_name ]
+O = `hostname`
+CN = `whoami` signing key
+emailAddress = `whoami`@`hostname`
+
+[ v3_usr ]
+basicConstraints=critical,CA:FALSE
+#basicConstraints=CA:FALSE
+keyUsage=digitalSignature
+#keyUsage = nonRepudiation, digitalSignature, keyEncipherment
+extendedKeyUsage=critical,codeSigning
+subjectKeyIdentifier=hash
+authorityKeyIdentifier=keyid
+#authorityKeyIdentifier=keyid,issuer
+__EOF__
+
+openssl req -new -nodes -utf8 -sha256 -days 365 -batch -config $GENKEY \
+		-out csr_ima.pem -keyout privkey_ima.pem \
+		-newkey mldsa87
+openssl x509 -req -in csr_ima.pem -days 365 -extfile $GENKEY -extensions v3_usr \
+		-CA ima-local-ca.pem -CAkey ima-local-ca.priv -CAcreateserial \
+		-outform DER -out x509_ima.der
-- 
2.53.0


