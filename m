Return-Path: <linux-integrity+bounces-1533-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FCA086E333
	for <lists+linux-integrity@lfdr.de>; Fri,  1 Mar 2024 15:20:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8FD351C21793
	for <lists+linux-integrity@lfdr.de>; Fri,  1 Mar 2024 14:20:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77CC86E5EB;
	Fri,  1 Mar 2024 14:20:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="nEIu0Rxy"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 034CE69D0D
	for <linux-integrity@vger.kernel.org>; Fri,  1 Mar 2024 14:20:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709302808; cv=none; b=C4rKJ9KPkzvpzOvkvJS143xFM16mVFaF+mwiByuChOwulRH9da4p1Ay18/MsokP+Y2YyDOrngbmXclpJOm8yOywK0p14O+98V6Rll0eZEmnIJWyzCcfbfkXzZybarq+BskE26whEKgKtZPPcwztONq3MZLeIXKv31SBDeeJcm+0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709302808; c=relaxed/simple;
	bh=IwUMa05Nt1Mmt7HyJrfe1qkwgl/kyDBIChZGtlRbdUI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=aanlleMj73sHkui5mBp63jOnYGzlK2Ruei00SVfOKsBNy5R5LjbUsjIqsp4e/JkP+8p4XTigeoA89IOqnHXCzTMFcSnG5i3UYctmPQ7evIAWDe6JtEB4hGNtIAuUMp0pnKi8C5dnihfYUoqldNjKzu+icONqV4Tfp3O0ji3fB2w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=nEIu0Rxy; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 421CUTC9008197
	for <linux-integrity@vger.kernel.org>; Fri, 1 Mar 2024 14:20:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding; s=pp1;
 bh=3Kow/laPkPe+zN5lTVdGHiZb++H4dCK82LxTdGjFn18=;
 b=nEIu0Rxy5awv/vu53YhKUsuCF3su1XJpPmw+x5HFAl+4KgB2aL5XKbzl3oQGtE9k2li+
 H9vPd4/vF3d1fT/CJpnRPwlnHV0jAdKQ6qoS2j0MQaEV0YO1RuyitESPSQIk5RV33Aap
 fmTT3nMUFe7vaPof+LnHZ1BHa5SCqUNFGQQ0EZZbVpKKjYnsuMJZdlmjMRbkGWyiLIUd
 HRq5QW84xpRoWJgi7dmK8rk04ZPNm4aPDuq2LvMuzcqzS4M5FPY5+KtJucW55p4k8/Ho
 +tYp60w9Rwip4dU2D+bOWaTBoadiesT7EJcj5OX6HblxLhx1k9m65oAilh+zv/YjxbTx Qw== 
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3wkf34ts6q-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-integrity@vger.kernel.org>; Fri, 01 Mar 2024 14:20:05 +0000
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 421CIaW3024122
	for <linux-integrity@vger.kernel.org>; Fri, 1 Mar 2024 14:20:05 GMT
Received: from smtprelay03.dal12v.mail.ibm.com ([172.16.1.5])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 3wfw0kvj9r-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-integrity@vger.kernel.org>; Fri, 01 Mar 2024 14:20:05 +0000
Received: from smtpav03.wdc07v.mail.ibm.com (smtpav03.wdc07v.mail.ibm.com [10.39.53.230])
	by smtprelay03.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 421EK2aB29426144
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 1 Mar 2024 14:20:04 GMT
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 2726958054;
	Fri,  1 Mar 2024 14:20:02 +0000 (GMT)
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B16335805A;
	Fri,  1 Mar 2024 14:20:01 +0000 (GMT)
Received: from sbct-3.pok.ibm.com (unknown [9.47.158.153])
	by smtpav03.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Fri,  1 Mar 2024 14:20:01 +0000 (GMT)
From: Stefan Berger <stefanb@linux.ibm.com>
To: linux-integrity@vger.kernel.org
Cc: zohar@linux.ibm.com, Stefan Berger <stefanb@linux.ibm.com>
Subject: [ima-evm-utils PATCH] Add missing newline to error message
Date: Fri,  1 Mar 2024 09:19:54 -0500
Message-ID: <20240301141954.358972-1-stefanb@linux.ibm.com>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: twALjARBnAJI9rNJOGU8GuM34zY316vj
X-Proofpoint-ORIG-GUID: twALjARBnAJI9rNJOGU8GuM34zY316vj
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-01_14,2024-03-01_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 impostorscore=0
 mlxscore=0 bulkscore=0 malwarescore=0 mlxlogscore=862 priorityscore=1501
 suspectscore=0 adultscore=0 lowpriorityscore=0 spamscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311290000
 definitions=main-2403010119

Signed-off-by: Stefan Berger <stefanb@linux.ibm.com>
---
 src/libimaevm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/src/libimaevm.c b/src/libimaevm.c
index 89330c4..f1dcb2d 100644
--- a/src/libimaevm.c
+++ b/src/libimaevm.c
@@ -227,7 +227,7 @@ int ima_calc_hash2(const char *file, const char *hash_algo, uint8_t *hash)
 		err = add_file_hash(file, pctx);
 		break;
 	default:
-		log_err("Unsupported file type (0x%x)", st.st_mode & S_IFMT);
+		log_err("Unsupported file type (0x%x)\n", st.st_mode & S_IFMT);
 		err = -1;
 		goto err;
 	}
-- 
2.44.0


