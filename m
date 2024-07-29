Return-Path: <linux-integrity+bounces-3238-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A373093F6B1
	for <lists+linux-integrity@lfdr.de>; Mon, 29 Jul 2024 15:30:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 583001F224F8
	for <lists+linux-integrity@lfdr.de>; Mon, 29 Jul 2024 13:30:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80E8C149DFA;
	Mon, 29 Jul 2024 13:29:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="UZlMKw37"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D93631494A6;
	Mon, 29 Jul 2024 13:29:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722259798; cv=none; b=FkEBMjx4NJdMpT+1MTgOEuzIkmvWnP86BjLgWVGOAZ8Hb5F5+3R4+LojHTtSfGS5TZX+9LNW/a+5cdWe5OzzdQA9B27Pyo2B49EV/l9bFrZuYtkui5VISG5jMzA/lgB1sosd+7RFs2fC+TgHqJJ3vWw2pN63rpgG7zWP8dBcT3k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722259798; c=relaxed/simple;
	bh=APoUsuhYnLUDwtPUCx7/PYVeFex1ATI0uym46kYFOKo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=L9eNhoH3Jo7XiGduSxXpRwQRzaVAlHzCKlKiDQ6w2QOtTVKUfzK6ohMj07X5C0VYa2klXT05edRhkBV0WECW9qow6K+TmfV3W3PGBAGE78LUr06Aw8UJhiNQReGdmYmPQO/wUpyfwX896iyb3x0ZY3wI2/K5i3/rbzkbp+gNf0s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=UZlMKw37; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353726.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 46TAPIf4007086;
	Mon, 29 Jul 2024 13:29:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from
	:to:cc:subject:date:message-id:mime-version
	:content-transfer-encoding; s=pp1; bh=eB6A9MrJh03YG6Qvz7znj4iY3W
	40u7jTthKBXdGxDA0=; b=UZlMKw37sIjJ7e2ackZCJs0HMNd4xtoR8nlArIBJtn
	Nb3FIwgsD2EmLh/GTbfWNv/1RSRMN4NdnA6O4U3jK00t8cD7dQ8pAwKSKPjrn6sR
	aFIhu8h8hSwf+zf5bp5CNkXfr/j+GAldcnFLqDItyJGzcQeFIYf6VnahDrdIW/HJ
	5VLsw28qoD/y3/2T48mvFYzjp+ogqzqLFCnmV1EkuN+nXClA35IBf8YGKvpJ5Lcm
	BudBgAvF3Cu3zE3/pvwjZ+ifN/7LqswzqFsWnGLlSGhAsTTgHr2g794Zf7jctelL
	4GaftpPzJhWwzvpWz/PvRifUgEL4NoUJgXoS0CxLeOeQ==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 40mtbemt64-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 29 Jul 2024 13:29:45 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 46TDNZAn029128;
	Mon, 29 Jul 2024 13:29:43 GMT
Received: from smtprelay02.dal12v.mail.ibm.com ([172.16.1.4])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 40nbm0f0at-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 29 Jul 2024 13:29:43 +0000
Received: from smtpav01.wdc07v.mail.ibm.com (smtpav01.wdc07v.mail.ibm.com [10.39.53.228])
	by smtprelay02.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 46TDTevW41288180
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 29 Jul 2024 13:29:42 GMT
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 4DF1D5804B;
	Mon, 29 Jul 2024 13:29:40 +0000 (GMT)
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 8B3FF58066;
	Mon, 29 Jul 2024 13:29:39 +0000 (GMT)
Received: from sbct-3.pok.ibm.com (unknown [9.47.158.153])
	by smtpav01.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 29 Jul 2024 13:29:39 +0000 (GMT)
From: Stefan Berger <stefanb@linux.ibm.com>
To: linux-integrity@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        jarkko@kernel.org
Cc: linux-kernel@vger.kernel.org, mpe@ellerman.id.au,
        naveen.n.rao@linux.ibm.com, zohar@linux.ibm.com,
        Stefan Berger <stefanb@linux.ibm.com>
Subject: [PATCH v2] tpm: ibmvtpm: Call tpm2_sessions_init() to initialize session support
Date: Mon, 29 Jul 2024 09:29:34 -0400
Message-ID: <20240729132934.311136-1-stefanb@linux.ibm.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: J_OEySM1r_qOd12P0g-88e86lwWUiQKw
X-Proofpoint-GUID: J_OEySM1r_qOd12P0g-88e86lwWUiQKw
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-29_11,2024-07-26_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 spamscore=0
 clxscore=1011 adultscore=0 lowpriorityscore=0 mlxlogscore=999
 malwarescore=0 bulkscore=0 suspectscore=0 phishscore=0 mlxscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2407110000 definitions=main-2407290090

Commit d2add27cf2b8 ("tpm: Add NULL primary creation") introduced
CONFIG_TCG_TPM2_HMAC. When this option is enabled on ppc64 then the
following message appears in the kernel log due to a missing call to
tpm2_sessions_init().

[    2.654549] tpm tpm0: auth session is not active

Add the missing call to tpm2_session_init() to the ibmvtpm driver to
resolve this issue.

Fixes: d2add27cf2b8 ("tpm: Add NULL primary creation")
Signed-off-by: Stefan Berger <stefanb@linux.ibm.com>
---
 drivers/char/tpm/tpm_ibmvtpm.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/char/tpm/tpm_ibmvtpm.c b/drivers/char/tpm/tpm_ibmvtpm.c
index d3989b257f42..1e5b107d1f3b 100644
--- a/drivers/char/tpm/tpm_ibmvtpm.c
+++ b/drivers/char/tpm/tpm_ibmvtpm.c
@@ -698,6 +698,10 @@ static int tpm_ibmvtpm_probe(struct vio_dev *vio_dev,
 		rc = tpm2_get_cc_attrs_tbl(chip);
 		if (rc)
 			goto init_irq_cleanup;
+
+		rc = tpm2_sessions_init(chip);
+		if (rc)
+			goto init_irq_cleanup;
 	}
 
 	return tpm_chip_register(chip);
-- 
2.45.2


