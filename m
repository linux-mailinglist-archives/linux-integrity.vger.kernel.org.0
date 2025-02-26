Return-Path: <linux-integrity+bounces-4997-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C48E2A46127
	for <lists+linux-integrity@lfdr.de>; Wed, 26 Feb 2025 14:42:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 374827A49BD
	for <lists+linux-integrity@lfdr.de>; Wed, 26 Feb 2025 13:41:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81B4021D3C4;
	Wed, 26 Feb 2025 13:41:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="POL8t4gp"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21B85219E86;
	Wed, 26 Feb 2025 13:41:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740577274; cv=none; b=bd9n2435DFWiXj8kMlGh/QI6G4gNdK/GG1IcdxmJ6OFKY6T3fHkLiII0qT9OfrGIUHtmRfHDcsihXe9gR60qZriuS01xtppNK7R+HUeF4G/Q/VW7L1Oh2dT6GDBRY8ktHn1iICKuoUnOcHldAK3FtRNG3T9NnWV/6Rukjssbsh4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740577274; c=relaxed/simple;
	bh=bRJ+Y2frt13NbfDCG2ElOCtwsN6xrTBDS3rGxlu1PAk=;
	h=Message-ID:Subject:From:To:Cc:Date:Content-Type:MIME-Version; b=nFcZeBy3F0wVHyy1fDlvR4JEOMKAmW6mULbDRTlDoCHF7QeWDthFHDf3Hgmo2Y4cow/OPDHRsOgECRQ7DFSxYzAR/El67pGU2auih+JpmmINVIJ3dLJQlG+zdpcDM5jzASufwnj6kp7GMYEEjDOeIv8O7UbCxKOTePjIiurZh0Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=POL8t4gp; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51Q5NweN020622;
	Wed, 26 Feb 2025 13:41:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=pp1; bh=WgtB+I5EeEFFDyU/wj4PxUl8h/5X
	Zf6iZzGCRVFO66w=; b=POL8t4gpLVUc+HgYGz3vYczC96Q3LZny7SFcOegDfmzI
	m1NaAv2MAchuGyvdSL8H2CEazS6xe1EFOmSPdcJ+5uoe2r0rRiAokydZpyKlJzr8
	CldNQPSSWJC7WWfv24aSfxar16MxQtfzu7c0TiD99XKO+hy8tpHE5b0dW96NgW2K
	wprZvguIed4GnAnl8XzUg49pB72tTxfgSEFJm9c+O6IFPNKXKfyFKvMDgPyWGso+
	opbLB6TUXzXCCyvvmCKmy0VGT7x3TIwgS13LH0iW9vY3iE2Egt4V6xxMNrAYrzdu
	zlUN5AcrOls5HMKDNjBEsJQJ9afIBj60VhhoP8j9CQ==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 451vs823cd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 26 Feb 2025 13:41:03 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 51QBIYrQ012507;
	Wed, 26 Feb 2025 13:41:02 GMT
Received: from smtprelay03.wdc07v.mail.ibm.com ([172.16.1.70])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 44ys9yk2ke-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 26 Feb 2025 13:41:02 +0000
Received: from smtpav01.dal12v.mail.ibm.com (smtpav01.dal12v.mail.ibm.com [10.241.53.100])
	by smtprelay03.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 51QDf1wu48365956
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 26 Feb 2025 13:41:01 GMT
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 26FD258058;
	Wed, 26 Feb 2025 13:41:02 +0000 (GMT)
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C9EF658061;
	Wed, 26 Feb 2025 13:41:01 +0000 (GMT)
Received: from li-43857255-d5e6-4659-90f1-fc5cee4750ad.ibm.com (unknown [9.61.180.23])
	by smtpav01.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 26 Feb 2025 13:41:01 +0000 (GMT)
Message-ID: <dc3b985a9324acf0455434943c2ead3b39945354.camel@linux.ibm.com>
Subject: [GIT PULL] integrity: subsystem fixes for v6.14
From: Mimi Zohar <zohar@linux.ibm.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-integrity <linux-integrity@vger.kernel.org>,
        linux-kernel
 <linux-kernel@vger.kernel.org>,
        Roberto Sassu
 <roberto.sassu@huaweicloud.com>
Date: Wed, 26 Feb 2025 08:41:01 -0500
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.4 (3.52.4-2.fc40) 
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: mqDd6fSGfbIDE9Ndu2ytHS2NR_I6EvdT
X-Proofpoint-GUID: mqDd6fSGfbIDE9Ndu2ytHS2NR_I6EvdT
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-26_03,2025-02-26_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 phishscore=0 suspectscore=0 priorityscore=1501 impostorscore=0 bulkscore=0
 mlxlogscore=999 spamscore=0 mlxscore=0 malwarescore=0 adultscore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2502100000 definitions=main-2502260108

Hi Linus,

Here's two changes: 1 bug fix and 1 spelling cleanup.  The bug fix restores=
 a
performance improvement.

thanks,

Mimi


The following changes since commit 2014c95afecee3e76ca4a56956a936e23283f05b=
:

  Linux 6.14-rc1 (2025-02-02 15:39:26 -0800)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/zohar/linux-integrity.git=
/ tags/integrity-v6.14-fix

for you to fetch changes up to 57a0ef02fefafc4b9603e33a18b669ba5ce59ba3:

  ima: Reset IMA_NONACTION_RULE_FLAGS after post_setattr (2025-02-04 21:36:=
43 -0500)

----------------------------------------------------------------
integrity-v6.14-fix

----------------------------------------------------------------
Roberto Sassu (1):
      ima: Reset IMA_NONACTION_RULE_FLAGS after post_setattr

Tanya Agarwal (1):
      integrity: fix typos and spelling errors

 security/integrity/evm/evm_crypto.c |  2 +-
 security/integrity/evm/evm_main.c   |  2 +-
 security/integrity/ima/ima.h        |  3 +++
 security/integrity/ima/ima_main.c   | 13 ++++++++-----
 4 files changed, 13 insertions(+), 7 deletions(-)

