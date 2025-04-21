Return-Path: <linux-integrity+bounces-5952-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B30BA95298
	for <lists+linux-integrity@lfdr.de>; Mon, 21 Apr 2025 16:19:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A2E41168A2A
	for <lists+linux-integrity@lfdr.de>; Mon, 21 Apr 2025 14:19:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F38C13E02D;
	Mon, 21 Apr 2025 14:18:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="O80hEzTW"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52CCD38DE9;
	Mon, 21 Apr 2025 14:18:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745245137; cv=none; b=OGkxlDv9K8r4dhQVDDzzM7sjxMKJY+I6X8yu7MvzjkW7aRW2t0hW7XL+IRg+eLZqisKojUpW05nGiuxc0e2h0Ojsfn2YsblSxKqQfez5R5z8Z1ci7GdTjBkht8ny0tBX2CXDiuB6fahFGEF3OttpyxIis4t1bjPkZ3Q9rJHJ6GE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745245137; c=relaxed/simple;
	bh=uqPZ8pSWA+KC9OH2B0rYCnAcm3U6jLzNWKwsq1ZwBLA=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=XPV/twVOwsMUY0wkrHFnYXFtIqFl+PlWWhJR94oKTiWC50wF0jQYY6oTPC5SazPq3Mh7CLAPO6Y8m0TbJZ6JFGyVL8eG7jfSjSj/CUVVV/Ri72mGKZsocNRUkqRLXkIODE5Jro+GdCO1S5B7PMyqmUYIx6+EBw+QFVGybgm7AZM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=O80hEzTW; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53LA3wqL007572;
	Mon, 21 Apr 2025 14:18:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=FVXVAV
	Bj9dt951RNAVxr15KnbP6+CzPRiqjlfAwfQ0U=; b=O80hEzTWZD+OojTOtaDHFb
	kmnfSXPv7ucP6tFzwx5wt1hukvsPqkVjQH4F19oYqZBPsWJG7+lr9LzxzmZ/W22b
	Jph91gyn4LfxFVoOFnp/h9fYYMVA7yNgs8hlN/usdM9mtYPzwTgaB133o0edN98e
	CiKdPw4FA5xz6GoLtrbSo3dIHAc/18n9RfJDREM1PFFsZzKMNcNnFOQuy+JUuFNp
	NQ/KR/vnCaK40smO2DUl9mkAgVdn5BRW+MkRKc41MxhiPJwsR9J7jpIxb6zFVKxu
	uSCY2m/fbaBjKAakvfWPmMW2Tn69qTk09JOZYI1OxP0SP/7TXBJ7+M+rSA/puTEA
	==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 465kxj8ybc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 21 Apr 2025 14:18:26 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 53LAl6iR032526;
	Mon, 21 Apr 2025 14:18:24 GMT
Received: from smtprelay06.dal12v.mail.ibm.com ([172.16.1.8])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 464phyetsk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 21 Apr 2025 14:18:24 +0000
Received: from smtpav01.wdc07v.mail.ibm.com (smtpav01.wdc07v.mail.ibm.com [10.39.53.228])
	by smtprelay06.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 53LEINNN17891846
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 21 Apr 2025 14:18:24 GMT
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id CEFF258063;
	Mon, 21 Apr 2025 14:18:23 +0000 (GMT)
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 127A358059;
	Mon, 21 Apr 2025 14:18:22 +0000 (GMT)
Received: from li-43857255-d5e6-4659-90f1-fc5cee4750ad.ibm.com (unknown [9.61.21.104])
	by smtpav01.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 21 Apr 2025 14:18:21 +0000 (GMT)
Message-ID: <ef18ae186cd17431b9ff6b8a443b63fd6fb78b98.camel@linux.ibm.com>
Subject: Re: [PATCH v12 3/9] kexec: define functions to map and unmap
 segments
From: Mimi Zohar <zohar@linux.ibm.com>
To: Baoquan He <bhe@redhat.com>, steven chen <chenste@linux.microsoft.com>
Cc: stefanb@linux.ibm.com, roberto.sassu@huaweicloud.com,
        roberto.sassu@huawei.com, eric.snowberg@oracle.com,
        ebiederm@xmission.com, paul@paul-moore.com, code@tyhicks.com,
        bauermann@kolabnow.com, linux-integrity@vger.kernel.org,
        kexec@lists.infradead.org, linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, madvenka@linux.microsoft.com,
        nramas@linux.microsoft.com, James.Bottomley@hansenpartnership.com,
        vgoyal@redhat.com, dyoung@redhat.com
Date: Mon, 21 Apr 2025 10:18:21 -0400
In-Reply-To: <dcde124baec01318e661f5430ce8a008a6d196c0.camel@linux.ibm.com>
References: <20250416021028.1403-1-chenste@linux.microsoft.com>
	 <20250416021028.1403-4-chenste@linux.microsoft.com>
	 <aAHW4O9qAKzaoa+O@MiWiFi-R3L-srv>
	 <dcde124baec01318e661f5430ce8a008a6d196c0.camel@linux.ibm.com>
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
X-Proofpoint-GUID: cikbJN6PF9hmHh0Nsj6AtPTZQGoZiaoI
X-Proofpoint-ORIG-GUID: cikbJN6PF9hmHh0Nsj6AtPTZQGoZiaoI
X-Authority-Analysis: v=2.4 cv=HLDDFptv c=1 sm=1 tr=0 ts=680653b2 cx=c_pps a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17 a=IkcTkHD0fZMA:10 a=XR8D0OoHHMoA:10 a=VwQbUJbxAAAA:8 a=bLk-5xynAAAA:8 a=yMhMjlubAAAA:8 a=PtDNVHqPAAAA:8 a=20KFwNOVAAAA:8
 a=As6bdjLyCJmV0PnI7e4A:9 a=QEXdDO2ut3YA:10 a=zSyb8xVVt2t83sZkrLMb:22 a=BpimnaHY1jUKGyF_4-AF:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-21_06,2025-04-21_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 suspectscore=0
 mlxlogscore=999 mlxscore=0 lowpriorityscore=0 clxscore=1015
 impostorscore=0 adultscore=0 spamscore=0 phishscore=0 bulkscore=0
 priorityscore=1501 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2502280000
 definitions=main-2504210109

On Mon, 2025-04-21 at 09:51 -0400, Mimi Zohar wrote:
> On Fri, 2025-04-18 at 12:36 +0800, Baoquan He wrote:
> > On 04/15/25 at 07:10pm, steven chen wrote:
> > > From: Steven Chen <chenste@linux.microsoft.com>
> >  ^^^^^^
>=20
> As James Bottomley previously explained[1], if you haven't made any chang=
es to
> Tushar's patch, then the very first line of the patch description would b=
e
> "From: Tushar Sugandhi <tusharsu@linux.microsoft.com>" followed by a blan=
k line.
> If there is a minor change, you would add "<your email address>: explanat=
ion".
> For example:
>=20
> Steven Chen <chenste@linux.microsoft.com>: modified patch description

To clarify: This line would be included below with your Signed-off-by tag.

>=20
> [1]
> https://lore.kernel.org/lkml/58e70121aaee33679ac295847197c1e5511b2a81.cam=
el@HansenPartnership.com/
>=20
> > >=20
> > > Implement kimage_map_segment() to enable IMA to map the measurement l=
og=20
> > > list to the kimage structure during the kexec 'load' stage. This func=
tion
> > > gathers the source pages within the specified address range, and maps=
 them
> > > to a contiguous virtual address range.
> > >=20
> > > This is a preparation for later usage.
> > >=20
> > > Implement kimage_unmap_segment() for unmapping segments using vunmap(=
).
> > >=20
> > > From: Tushar Sugandhi <tusharsu@linux.microsoft.com>
> >   ^^^^^^
>=20
> Neither "Author:" nor "From:" belong here.  Please remove.
>=20
> > > Signed-off-by: Tushar Sugandhi <tusharsu@linux.microsoft.com>
> >   ^^^^^^^
>=20
> Having Tushar's "Signed-off-by" tag and yours below indicate that you mod=
ified
> the original author's patch.

To clarify: "Just" having Tushar's "Signed-off-by" tag and yours below indi=
cate
that you modified the original author's patch.

>=20
> > > Cc: Eric Biederman <ebiederm@xmission.com>
> > > Cc: Baoquan He <bhe@redhat.com>=20
> > > Cc: Vivek Goyal <vgoyal@redhat.com>
> > > Cc: Dave Young <dyoung@redhat.com>
> > > Signed-off-by: steven chen <chenste@linux.microsoft.com>
> >   ^^^^^
> >=20
> > The signing on this patch is a little confusing. I can't see who is the
> > real author, who is the co-author, between you and Tushar. You may need
> > to refer to Documentation/process/5.Posting.rst to make that clear.
> >=20
> > > Acked-by: Baoquan He <bhe@redhat.com>

