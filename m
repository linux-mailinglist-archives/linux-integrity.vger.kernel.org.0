Return-Path: <linux-integrity+bounces-6083-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BDDEAA4658
	for <lists+linux-integrity@lfdr.de>; Wed, 30 Apr 2025 11:06:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 124731BC651E
	for <lists+linux-integrity@lfdr.de>; Wed, 30 Apr 2025 09:05:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1DCA62206B1;
	Wed, 30 Apr 2025 09:04:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="HOrwCMxH"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6114421D3F9;
	Wed, 30 Apr 2025 09:04:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746003856; cv=none; b=LSRsc9KZYZk0udqM4j81brVbiK/n50Q491RZPrd4w0GkntsczZ2Z3sRjr1IfVW7PJlhCBQdeI4X64cEcSjuirugtxRkArvVJba+gc9znvYeWlUoG7sl7ptjiVwJhvVculBsmuVLAl8v0cj3E2EoMGBaAKmYgA7uRtXTwEOHWLAc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746003856; c=relaxed/simple;
	bh=EkoOHQPQ3eaqRG+VimOFjk0KxHikHPluhIjOJ55s28Q=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=VG6HKbuMIwijY1AmnjRyWQaM+tTMHX7DKyk2WP57tA+HGUgtOnOnQoYEWAAmiRbJ1KaQkir1ZiLYghRaNGostrUDYV9KX0mAhWiqFKxYgiZpeVyJdlf01Z79uZJ+xIGv+E+pO0+eXK36QfSaFdeOHKzanG8i2RymuUeU4zX1hr0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=HOrwCMxH; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53TNkGna027564;
	Wed, 30 Apr 2025 09:03:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=vKuBZ5aZc0d1DJ2ixmVGYewRSDRmMTUcAvN2prhmT
	kc=; b=HOrwCMxHMgMabaP+Kinn51j52stEhUWOZXo3pp6SQXC2RlTIZ+g2mj83C
	QHlGx/GK5XkMAjlWRv/WHHhiQ/ydicPPU9tR0x2A6fCnCAJw+GA7yMnz5tUs2PL1
	uuF+Wxk26vZyjmnhNAHvPdsiyPzyVxpG3BKvzFbScPJ/syDBPo9VuTji/Lt4+u6n
	bhd/I8i9+5fvQouCHqj11tcF7ELXDd6OZyFS/VI++j45kI4bW7MASVm1wtgTFsfR
	LI0c9GFRFW2kSoCmCB5JMYN5ctH6kECzVzbqLbmqhK0pKr2JHhdfpCFR/KOSOiQD
	BdVko79xZAXSdQs+mhvZ1pDZE/ngQ==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 46b8r0sqks-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 30 Apr 2025 09:03:58 +0000 (GMT)
Received: from m0353725.ppops.net (m0353725.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 53U8mTQN021165;
	Wed, 30 Apr 2025 09:03:57 GMT
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 46b8r0sqkk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 30 Apr 2025 09:03:57 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 53U7DEPl031627;
	Wed, 30 Apr 2025 09:03:57 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4699tu79wn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 30 Apr 2025 09:03:56 +0000
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 53U93r7C17629530
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 30 Apr 2025 09:03:53 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 65DEF20043;
	Wed, 30 Apr 2025 09:03:53 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id EDC1F20075;
	Wed, 30 Apr 2025 09:03:50 +0000 (GMT)
Received: from li-fc74f8cc-3279-11b2-a85c-ef5828687581.ibm.com.com (unknown [9.39.31.221])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 30 Apr 2025 09:03:50 +0000 (GMT)
From: Srish Srinivasan <ssrish@linux.ibm.com>
To: linux-integrity@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Cc: maddy@linux.ibm.com, mpe@ellerman.id.au, npiggin@gmail.com,
        christophe.leroy@csgroup.eu, naveen@kernel.org, ajd@linux.ibm.com,
        zohar@linux.ibm.com, nayna@linux.ibm.com, linux-kernel@vger.kernel.org
Subject: [PATCH 0/3] Enhancements to the secvar interface in static key management mode
Date: Wed, 30 Apr 2025 14:33:47 +0530
Message-ID: <20250430090350.30023-1-ssrish@linux.ibm.com>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNDMwMDA2MCBTYWx0ZWRfX5CwEZ7CcAuaH 3JCjHEbeTGRgoqDQLepQqbrjtefpMY/V6FN6IVI7vwBene6TRku7Aups4kt74CdKU08uywcXSPT Bjlxn5SrcRsgMGcPYvxOTuaLbTrK40YKRBhZjYI0bZTq8h/exvWYJd6uIiI5wqQt26Tb2k2xahq
 8CqFE8J9HcBx00wvtKJMjS1SvvyUmLmOsF2bSjdmIeWnXYYtnKHR9y8SM6G3TXf3P/lhu6hlQgE hd3K6hVnmYmAIYl80+O85tweEkB+Q7LY3w5H4AgtMg4Nz/Ytry3pvN6FkfnQtbGeCRkT8sks3hr 0ViXFKs2MNKxX6V+3/6Qbt69cTmsZoZzA/5xxl0J4FOBRoASsUJk4D60Zlwfhw4Nl+bSiASaERK
 Be7QFUSxGsQ+SR++i7SOU5tnwoyN/uerOmiwVm23XK6o7gQQJtMFYnJVgHOYjv2Aj1X92XcD
X-Authority-Analysis: v=2.4 cv=OqdPyz/t c=1 sm=1 tr=0 ts=6811e77e cx=c_pps a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17 a=XR8D0OoHHMoA:10 a=-1jmnclONZOZV9iy3uUA:9
X-Proofpoint-GUID: WsIpi0vml3b7-lnxn2t7OFbitzGNn3PZ
X-Proofpoint-ORIG-GUID: 6QxYdSmDHmGiKknebpMSRVYlQek6CcKv
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-04-30_02,2025-04-24_02,2025-02-21_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 suspectscore=0 malwarescore=0 priorityscore=1501 bulkscore=0 mlxscore=0
 lowpriorityscore=0 adultscore=0 clxscore=1011 spamscore=0 mlxlogscore=999
 phishscore=0 classifier=spam authscore=0 authtc=n/a authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.19.0-2504070000
 definitions=main-2504300060

The PLPKS enabled Power LPAR sysfs exposes all of the secure boot secure
variables irrespective of the key management mode. There is support for
both static and dynamic key management and the key management mode can
be updated using the management console. The user can modify the secure
boot secvars db, dbx, grubdb, grubdbx, and sbat only in the dynamic key
mode. But the sysfs interface exposes these secvars even in static key
mode. This could lead to errors when reading them or writing to them in
the static key mode.

Update the secvar format property based on the key management mode and
expose only the secure variables relevant to the key management mode.
Enable loading of signed third-party kernel modules in the static key
mode when the platform keystore is enabled.

Srish Srinivasan (3):
  powerpc/pseries: Correct secvar format representation for static key
    management
  powerpc/secvar: Expose secvars relevant to the key management mode
  integrity/platform_certs: Allow loading of keys in static key
    management mode

 Documentation/ABI/testing/sysfs-secvar        |  9 +-
 arch/powerpc/platforms/pseries/plpks-secvar.c | 98 ++++++++++++-------
 .../integrity/platform_certs/load_powerpc.c   |  5 +-
 3 files changed, 73 insertions(+), 39 deletions(-)

-- 
2.47.1


