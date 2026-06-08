Return-Path: <linux-integrity+bounces-9774-lists+linux-integrity=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-integrity@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 5EylFJb9Jmo7pQIAu9opvQ
	(envelope-from <linux-integrity+bounces-9774-lists+linux-integrity=lfdr.de@vger.kernel.org>)
	for <lists+linux-integrity@lfdr.de>; Mon, 08 Jun 2026 19:36:22 +0200
X-Original-To: lists+linux-integrity@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id E01016594EF
	for <lists+linux-integrity@lfdr.de>; Mon, 08 Jun 2026 19:36:21 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=ibm.com header.s=pp1 header.b=paTHSMAO;
	spf=pass (mail.lfdr.de: domain of "linux-integrity+bounces-9774-lists+linux-integrity=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="linux-integrity+bounces-9774-lists+linux-integrity=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=ibm.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6027F3051C75
	for <lists+linux-integrity@lfdr.de>; Mon,  8 Jun 2026 16:21:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B04434751E;
	Mon,  8 Jun 2026 16:21:37 +0000 (UTC)
X-Original-To: linux-integrity@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09FBB3469FC;
	Mon,  8 Jun 2026 16:21:33 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780935697; cv=none; b=VYh0TH+podPmXr+Cq8Ghliqp1ci3ozhd3LdQmKOd7S7YdctVX/1/iggiehoXiYj0wvF9FffPPMLg5dEb3n3Q8+su/q/gJwhJcPXLjCO4mO5CUwygCew63CQfyZBFk2FWylgNPWMDsovmU15Ltb/BAMry+VUg+7md2JdE+L+PIUQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780935697; c=relaxed/simple;
	bh=v3MaV/Co+8L1uir+O5xPbYzfEfB68PG7V7O3aJfnrvc=;
	h=Message-ID:Subject:From:To:Cc:In-Reply-To:References:Content-Type:
	 Date:MIME-Version; b=CWW2AjHxJXUc8/YKCZspDwTU4rOvLLP4Ey9I2VQnZVjHs49j/u9MR0Nxkt+uPFux8xg/RRvPxXwSd0FlfJxDisdJvhlsmnYN2G7Itrvv3EWHXfrS2HLPwKwUH75Ou/hXocwSe2uF2agRcDTFlnMOIVcfygLToEQnUeoYg7ymzi4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=paTHSMAO; arc=none smtp.client-ip=148.163.156.1
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 658DhXCW2849834;
	Mon, 8 Jun 2026 16:21:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=2Z686q
	A0PFjUcaAAImBwPxXGO3nXVtHFA8fkpcfa3Gs=; b=paTHSMAOsNKJodwrTo/Qzw
	xWXGIUcobGbBL1KZBLNM1PyW4+RG1S/sWjlSAET2C12MgQdOtJmi1JLtcSOpIjOR
	aFWvUZ6T+hFAFXnsA8eX3KwFIdw4lEYRvWm0wQmoDCILy+hUSHblD0WfPmsJdJkb
	Rb+GH4pN6POXux0SDF8ft5sUlbG4RT0+HM4YtsFufRcRQWjmxu8f5WdhNdP42Dxp
	qgbsquMqkoNjecfrUvm3WeiIqC7g0RMEqCq1dGm6YV2n3u7egkNJTiF/LiYT9Me+
	gus7u2IamZTX13funUF9w11VcIpSyM04JfCqW/OcmMczwYOd7EGZ3QoQNhwfwJBQ
	==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4emb9586y4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 08 Jun 2026 16:21:04 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 658GJiMD018275;
	Mon, 8 Jun 2026 16:21:03 GMT
Received: from smtprelay07.wdc07v.mail.ibm.com ([172.16.1.74])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4emycgx1gj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 08 Jun 2026 16:21:03 +0000 (GMT)
Received: from smtpav04.wdc07v.mail.ibm.com (smtpav04.wdc07v.mail.ibm.com [10.39.53.231])
	by smtprelay07.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 658GL2rQ11403880
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 8 Jun 2026 16:21:02 GMT
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 8E4FD58045;
	Mon,  8 Jun 2026 16:21:02 +0000 (GMT)
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 09EF158050;
	Mon,  8 Jun 2026 16:21:01 +0000 (GMT)
Received: from li-43857255-d5e6-4659-90f1-fc5cee4750ad.ibm.com (unknown [9.61.149.251])
	by smtpav04.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Mon,  8 Jun 2026 16:21:00 +0000 (GMT)
Message-ID: <22debae414a07a3cbdb62e723dfb737d6d4bd693.camel@linux.ibm.com>
Subject: Re: [PATCH v7 00/12] ima: Exporting and deleting IMA measurement
 records from kernel memory
From: Mimi Zohar <zohar@linux.ibm.com>
To: Roberto Sassu <roberto.sassu@huaweicloud.com>, corbet@lwn.net,
        skhan@linuxfoundation.org, dmitry.kasatkin@gmail.com,
        eric.snowberg@oracle.com, paul@paul-moore.com, jmorris@namei.org,
        serge@hallyn.com
Cc: linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-integrity@vger.kernel.org, linux-security-module@vger.kernel.org,
        gregorylumen@linux.microsoft.com, chenste@linux.microsoft.com,
        nramas@linux.microsoft.com, Roberto Sassu <roberto.sassu@huawei.com>
In-Reply-To: <20260605172236.2042045-1-roberto.sassu@huaweicloud.com>
References: <20260605172236.2042045-1-roberto.sassu@huaweicloud.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Date: Mon, 08 Jun 2026 12:21:00 -0400
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Evolution 3.58.3 (3.58.3-1.fc43) 
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Authority-Analysis: v=2.4 cv=N4UZ0W9B c=1 sm=1 tr=0 ts=6a26ebf0 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=U7nrCbtTmkRpXpFmAIza:22 a=i0EeH86SAAAA:8
 a=veqT70qKwYKqTZjYeGoA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: rWOIk9THD1O5MGkph097CQJrRU-jqhw_
X-Proofpoint-GUID: S4-J6idJEmYCWSVqSK2PwPI0D3IzTR67
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjA4MDE1MyBTYWx0ZWRfX7sAsKwaNIQTZ
 Ivu98Gl95got185xnNxqyQCiYOVGzQiOHZXfSfZhxNDjbdSxCtTSoI6s2vHmPQmmV1+WrtFA4sn
 kcI9zeOvFTrk9YCbSZr3oZYTPXllL5nBnF/sakkwlA3+gCVTO5siEByhvnkAtlbjLOPknkJFASP
 FSY/uk877mnIdQNsPx/IMq6FX00tFqEw7DXm7FiF7B0ESypySSMzXsEFK11BeQHk1lc74xHCevM
 2J4/QAw7+7PnLZC2swX1zRdHoHGAvY2ZOoovKDSioDb2WzwYhbZTVRJHfiYKBONo5qSoWgQvqO9
 DgK9aQ3J1wsrYEtCo7/huSZ/jSP5WkIhXquL52Sopvr13lOBU64yhxhoiU0RCOqRpxqxSqZqggA
 B1cwmvQH4myz1oFObva3SmnRS2vSfqPMUETanfCI0uMmfQOekufoQlEjk3j1/J3VVK5LeVcJbgv
 uxq5G+lwXmuuZSfeyug==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-08_04,2026-06-05_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 malwarescore=0 spamscore=0 clxscore=1015 lowpriorityscore=0
 phishscore=0 impostorscore=0 adultscore=0 priorityscore=1501 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2606080153
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[ibm.com,none];
	R_DKIM_ALLOW(-0.20)[ibm.com:s=pp1];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-9774-lists,linux-integrity=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[16];
	RCVD_TLS_LAST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FREEMAIL_TO(0.00)[huaweicloud.com,lwn.net,linuxfoundation.org,gmail.com,oracle.com,paul-moore.com,namei.org,hallyn.com];
	FORGED_RECIPIENTS(0.00)[m:roberto.sassu@huaweicloud.com,m:corbet@lwn.net,m:skhan@linuxfoundation.org,m:dmitry.kasatkin@gmail.com,m:eric.snowberg@oracle.com,m:paul@paul-moore.com,m:jmorris@namei.org,m:serge@hallyn.com,m:linux-doc@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:linux-integrity@vger.kernel.org,m:linux-security-module@vger.kernel.org,m:gregorylumen@linux.microsoft.com,m:chenste@linux.microsoft.com,m:nramas@linux.microsoft.com,m:roberto.sassu@huawei.com,m:dmitrykasatkin@gmail.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[zohar@linux.ibm.com,linux-integrity@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[huawei.com:email,vger.kernel.org:from_smtp,linux.ibm.com:mid,linux.ibm.com:from_mime];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[zohar@linux.ibm.com,linux-integrity@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[ibm.com:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[linux-integrity];
	RCVD_COUNT_SEVEN(0.00)[11]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: E01016594EF

On Fri, 2026-06-05 at 19:22 +0200, Roberto Sassu wrote:
> From: Roberto Sassu <roberto.sassu@huawei.com>
>=20
> Introduction
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>=20
> The IMA measurements list is currently stored in the kernel memory.
> Memory occupation grows linearly with the number of records, and can
> become a problem especially in environments with reduced resources.
>=20
> While there is an advantage in keeping the IMA measurements list in
> kernel memory, so that it is always available for reading from the
> securityfs interfaces, storing it elsewhere would make it possible to
> free precious memory for other kernel usage.
>=20
> The IMA measurements list needs to be retained and safely stored for new
> attestation servers to validate it. Assuming the IMA measurements list
> is properly saved, storing it outside the kernel does not introduce
> security issues, since its integrity is anyway protected by the TPM.
>=20
> Hence, the new IMA staging mechanism is introduced to export IMA
> measurements to user space and delete them from kernel space.
>=20
> Staging consists in atomically moving the current measurements list to a
> temporary list, so that measurements can be deleted afterwards. The
> staging operation locks the hot path (racing with addition of new
> measurements) for a very short time, only for swapping the list
> pointers. Deletion of the measurements instead is done locklessly, away
> from the hot path.
>=20
> There are two flavors of the staging mechanism. In the staging with
> prompt, all current measurements are staged, read and deleted upon
> confirmation. In the staging and deleting flavor, N measurements are
> staged from the beginning of the current measurements list and
> immediately deleted without confirmation.
>=20
>=20
> Usage
> =3D=3D=3D=3D=3D
>=20
> The IMA staging mechanism can be enabled from the kernel configuration
> with the CONFIG_IMA_STAGING option. This option prevents inadvertently
> removing the IMA measurement list on systems which do not properly save
> it.
>=20
> If the option is enabled, IMA duplicates the current securityfs
> measurements interfaces (both binary and ASCII), by adding the _staged
> file suffix. Both the original and the staging interfaces gain the write
> permission for the root user and group, but require the process to have
> CAP_SYS_ADMIN set.
>=20
> The staging mechanism supports two flavors.
>=20
> Staging with prompt
> ~~~~~~~~~~~~~~~~~~~
>=20
> The current measurement list is moved to a temporary staging area,
> allowing it to be saved to external storage, before being deleted upon
> confirmation.
>=20
> This staging process is achieved with the following steps.
>=20
>   1.  echo A > <_staged interface>: the user requests IMA to stage the
>       entire measurements list;
>   2.  cat <_staged interface>: the user reads the staged measurements;
>   3.  echo D > <_staged interface>: the user requests IMA to delete
>       staged measurements.
>=20
> Staging and deleting
> ~~~~~~~~~~~~~~~~~~~~
>=20
> N measurements are staged to a temporary staging area, and immediately
> deleted without further confirmation.
>=20
> This staging process is achieved with the following steps.
>=20
>   1.  cat <original interface>: the user reads the current measurements
>       list and determines what the value N for staging should be;
>   2.  echo N > <original interface>: the user requests IMA to delete N
>       measurements from the current measurements list.
>=20
>=20
> Management of Staged Measurements
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D
>=20
> Since with the staging mechanism measurement records are removed from
> the kernel, the staged measurements need to be saved in a storage and
> concatenated together, so that they can be presented during remote
> attestation as if staging was never done. This task can be accomplished
> by a remote attestation agent modified to support staging, or a system
> service.
>=20
>=20
> Patch set content
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>=20
> Patches 1-8 are preparatory patches to quickly replace the hash table,
> maintain separate counters for the different measurements list types,
> mediate access to the measurements list interface, and simplify the stagi=
ng
> patches.
>=20
> Patch 9 introduces the staging with prompt flavor. Patch 10 makes it
> possible to flush the hash table when deleting all the staged measurement=
s.
> Patch 11 introduces the staging and deleting flavor. Patch 12 adds the
> documentation of the staging mechanism.
>=20
>=20
> Changelog
> =3D=3D=3D=3D=3D=3D=3D=3D=3D
>=20
> v6:
>  - Make ima_extend_list_mutex as static since it is not needed anymore by
>    ima_dump_measurement_list() (suggested by Mimi)
>  - Export ima_flush_htable in patch 11 instead of 10 (suggested by Mimi)
>  - Add clarification in the documentation regarding a proactive remote
>    attestation agent, and storing all the measurements in the storage
>    (suggested by Mimi)

Roberto, thank you for making these and all the other changes.  The patch s=
et is
now queued in next-integrity.

Mimi

