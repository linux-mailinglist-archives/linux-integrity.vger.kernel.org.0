Return-Path: <linux-integrity+bounces-5980-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5CDD1A9580D
	for <lists+linux-integrity@lfdr.de>; Mon, 21 Apr 2025 23:35:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 88BC4167551
	for <lists+linux-integrity@lfdr.de>; Mon, 21 Apr 2025 21:35:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72ED7217F5C;
	Mon, 21 Apr 2025 21:35:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="BBOZfSr3"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B453F1EF394;
	Mon, 21 Apr 2025 21:35:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745271346; cv=none; b=BS9t3VoJArdJZBAQKS+GJFaMK78hrrE0ZwA6uXsq815GIOSI+WJU/YyhzELRY2QW8bxqA/NOVXkbttmMWxe2lhVbyUctbICA8MaBoQyYgkYS1TT1aj7aJb8LLFfPbytFMYHmOXfylcpmCYJdqCoQOUJW+mKIXkPbOsGGDyb/ON4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745271346; c=relaxed/simple;
	bh=IQYal5UE3ClVvN1lCGB7HKtDymzeIsGFwRwCqGsG/T8=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=kjzZ2DA2pKqpngxirPtjMXjWA+xp1w09haRaJfJ2pnsj33ETIsASGtP79233i7EZYz+3CB3tJ8dFtEIztvojJoBY1pzYhmZieIoe3e8b99ubKIe4bhNkpuw8k9thqFwIr2YTV9/+DKBM7SRzujWa53ri2lXyHR06jxzsTwRdGmY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=BBOZfSr3; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53LL3UF5012850;
	Mon, 21 Apr 2025 21:35:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=I8hwgS
	KySN4oDCnUgrZWJ6YPpS5dJqH5If6DsGLP0L0=; b=BBOZfSr3n0F1o3Taj88rDU
	WUyPRAqj9kD8PDsMsxc0n380+3b4Ed95HJTASegikhJDyGg83VVzG4KccbhJD+/e
	rRi5i4bB8U6N4PoqHpcbpUtUAy5k5VImNTT4jfAvXuq4RR/rvOQf4O395k4WAXJc
	nHGylVKOGctUS9ktx+XLWTp5QtHhSObLF+ONCYazP0xV4TD00+n0B6sDgqdApqhU
	TW8Il8IL/1bWbM2eRZUOlcF4FVf2GAAV9gCuv2goNKz/zK13ZfQ144ka9rE8jVSX
	Dd2MiNG9tdxExbZZ2Y8FFYXuSEwhe8nUO3yHM91WnLN4Bd3BoGg1eowDFTjz8dzg
	==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 465wkkg2yv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 21 Apr 2025 21:35:15 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 53LJsn51032537;
	Mon, 21 Apr 2025 21:35:14 GMT
Received: from smtprelay02.wdc07v.mail.ibm.com ([172.16.1.69])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 464phyg708-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 21 Apr 2025 21:35:14 +0000
Received: from smtpav06.wdc07v.mail.ibm.com (smtpav06.wdc07v.mail.ibm.com [10.39.53.233])
	by smtprelay02.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 53LLZEnR32047824
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 21 Apr 2025 21:35:14 GMT
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E6DE45803F;
	Mon, 21 Apr 2025 21:35:13 +0000 (GMT)
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 2312158055;
	Mon, 21 Apr 2025 21:35:12 +0000 (GMT)
Received: from li-43857255-d5e6-4659-90f1-fc5cee4750ad.ibm.com (unknown [9.61.51.165])
	by smtpav06.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 21 Apr 2025 21:35:12 +0000 (GMT)
Message-ID: <6c3aca6815edf25828bad6f0b4587a040ada03c5.camel@linux.ibm.com>
Subject: Re: [PATCH v12 3/9] kexec: define functions to map and unmap
 segments
From: Mimi Zohar <zohar@linux.ibm.com>
To: steven chen <chenste@linux.microsoft.com>, Baoquan He <bhe@redhat.com>
Cc: stefanb@linux.ibm.com, roberto.sassu@huaweicloud.com,
        roberto.sassu@huawei.com, eric.snowberg@oracle.com,
        ebiederm@xmission.com, paul@paul-moore.com, code@tyhicks.com,
        bauermann@kolabnow.com, linux-integrity@vger.kernel.org,
        kexec@lists.infradead.org, linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, madvenka@linux.microsoft.com,
        nramas@linux.microsoft.com, James.Bottomley@hansenpartnership.com,
        vgoyal@redhat.com, dyoung@redhat.com
Date: Mon, 21 Apr 2025 17:35:11 -0400
In-Reply-To: <a9e3713f-4edf-479c-8be1-fe5b3dc22866@linux.microsoft.com>
References: <20250416021028.1403-1-chenste@linux.microsoft.com>
	 <20250416021028.1403-4-chenste@linux.microsoft.com>
	 <aAHW4O9qAKzaoa+O@MiWiFi-R3L-srv>
	 <dcde124baec01318e661f5430ce8a008a6d196c0.camel@linux.ibm.com>
	 <ef18ae186cd17431b9ff6b8a443b63fd6fb78b98.camel@linux.ibm.com>
	 <a9e3713f-4edf-479c-8be1-fe5b3dc22866@linux.microsoft.com>
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
X-Authority-Analysis: v=2.4 cv=DekXqutW c=1 sm=1 tr=0 ts=6806ba13 cx=c_pps a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17 a=IkcTkHD0fZMA:10 a=XR8D0OoHHMoA:10 a=VwQbUJbxAAAA:8 a=bLk-5xynAAAA:8 a=yMhMjlubAAAA:8 a=PtDNVHqPAAAA:8 a=20KFwNOVAAAA:8
 a=Scrp5zbnQvEsE254UrAA:9 a=QEXdDO2ut3YA:10 a=zSyb8xVVt2t83sZkrLMb:22 a=BpimnaHY1jUKGyF_4-AF:22
X-Proofpoint-ORIG-GUID: KnR4bJ9sLsQhWnMkD4xIv9UvzuVn2yjL
X-Proofpoint-GUID: KnR4bJ9sLsQhWnMkD4xIv9UvzuVn2yjL
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-21_10,2025-04-21_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 malwarescore=0
 adultscore=0 mlxscore=0 phishscore=0 priorityscore=1501 spamscore=0
 mlxlogscore=999 impostorscore=0 bulkscore=0 lowpriorityscore=0
 suspectscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2502280000
 definitions=main-2504210169

On Mon, 2025-04-21 at 13:40 -0700, steven chen wrote:
> On 4/21/2025 7:18 AM, Mimi Zohar wrote:
> > On Mon, 2025-04-21 at 09:51 -0400, Mimi Zohar wrote:
> > > On Fri, 2025-04-18 at 12:36 +0800, Baoquan He wrote:
> > > > On 04/15/25 at 07:10pm, steven chen wrote:
> > > > > From: Steven Chen <chenste@linux.microsoft.com>
> > > >   ^^^^^^
> > > As James Bottomley previously explained[1], if you haven't made any c=
hanges to
> > > Tushar's patch, then the very first line of the patch description wou=
ld be
> > > "From: Tushar Sugandhi <tusharsu@linux.microsoft.com>" followed by a =
blank line.
> > > If there is a minor change, you would add "<your email address>: expl=
anation".
> > > For example:
> > >=20
> > > Steven Chen <chenste@linux.microsoft.com>: modified patch description
> > To clarify: This line would be included below with your Signed-off-by t=
ag.
> >=20
> > > [1]
> > > https://lore.kernel.org/lkml/58e70121aaee33679ac295847197c1e5511b2a81=
.camel@HansenPartnership.com/
> > >=20
> > > > > Implement kimage_map_segment() to enable IMA to map the measureme=
nt log
> > > > > list to the kimage structure during the kexec 'load' stage. This =
function
> > > > > gathers the source pages within the specified address range, and =
maps them
> > > > > to a contiguous virtual address range.
> > > > >=20
> > > > > This is a preparation for later usage.
> > > > >=20
> > > > > Implement kimage_unmap_segment() for unmapping segments using vun=
map().
> > > > >=20
> > > > > From: Tushar Sugandhi <tusharsu@linux.microsoft.com>
> > > >    ^^^^^^
> > > Neither "Author:" nor "From:" belong here.  Please remove.
> > >=20
> > > > > Signed-off-by: Tushar Sugandhi <tusharsu@linux.microsoft.com>
> > > >    ^^^^^^^
> > > Having Tushar's "Signed-off-by" tag and yours below indicate that you=
 modified
> > > the original author's patch.
> > To clarify: "Just" having Tushar's "Signed-off-by" tag and yours below =
indicate
> > that you modified the original author's patch.
>=20
> Hi Mimi,
>=20
> I will update it in next version.

Sigh, after reviewing your discussion with Baoquan, I'm not sure whether my
comment this morning added more confusion.

Option 1: Include a single "From:" line at the very top to change the autho=
r
from yourself to someone else.  The following from line would make Tushar t=
he
patch author:  From: Tushar Sugandhi <tusharsu@linux.microsoft.com>

In addition, any minor changes you made should be added before your Signed-=
off-
by tag.  For example: Steven Chen <chenste@linux.microsoft.com>: modified p=
atch
description

Option 2: As mentioned previously and now discussed with Baoquan, adding "C=
o-
developed-by:"

>=20
> Just wandering are you done reviewing or still need more time?

Yes, I just finished reviewing/testing.  The patch descriptions are looking=
 much
better.  As Baoquan reminded you, please remember to update the "ima: defin=
e and
call ima_alloc_kexec_file_buf()" patch description.

thanks,

Mimi

>=20
> > > > > Cc: Eric Biederman <ebiederm@xmission.com>
> > > > > Cc: Baoquan He <bhe@redhat.com>
> > > > > Cc: Vivek Goyal <vgoyal@redhat.com>
> > > > > Cc: Dave Young <dyoung@redhat.com>
> > > > > Signed-off-by: steven chen <chenste@linux.microsoft.com>
> > > >    ^^^^^
> > > >=20
> > > > The signing on this patch is a little confusing. I can't see who is=
 the
> > > > real author, who is the co-author, between you and Tushar. You may =
need
> > > > to refer to Documentation/process/5.Posting.rst to make that clear.
> > > >=20
> > > > > Acked-by: Baoquan He <bhe@redhat.com>

