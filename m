Return-Path: <linux-integrity+bounces-6364-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 50E20ACE717
	for <lists+linux-integrity@lfdr.de>; Thu,  5 Jun 2025 01:14:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 85AE7188F8D3
	for <lists+linux-integrity@lfdr.de>; Wed,  4 Jun 2025 23:14:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C74326C3AA;
	Wed,  4 Jun 2025 23:12:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="nnvKkec1"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 927B126C38E;
	Wed,  4 Jun 2025 23:12:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749078766; cv=none; b=WXOeetRlHe5ES2vUKBu5W/Zlp52X6PxJng7SPpveritJ5oYSwSJmqfFusWzV4w9qc3SP65mcLhA0HylnbU3kjwhXxtqgSIOl1dzRwSTcWEH9YkpT8kW6nZvdKhdglSPDfjNqNIFbLDvPvxCBmkM2MVrHEJVI2/7pd1k5Ln8UPrg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749078766; c=relaxed/simple;
	bh=dI3zrscUxocjWx/CYt+fx2JLhAr1E1g5rkt3nbMrXWQ=;
	h=Message-ID:Subject:From:To:Cc:In-Reply-To:References:Content-Type:
	 Date:MIME-Version; b=HvW/j1H7YJPD63kDU9K7KaSjY6VEFDHrdfm5PXd5/y3ZA+GEqBx23epgDWRFW+9FGW2uZOdgoDofCK98vMrKeJoNytC21vMZKcC/SJWZYz06DAB6i5pmdblznhAVWHZNbNUhn7wlTzLhNHKq7kwvQiSrKduJ6bJJcN3XKSH3PCw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=nnvKkec1; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 554LvVwc030628;
	Wed, 4 Jun 2025 23:12:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=/8T3Wa
	ZuvL5OZZo93H7D0HmVm+r/qGf9r//grSVRSuo=; b=nnvKkec1dZKCcMdYVXmWqB
	L3n3DenN7LDxYQseSCyuLgRX0B400IKGEeCxLzA4s+27jTR1/DCydvq0XT3+WQUB
	wjIa/YsdXIV8KQDCL6BD+Y9+fg0USVbl1a/keagKcoJEEM7sW4XGb2949BPZ4rKL
	v9PwzjOLPfhaePxq65gq6seBxsK6GQkqWoL4gb/FcgYfBfWmxEH5JydjVr2LKDtz
	Ha4g9lZ28rIUx2K6BllMuQUikt5tapwBvQS/G5yQrqE/nfU23AIb2IxwSvaVWS+T
	FdAc5ArH4gRXsxaiIommQ9acDPdIE6ZKPJY8eskF4Sn1P3BE6/wDx0RCIL8lvjgA
	==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 471geywhf1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 04 Jun 2025 23:12:25 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 554N7WJh024883;
	Wed, 4 Jun 2025 23:12:24 GMT
Received: from smtprelay05.dal12v.mail.ibm.com ([172.16.1.7])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 470dkmj0c2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 04 Jun 2025 23:12:24 +0000
Received: from smtpav06.wdc07v.mail.ibm.com (smtpav06.wdc07v.mail.ibm.com [10.39.53.233])
	by smtprelay05.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 554NCNX37471686
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 4 Jun 2025 23:12:23 GMT
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 66BE75803F;
	Wed,  4 Jun 2025 23:12:23 +0000 (GMT)
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 79F4358054;
	Wed,  4 Jun 2025 23:12:22 +0000 (GMT)
Received: from li-43857255-d5e6-4659-90f1-fc5cee4750ad.ibm.com (unknown [9.61.95.113])
	by smtpav06.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Wed,  4 Jun 2025 23:12:22 +0000 (GMT)
Message-ID: <bf593f8bcadc41e0c4823b7173ee5695da51152e.camel@linux.ibm.com>
Subject: Re: [PATCH] ima: add a knob ima= to make IMA be able to be disabled
From: Mimi Zohar <zohar@linux.ibm.com>
To: Coiby Xu <coxu@redhat.com>
Cc: Baoquan He <bhe@redhat.com>, linux-integrity@vger.kernel.org,
        kexec@lists.infradead.org, linux-kernel@vger.kernel.org,
        pmenzel@molgen.mpg.de, ruyang@redhat.com, chenste@linux.microsoft.com
In-Reply-To: <hn455nyrp65bb23ltub4tet6ixfcggshgerxm2bhun4ubv2iau@eanh3ka67irf>
References: <20250515233953.14685-1-bhe@redhat.com>
	 <aCaFNvHbYxrCaPbe@MiWiFi-R3L-srv>
	 <1d2848fe45dbf58707cecf16c4fc46b179e24415.camel@linux.ibm.com>
	 <aC6Y3S9hEB1snvwj@MiWiFi-R3L-srv>
	 <c0f1df02160138d0782cb897eda844287b3d7792.camel@linux.ibm.com>
	 <hn455nyrp65bb23ltub4tet6ixfcggshgerxm2bhun4ubv2iau@eanh3ka67irf>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Date: Wed, 04 Jun 2025 18:53:07 -0400
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Evolution 3.54.3 (3.54.3-1.fc41) 
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: 6pZ1Jz3TJQ6e-pkSk8DkFV26sECAxnGM
X-Authority-Analysis: v=2.4 cv=DYMXqutW c=1 sm=1 tr=0 ts=6840d2d9 cx=c_pps a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17 a=UeMwZWw34uBX8khp:21 a=IkcTkHD0fZMA:10 a=6IFa9wvqVegA:10 a=metLV1VPRzkCuRW9CoIA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: 6pZ1Jz3TJQ6e-pkSk8DkFV26sECAxnGM
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjA0MDE5MSBTYWx0ZWRfX9YNkm/q/Ke9O Oprap30aN9L8gV2BwrImoP9RT1qdyxnyhQWJ6yvXljUsJyA9Xm/vEqtn/fMMAMrjUF4oJX24XFQ VMfA5GLTL8ir0GaTZAJ0Quc7ZuMpDgWg3yyvfsqZYRJrzkQgjyAEwtyfVv5s/YBau6bZJDl2E9d
 +FM5XrOdyhXszpSwnCE0D36EVmrlIVAinGFtm6oSTmr/esgw1CY/lddBwOZ2fmnV0CRS45npryq pXjEy26kVJwyUMG6qaOGve7nzvb3y/842PgX1Dm51fcb+ylkqGTORQ9UXhgHXopBTxVJ7fXpfuv uTzV/iBqVI09BiDFmKywP00f3CNtHW5vVHg3M+cxANawakSJQHLyQeahFjFQVNFedHLL3Mwm8st
 1vMTsUN4+lOkXicLknwhZl5MZxnwwdP295+6YXoF9dLiFUYh7xccYLobDiksg/KJVE8PzuIQ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-04_04,2025-06-03_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 lowpriorityscore=0 suspectscore=0 spamscore=0 mlxscore=0
 priorityscore=1501 clxscore=1015 phishscore=0 mlxlogscore=999 adultscore=0
 malwarescore=0 bulkscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2506040191

On Wed, 2025-06-04 at 11:34 +0800, Coiby Xu wrote:
> On Thu, May 22, 2025 at 07:08:04AM -0400, Mimi Zohar wrote:
> > On Thu, 2025-05-22 at 11:24 +0800, Baoquan He wrote:
> > > On 05/21/25 at 08:54am, Mimi Zohar wrote:
> > > > On Fri, 2025-05-16 at 08:22 +0800, Baoquan He wrote:
> > > > > CC kexec list.
> > > > >=20
> > > > > On 05/16/25 at 07:39am, Baoquan He wrote:
> > > > > > Kdump kernel doesn't need IMA functionality, and enabling IMA w=
ill cost
> > > > > > extra memory. It would be very helpful to allow IMA to be disab=
led for
> > > > > > kdump kernel.
> > >=20
> > > Thanks a lot for careufl reviewing and great suggestions.
> > >=20
> > > >=20
> > > > The real question is not whether kdump needs "IMA", but whether not=
 enabling
> > > > IMA in the kdump kernel could be abused.=C2=A0 The comments below d=
on't address
> > > > that question but limit/emphasize, as much as possible, turning IMA=
 off is
> > > > limited to the kdump kernel.
> > >=20
> > > Are you suggesting removing below paragraph from patch log because th=
ey
> > > are redundant? I can remove it in v2 if yes.
> >=20
> > "The comments below" was referring to my comments on the patch, not the=
 next
> > paragraph.  "don't address that question" refers to whether the kdump k=
ernel
> > could be abused.
> >=20
> > We're trying to close integrity gaps, not add new ones.  Verifying the =
UKI's
> > signature addresses the integrity of the initramfs.  What about the int=
egrity of
> > the kdump initramfs (or for that matter the kexec initramfs)?  If the k=
dump
> > initramfs was signed, IMA would be able to verify it before the kexec.
>=20
> Hi Mimi,
>=20
> I thought you were asking that the commit message should address the
> question why disabling IMA should be limited to the kdump kernel. It
> turns out I misunderstood your concern.
>=20
> Currently there is no way provided to verify the kdump initramfs as a
> whole file or to verify individual files in the kdump initramfs.

There were multiple attempts to close this integrity gap, but none of them =
were
upstreamed.
>=20
> As you have already known, the kdump initramfs is always generated on
> the fly and will be re-generated when the dumping target changes or
> some important files change. We try to generate a minimal initramfs in
> order to save memory. So yes, it's impossible to sign it as a whole file
> beforehand.

I'm just curious as to how UKI includes the initramfs, if it does, in the
signature.

>=20
> And since xattrs like security.ima are not supported in the kdump
> initramfs, we have no way to use IMA to verify individual file's
> integrity.  In fact, we have to stop IMA from working otherwise it's
> very likely kdump will break.
>=20
> So far, I'm not aware of any bug report that complains kdump stops
> working because of IMA. So it indicates very few users are trying to use
> IMA in kdump.
>=20
> If users do have concerns on the integrity of kdump initramfs, I think
> we can advice users to make sure the deployed IMA policy will verify the
> integrity of the files while they are being collected and copied into
> the kdump initramfs by tools like dracut.

For now, I'd prefer to leave it as an integrity gap that still needs to be
addressed.

thanks,

Mimi

