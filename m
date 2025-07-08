Return-Path: <linux-integrity+bounces-6639-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 77B40AFD8E0
	for <lists+linux-integrity@lfdr.de>; Tue,  8 Jul 2025 22:52:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7E2EF42782F
	for <lists+linux-integrity@lfdr.de>; Tue,  8 Jul 2025 20:52:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9D4C239E66;
	Tue,  8 Jul 2025 20:52:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="nW/7iTfn"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B4D0213E77;
	Tue,  8 Jul 2025 20:52:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752007956; cv=none; b=fgyWxJ89cvJXCie3GpabwbNmPShkXNfVL60vQmP5k/7CBeBosiBHuVcAIj51dvCzbxZ4CHN6kTe0pAWtUP2uNxamrvb0UutRnUGXQt/5w+QXD+b0+JFu5/5r8S3zX7/0BJWLth1tVzxfhiAvACFyWUTeH0lwJIQ6Mg/2FV/36yY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752007956; c=relaxed/simple;
	bh=qSBnADzs5VvDPRh9urXHvqRKFL9L10HY/facQks3qXQ=;
	h=Message-ID:Subject:From:To:Cc:In-Reply-To:References:Content-Type:
	 Date:MIME-Version; b=FCMhLYURyxnAHHwoUh31oQSd2yYpkzyX3uf4q/NPiLkUBopw7pWXV+qr76WjOigU5RH1DC/LcRkOvfjbmHuRKdJTC2lPEcHltd+XolR23d+va7uk55GE8+VIAFTk3CFyWNyoN6IfdkNRmsUu+SE7k3dQHpQoTZiS9gHCOZYCzq4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=nW/7iTfn; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 568GxjUV010856;
	Tue, 8 Jul 2025 20:52:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=KmZUm8
	+ahDkjmgsBBQ7WFiB68H+WvDhSZI+Q02U22IA=; b=nW/7iTfnDg8ZRUwvZzvBjs
	Ivw0H7VzNXCE4EHUR9LcAarHqPa9iubCkQMPeIYoJ3ezXc6FtTo/cixAaiVMObhF
	SWl0mvayxnZkFxmkMdWacTznl8n1NdRLPxboeqQmimiQXYoEMqcS01u1cz8NY3vh
	p1YtyRWW5Qe9kDFbhhuZuXtsujZaVEVJbmoLcyb4FExA3OTrIhfqjxm5fga2QD7u
	O3M+W8sZRERT0LDqdVvYQliolVymi+ac9vLtRNuqNXez13F272FKK19SuQqkjgO8
	LhCV0G2trT95wUrMEVFqwvgqkaJQw3On7ffxgEGEoOxgAwnSEijDy3QV1sIvWzyw
	==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 47ptfyss0v-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 08 Jul 2025 20:52:06 +0000 (GMT)
Received: from m0353725.ppops.net (m0353725.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 568KlUvv030923;
	Tue, 8 Jul 2025 20:52:05 GMT
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 47ptfyss0u-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 08 Jul 2025 20:52:05 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 568IcXU0025634;
	Tue, 8 Jul 2025 20:52:05 GMT
Received: from smtprelay06.dal12v.mail.ibm.com ([172.16.1.8])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 47qfcp4uvs-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 08 Jul 2025 20:52:05 +0000
Received: from smtpav05.wdc07v.mail.ibm.com (smtpav05.wdc07v.mail.ibm.com [10.39.53.232])
	by smtprelay06.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 568Kq4U926935878
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 8 Jul 2025 20:52:04 GMT
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 174005805D;
	Tue,  8 Jul 2025 20:52:04 +0000 (GMT)
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id F423058043;
	Tue,  8 Jul 2025 20:52:02 +0000 (GMT)
Received: from li-43857255-d5e6-4659-90f1-fc5cee4750ad.ibm.com (unknown [9.31.96.173])
	by smtpav05.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Tue,  8 Jul 2025 20:52:02 +0000 (GMT)
Message-ID: <b1b5feaa93922c9b5a8f1a1e41385d266fe640ce.camel@linux.ibm.com>
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
In-Reply-To: <aGeECyNqSQoIP7d2@gardel-login>
References: <Z9wDxeRQPhTi1EIS@gardel-login>
	 <1a6cf2097487816e4b93890ad760f18fe750bd70.camel@linux.ibm.com>
	 <aGYurikYK1ManAp3@gardel-login>
	 <8401c23009db3b8447b0b06710b37b1585a081ab.camel@linux.ibm.com>
	 <aGZ_x8Ar6iwzt2zV@gardel-login>
	 <45b30f515efc3e364e1d248ab0ed7f12f8312f5d.camel@linux.ibm.com>
	 <aGeECyNqSQoIP7d2@gardel-login>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Date: Tue, 08 Jul 2025 16:52:02 -0400
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Evolution 3.54.3 (3.54.3-1.fc41) 
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=crubk04i c=1 sm=1 tr=0 ts=686d84f6 cx=c_pps a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=T32AvWmzj0pvYibFOuoA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: qkainbchoXgLqvFw5dBjSwoGf7H0n_nW
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzA4MDE3NiBTYWx0ZWRfX906q5c65biPH 5WL/kQ1lQzSVw8jKM91r306IM/6YF8E2nrPgoQ298RcBJ8jIKZq4WjDgaf/HGNie7K8nZ2Ea4EX yxLqQ4CJXr1eJMBlhhQwx0da7W/gawKQ7gozYYRyeQF4VhGuSkjLJC9MfoERRJyOEDWgQPKq6u/
 np/1au1hpyzMaeurJbE+J0D9IP0ihotQDe6xRFJcITAzYhwDon9NHismoAVBmopEgVvTSAbqTdG xYSOd7WPoBFmzI1wC1MUpkCTaoNQo+j12hOOqzZbppg/jkh3xmtK0HYs696/e3IZEDCpI9VIp6r bjcjjq4QuVLj9Td0JCMaJ0mDyOHqQmPwdB1fRo7uvvR+t3IhAGWYESb/qFjETv/Q3Kbr6mnkMsK
 AmlVfLcBgZfq9y11HNrDrR4H+VjWkLZXrYsgnmCZYpdoNM4VvmEBMCR91o69X2PyhnRxsAly
X-Proofpoint-GUID: qmpT9jcJKsqhUmMpaVGqklSC4xenKg6i
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-08_05,2025-07-08_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 mlxlogscore=999
 priorityscore=1501 adultscore=0 suspectscore=0 lowpriorityscore=0
 clxscore=1015 impostorscore=0 malwarescore=0 spamscore=0 bulkscore=0
 phishscore=0 classifier=spam authscore=0 authtc=n/a authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2507080176

On Fri, 2025-07-04 at 09:34 +0200, Lennart Poettering wrote:
> > That would be preferable to changing the existing expectations to loadi=
ng the
> > MOK keys when secure boot is not enabled.
>=20
> Sorry, but I vehemently disagree, that's a really broken security
> model. SecureBoot on should mean strict rules and, SB off should mean
> relaxed rules, and you are doing it in the opposite way.

We're going around and around in circles, each of us saying the same thing =
over
and over.  Let's try breaking this down.

For now let's assume there are just two security models, the hybrid securit=
y
model of trusted boot transitioning to secure boot and the secure boot only
model.

In the hybrid security model of trusted boot transitioning to secure boot,
you're claiming it is always safe to load vendor keys and/or "local keys",
whether secure boot is enabled or disabled.   This makes sense, because the=
 keys
will be measured and the disk encryption key won't be unsealed (TPM 1.2
terminology) if there are unknown keys.

I'm claiming in the secure boot ONLY model, the default is to use the set o=
f
known builtin trusted keys and to make an exception to allow "vendor keys"
and/or "local keys" IFF secure boot is enabled.  This is a reasonable excep=
tion,
relaxing of rules.

With your understanding of "SecureBoot on should mean strict rules and, SB =
off
should mean relaxed rules ... " there would be no difference if Secure Boot=
 is
enabled or disabled.  For your hybrid security model case this works
perfectly.=C2=A0In the secure boot only case, however, it breaks the existi=
ng
security model expectations.

The question is how can both of these security models co-exist?

Mimi

