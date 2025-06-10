Return-Path: <linux-integrity+bounces-6400-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BBF52AD44A2
	for <lists+linux-integrity@lfdr.de>; Tue, 10 Jun 2025 23:19:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CA27B3A46FB
	for <lists+linux-integrity@lfdr.de>; Tue, 10 Jun 2025 21:19:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A127F283151;
	Tue, 10 Jun 2025 21:19:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="qFwiXc3s"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E1E128314C;
	Tue, 10 Jun 2025 21:19:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749590375; cv=none; b=W4tuusiNjLbTKZPRhbGvFpVQpSiw2+3yxP0HrnKLuoq9FsV3YsrLc8N5wuxbAMF/qv2TV+adcR8o9xjDK9qq+36+kJ6naLvr/7x3tASoxL8/MurH3sOZoSySN+j4UIL50sfXLfJIgTi2Dc5D2c6Jp7Z/eyx6hHBv7olgkYg2aVo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749590375; c=relaxed/simple;
	bh=8nxvoNRUjPFxdF50Jrr9dnfqLT5PX02cvePHTBGD/2E=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=iuv1TnbzZ/09/fiMlUBstISd/CGur587laZRPIs5WXUc3Xq2l76Jkkv1uczBFwa6H9CwNQ3iEqsD2J9NbIzaHDLJTIPfXzcHwKUw+/MnNu2kBi7brCZtbIXjefiNXOSQkNTVDB4AgQh6pJLUlJybZbu3uBUfnNwRnUojc8XjQ+U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=qFwiXc3s; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55AGif99010507;
	Tue, 10 Jun 2025 21:19:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=koPLt8qRp3FKcDva4ZD4XUs8JAblTCSf3xDPaI6Bo
	rQ=; b=qFwiXc3suFWGzJ0iAyZMZieSGPkW5ipOoNyrKoHNfLGKpYYJDhH4hSlQe
	SQObbxSN5CI4GnIYxvHP3O/cpa8Ww4v4MBtt1FzAdIxPpG8xVlMtN9su3IL6gjJP
	3jru6vVuor6WCnLMTYCtOj6MNZ7He45x9WG+mRJWFYav5nYxDjR5+yu5m2Vcxue3
	cIO5jarlKxew2XtO+reVnroTDhhEGPGKDjGZR2kYtQOrgUfsE8R1AYzhSEJKXecW
	NdGUxGD8mamrXqlUU2Xnmio4iIyM08yBppuj+FkeRGFPwrOHjkiJdMXSPOhW/qhT
	GA7AfFbAOrLFT3Lg5+u6RBn3r50JA==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 474dv7grvu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 10 Jun 2025 21:19:17 +0000 (GMT)
Received: from m0353729.ppops.net (m0353729.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 55ALHYA6020513;
	Tue, 10 Jun 2025 21:19:17 GMT
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 474dv7grvq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 10 Jun 2025 21:19:16 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 55AHYB7s028110;
	Tue, 10 Jun 2025 21:19:15 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 47518mccc5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 10 Jun 2025 21:19:15 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 55ALJBPx44499230
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 10 Jun 2025 21:19:11 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 818432004E;
	Tue, 10 Jun 2025 21:19:11 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 7046720043;
	Tue, 10 Jun 2025 21:19:08 +0000 (GMT)
Received: from li-fc74f8cc-3279-11b2-a85c-ef5828687581.ibm.com.com (unknown [9.39.26.197])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 10 Jun 2025 21:19:08 +0000 (GMT)
From: Srish Srinivasan <ssrish@linux.ibm.com>
To: linux-integrity@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Cc: maddy@linux.ibm.com, mpe@ellerman.id.au, npiggin@gmail.com,
        christophe.leroy@csgroup.eu, naveen@kernel.org, ajd@linux.ibm.com,
        zohar@linux.ibm.com, nayna@linux.ibm.com, rnsastry@linux.ibm.com,
        msuchanek@suse.de, linux-kernel@vger.kernel.org
Subject: [PATCH v4 0/3] Enhancements to the secvar interface in static key management mode
Date: Wed, 11 Jun 2025 02:49:04 +0530
Message-ID: <20250610211907.101384-1-ssrish@linux.ibm.com>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: fxxsW0xGSOuaQ-l4FqO0ebhCT11qz7ro
X-Proofpoint-GUID: UuDglZBT5VJYf4exTu3iiFRrA_1WA-W_
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjEwMDE3NCBTYWx0ZWRfX52DtepAgTJ26 5xcfglXTmsJPc98J9D/l4hAFmXPFqaGWcF1uV1fmIX0GWzs4zS62IKmDvEnmqrakqtyc7LQvQe3 CJH03lMGyd7aDbdBWNdp02lFCGefqqLyfTkoEXR0NfllWJ15LWWxhg7Zl0L5PyzDmgdEcFGNvvo
 G2IltGHbsKzZCLw77ank9m4hT6fhizqlQ8wQlNrRFlxn319V9IwNJzXb7huWUKDggwwTg+pFuHw X8Dzm1Wwmj3/cPv5WC8E7WC9tyDPA/2HZ/gB6ErLRAvDTk5MXmNQ2Pnm8z3kVBJmkYsDcxDtbtX rUkJYw6+9uab7wERwip0kkumbPSpUncPtJSVlaxuQtcmsgD0E/2u76mdlI4CYzCjxXhvpHSTyLD
 0P0FIzRhBoij/VlwAHKuSrJH5mlswyPPmLSyr0JTGqtN0toXBoJkstMgfKlCbUbvOx7RKSsj
X-Authority-Analysis: v=2.4 cv=CfMI5Krl c=1 sm=1 tr=0 ts=6848a155 cx=c_pps a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17 a=6IFa9wvqVegA:10 a=-GDc6ojF7u6cf32OQp4A:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-10_10,2025-06-10_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 spamscore=0
 phishscore=0 priorityscore=1501 clxscore=1015 impostorscore=0 mlxscore=0
 suspectscore=0 mlxlogscore=999 adultscore=0 malwarescore=0
 lowpriorityscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2506100174

The PLPKS enabled Power LPAR sysfs exposes all of the secure boot secure
variables irrespective of the key management mode. There is support for
both static and dynamic key management and the key management mode can
be updated using the management console. The user should be able to read
from and write to the secure boot secvars db, dbx, grubdb, grubdbx, and
sbat only in the dynamic managememnt key mode. But the sysfs interface
exposes these secvars even in the static key management mode even
though they are not getting consumed in this mode.

Update the secvar format property based on the key management mode and
expose only the secure variables relevant to the key management mode.
Enable loading of signed third-party kernel modules in the static key
mode when the platform keystore is enabled.

Changelog:

v4:

* Patch 2:

  - Changes to the documentation and the patch description based on
    feedback from Michal.

v3:

* Patch 1:

  - Minor changes to the docmentation based on feedback from Andrew.
  - Added reviewed-by from Andrew.

v2:

* Patch 1:

  - Updated plpks_get_sb_keymgmt_mode to handle -ENOENT and -EPERM in
    the case of static key management mode, based on feedback from
    Andrew.
  - Moved the documentation changes relevant to the secvar format
    property from Patch 2 to Patch 1.
  - Added reviewed-by from Nayna.

* Patch 2:

  - Moved the documentaton changes relevant to secure variables from
    /sys/firmware/secvar/format to
    /sys/firmware/secvar/vars/<variable name>.
  - Added reviewed-by from Nayna and Andrew.

* Patch 3:
  - Added reviewed-by from Nayna and Andrew.


Srish Srinivasan (3):
  powerpc/pseries: Correct secvar format representation for static key
    management
  powerpc/secvar: Expose secvars relevant to the key management mode
  integrity/platform_certs: Allow loading of keys in the static key
    management mode

 Documentation/ABI/testing/sysfs-secvar        |  17 ++-
 arch/powerpc/platforms/pseries/plpks-secvar.c | 104 ++++++++++++------
 .../integrity/platform_certs/load_powerpc.c   |   5 +-
 3 files changed, 87 insertions(+), 39 deletions(-)

-- 
2.47.1


