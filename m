Return-Path: <linux-integrity+bounces-92-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 45D8B7F07A1
	for <lists+linux-integrity@lfdr.de>; Sun, 19 Nov 2023 17:51:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 777BF1C208CA
	for <lists+linux-integrity@lfdr.de>; Sun, 19 Nov 2023 16:51:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8447156F6;
	Sun, 19 Nov 2023 16:51:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="lduu1mBE"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC94E11A
	for <linux-integrity@vger.kernel.org>; Sun, 19 Nov 2023 08:51:18 -0800 (PST)
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3AJGAY2t001079
	for <linux-integrity@vger.kernel.org>; Sun, 19 Nov 2023 16:51:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding; s=pp1;
 bh=ZuZIWUp8TdRTZYUQ94RgmNyJLPcK8wHYyBsTovzoGQ4=;
 b=lduu1mBEISuOPZFp+Mn+HncFUsjV5pXMWord/e00XHJsHq6T2Ih8MhPAyqmIttcRCxkG
 P5B00ALr8DaCCBJMFcGQb2gUbqm24hJA2nrberCFoEbx/M86VTym+RAQVmzttSMmwagS
 Qocwk8YSiSfgy75WNLgxivoFW+wnG+/QrKFOtskFWsxskg6EvfQm6Tmfc1XTlF18U2Zu
 5cUFcLFx4l9b1imvU08Team8zhD5y8vVZ74vg6A7ayLDyi3mtRrcPi4+/aRiN57F6aJE
 zLzN5oU8RgsbyVkTTalFTmdtlMs01TBcT8fvsWOrb91AfTAzDuQ2luwDssMjej0yNh4l ag== 
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3ueywxsk6a-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-integrity@vger.kernel.org>; Sun, 19 Nov 2023 16:51:18 +0000
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 3AJECDur006607
	for <linux-integrity@vger.kernel.org>; Sun, 19 Nov 2023 16:50:51 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 3uf9tjupa6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-integrity@vger.kernel.org>; Sun, 19 Nov 2023 16:50:51 +0000
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 3AJGom0b45089042
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sun, 19 Nov 2023 16:50:48 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 8F51C20049;
	Sun, 19 Nov 2023 16:50:48 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A20CE20040;
	Sun, 19 Nov 2023 16:50:47 +0000 (GMT)
Received: from li-f45666cc-3089-11b2-a85c-c57d1a57929f.ibm.com.com (unknown [9.61.134.108])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Sun, 19 Nov 2023 16:50:47 +0000 (GMT)
From: Mimi Zohar <zohar@linux.ibm.com>
To: linux-integrity@vger.kernel.org
Cc: Mimi Zohar <zohar@linux.ibm.com>
Subject: [ima-evm-utils PATCH 00/12] Address non concurrency-safe libimaevm global variables
Date: Sun, 19 Nov 2023 11:50:31 -0500
Message-Id: <20231119165043.46960-1-zohar@linux.ibm.com>
X-Mailer: git-send-email 2.39.3
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: a33PkwczBJEAbJGfULWk8fAOTTlrqbRg
X-Proofpoint-ORIG-GUID: a33PkwczBJEAbJGfULWk8fAOTTlrqbRg
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-19_15,2023-11-17_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 mlxlogscore=721
 malwarescore=0 clxscore=1015 impostorscore=0 bulkscore=0 adultscore=0
 priorityscore=1501 suspectscore=0 spamscore=0 lowpriorityscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311060000 definitions=main-2311190129

The libimaevm global variables are not concurrency-safe.  Instead of
relying on global variables, define new functions with these variables
as parameters, update static functions definitions with these variables,
and deprecate existing functions.  Limit change to public keys, hash
algorithm, and key password.

To avoid library incompatability, make the existing functions wrappers
for the new function versions.

Mimi Zohar (12):
  Rename "public_keys" to "g_public_keys"
  Free public keys list
  Update library function definitions to include a "public_keys"
    parameter
  Update a library function definition to include a "hash_algo"
    parameter
  Update cmd_verify_ima() to define and use a local list of public keys
  Update cmd_verify_evm to define and use a local list of public keys
  Update ima_measurements to define and use a local list of public keys
  Define library ima_calc_hash2() function with a hash algorithm
    parameter
  Use a local hash algorithm variable when verifying file signatures
  Update EVM signature verification to use a local hash algorithm
    variable
  Use a file specific hash algorithm variable for signing files
  Define and use a file specific "keypass" variable

 src/evmctl.c    |  99 +++++++++++++++++-------------
 src/imaevm.h    |   5 ++
 src/libimaevm.c | 159 ++++++++++++++++++++++++++++++++++++------------
 3 files changed, 181 insertions(+), 82 deletions(-)

-- 
2.39.3


