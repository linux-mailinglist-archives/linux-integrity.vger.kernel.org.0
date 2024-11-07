Return-Path: <linux-integrity+bounces-4065-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C2AD29C0849
	for <lists+linux-integrity@lfdr.de>; Thu,  7 Nov 2024 15:00:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7B1591F21736
	for <lists+linux-integrity@lfdr.de>; Thu,  7 Nov 2024 14:00:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E097200132;
	Thu,  7 Nov 2024 14:00:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="rdEfg8kH"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7E2417BB0D;
	Thu,  7 Nov 2024 14:00:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730988017; cv=none; b=Dk4LTPOHsPl/lqYxI5QrnQyahFBw5ok5a4Wbss+Zx9/FxYMO1Da3oijoTfpva+TITm7tGl0LgK4NjvRGbqmDGgrHbSSpSqGic0ck+Rj18dNJyVkU92hHXgxhTX5HFIIw7l8fIZaJDSHrEGr7K7g/7s8IYEuiK1XIBwVVZbwM0Xw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730988017; c=relaxed/simple;
	bh=htQux0twfHQwlwceiIF8ei3ryO6VfDFp3aoNPmHpa7I=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=nd1fDEg2HAqBNXoGekHFFTLI4a+PvXMrsZWd0mc6ugYv1lNu6dVVQ7yn7hgrr+ZvNiHIn+KCf6hmXIaA3E2Zb9Nhe+6l8Tx86doaZqFctMF6GosYL2lpQ9/9qasiErixmM4uD1MmtGNeHwsmOuz6dL6Yo9rX/SpZgVslKxJREAc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=rdEfg8kH; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4A7Dlpni005360;
	Thu, 7 Nov 2024 14:00:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=HNbyJ8
	FJTjee4PYxExjyZ0U+Ysg+Oyd60UcU4Ecq7xU=; b=rdEfg8kHb+jCacVOaif5Ce
	Nro09dnzL+sV8zhvO0yj8hVp9EDHsJkDBRbHdF2BDGN0bREmdRD0e0oWVQXQ786Q
	UblVyHpNemJK+SO4Tn5Ep90EKYwQIUA9xgvCxXbIM8JBwMqLePYTVWp1DaAF4+qI
	Zkhs5p/wBG2cJY000OmFHwWjaSnIxJ8XsnrHFFQQXiF/NbFK7uf0TBDVNJo97MTW
	0I6aK8pnYRVnU4+z4MOoNBFy4L16a4TzHZgjmxYnLPUQSPceV8K2k9WY+TJUzcCN
	UVMvGaxbXit7vLRMxCmK1Bt7LwGh+zBsui7jQvGc6RIByqvN7hIYPZ9rA3h06Mvg
	==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 42rxmp03b8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 07 Nov 2024 14:00:04 +0000 (GMT)
Received: from m0356517.ppops.net (m0356517.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 4A7E04wj000784;
	Thu, 7 Nov 2024 14:00:04 GMT
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 42rxmp03b3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 07 Nov 2024 14:00:04 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 4A7DKC8Y008450;
	Thu, 7 Nov 2024 14:00:03 GMT
Received: from smtprelay07.dal12v.mail.ibm.com ([172.16.1.9])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 42nywm6t3f-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 07 Nov 2024 14:00:03 +0000
Received: from smtpav04.dal12v.mail.ibm.com (smtpav04.dal12v.mail.ibm.com [10.241.53.103])
	by smtprelay07.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 4A7E02tP54395194
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 7 Nov 2024 14:00:02 GMT
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 79C0F58063;
	Thu,  7 Nov 2024 14:00:02 +0000 (GMT)
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id EA44E58052;
	Thu,  7 Nov 2024 14:00:01 +0000 (GMT)
Received: from li-43857255-d5e6-4659-90f1-fc5cee4750ad.ibm.com (unknown [9.61.35.241])
	by smtpav04.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Thu,  7 Nov 2024 14:00:01 +0000 (GMT)
Message-ID: <7f77c0e8b481fd813b3a76b84d33d8db62e235f7.camel@linux.ibm.com>
Subject: Re: [PATCH v2] tpm: Opt-in in disable PCR integrity protection
From: Mimi Zohar <zohar@linux.ibm.com>
To: Jarkko Sakkinen <jarkko@kernel.org>, linux-integrity@vger.kernel.org,
        Jonathan Corbet <corbet@lwn.net>, Peter Huewe <peterhuewe@gmx.de>,
        Jason
 Gunthorpe <jgg@ziepe.ca>,
        James Bottomley
 <James.Bottomley@HansenPartnership.com>
Cc: Roberto Sassu <roberto.sassu@huawei.com>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Date: Thu, 07 Nov 2024 09:00:01 -0500
In-Reply-To: <D5FZRXBCH2B4.1GQIIVQHVB2XI@kernel.org>
References: <20241107095138.78209-1-jarkko@kernel.org>
	 <e015a939893d35efe75e598152725adcc2befdd8.camel@linux.ibm.com>
	 <D5FZRXBCH2B4.1GQIIVQHVB2XI@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.4 (3.52.4-1.fc40) 
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: 0A-dx98u5gpMlexuIRJ4o8yqdHrnAwgJ
X-Proofpoint-GUID: z2DRo5J8axsKwM-xMcZeUtyWau5h5XG9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-15_01,2024-10-11_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 priorityscore=1501 impostorscore=0 phishscore=0 suspectscore=0
 adultscore=0 malwarescore=0 mlxlogscore=711 mlxscore=0 bulkscore=0
 clxscore=1015 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2409260000 definitions=main-2411070106

On Thu, 2024-11-07 at 15:47 +0200, Jarkko Sakkinen wrote:
> On Thu Nov 7, 2024 at 3:44 PM EET, Mimi Zohar wrote:
> > >=20
> > > @@ -232,18 +236,26 @@ int tpm2_pcr_extend(struct tpm_chip *chip, u32 =
pcr_idx,
> > >  	int rc;
> > >  	int i;
> > > =20
> > > -	rc =3D tpm2_start_auth_session(chip);
> > > -	if (rc)
> > > -		return rc;
> > > +	if (!disable_pcr_integrity_protection) {
> > > +		rc =3D tpm2_start_auth_session(chip);
> > > +		if (rc)
> > > +			return rc;
> > > +	}
> > > =20
> > >  	rc =3D tpm_buf_init(&buf, TPM2_ST_SESSIONS, TPM2_CC_PCR_EXTEND);
> > >  	if (rc) {
> > > -		tpm2_end_auth_session(chip);
> > > +		if (!disable_pcr_integrity_protection)
> > > +			tpm2_end_auth_session(chip);
> > >  		return rc;
> > >  	}
> > > =20
> > > -	tpm_buf_append_name(chip, &buf, pcr_idx, NULL);
> > > -	tpm_buf_append_hmac_session(chip, &buf, 0, NULL, 0);
> > > +	if (!disable_pcr_integrity_protection) {
> > > +		tpm_buf_append_name(chip, &buf, pcr_idx);
> >=20
> > tpm_buf_append_name() parameters didn't change.  Don't remove the 'name=
' field
> > here.
>=20
> Hmm... weird I'll check this. Maybe I had something left to staging...
>=20
> >=20
> >=20
> > > +		tpm_buf_append_hmac_session(chip, &buf, 0, NULL, 0);
> > > +	} else {
> > > +		tpm_buf_append_handle(chip, &buf, pcr_idx);
> >=20
>=20
> > Or here.
>=20
> Here I think it is appropriate

Agreed

>=20
> >=20
> > > +		tpm_buf_append_auth(chip, &buf, 0, NULL, 0);
> > > +	}
> > > =20
> > >  	tpm_buf_append_u32(&buf, chip->nr_allocated_banks);
> > >=20

