Return-Path: <linux-integrity+bounces-7363-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D19BBB7FEE
	for <lists+linux-integrity@lfdr.de>; Fri, 03 Oct 2025 21:46:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 59FEB189CE59
	for <lists+linux-integrity@lfdr.de>; Fri,  3 Oct 2025 19:46:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 491C61F4190;
	Fri,  3 Oct 2025 19:46:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="pwxz+051"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9293529405;
	Fri,  3 Oct 2025 19:46:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759520768; cv=none; b=fGK2Ac8tS2nZQWY7fmydGkrlrxOj2XMgLZSsHkDyg4C6jmT/OuJqcwc1IjSpizXZ3EiFEXN5EDyEGnf357x/rU9r6rheSuJH7Yq1DdaBmMXpyKhPcFQgpWkCERkUHfOMH69v9ssHNWeo6SN16hk5n/l39UKniKsngeafSAu6Jg8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759520768; c=relaxed/simple;
	bh=FYgI+8DVFLoz3Mo1QSKIyBySU789fjJWTtKhpJbrAiw=;
	h=Message-ID:Subject:From:To:Cc:Content-Type:Date:MIME-Version; b=ttJg8hm5CA/TLBoGfblwov64F+CW2fcDePjNTspxP3j9pMbv6oJz9hKGT96FxIRKrn+TMUr6T2u2DMMd1jzPDBDQy6nE+lKRomiz/bk2nYE9ClSaNTXnhUkCYxB4BeZHexlWLf17VuoSwoP3Am17b6hCXGsF/2pDUqp5h3zDY6s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=pwxz+051; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 593ClxMp020716;
	Fri, 3 Oct 2025 19:45:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=pp1; bh=liEcdOeoAzkXJhIOic7285aRp08Y
	b3xqhFYfk9SqN8k=; b=pwxz+051cjZhOSDvrkYMkyBn9EvcHIWngxiMaaB0F/Hv
	qIUIo0b7zeol+9MK/EksCnu9Uoi6xEbRmcafDuVhmGC6lh6d0H0xnbB8m3EPO5E6
	34/9djbtniGmKsYA+7Vktl/Xe+HFe2xgEF6l2S5LnyeHJBdsjylzhb/qkQOA7+ZF
	Zh38qCawPOIVYNQaX6atyU9SdCblhd44QXT/+h4kOj/aYklR/JcIwL51FhNGdkPl
	+kqupV19+9xRh0BFicY3lJwLTem224xXaJ03mOCi6F1vc3E4epnCoYd8Uq9tvj0H
	cO6zM8eC3n8M3blNjLyZkuPM8biMVA49swW4NFIowg==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 49e7jx3ty4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 03 Oct 2025 19:45:58 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 593HalWL026818;
	Fri, 3 Oct 2025 19:45:57 GMT
Received: from smtprelay02.wdc07v.mail.ibm.com ([172.16.1.69])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 49eu8ncmj5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 03 Oct 2025 19:45:57 +0000
Received: from smtpav06.wdc07v.mail.ibm.com (smtpav06.wdc07v.mail.ibm.com [10.39.53.233])
	by smtprelay02.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 593Jjv8n32047846
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 3 Oct 2025 19:45:57 GMT
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 7B95D58055;
	Fri,  3 Oct 2025 19:45:57 +0000 (GMT)
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id F2AE35803F;
	Fri,  3 Oct 2025 19:45:56 +0000 (GMT)
Received: from li-43857255-d5e6-4659-90f1-fc5cee4750ad.ibm.com (unknown [9.61.86.89])
	by smtpav06.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Fri,  3 Oct 2025 19:45:56 +0000 (GMT)
Message-ID: <235aaef81ca206c9ac1f69ece17dd9a15f826d85.camel@linux.ibm.com>
Subject: [GIT PULL] integrity: subsystem fixes for v6.18
From: Mimi Zohar <zohar@linux.ibm.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-integrity <linux-integrity@vger.kernel.org>,
        linux-kernel	
 <linux-kernel@vger.kernel.org>,
        Roberto Sassu
 <roberto.sassu@huaweicloud.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Date: Fri, 03 Oct 2025 15:45:56 -0400
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Evolution 3.54.3 (3.54.3-2.fc41) 
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTI3MDAyNSBTYWx0ZWRfXwqrmRvKgid7L
 DvWkTJXLmVpDQpV58DP0Bf/eW2iFfHzauiCNzAQYiLoGqC14/QlHedGXgeW7OxiCcU82EFaDE2p
 K2qCZYtQ1x4fMurQ6R6JqfpAVsiHaJj/TtbCmooQgMHSZ7G4/CVM06572wdufU6yuaEIPBpC9Yv
 CxY7A0ghJ9I4jpHMWE2nohQytzf0zXU3MF9Kz+kmgsKmqeX8+qZplzEyaAb7ouVFGghHN9mJXAq
 UARyVe0/Nh+WPEyWC9GfyGLWUHEk7acA/UrTHzRD17BPm4e2KXBOQvdvgvURc4Hu9n0jdgWRZXQ
 6ZQ7JtkD3vO4nV8zRlJEuSQicb7+1cMWcaRSZaN5eucxaHq3t+hWeQNNVxNcI8PLzBoIDaRCEr4
 rxocmnBRJMf8uUd8o1d73kXj7Dc3Aw==
X-Proofpoint-ORIG-GUID: fzWM3UfK3XtN6iH8mKx-rPM6Mlnwmev5
X-Proofpoint-GUID: fzWM3UfK3XtN6iH8mKx-rPM6Mlnwmev5
X-Authority-Analysis: v=2.4 cv=GdUaXAXL c=1 sm=1 tr=0 ts=68e027f6 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=VwQbUJbxAAAA:8 a=YP3ZxmzE6RWCoqP63XUA:9
 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-03_06,2025-10-02_03,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 clxscore=1015 phishscore=0 adultscore=0 priorityscore=1501
 malwarescore=0 spamscore=0 bulkscore=0 impostorscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2509150000 definitions=main-2509270025

Hi Linus,

There's just a couple of changes: 2 crypto code cleanup and 1 IMA xattr bug=
 fix.

thanks,

Mimi

The following changes since commit c17b750b3ad9f45f2b6f7e6f7f4679844244f0b9=
:

  Linux 6.17-rc2 (2025-08-17 15:22:10 -0700)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/zohar/linux-integrity.git=
/ tags/integrity-v6.18

for you to fetch changes up to 88b4cbcf6b041ae0f2fc8a34554a5b6a83a2b7cd:

  ima: don't clear IMA_DIGSIG flag when setting or removing non-IMA xattr (=
2025-10-03 07:50:56 -0400)

----------------------------------------------------------------
integrity-v6.18

----------------------------------------------------------------
Coiby Xu (1):
      ima: don't clear IMA_DIGSIG flag when setting or removing non-IMA xat=
tr

Eric Biggers (2):
      integrity: Select CRYPTO from INTEGRITY_ASYMMETRIC_KEYS
      lib/digsig: Use SHA-1 library instead of crypto_shash

 lib/Kconfig                           |  3 +--
 lib/digsig.c                          | 46 +++++--------------------------=
----
 security/integrity/Kconfig            |  1 +
 security/integrity/ima/ima_appraise.c | 23 ++++++++++++++----
 4 files changed, 26 insertions(+), 47 deletions(-)


