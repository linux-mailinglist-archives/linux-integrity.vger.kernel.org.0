Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8058830C4AF
	for <lists+linux-integrity@lfdr.de>; Tue,  2 Feb 2021 17:01:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235883AbhBBP7W (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 2 Feb 2021 10:59:22 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:3860 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235887AbhBBP5T (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 2 Feb 2021 10:57:19 -0500
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 112FWDM7082394;
        Tue, 2 Feb 2021 10:56:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=SGBWaiRV18Qg4DhtBk/DUGHQvFIvmwDgzCbpj9xKQS0=;
 b=dzvHa3xYzwWwyFZaRZ6P3tXqd4RL8hj1gHtUaEC7aXVW2y8FfD6oNjznXK9AqR38YZPg
 bMQyrh+nIMVXjCtHPK54hv1DQc+LXQ+bYQOBGh/8AdFh8kHHdyfAFp5vHKsyW4ZBwfJ9
 o37iWWt1hZy1YgDp1Dit13RJgrXJ6ZAMqJIogPcJ6aOcLA3feq3Qg12iLCIrSxj4cljY
 i6A2J/Kf32quVmRXPZ06r2jEHvCTun7sq+k7xNTCdd2c7rJ/Y5QDMaXQUMjOyXR2oO7O
 Bqmo5zEZGapBaS+AaQ0MqTE+CyAXU56nZKnElWY/c3qXWpzJzlawxWbwbJeZ1OTlvMMr GQ== 
Received: from ppma02wdc.us.ibm.com (aa.5b.37a9.ip4.static.sl-reverse.com [169.55.91.170])
        by mx0a-001b2d01.pphosted.com with ESMTP id 36f5nm9fcc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 02 Feb 2021 10:56:28 -0500
Received: from pps.filterd (ppma02wdc.us.ibm.com [127.0.0.1])
        by ppma02wdc.us.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 112Fjguv010180;
        Tue, 2 Feb 2021 15:56:27 GMT
Received: from b01cxnp23034.gho.pok.ibm.com (b01cxnp23034.gho.pok.ibm.com [9.57.198.29])
        by ppma02wdc.us.ibm.com with ESMTP id 36cy397amf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 02 Feb 2021 15:56:27 +0000
Received: from b01ledav006.gho.pok.ibm.com (b01ledav006.gho.pok.ibm.com [9.57.199.111])
        by b01cxnp23034.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 112FuRrb43712962
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 2 Feb 2021 15:56:27 GMT
Received: from b01ledav006.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 48CA5AC05F;
        Tue,  2 Feb 2021 15:56:27 +0000 (GMT)
Received: from b01ledav006.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 32B9FAC065;
        Tue,  2 Feb 2021 15:56:27 +0000 (GMT)
Received: from sbct-3.pok.ibm.com (unknown [9.47.158.153])
        by b01ledav006.gho.pok.ibm.com (Postfix) with ESMTP;
        Tue,  2 Feb 2021 15:56:27 +0000 (GMT)
From:   Stefan Berger <stefanb@linux.ibm.com>
To:     zohar@linux.ibm.com, vt@altlinux.org,
        linux-integrity@vger.kernel.org
Cc:     Stefan Berger <stefanb@linux.ibm.com>
Subject: [PATCH v2 1/2] ima_evm_utils: Fix calculation of keyid for older distros
Date:   Tue,  2 Feb 2021 10:56:24 -0500
Message-Id: <20210202155625.3555769-2-stefanb@linux.ibm.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20210202155625.3555769-1-stefanb@linux.ibm.com>
References: <20210202155625.3555769-1-stefanb@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.369,18.0.737
 definitions=2021-02-02_07:2021-02-02,2021-02-02 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0
 priorityscore=1501 lowpriorityscore=0 bulkscore=0 impostorscore=0
 adultscore=0 mlxscore=0 clxscore=1015 suspectscore=0 mlxlogscore=999
 phishscore=0 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2102020104
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Older distros, such as Ubuntu Xenial or Centos 7, fail to calculate the
keyid properly in the bash script. Adding 'tail -n1' into the pipe fixes
the issue since we otherwise have two numbers in 'id' due to two
'BIT STRING's.

Signed-off-by: Stefan Berger <stefanb@linux.ibm.com>
---
 tests/sign_verify.test | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tests/sign_verify.test b/tests/sign_verify.test
index 288e133..2477b34 100755
--- a/tests/sign_verify.test
+++ b/tests/sign_verify.test
@@ -43,6 +43,7 @@ _keyid_from_cert() {
   id=$($cmd 2>/dev/null \
     | openssl asn1parse \
     | grep BIT.STRING \
+    | tail -n1 \
     | cut -d: -f1)
   if [ -z "$id" ]; then
     echo - "$cmd" >&2
-- 
2.26.2

