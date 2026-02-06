Return-Path: <linux-integrity+bounces-8470-lists+linux-integrity=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-integrity@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eD4UK/oKhmkRJQQAu9opvQ
	(envelope-from <linux-integrity+bounces-8470-lists+linux-integrity=lfdr.de@vger.kernel.org>)
	for <lists+linux-integrity@lfdr.de>; Fri, 06 Feb 2026 16:38:34 +0100
X-Original-To: lists+linux-integrity@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 17530FFD2A
	for <lists+linux-integrity@lfdr.de>; Fri, 06 Feb 2026 16:38:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E97E7303FFF5
	for <lists+linux-integrity@lfdr.de>; Fri,  6 Feb 2026 15:36:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8D1329B8DB;
	Fri,  6 Feb 2026 15:36:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="P4NtCUFB"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 938612BE644
	for <linux-integrity@vger.kernel.org>; Fri,  6 Feb 2026 15:36:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770392204; cv=none; b=Zym9VdzFweugzSk8eL3T1obtnCFnWJ4gpaokURak8FiezWEViTFfLteJodk9QdpuDoLNlFpQHuRA2PM9eL0Esxrmssf41RM43NjjSTrL9x+1bfC/QyxPSw+cNKAM6O87WsglvmJfhAtJc8izp7qZFgC+GyPP0BRabpeTq94/gyI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770392204; c=relaxed/simple;
	bh=thioLb4ahDaSMLlEIOOhGbWfPSDsmGoTgjvDBPPm8Hg=;
	h=Message-ID:Subject:From:To:In-Reply-To:References:Content-Type:
	 Date:MIME-Version; b=PQ5JEG9SpsbIDJOrfVHs2IVfJPtY0n/ldoxGWJRgKPc+mm7HX2c6nfXtTJnuZSInYRTq/GvvwW1vOXO9IZQipmg08qgG99cHyxg/uXSxwKi2FWUK3EOSvlyw6dJy40qluztzro91N7rLY3dTjEMQyzkglW4S4y2BIRqrp6jWK8E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=P4NtCUFB; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 616EjLkH005433;
	Fri, 6 Feb 2026 15:36:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=
	content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=N+7Oyt
	Di7sYc0+N2cUY/aXErU9gEauS3Ni6MTU+FxOk=; b=P4NtCUFBoO4QnFrbkJaqlZ
	zgsf6ghdya2jRRe+k+SHuMIWHSKZdSqZaI7icw84s0LdEPW0903vm6EP35IMwIVv
	RCn0d+Vjm4/zxGwOd0xSJsowTorpE3GN0w8SdpoQ+vgPbtWrdg8NZ23zX4ZfZpfp
	a7SWgkuOlfAbaV6iEwSBugp1FaTEhM3exRXPLLZ2Fz/NUvSsCl24KhfIDG/2/NnN
	9cb3LAWLoWhdS2RMcN4iJTG7g5MUPwh8xtoYoPwAhMU1EomhCtq0eFv02nMpLVoT
	XzB/Hn9aAs1XVh+wyoIqNlZUn5JMbE4OcK/ipSWGyXLkT+OdsrywVF12Xy1Jhu0w
	==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4c19dtm5bn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 06 Feb 2026 15:36:39 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 616DrKqK027357;
	Fri, 6 Feb 2026 15:36:38 GMT
Received: from smtprelay07.wdc07v.mail.ibm.com ([172.16.1.74])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4c1xs1pek4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 06 Feb 2026 15:36:38 +0000
Received: from smtpav06.dal12v.mail.ibm.com (smtpav06.dal12v.mail.ibm.com [10.241.53.105])
	by smtprelay07.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 616Fabvq30212770
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 6 Feb 2026 15:36:38 GMT
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 9BF935805D;
	Fri,  6 Feb 2026 15:36:37 +0000 (GMT)
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 57AA558043;
	Fri,  6 Feb 2026 15:36:37 +0000 (GMT)
Received: from li-43857255-d5e6-4659-90f1-fc5cee4750ad.ibm.com (unknown [9.61.138.68])
	by smtpav06.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Fri,  6 Feb 2026 15:36:37 +0000 (GMT)
Message-ID: <f8b3451a6ef619dd2934bc839618fabc9408967c.camel@linux.ibm.com>
Subject: Re: IMA vs TPM (SPI) boot order problems
From: Mimi Zohar <zohar@linux.ibm.com>
To: Jonathan McDowell <noodles@earth.li>, linux-integrity@vger.kernel.org,
        Romain Naour <romain.naour@smile.fr>
In-Reply-To: <aYXEepLhUouN5f99@earth.li>
References: <aYXEepLhUouN5f99@earth.li>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Date: Fri, 06 Feb 2026 10:36:36 -0500
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Evolution 3.56.2 (3.56.2-2.fc42) 
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjA2MDExMSBTYWx0ZWRfXzxA6GOR/YLBZ
 cUS2CYTybLjdL/zQjlMExQib4a8FzRm/5HzUtyDEyG2ZjNIvU7n/ASt6G5eaXcspvr+A6ufBF1C
 VCARJU1RLh2mNVgOiWiu2qN+ADkqN6PbDY9X9Ad/4+J7a6d5WnctQUkpfXQXrb2lhHvHGGIj2TX
 Gi/wYKvRpkkoOcfzDYiMJX5yb63wCo/unX1kSNR46Xq8y6EKGawdrDABDZjT98zvQMT/fd/6FJw
 PI/XQwnbofdCZm2D9BO50xEmByOyNW+MoHhM9R65Xxv6vxBC69qCMOfMb+9/oB7F0WprvHBWLkW
 LV5gWVjNDnUkdWDlZJOYJWBtSRLllDWXYmJRW7OKBxepis/XOdcEWHhp3CXil3a4+xxTIwlOQhg
 vD0zS6iOi0u3Ly0CkJ/HQGu04KiqZJNVt0ot+uQqp/RHOdqzKvaXA0/cVJ1OogceiQxcy33LfxG
 Lxk12aT+rfhGXiG81Tw==
X-Proofpoint-GUID: dGgHh-Yr7bI5-3PZVmPR8LZ_LE5mHEOl
X-Proofpoint-ORIG-GUID: dGgHh-Yr7bI5-3PZVmPR8LZ_LE5mHEOl
X-Authority-Analysis: v=2.4 cv=LesxKzfi c=1 sm=1 tr=0 ts=69860a87 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=IkcTkHD0fZMA:10 a=HzLeVaNsDn8A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=Mpw57Om8IfrbqaoTuvik:22 a=GgsMoib0sEa3-_RKJdDe:22 a=VwQbUJbxAAAA:8
 a=Xtfh4XruUQ4jryaDHREA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-06_04,2026-02-05_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 impostorscore=0 spamscore=0 lowpriorityscore=0 clxscore=1011
 adultscore=0 suspectscore=0 priorityscore=1501 phishscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2601150000 definitions=main-2602060111
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[ibm.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[ibm.com:s=pp1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_THREE(0.00)[3];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-8470-lists,linux-integrity=lfdr.de];
	DKIM_TRACE(0.00)[ibm.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.ibm.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[zohar@linux.ibm.com,linux-integrity@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	PRECEDENCE_BULK(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[linux-integrity];
	RCVD_COUNT_SEVEN(0.00)[11]
X-Rspamd-Queue-Id: 17530FFD2A
X-Rspamd-Action: no action

On Fri, 2026-02-06 at 10:37 +0000, Jonathan McDowell wrote:
> I'm seeing an issue with a SPI attached TPM, where it's not coming up=20
> early enough for IMA to decide there's a TPM available that it can=20
> measure into. The TPM is definitely present, and by the time we get to=
=20
> userspace it's working fine.
>=20
> This is sort of resurrecting a post from 2024 by Romain, though that=20
> concerned an i2c TPM:
>=20
> https://lore.kernel.org/all/9b98d912-ba78-402c-a5c8-154bef8794f7@smile.fr=
/
>=20
> There doesn't seem to have actually been a fixed applied, so I tried the=
=20
> late_initcall_sync suggestion, but that didn't change things:
>=20
> [    0.000000] ACPI: TPM2 0x0000004044BCA998 00004C (v04 ALASKA A M I    =
00000001 AMI  00000000)
> [    0.000000] GICv3: 960 SPIs implemented
> [    0.000000] GICv3: 320 Extended SPIs implemented
> [    0.000447] LSM: initializing lsm=3Dcapability,bpf,ima
> [    0.394832] Trying to unpack rootfs image as initramfs...
> [    0.681134] tegra-qspi NVDA1513:00: Adding to iommu group 1
> [    0.681241] tegra-qspi NVDA1513:00: device reset failed
> [    0.686925] tpm_tis_spi spi-PRP0001:01: 2.0 TPM (device-id 0x1B, rev-i=
d 22)
> [    0.894451] ima: No TPM chip found, activating TPM-bypass!
> [    0.894462] ima: Allocated hash algorithm: sha256
> [    0.894471] ima: No architecture policies found
>=20
> This seems to show SPI + the TPM coming up before IMA, but still not in=
=20
> a way that makes IMA happy.

Here's an example with really well written patch descriptions, that was
upstreamed:

746d9e9f62a6 ("tpm: tpm_crb_ffa: try to probe tpm_crb_ffa when it's built-i=
n")
0e0546eabcd6 ("firmware: arm_ffa: Change initcall level of ffa_init() to
rootfs_initcall")

Mimi

