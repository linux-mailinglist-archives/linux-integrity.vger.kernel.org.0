Return-Path: <linux-integrity+bounces-2862-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 47B8690BB2C
	for <lists+linux-integrity@lfdr.de>; Mon, 17 Jun 2024 21:34:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C938E284230
	for <lists+linux-integrity@lfdr.de>; Mon, 17 Jun 2024 19:34:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FC863AC16;
	Mon, 17 Jun 2024 19:34:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="nteoDU7f"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0DE01BDEF;
	Mon, 17 Jun 2024 19:34:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718652874; cv=none; b=GZLNvrsPr1xX7Kcgd1ZlhA6pV3vBOlTwtn4qeYxDrp4/1zW1mF1+oVSZShBq8ojLCNxXlbolq4ooPU+UtaKD7MpgtQxTK1Hzm3doDv/LdMNFCuKuuUTHy7hk5TugYesTBWj5AcULg2drWu4bn1QnePhMJna2euAqVlNqCUMW2R0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718652874; c=relaxed/simple;
	bh=iOCgZclJM7x49GMIvu9XuKkfAq+dd65uL4pshkxcOzo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=YZ1bbcTcWg1YvEo9mWqfkUfWsA0mcwx9XMb6ZF81Gie4ShtFZ9zkoz+2pS5wfA1XacucCIG6cOWhek5+78ErIiSDJ02tuySrygIslZTt2GqvB+yCIklEHq2V76aqHZcXG/tK3MLjiYk4PHFDyVQl9xj773cBZIIb/EbMmi1Ya8s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=nteoDU7f; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353723.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45HIxq1U007157;
	Mon, 17 Jun 2024 19:34:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from
	:to:cc:subject:date:message-id:mime-version
	:content-transfer-encoding; s=pp1; bh=1rtWCLDVD5hMYMANqkF4sbcV8H
	woHlf6NHGpbmCphXc=; b=nteoDU7fBPxBhbI2g1oZx7O9k1RSPdTAuFKQMiZ4w5
	/sc/xg5ZxACM9s5aUiOJ1dsoRN3Gwn1bqrrPGLH9dcNPLyLdpRHW3fUkigxsjIL7
	XB7e6TP+vXjALKiRJLzQBn2Nt+hE1y1Z7OTfOvG+5MK6+ExPiAg5HcW9lJE0OoV0
	zv2p8K3M92SQI8UfnD/ioq5TuRwSpkYvqIUOhb1FdvymaxejSY+HNnnv3OPufNAZ
	JpLHggvrSJVSQeXEW4/dOyvMN5p91bjMAin/PNB2sGSLcU61WmryS2AWSguBNHN3
	COSgaYWcGY26DiR9r2vDdf6De/P0CJpstRuE/+hh2NJA==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3yttwc828x-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 17 Jun 2024 19:34:19 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 45HIhUj4009941;
	Mon, 17 Jun 2024 19:34:19 GMT
Received: from smtprelay06.wdc07v.mail.ibm.com ([172.16.1.73])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 3ysqgmcj9f-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 17 Jun 2024 19:34:19 +0000
Received: from smtpav05.dal12v.mail.ibm.com (smtpav05.dal12v.mail.ibm.com [10.241.53.104])
	by smtprelay06.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 45HJYFsa26804904
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 17 Jun 2024 19:34:17 GMT
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 1301558065;
	Mon, 17 Jun 2024 19:34:15 +0000 (GMT)
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 993C558052;
	Mon, 17 Jun 2024 19:34:14 +0000 (GMT)
Received: from sbct-3.pok.ibm.com (unknown [9.47.158.153])
	by smtpav05.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 17 Jun 2024 19:34:14 +0000 (GMT)
From: Stefan Berger <stefanb@linux.ibm.com>
To: linux-integrity@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        jarkko@kernel.org
Cc: linux-kernel@vger.kernel.org, mpe@ellerman.id.au,
        naveen.n.rao@linux.ibm.com, Stefan Berger <stefanb@linux.ibm.com>
Subject: [PATCH] tpm: ibmvtpm: Call tpm2_sessions_init() to initialize session support
Date: Mon, 17 Jun 2024 15:34:08 -0400
Message-ID: <20240617193408.1234365-1-stefanb@linux.ibm.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: -09hiv8-DnkBLNg901VJl7ge-fi8Djmw
X-Proofpoint-GUID: -09hiv8-DnkBLNg901VJl7ge-fi8Djmw
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-17_14,2024-06-17_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999
 malwarescore=0 suspectscore=0 phishscore=0 spamscore=0 priorityscore=1501
 adultscore=0 mlxscore=0 bulkscore=0 impostorscore=0 lowpriorityscore=0
 clxscore=1011 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2405170001 definitions=main-2406170150

Fix the following type of error message caused by a missing call to
tpm2_sessions_init() in the IBM vTPM driver:

[    2.987131] tpm tpm0: tpm2_load_context: failed with a TPM error 0x01C4
[    2.987140] ima: Error Communicating to TPM chip, result: -14

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


