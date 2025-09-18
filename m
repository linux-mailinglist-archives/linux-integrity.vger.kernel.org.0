Return-Path: <linux-integrity+bounces-7172-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0589DB862BB
	for <lists+linux-integrity@lfdr.de>; Thu, 18 Sep 2025 19:13:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C17E316C0A1
	for <lists+linux-integrity@lfdr.de>; Thu, 18 Sep 2025 17:13:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F08183128B4;
	Thu, 18 Sep 2025 17:13:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="j2q3Ulp/"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FBAA2641C3;
	Thu, 18 Sep 2025 17:13:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758215588; cv=none; b=BDG1oyS0vBBwyH9KdphIV6Y02yl/VLs9yzaIRNrQ3cau9IxECRPlA5eSJZ/8Mck/d/48d43Bi5r9X6qx9ShOhYcuJK//O4PxSWWHSRwf+x1ieYXfWVn5ADNeEVMqeHu7PmhnJY9MlRFdAFHNoApjC/wX7n7BeUaiLb6jDeMdB0Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758215588; c=relaxed/simple;
	bh=1hV2dadTHDMFfJXNXDpraffIQQmZbcYwkLEa8NpJVwA=;
	h=Message-ID:Subject:From:To:Cc:In-Reply-To:References:Content-Type:
	 Date:MIME-Version; b=YrWgaF+a8bgoXIG7S3mC5NreAp+uo/YRL29xvKnV0ZF/u2HQAZUySJtiLKEslk9VInLXup4v0pIHRQRsrnjnfBtRHToqmRCD/8aT7pxdqHOIfbABEZTj8b32lyouZG+pNWM5/8r2c7ZWuY4YKcOpQ0AJjfqK38VIU1nlo0kKsp4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=j2q3Ulp/; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58IF0ojO012241;
	Thu, 18 Sep 2025 17:12:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=1hV2da
	dTHDMFfJXNXDpraffIQQmZbcYwkLEa8NpJVwA=; b=j2q3Ulp/C5nHyyshFSMOHq
	XTSI4Y2otOVPMjUp9Xc2YWBSBVe3qOoGt7qrbft4ZDndWxXw5LZCmLVQLba8bRtR
	u22d3PYwnsM9OK0iPJmXDrrpO01SG8/URWmoG+EE1YP1UjHhiMC0heVUglV85+QC
	wI0kQWffaAhQ3yNRQUUqnntq3Zy0QZs/lmEoWuXW1jwtruMYnpbc3hlvSn4U2d/T
	wbyLt/YicJFtu4HtxEsw7RAVUs28+vTIv1wVe3TfejMX3r7T0wEGL1OIQ+GaUPkW
	Cug8yAmPLYPcAYxt9zAFDdCWvxcHdgYsbeL2dbyUK6cPqH1b0SBo87mGnBO14n+Q
	==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 497g4jbsta-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 18 Sep 2025 17:12:04 +0000 (GMT)
Received: from m0356517.ppops.net (m0356517.ppops.net [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 58IGwx1Y018271;
	Thu, 18 Sep 2025 17:12:04 GMT
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 497g4jbst2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 18 Sep 2025 17:12:04 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 58IExhig019200;
	Thu, 18 Sep 2025 17:12:02 GMT
Received: from smtprelay05.wdc07v.mail.ibm.com ([172.16.1.72])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 495n5mqp6n-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 18 Sep 2025 17:12:02 +0000
Received: from smtpav05.dal12v.mail.ibm.com (smtpav05.dal12v.mail.ibm.com [10.241.53.104])
	by smtprelay05.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 58IHC1Qf15467030
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 18 Sep 2025 17:12:01 GMT
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 5B1385805D;
	Thu, 18 Sep 2025 17:12:01 +0000 (GMT)
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 8BD7F58056;
	Thu, 18 Sep 2025 17:11:59 +0000 (GMT)
Received: from li-43857255-d5e6-4659-90f1-fc5cee4750ad.ibm.com (unknown [9.31.96.173])
	by smtpav05.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 18 Sep 2025 17:11:59 +0000 (GMT)
Message-ID: <3123287ce1bf9691f89505e2b8163afff633c4e9.camel@linux.ibm.com>
Subject: Re: [PATCH v4 21/34] lsm: output available LSMs when debugging
From: Mimi Zohar <zohar@linux.ibm.com>
To: Paul Moore <paul@paul-moore.com>, linux-security-module@vger.kernel.org,
        linux-integrity@vger.kernel.org, selinux@vger.kernel.org
Cc: John Johansen <john.johansen@canonical.com>,
        Roberto Sassu	
 <roberto.sassu@huawei.com>, Fan Wu <wufan@kernel.org>,
        =?ISO-8859-1?Q?Micka=EBl_Sala=FCn?=	 <mic@digikod.net>,
        =?ISO-8859-1?Q?G=FCnther?= Noack <gnoack@google.com>,
        Kees Cook
 <kees@kernel.org>, Micah Morton <mortonm@chromium.org>,
        Casey Schaufler	
 <casey@schaufler-ca.com>,
        Tetsuo Handa
 <penguin-kernel@I-love.SAKURA.ne.jp>,
        Nicolas Bouchinet
 <nicolas.bouchinet@oss.cyber.gouv.fr>,
        Xiu Jianfeng <xiujianfeng@huawei.com>
In-Reply-To: <20250916220355.252592-57-paul@paul-moore.com>
References: <20250916220355.252592-36-paul@paul-moore.com>
	 <20250916220355.252592-57-paul@paul-moore.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Date: Thu, 18 Sep 2025 13:11:58 -0400
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Evolution 3.54.3 (3.54.3-2.fc41) 
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=Qf5mvtbv c=1 sm=1 tr=0 ts=68cc3d64 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=vpqfxihKAAAA:8 a=DfNHnWVPAAAA:8
 a=xVhDTqbCAAAA:8 a=VnNF1IyMAAAA:8 a=KL3qizArU62ITGmDAicA:9 a=QEXdDO2ut3YA:10
 a=AULIiLoY-XQsE5F6gcqX:22 a=rjTVMONInIDnV1a_A2c_:22 a=GrmWmAYt4dzCMttCBZOh:22
X-Proofpoint-ORIG-GUID: SkTL1cIxD90jL6Vq6B_UE1uL4R1No4pj
X-Proofpoint-GUID: d00kqZNpDEt5rhR2hGAGVYn3OKlD9-LT
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTE2MDIwNCBTYWx0ZWRfX64s9cKXluIxQ
 ZiAB74qPwqweOQZ/IHByCZbYpArFpMf1mHgNcapeZ3q2nOzInYwMaQdbS8MVrYxjApgnlRkU8d9
 epBB4QFv1A63JXdqzbiSl+xrrOPuv6cx8HaAm5l2XvFxEl5rR7YIjMCXjEsxFtb4H5GlsAoryER
 /SK4D5hB/084FzvumhevxQ/xt6c7jRILX9QvZJQYtYche1QBukul6hkBABzkKVT+R4HFpWK+RE5
 1ixs230L7vLZk3l9jdSzGGH6Gs3IOrhly5nurXCOkifsNaZvzy1Dc2CoQvNFdHAdd19dTHjQBFH
 3lCOu2LaF+5zOySE44TZTSWhxDZdXtE2u5jq6f6jgEBZBaYYTD0L3wBT3a89t1c89Q7RKgFiHpm
 e3TUikNa
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-18_01,2025-09-18_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 clxscore=1015 phishscore=0 suspectscore=0 adultscore=0
 priorityscore=1501 malwarescore=0 bulkscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2509160204

On Tue, 2025-09-16 at 18:03 -0400, Paul Moore wrote:
> This will display all of the LSMs built into the kernel, regardless
> of if they are enabled or not.
>=20
> Reviewed-by: Casey Schaufler <casey@schaufler-ca.com>
> Reviewed-by: John Johansen <john.johhansen@canonical.com>
> Signed-off-by: Paul Moore <paul@paul-moore.com>

Reviewed-by: Mimi Zohar <zohar@linux.ibm.com>



