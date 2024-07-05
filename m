Return-Path: <linux-integrity+bounces-3025-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2213F928E18
	for <lists+linux-integrity@lfdr.de>; Fri,  5 Jul 2024 22:20:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CED76284023
	for <lists+linux-integrity@lfdr.de>; Fri,  5 Jul 2024 20:20:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AAB4B149C7F;
	Fri,  5 Jul 2024 20:20:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="XcJwvnqF"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EFBA135417;
	Fri,  5 Jul 2024 20:20:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720210837; cv=none; b=QXDqfiabFQJVbGZx+seSKZ5lQd4d4me6QCJj38oqmEZ5BRP0Tn0v8M2MAi6ZpRrsWXQrpCF0Q5xuqgIzUt0+AV1u48eJF5KI6Qu6S4LDnteNS541oxwr6iPn6J6l3aIeCo1PbKanBQr+vHPszIYZU7mOKeYp0YujY7n4Gn5vEG4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720210837; c=relaxed/simple;
	bh=r9qw9qMrM/jSTBQBaiC5h28NQHthl6ezFri5P9bV7kI=;
	h=Message-ID:Subject:From:To:Cc:Date:Content-Type:MIME-Version; b=DFm3cOqLVmXGNCoHi/13ZbfTMdgNq6LZfdafliE4E/XuelKtyUj0SuhfUZKCmKi+Zt6f43LwSsISaWFV5hvaoy3Kj20MzMRtN70e1Q6hFn57NRDGLR4PPzVvciLnKWuUr8uQ5zmR0TBhZTD9Ihbp7c260BMxW85ZSoRB9MOKMQs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=XcJwvnqF; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353727.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 465Hu3Gu005429;
	Fri, 5 Jul 2024 20:20:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=
	message-id:subject:from:to:cc:date:content-type
	:content-transfer-encoding:mime-version; s=pp1; bh=fr8Mth6/lY4Zv
	7YaTLOECfAxUMnV2L+TFDsJzj+8X4k=; b=XcJwvnqFU9MzRyYE5Z9f6+PNl73Ce
	NdA423SYPmf35lMAX67mB2sAaZgrpVrsGk9YsW9DBCUF87M1C3yUyYe28Neuwu0N
	vcbYtEfYBTUa+kcVrn9IiJ9FC4VdRBwT4pF0nCL4Ie4eybsMi5LQsIQSuitLGnMs
	5iOdQfHohowwI0WdO57RVDenQCImXiHu2xB6auT8YMm1OZoTY1n0Tjo9AVNX4ZjV
	SShq4cFiTR13qBsVUjjlrKtTTMRrsXAGgxeEuniEpY7eVw1zFbRnHJ+h14xH7Lpo
	VeBi3GahI4nSe8/dKnzV0fT0lYZs/7/kiKZtzkG+fo3aH7AA0GQJI8hzg==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 406j6a0sm9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 05 Jul 2024 20:20:27 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 465KGMF9009473;
	Fri, 5 Jul 2024 20:20:26 GMT
Received: from smtprelay02.dal12v.mail.ibm.com ([172.16.1.4])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 402xtn739c-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 05 Jul 2024 20:20:26 +0000
Received: from smtpav02.wdc07v.mail.ibm.com (smtpav02.wdc07v.mail.ibm.com [10.39.53.229])
	by smtprelay02.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 465KKOKH18088334
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 5 Jul 2024 20:20:26 GMT
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 0C11058073;
	Fri,  5 Jul 2024 20:20:24 +0000 (GMT)
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 729D958061;
	Fri,  5 Jul 2024 20:20:23 +0000 (GMT)
Received: from li-5cd3c5cc-21f9-11b2-a85c-a4381f30c2f3.ibm.com (unknown [9.61.131.151])
	by smtpav02.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Fri,  5 Jul 2024 20:20:23 +0000 (GMT)
Message-ID: <6b98a933682b443f0c16a4c8b3c5cd6db59d8f17.camel@linux.ibm.com>
Subject: [GIT PULL] integrity: subsystem update for v6.10-rcX
From: Mimi Zohar <zohar@linux.ibm.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-integrity <linux-integrity@vger.kernel.org>,
        linux-kernel
 <linux-kernel@vger.kernel.org>,
        Roberto Sassu
 <roberto.sassu@huaweicloud.com>
Date: Fri, 05 Jul 2024 16:20:22 -0400
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5 (3.28.5-26.el8_10) 
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: Kzq8q4nTlh9Gpijf0BHnblTeF4El7c9p
X-Proofpoint-ORIG-GUID: Kzq8q4nTlh9Gpijf0BHnblTeF4El7c9p
Content-Transfer-Encoding: 7bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-05_15,2024-07-05_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 adultscore=0
 phishscore=0 priorityscore=1501 clxscore=1011 spamscore=0 malwarescore=0
 impostorscore=0 suspectscore=0 mlxlogscore=698 lowpriorityscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2406140001 definitions=main-2407050145

Hi Linus,

A single bug fix to properly remove all of the securityfs IMA measurement lists.

thanks,

Mimi

The following changes since commit c3f38fa61af77b49866b006939479069cd451173:

  Linux 6.10-rc2 (2024-06-02 15:44:56 -0700)

are available in the Git repository at:

  ssh://gitolite@ra.kernel.org/pub/scm/linux/kernel/git/zohar/linux-integrity.git tags/integrity-v6.10-fix

for you to fetch changes up to fbf06cee60876d50f259d0689e3c03940750f0d4:

  ima: fix wrong zero-assignment during securityfs dentry remove (2024-06-03 16:37:22 -0400)

----------------------------------------------------------------
integrity-v6.10-fix

----------------------------------------------------------------
Enrico Bravi (1):
      ima: fix wrong zero-assignment during securityfs dentry remove

 security/integrity/ima/ima_fs.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)


