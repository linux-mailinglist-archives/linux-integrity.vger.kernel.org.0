Return-Path: <linux-integrity+bounces-650-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 58FC0824896
	for <lists+linux-integrity@lfdr.de>; Thu,  4 Jan 2024 20:06:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CAA9F282F4C
	for <lists+linux-integrity@lfdr.de>; Thu,  4 Jan 2024 19:06:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 780DA28E06;
	Thu,  4 Jan 2024 19:06:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="SJMbvhGK"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA61E28E38
	for <linux-integrity@vger.kernel.org>; Thu,  4 Jan 2024 19:06:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 404Imwdi027328
	for <linux-integrity@vger.kernel.org>; Thu, 4 Jan 2024 19:06:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding; s=pp1;
 bh=0hVqyWWIRdJtqW+6EHYHyxpSniIppsbrvgnQiHKhKP0=;
 b=SJMbvhGKmCDNpsdP+xQlQAS1/GbLwkA6uNqemWwxR0r9tvUoZMXOjog5jwm3KtiDJdsV
 59XuXOlfMbx8dH5mQFVqzyUaUpKR2H4eLCxiHuLB/NIWf7UlipUwumK0fQSgjgrneWTC
 h+j76dk//++pYC9mtSMsQok3WM9RcPe/2C/9iTuDNh4JFAFVkj0LGNZjivtpIgupaoAI
 NeeVFKCTi97OdKYuVwEAqlnKRJvWHCVv4eMsNumX7WcCwT+ECAPbhq4PHKj/eLfTa5Ss
 cHl5+3xfycPDPSpFO8/5s4X0VxbI8sLysMm56kwggitMpiayEmCaLNRAUXOobT0TEqGr Cg== 
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3ve298gdew-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-integrity@vger.kernel.org>; Thu, 04 Jan 2024 19:06:08 +0000
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 404GvscJ007298
	for <linux-integrity@vger.kernel.org>; Thu, 4 Jan 2024 19:06:08 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3vaxhpb468-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-integrity@vger.kernel.org>; Thu, 04 Jan 2024 19:06:08 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 404J652I15204974
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 4 Jan 2024 19:06:05 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 18D2C20043;
	Thu,  4 Jan 2024 19:06:05 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 5766420040;
	Thu,  4 Jan 2024 19:06:04 +0000 (GMT)
Received: from li-f45666cc-3089-11b2-a85c-c57d1a57929f.watson.ibm.com (unknown [9.31.99.90])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu,  4 Jan 2024 19:06:04 +0000 (GMT)
From: Mimi Zohar <zohar@linux.ibm.com>
To: linux-integrity@vger.kernel.org
Cc: Stefan Berger <stefanb@linux.ibm.com>, Mimi Zohar <zohar@linux.ibm.com>
Subject: [ima-evm-utils PATCH v3 00/13] Address non concurrency-safe libimaevm global variables
Date: Thu,  4 Jan 2024 14:05:45 -0500
Message-Id: <20240104190558.3674008-1-zohar@linux.ibm.com>
X-Mailer: git-send-email 2.39.3
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: QYpmGCbpXzh1n6PCzOpHXXUGAeJ4jrdo
X-Proofpoint-ORIG-GUID: QYpmGCbpXzh1n6PCzOpHXXUGAeJ4jrdo
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-04_11,2024-01-03_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0
 priorityscore=1501 phishscore=0 bulkscore=0 adultscore=0 impostorscore=0
 mlxlogscore=985 mlxscore=0 lowpriorityscore=0 clxscore=1015 suspectscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2401040149

The libimaevm global variables are not concurrency-safe.  Instead of
relying on global variables, define new functions with these variables
as parameters, update static functions definitions with these variables,
and deprecate existing functions.  The change is limited to public keys,
hash algorithm, and key password.

To avoid library incompatability, make the existing functions wrappers
for the new function versions and deprecate existing functions.

The deprecated function warnings can be disabled by specifying
'-Wno-deprecated-declarations'.  Allow suppressing just the libimevm
warnings by enabling IMAEVM_SUPPRESS_DEPRECATED.

e.g. configure CFLAGS="-DIMAEVM_SUPPRESS_DEPRECATED"

Changelog v3:
Addressed Stefan Berger's comments:
- Forward declare "struct public_key_entry" in order to replace
  "void *public_key" usage.
- Move the "__attribute__((deprecated))" from the functions to the function
  definitions.
- Allow suppressing just the libimevm deprecated warngings by defining
  and enabling "-DIMAEVM_SUPPRESS_DEPRECATED".
- Add "Reviewed-by" tags.

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

 src/evmctl.c    | 136 +++++++++++++++++++++++++++-----------------
 src/imaevm.h    |  29 ++++++++--
 src/libimaevm.c | 148 +++++++++++++++++++++++++++++++++++-------------
 3 files changed, 218 insertions(+), 95 deletions(-)

-- 
2.39.3


