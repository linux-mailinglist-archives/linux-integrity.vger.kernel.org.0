Return-Path: <linux-integrity+bounces-4104-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 856799C6F5D
	for <lists+linux-integrity@lfdr.de>; Wed, 13 Nov 2024 13:44:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 49E30289AEC
	for <lists+linux-integrity@lfdr.de>; Wed, 13 Nov 2024 12:44:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADC10202650;
	Wed, 13 Nov 2024 12:42:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="WEy0+trl"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C52DA20111A;
	Wed, 13 Nov 2024 12:42:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731501761; cv=none; b=B9J9wiIANvixfmvg5CbpNnsvFQAQHG8gv2hKzgizFqcAsjTWstJNq/4XScE+VVpe91Llw18EB9VFAV4NLu2UjvSdD83gTEAi6XsbDdgswfsiT6tmqQepJsHtmMrLm/ui/xY6HePcqvxf8kJ4A8MNrNUk3i+jQeL3uXXywT41OHI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731501761; c=relaxed/simple;
	bh=4Hz00pKai+P1TZ4oJ4+z8K3c6n8vVIWDUtAaiouqPEE=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=pVmF62GpCsLFUBurbcYBbSWZflUDOdrqo4zfwTkPZQFNOxHt11YCjogQXytwXO5t+wZtSZVOYA6xrr+Bvb2MY1uNp7MpxjDkypT36VFyZnYZmiUBxzJAg/qKyuW7eqXp3oDObO4oYfJmjwP8w14USCuGPkX1uwxOxzz95ieqolM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=WEy0+trl; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4ADAYCN1013095;
	Wed, 13 Nov 2024 12:42:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=4Hz00p
	Kai+P1TZ4oJ4+z8K3c6n8vVIWDUtAaiouqPEE=; b=WEy0+trltJD8N+mNcVym4S
	hTkxXIRmSn1c3oXWIcqc6qb4cQyApwtYvqVMGa/ituAR3OERVceJ7zcpu3n3NtQL
	1Q22Lwzpz2BvR9t/tAhz3SVQPXQFB4TLJQC1HcCtIiBt02aLbAtGUYRU0S5sxt0R
	OZ+XliHSTJRTFfnx4LwMZzkZ5U7fOTs8VQ+YGbWF1gqVXLiMYgpJ+An38lo2Kb3F
	vLysPYX/YDdVhjvZfJlAPWGPWvxzrhzJqtpfDRXE24AQDQTpemFPfnMwSy1MZ7b6
	gNwOHwaz9QVCQV8UmiJTxnv57dUcxaR3smMcppjnAgg2xg42jQ8nhf1gcelCSlFQ
	==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 42vdceubhb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 13 Nov 2024 12:42:14 +0000 (GMT)
Received: from m0360072.ppops.net (m0360072.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 4ADCdGmv007724;
	Wed, 13 Nov 2024 12:42:13 GMT
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 42vdceubha-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 13 Nov 2024 12:42:13 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 4AD3kg4Z017481;
	Wed, 13 Nov 2024 12:42:12 GMT
Received: from smtprelay05.dal12v.mail.ibm.com ([172.16.1.7])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 42tk2mx7fj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 13 Nov 2024 12:42:12 +0000
Received: from smtpav05.dal12v.mail.ibm.com (smtpav05.dal12v.mail.ibm.com [10.241.53.104])
	by smtprelay05.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 4ADCgB2j52822512
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 13 Nov 2024 12:42:12 GMT
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E5C2A58065;
	Wed, 13 Nov 2024 12:42:11 +0000 (GMT)
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id AF80D58052;
	Wed, 13 Nov 2024 12:42:10 +0000 (GMT)
Received: from li-43857255-d5e6-4659-90f1-fc5cee4750ad.ibm.com (unknown [9.61.108.198])
	by smtpav05.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 13 Nov 2024 12:42:10 +0000 (GMT)
Message-ID: <ea75a417d4218dfb86b6061567059bdf3dec54ec.camel@linux.ibm.com>
Subject: Re: [PATCH v3] tpm: Opt-in in disable PCR integrity protection
From: Mimi Zohar <zohar@linux.ibm.com>
To: Jarkko Sakkinen <jarkko@kernel.org>, linux-integrity@vger.kernel.org,
        Jonathan Corbet <corbet@lwn.net>, Peter Huewe <peterhuewe@gmx.de>,
        Jason
 Gunthorpe <jgg@ziepe.ca>,
        James Bottomley
 <James.Bottomley@HansenPartnership.com>
Cc: Roberto Sassu <roberto.sassu@huawei.com>,
        David Howells
 <dhowells@redhat.com>, Paul Moore <paul@paul-moore.com>,
        James Morris
 <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>, Thomas Huth
 <thuth@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Paul E.
 McKenney" <paulmck@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Xiongwei Song <xiongwei.song@windriver.com>,
        Stefan Berger
 <stefanb@linux.ibm.com>,
        Ard Biesheuvel <ardb@kernel.org>, Al Viro
 <viro@zeniv.linux.org.uk>,
        "open list:DOCUMENTATION"
 <linux-doc@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        "open list:KEYS-TRUSTED" <keyrings@vger.kernel.org>,
        "open list:SECURITY
 SUBSYSTEM" <linux-security-module@vger.kernel.org>,
        Josh Poimboeuf
 <jpoimboe@kernel.org>
Date: Wed, 13 Nov 2024 07:42:10 -0500
In-Reply-To: <D5KTIBJRLLZO.393Y9M060YHWG@kernel.org>
References: <20241113002414.609168-1-jarkko@kernel.org>
	 <9649cec7710241dc359c7c1a715b2cef36ebce15.camel@linux.ibm.com>
	 <D5KTIBJRLLZO.393Y9M060YHWG@kernel.org>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.52.4 (3.52.4-1.fc40) 
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: yT6ooz69NEwuzhEGBZYVrrFEixZUyC-l
X-Proofpoint-ORIG-GUID: 6CMqFR4PEhDVdZm6gZvDqpqUPr_WM3_1
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
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 phishscore=0
 spamscore=0 clxscore=1015 malwarescore=0 mlxlogscore=616
 priorityscore=1501 bulkscore=0 mlxscore=0 impostorscore=0 suspectscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2409260000 definitions=main-2411130107

On Wed, 2024-11-13 at 07:56 +0200, Jarkko Sakkinen wrote:
> On Wed Nov 13, 2024 at 6:34 AM EET, Mimi Zohar wrote:
> > The module_param variable documentation needs to be updated to reflect =
the
> > actual module_param variable 'disable_pcr_integrity'.
> >=20
> > Otherwise,
> > Tested-by: Mimi Zohar <zohar@linux.ibm.com>
>=20
> Thanks for catching that glitch. Here's updated version:
>=20
> https://git.kernel.org/pub/scm/linux/kernel/git/jarkko/linux-tpmdd.git/co=
mmit/?id=3D8f22b3ed4d200ae0c575791e069316c633ed5c39

Looks good.

thanks,

Mimi

