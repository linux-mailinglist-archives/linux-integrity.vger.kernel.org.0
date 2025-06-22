Return-Path: <linux-integrity+bounces-6493-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 52B6DAE2FCC
	for <lists+linux-integrity@lfdr.de>; Sun, 22 Jun 2025 14:23:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 470863B3A2B
	for <lists+linux-integrity@lfdr.de>; Sun, 22 Jun 2025 12:22:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E8451DED7C;
	Sun, 22 Jun 2025 12:22:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="f469nGfo"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86D981A4F12;
	Sun, 22 Jun 2025 12:22:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750594976; cv=none; b=Z2hwCA6VAZny6YArwsmWfPAH6rgyOHDiTgd7SjJi+6H/5AYV58i/K7hwogAqZyO1EXWtePjyzHc169WpnlRuRiqCiVhqqrW8di9P5Evvq+B1W8iSxf8jakNY1X8ZVpP0FjtBYAlQsLhK3rI+ITwYlTBgZ0wkI3quh0HSyZiInxw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750594976; c=relaxed/simple;
	bh=KRjNzQ29EUr2lI75KF0mqNTaqwg++wgc+dsId2HE21g=;
	h=Message-ID:Subject:From:To:Cc:In-Reply-To:References:Content-Type:
	 Date:MIME-Version; b=sogA8floDTpAsnQWubLQxC2kbQNi3vtme3zE7hqLQ38pL0lMp3Rvzi9suLSKD7iDTDn9PadqDMkFckulVG66Wab0evan/Y6V+6I1mQlmCCTmaRIGCY5gECpDxOZjTOq1Otjn3yIRI4t0dhTs97thDxgXbcCTQ/eNmatBnOIXAPI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=f469nGfo; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55M9U1KN001347;
	Sun, 22 Jun 2025 12:22:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=cQeOCv
	EZJftYIWriW4YD8qUFLKSLRcM+bzupOIftamU=; b=f469nGfoUK6zRFeCKnECAQ
	2frMspi3yUyiZ1iTcVPr4OvtRZOurFwfDsNS5Ve3311/0VzaUpUgrzr8BPVwyCln
	/prtz51AHRYA5AIfLg6nBRzkwoK4qEOPoyUs9sVK6KVzW1+n+ifbLHzbZ4pKFR7V
	BJGeuTmn8wEKSAkMTamXkifMXFdFOgSeatR9mUL5fdV4Q0fPHPhkQUqxJ7AuDfGh
	G2KlBHXJxxpcrQnhbo96fy1BurYcxs9TZ8xP6aEITpvvl9KhxbDR9Ch4cKriYv+v
	TzPavutV2dkMceF6Zi7W473+9rhXobfvjYYv20AJUa+OUeeWFPAt08iWvh5vjkGA
	==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 47dmf2mjy0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 22 Jun 2025 12:22:45 +0000 (GMT)
Received: from m0360072.ppops.net (m0360072.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 55MCMiWn002080;
	Sun, 22 Jun 2025 12:22:44 GMT
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 47dmf2mjxu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 22 Jun 2025 12:22:44 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 55M8HsgC003994;
	Sun, 22 Jun 2025 12:22:43 GMT
Received: from smtprelay03.dal12v.mail.ibm.com ([172.16.1.5])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 47e99k9gxe-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 22 Jun 2025 12:22:43 +0000
Received: from smtpav01.wdc07v.mail.ibm.com (smtpav01.wdc07v.mail.ibm.com [10.39.53.228])
	by smtprelay03.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 55MCMhX612321336
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sun, 22 Jun 2025 12:22:43 GMT
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 354845804B;
	Sun, 22 Jun 2025 12:22:43 +0000 (GMT)
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 33EC258059;
	Sun, 22 Jun 2025 12:22:42 +0000 (GMT)
Received: from li-43857255-d5e6-4659-90f1-fc5cee4750ad.ibm.com (unknown [9.61.92.25])
	by smtpav01.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Sun, 22 Jun 2025 12:22:42 +0000 (GMT)
Message-ID: <47dbda783e5919a8137e3781472fe7ae94ee1c73.camel@linux.ibm.com>
Subject: Re: [PATCH v4 1/2] firmware: arm_ffa: Change initcall level of
 ffa_init() to rootfs_initcall
From: Mimi Zohar <zohar@linux.ibm.com>
To: Yeoreum Yun <yeoreum.yun@arm.com>, jarkko@kernel.org, sudeep.holla@arm.com,
        peterhuewe@gmx.de, jgg@ziepe.ca, stuart.yoder@arm.com
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-integrity@vger.kernel.org
In-Reply-To: <20250618102302.2379029-2-yeoreum.yun@arm.com>
References: <20250618102302.2379029-1-yeoreum.yun@arm.com>
	 <20250618102302.2379029-2-yeoreum.yun@arm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Date: Sun, 22 Jun 2025 08:22:41 -0400
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Evolution 3.54.3 (3.54.3-1.fc41) 
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=M5FNKzws c=1 sm=1 tr=0 ts=6857f595 cx=c_pps a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17 a=IkcTkHD0fZMA:10 a=6IFa9wvqVegA:10 a=7CQSdrXTAAAA:8 a=VnNF1IyMAAAA:8 a=DDGuNG6xrOoNSW4XS2IA:9 a=QEXdDO2ut3YA:10
 a=a-qgeE7W1pNrGK8U0ZQC:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjIyMDA3NiBTYWx0ZWRfX/vOuTE67BXDo idPqzdNkfcnMbLwb4vXYRhxryNp1Y4UPsaXdLQPyV1Qe8LJn471ge+7uBRvx0ZsJ4oy31JZTEfe YyHSwE3RjycjStnfIDWc/sSffqN0KrjOoc5rfCEIMMzVoAYW4hxqMdaCqUIl0nc72IvChl1yyhv
 gAje4CL5mo1YIur7sHb/KJP/A/BkG13d0wS192cJ3vTUuk9+TGJKKGXaOW9RYC8b8tI9SUqs3c9 SzQ83rNnTZuAwYa0UGlTZrSyME50LN8gU+GC4dTCDQ/xvaBlglJBsKU/nPMbHMkF38VWPmfuy1e yWKZRSQVouhXUVXAujW1VJaNs2Ok8Pot5+KCIhKL24y3u6Y5iJ4gqDkYTPzmHQh+CgdJ0haR/Zk
 INsoVoXbO/P4lgEW1hKtNa5ukxTSYdfZL6JRZx34ZDavd4XMshuAVLws/i8pWuNcSJd1Y1w7
X-Proofpoint-GUID: VWP3MNWq71S8Z8s0TWtHd95NamqWgdZX
X-Proofpoint-ORIG-GUID: OzPov1yOrvGApJkFDG_m7XqcFoHhFzOs
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-22_04,2025-06-20_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 bulkscore=0 malwarescore=0 impostorscore=0 suspectscore=0
 priorityscore=1501 phishscore=0 spamscore=0 clxscore=1011 adultscore=0
 mlxscore=0 mlxlogscore=999 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2506220076

On Wed, 2025-06-18 at 11:23 +0100, Yeoreum Yun wrote:
> The Linux IMA (Integrity Measurement Architecture) subsystem used for sec=
ure
> boot, file integrity, or remote attestation cannot be a loadable module
> for few reasons listed below:
>=20
>  o Boot-Time Integrity: IMA=E2=80=99s main role is to measure and apprais=
e files
>    before they are used. This includes measuring critical system files du=
ring
>    early boot (e.g., init, init scripts, login binaries). If IMA were a m=
odule,
>    it would be loaded too late to cover those.
>=20
>  o TPM Dependency: IMA integrates tightly with the TPM to record measurem=
ents
>    into PCRs. The TPM must be initialized early (ideally before init_ima(=
)),
>    which aligns with IMA being built-in.
>=20
>  o Security Model: IMA is part of a Trusted Computing Base (TCB). Making =
it a
>    module would weaken the security model, as a potentially compromised s=
ystem
>    could delay or tamper with its initialization.
>=20
> IMA must be built-in to ensure it starts measuring from the earliest poss=
ible
> point in boot which inturn implies TPM must be initialised and ready to u=
se
> before IMA.
>=20
> To enable integration of tpm_event_log with the IMA subsystem, the TPM dr=
ivers
> (tpm_crb and tpm_crb_ffa) also needs to be built-in. However with FF-A dr=
iver
> also being initialised at device initcall level, it can lead to an
> initialization order issue where:
>  - crb_acpi_driver_init() may run before tpm_crb_ffa_driver()_init and ff=
a_init()
>  - As a result, probing the TPM device via CRB over FFA is deferred
>  - ima_init() (called as a late initcall) runs before deferred probe comp=
letes,
>    IMA fails to find the TPM and logs the below error:
>=20
>    |  ima: No TPM chip found, activating TPM-bypass!
>=20
> Eventually it fails to generate boot_aggregate with PCR values.
>=20
> Because of the above stated dependency, the ffa driver needs to initialis=
ed
> before tpm_crb_ffa module to ensure IMA finds the TPM successfully when
> present.
>=20
> Signed-off-by: Yeoreum Yun <yeoreum.yun@arm.com>

Thank you for the well written patch description.

> ---
>  drivers/firmware/arm_ffa/driver.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/drivers/firmware/arm_ffa/driver.c b/drivers/firmware/arm_ffa=
/driver.c
> index fe55613a8ea9..1a690b8186df 100644
> --- a/drivers/firmware/arm_ffa/driver.c
> +++ b/drivers/firmware/arm_ffa/driver.c
> @@ -2058,7 +2058,7 @@ static int __init ffa_init(void)
>  	kfree(drv_info);
>  	return ret;
>  }
> -module_init(ffa_init);
> +rootfs_initcall(ffa_init);

LGTM as the driver is always builtin.

Reviewed-by: Mimi Zohar <zohar@linux.ibm.com>

> =20
>  static void __exit ffa_exit(void)
>  {


