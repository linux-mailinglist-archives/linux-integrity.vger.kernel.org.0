Return-Path: <linux-integrity+bounces-5438-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E6812A71745
	for <lists+linux-integrity@lfdr.de>; Wed, 26 Mar 2025 14:17:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D33713AC95A
	for <lists+linux-integrity@lfdr.de>; Wed, 26 Mar 2025 13:17:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E18EA1C862D;
	Wed, 26 Mar 2025 13:17:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="ImckGktg"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42DD01B21A7;
	Wed, 26 Mar 2025 13:17:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742995047; cv=none; b=HI6CjcA0dOgDRiE0EG0i5Y+B8OTnhC21D6ecYs8O9hmLK52cY98/iPN+i3gkhpz01LtrOFe5hezZUQDNL5V16fCauEjl9ippbjmaKicZ/p51ysg90kCzyu7vKsABiUwNrbvn0S8GVAoGetvansfGb5YOch9gs9eVzVSP1eZq1D4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742995047; c=relaxed/simple;
	bh=5LTt8toHUOmillf4ck7JAEUd0cRbvsUvltg7TJScrQc=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=VrsXXL1kPDjdSYr9Y27fTXl6laZlp4fWwd4orhIGLvNlXbnjEIOwCap8FNdg0XEbmcaSA3gW8ShzACUo+KVC/iMgcq6sgCr10VN0o41y06p4DsrFdMCx0G9YIAMcv6rZtHrMzxuGbcjYViffby5jEHfI/j0hx5IqGtEEKRO7d1g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=ImckGktg; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52QDAEaA001561;
	Wed, 26 Mar 2025 13:17:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=eLXGk8
	E+7+fznpZBnrreYff0kjvF6A1PBo2NCZhX8Rk=; b=ImckGktgbzsPEASON+RNT0
	bYuYqPqckPpNjp+UVrQ+YWV+WDov/5J0Skbz209cnv54QGTVr4Rm6DqXW3wQgSpq
	R6cyGy8CB9Rg9PckCfcGTJ2Cpv35hqyXuoKXOxrw4pJ8vSZGFKWR1m6A3bka2O8a
	FZPq2Z9Oms/agnK7uManhwS1/kp1JqW/s7MHCFtw0LiMrUvM3DPh7rUnq4si2HLI
	BxOYdJdgGGUzAn0OajTZ+rGCXidF7DtXoXw+3FT1sDMo6cejVBl9Sl1ubsZGVO/O
	PRji74v1EQJvyGypaBvVP/qm8X1UBx4uOpMSq9jHT6K2zO/KbHiWu2oVwFjx0x/g
	==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 45m9ya2k4v-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 26 Mar 2025 13:17:09 +0000 (GMT)
Received: from m0360083.ppops.net (m0360083.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 52QD7xU7012270;
	Wed, 26 Mar 2025 13:17:08 GMT
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 45m9ya2k4s-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 26 Mar 2025 13:17:08 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 52Q93gUk030325;
	Wed, 26 Mar 2025 13:17:07 GMT
Received: from smtprelay05.wdc07v.mail.ibm.com ([172.16.1.72])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 45j7htgn92-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 26 Mar 2025 13:17:07 +0000
Received: from smtpav02.dal12v.mail.ibm.com (smtpav02.dal12v.mail.ibm.com [10.241.53.101])
	by smtprelay05.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 52QDH6D225363086
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 26 Mar 2025 13:17:07 GMT
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 9F2AB5805C;
	Wed, 26 Mar 2025 13:17:06 +0000 (GMT)
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 024C058051;
	Wed, 26 Mar 2025 13:17:06 +0000 (GMT)
Received: from li-43857255-d5e6-4659-90f1-fc5cee4750ad.ibm.com (unknown [9.61.116.195])
	by smtpav02.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 26 Mar 2025 13:17:05 +0000 (GMT)
Message-ID: <fbd87f01b5463e399900df8dcb094a9039bd589f.camel@linux.ibm.com>
Subject: Re: [RFC PATCH v2 02/13] ima: always create runtime_measurements
 sysfs file for ima_hash
From: Mimi Zohar <zohar@linux.ibm.com>
To: Nicolai Stange <nstange@suse.de>
Cc: Roberto Sassu <roberto.sassu@huawei.com>,
        Dmitry Kasatkin
 <dmitry.kasatkin@gmail.com>,
        Eric Snowberg <eric.snowberg@oracle.com>,
        Jarkko Sakkinen <jarkko@kernel.org>,
        James Bottomley
 <James.Bottomley@HansenPartnership.com>,
        linux-integrity@vger.kernel.org, linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org
Date: Wed, 26 Mar 2025 09:17:05 -0400
In-Reply-To: <875xjwrymf.fsf@>
References: <20250323140911.226137-1-nstange@suse.de>
	 <20250323140911.226137-3-nstange@suse.de>
	 <35d199c2a09e9215aad715c97a6702dd04be4a98.camel@linux.ibm.com>
	 <875xjwrymf.fsf@>
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
X-Proofpoint-GUID: xIM3n18FKTyExZinkz8ePcD2lJ0Ic1s5
X-Proofpoint-ORIG-GUID: q8NXFVyH80ec7ZUwiRabWHbxZ7zVLtN2
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-26_06,2025-03-26_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 bulkscore=0
 mlxlogscore=999 mlxscore=0 clxscore=1015 lowpriorityscore=0 spamscore=0
 priorityscore=1501 suspectscore=0 adultscore=0 phishscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2502280000 definitions=main-2503260079

On Wed, 2025-03-26 at 09:21 +0100, Nicolai Stange wrote:
> Mimi Zohar <zohar@linux.ibm.com> writes:
>=20
> > On Sun, 2025-03-23 at 15:09 +0100, Nicolai Stange wrote:
> > > runtime_measurements_<hash-algo> sysfs files are getting created for
> > > each PCR bank + for SHA-1.
> > >=20
> > > Now that runtime_measurements_<hash-algo> sysfs file creation is bein=
g
> > > skipped for unsupported hash algorithms, it will become possible that=
 no
> > > such file would be provided at all once SHA-1 is made optional in a
> > > later patch.
> > >=20
> > > Always create the file for the 'ima_hash' algorithm, even if it's not
> > > associated with any of the PCR banks. As IMA initialization will
> > > continue to fail if the ima_hash algorithm is not available to the
> > > kernel, this guarantees that at least one such file will always be
> > > there.
> > >=20
> > > Signed-off-by: Nicolai Stange <nstange@suse.de>
> > > ---
> > >  security/integrity/ima/ima_fs.c | 6 ++----
> > >  1 file changed, 2 insertions(+), 4 deletions(-)
> > >=20
> > > diff --git a/security/integrity/ima/ima_fs.c b/security/integrity/ima=
/ima_fs.c
> > > index a8df2fe5f4cb..f030ff7f56da 100644
> > > --- a/security/integrity/ima/ima_fs.c
> > > +++ b/security/integrity/ima/ima_fs.c
> > > @@ -436,10 +436,8 @@ static int __init create_securityfs_measurement_=
lists(void)
> > >  	u16 algo;
> > >  	int i;
> > > =20
> > > -	securityfs_measurement_list_count =3D NR_BANKS(ima_tpm_chip);
> > > -
> > > -	if (ima_sha1_idx >=3D NR_BANKS(ima_tpm_chip))
> > > -		securityfs_measurement_list_count++;
> > > +	securityfs_measurement_list_count =3D
> > > +		NR_BANKS(ima_tpm_chip) + ima_extra_slots;
> > > =20
> > >  	ascii_securityfs_measurement_lists =3D
> > >  	    kcalloc(securityfs_measurement_list_count, sizeof(struct dentry=
 *),
> >=20
> > "ima_hash" is the default file hash algorithm.  Re-using it as the defa=
ult
> > complete measurement list assumes that the subsequent kexec'ed kernels =
configure
> > and define it as the default file hash algorithm as well, which might n=
ot be the
> > case.
>=20
> I don't really see why the ima_hashes would have to match between kexecs
> for this to work -- all events' template hashes are getting recreated
> from scratch anyway after kexec (ima_restore_measurement_list() ->
> ima_calc_field_array_hash()).
>=20
> That is, if ima_hash=3Dsha256 first, and ima_hash=3Dsha384 after kexec, o=
ne
> would have *runtime_measurements_sha256 first and
> *runtime_measurements_sha384 after kexec. And both had exclusively
> template hashes of their respective algo in them each.
>=20
> What am I missing?

Your solution would work nicely, if the "ima_hash" algorithm could be guara=
nteed
to be built into the kernel.  It's highly unlikely someone would choose a h=
ash
algorithm not built into kernel, but it is possible.  hash_setup() only ver=
ifies
that the hash algorithm is a valid name.

Either fix hash_setup() to guarantee that the chosen hash algorithm is buil=
t
into the kernel or use the CONFIG_IMA_DEFAULT_HASH and add a Kconfig to sel=
ect
the hash algorithm.  This would be in lieu of v2 05/13.

> > Drop this patch.
>=20
> Fine by me, but just to confirm, in case there's no TPM attached and
> SHA1 was disabled, there would be no /sys/*/*runtime_measurement* at all
> then. Is that Ok?

Of course not.  :)

> ima_hash was chosen here only, because after this series, it will be the
> only single algorithm guaranteed to be available.

With the proposed changes to "[RFC PATCH v2 05/13] ima: select CRYPTO_SHA25=
6
from Kconfig', SHA256 would be added to the "extra" measurements if the TPM
SHA256 bank is disabled.

Mimi

