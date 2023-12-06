Return-Path: <linux-integrity+bounces-359-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D8BB80789A
	for <lists+linux-integrity@lfdr.de>; Wed,  6 Dec 2023 20:28:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B6D141F212E8
	for <lists+linux-integrity@lfdr.de>; Wed,  6 Dec 2023 19:28:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4698A47F4D;
	Wed,  6 Dec 2023 19:28:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="Gd/XFSAE"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75F0CD5A
	for <linux-integrity@vger.kernel.org>; Wed,  6 Dec 2023 11:28:07 -0800 (PST)
Received: from pps.filterd (m0353724.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3B6HKtFs017268
	for <linux-integrity@vger.kernel.org>; Wed, 6 Dec 2023 19:28:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding; s=pp1;
 bh=jLvmK53HpS6QN0dKKKjBx5n0jv2dV5F2cO2BdMxjHaU=;
 b=Gd/XFSAEw8c5+aJ9wPsQdnGmUgrhWUzfBXdYnbTR+pj9RAN9AMOg1VMxW11lonbL4Q/D
 J9Jgfj3qsM4+TzSrE/4cIg+Hl/ZOjvJt+RjlHdLnyt4Ud2+7YaNSRRcTm4q4V6Vkza0k
 Bmfkh24ePqGXO2c2eQc4kHFuaTGyDVJyL0/RsIgrK21a4EFQjBRDwgz7pSk4MDwkHxuF
 +e/d6GZaNFgcmOAVK31utE9nGdZFzeyj5+qD8fbDLKxy/nkr9B+OOXIreNyaGWpKJyJN
 9j9p1MHDBrac5S6xVEJ8ZtQwbymwd3UDuuKVaLussufbJIRzcfn9uXJfZAWBCov5CEKW dQ== 
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3utw5huhpd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-integrity@vger.kernel.org>; Wed, 06 Dec 2023 19:28:06 +0000
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 3B6IZ47R013740
	for <linux-integrity@vger.kernel.org>; Wed, 6 Dec 2023 19:28:05 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3utau46jt1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-integrity@vger.kernel.org>; Wed, 06 Dec 2023 19:28:05 +0000
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 3B6JS2jn20709928
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 6 Dec 2023 19:28:02 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 8EC792004B;
	Wed,  6 Dec 2023 19:28:02 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 715FF20040;
	Wed,  6 Dec 2023 19:28:01 +0000 (GMT)
Received: from li-f45666cc-3089-11b2-a85c-c57d1a57929f.ibm.com.com (unknown [9.61.99.183])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed,  6 Dec 2023 19:28:01 +0000 (GMT)
From: Mimi Zohar <zohar@linux.ibm.com>
To: linux-integrity@vger.kernel.org
Cc: Stefan Berger <stefanb@linux.ibm.com>, Mimi Zohar <zohar@linux.ibm.com>
Subject: [ima-evm-utils PATCH v2 00/13] Address non concurrency-safe libimaevm global variables
Date: Wed,  6 Dec 2023 14:27:21 -0500
Message-Id: <20231206192734.339999-1-zohar@linux.ibm.com>
X-Mailer: git-send-email 2.39.3
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: HYzHUBBKVp6mXn4lM3MlxgariILKnXNV
X-Proofpoint-GUID: HYzHUBBKVp6mXn4lM3MlxgariILKnXNV
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-06_16,2023-12-06_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 spamscore=0
 lowpriorityscore=0 phishscore=0 malwarescore=0 bulkscore=0 adultscore=0
 priorityscore=1501 suspectscore=0 mlxlogscore=999 impostorscore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2312060141

The libimaevm global variables are not concurrency-safe.  Instead of
relying on global variables, define new functions with these variables
as parameters, update static functions definitions with these variables,
and deprecate existing functions.  The change is limited to public keys,
hash algorithm, and key password.

To avoid library incompatability, make the existing functions wrappers
for the new function versions and deprecate existing functions.

Changelog v2:
Addressed Stefan Berger's comments:
- Prefix the new library functions to avoid namespace pollution.
- Define internal library function 'public_keys' as struct
  public_key_entry, not void.
- Prefix new static global variables with 'g_'.
- Annotate deprecated functions with "__attribute__(deprecated)".
- init_public_keys() function was defined as void. The new
  imaevm_init_public_keys() function is defined as an int. Check the
  return value.
- Update sign_{ima,evm} function definitions to include the hash
  algorithm as a paramater.
- Added Stefan's "Reviewed-by" tag.

Mimi Zohar (13):
  Rename "public_keys" to "g_public_keys"
  Free public keys list
  Update library function definitions to include a "public_keys"
    parameter
  Update imaevm_verify_hash() definition to include "hash_algo"
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
  Update sign_hash_v*() definition to include the key password
  Define and use a file specific "keypass" variable

 src/evmctl.c    | 135 ++++++++++++++++++++++++++----------------
 src/imaevm.h    |   9 +++
 src/libimaevm.c | 153 +++++++++++++++++++++++++++++++++++-------------
 3 files changed, 205 insertions(+), 92 deletions(-)

-- 
2.39.3


