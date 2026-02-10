Return-Path: <linux-integrity+bounces-8485-lists+linux-integrity=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-integrity@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YH1aNsFGi2kpTwAAu9opvQ
	(envelope-from <linux-integrity+bounces-8485-lists+linux-integrity=lfdr.de@vger.kernel.org>)
	for <lists+linux-integrity@lfdr.de>; Tue, 10 Feb 2026 15:54:57 +0100
X-Original-To: lists+linux-integrity@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 38A0A11C258
	for <lists+linux-integrity@lfdr.de>; Tue, 10 Feb 2026 15:54:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B783C302B3A1
	for <lists+linux-integrity@lfdr.de>; Tue, 10 Feb 2026 14:54:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 425DC37FF50;
	Tue, 10 Feb 2026 14:54:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="ZhR0Tdwg"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8A99368263;
	Tue, 10 Feb 2026 14:54:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770735295; cv=none; b=hesNVF0QlHwGnAZi6YS2+k3bQiVfVNZ9vByWQEaChqJCvdhY68Sgid8I5nV0+AMHytboBZ6cfTAX0wCDfs+O/kFbca0aFhdrTyuQcEogi2BgWmQe/BIA+uBuARC8HBipb8QUN2W0kiTDEovzxoH7lg7dzDQrtiTntUMqUR+IvXs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770735295; c=relaxed/simple;
	bh=sDVw4Eh0PVZprk0KGVnzWwRhV18oKr8j16nPaOBBSEU=;
	h=Message-ID:Subject:From:To:Cc:Content-Type:Date:MIME-Version; b=F4o4dHNC7WMzJDhNv+W9tXSQSdo4HjKaGlgKSfI5TCeVLmTUFWjUxdQtBKoHC5rztq+ncn4TvwiismoPRkWbDmhSCTNI7k5RoA1E4g8uN2CQGxvM/+bgs+3aP8jerJKcMouEv2p6On/3i2WaajaXvyl8t4ghiotmEQMN4LNFD4M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=ZhR0Tdwg; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 61A3jbxR3537614;
	Tue, 10 Feb 2026 14:54:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=pp1; bh=SHzQwoL5pn42P/gN/Am5armdFRlR
	nUQaSEKwuWWplhE=; b=ZhR0TdwgIXE1JrXKK78MRDO1rDRY2KEAueHuaUdaHCEY
	VKHpm3GBgn9DV8BuFAZG/4GTBTpfFqmlLGgE/nCsfhY2/3ydPn82o4TK3L4yaRCR
	y/Kjd+wDeh94EJamK8TDFPOg1hBLkW192Io9NhHikKsFyOsYvdzy1aR+jeavtuQj
	paG6qtmvDoCOqMJurFVjkdp2z+FlC5Pn4X041zkZE6Jm2eUpJr/1CrPzh6EFI4l+
	/gs05WElrTv86fUdiGC7/xejV/5ZRrpgslhQatUEgeAqjUCzi0c+0oLXtiM7D72E
	vQSMT+uJHCG9dCpRi+2HkVefAQimCStHk/JyKmURqg==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4c696v2jqa-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 10 Feb 2026 14:54:43 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 61ABFbMu001815;
	Tue, 10 Feb 2026 14:54:43 GMT
Received: from smtprelay05.wdc07v.mail.ibm.com ([172.16.1.72])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4c6je21e2y-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 10 Feb 2026 14:54:43 +0000
Received: from smtpav06.dal12v.mail.ibm.com (smtpav06.dal12v.mail.ibm.com [10.241.53.105])
	by smtprelay05.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 61AEsgAs31851020
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 10 Feb 2026 14:54:42 GMT
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id F2D5A58055;
	Tue, 10 Feb 2026 14:54:41 +0000 (GMT)
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A506658043;
	Tue, 10 Feb 2026 14:54:41 +0000 (GMT)
Received: from li-43857255-d5e6-4659-90f1-fc5cee4750ad.ibm.com (unknown [9.61.16.10])
	by smtpav06.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 10 Feb 2026 14:54:41 +0000 (GMT)
Message-ID: <a6da3d9309492557026cee3b5a50c6aea8967365.camel@linux.ibm.com>
Subject: [GIT PULL] integrity: subsystem updates for v7.0
From: Mimi Zohar <zohar@linux.ibm.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-integrity <linux-integrity@vger.kernel.org>,
        linux-kernel	
 <linux-kernel@vger.kernel.org>,
        Roberto Sassu
 <roberto.sassu@huaweicloud.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Date: Tue, 10 Feb 2026 09:54:41 -0500
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Evolution 3.56.2 (3.56.2-2.fc42) 
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: nY8fiXtv038aXmpOENWz7B6-sw5JM5MN
X-Proofpoint-ORIG-GUID: nY8fiXtv038aXmpOENWz7B6-sw5JM5MN
X-Authority-Analysis: v=2.4 cv=JdWxbEKV c=1 sm=1 tr=0 ts=698b46b3 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=IkcTkHD0fZMA:10 a=HzLeVaNsDn8A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=Mpw57Om8IfrbqaoTuvik:22 a=GgsMoib0sEa3-_RKJdDe:22 a=VwQbUJbxAAAA:8
 a=xPnSAAC3n9dleaLTOJgA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjEwMDEyNSBTYWx0ZWRfX756OJMz5bPOp
 ODgXpF9FbnZPXUZ0ZIm2+i49ehJFqb8rRpjmI+BYdSK+mdgB9XDYOYfoj3XGQgs3bNFJs3+H4Ir
 xSTSIk/bjjH+4045nRU0+K/QUYpqqe/K7hd/kUjwpq5ai5nWFf3Mem/sGIH0VrHn6gITNcfLC+G
 YBAIZ0u1QzTfBQt8tKScsSo1b3R4Sr/q0TdVaJJiK4ObTWhVKll/KY7K4UPK1/HJoEExtxmAyXu
 WELzcGJwYgCYoPZwaojdMqvaZaS88uPb0rEW4td6hFyuy4wxTpqOBqrMdyRCkYr5UR+mVx4rQOA
 Gj1UseKmaMgLSZME89U55+Q6lW2avXpbCsoyduTc8I67VKnBVXC2EUy7Frp4LnTMMzalkR1dPUq
 NqJjH+4rkw/a3MivpRqmtItmk8rlum3fi10MVnwVBAkqxFGE3LfaiuC3nGkYv/+hHHIcGm9dHxq
 RLY8or5XJ5jKD10ZfUg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-10_01,2026-02-10_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 clxscore=1015 impostorscore=0 bulkscore=0
 lowpriorityscore=0 suspectscore=0 adultscore=0 spamscore=0 malwarescore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2601150000
 definitions=main-2602100125
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[ibm.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[ibm.com:s=pp1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-integrity];
	MIME_TRACE(0.00)[0:+];
	MID_RHS_MATCH_FROM(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[11];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[zohar@linux.ibm.com,linux-integrity@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-8485-lists,linux-integrity=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns];
	TO_DN_ALL(0.00)[];
	DKIM_TRACE(0.00)[ibm.com:+]
X-Rspamd-Queue-Id: 38A0A11C258
X-Rspamd-Action: no action

Hi Linus,

There are just two bug fixes: IMA's detecting scripts (bprm_creds_for_exec)=
,=20
calculating the EVM HMAC.

thanks,

Mimi


The following changes since commit f8f9c1f4d0c7a64600e2ca312dec824a0bc2f1da=
:

  Linux 6.19-rc3 (2025-12-28 13:24:26 -0800)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/zohar/linux-integrity.git=
/ tags/integrity-v7.0

for you to fetch changes up to 0496fc9cdc384f67be4413b1c6156eb64fccd5c4:

  evm: Use ordered xattrs list to calculate HMAC in evm_init_hmac() (2026-0=
1-23 14:31:41 -0500)

----------------------------------------------------------------
integrity-v7.0

----------------------------------------------------------------
Chris J Arges (1):
      ima: Fix stack-out-of-bounds in is_bprm_creds_for_exec()

Roberto Sassu (1):
      evm: Use ordered xattrs list to calculate HMAC in evm_init_hmac()

 security/integrity/evm/evm_crypto.c   | 14 ++++++++++----
 security/integrity/ima/ima.h          |  6 ++++--
 security/integrity/ima/ima_appraise.c | 16 +++-------------
 security/integrity/ima/ima_main.c     | 22 +++++++++++++---------
 4 files changed, 30 insertions(+), 28 deletions(-)

