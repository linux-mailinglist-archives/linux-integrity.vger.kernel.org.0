Return-Path: <linux-integrity+bounces-5023-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C343A4A46E
	for <lists+linux-integrity@lfdr.de>; Fri, 28 Feb 2025 21:55:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 373B77AA09B
	for <lists+linux-integrity@lfdr.de>; Fri, 28 Feb 2025 20:54:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F23D1C173F;
	Fri, 28 Feb 2025 20:55:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="MEH33GkV"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA77823F38F
	for <linux-integrity@vger.kernel.org>; Fri, 28 Feb 2025 20:55:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740776133; cv=none; b=YjbVXxijh+XmV0ig6wAwKGIHc4KK1MBLNEwu5hhlPyiEKEv+lgJllGKbNr8RJwzN/WwZNYLBD+y6hY37hZnm8EeOgonkKMfbVR9ObNxevLCjJC1rhuCae3Wl/luqR1uRsvA/4KLT7i/6N7WY0kMpaZOoG5JTJZkQcdf9AzLqMkE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740776133; c=relaxed/simple;
	bh=AGPGb7YXK4QewsAu+1/Y0aY9U4QjycK8KehHMrrzvRA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=K0/Esoug1xkBbCS7lu+neOwCV+Vl+5HhYCqj4mkjisnpynbMjjt7O5mzdOcIVOoRo6vaz3HlNG184z0J4B1I19mvh+vQQtXGgHAdc4fXudnPTDzBzctGBcQI7zFW1BaSmm5sXbsnXbKB8ADmAa6AFLYoeJazikXzHQly4dR1Iwg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=MEH33GkV; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51SHVtd3025723;
	Fri, 28 Feb 2025 20:55:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=tCJgUbqdRpFwoDgOgc9St0YLRROk66eM6X4Vj0+tE
	c8=; b=MEH33GkVFPbN5L5MTTxcjCFXpvyjnOhjXq179qGHq7XBYPrMILhT+l2m9
	sNB+THp5lp6BNPgcl3xw8BTT/t4yYjb5+Kj+fPoTMowrGM61O97QITbLC0Sffz3W
	SB/Y0P0zEAyAI/Il7Ab1dRIeuhj4N5N3C7yhVu8UG1O5iJFkrRzeWiiBJQxbhDDR
	5F8MjLlAtqv+nQcXhpcT/GrDn2oF8Tz9n9XiE5rgjM1Pl7T8VRhoxPuSrfH74Vmp
	1nklUyUkw576mkZP71B+otl2q9fgn3+vtyCQpjJqDb4RwCWoj8uBzrYx6CmZpfAd
	Z5muy6VTfPbJA6XIcyLrUzE6pAsSA==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4538uq3shr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 28 Feb 2025 20:55:20 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 51SJYbEL012918;
	Fri, 28 Feb 2025 20:55:19 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 44yrwt8tcv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 28 Feb 2025 20:55:19 +0000
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 51SKtG2538470004
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 28 Feb 2025 20:55:16 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 2327F20043;
	Fri, 28 Feb 2025 20:55:16 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A46C720040;
	Fri, 28 Feb 2025 20:55:14 +0000 (GMT)
Received: from li-43857255-d5e6-4659-90f1-fc5cee4750ad.ibm.com.com (unknown [9.61.94.47])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 28 Feb 2025 20:55:14 +0000 (GMT)
From: Mimi Zohar <zohar@linux.ibm.com>
To: linux-integrity@vger.kernel.org
Cc: Mimi Zohar <zohar@linux.ibm.com>, roberto.sassu@huawei.com,
        Stefan Berger <stefanb@linux.ibm.com>, Petr Vorel <pvorel@suse.cz>
Subject: [PATCH v2 0/2] ima: minimize open-writers and ToMToU violations
Date: Fri, 28 Feb 2025 15:55:03 -0500
Message-ID: <20250228205505.476845-1-zohar@linux.ibm.com>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: KtKTnQyZkI9dYbXGPq36a9znK5SMxCng
X-Proofpoint-ORIG-GUID: KtKTnQyZkI9dYbXGPq36a9znK5SMxCng
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-28_06,2025-02-28_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 bulkscore=0
 phishscore=0 lowpriorityscore=0 impostorscore=0 mlxlogscore=600
 clxscore=1015 suspectscore=0 priorityscore=1501 spamscore=0 malwarescore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2502100000 definitions=main-2502280148

Each time a file in policy, that is already opened for write, is opened
for read, an open-writers integrity violation audit message is emitted
and a violation record is added to the IMA measurement list.

Similarly each time a file in policy, that is already opened for read,
is opened for write, a Time-of-Measure-Time-of-Use (ToMToU) integrity
violation audit message is emitted and a violation record is added to
the IMA measurement list.

As there is no benefit in having multiple open-writers or ToMToU
violations for the same file open in the audit log and IMA measurement
list, minimize them.

Minimizing open-writer violations results in a single open-writers
violation being emitted until all writers are closed no matter the
number of subsequent file open readers (or writers).

Minimizing ToMToU violations results in a single ToMToU violation being
emitted for all subsequent file open writers, until another in policy
file open reader.

Since the IMA_MUST_MEASURE atomic flag is only used for tracking ToMToU
violations, rename the atomic flag to IMA_MAY_EMIT_TOMTOU.

Define a new atomic flag named IMA_EMITTED_OPENWRITERS to minimize
open-writer violations.

Mimi Zohar (2):
  ima: limit the number of open-writers integrity violations
  ima: limit the number of ToMToU integrity violations

 security/integrity/ima/ima.h      |  3 ++-
 security/integrity/ima/ima_main.c | 18 +++++++++++++-----
 2 files changed, 15 insertions(+), 6 deletions(-)

--
2.48.1


