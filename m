Return-Path: <linux-integrity+bounces-3815-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B07199F7DE
	for <lists+linux-integrity@lfdr.de>; Tue, 15 Oct 2024 22:09:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D69311F21C24
	for <lists+linux-integrity@lfdr.de>; Tue, 15 Oct 2024 20:09:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4447E1F583C;
	Tue, 15 Oct 2024 20:09:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="UNfs8g3h"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 823F51B3936;
	Tue, 15 Oct 2024 20:08:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729022940; cv=none; b=Gtv9mBF7wJDkTC4OOoYuz9VFK1a1WxF3N72nBI+ZaSkfw2musPBXqPGdNRzdy7oJSbf3zj4EiHJlv3XEcMQ/HWyg4k1l5xNw3l0LZVrNKn8qg2tDojdwo4cHZpSBEXHXmQ1G7cK/DeTikAECzdid/S4uVaNx8G3WBtbjrRgxDBQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729022940; c=relaxed/simple;
	bh=j2OJ4nJ22YAGX1EN1Ws9619MuiTw8/GcQUNttC73stc=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=pWndNrWop9YuUzDfXLo0gKyMQard1QsCRW+dZSQNNb5KVjCCEJV/vwIzBfE1ebgQ4gqEUzoRbWMxKSNKawQI/YEH9CDJ7BwtU7gO3bcZKE+7g+QpiSHraJlBWtVHyKkFMkj4nC07rF8Ie5lR5ZuNa+FChg9hvVSNt2aJWmcjLRA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=UNfs8g3h; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49FJuBhD002725;
	Tue, 15 Oct 2024 20:08:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=69L/af
	3IKivmKEyI/Ji8fL2xhTF/EYJNbW9XFUPCA2Q=; b=UNfs8g3hi7tf/L+cDxN+IV
	E6mgZzQ7BANlXNe2isaXxE4G4VApivQAH0fDC10cYAIF4JEWIvBjQ1H7g5VJYRh9
	r5vU69++lQRkTRsbqlZ1IES+XfqHoGg/NUbaYrHx1rbvrPH/twGd4AjyxDBn+IIk
	aI3eY7yPMksw4idZj1hsUGyeNxmeEA/bSXTNvrXaUH5jiWKDkSO+WZp845cFbz0Z
	sSNfUn3QiwM4Sx2WOta6cmJ08hCsYUFa3ln/mJcoq8mNxWpOU/CExCinL2p5qb8X
	W7FrLtAr8fNqI4n5T7RR4PdrU0+MUu8/8Y0Okw/XybVhDSRdU03ec/oTG7LY7b5Q
	==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 429xywr1rg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 15 Oct 2024 20:08:30 +0000 (GMT)
Received: from m0360072.ppops.net (m0360072.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 49FK8TK7028463;
	Tue, 15 Oct 2024 20:08:30 GMT
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 429xywr1ra-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 15 Oct 2024 20:08:29 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 49FJC56T005930;
	Tue, 15 Oct 2024 20:08:29 GMT
Received: from smtprelay03.dal12v.mail.ibm.com ([172.16.1.5])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 428650wd5u-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 15 Oct 2024 20:08:29 +0000
Received: from smtpav01.dal12v.mail.ibm.com (smtpav01.dal12v.mail.ibm.com [10.241.53.100])
	by smtprelay03.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 49FK8SQi48562460
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 15 Oct 2024 20:08:28 GMT
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A2B2B58059;
	Tue, 15 Oct 2024 20:08:28 +0000 (GMT)
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D8AD558058;
	Tue, 15 Oct 2024 20:08:27 +0000 (GMT)
Received: from li-43857255-d5e6-4659-90f1-fc5cee4750ad.ibm.com (unknown [9.61.187.172])
	by smtpav01.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 15 Oct 2024 20:08:27 +0000 (GMT)
Message-ID: <036746bc4e37ff10a18b5fdffd6fdee561dd5bfe.camel@linux.ibm.com>
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
Date: Tue, 15 Oct 2024 16:08:27 -0400
In-Reply-To: <64710fe1db1432ca8857ec83fff4809ab1550137.camel@kernel.org>
References: <20240921120811.1264985-1-jarkko@kernel.org>
	 <f69e08167d8354db31013018edf064a2876f8d1c.camel@kernel.org>
	 <21b46f4882f0b9b12304d7786bd88f33a7ad2b97.camel@huaweicloud.com>
	 <a0068539450a81fdd363d078521cb3822c54608b.camel@kernel.org>
	 <e70c55c6edea2a5be7786ee04a85778193237444.camel@kernel.org>
	 <04dc04872f2925166f969b43852161d468ee899a.camel@linux.ibm.com>
	 <64710fe1db1432ca8857ec83fff4809ab1550137.camel@kernel.org>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.52.4 (3.52.4-1.fc40) 
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: vEnh6mst_1x2h32pBMI1SmYyzJM4-QtK
X-Proofpoint-GUID: SXjOjMcLJvo3WHzLFeaengjc6HSy-qJw
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-15_01,2024-10-11_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 bulkscore=0
 spamscore=0 priorityscore=1501 phishscore=0 adultscore=0 mlxlogscore=999
 lowpriorityscore=0 clxscore=1015 impostorscore=0 mlxscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2409260000
 definitions=main-2410150135

On Mon, 2024-10-14 at 15:34 +0300, Jarkko Sakkinen wrote:
> On Mon, 2024-10-14 at 07:45 -0400, Mimi Zohar wrote:
> > > > For server/IMA use case I'll add a boot parameter it can be
> > > > either on or off by default, I will state that in the commit
> > > > message and we'll go from there.
> >=20
> > Sounds good.
>=20
> But only after this patch set lands. I gave this a thought and since
> this patch set is specifically for a specific Bugzilla bug that it
> closes, I have no interest to increase its scope.

Prior to your performance improvement patch set it took >10 minutes to boot,
when it succeeded booting.  Now on Fedora 40 with "ima_policy=3Dtcb" on the=
 boot
command line, it's taking ~3 minutes to boot.  Do you really think that is
acceptable?!

> >=20
> > >=20
> > > Up until legit fixes are place distributors can easily disable
> > > the feature. It would be worse if TCG_TPM2_HMAC did not exist.
> > >=20
> > > So I think it is better to focus on doing right things right,
> > > since the feature itself is useful objectively, and make sure
> > > that those fixes bring the wanted results.

The right thing would have been to listen to my concerns when this was init=
ially
being discussed.  The right thing wasn't enabling TCG_TPM2_HMAC by default.

> >=20
> > Are you backtracking on having a boot parameter here specifically to
> > turn on/off
> > HMAC encryption for IMA?
>=20
> I'm not really sure yet but obviously any change goes through review.
>=20
> Also fastest route is to send your own RFC's to IMA specific issue.
> For me it will take some time (post this patch set).

Done.  The patch applies cleanly with/without the TPM performance improveme=
nt
patch set.
https://lore.kernel.org/linux-integrity/20241015193916.59964-1-zohar@linux.=
ibm.com/

Mimi

