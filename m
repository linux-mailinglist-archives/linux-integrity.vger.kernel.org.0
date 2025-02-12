Return-Path: <linux-integrity+bounces-4800-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CF54A3267D
	for <lists+linux-integrity@lfdr.de>; Wed, 12 Feb 2025 14:04:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BA7DA166271
	for <lists+linux-integrity@lfdr.de>; Wed, 12 Feb 2025 13:03:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B3DC20E030;
	Wed, 12 Feb 2025 13:03:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="JexrGaX+"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CDFA20E020;
	Wed, 12 Feb 2025 13:03:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739365429; cv=none; b=oXSx7OEOLCB5TaqqJgVkLpI68312LMYJQIk7d4/gtDIlVsn8on4cTJk8nfNY9vBZ2f5uIQ2F89UWp7bZ9/+ssIiy+aoV+oAUFeniRAWhUNLtVTZ2h7Y1K6woSQx2PrBWmBhBc4Swgj08IxDUuD1fbZRrcxpCrNLorVuOAC1oLeM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739365429; c=relaxed/simple;
	bh=CH67KHtOFoFk6tLjTkF6ElKAoDA4yM8zT/sD1gHjNMs=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=TBcUj8/x+zeAKjyIwvrksgt60bQHBUEUoS5mnStbqn7JHUHdoU31ZcVfUt6HrACm0298zEHVKUchAOjDxm5hbWihxbeaCHWVCMADzT379SAf0gm9pgWMhd9ThpNf7Wrj2J/bRR52VVxEZVemcf9mUImZ/qTHMblixpgbHHhn1x4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=JexrGaX+; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51CAxSbX013670;
	Wed, 12 Feb 2025 13:03:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=krHBiN
	5fDn9iL+VMLKCmrS+HPrhLWm4BXzABiQLQpLw=; b=JexrGaX++PInzP3zdCZjD3
	KbkFtDaJsk3RVitxji+enBcU3Rt1JPEFclfW7tGURxY+sQK4uiv8/rP6fE5udfuD
	etkhmGGIaCJmOgGPosuxlqotL8lgDmvzh/6e1qiXkRNnWvh9MCwprerHMA+q/cYm
	apU79lmHhkus3D6Eb0vJ36I3RFGcwhZgJdnv7k1gj0sK3smFjjBkRx9wRdd7Bpe0
	1eE2bSH+LxoDCH1q9U0sVX5bsqtWam7aTMCLgCMC9+gJiT04UioUvfWgM+/XoihA
	0ivcaVGGv9ZM8kEXCy/Vnkjlyx+VsMe0pyMV+guTWlvFM6u0u7jpgsJtZmADWCVA
	==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 44rjfytvs8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 12 Feb 2025 13:03:20 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 51CCZBb4028197;
	Wed, 12 Feb 2025 13:03:19 GMT
Received: from smtprelay01.wdc07v.mail.ibm.com ([172.16.1.68])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 44phyygsnt-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 12 Feb 2025 13:03:19 +0000
Received: from smtpav06.wdc07v.mail.ibm.com (smtpav06.wdc07v.mail.ibm.com [10.39.53.233])
	by smtprelay01.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 51CD3JrI27132602
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 12 Feb 2025 13:03:19 GMT
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 1505958077;
	Wed, 12 Feb 2025 13:03:19 +0000 (GMT)
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A32E25806F;
	Wed, 12 Feb 2025 13:03:17 +0000 (GMT)
Received: from li-43857255-d5e6-4659-90f1-fc5cee4750ad.ibm.com (unknown [9.61.169.88])
	by smtpav06.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 12 Feb 2025 13:03:17 +0000 (GMT)
Message-ID: <b7dd78f21a9fa9dc3b6f90eae2668cfe5c7670c7.camel@linux.ibm.com>
Subject: Re: [PATCH v7 2/7] kexec: define functions to map and unmap segments
From: Mimi Zohar <zohar@linux.ibm.com>
To: steven chen <chenste@linux.microsoft.com>, stefanb@linux.ibm.com,
        roberto.sassu@huaweicloud.com, roberto.sassu@huawei.com,
        eric.snowberg@oracle.com, ebiederm@xmission.com, paul@paul-moore.com,
        code@tyhicks.com, bauermann@kolabnow.com,
        linux-integrity@vger.kernel.org, kexec@lists.infradead.org,
        linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: madvenka@linux.microsoft.com, nramas@linux.microsoft.com,
        James.Bottomley@HansenPartnership.com
Date: Wed, 12 Feb 2025 08:03:17 -0500
In-Reply-To: <47565966-c735-4758-80a5-523fd93adc72@linux.microsoft.com>
References: <20250203232033.64123-1-chenste@linux.microsoft.com>
	 <20250203232033.64123-3-chenste@linux.microsoft.com>
	 <6fd5510827a2ebb91aee8c72432e248e967fa5be.camel@linux.ibm.com>
	 <47565966-c735-4758-80a5-523fd93adc72@linux.microsoft.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.4 (3.52.4-2.fc40) 
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: Wb7pe2c-W48JJx9ojXknjIakieQe4wt2
X-Proofpoint-ORIG-GUID: Wb7pe2c-W48JJx9ojXknjIakieQe4wt2
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-12_04,2025-02-11_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 impostorscore=0
 mlxscore=0 suspectscore=0 adultscore=0 clxscore=1015 mlxlogscore=999
 lowpriorityscore=0 priorityscore=1501 phishscore=0 malwarescore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2501170000 definitions=main-2502120101

On Mon, 2025-02-10 at 09:06 -0800, steven chen wrote:
> On 2/7/2025 11:15 AM, Mimi Zohar wrote:
> > Hi Steven,
> >=20
> > On Mon, 2025-02-03 at 15:20 -0800, steven chen wrote:
> > > Currently, the mechanism to map and unmap segments to the kimage
> > > structure is not available to the subsystems outside of kexec.=C2=A0 =
This
> > > functionality is needed when IMA is allocating the memory segments
> > > during kexec 'load' operation.=C2=A0 Implement functions to map and u=
nmap
> > > segments to kimage.
> > >=20
> > > Implement kimage_map_segment() to enable mapping of IMA buffer source
> > > pages to the kimage structure post kexec 'load'.=C2=A0 This function,
> > > accepting a kimage pointer, an address, and a size, will gather the
> > > source pages within the specified address range, create an array of p=
age
> > > pointers, and map these to a contiguous virtual address range.=C2=A0 =
The
> > > function returns the start of this range if successful, or NULL if
> > > unsuccessful.
> > >=20
> > > Implement kimage_unmap_segment() for unmapping segments
> > > using vunmap().
> > >=20
> > > From: Tushar Sugandhi <tusharsu@linux.microsoft.com>
> > > Author: Tushar Sugandhi <tusharsu@linux.microsoft.com>
> > > Reviewed-by: Stefan Berger <stefanb@linux.ibm.com>
> > > Reviewed-by: Mimi Zohar <zohar@linux.ibm.com>
> > I don't recall previously adding my "Reviewed-by" tag.
> >=20
> > Eric, I'd appreciate your reviewing this and the subsequent patch "[PAT=
CH v7 3/7]
> > ima: kexec: skip IMA segment validation after kexec soft reboot" in par=
ticular.
> Hi Eric, Could you help to review this patch as Mimi mentioned? Thanks!
> >=20
> > > Signed-off-by: Tushar Sugandhi <tusharsu@linux.microsoft.com>

Steven, since these patches impact kdump, before re-posting the patch set, =
please
include the following tags before your Signed-off-by tag on the kexec patch=
es.

Cc: Eric Biederman <ebiederm@xmission.com>
Cc: Baoquan He <bhe@redhat.com>                                            =
=20
Cc: Vivek Goyal <vgoyal@redhat.com>                                        =
=20
Cc: Dave Young <dyoung@redhat.com>  =20

> > > Signed-off-by: steven chen <chenste@linux.microsoft.com>

thanks,

Mimi



