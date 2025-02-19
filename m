Return-Path: <linux-integrity+bounces-4902-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3442DA3C4D9
	for <lists+linux-integrity@lfdr.de>; Wed, 19 Feb 2025 17:23:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 064D11884F66
	for <lists+linux-integrity@lfdr.de>; Wed, 19 Feb 2025 16:22:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F56D1DFE22;
	Wed, 19 Feb 2025 16:21:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="E6hQ2+Ot"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A39E1FDE10
	for <linux-integrity@vger.kernel.org>; Wed, 19 Feb 2025 16:21:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739982119; cv=none; b=S7FWA/HQIQKKIZJP52fDoZKi1lC4C1O7CVD7Dr5xoR9THEQWMHOrgn/lnylez6HryHhANJBD6tOlCSqXsRVjinQFWNlvpWdMatq0atKwPIOIErvJsGZ9Oxh/MYzSUAwj7l8d2Zwv4ROtGCuOVxKk2svgGARWYYRvavO4XxWYdxs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739982119; c=relaxed/simple;
	bh=QodbW6j/E8KFktjODDeg/aTG1Y0g5LF41vPRgOa2Wd4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=u8AbfmcJO6fQj0ok2oJt1SveF/DWUeUEqAiBrp0nJ9UtN6jMCg3yHRDrMsFhvAXAVpwirvkqsqWFdIUwT2YvECzlGQ+nriqBEQSDMVmlDjXXKLxh8eJJlvJ+q/XpCMkxESAht8qAsHBWS8M0VeIRwUXXzQhNOLcfNlJzPz8wp88=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=E6hQ2+Ot; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51J7WiXe002868;
	Wed, 19 Feb 2025 16:21:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=Cp6H29nUa43sewS1yMLoNq89Dmzv4VRUsIKjDr2oa
	gM=; b=E6hQ2+OtX2mQqG/UbgMlNZ/wLTR+QpEyMB22OKLCqWQe+vwu6WPAdynbv
	sUbb8dbJrlSTbCGpY5ZHeS6OWm9Z/JN6MW0Dq7fSuwAENdRZo0HAPT948ASsBZWi
	klgtgbJLt2PhN/y+lnCw63saztOWO1YKz1p6Gsa3xn0kOlVYjfZwbz3zjpZw18mO
	9E1GPmz5LqhJCkWieppD4YnsHrbsSud83qNDQyi+8rX0bt3YDzbo96ADtvCjem4C
	nJb2l3brzIr/IHSEjOTUg7hIm6qjUUF6FlarjKBADcFdkksef3OGNHCmMC9nGhc5
	Kv5Nyvrr9yVoGDuUkH2nS8u7Q+m3A==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 44wb0ntjyr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 19 Feb 2025 16:21:45 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 51JE2YvD029303;
	Wed, 19 Feb 2025 16:21:45 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 44w024d0he-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 19 Feb 2025 16:21:45 +0000
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 51JGLfOc20709802
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 19 Feb 2025 16:21:42 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id DB2BE2004B;
	Wed, 19 Feb 2025 16:21:41 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 7649C20040;
	Wed, 19 Feb 2025 16:21:40 +0000 (GMT)
Received: from li-43857255-d5e6-4659-90f1-fc5cee4750ad.fios-router.home (unknown [9.61.30.244])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 19 Feb 2025 16:21:40 +0000 (GMT)
From: Mimi Zohar <zohar@linux.ibm.com>
To: linux-integrity@vger.kernel.org
Cc: Mimi Zohar <zohar@linux.ibm.com>, roberto.sassu@huawei.com,
        Stefan Berger <stefanb@linux.ibm.com>, Petr Vorel <pvorel@suse.cz>
Subject: [PATCH 0/2] ima: limit both open-writers and ToMToU violations
Date: Wed, 19 Feb 2025 11:21:29 -0500
Message-ID: <20250219162131.416719-1-zohar@linux.ibm.com>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: Kr2LpLtBLaA-g7vzQ7kgMAdaLditY7vU
X-Proofpoint-GUID: Kr2LpLtBLaA-g7vzQ7kgMAdaLditY7vU
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-19_07,2025-02-19_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 mlxlogscore=702
 malwarescore=0 lowpriorityscore=0 mlxscore=0 phishscore=0
 priorityscore=1501 suspectscore=0 clxscore=1015 bulkscore=0 adultscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2502100000 definitions=main-2502190124

Each time a file in policy, that is already opened for write, is opened
for read an open-writers integrity violation audit message is emitted
and a violation record is added to the IMA measurement list, even if an
open-writers violation has already been recorded.

Similalry each time a file in policy, that is already opened for read,
is opened for write a Time-of-Measure-Time-of-Use (ToMToU) integrity
violation audit message is emitted and a violation record is added to
the IMA measurement list, even if a ToMToU violation has already been
recorded.

Minimize the violations in the audit log and the IMA measurement list.


Mimi Zohar (2):
  ima: limit the number of open-writers integrity violations
  ima: limit the number of ToMToU integrity violations

 security/integrity/ima/ima.h      |  1 +
 security/integrity/ima/ima_main.c | 16 ++++++++++++----
 2 files changed, 13 insertions(+), 4 deletions(-)

--
2.48.1


