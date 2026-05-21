Return-Path: <linux-integrity+bounces-9621-lists+linux-integrity=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-integrity@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GERpKwM3D2qIHwYAu9opvQ
	(envelope-from <linux-integrity+bounces-9621-lists+linux-integrity=lfdr.de@vger.kernel.org>)
	for <lists+linux-integrity@lfdr.de>; Thu, 21 May 2026 18:46:59 +0200
X-Original-To: lists+linux-integrity@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 717705A9923
	for <lists+linux-integrity@lfdr.de>; Thu, 21 May 2026 18:46:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id B9598311344A
	for <lists+linux-integrity@lfdr.de>; Thu, 21 May 2026 15:18:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E837D33D6E6;
	Thu, 21 May 2026 15:18:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="IEXyX0q9"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6997E2F1FF4;
	Thu, 21 May 2026 15:18:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779376735; cv=none; b=XbaLb7ZnbLf+cPPpkx+IBMufhJUu+0hHBV35QpHIoRuRFenM7Fzr9qtBCBatjRcQMuWJaSJhlV3C+f7MnZrMq17tKkRdw3dnSMR1aJOHIn3Y6p8KfouEJ5U8OxmUG8y+m/9yd6VWH9GaOym6EEgL1MhhEFuYGRVtYGYd6kTBXyA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779376735; c=relaxed/simple;
	bh=xBZA5CsRVJzDN0qV96OM2/Zzfa5/4reQWlR18uIa24w=;
	h=Message-ID:Subject:From:To:Cc:In-Reply-To:References:Content-Type:
	 Date:MIME-Version; b=SigQ+hxzHiwqG/zGtvKkvke5nTqbjppy+gYxhpbMr97S1nz1FniiEgZ4C/xWEfkhMIir7J4nZXmriFYC75NQZMzVOpcv00tAFk0pml/28oxX6mQVVm4zmswl0q6wvPfAb5QOy5QLPXqte9OSmtUGChI7FE36QwLhCkt30AI1cuk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=IEXyX0q9; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64L6fYuB3442044;
	Thu, 21 May 2026 15:18:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=HI2nZz
	FWmsfYJxL1K0I6NvtdLfLvLyCHxjlaa9z5wtA=; b=IEXyX0q9AiyW6m26blwhuo
	Z5uF87uuT33mHg2MujBeEtmOAi7qkd1QeNWcSOpAxNtjm+ghaKX5PFAeY7pWGVkN
	5JSeSC80KeByBji/o1y6sed8of21kOauSpOcQV1m65imu/dek9KEFLClZa7WZnLJ
	ATjjI6CG+c+RhS4h4geF7WdTKyuVPYNVAD8RBekzuAKmzTxd86h13k8ZQQZ/spXL
	MhYzHxB7DA71DNvyTPFiqSYVdG+f9FRYwFEwBLlJYHGiNar8d2b3vyK0aK19fWhR
	rVpllZwEY0qS7U3axODxr60mTuLcJCzKT3cc06CLRvcXFN9pBTB1ieBF5ngo2aKQ
	==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4e6hawej1q-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 21 May 2026 15:18:30 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 64LEsAQg031009;
	Thu, 21 May 2026 15:18:29 GMT
Received: from smtprelay02.dal12v.mail.ibm.com ([172.16.1.4])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4e739w4y7v-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 21 May 2026 15:18:29 +0000 (GMT)
Received: from smtpav06.dal12v.mail.ibm.com (smtpav06.dal12v.mail.ibm.com [10.241.53.105])
	by smtprelay02.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 64LFIT3K12583570
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 21 May 2026 15:18:29 GMT
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 33B3758055;
	Thu, 21 May 2026 15:18:29 +0000 (GMT)
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 3449D5805E;
	Thu, 21 May 2026 15:18:28 +0000 (GMT)
Received: from li-43857255-d5e6-4659-90f1-fc5cee4750ad.ibm.com (unknown [9.61.146.128])
	by smtpav06.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 21 May 2026 15:18:28 +0000 (GMT)
Message-ID: <cf6322e0dc11ff64135f78f4eaad73eb7281f5d7.camel@linux.ibm.com>
Subject: Re: [PATCH v5 09/13] ima: Add support for staging measurements
 with prompt
From: Mimi Zohar <zohar@linux.ibm.com>
To: Roberto Sassu <roberto.sassu@huaweicloud.com>, corbet@lwn.net,
        skhan@linuxfoundation.org, dmitry.kasatkin@gmail.com,
        eric.snowberg@oracle.com, paul@paul-moore.com, jmorris@namei.org,
        serge@hallyn.com
Cc: linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-integrity@vger.kernel.org, linux-security-module@vger.kernel.org,
        gregorylumen@linux.microsoft.com, chenste@linux.microsoft.com,
        nramas@linux.microsoft.com, Roberto Sassu <roberto.sassu@huawei.com>
In-Reply-To: <20260429160319.4162918-10-roberto.sassu@huaweicloud.com>
References: <20260429160319.4162918-1-roberto.sassu@huaweicloud.com>
	 <20260429160319.4162918-10-roberto.sassu@huaweicloud.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Date: Thu, 21 May 2026 11:18:27 -0400
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Evolution 3.58.3 (3.58.3-1.fc43) 
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTIxMDE1MiBTYWx0ZWRfX3++jZjKBe+SO
 VPTu8bax+B9popHzhRPJxtZAG5UWN/UJEHRNPkWMuKVvHGhd/hwI6WoRhXTm3goYOW8ZVfCl7Po
 y6EH4muVnW2148x+YuPp7ddxYsn8uAn8AuYvG+YJ4HmR8SedrFNaN3/yC3tOX6xLatLmUuxG3RO
 /NbSKgugy8TeU/eUyuWqzfjkDbf4Ph0RR+RUBkQJA1WOnkyGaR2qH0dvt68eF/glU/BCPNpSL2B
 MfqD9xMo3yq3EhZ1JEirYL1inutw9+bLPqLvC9vUNM1sRmGVbhcmibi+QBsT6+KspoefDSzY+0Q
 L5Zl14T06AiyDyf1Htge9UD4WoqTJ5n7YDoF7hERUbEpXQjjOF9JqWpCfP5T9LL/z46QjaWegms
 iZBUNqAT57MDdhOJC80Z318eBFb6WS51WjyewnZJDNc4MhJ8yujqwhC9zIItD0iejG12ZubJwwi
 nkWFYHAcTYa3Tl4mVTg==
X-Authority-Analysis: v=2.4 cv=Np/htcdJ c=1 sm=1 tr=0 ts=6a0f2247 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=RzCfie-kr_QcCd8fBx8p:22 a=NEAV23lmAAAA:8
 a=i0EeH86SAAAA:8 a=yMhMjlubAAAA:8 a=a5u0tm0crO7lR8Lkly4A:9 a=QEXdDO2ut3YA:10
 a=O8hF6Hzn-FEA:10
X-Proofpoint-ORIG-GUID: KK3IyZ8vGpiSNbOK52o-n2rnwNqoMk8y
X-Proofpoint-GUID: s75_Kn3lWCeflKNh8kNDoBIp__Bv4BbE
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-21_02,2026-05-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 spamscore=0 clxscore=1015 priorityscore=1501 impostorscore=0
 lowpriorityscore=0 suspectscore=0 adultscore=0 phishscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605130000 definitions=main-2605210152
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[ibm.com,none];
	R_DKIM_ALLOW(-0.20)[ibm.com:s=pp1];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-9621-lists,linux-integrity=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[huaweicloud.com,lwn.net,linuxfoundation.org,gmail.com,oracle.com,paul-moore.com,namei.org,hallyn.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[16];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,huawei.com:email];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[zohar@linux.ibm.com,linux-integrity@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[ibm.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-integrity];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[11]
X-Rspamd-Queue-Id: 717705A9923
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Wed, 2026-04-29 at 18:03 +0200, Roberto Sassu wrote:
> From: Roberto Sassu <roberto.sassu@huawei.com>
>=20
> Introduce the ability of staging the IMA measurement list and deleting th=
em
> with a prompt.
>=20
> Staging means moving the current content of the measurement list to a

-> moving the current measurement list records ...

> separate location, and allowing users to read and delete it. This causes
> the measurement list to be atomically truncated before new measurements c=
an
> be added.=C2=A0

The wording is a bit off - "before new measurements can be added".  One of =
the
main objectives of staging the measurement list is to allow new measurement
records to continue to be added to the measurement list, while the staged
measurements are exported.

> Staging can be done only once at a time. In the event of kexec(),
> staging is reverted and staged entries will be carried over to the new
> kernel.
>=20
> Introduce ascii_runtime_measurements_<algo>_staged and
> binary_runtime_measurements_<algo>_staged interfaces to access and delete
> the measurements. Also, add write permission to the original measurement
> interfaces.

Wondering if adding "write" permission to the original measurement interfac=
e
will change based on your 9/13 comment.

The patch, like others in this patch set, are well written.  There are a co=
uple
of inline comments.  I'll defer reviewing the rest of this patch to v6.

>=20
> Use 'echo A > <IMA original interface>' and
> 'echo D > <IMA _staged interface>' to respectively stage and delete the
> entire measurements list. Locking of these interfaces is also mediated wi=
th
> a call to _ima_measurements_open() and with ima_measurements_release().
>=20
> Implement the staging functionality by introducing the new global
> measurements list ima_measurements_staged, and ima_queue_stage() and
> ima_queue_staged_delete_all() to respectively move measurements from the
> current measurements list to the staged one, and to move staged
> measurements to the ima_measurements_trim list for deletion. Introduce
> ima_queue_delete() to delete the measurements.
>=20
> Finally, introduce the BINARY_STAGED and BINARY_FULL binary measurements
> list types, to maintain the counters and the binary size of staged
> measurements and the full measurements list (including entries that were
> staged). BINARY still represents the current binary measurements list.
>=20
> Use the binary size for the BINARY + BINARY_STAGED types in
> ima_add_kexec_buffer(), since both measurements list types are copied to
> the secondary kernel during kexec. Use BINARY_FULL in
> ima_measure_kexec_event(), to generate a critical data record.
>=20
> It should be noted that the BINARY_FULL counter is not passed through
> kexec. Thus, the number of entries included in the kexec critical data
> records refers to the entries since the previous kexec records.
>=20
> Note: This code derives from the Alt-IMA Huawei project, whose license is
>       GPL-2.0 OR MIT.
>=20
> Link: https://github.com/linux-integrity/linux/issues/1
> Suggested-by: Gregory Lumen <gregorylumen@linux.microsoft.com> (staging r=
evert)
> Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>
> ---
>  security/integrity/ima/Kconfig     |  13 +++
>  security/integrity/ima/ima.h       |   8 +-
>  security/integrity/ima/ima_fs.c    | 181 ++++++++++++++++++++++++++---
>  security/integrity/ima/ima_kexec.c |  24 +++-
>  security/integrity/ima/ima_queue.c |  97 +++++++++++++++-
>  5 files changed, 302 insertions(+), 21 deletions(-)
>=20
> diff --git a/security/integrity/ima/Kconfig b/security/integrity/ima/Kcon=
fig
> index 862fbee2b174..48c906793efb 100644
> --- a/security/integrity/ima/Kconfig
> +++ b/security/integrity/ima/Kconfig
> @@ -332,4 +332,17 @@ config IMA_KEXEC_EXTRA_MEMORY_KB
>  	  If set to the default value of 0, an extra half page of memory for th=
ose
>  	  additional measurements will be allocated.
> =20
> +config IMA_STAGING
> +	bool "Support for staging the measurements list"
> +	default y

Exporting and deleting the IMA measurement list carries an inherent securit=
y
risk: if the measurements are not durably stored before deletion, they are
permanently lost. Deletion should be treated as experimental until a truste=
d
service exists to guarantee safe storage.

Please change the default to 'n'.


> +	help
> +	  Add support for staging the measurements list.
> +
> +	  It allows user space to stage the measurements list for deletion and
> +	  to delete the staged measurements after confirmation.
> +
> +	  On kexec, staging is reverted and staged measurements are prepended

-> staging is aborted and any staged measurement records are .copied ..

> +	  to the current measurements list when measurements are copied to the
> +	  secondary kernel.
> +
>  endif

Mimi

