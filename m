Return-Path: <linux-integrity+bounces-7037-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CE90B49CDB
	for <lists+linux-integrity@lfdr.de>; Tue,  9 Sep 2025 00:35:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 27FF53B7BEB
	for <lists+linux-integrity@lfdr.de>; Mon,  8 Sep 2025 22:35:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB30F2EB857;
	Mon,  8 Sep 2025 22:34:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="pKH8yNZi"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DE6820C001;
	Mon,  8 Sep 2025 22:34:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757370897; cv=none; b=T5WQjcKzQNS6WBv1uhWV1Gj/TtnaZkQcjf9TFrSJAS53GX6ASG+Pe6T6yfXTrshzXALRvwSwbjy5FQxEQgZHYzT34Xgy5ycashqbZhrfy3fMLUdCkfYcz7whtCq8/SHd37bWeOpKr06wtFKb7SVlr7HscBHVWfC5qGiGU1tWxzM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757370897; c=relaxed/simple;
	bh=0iOHoMYcBRxtkfhPXNi4R6H5QoB1LN5Y1Ef+9cZ77jQ=;
	h=Message-ID:Subject:From:To:Cc:In-Reply-To:References:Content-Type:
	 Date:MIME-Version; b=nJ84vekutH9/6V5WvmQ4bqYPHICM8ys/5Xbk78e1tTTXiz3jqtCXxct1tieAhYIodf42a0ER7AO13DFHeDV+yGcgDDTwHOlsgxB/3pK40MyFAKlwWugBZo+LPPLzLXeZ4qd6hJyZYqC3ImHds6BNZW/HBGQ/I0GqdS3R5C8PK7k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=pKH8yNZi; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 588CvQSt010054;
	Mon, 8 Sep 2025 22:33:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=FBfcfR
	JWlp10bUf85Vy10b5YNSv6VPq9D4msUXzmtsU=; b=pKH8yNZiHZxor5JISI+3Xc
	7FKtrYfoUuXzfk09DBjbCHeY7RI9dMqiBGW03+gG9tOoqSPGmngu4W7tiM1AOkv1
	C+zvqC2zqVKi5tC2jeVWge0XA9/9SMrcEGra5BVs5MefW+4JL6JDtZpc5JU4k3kH
	/dLdeFWxBR5Pc3pIBYeRfmDMMjaAGsbIoHl+6LSHjD/2Wczd0WPDeFZUyfMNDqR7
	+686fcQHeWp3WTsOQxpwOH7r3C9Qbs7CuGxv7CvTRLo2ckgmbUeGugrk/M/fV6iP
	y8tFXJFtPCDjw3Tm5sYrQAFkb9PqQ/2VET7D0C4n38kQakYl40Yxmm8fojHRYZhw
	==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 490cmwm88x-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 08 Sep 2025 22:33:50 +0000 (GMT)
Received: from m0353729.ppops.net (m0353729.ppops.net [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 588MXnnH010470;
	Mon, 8 Sep 2025 22:33:49 GMT
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 490cmwm88u-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 08 Sep 2025 22:33:49 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 588LnHwA017181;
	Mon, 8 Sep 2025 22:33:48 GMT
Received: from smtprelay06.wdc07v.mail.ibm.com ([172.16.1.73])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4911gm8187-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 08 Sep 2025 22:33:48 +0000
Received: from smtpav06.dal12v.mail.ibm.com (smtpav06.dal12v.mail.ibm.com [10.241.53.105])
	by smtprelay06.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 588MXlHx2621976
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 8 Sep 2025 22:33:48 GMT
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id ADFDC58069;
	Mon,  8 Sep 2025 22:33:47 +0000 (GMT)
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B2BCE5806A;
	Mon,  8 Sep 2025 22:33:46 +0000 (GMT)
Received: from li-43857255-d5e6-4659-90f1-fc5cee4750ad.ibm.com (unknown [9.61.151.244])
	by smtpav06.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Mon,  8 Sep 2025 22:33:46 +0000 (GMT)
Message-ID: <9f1dd6d30193c82ff36b5665eadc1aec73736017.camel@linux.ibm.com>
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
In-Reply-To: <CAHC9VhTJnQ3EggEXwbW5D8xOnb+Z_02yz-Dgb7QiAoArhw1ETg@mail.gmail.com>
References: <20250814225159.275901-36-paul@paul-moore.com>
	 <20250814225159.275901-67-paul@paul-moore.com>
	 <CAHC9VhS3KdVO9n-dgk1qFzTae0i+Oab8atMmt0CAsMEm1D4v5w@mail.gmail.com>
	 <bd46c63ebb9eddfcdc8df92fe9f85473416ea8a0.camel@linux.ibm.com>
	 <CAHC9VhTJnQ3EggEXwbW5D8xOnb+Z_02yz-Dgb7QiAoArhw1ETg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Date: Mon, 08 Sep 2025 18:33:46 -0400
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Evolution 3.54.3 (3.54.3-1.fc41) 
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: fOL6Rx33DAw5gUt7fqCGXu4VQxzjmAsO
X-Proofpoint-ORIG-GUID: 5VWIp5yj1HP490urrPrrfVHj1q66Pbv7
X-Authority-Analysis: v=2.4 cv=J52q7BnS c=1 sm=1 tr=0 ts=68bf59ce cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=muJfdD1AdBiDBFObZ70A:9
 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTA2MDAyNSBTYWx0ZWRfXxSFCU2Jjn0mn
 OtQwuBrCqV4L7GJXI+x5ZFBkT5++TbGGhfbKqhs1cA23gPHdIeF5vBhwU9aIg/W+U3kFk+xHYMR
 GwPc5SzvDeuBsbcMbfcS/LjVwRDCbHL6uFNWQD9x7xwo+72dgi5ExnZPDj4XcvjwVWTljr5HwFK
 2R6rKzMtc73RD5AxlLqeWAzf7Uh2m4+q8PHPF0ti1IqKrl0ozHSLhwne17bOnvTPe1d5ZyVfyHt
 2ZQPTCpTTskjGSyjrrXKXK0ieX/2rNeKmEBPAq0jaO3S09l99SrK7/bzdjAjgYb2gFYXWdnXoBA
 VcCM8EERdRSBjw02OfKaMYkoerGeCd9FnENZXvNtSbGX26y785UAaUaBaQPO6KocoAZhqiilmmH
 XSHyrIJp
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-08_06,2025-09-08_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 clxscore=1015 suspectscore=0 spamscore=0 phishscore=0
 bulkscore=0 adultscore=0 malwarescore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2509060025

On Sun, 2025-09-07 at 21:05 -0400, Paul Moore wrote:
> > The "unrelated to IMA/EVM" wording misses the point.=C2=A0 An exception=
 was made to
> > load the pre-boot keys onto the .platform keyring in order for IMA/EVM =
to verify
> > the kexec kernel image appended signature.=C2=A0 This exception was sub=
sequently
> > extended to verifying the pesigned kexec kernel image signature.=C2=A0 =
(Other
> > subsystems are abusing the keys on the .platform keyring to verify othe=
r
> > signatures.)
> >=20
> > Instead of saying "unrelated to IMA/EVM", how about saying something al=
ong the
> > lines of "IMA has a dependency on the platform and machine keyrings, bu=
t this
> > dependency isn't limited to IMA/EVM."
> >=20
> > Paul, this patch set doesn't apply to cleanly to Linus's tree.=C2=A0 Wh=
at is the base
> > commit?
>=20
> It would have been based on the lsm/dev branch since the LSM tree is
> the target, however, given the scope of the patchset and the fact that
> it has been several weeks since it was originally posted, I wouldn't
> be surprised it if needs some fuzzing when applied on top of lsm/dev
> too.

Thanks, Paul.  I was able to apply the patches and run some regression test=
s.

Mimi



