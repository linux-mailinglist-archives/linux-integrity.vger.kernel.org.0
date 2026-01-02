Return-Path: <linux-integrity+bounces-8158-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 118A4CEF113
	for <lists+linux-integrity@lfdr.de>; Fri, 02 Jan 2026 18:29:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id AB3943011769
	for <lists+linux-integrity@lfdr.de>; Fri,  2 Jan 2026 17:29:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 077EF2C11D4;
	Fri,  2 Jan 2026 17:29:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="SI44PWYk"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72BB72C15B4;
	Fri,  2 Jan 2026 17:28:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767374939; cv=none; b=R/GG9P91/Gm1wmwq/LMqPkWQWx0DUDR8CQstdYDbY0TFKGoHP3QsXD/EmeRgsLw3f7bAm+Zrj2eom60H4mOBDbceX+UAcbQrq3Peaevj0MnNRADjhflIw4+Ni2ew39w60p8J4eeYrQpxc0lGdNo1tQB4DRhjC3JesUU5l1atk90=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767374939; c=relaxed/simple;
	bh=nJtsfWVgOcyw0E2yQEkslbtzOMkCwFRXFuhgo5IbvSQ=;
	h=Message-ID:Subject:From:To:Cc:In-Reply-To:References:Content-Type:
	 Date:MIME-Version; b=fgoVXuJ6PoJLt4TdoJElbGTXJw07baVbBvODDTVzdrHdK8+RHz60QzRjoJul7lJ/xl4M7MzYsEGiLNhFp85kW1uDNW2yr54Gkbj+n0kdOWMYHKLnq3STonAUbh+2cvySSfQEjdeI9S1FhkVhcM9LG1prSWMxUswKb8DSfiOtTHU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=SI44PWYk; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 6020FNn7025758;
	Fri, 2 Jan 2026 17:28:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=nJtsfW
	VgOcyw0E2yQEkslbtzOMkCwFRXFuhgo5IbvSQ=; b=SI44PWYkBAofj1Yuyketiy
	AIiDrkp+HKdZwff40roht7U9E0HYkttTDdgcwNgQzyBORu/5janyERphcjdKqqCv
	KT8UqF5JDWQUtGss8TDAWPl7um3CwFfZFn8LlvDchgRBha1uNrlqjW1Isk0JFWhy
	cn9Zs3rewP4Xyquh+8ZkxDVRVhDx5bofjc5Vfg/8TGv1GQOXO/QtcPB6Evef3A90
	571sLloTGruurHT8Azi1TE6s9wVeeQ73GiC9EhP2cB4U2VC8E0i5Tn64G3Uwp7sS
	nMSBVIQs7KLelkAHSkWElngDhGTMo1+8Q2mDJhLQ6NRkuOy6p29ywYNg+9iI6lWQ
	==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4ba5vfdd85-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 02 Jan 2026 17:28:44 +0000 (GMT)
Received: from m0353725.ppops.net (m0353725.ppops.net [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 602HSibx004667;
	Fri, 2 Jan 2026 17:28:44 GMT
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4ba5vfdd83-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 02 Jan 2026 17:28:44 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 602Ed2L3025020;
	Fri, 2 Jan 2026 17:28:43 GMT
Received: from smtprelay02.dal12v.mail.ibm.com ([172.16.1.4])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4bau9kqem2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 02 Jan 2026 17:28:43 +0000
Received: from smtpav05.wdc07v.mail.ibm.com (smtpav05.wdc07v.mail.ibm.com [10.39.53.232])
	by smtprelay02.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 602HSfZs24445690
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 2 Jan 2026 17:28:42 GMT
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B92F658043;
	Fri,  2 Jan 2026 17:28:41 +0000 (GMT)
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 2405F58053;
	Fri,  2 Jan 2026 17:28:40 +0000 (GMT)
Received: from li-43857255-d5e6-4659-90f1-fc5cee4750ad.ibm.com (unknown [9.61.43.105])
	by smtpav05.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Fri,  2 Jan 2026 17:28:40 +0000 (GMT)
Message-ID: <46cb57e43f107e52a41c2a041fe693728af7fbef.camel@linux.ibm.com>
Subject: Re: [PATCH v2 2/6] powerpc/pseries: move the PLPKS config inside
 its own sysfs directory
From: Mimi Zohar <zohar@linux.ibm.com>
To: Srish Srinivasan <ssrish@linux.ibm.com>, linux-integrity@vger.kernel.org,
        keyrings@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Cc: maddy@linux.ibm.com, mpe@ellerman.id.au, npiggin@gmail.com,
        christophe.leroy@csgroup.eu, James.Bottomley@HansenPartnership.com,
        jarkko@kernel.org, nayna@linux.ibm.com, rnsastry@linux.ibm.com,
        linux-kernel@vger.kernel.org, linux-security-module@vger.kernel.org
In-Reply-To: <20251217172505.112398-3-ssrish@linux.ibm.com>
References: <20251217172505.112398-1-ssrish@linux.ibm.com>
	 <20251217172505.112398-3-ssrish@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Date: Fri, 02 Jan 2026 12:28:39 -0500
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Evolution 3.54.3 (3.54.3-2.fc41) 
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=a9k9NESF c=1 sm=1 tr=0 ts=6958004c cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=IkcTkHD0fZMA:10 a=vUbySO9Y5rIA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=VnNF1IyMAAAA:8 a=24atm0IDbaraCodkIm4A:9 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: FEKPQfspruN-x73DWrXe6w-wdVa52VhF
X-Proofpoint-ORIG-GUID: eATCzki2Sl085dgCOS5EL1fFHY622w99
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTAyMDE1NCBTYWx0ZWRfX7lO7hpAe1i7g
 hoCUSG/O17pSMTZGS2Grsj8wdg0xmNrzBIlXXj0v59nkcWJmkGCRrCtojWFAyRyyHjSPFa5Ey4d
 EQwpOWUHbsyL5BYMoBHmqzBoFy6q7kyDsSZheYns1V28m67ZV7OMI3IKfVnFEpCWXShlVkLT9sb
 2AexrBSNVz1cb8xVdun86vPRRbhrzWhg+VNR+uaKWHuDbbUFUZoi3kiJETmA1WdHqmqAP/WKcaB
 5iRqS08HyH6fqKdpC5hRb5n25vMiAntXV3XYUnedAzlo/41RYocFvkJ4YDEZRY+Zijj6RoqnXAP
 gWZm59VFF+qLHJ2toSwgO3T3Cv5HCGUvCNUrH3zjxWs4y/lCTiajfmrc41Xq4jg+5FM/isef2p0
 Jl9UXUWgzrlibxksu2kfFA6BkkS2myWNLnQPfN8LCUuDfNt2s8GDaoI9FeTHoOUIXs0UMAHhj/f
 qJzGDohZH4aJ+MDKcBw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-02_02,2025-12-31_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 bulkscore=0 impostorscore=0 clxscore=1015 adultscore=0
 priorityscore=1501 phishscore=0 malwarescore=0 lowpriorityscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2512120000 definitions=main-2601020154

On Wed, 2025-12-17 at 22:55 +0530, Srish Srinivasan wrote:
> The /sys/firmware/secvar/config directory represents Power LPAR Platform
> KeyStore (PLPKS) configuration properties such as max_object_size, signed=
_
> update_algorithms, supported_policies, total_size, used_space, and versio=
n.
> These attributes describe the PLPKS, and not the secure boot variables
> (secvars).
>=20
> Create /sys/firmware/plpks directory and move the PLPKS config inside thi=
s
> directory. For backwards compatibility, create a soft link from the secva=
r
> sysfs directory to this config and emit a warning stating that the older
> sysfs path has been deprecated. Separate out the plpks specific
> documentation from secvar.
>=20
> Signed-off-by: Srish Srinivasan <ssrish@linux.ibm.com>

LGTM.

Reviewed-by: Mimi Zohar <zohar@linux.ibm.com>

