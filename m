Return-Path: <linux-integrity+bounces-3806-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3089A99C97B
	for <lists+linux-integrity@lfdr.de>; Mon, 14 Oct 2024 13:54:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AC169B26B84
	for <lists+linux-integrity@lfdr.de>; Mon, 14 Oct 2024 11:46:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDA8E19C557;
	Mon, 14 Oct 2024 11:46:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="MdS0KHEf"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25BF7154BFF;
	Mon, 14 Oct 2024 11:46:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728906390; cv=none; b=qNNBXGjUQcNlw82lgAHeoo8BDXcVaPX8EYi3TshFL7+l8enr2/4iacg/IbgEydyptZrUUJNYnRLUQSixZDPSbQ2nIIHkhXaXo3tkoYpcfJEC7bwZDvA3SiWTS/6URXDLc+dBOykx3OofovW7Qf1tEfN131XuCkOxFr0jedHpI10=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728906390; c=relaxed/simple;
	bh=WCsxHw3vZQcjnLcbXSjXjwVJ4eA/MYcD+tajOib6FT4=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=VolPdGa5VJtL2CurWFaCE6rW6NOwAVApeZYXsw5sML984jtqFF5rBqdJSEd9dwaHAX6Fgei5JTECUELfmS8g1/AQis8qBS7QGgl07PEy2sANeZFdTp1XpbnVfjhGDKbn0rSZHzPGwaTWg0dqK+/jEcx70dpsZ0owR6rSfFoWUL0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=MdS0KHEf; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49E9shQo005514;
	Mon, 14 Oct 2024 11:46:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=
	message-id:subject:from:to:cc:date:in-reply-to:references
	:content-type:content-transfer-encoding:mime-version; s=pp1; bh=
	WCsxHw3vZQcjnLcbXSjXjwVJ4eA/MYcD+tajOib6FT4=; b=MdS0KHEfRRyQVmol
	l7Foxf3uI71SAwaBHJEHAXKpSmji55GQD4A7nlBYv6etacyeuim5f0xt/xxCk1iZ
	XiU4+TcUABZwnyNSp0StGb+nYUwFWNLZ5OL0d4xX9gndVgfUf1Ld8JjmKiNwYjJ/
	uMc2pVBS2lDPJX1ELTJxPOxiXsui+mtA/7JRAYA8ljAeGav399O/qYhdj78rgVpe
	/HWmCTjsjtY/0WXZLegLZKyI0Brb9GWKdq1CAZVIf3vLNvF4ZIvIkmDkJIOcQQy5
	gYmeeVZohS5iatQKgdFD3Rq/E4TQ0JSelrr9ReuPZ30oyMk67+VK+QvnWSKP0JkV
	RfyaGw==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4291330fxk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 14 Oct 2024 11:46:01 +0000 (GMT)
Received: from m0356517.ppops.net (m0356517.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 49EBk1Tg017492;
	Mon, 14 Oct 2024 11:46:01 GMT
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4291330fxc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 14 Oct 2024 11:46:01 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 49EBbf5K002452;
	Mon, 14 Oct 2024 11:45:59 GMT
Received: from smtprelay03.wdc07v.mail.ibm.com ([172.16.1.70])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4284eme94a-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 14 Oct 2024 11:45:59 +0000
Received: from smtpav05.dal12v.mail.ibm.com (smtpav05.dal12v.mail.ibm.com [10.241.53.104])
	by smtprelay03.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 49EBjxIx25231986
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 14 Oct 2024 11:45:59 GMT
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 0810A58067;
	Mon, 14 Oct 2024 11:45:58 +0000 (GMT)
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 389CF58052;
	Mon, 14 Oct 2024 11:45:58 +0000 (GMT)
Received: from li-43857255-d5e6-4659-90f1-fc5cee4750ad.ibm.com (unknown [9.61.89.75])
	by smtpav05.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 14 Oct 2024 11:45:58 +0000 (GMT)
Message-ID: <04dc04872f2925166f969b43852161d468ee899a.camel@linux.ibm.com>
Subject: Re: [PATCH v5 0/5] Lazy flush for the auth session
From: Mimi Zohar <zohar@linux.ibm.com>
To: Jarkko Sakkinen <jarkko@kernel.org>,
        Roberto Sassu
	 <roberto.sassu@huaweicloud.com>,
        linux-integrity@vger.kernel.org
Cc: James.Bottomley@HansenPartnership.com, roberto.sassu@huawei.com,
        mapengyu@gmail.com, David Howells <dhowells@redhat.com>,
        Paul Moore
 <paul@paul-moore.com>, James Morris <jmorris@namei.org>,
        "Serge E. Hallyn"
 <serge@hallyn.com>, Peter Huewe <peterhuewe@gmx.de>,
        Jason Gunthorpe
 <jgg@ziepe.ca>, keyrings@vger.kernel.org,
        linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Mon, 14 Oct 2024 07:45:57 -0400
In-Reply-To: <e70c55c6edea2a5be7786ee04a85778193237444.camel@kernel.org>
References: <20240921120811.1264985-1-jarkko@kernel.org>
	 <f69e08167d8354db31013018edf064a2876f8d1c.camel@kernel.org>
	 <21b46f4882f0b9b12304d7786bd88f33a7ad2b97.camel@huaweicloud.com>
	 <a0068539450a81fdd363d078521cb3822c54608b.camel@kernel.org>
	 <e70c55c6edea2a5be7786ee04a85778193237444.camel@kernel.org>
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
X-Proofpoint-ORIG-GUID: rYrsrcYGDrxAJtbTIwXVtk0T6VlTXmWv
X-Proofpoint-GUID: Yej-s5UB3gYcINthSPFZKN81Sf6sAPvl
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-14_10,2024-10-11_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 suspectscore=0
 phishscore=0 mlxscore=0 bulkscore=0 priorityscore=1501 mlxlogscore=999
 spamscore=0 lowpriorityscore=0 clxscore=1015 adultscore=0 impostorscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2409260000
 definitions=main-2410140083

On Sat, 2024-10-12 at 13:56 +0300, Jarkko Sakkinen wrote:
> On Fri, 2024-10-11 at 19:25 +0300, Jarkko Sakkinen wrote:
> > On Fri, 2024-10-11 at 18:10 +0200, Roberto Sassu wrote:
> > > Initially, I thought that maybe it would not be good to have an
> > > event
> > > log with unmodified and altered measurement entries. Then, I tried
> > > to
> > > think if we can really prevent an active interposer from injecting
> > > arbitrary PCR extends and pretending that those events actually
> > > happened.
> > >=20
> > > If I understood James's cover letter correctly, the kernel can
> > > detect
> > > whether a TPM reset occurred, but not that a PCR extend occurred
> > > (maybe
> > > with a shadow PCR?).
> >=20
> > We can detect TPM reset indirectly. I.e. null seed re-randomizes
> > per reset.
> >=20
> > >=20
> > > Second point, do we really want to take the responsibility to
> > > disable
> > > the protection on behalf of users? Maybe a better choice is to let
> > > them
> > > consciously disable HMAC protection.
> >=20
> > So when IMA is not used already with these fixes we get good
> > results. And for tpm2_get_random() we can make the algorithm
> > smarter. All in all we have good path ongoing for "desktop
> > use case" that I would keep thing way there are or at least
> > postpone any major decisions just a bit.
> >=20
> > For server/IMA use case I'll add a boot parameter it can be
> > either on or off by default, I will state that in the commit
> > message and we'll go from there.

Sounds good.

>=20
> Up until legit fixes are place distributors can easily disable
> the feature. It would be worse if TCG_TPM2_HMAC did not exist.
>=20
> So I think it is better to focus on doing right things right,
> since the feature itself is useful objectively, and make sure
> that those fixes bring the wanted results.

Are you backtracking on having a boot parameter here specifically to turn o=
n/off
HMAC encryption for IMA?

Mimi


