Return-Path: <linux-integrity+bounces-7028-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7DA14B482AE
	for <lists+linux-integrity@lfdr.de>; Mon,  8 Sep 2025 04:47:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4A383189D579
	for <lists+linux-integrity@lfdr.de>; Mon,  8 Sep 2025 02:47:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BEB91CAB3;
	Mon,  8 Sep 2025 02:47:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="LJ3Nyiv+"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E597A171CD;
	Mon,  8 Sep 2025 02:47:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757299623; cv=none; b=ENLMDB8wTarg3OevDVOtYAN9Am7A/cCUaJ23+HD+UxMGq+TGdc3bVQ5qPDk9q1YgcYky/LoRrAOgiGsCUqR4UVUkBFODuLoyC1tpBCsnD0913y278/36JXcFpiqtzZ5eY8IRJPPgN7nyOrFR0aGgTpWdqnd3C3LHhSzRqzuzfdw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757299623; c=relaxed/simple;
	bh=MYX2NlO5SyBW5gYlK+OqGWG3bL0XKYEN8w+6BK9jatM=;
	h=Message-ID:Subject:From:To:Cc:In-Reply-To:References:Content-Type:
	 Date:MIME-Version; b=KTbPLs8v0SVDah1JM2f40zIUGusZsWF79N5QOkme3KuNCdawbUqqskIJF2fspD69N7MNYpAw4VQCzglhtIRugI1q6pcemXsYoFIBgomj5bY7fpYLsZgZBnnZjGS/M9+rN/L1CmVt+T69aN+laq6FUZyUq/sqmqMAKLKbKlmRgug=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=LJ3Nyiv+; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 587FcUDY005177;
	Mon, 8 Sep 2025 02:45:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=A/cbUp
	Gh7z2VHQ89oyaGcGv0SVlB9sd30q8A6DhrUiY=; b=LJ3Nyiv+BUxf69IxPhytiS
	KJ4MRdtU2vtAwV6e9yoEQ/9WBgUdGNBMi097frzy3mc81gOBhM2eFpBueAQvfxkM
	7VlCKW+Y1sFD6grkyK/+RUPcGJlM0AYgCrCz9TY4C95/TQDZ3ITUSAM0tXWikjhb
	RhzKYoKo3Xx8o355NgBT4kjRY1yWH/6SbwMu9XzIDnCcnalc45n3uFIAWXIyDRwN
	iyNsIXkFWFkrXniz29Wu2zPeJ6lUrtAFw/XdHJqqEOaq7/IfxScAtuM2Q31adRmQ
	JajJeeJHoNwnvOfChm5omM9ehZY/GoSkMOVjOrJLgx9rQe7PxCjN4NoScK7qF2pg
	==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 490xycksa3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 08 Sep 2025 02:45:49 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 5880EDph008428;
	Mon, 8 Sep 2025 02:45:47 GMT
Received: from smtprelay06.dal12v.mail.ibm.com ([172.16.1.8])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 49109pc0tn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 08 Sep 2025 02:45:47 +0000
Received: from smtpav01.dal12v.mail.ibm.com (smtpav01.dal12v.mail.ibm.com [10.241.53.100])
	by smtprelay06.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 5882jlNT19071578
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 8 Sep 2025 02:45:47 GMT
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 3C57C58057;
	Mon,  8 Sep 2025 02:45:47 +0000 (GMT)
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 51A2C58058;
	Mon,  8 Sep 2025 02:45:46 +0000 (GMT)
Received: from li-43857255-d5e6-4659-90f1-fc5cee4750ad.ibm.com (unknown [9.61.145.77])
	by smtpav01.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Mon,  8 Sep 2025 02:45:46 +0000 (GMT)
Message-ID: <0cccd05c0005d3b9e85ab92e35363cc69ea6a3f2.camel@linux.ibm.com>
Subject: Re: [PATCH] ima,evm: move initcalls to the LSM framework
From: Mimi Zohar <zohar@linux.ibm.com>
To: Paul Moore <paul@paul-moore.com>
Cc: Roberto Sassu <roberto.sassu@huaweicloud.com>, roberto.sassu@huawei.com,
        linux-security-module@vger.kernel.org, linux-integrity@vger.kernel.org,
        selinux@vger.kernel.org, john.johansen@canonical.com, wufan@kernel.org,
        mic@digikod.net, kees@kernel.org, mortonm@chromium.org,
        casey@schaufler-ca.com, penguin-kernel@i-love.sakura.ne.jp,
        nicolas.bouchinet@oss.cyber.gouv.fr, xiujianfeng@huawei.com
In-Reply-To: <CAHC9VhTGAcMTXHReinybpLzer7seCN+NUTHcFte+aU2oRNtNNg@mail.gmail.com>
References: <9f35539de7188c6b853c55b76958a286131f5928.camel@huaweicloud.com>
	 <20250902125457.2689519-1-roberto.sassu@huaweicloud.com>
	 <82f22f97486622408bec772a9b025e301c8fa2f4.camel@linux.ibm.com>
	 <CAHC9VhTGAcMTXHReinybpLzer7seCN+NUTHcFte+aU2oRNtNNg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Date: Sun, 07 Sep 2025 22:45:45 -0400
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Evolution 3.54.3 (3.54.3-1.fc41) 
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: nxbbBZgga2uGw9ctsyup4-NS38V4HEE2
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTA2MDIzNSBTYWx0ZWRfX7ZCxI/8eAtM2
 Lz4g4JY0pjz9cc4FNwqQkCzWkLf0v3SxFmLSnuU5nsu4TwsMtl1NPhtyF+5TmQAztipiGQCyeLH
 iGNUn6DYmaWLDdsszHouGpiUuPRYAaMu7x+nnlwYSb3Zxxx7VWKr3Ci2AhyNtMIrOGvLL8sEyZa
 ZRAE5IKkLUgMQXwcLR5UvVBUI9kli+xFJiAP91SfrZUnh/NjPd53JOxb2OGUvZZe7A8EryGp9B1
 sgivj3KhxO5/JwZgCLted6Y6CdC0q40CnYF2hka90fwJSOskuCJGmHF+42olU4DigkkjDgOA1sU
 lDhZb+dascAg6Q4y2sfk9UtPIHBhvktgnOxBbZsqTWHXUjvr+C09EG2MvqaeHKvcFh2p27+VqPw
 icfKU15v
X-Proofpoint-GUID: nxbbBZgga2uGw9ctsyup4-NS38V4HEE2
X-Authority-Analysis: v=2.4 cv=F59XdrhN c=1 sm=1 tr=0 ts=68be435d cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=VnNF1IyMAAAA:8 a=xVhDTqbCAAAA:8
 a=i0EeH86SAAAA:8 a=yORHCZHdIJkfznEZqAAA:9 a=QEXdDO2ut3YA:10
 a=GrmWmAYt4dzCMttCBZOh:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-07_10,2025-09-04_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 malwarescore=0 suspectscore=0 phishscore=0 clxscore=1015
 impostorscore=0 bulkscore=0 adultscore=0 spamscore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2509060235

On Sun, 2025-09-07 at 21:08 -0400, Paul Moore wrote:
> On Sun, Sep 7, 2025 at 5:18=E2=80=AFPM Mimi Zohar <zohar@linux.ibm.com> w=
rote:
> >=20
> > On Tue, 2025-09-02 at 14:54 +0200, Roberto Sassu wrote:
> > > From: Paul Moore <paul@paul-moore.com>
> >=20
> > Remove above ...
> >=20
> > >=20
> > > This patch converts IMA and EVM to use the LSM frameworks's initcall
> > > mechanism. It moved the integrity_fs_init() call to ima_fs_init() and
> > > evm_init_secfs(), to work around the fact that there is no "integrity=
" LSM,
> > > and introduced integrity_fs_fini() to remove the integrity directory,=
 if
> > > empty. Both integrity_fs_init() and integrity_fs_fini() support the
> > > scenario of being called by both the IMA and EVM LSMs.
> > >=20
> > > It is worth mentioning that this patch does not touch any of the
> > > "platform certs" code that lives in the security/integrity/platform_c=
erts
> > > directory as the IMA/EVM maintainers have assured me that this code i=
s
> > > unrelated to IMA/EVM, despite the location, and will be moved to a mo=
re
> >=20
> > This wording "unrelated to IMA/EVM" was taken from Paul's patch descrip=
tion, but
> > needs to be tweaked.  Please refer to my comment on Paul's patch.
>=20
> Minim, Roberto, would both of you be okay if I changed the second
> paragraph to read as follows:
>=20
> "This patch does not touch any of the platform certificate code that
> lives under the security/integrity/platform_certs directory as the
> IMA/EVM developers would prefer to address that in a future patchset."

That's fine.

>=20
> > > relevant subsystem in the future.
> > >=20
> > > Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>
> >=20
> > Reviewed-by: Mimi Zohar <zohar@linux.ibm.com>, but not yet tested.
>=20


