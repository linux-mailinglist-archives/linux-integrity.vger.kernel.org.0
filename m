Return-Path: <linux-integrity+bounces-9803-lists+linux-integrity=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-integrity@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id mtngB4D7M2qIKAYAu9opvQ
	(envelope-from <linux-integrity+bounces-9803-lists+linux-integrity=lfdr.de@vger.kernel.org>)
	for <lists+linux-integrity@lfdr.de>; Thu, 18 Jun 2026 16:06:56 +0200
X-Original-To: lists+linux-integrity@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id AF9966A0CCA
	for <lists+linux-integrity@lfdr.de>; Thu, 18 Jun 2026 16:06:55 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=ibm.com header.s=pp1 header.b=ex6SexHG;
	spf=pass (mail.lfdr.de: domain of "linux-integrity+bounces-9803-lists+linux-integrity=lfdr.de@vger.kernel.org" designates 2600:3c09:e001:a7::12fc:5321 as permitted sender) smtp.mailfrom="linux-integrity+bounces-9803-lists+linux-integrity=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=ibm.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 29BAF3009174
	for <lists+linux-integrity@lfdr.de>; Thu, 18 Jun 2026 14:06:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A69A232AACB;
	Thu, 18 Jun 2026 14:06:52 +0000 (UTC)
X-Original-To: linux-integrity@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2845F279907;
	Thu, 18 Jun 2026 14:06:50 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781791612; cv=none; b=CFcCYQ8XBcVBV2hC02u7WjV3/XDhZa5/0Us5Kx95ByB1jgp0f2fmdGAotNdTMC6UAjNuDAJcO6NBw1JiqxBtfouCVGZpJZE15SYI9fFgn470QJntbHDXBh46pYRWeC/MjiMcTSt55XyGez+UBb44r6p7NCNyCUoA/JjOXUncKNw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781791612; c=relaxed/simple;
	bh=/fyhEkJ9q9lSrie8Jmmg+EDMW0JQfR4csULgOoPMnM8=;
	h=Message-ID:Subject:From:To:Cc:Content-Type:Date:MIME-Version; b=odrbgArim4tW5zEERaeJCaMN/uG2wDrqN3JJPHdzZSUAPd1PmCpM2Izinm23V5P/A7HjmPYL6d9KDxDqz09bJev8q3Q0okQOw1fF0n8/VZNkVWTsjQmy4ZUqxqFryHT7kIMOS43+bzYY8S4zqWI72Ae6n8NXT+XfYMT3Yze7+9Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=ex6SexHG; arc=none smtp.client-ip=148.163.158.5
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65IDILfb3466226;
	Thu, 18 Jun 2026 14:06:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=pp1; bh=WpXof7h4wdwqlXsy5ii+7djm3x4o
	cfPhSBumI57G32U=; b=ex6SexHGHK18EudCX7lCvSeNKgnRCsnLboFZAtDFqd9D
	aupRIgXa6KWkQDGO9qegvuYmZ6hI0NS7znC8ZqZhsElsZdXsThdKgXo/oEoDgeDI
	LeQbn7ZEvtQwhL01r+UGrn8Eg5/I31fQ18r4WRaxkyrkQh00bNqddi6l3DBqfccN
	GJpIg5uExhzr64zpoaNmufzaQCAk5YYSRinBXFXhpii3nnFVX7rmbGZ7flXdG+wf
	H4bigjfjBqIxHjAhzq5n1husiRa1lIrZeu13hBfvSOpFnhUN5EJSgw9VH/4O0ekX
	6Lcvt/7Tphl9cq498FrbnebZp4u1Pi1LrgWELHS0Ng==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4eueqxgcps-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 18 Jun 2026 14:06:39 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 65IE51cG029507;
	Thu, 18 Jun 2026 14:06:39 GMT
Received: from smtprelay05.dal12v.mail.ibm.com ([172.16.1.7])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4ev172c2rs-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 18 Jun 2026 14:06:39 +0000 (GMT)
Received: from smtpav03.dal12v.mail.ibm.com (smtpav03.dal12v.mail.ibm.com [10.241.53.102])
	by smtprelay05.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 65IE6c8C33620656
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 18 Jun 2026 14:06:38 GMT
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 821F258060;
	Thu, 18 Jun 2026 14:06:38 +0000 (GMT)
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 23BCF5803F;
	Thu, 18 Jun 2026 14:06:38 +0000 (GMT)
Received: from li-43857255-d5e6-4659-90f1-fc5cee4750ad.ibm.com (unknown [9.61.121.126])
	by smtpav03.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 18 Jun 2026 14:06:38 +0000 (GMT)
Message-ID: <2a5a07ef24454c295c3a63ae8cedcd6c47578101.camel@linux.ibm.com>
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
Date: Thu, 18 Jun 2026 10:06:01 -0400
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Evolution 3.58.3 (3.58.3-1.fc43) 
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=OcSoyBTY c=1 sm=1 tr=0 ts=6a33fb6f cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VwQbUJbxAAAA:8
 a=k78ojuanA3dAwUmKk3MA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjE4MDEyOSBTYWx0ZWRfXz6Ph96Dpm1R5
 gPHGdP/3UdAvXuPZ2Bbm8T7UgSsxL2GzBrc6BRlNOYMcXYsH1+DBOjcqgZNxn2LPi599OqIHTQg
 pxjti9s34w2QrhRdprKAWa5U9R0kPUUjvEj74g6BZgm8PTawZkUSA2ubFpaky6CL4Tmpf4yn2GK
 8jXFOHE6+tyIxyy5SUxNJIdEydHqq8cnG3d6GObIwBslMYrrFxvauXgN7JgyUT9SVANVPcADYQH
 nfkPzfg5l89yjRDiHzaXZJJGduaCd/Ctht0DotW+e8WcoNQbaQzg6wgN5rT417Dp80yNdPFMsYI
 h7Llh8JFeFbXNjF1oxrVXUpTmxdMzPRzl4qIXGkpjD3DGzei7hO/0UjTAOYsZzR2KfZahgzuSDj
 jHmk0LfecT9JGYtn7qcO+gEYr4McIBorcXXkp+SUudNYpcZx8kLMvaucEYW6lLPqG2+OJ5uaAUR
 0zp+fpRHMh/rxnjFGjA==
X-Proofpoint-GUID: 4vNjoCRC-FNPf1FfglTDk2cuwHCUSR1z
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjE4MDEyOSBTYWx0ZWRfXw4C89HDSUL9E
 piOsASLrQJ4wRncOfCKfqZi2E6wIJVE4lVGU064yRvju7FneU7wAAxSKCVQxQFXuxasrj18s7b4
 2NnZ9vOyDYgs/UdH4DPlLlgOMo4DU20=
X-Proofpoint-ORIG-GUID: 4vNjoCRC-FNPf1FfglTDk2cuwHCUSR1z
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-18_01,2026-06-18_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 phishscore=0 bulkscore=0 suspectscore=0 lowpriorityscore=0
 impostorscore=0 malwarescore=0 spamscore=0 adultscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606180129
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[ibm.com,none];
	R_DKIM_ALLOW(-0.20)[ibm.com:s=pp1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-9803-lists,linux-integrity=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo];
	FORGED_RECIPIENTS(0.00)[m:torvalds@linux-foundation.org,m:linux-integrity@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:roberto.sassu@huaweicloud.com,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[zohar@linux.ibm.com,linux-integrity@vger.kernel.org];
	DKIM_TRACE(0.00)[ibm.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
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
X-Rspamd-Queue-Id: AF9966A0CCA

Hi Linus,
                                                                           =
   =20
There are 2 main changes, some code cleanup, and a couple of bug fixes.    =
   =20

Main changes:
- Introduce IMA and EVM post-quantum ML-DSA signature support

ML-DSA signature support for IMA and EVM is limited to sigv3 signatures, wh=
ich
signs a hash of a compact structure containing the file data/metadata hash,=
 hash
type, and hash algorithm. IMA and EVM still calculate the file data/metadat=
a
hashes respectively.

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
methods reduce the period during which new measurements are blocked from be=
ing
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


