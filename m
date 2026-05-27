Return-Path: <linux-integrity+bounces-9691-lists+linux-integrity=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-integrity@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iNMPDa4AF2o70wcAu9opvQ
	(envelope-from <linux-integrity+bounces-9691-lists+linux-integrity=lfdr.de@vger.kernel.org>)
	for <lists+linux-integrity@lfdr.de>; Wed, 27 May 2026 16:33:18 +0200
X-Original-To: lists+linux-integrity@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id B0D005E5ED0
	for <lists+linux-integrity@lfdr.de>; Wed, 27 May 2026 16:33:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3F156302C153
	for <lists+linux-integrity@lfdr.de>; Wed, 27 May 2026 14:31:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB4D6366557;
	Wed, 27 May 2026 14:31:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="Mj3U3bbx"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62BB0282F3A;
	Wed, 27 May 2026 14:31:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779892281; cv=none; b=j55rKkpCXu3ciKO/Z7fU4o+oomrfVn0oTqaOp+y7hyiWj6Hxsd00SWVSwY68t9O52vEqGzbHZVEnaF+vjJlVkuB+DNLvLFUIas4viwivRKwli85HG92wDuavNIylni61UyssCVk6U54pmbEIw3KVlcgKuD2297hQBxZG8HQPXHM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779892281; c=relaxed/simple;
	bh=/O4X8XttFEqtU/q5/9L0DucZnE8x2s4y53B1d9aP46A=;
	h=Message-ID:Subject:From:To:Cc:In-Reply-To:References:Content-Type:
	 Date:MIME-Version; b=i+HezyFpT9AWX9nOtwdAv6MTu7eGMJmxC45rMeEba9FTw/lDeohqWjEyFB/8rrJxAILLzIp28w9UMaPHtX1XxBe8443azxvlCp0jgRVm8QseE+2IxgC0Mh8qkxdAHXWiMzve0Xlq7/qQxIFGfxhuX6XpNV+4tYcjap4CUkdTwFM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=Mj3U3bbx; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64RCWOnM3811204;
	Wed, 27 May 2026 14:30:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=+ebLCj
	YLh7IMim41EldDt0WxK7+GjVy9RdI6q1Bwocs=; b=Mj3U3bbxzJwjlVrOnvrpOL
	SqqMeo/ZtGpYvvCUGF8AZUBsW/+iCt5kGnYp8TwEQa8agsX3yDsHVkBuLMn+iSB4
	CW8FEwQkETKFWG92hvzFEmwG35gftC1OxvG+/xs/NxZFvGFu2W6mY8BuMuHb4qiK
	l9qjHSvxIWEy9A7Fld4g3RJ7fp+YF9ehEH2tvptQx+NVa0HaX6/49isHMMqTbPFS
	Nd3GYt7LfaW/sHbBVSA9w6SzgDlFxDJSB/sd3GsxILWSi4rhQyNyva+5VsxAWEvK
	Nbsxx465Ia/SYeo+s3P/PYjaF9kcwkGaMXw7a0MKhcT59cq2HuOOOfhngEv5HzFQ
	==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4eb4qc1s8m-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 27 May 2026 14:30:58 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 64REOCKg020611;
	Wed, 27 May 2026 14:30:58 GMT
Received: from smtprelay07.wdc07v.mail.ibm.com ([172.16.1.74])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4edjrb3dd8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 27 May 2026 14:30:57 +0000 (GMT)
Received: from smtpav02.wdc07v.mail.ibm.com (smtpav02.wdc07v.mail.ibm.com [10.39.53.229])
	by smtprelay07.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 64REUvaM27918918
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 27 May 2026 14:30:57 GMT
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 3B3AC58059;
	Wed, 27 May 2026 14:30:57 +0000 (GMT)
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C84B158058;
	Wed, 27 May 2026 14:30:55 +0000 (GMT)
Received: from li-43857255-d5e6-4659-90f1-fc5cee4750ad.ibm.com (unknown [9.61.130.141])
	by smtpav02.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 27 May 2026 14:30:55 +0000 (GMT)
Message-ID: <e017ff8eb8bee4540e8877a594774508e8a79311.camel@linux.ibm.com>
Subject: Re: [PATCH v4 2/3] security: ima: introduce IMA_INIT_LATE_SYNC
 option
From: Mimi Zohar <zohar@linux.ibm.com>
To: Yeoreum Yun <yeoreum.yun@arm.com>, linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-integrity@vger.kernel.org
Cc: paul@paul-moore.com, roberto.sassu@huaweicloud.com, noodles@earth.li,
        jarkko@kernel.org, sudeep.holla@kernel.org, jmorris@namei.org,
        serge@hallyn.com, dmitry.kasatkin@gmail.com, eric.snowberg@oracle.com,
        jgg@ziepe.ca
In-Reply-To: <20260525075404.3480282-3-yeoreum.yun@arm.com>
References: <20260525075404.3480282-1-yeoreum.yun@arm.com>
	 <20260525075404.3480282-3-yeoreum.yun@arm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Date: Wed, 27 May 2026 10:30:55 -0400
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Evolution 3.58.3 (3.58.3-1.fc43) 
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTI3MDEzOCBTYWx0ZWRfX5rqMimvjJ+8O
 MXcc30tj2YLxNOysf6dydiVh4cb8AtV+TxVITu7nNoanFtM30RVUSfu72sjAWaaaC6sgaoJG/Zg
 xENuMNQPuO7G0iDjHay/c7fciANJkRlXcipb2fRDwfgFq/IIfxKiSHYsiTsPd7O6+YQfsVXIRDt
 RHMgaBbAJVPcR09Kog/HL0oYDWxPYfmZOnuH9WmRouTwjpH6KNfq5r+a0LQhda4p8Dge76yMu9w
 CNhfCHsbhu8Nn7KaVD38dCKcd5O5T7imcomH80jQPulqAHSFblYU7G18fqnK5Fe+JiYxDeFJ65w
 EUxlG0SdJJx74sGnmLAre8nDd6d1PC8ATnd1spgyN8/v+INmwt7hu7Y7/ukU5/cEkiRQN5pggzX
 1duXSgfMezAZXz8ZL7tjiY6+zPJkPVe5dKt/pQKFXAYgt5WS6Z7zB92pSVsJtjQqjyNxI/sSkEV
 HamsitVb4jchW1A0LUA==
X-Authority-Analysis: v=2.4 cv=KItqylFo c=1 sm=1 tr=0 ts=6a170023 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=uAbxVGIbfxUO_5tXvNgY:22 a=VwQbUJbxAAAA:8
 a=VnNF1IyMAAAA:8 a=7CQSdrXTAAAA:8 a=UcpHEPep0OYEHb0RgzgA:9 a=QEXdDO2ut3YA:10
 a=a-qgeE7W1pNrGK8U0ZQC:22
X-Proofpoint-ORIG-GUID: UBimQHyf8YaVJBDIqd5V8dmem3IIgSY7
X-Proofpoint-GUID: Ds-Smd86gvxxCuSKhbfuMPwMo8RWAwLS
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-05-27_02,2026-05-26_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 malwarescore=0 lowpriorityscore=0 spamscore=0 priorityscore=1501
 clxscore=1015 adultscore=0 suspectscore=0 bulkscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605130000 definitions=main-2605270138
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[ibm.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[ibm.com:s=pp1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[14];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-9691-lists,linux-integrity=lfdr.de];
	FREEMAIL_CC(0.00)[paul-moore.com,huaweicloud.com,earth.li,kernel.org,namei.org,hallyn.com,gmail.com,oracle.com,ziepe.ca];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,arm.com:email];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
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
X-Rspamd-Queue-Id: B0D005E5ED0
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Mon, 2026-05-25 at 08:54 +0100, Yeoreum Yun wrote:
> To generate the boot_aggregate log in the IMA subsystem with TPM PCR valu=
es,
> the TPM driver must be built as built-in and
> must be probed before the IMA subsystem is initialized.
>=20
> However, when the TPM device operates over the FF-A protocol using
> the CRB interface, probing fails and returns -EPROBE_DEFER if
> the tpm_crb_ffa device =E2=80=94 an FF-A device that provides the communi=
cation
> interface to the tpm_crb driver =E2=80=94 has not yet been probed.
>=20
> To ensure the TPM device operating over the FF-A protocol with
> the CRB interface is probed before IMA initialization,
> the following conditions must be met:
>=20
> 1. The corresponding ffa_device must be registered,
>    which is done via ffa_init().
>=20
> 2. The tpm_crb_driver must successfully probe this device via
>    tpm_crb_ffa_init().
>=20
> 3. The tpm_crb driver using CRB over FF-A can then
>    be probed successfully. (See crb_acpi_add() and
>    tpm_crb_ffa_init() for reference.)
>=20
> Unfortunately, ffa_init(), tpm_crb_ffa_init(), and crb_acpi_driver_init()=
 are
> all registered with device_initcall, which means crb_acpi_driver_init() m=
ay
> be invoked before ffa_init() and tpm_crb_ffa_init() are completed.
>=20
> When this occurs, probing the TPM device is deferred.
> However, the deferred probe can happen after the IMA subsystem
> has already been initialized, since IMA initialization is performed
> during late_initcall, and deferred_probe_initcall() is performed
> at the same level.
>=20
> And the similar situation is reported on TPM devices attached on SPI
> bus[0].
>=20
> To resolve this, introduce IMA_INIT_LATE_SYNC option to initialise
> IMA at late_inicall_sync so that IMA is initialized with the TPM
> device probed deffered.

-> deferred

>=20
> When this option is enabled, modules that access files in the
> initramfs through usermode helper calls such as request_module()
> during initcall must not be built-in. Otherwise, IMA may miss
> measuring those files since they're the file accesses before the

Reword or remove phrase starting with "since".

> initialisation of IMA [1].
>=20
> Link: https://lore.kernel.org/all/aYXEepLhUouN5f99@earth.li/ [0]
> Link: https://lore.kernel.org/all/2b3782398cc17ce9d355490a0c42ebce9120a9a=
e.camel@linux.ibm.com/ [1]
> Suggested-by: Mimi Zohar <zohar@linux.ibm.com>
> Signed-off-by: Yeoreum Yun <yeoreum.yun@arm.com>

This version of the patch drops differentiating the boot_aggregate record b=
ased
on initcall as was posted in "[RFC PATCH v3 1/4] lsm: Allow LSMs to registe=
r for
late_initcall_sync init".  Being able to differentiate the initcalls is nee=
d by
the remote attestation services.

Mimi

