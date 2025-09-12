Return-Path: <linux-integrity+bounces-7063-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0ED8CB554CC
	for <lists+linux-integrity@lfdr.de>; Fri, 12 Sep 2025 18:38:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BDE92AA49B1
	for <lists+linux-integrity@lfdr.de>; Fri, 12 Sep 2025 16:38:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82D2231CA5A;
	Fri, 12 Sep 2025 16:38:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="qa8AjvoY"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8BB5311C03;
	Fri, 12 Sep 2025 16:38:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757695107; cv=none; b=XATH0OS2huGetySgg8tFARWUsp3XUxf1putWzw2nLIMfm3MHENrvYLbTi8A1Gly9j9V7DpvoUxvHD8Oq5omxBFY4lXOeUFk7b2EE5eRyPAgpMLL+qlA9E+5WITtnKLC9XFfWj1hQr9VFesMKj7BMLDdFV+UXtLDvoZvwVubCG3E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757695107; c=relaxed/simple;
	bh=2RaPbc9jVOhVYH7V2C0vnTwGjblLI5tvoUlhHEkUM3A=;
	h=Message-ID:Subject:From:To:Cc:In-Reply-To:References:Content-Type:
	 Date:MIME-Version; b=tKAuHHzXHgwiZnIvyrGxFG8h2AanuQX3kBDT3lH+gIoxhrZ8JS2/Qq8EBJ1O4tQkc+Hx/tUynDCorcSx7dk3PlRTfJ8KV3GesEiMhSekjDggZ2+AA6Wkhu9DuBjXzvJo+YJ2/+ADDACcvGE5kgS7XIT57VvjJRM11gHC/EOToEM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=qa8AjvoY; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58C9LufK028539;
	Fri, 12 Sep 2025 16:37:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=DI0p5X
	VIyWC/Uc+yOWrpUqOI9NbAAOOCwcn10yjBar8=; b=qa8AjvoYRk23gmEWuY8FwH
	Z67y1w7CokEz66O5EbQyL0NcwMYLFkhzqqPKeXkXuswubOI9e9R2N99FCZeAw7xY
	LUJWVFY6DDA8llzrGlwPbSQlTqS8iL5SHZ1ncveGNDNERFP0Qgkguz56iYiHLbvt
	jFu65P4lDQXV4RdC+UDrVcYlF5EV2lPCYn9pKBcetH4N/n0V08eCiSMKESANkUBw
	68WMR0rJPV/aQYs0BRfiyLe+/xDwQR+bdieXqYIvLcEIdYvIc/t8n7U8ZUz9K/Da
	fEnzr5JKaw12VjwpsulLYB84IrgASA699fId1sClUUNVVtMx0EyKNdSAwmrx7X/g
	==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 490ukf0qhp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 12 Sep 2025 16:37:21 +0000 (GMT)
Received: from m0360072.ppops.net (m0360072.ppops.net [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 58CGbLGi018156;
	Fri, 12 Sep 2025 16:37:21 GMT
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 490ukf0qhh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 12 Sep 2025 16:37:21 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 58CDelSB007912;
	Fri, 12 Sep 2025 16:37:20 GMT
Received: from smtprelay04.wdc07v.mail.ibm.com ([172.16.1.71])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 49109q3vfv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 12 Sep 2025 16:37:20 +0000
Received: from smtpav03.dal12v.mail.ibm.com (smtpav03.dal12v.mail.ibm.com [10.241.53.102])
	by smtprelay04.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 58CGbJ1S51249614
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 12 Sep 2025 16:37:20 GMT
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id CD82D5805A;
	Fri, 12 Sep 2025 16:37:19 +0000 (GMT)
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id DB3B558056;
	Fri, 12 Sep 2025 16:37:18 +0000 (GMT)
Received: from li-43857255-d5e6-4659-90f1-fc5cee4750ad.ibm.com (unknown [9.61.159.184])
	by smtpav03.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 12 Sep 2025 16:37:18 +0000 (GMT)
Message-ID: <f9aceb873648bcc8ba6c07b9b9bd269800f03c14.camel@linux.ibm.com>
Subject: Re: [PATCH v3 31/34] ima,evm: move initcalls to the LSM framework
From: Mimi Zohar <zohar@linux.ibm.com>
To: Paul Moore <paul@paul-moore.com>
Cc: Roberto Sassu <roberto.sassu@huawei.com>,
        linux-security-module@vger.kernel.org, linux-integrity@vger.kernel.org,
        selinux@vger.kernel.org, John Johansen <john.johansen@canonical.com>,
        Fan
 Wu	 <wufan@kernel.org>,
        =?ISO-8859-1?Q?Micka=EBl_Sala=FCn?=
 <mic@digikod.net>,
        =?ISO-8859-1?Q?G=FCnther?= Noack	 <gnoack@google.com>,
        Kees Cook <kees@kernel.org>, Micah Morton	 <mortonm@chromium.org>,
        Casey
 Schaufler <casey@schaufler-ca.com>,
        Tetsuo Handa	
 <penguin-kernel@i-love.sakura.ne.jp>,
        Nicolas Bouchinet	
 <nicolas.bouchinet@oss.cyber.gouv.fr>,
        Xiu Jianfeng <xiujianfeng@huawei.com>
In-Reply-To: <CAHC9VhQT8X8UDt2ZbKhA8bVcaNj06sVyTLG0+WyevrTVFpJwtA@mail.gmail.com>
References: <20250814225159.275901-36-paul@paul-moore.com>
	 <20250814225159.275901-67-paul@paul-moore.com>
	 <CAHC9VhS3KdVO9n-dgk1qFzTae0i+Oab8atMmt0CAsMEm1D4v5w@mail.gmail.com>
	 <bd46c63ebb9eddfcdc8df92fe9f85473416ea8a0.camel@linux.ibm.com>
	 <CAHC9VhTJnQ3EggEXwbW5D8xOnb+Z_02yz-Dgb7QiAoArhw1ETg@mail.gmail.com>
	 <9f1dd6d30193c82ff36b5665eadc1aec73736017.camel@linux.ibm.com>
	 <CAHC9VhQT8X8UDt2ZbKhA8bVcaNj06sVyTLG0+WyevrTVFpJwtA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Date: Fri, 12 Sep 2025 12:37:18 -0400
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Evolution 3.54.3 (3.54.3-1.fc41) 
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTA2MDE5NSBTYWx0ZWRfX0IPeRwJI3Adi
 qjW66a4Pvc+8GFw75a2yOYGgWzU3ex911mTiCbMtlV3Fsb4wkZbu7sEfz9BZuLCJPcSya4Amx4d
 VdZqJ/tCu+pd5HSeFFb1cZq3TNMwMaBi+sYMvvPZ9zXA1mMi7y7NMB/S8oi+9xdwlfAqlYUFCO4
 sMaRea9nLXr0c3TdSKHbSxUOP88rkw6WIha9atHr2pewwholZm5ujJ3BhotwFY3WpOU/CWY6RR4
 oPahVjUNrjOnp1eq5yW04qNwbja2JuhYWnsRil8K5+kQgEuUy3iHj7k187GWUm7Y71TOauO1Bo1
 zHSh7r7e3qQ5tt9ak32AKiY7S9FJizzsMEv+Tg7J1f7qGwqAMTkcLaeKq3yAK9iEhMm1piGvwXB
 ELhuWfKx
X-Proofpoint-ORIG-GUID: Yxh_EHnslaCun6acJXqbcBg6NjEz5PrK
X-Proofpoint-GUID: vvOdsqKARsuCKDEWjnHCxq114P4DZJWX
X-Authority-Analysis: v=2.4 cv=StCQ6OO0 c=1 sm=1 tr=0 ts=68c44c42 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=VnNF1IyMAAAA:8 a=CT4C0UVHrSCr1UfN2mgA:9
 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-12_06,2025-09-12_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 malwarescore=0 bulkscore=0 clxscore=1015 adultscore=0
 suspectscore=0 priorityscore=1501 impostorscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2509060195

On Thu, 2025-09-11 at 15:30 -0400, Paul Moore wrote:
> On Mon, Sep 8, 2025 at 6:34=E2=80=AFPM Mimi Zohar <zohar@linux.ibm.com> w=
rote:
> > On Sun, 2025-09-07 at 21:05 -0400, Paul Moore wrote:
> > > > The "unrelated to IMA/EVM" wording misses the point.  An exception =
was made to
> > > > load the pre-boot keys onto the .platform keyring in order for IMA/=
EVM to verify
> > > > the kexec kernel image appended signature.  This exception was subs=
equently
> > > > extended to verifying the pesigned kexec kernel image signature.  (=
Other
> > > > subsystems are abusing the keys on the .platform keyring to verify =
other
> > > > signatures.)
> > > >=20
> > > > Instead of saying "unrelated to IMA/EVM", how about saying somethin=
g along the
> > > > lines of "IMA has a dependency on the platform and machine keyrings=
, but this
> > > > dependency isn't limited to IMA/EVM."
> > > >=20
> > > > Paul, this patch set doesn't apply to cleanly to Linus's tree.  Wha=
t is the base
> > > > commit?
> > >=20
> > > It would have been based on the lsm/dev branch since the LSM tree is
> > > the target, however, given the scope of the patchset and the fact tha=
t
> > > it has been several weeks since it was originally posted, I wouldn't
> > > be surprised it if needs some fuzzing when applied on top of lsm/dev
> > > too.
> >=20
> > Thanks, Paul.  I was able to apply the patches and run some regression =
tests.
>=20
> Mimi, I know you already tagged Roberto's patch with a 'Reviewed-by'
> tag, but I wanted to follow up and see if you were comfortable
> converting that into an ACK, or if you wanted more time to review
> Roberto's patch?  No wrong answers, just trying to understand where
> you are at with this patch.

Please don't convert the Reviewed-by tag quite yet to an Ack.  I'd really l=
ike
to review the entire patch set and do some additional testing.

thanks,

Mimi

