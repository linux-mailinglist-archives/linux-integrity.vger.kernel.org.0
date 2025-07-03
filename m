Return-Path: <linux-integrity+bounces-6604-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3297FAF7200
	for <lists+linux-integrity@lfdr.de>; Thu,  3 Jul 2025 13:24:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 59C027A5F9B
	for <lists+linux-integrity@lfdr.de>; Thu,  3 Jul 2025 11:22:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 279AE2E3B16;
	Thu,  3 Jul 2025 11:23:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="FLua1SpB"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56B082E3AFF;
	Thu,  3 Jul 2025 11:23:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751541826; cv=none; b=NzjX2yy/VJrWdgzL9/ZApDFFkUl/IAVcrue9sQRKL0arxOGnva85my+fCJakiOYyn42Taz0xNHtnZZacLaWWmD/KfWYkok/qrFDgPR5Yimfw+e0eTAKL9vB+DbhH7jejKRdYbTVcFO9C8/mTUSP9GY1GymZwZuEXqqn93JsEVPU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751541826; c=relaxed/simple;
	bh=oLOZlkz4/kMnU9rgSW96ifr6RqN12imGk9bUzWGFcuU=;
	h=Message-ID:Subject:From:To:Cc:In-Reply-To:References:Content-Type:
	 Date:MIME-Version; b=NpcKrbmo5Er+pgAUsRmkihASYAJxy5YfQYBQCMmbhRx4u/IvOjp3QiQ8bZI94kzVIY+xuiaEOo5IzXcA2ZzvqvCGEgYRqXJwNPerMijvcKOZwVOvrTCKtic1ndIS2seMpA9h2cilJprtgzKDtoFWoAStk4D0pdUQ+H+c/JLCvsc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=FLua1SpB; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56307CLS009905;
	Thu, 3 Jul 2025 11:23:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=4emJw4
	ErehVOKAjtCy8M8j74Pv47NHFVJ+00dCO9c8g=; b=FLua1SpBxBfqAYVTSreT6f
	SVKfMdpkHUd1jIeU0LcbAKHhzNRLOcVsJQBsmb5LRdrAMu++uvjdI2HXrbbJs1Ix
	0C5TjBsV7FMJmdDfRvYbSfhtXA0RfkpXPNIe+mtk4TglE0gZC567BGj5b8ahrqEv
	pzmn4iggUrr79ycaSBCXCOTo2cVggXGCvuhYBA3GKPJj5JjKjovIf9DuOJQ5nwuN
	oF3ZSRlpl/QV3YzdOBb5jmsl0qT6hpICkUyaejrij0spaBSpezkgZiAx7rYVJ/k8
	3/nh8FNcF3zr7saIjPiK+rAniGmYYvozsznSZgTkWhvXvt/k5OOjNnv+W/vD3Y2g
	==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 47j5ttk553-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 03 Jul 2025 11:23:26 +0000 (GMT)
Received: from m0356516.ppops.net (m0356516.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 563BHdQd025413;
	Thu, 3 Jul 2025 11:23:26 GMT
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 47j5ttk551-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 03 Jul 2025 11:23:26 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 563AmEmC011873;
	Thu, 3 Jul 2025 11:23:25 GMT
Received: from smtprelay02.dal12v.mail.ibm.com ([172.16.1.4])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 47jv7n4ex4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 03 Jul 2025 11:23:25 +0000
Received: from smtpav05.wdc07v.mail.ibm.com (smtpav05.wdc07v.mail.ibm.com [10.39.53.232])
	by smtprelay02.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 563BNOQS28115516
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 3 Jul 2025 11:23:24 GMT
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 6FB2558043;
	Thu,  3 Jul 2025 11:23:24 +0000 (GMT)
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 18DA858061;
	Thu,  3 Jul 2025 11:23:23 +0000 (GMT)
Received: from li-43857255-d5e6-4659-90f1-fc5cee4750ad.ibm.com (unknown [9.61.102.16])
	by smtpav05.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Thu,  3 Jul 2025 11:23:22 +0000 (GMT)
Message-ID: <8401c23009db3b8447b0b06710b37b1585a081ab.camel@linux.ibm.com>
Subject: Re: [PATCH] Revert "integrity: Do not load MOK and MOKx when
 secure boot be disabled"
From: Mimi Zohar <zohar@linux.ibm.com>
To: Lennart Poettering <mzxreary@0pointer.de>
Cc: Jarkko Sakkinen <jarkko@kernel.org>,
        Roberto Sassu	
 <roberto.sassu@huawei.com>,
        Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
        Eric Snowberg <eric.snowberg@oracle.com>,
        Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>,
        "Serge E. Hallyn"	 <serge@hallyn.com>, linux-integrity@vger.kernel.org,
        keyrings@vger.kernel.org, linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        "Lee,
 Chun-Yi" <joeyli.kernel@gmail.com>
In-Reply-To: <aGYurikYK1ManAp3@gardel-login>
References: <Z9wDxeRQPhTi1EIS@gardel-login>
	 <1a6cf2097487816e4b93890ad760f18fe750bd70.camel@linux.ibm.com>
	 <aGYurikYK1ManAp3@gardel-login>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Date: Thu, 03 Jul 2025 07:23:22 -0400
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Evolution 3.54.3 (3.54.3-1.fc41) 
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: HZ8B1dRlKfYZ0lNGt2l8fRKVvedpbDAT
X-Authority-Analysis: v=2.4 cv=UtNjN/wB c=1 sm=1 tr=0 ts=6866682e cx=c_pps a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=VnNF1IyMAAAA:8 a=JnBA2F1U-474F7nXX6wA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: d21f4K65zcBRJYncthFVJkaJrlCK98v8
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzAzMDA5MyBTYWx0ZWRfXz9kgAsO/VuU/ QlEYHcaC7527+wF/Gjc7B7bcEuYcXOswmwfVT/uppKPb3b9CFXOyBic0T9k07+xPC3VMZ+mc6sz YDiJVF/V4nrlQRssFQZprr1L5WGCaDgMedCc7MyR1l7owP+TGZkaw38zqzL/aLReMzF/NWXDKtT
 BZCiS1RVZj5Lsg+/Azk+y0LJXI/tc8rih+GlkV2K3wyzJgXwNa5lkyFH9BgTFlQXSfIeUgWOOGz jdRK36T9AYAtec1FdZKbw/3QBfGeyunzx8FYz1ko7UOl/DTxXMEJNmGnwDszNxAYibooEZiQn6Y 2FVyjGsN8PFDC9sSKkO/5ihyZeGPE8+sAvVP3SWkNz/SgBs6Ph8sCujQmXUOtsE4ts5o4v4b7DJ
 lMcqHSSOGnqaxDHPTdU9O9Sc93eC9dAq/jPnS+tmAgsUHny+EqwT/K3K6EtP8jRCggNRvxTA
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-03_03,2025-07-02_04,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0
 priorityscore=1501 phishscore=0 mlxscore=0 spamscore=0 mlxlogscore=999
 adultscore=0 clxscore=1015 lowpriorityscore=0 bulkscore=0 impostorscore=0
 malwarescore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2507030093

On Thu, 2025-07-03 at 09:18 +0200, Lennart Poettering wrote:
> On Mi, 02.07.25 21:40, Mimi Zohar (zohar@linux.ibm.com) wrote:
>=20
> > On Thu, 2025-03-20 at 13:02 +0100, Lennart Poettering wrote:
> > > This reverts commit 92ad19559ea9a8ec6f158480934ae26ebfe2c14f.
> > >=20
> > > This original commit this reverts creates a strange situation: it
> > > ensures more restrictive behaviour if SecureBoot is off then when it
> > > is on, which is the opposite of what one would expect.
> > >=20
> > > Typically, one would expect that if SB is off the validation of
> > > resources during the pre-kernel and kernel initialization is less
> > > restrictive, not more restrictive. But this check turned the world on
> > > its head.
> >=20
> > Hi Lennart,
> >=20
> > I'm really sorry for the long delay ...
> >=20
> > > From an IMA perspective, the default is to only trust keys built into=
 the kernel
> > or certificates signed by the builtin keys and loaded onto the
> > .secondary_trusted_keys keyring.
> >=20
> > The ability of loading MOK keys onto the .machine keyring and linked to=
 the
> > .secondary_trusted_keys keyring is an exception based on the assumption=
 that
> > that there is a secure boot chain of trust.  Allowing untrusted keys on=
to or
> > linked to the .secondary_trusted_keys keyring, would potentially allow =
loading
> > code signing keys onto the IMA keyring signed by untrusted MOK keys.
> >=20
> > I was really hesitant to allow this exception of loading MOK keys onto =
the
> > .machine keyring in the first place.  I'm now even more concerned.
> >=20
> > This is not just an issue of being more or less restrictive, but of add=
ing a new
> > integrity gap when one didn't exist previously.
>=20
> But we are talking of the case here where SecureBoot is *off*,

Exactly, so there is no trust in any keys other than those built into the
kernel. True that is of course dependent on trusting the kernel.  In the ca=
se of
MOK, trusting additional keys requires at minimum a "safe" secure boot
environment and other things to prevent its abuse.

> i.e. there is a concious decision in place that there is no trust
> chain, and that the firmware *happily* *already* accepts unsigned boot
> loaders/kernels and just runs with them. If SecureBoot is already off,
> then an attacker can patch around in the kernel invoked at boot
> completely freely anyway, there is *no* authentication done. Hence
> it's really weird to then insist that the path into the kernel keyring
> via mok keys is off in *only* this case, because an attacker can get
> into that anyway in this case, it's just a lot more cumbersome.
>=20
> It's really strange that currently when people ask for tight security
> (i.e. SB on) the linux kernel is super relaxed and allows any keys to
> be inserted, but if people ask for security checks to be off (i.e. SB
> off) the kernel starts being super strict and doesn't allow any keys
> to propagate into mok. That's really confusing and contradictory, no?

That all may be true, but you're ignoring what I said about only "trusting"=
 MOK
in certain situations.  If you have another safer, better mechanism for
establishing a new root of trust for keys (e.g. TPM), then by all means sha=
re it
and we can make additional exceptions.

Mimi

