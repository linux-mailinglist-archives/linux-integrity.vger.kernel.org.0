Return-Path: <linux-integrity+bounces-4081-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id CF1F59C4632
	for <lists+linux-integrity@lfdr.de>; Mon, 11 Nov 2024 20:54:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EABFEB21E9D
	for <lists+linux-integrity@lfdr.de>; Mon, 11 Nov 2024 19:54:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B14EC1A76B4;
	Mon, 11 Nov 2024 19:54:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="pQYbdCFV"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 135F1132103;
	Mon, 11 Nov 2024 19:54:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731354866; cv=none; b=cMEYavjMc0voikdf5YU10JhhLthOkDP7+WfhMZDQsm0v6dpX8SG9IaXkHuT2eKGukr13oztZ9rtb67uv97uRjwRDCPtJc9uPoCcn8W5SUTmdo1N3EcTwmsD/duImJhXxFMQWrP/DF0D/kCUMmGGi/bzYRq6kzw59voP2UL3sMxw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731354866; c=relaxed/simple;
	bh=+xNIR6SyFbLm4ZiDbBSE2ZDeR0CGKJ5wHtQjD0Ngm50=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=qGxdl4sUNu4lMqsNB/RCbE/xnEzKhgwSlgiQnojVjNRcEziGZYXNISdvkGEb0J7wY5+5HEp8/pPonQmYDyVe0HOwgJVqXPvQM/t8Tog8dIeY+2htZbRJ6fJo59vz8gKgN62JmES9qopgHcq6lhjLkgeeBueEe5ke571zZpwi+Qg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=pQYbdCFV; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4ABF9xms029461;
	Mon, 11 Nov 2024 19:53:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=87Oyme
	Nad5N63iba6WZgJPlA/SgeyRhOrvUOkAOWbg8=; b=pQYbdCFVP9mAwExQq69TYs
	6IhzElpuA9Ec/lIHBLdXBgG/wo/obNmV6qiKjwIvCgrvfOVQC8OuHXSXhXW8eyVz
	W1t+CKMTqNBr+uF/yjFGLcm6CCW7qfHugIZCp8Dca/F7uXp6xtm8YPWC2om4e+d8
	LgNCJixWdLyAya7xWqE8o7R3LMcey+7c9J8oRkw6tKyhQjkj/bzmuEk7ay4QA9rk
	BkSgOaEYKaLfr3EBq541DYKQ+YxrypHP7HhMDd3YpkplFO6Z/T9r2gPGcp0sh4oY
	NAGGAyOtWAJAPYRkX0JNh3FdqHvoLMMCwmR0dshTPb5V/vhFB2Q3nnflENbJZ+Rg
	==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 42umav92xt-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 11 Nov 2024 19:53:13 +0000 (GMT)
Received: from m0356516.ppops.net (m0356516.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 4ABJrCLL030306;
	Mon, 11 Nov 2024 19:53:12 GMT
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 42umav92xr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 11 Nov 2024 19:53:12 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 4ABJbl93008404;
	Mon, 11 Nov 2024 19:53:12 GMT
Received: from smtprelay05.wdc07v.mail.ibm.com ([172.16.1.72])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 42tjey9n6y-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 11 Nov 2024 19:53:12 +0000
Received: from smtpav05.dal12v.mail.ibm.com (smtpav05.dal12v.mail.ibm.com [10.241.53.104])
	by smtprelay05.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 4ABJrBiC20709950
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 11 Nov 2024 19:53:11 GMT
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 7BEF258052;
	Mon, 11 Nov 2024 19:53:11 +0000 (GMT)
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id F09AD5805D;
	Mon, 11 Nov 2024 19:53:10 +0000 (GMT)
Received: from li-43857255-d5e6-4659-90f1-fc5cee4750ad.ibm.com (unknown [9.61.110.57])
	by smtpav05.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 11 Nov 2024 19:53:10 +0000 (GMT)
Message-ID: <dd51366e50de86e8a6002f2f53801c53a9b770f3.camel@linux.ibm.com>
Subject: Re: [PATCH v2] tpm: Opt-in in disable PCR integrity protection
From: Mimi Zohar <zohar@linux.ibm.com>
To: James Bottomley <James.Bottomley@HansenPartnership.com>,
        Jarkko Sakkinen
 <jarkko@kernel.org>, linux-integrity@vger.kernel.org,
        Jonathan Corbet
 <corbet@lwn.net>, Peter Huewe <peterhuewe@gmx.de>,
        Jason Gunthorpe
 <jgg@ziepe.ca>
Cc: Roberto Sassu <roberto.sassu@huawei.com>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Date: Mon, 11 Nov 2024 14:53:10 -0500
In-Reply-To: <10296fd8b0fcbf1d813577ef41738ffea12b70d1.camel@HansenPartnership.com>
References: <20241107095138.78209-1-jarkko@kernel.org>
	 <76d9ae11c339b589a8ec94f010e7439b7ce7d283.camel@HansenPartnership.com>
	 <D5FZT0QPHL0O.231WD6VUHC48X@kernel.org>
	 <10296fd8b0fcbf1d813577ef41738ffea12b70d1.camel@HansenPartnership.com>
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
X-Proofpoint-GUID: wK0NwLDaDVQMoVyqQtYxYDorsb2XHBFc
X-Proofpoint-ORIG-GUID: wt9Pl_62oacIojLZdQX_ssJzsL0ODwSk
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-15_01,2024-10-11_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=516
 impostorscore=0 malwarescore=0 suspectscore=0 clxscore=1015 bulkscore=0
 lowpriorityscore=0 mlxscore=0 phishscore=0 adultscore=0 spamscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2409260000 definitions=main-2411110156

On Thu, 2024-11-07 at 08:52 -0500, James Bottomley wrote:
> On Thu, 2024-11-07 at 15:49 +0200, Jarkko Sakkinen wrote:
> > On Thu Nov 7, 2024 at 3:20 PM EET, James Bottomley wrote:
> > > On Thu, 2024-11-07 at 11:51 +0200, Jarkko Sakkinen wrote:
> > > [...]
> > > > +void tpm_buf_append_auth(struct tpm_chip *chip, struct tpm_buf
> > > > *buf,
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 u8=
 attributes, u8 *passphrase, int
> > > > passphrase_len)
> > > > +{
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0/* offset tells us where=
 the sessions area begins */
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0int offset =3D buf->hand=
les * 4 + TPM_HEADER_SIZE;
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0u32 len =3D 9 + passphra=
se_len;
> > > > +
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0if (tpm_buf_length(buf) =
!=3D offset) {
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0/* not the first session so update the existing
> > > > length */
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0len +=3D get_unaligned_be32(&buf->data[offset]);
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0put_unaligned_be32(len, &buf->data[offset]);
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0} else {
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0tpm_buf_append_u32(buf, len);
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0}
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0/* auth handle */
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0tpm_buf_append_u32(buf, =
TPM2_RS_PW);
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0/* nonce */
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0tpm_buf_append_u16(buf, =
0);
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0/* attributes */
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0tpm_buf_append_u8(buf, 0=
);
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0/* passphrase */
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0tpm_buf_append_u16(buf, =
passphrase_len);
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0tpm_buf_append(buf, pass=
phrase, passphrase_len);
> > > > +}
> > > > +
> > >=20
> > > The rest of the code looks fine, but if you're going to extract
> > > this as a separate function instead of doing the open coded struct
> > > tpm2_null_auth that was there originally, you should probably
> > > extract and use the tpm2_buf_append_auth() function in
> > > trusted_tpm2.c
> >=20
> > So this was straight up from Mimi's original patch :-)
>=20
> Yes, I had the same comment prepped for that too.

But it wasn't sent ...
>=20
> > Hmm... was there duplicate use for this in the patch? I'll check
> > this.
>=20
> The original open coded the empty auth append with struct
> tpm2_null_auth since it's the only user.  However, since we do have
> another user in trusted keys, it might make sense to consolidate.

Instead of delaying the current patch from being upstreamed, perhaps this c=
hange
can be deferred?

thanks,

Mimi

