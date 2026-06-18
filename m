Return-Path: <linux-integrity+bounces-9804-lists+linux-integrity=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-integrity@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id dMkSFK4HNGo9LgYAu9opvQ
	(envelope-from <linux-integrity+bounces-9804-lists+linux-integrity=lfdr.de@vger.kernel.org>)
	for <lists+linux-integrity@lfdr.de>; Thu, 18 Jun 2026 16:58:54 +0200
X-Original-To: lists+linux-integrity@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id E29166A1126
	for <lists+linux-integrity@lfdr.de>; Thu, 18 Jun 2026 16:58:53 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=ibm.com header.s=pp1 header.b=A4sUM46a;
	spf=pass (mail.lfdr.de: domain of "linux-integrity+bounces-9804-lists+linux-integrity=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="linux-integrity+bounces-9804-lists+linux-integrity=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=ibm.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 54CF13019025
	for <lists+linux-integrity@lfdr.de>; Thu, 18 Jun 2026 14:58:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 027F438944E;
	Thu, 18 Jun 2026 14:58:52 +0000 (UTC)
X-Original-To: linux-integrity@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABC3A7083C;
	Thu, 18 Jun 2026 14:58:50 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781794731; cv=none; b=iXLSRg59F+Kcs+TlwQNDeM34Opx8zyKyFZ3D+eYatl2UiWTNjJJE4h1ixE/e/GJooFCwVGPoQc9h6mZLb+wjjesy5i+m5u+X7OEQvkc3oZh2DEUHZz7XLwJ84D4C/ZuV/W5L1j1VGsr1VA9WL97+rqWBZ0BVleqcJMoBVXfJOGk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781794731; c=relaxed/simple;
	bh=fIvL4+m1GMHzyxSknPY3yTTP2HLVnwplt+LjWa1aAdA=;
	h=Message-ID:Subject:From:To:Cc:Content-Type:Date:MIME-Version; b=uon5pNuFIx5VJz8fWTVPPL4Q/09NXGWydBtTZEhlEXtntbl6kRy6N6PXQpmjiCmDTsbglOvViE5T7+KKw8+8p4Lfi9oSKrlDim298zBCmMiL9pIe5QckWWZ0Z+O/MeuIAdc0kW0Z8L6+CeIAdyEo+iVVb/dE2fLN+uYJlWCYVXw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=A4sUM46a; arc=none smtp.client-ip=148.163.156.1
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65IEIHRb3688698;
	Thu, 18 Jun 2026 14:58:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=pp1; bh=jn5I7cwWoRbcEPLhPRVFfJ6Qs7nc
	HkcNtFByzBO1LBY=; b=A4sUM46afbmAWgw6NMwolrPXbzZ1K845wC5Ns4aLe2o6
	lqnm5Xsdk7PLrFj5vRCY+s1ZHDF/c+jCySsKgUAhLrW3RjT7CEMdmVuKVl6HJL29
	uPOzd+i6y5xuh8yFaXNeDwTZfnbDzxaiHZXnFwyyaR9cp3iPx1H0oVs84Dx9cAHb
	7troE/Vp8aQeRqZrSIXk4Fh+xGESpVAxghPa8PKAkfjP7lX95c6kLFLEttufOvvn
	mQDLkQK+A/DIb/zpj323EWclHC2Vh+MLw7oj8kZEC/Sn3BE/axkDQkJtzM9Oyp8t
	EYFApc9pJk9Lr+NLV/wZDUghtLYQiaF92003M/uYWA==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4eueqtrs26-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 18 Jun 2026 14:58:42 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 65IEncg5002062;
	Thu, 18 Jun 2026 14:58:41 GMT
Received: from smtprelay06.dal12v.mail.ibm.com ([172.16.1.8])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4ev172492k-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 18 Jun 2026 14:58:41 +0000 (GMT)
Received: from smtpav03.dal12v.mail.ibm.com (smtpav03.dal12v.mail.ibm.com [10.241.53.102])
	by smtprelay06.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 65IEwerG25887440
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 18 Jun 2026 14:58:41 GMT
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E308F58061;
	Thu, 18 Jun 2026 14:58:40 +0000 (GMT)
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 5BFEA58056;
	Thu, 18 Jun 2026 14:58:40 +0000 (GMT)
Received: from li-43857255-d5e6-4659-90f1-fc5cee4750ad.ibm.com (unknown [9.61.121.126])
	by smtpav03.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 18 Jun 2026 14:58:40 +0000 (GMT)
Message-ID: <e20929a067e41978ce92d782053b7d5c46210e3a.camel@linux.ibm.com>
Subject: [GIT PULL] integrity: subsystem fixes for v7.2
From: Mimi Zohar <zohar@linux.ibm.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-integrity <linux-integrity@vger.kernel.org>,
        linux-kernel	
 <linux-kernel@vger.kernel.org>,
        Roberto Sassu
 <roberto.sassu@huaweicloud.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Date: Thu, 18 Jun 2026 10:58:39 -0400
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Evolution 3.58.3 (3.58.3-1.fc43) 
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: LS1zLmoC8Hr5bVioR62Q3A4Xn8urn7Om
X-Proofpoint-GUID: LS1zLmoC8Hr5bVioR62Q3A4Xn8urn7Om
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjE4MDEzNyBTYWx0ZWRfX1ENzMxeZ2Zj3
 vrOg9V6XlRjX90u4BxIw3DQAY5JXLEiA2lI7BIrt8xyuO1FVm4fogMpxTQ2629i9fvLwkO0peOK
 KX9dkGXuxUohcu0UgcCwE5Cl1lIIsd5FL2bjSFyqpAwFeIZXedTBpOIO+qdRd0suMMzxw98c73a
 Rhm0loFXG2bK19Becbv1wojRKMaGt9UtsZyhtDTCWlW0n0BtTD7DwtxG9l1son3FcpKQVpmF2g3
 psUZuyt6KVGIQpTCAhbSMhLrDThzG76Z5iVRjrlG50SvlHvb6Mp3etDq/MOZZJiX26cIi9tuh75
 aFr3R6wS4cjA6TYAx441V+LbZb2XkHLS33kgqwAgGyL2ePnPeyNYWjMr1uyKDXEspjcqXEBmGZP
 804WfU9oZYJDmJNMxH2Wbh1pfhI5waewhOh8fhfd+K3ddtvt6fgOwWCcKvbX0GTP5w2I+GZ8MvE
 3FAPUlhcRJ3d8zhurHw==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjE4MDEzNyBTYWx0ZWRfXxb+vQcqBEemC
 ZVnHDT76GfpWkdWuy0T695VyypWD5eoTHykh8ikMhgs2VFxCvgdzUTbYwvISsjKStKTGw6HvEhf
 prdINN86M8Ued1RTMiY1eoKAajbINEU=
X-Authority-Analysis: v=2.4 cv=B4KJFutM c=1 sm=1 tr=0 ts=6a3407a2 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VwQbUJbxAAAA:8
 a=k78ojuanA3dAwUmKk3MA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-18_02,2026-06-18_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 adultscore=0 lowpriorityscore=0 suspectscore=0
 priorityscore=1501 clxscore=1015 phishscore=0 spamscore=0 bulkscore=0
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2606180137
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[ibm.com,none];
	R_DKIM_ALLOW(-0.20)[ibm.com:s=pp1];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-9804-lists,linux-integrity=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,linux.ibm.com:mid,linux.ibm.com:from_mime,vger.kernel.org:from_smtp];
	FORGED_RECIPIENTS(0.00)[m:torvalds@linux-foundation.org,m:linux-integrity@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:roberto.sassu@huaweicloud.com,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[zohar@linux.ibm.com,linux-integrity@vger.kernel.org];
	DKIM_TRACE(0.00)[ibm.com:+];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	MIME_TRACE(0.00)[0:+];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[zohar@linux.ibm.com,linux-integrity@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	FORGED_SENDER_FORWARDING(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[linux-integrity];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[11]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: E29166A1126

[Resending pull request with minor wording tweaks.]

Hi Linus,                                                                  =
   =20
                                                                           =
   =20
There are 2 main changes, some code cleanup, and a couple of bug fixes.    =
   =20
                                                                           =
   =20
Main changes:                                                              =
   =20
- Introduce IMA and EVM post-quantum ML-DSA signature support              =
   =20
                                                                           =
   =20
ML-DSA signature support for IMA and EVM is limited to sigv3 signatures, wh=
ich
calculates and verifies a hash of a compact structure containing the file
data/metadata hash, hash type, and hash algorithm. IMA and EVM still calcul=
ate
the file data/metadata hashes respectively.

- Introduce support for removing IMA measurement list records stored in ker=
nel
memory

The IMA measurement list can grow large depending on policy, but removing
records breaks remote attestation, unless they are safely preserved and mad=
e
available for attestation requests. Until environments are prepared to pres=
erve
the measurement records, a new CONFIG_IMA_STAGING Kconfig option is introdu=
ced
to guard against deletion.

Several approaches for removing measurement list records were evaluated but
rejected due to filesystem constraints, the introduction of a new critical =
data
record, and locking concerns. Two methods are being upstreamed: staged dele=
tion
with confirmation, and staged deletion of N records without confirmation. B=
oth
methods minimize the period during which new measurements are blocked from =
being
appended to the measurement list by staging the measurement list.` A compar=
ison
of the two methods is included in the documentation.

Thanks,

Mimi


The following changes since commit 254f49634ee16a731174d2ae34bc50bd5f45e731=
:

  Linux 7.1-rc1 (2026-04-26 14:19:00 -0700)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/zohar/linux-integrity.git=
/ tags/integrity-v7.2

for you to fetch changes up to 35d6f5e788dae0dcc4c42d1280360f19aef9ab52:

  doc: security: Add documentation of exporting and deleting IMA measuremen=
ts (2026-06-08 11:43:36 -0400)

----------------------------------------------------------------
integrity-v7.2

----------------------------------------------------------------
Goldwyn Rodrigues (1):
      ima: return error early if file xattr cannot be changed

Kamlesh Kumar (1):
      ima: Fix sigv3 signature handling for EVM_IMA_XATTR_DIGSIG

Pengpeng Hou (1):
      evm: terminate and bound the evm_xattrs read buffer

Roberto Sassu (12):
      ima: Remove ima_h_table structure
      ima: Replace static htable queue with dynamically allocated array
      ima: Introduce per binary measurements list type ima_num_records coun=
ter
      ima: Introduce per binary measurements list type binary_runtime_size =
value
      ima: Introduce _ima_measurements_start() and _ima_measurements_next()
      ima: Mediate open/release method of the measurements list
      ima: Use snprintf() in create_securityfs_measurement_lists
      ima: Introduce ima_dump_measurement()
      ima: Add support for staging measurements with prompt
      ima: Add support for flushing the hash table when staging measurement=
s
      ima: Support staging and deleting N measurements records
      doc: security: Add documentation of exporting and deleting IMA measur=
ements

Stefan Berger (4):
      integrity: Check for NULL returned by asymmetric_key_public_key
      integrity: Check that algo parameter is within valid range
      integrity: Refactor asymmetric_verify for reusability
      integrity: Add support for sigv3 verification using ML-DSA keys

 Documentation/admin-guide/kernel-parameters.txt |   6 +
 Documentation/security/IMA-export-delete.rst    | 203 ++++++++++++++
 Documentation/security/index.rst                |   1 +
 MAINTAINERS                                     |   2 +
 security/integrity/digsig_asymmetric.c          | 152 +++++++++--
 security/integrity/evm/evm_secfs.c              |  16 +-
 security/integrity/ima/Kconfig                  |  15 +
 security/integrity/ima/ima.h                    |  28 +-
 security/integrity/ima/ima_api.c                |   2 +-
 security/integrity/ima/ima_appraise.c           |  10 +-
 security/integrity/ima/ima_fs.c                 | 346 ++++++++++++++++++++=
+---
 security/integrity/ima/ima_init.c               |   5 +
 security/integrity/ima/ima_kexec.c              |  42 ++-
 security/integrity/ima/ima_policy.c             |   3 +-
 security/integrity/ima/ima_queue.c              | 327 ++++++++++++++++++++=
--
 15 files changed, 1057 insertions(+), 101 deletions(-)
 create mode 100644 Documentation/security/IMA-export-delete.rst


