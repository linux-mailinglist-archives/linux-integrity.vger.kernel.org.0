Return-Path: <linux-integrity+bounces-7062-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 003B6B54F6B
	for <lists+linux-integrity@lfdr.de>; Fri, 12 Sep 2025 15:24:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1EBCEA03B3A
	for <lists+linux-integrity@lfdr.de>; Fri, 12 Sep 2025 13:24:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 988BC304BB3;
	Fri, 12 Sep 2025 13:23:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="bKnqVQJE"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06E40276056;
	Fri, 12 Sep 2025 13:23:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757683437; cv=none; b=tt3CmUyv2XkaPQYHUdXpwXsS1miPbYGMRdASMJr46KQTqMto7xPV4r9f40UzMhzgh/idy5IMQRRfzrrvbgvoY7ucrwXpjHw8mjbjIDlSM9xcXQZeFXcYQcT6Et0J6fF+cHqwFQyC4olqC7w5tef41UR1xvhwYpz5PaQKxftJFmU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757683437; c=relaxed/simple;
	bh=Gz3TC4qWdHERRHYAN66vUbTcYtrmsFGE2lN/5tUmmFc=;
	h=Message-ID:Subject:From:To:Cc:In-Reply-To:References:Content-Type:
	 Date:MIME-Version; b=e8rWMg8PMaxJIt9A/7UBZqna5Ldx0s1JnOpL/BIlWCIkZwOArhiKYrmuDdqfBB9errYYyl5hnq+QgSKl/XRnaIqvWNFJgziD0FKg2WkVFpXyIEk5KOpxC7TKun21RY63WnH3hhz3wV+gAUWa81uPzJ3xoCDrKNetgXIC94o5hHE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=bKnqVQJE; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58C95ttR019558;
	Fri, 12 Sep 2025 13:23:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=P+r1sr
	Tm6O90zQE5Lj5ytglMLspvyewQLU5BjeCuJ94=; b=bKnqVQJEn3sqZAW1MUGqz6
	esZ8LV3I0WdWf5u3UGEsO+ncdYlMz6VL+hAKNfIBB/nu4XLgTHLtqn2MUvjNAXz6
	swQTqfmAH85B6C9P/BHPfox9pyySydNPG4fmBk/9EvAd4A4+yDV3vZQ+/0gl0FYH
	smKQjadwUXStKo0E2y2QaJk4Jai2/1X81CcOmBMy6kAi/2mcytmtCGrmespMf/so
	FPm1NfcBfnYfc8vQC4N4DcKBWXMSQuix33fSycDUvR9ucmihHBl2DSdf7lYykETm
	b/xgyvKwB4vgfGPIJOx11iGq5GsZ2KLL/DAhLluM5N/cbWPx0VwoVueFGr2f+lwQ
	==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 490cmxbry5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 12 Sep 2025 13:23:48 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 58CBSePp001198;
	Fri, 12 Sep 2025 13:23:47 GMT
Received: from smtprelay01.wdc07v.mail.ibm.com ([172.16.1.68])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 491203tvu8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 12 Sep 2025 13:23:47 +0000
Received: from smtpav03.wdc07v.mail.ibm.com (smtpav03.wdc07v.mail.ibm.com [10.39.53.230])
	by smtprelay01.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 58CDNlu723593358
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 12 Sep 2025 13:23:47 GMT
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id EE5B85805C;
	Fri, 12 Sep 2025 13:23:46 +0000 (GMT)
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 3FC275805A;
	Fri, 12 Sep 2025 13:23:46 +0000 (GMT)
Received: from li-43857255-d5e6-4659-90f1-fc5cee4750ad.ibm.com (unknown [9.61.85.212])
	by smtpav03.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 12 Sep 2025 13:23:46 +0000 (GMT)
Message-ID: <b8723148a39083cab0b43f9c7fa5ce18d696f99d.camel@linux.ibm.com>
Subject: Re: [PATCH 2/2] ima_{conditionals,policy}: Handle policy required
 to be signed
From: Mimi Zohar <zohar@linux.ibm.com>
To: Petr Vorel <pvorel@suse.cz>, ltp@lists.linux.it
Cc: linux-integrity@vger.kernel.org, selinux@vger.kernel.org,
        Cyril Hrubis
	 <chrubis@suse.cz>, Coiby Xu <coxu@redhat.com>
In-Reply-To: <20250912073210.47637-3-pvorel@suse.cz>
References: <20250912073210.47637-1-pvorel@suse.cz>
	 <20250912073210.47637-3-pvorel@suse.cz>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Date: Fri, 12 Sep 2025 09:23:45 -0400
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Evolution 3.54.3 (3.54.3-1.fc41) 
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 4wQ-mtovDtlCsEnLyg7hB-ORtz0CBemg
X-Proofpoint-ORIG-GUID: 4wQ-mtovDtlCsEnLyg7hB-ORtz0CBemg
X-Authority-Analysis: v=2.4 cv=J52q7BnS c=1 sm=1 tr=0 ts=68c41ee4 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=VwQbUJbxAAAA:8 a=eT_AGdNYAAAA:8
 a=VnNF1IyMAAAA:8 a=N_e08WI2rTb28WxUWdcA:9 a=QEXdDO2ut3YA:10
 a=cQHuB3lTkaQsuJFJLY--:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTA2MDAyNSBTYWx0ZWRfX+bVhwvhva/tT
 Yd9YTLYlotruv+9DC49WvDa/bshR3S2lOkMZGcKd2ICx5WodFZEhhyU37v12yb6HLmF3T77Lma5
 Eoi9Wk+LMUSFWJjMhrRkyjs70c3jxgSbUKiZEWMiKCjMeqZMJ3GIEpSvIlh01K8DHEMNRXiybEv
 Cg+jb/M4uz5QBGvEk6OsSeH4B7aV/7aluMPnN3LxFtYdRWoohHoePiwd3b9bWRwdGKU5XpamxRu
 5AOP08xaDvNSAGd1DpnXPy2lqwhsJuseGHegoB+1oiazu2oq6qi/cIJnn3hPotbxjpVy5XUhw05
 byrgdLSWR9sE6zv/yrUoorpzccMkiazo46wrX4Qd80fAoqxCIcsSMslJmKQ1iTbl8svupMnvLZL
 ZjwPurK1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-12_04,2025-09-11_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 clxscore=1015 suspectscore=0 spamscore=0 phishscore=0
 bulkscore=0 adultscore=0 malwarescore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2509060025

On Fri, 2025-09-12 at 09:32 +0200, Petr Vorel wrote:
> Since kernel 6.6 policy needs to be signed on enabled UEFI secure boot.
> Skip testing in that case.
>=20
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit=
/?id=3D56dc986a6b20b
>=20
> This fixes errors:
>=20
>     ima_policy 2 TINFO: verify that policy file is not opened concurrentl=
y and able to loaded multiple times
>     ima_policy 2 TFAIL: problem loading or extending policy (may require =
policy to be signed)
>     https://openqa.suse.de/tests/18723792#step/ima_conditionals/6
>=20
>     ima_conditionals 1 TINFO: verify measuring user files when requested =
via uid
>     echo: write error: Permission denied
>     ima_conditionals 1 TBROK: echo measure uid=3D65534 > /sys/kernel/secu=
rity/ima/policy failed
>=20
> Ideally there would be test which check that unsigned policy cannot be
> written.
>=20
> Signed-off-by: Petr Vorel <pvorel@suse.cz>

Thanks, Petr.

Reviewed-by: Mimi Zohar <zohar@linux.ibm.com>

At some point, consider adding support for signing policy rules, if the
private/public keypair is provided.


Mimi

