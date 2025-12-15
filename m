Return-Path: <linux-integrity+bounces-7989-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 99253CBE7E3
	for <lists+linux-integrity@lfdr.de>; Mon, 15 Dec 2025 16:06:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 0F9363001180
	for <lists+linux-integrity@lfdr.de>; Mon, 15 Dec 2025 15:06:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C62730FF25;
	Mon, 15 Dec 2025 14:02:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="UJ85NnV8"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88ADA30FF3A;
	Mon, 15 Dec 2025 14:02:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765807358; cv=none; b=ROxyCBWLYZeTPXZ9+yOgrJfBbOxOhgLRut6nXXfkHC5aMW3wjXo/A1rQNaSmxziVyJnHGT0SqXVR2bS/wv+uu6HuKK4gA9+5y2txf82z1KH89TzzECaIeP/Xj27q7nOXBvezHUFdr7TU9I63YVtl3WCsdsLe2+9Zegv4Q0MmTBU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765807358; c=relaxed/simple;
	bh=CNk3Gny6Eq3dZRKg7BGu1UbnDEcS8g5xr5JBzKALF8g=;
	h=Message-ID:Subject:From:To:Cc:In-Reply-To:References:Content-Type:
	 Date:MIME-Version; b=vGctnuB/HgTVUNMYKYrV6sIdkGDNgpUZuMdEgc/s9ErDu4Z+HPU4G4S1FyT+toI9/pMbjnVOY81A9CH9mNZtI1KY+7KaDm11OtUjd5FPFgPd7bEEWuUNcka3dGqfcABUkghsU5iMP1S60YFWjMCWdfYUw3Q5Sau4CcSsfevKkSM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=UJ85NnV8; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5BF74uKe021469;
	Mon, 15 Dec 2025 14:02:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=BZZ8gU
	lX9jobhrDx9zOK3xqdapuyPIterguTVyWFnmc=; b=UJ85NnV8BxA6m/NzsC1T/C
	SB+xvMuD9kbKXibV4JBG1DgRU1YqOEDD6OYT80n4KGZ0z+0/kMtgnz1Tk1IwJxRw
	vN0PCZBVBvuHybSiWbDXr1wk7zrQl5TbuBInGaV8cTyhTvEAejPbP0ZWUytjh5uu
	P1ukByJnscn6joymUkGMao1xVkvmEnf06c7snvKR3cPPk9xXp3aJlh50pAARCKuU
	c3jBcwO5VIQQsr6jy02Bhb1UIEkSfob6a24c3nvw4WoQoQBFrBlehTrhuf0KUpc2
	plNkQ0TFnNMeycavrvP38yYnVGZfBSTaE5M5sHL6X/qFjJbHDj5xnI2Sj255VBbw
	==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4b0wjpsw67-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 15 Dec 2025 14:02:12 +0000 (GMT)
Received: from m0356516.ppops.net (m0356516.ppops.net [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 5BFDvDMK007741;
	Mon, 15 Dec 2025 14:02:12 GMT
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4b0wjpsw5y-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 15 Dec 2025 14:02:12 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 5BFB1Biu026761;
	Mon, 15 Dec 2025 14:02:11 GMT
Received: from smtprelay02.dal12v.mail.ibm.com ([172.16.1.4])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4b1jfs6ygr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 15 Dec 2025 14:02:11 +0000
Received: from smtpav06.dal12v.mail.ibm.com (smtpav06.dal12v.mail.ibm.com [10.241.53.105])
	by smtprelay02.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 5BFE2A4r29295354
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 15 Dec 2025 14:02:10 GMT
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B788858055;
	Mon, 15 Dec 2025 14:02:10 +0000 (GMT)
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D131A58043;
	Mon, 15 Dec 2025 14:02:09 +0000 (GMT)
Received: from li-43857255-d5e6-4659-90f1-fc5cee4750ad.ibm.com (unknown [9.61.148.132])
	by smtpav06.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 15 Dec 2025 14:02:09 +0000 (GMT)
Message-ID: <8075a38abe5f7256ae8ce70359f78822f277ccfa.camel@linux.ibm.com>
Subject: Re: [PATCH V2 1/1] IMA event log trimming
From: Mimi Zohar <zohar@linux.ibm.com>
To: steven chen <chenste@linux.microsoft.com>, linux-integrity@vger.kernel.org
Cc: roberto.sassu@huawei.com, dmitry.kasatkin@gmail.com,
        eric.snowberg@oracle.com, corbet@lwn.net, serge@hallyn.com,
        paul@paul-moore.com, jmorris@namei.org,
        linux-security-module@vger.kernel.org, anirudhve@linux.microsoft.com,
        gregorylumen@linux.microsoft.com, nramas@linux.microsoft.com,
        sushring@linux.microsoft.com, linux-doc@vger.kernel.org
In-Reply-To: <20251210235314.3341-2-chenste@linux.microsoft.com>
References: <20251210235314.3341-1-chenste@linux.microsoft.com>
	 <20251210235314.3341-2-chenste@linux.microsoft.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Date: Mon, 15 Dec 2025 09:02:09 -0500
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Evolution 3.54.3 (3.54.3-2.fc41) 
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjEzMDAwMSBTYWx0ZWRfX0yV7Mf5blC3w
 AaO1LQKAV2UYiiBmHcseJKAGO3F/+6KIyRmoZD2DQ2KJk+q7DUc7eEwKfsgDytucCUFYUvi57Ey
 d0o29cMG7s9+yWxp59xyVOM4pVwhBR7/Zv6xU+7UQP8tmlIrRIWPjhtaLsz3rtfNHl09K+S/w9D
 P1nz6lJsBQ8sYX7GPqHx4ayh9rjIEYIW4U6fDKkiL4MdPHKqwdf+sK7f70RZqd4y3cQVgp3Xz0Z
 4zgVFYNPZwIIr2U79PAU/1g2tLeldGA4UJROeqAXDG6iBs8b9+O2XcNlRKxTa8hBe8jPn34h/LS
 l/huY3z1qFJd406XLv5EW7TFFYdrz/7lxWdN5hWCVXReFngE4WXY60Rs9XZtWrGaIekxVKx8j/e
 JnxqTf5elVfwTsq+hR6q62poVDYfrA==
X-Proofpoint-GUID: kz-flyVU7aY1Qe3_3Kbcd_XJMYHE1aej
X-Proofpoint-ORIG-GUID: IvWNjI-eD8XLKzsdRPq7o10CmrEeb0Zp
X-Authority-Analysis: v=2.4 cv=Kq5AGGWN c=1 sm=1 tr=0 ts=694014e4 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=IkcTkHD0fZMA:10 a=wP3pNCr1ah4A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=yMhMjlubAAAA:8 a=qxrvh61xDQAC6cKOOUwA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-15_02,2025-12-15_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 malwarescore=0 impostorscore=0 clxscore=1011 spamscore=0
 priorityscore=1501 lowpriorityscore=0 bulkscore=0 phishscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510240000 definitions=main-2512130001

Hi Steven,

The main difference between this patch and Roberto's version is the length =
of
time needed for locking the measurement list, which prevents new entries fr=
om
being appended to the measurement list.  In Roberto's version, the list hea=
d is
moved quickly and the lock released.  Measuring the total amount of time ne=
eded
to trim the measurement list ignores the benefit of his version. I plan on
reviewing both this version and his (hopefully today).

There are a number of other things missing from this patch, which I'll enum=
erate
when I review it.

On Wed, 2025-12-10 at 15:53 -0800, steven chen wrote:
> This patch is for trimming N entries of the IMA event logs. It will also
> cleaning the hash table if ima_flush_htable is set.

Please refer to "Describe your changes in imperative mood" in the "Describe=
 your
changes" section of Documentation/process/submitting-patches.rst.

>=20
> It provides a userspace interface ima_trim_log that can be used to input
> number N to let kernel to trim N entries of IMA event logs. When read
> this interface, it returns number of entries trimmed last time.
>=20
> Signed-off-by: steven chen <chenste@linux.microsoft.com>

--=20
thanks,

Mimi


