Return-Path: <linux-integrity+bounces-6024-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D4708A9B8DA
	for <lists+linux-integrity@lfdr.de>; Thu, 24 Apr 2025 22:11:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1D7D8925F2B
	for <lists+linux-integrity@lfdr.de>; Thu, 24 Apr 2025 20:11:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8CE671F8730;
	Thu, 24 Apr 2025 20:11:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="BwKJEP6n"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D119B1F4612
	for <linux-integrity@vger.kernel.org>; Thu, 24 Apr 2025 20:11:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745525499; cv=none; b=dz4Can2CSdYSRLIl7uD2XUOfNjLD37BoJSrDP4CnwVD9ZZJvzZGZllsD7k+xHZ2ZRj6Trv/P6ibcNZTjAKGG4lXND1KDayth3BZHpXNAzEAwjIRrjqd+IYXCcvI5gYpSP/nzyuwGNHUdFtvOO+eiad74picj7rBKQo4wi8pdHwc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745525499; c=relaxed/simple;
	bh=Wng3B2uxm1o/KTkviVFVpA4/SE487Rmo/2wIfNscXos=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=oy0szr8eKTpk7i7m1qLQFFw7tK9/ULcZt9XquTTPUojq1JmNc+n5pSGsv9gQQBXP9PNgHABxGi6TJvyN7ByLazHhB5PB1P5kMlxEGGrCIcMXFLo2jTOl/ySMai/QgfK3dgFAmrhNOZ+4apwB/I08VrjIJ8Uc5oQlWZwsVF8xKhI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=BwKJEP6n; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53OIuoV1007626
	for <linux-integrity@vger.kernel.org>; Thu, 24 Apr 2025 20:11:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=
	content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=MODK7x
	IctbzQY06rUIAT6USZTi4n8nYnPZD7Wj/Ivac=; b=BwKJEP6nTPKikBW6MO2Nd6
	lsl2NGMCZL7i/8ZLzI8a1ts+t+U2ZSuXUPLz1EftP6/jooCNNjJAb6WX4Xth4y2W
	mfuGc8ARPpvqCul46u9zaXkOmZLucZSwkw/9tngnoys98TfvBHZmCB4FU6n1dPaT
	QZE4bIVSrcyIofhzZkN0gEWaqT8Eb/N+S55Ba2khK375p/636mxz34h8B8EgI1ED
	jnJ2nqNlc/PaXBe99PJoc4WFCCWFNXVwXdWF7+jGyxCCNLF94nDJcTmbdHIi2cMB
	icLZwRT7U2jx4y6yUgRA0btzhLKKBjjwqMZh0tRzIoiSlPt3Lyt5SyRwanZqAvjg
	==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 467a60w7ye-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-integrity@vger.kernel.org>; Thu, 24 Apr 2025 20:11:36 +0000 (GMT)
Received: from m0353725.ppops.net (m0353725.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 53OKAUfq017416
	for <linux-integrity@vger.kernel.org>; Thu, 24 Apr 2025 20:11:35 GMT
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 467a60w7yc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 24 Apr 2025 20:11:35 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 53OJCfTK005844;
	Thu, 24 Apr 2025 20:11:35 GMT
Received: from smtprelay05.dal12v.mail.ibm.com ([172.16.1.7])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 466jfxhy5d-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 24 Apr 2025 20:11:35 +0000
Received: from smtpav01.dal12v.mail.ibm.com (smtpav01.dal12v.mail.ibm.com [10.241.53.100])
	by smtprelay05.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 53OKBYj023790278
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 24 Apr 2025 20:11:34 GMT
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 82C9058058;
	Thu, 24 Apr 2025 20:11:34 +0000 (GMT)
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 558A458057;
	Thu, 24 Apr 2025 20:11:34 +0000 (GMT)
Received: from li-43857255-d5e6-4659-90f1-fc5cee4750ad.ibm.com (unknown [9.31.96.173])
	by smtpav01.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 24 Apr 2025 20:11:34 +0000 (GMT)
Message-ID: <fb35292f38d75d4a9f3360e17c7176cf2d1a6484.camel@linux.ibm.com>
Subject: Re: evmctl hmac fails in setxattr even in version 1.6.2
From: Mimi Zohar <zohar@linux.ibm.com>
To: Lev Olshvang <levonshe@yandex.com>,
        "linux-integrity@vger.kernel.org"
	 <linux-integrity@vger.kernel.org>
Date: Thu, 24 Apr 2025 16:11:34 -0400
In-Reply-To: <5ac2d162-a9f2-44db-a2be-c69602d14b17@yandex.com>
References: <5ac2d162-a9f2-44db-a2be-c69602d14b17@yandex.com>
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
X-Authority-Analysis: v=2.4 cv=Q47S452a c=1 sm=1 tr=0 ts=680a9af8 cx=c_pps a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17 a=IkcTkHD0fZMA:10 a=XR8D0OoHHMoA:10 a=FSAMPwj4SNor4FMueUoA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: N1iJM345hWi824aihvkH8O0U4QY5EDeY
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNDI0MDE0MSBTYWx0ZWRfX0aMf745wvQfu GnANK69DIuGfZ3sfn5PIo4fGkUNhLiCLj/4POyc4301XngaIW0vDHzVViXBIuF5S0xCzlcVFYmO hqj6Qgrq6OCCx6RumoRMfSlV6GktytQeMgQyl1E9eV7hSm5G/NxrRtitRBkfn7/zLWzYOsBd8d6
 YH0uIGAkUEfe6L0YZzCyCkpylB54K0Dcyb6/nDL36uOXS2Z1Ajk4xJh+QOyvCNAUbs44jyWoB1A NURtZFn0X1A9uqtw8mZTikd/xuwvnLvfNcVjvRSzzgzaU/QfcVlPTLseB2or1FDzMstJSWwf4bM UlFoATyH3gnJqFDksk0HTm2mDeeBc2a1w1esQJSVXOb6J7WhFfulXTDJ2DWJHqxdsoKkIdYCo0+
 L28tDKiEcAxq0ppzC4YJAWoKq9/gsnr0tje8ubxzrdSQkqHpD948sNfqij1DBswTzbThYOWH
X-Proofpoint-ORIG-GUID: rFu6TXv6TDp0imAYfNK83PK_fCp6B_aa
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-04-24_09,2025-04-24_02,2025-02-21_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 malwarescore=0
 impostorscore=0 adultscore=0 mlxscore=0 bulkscore=0 priorityscore=1501
 lowpriorityscore=0 spamscore=0 suspectscore=0 mlxlogscore=999 phishscore=0
 classifier=spam authscore=0 authtc=n/a authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2504070000
 definitions=main-2504240141

On Thu, 2025-04-24 at 20:29 +0300, Lev Olshvang wrote:
> Hi List,
>=20
> I work on a ARM64 ubuntu 22 system, with installed
> ima-evm-utils=C2=A0=C2=A0 1.1-0ubuntu2
>=20
>=20
> I succedeed in implementing IMA and now I want to add EMV hmac=20
> functionality.
>=20
> I booted kernel command line=C2=A0=C2=A0 "ima=3Don ima_appraise=3Dlog"
>=20
> Then I made _evm keyring and added kmk and emv keys:
> EVM_KR=3D`keyctl newring _evm @u`
> keyctl add user kmk "$(dd if=3D/dev/urandom bs=3D1 count=3D32 2> /dev/nul=
l)" @u
> keyctl add encrypted evm-key "new user:kmk 64" $EVM_KR
> keyctl shows
>  =C2=A0711205770 ----s-rv=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 0=C2=A0=C2=A0=C2=
=A0=C2=A0 0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 \_ keyring: _ima
> 1066122475 --als--v=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 0=C2=A0=C2=A0=C2=A0=C2=
=A0 0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0 \_ asymmetric: mra:=
=20
> adm_signing key: 9375cf2445606beba28208741540ad1897d59051
>  =C2=A0315058417 --alswrv=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 0=C2=A0=C2=A0=C2=
=A0=C2=A0 0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 \_ keyring: _evm
>  =C2=A0685369470 --alswrv=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 0=C2=A0=C2=A0=C2=
=A0=C2=A0 0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0 \_ encrypted:=
 evm-key
>  =C2=A0 35009219 --alswrv=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 0=C2=A0=C2=A0=C2=
=A0=C2=A0 0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 \_ user: kmk
>=20
>=20
> But evmctl hmac command returns error:
> evmctl hmac /etc/init.d/netconsole
> setxattr failed: /etc/init.d/netconsole
> errno: Operation not permitted (1)
>=20
>=20
>=20
> I cloned ima-evmctl and compiled version 1.6.2 for x86_64, same ubuntu ,
> I got same result
> sudo /usr/local/bin/evmctl -d hmac --hmackey /etc/keys/plain.txt=20
> ../IMA_EVM/DEMO
> hash(sha256):=20
> 0404a6cffb233ebd759555c7070d9985961bbd1d3007e7c8d9cba5e9c5c28496c51f
> Reading to /etc/keys/plain.txt
> generation: 3093355876
> no xattr: security.selinux
> no xattr: security.SMACK64
> no xattr: security.apparmor
> name: security.ima, size: 34
> no xattr: security.capability
> uuid: 069df3798ff14641a6e0f1db2b852380
> hmac: 9df5db81cf089c22c4c128070c36827d7983284f
> Setting EVM hmac xattr failed: ../IMA_EVM/DEMO=C2=A0 (errno: Operation no=
t=20
> permitted)
>=20
>=20
> It must be something trivial, please help

Correct the EVM HMAC cannot be written directly, only the EVM portable sign=
ature
can be written directly.  EVM verifies the existing security.evm before all=
owing
it to be updated.  In EVM "fix" mode the existing EVM verification status i=
s
ignored.

To label the filesystem, boot with the "evm=3Dfix" boot command line option=
, after
loading the EVM HMAC key (trusted key), walk the filesystem opening each fi=
le.=20
This will calculate and write out the EVM HMAC.  Refer to the ima-evm-utils
README.

Mimi

