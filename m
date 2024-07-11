Return-Path: <linux-integrity+bounces-3096-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 29CB592EA45
	for <lists+linux-integrity@lfdr.de>; Thu, 11 Jul 2024 16:07:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D2E9028214C
	for <lists+linux-integrity@lfdr.de>; Thu, 11 Jul 2024 14:07:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DAF69160883;
	Thu, 11 Jul 2024 14:07:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="jgLdqRUs"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D47914BFA2;
	Thu, 11 Jul 2024 14:07:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720706824; cv=none; b=tFShzr23PNDpLlpM9SaupQ5imWdeilugimTnyN6zk/gVSDq8kWxZbh3Y4KpOukv5vK+EaOpBpIIHCTESUI4dSSnL2lQcu/cBVG05WBagQMnPofOjMlksbZly48lkcL8/UQHI0xxSi33wD9ClGoyYsV+Rv4xTZsWbzZCcfDivpk8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720706824; c=relaxed/simple;
	bh=+NFR6f693MzG7lw8XXy6V2If/ntMHXFXvJBRbgsBiIU=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=HpPArqbSHT4gsC39k/vxX4pVYZVv6VCmA4g3/SlfOijWODdlQbD74KxjTanPEHbC0Ronui3GEt1WhVIT7xGlvZVHlvqJV/ZdUNlFuoFbGTMq0Gop4MRYZ9C7Op/yRMjjxp53MDtyOisMeHtKePXR7h1iR1EPOtIJVLYGsBdtpEU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=jgLdqRUs; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353728.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 46BE1HoQ023461;
	Thu, 11 Jul 2024 14:06:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=
	message-id:subject:from:to:cc:date:in-reply-to:references
	:content-type:content-transfer-encoding:mime-version; s=pp1; bh=
	cHExn9jnsbTJCAsMj9L9En/xN94s17ShVmCpW9gJCYI=; b=jgLdqRUsySgJCiuz
	xt6v26P58D9IUMg77N+iDH1rgYB7MPd8BrQnx4PEDolX/Q5QvXzWbeK79Ya6dITI
	kH7qFIDTopzsD3Dxev96ZNhDRVmTXaN205tYvqxrRquIOThoWXyjG8uP9dR5GADv
	sjxq1PQGxyKi2xJCUNnQWQXYcl78jAO0GODtluywk+6xedqtI3PmwAgrC9XhlQVr
	GyWlaU8WctrhaOzmHZXAlb1B5d//f9NsR4rprNqar066+MsxVUsfbZhjC58bvt6s
	zWF4nLZBy8Jg7YmZ67jrB2u8aotYpsItv2zj6AuALaQOiBsn6E9HArxwjlw5HUNB
	cHg6Gg==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 40aej1re2s-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 11 Jul 2024 14:06:28 +0000 (GMT)
Received: from m0353728.ppops.net (m0353728.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 46BE6S7o000322;
	Thu, 11 Jul 2024 14:06:28 GMT
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 40aej1re2n-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 11 Jul 2024 14:06:28 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 46BDXkco006896;
	Thu, 11 Jul 2024 14:06:27 GMT
Received: from smtprelay06.wdc07v.mail.ibm.com ([172.16.1.73])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 407jfmruad-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 11 Jul 2024 14:06:27 +0000
Received: from smtpav03.wdc07v.mail.ibm.com (smtpav03.wdc07v.mail.ibm.com [10.39.53.230])
	by smtprelay06.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 46BE6OpH27329276
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 11 Jul 2024 14:06:26 GMT
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 4E76D5805D;
	Thu, 11 Jul 2024 14:06:24 +0000 (GMT)
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 425125805F;
	Thu, 11 Jul 2024 14:06:23 +0000 (GMT)
Received: from li-5cd3c5cc-21f9-11b2-a85c-a4381f30c2f3.ibm.com (unknown [9.61.115.143])
	by smtpav03.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 11 Jul 2024 14:06:23 +0000 (GMT)
Message-ID: <b551f01f52d5cefea3992f6c75baa0683ed57ac9.camel@linux.ibm.com>
Subject: Re: [RFC] integrity: wait for completion of i2c initialization
 using late_initcall_sync()
From: Mimi Zohar <zohar@linux.ibm.com>
To: Romain Naour <romain.naour@smile.fr>, Paul Menzel <pmenzel@molgen.mpg.de>
Cc: linux-integrity@vger.kernel.org, linux-security-module@vger.kernel.org,
        serge@hallyn.com, jmorris@namei.org, paul@paul-moore.com,
        eric.snowberg@oracle.com, dmitry.kasatkin@gmail.com,
        roberto.sassu@huawei.com, Romain Naour <romain.naour@skf.com>
Date: Thu, 11 Jul 2024 10:06:22 -0400
In-Reply-To: <e197920f27bc67df45327ef56ee509d113435b25.camel@linux.ibm.com>
References: <20240701133814.641662-1-romain.naour@smile.fr>
	 <c090cd3c-f4c6-4923-a9fa-b54768ca2a26@molgen.mpg.de>
	 <d7429218-7b48-4201-8ad9-63728e188be5@smile.fr>
	 <e197920f27bc67df45327ef56ee509d113435b25.camel@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5 (3.28.5-26.el8_10) 
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: jvrX91ASUCSegeu_NarCxrXaLxdrALIA
X-Proofpoint-GUID: NLEYhPrBfb8opar7k0B9SscgLSkRGdt5
Content-Transfer-Encoding: 7bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-11_09,2024-07-11_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0 mlxscore=0
 clxscore=1015 impostorscore=0 adultscore=0 spamscore=0 bulkscore=0
 priorityscore=1501 phishscore=0 mlxlogscore=999 suspectscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2406140001 definitions=main-2407110095

On Mon, 2024-07-01 at 22:37 -0400, Mimi Zohar wrote:
> Hi Romain,
> 
> Please limit the subject line to 70 - 75 characters.
> 
> 
> On Mon, 2024-07-01 at 16:58 +0200, Romain Naour wrote:
> > > > [1]
> > > > https://lore.kernel.org/linux-integrity/9b98d912-ba78-402c-a5c8-154bef8794f7@smile.fr/
> > > > [2]
> > > > https://e2e.ti.com/support/processors-group/processors/f/processors-forum/1375425/tda4vm-ima-vs-tpm-builtin-driver-boot-order
> > > > 
> > > > Signed-off-by: Romain Naour <romain.naour@skf.com>
> > > 
> > > Should this get a Fixes: tag and be also applied to the stable series?
> > 
> > The current behavior can be reproduced on any released kernel (at least since
> > 6.1). But I'm not sure if it should be backported to stable kernels since it
> > delays the ima/evm initialization at runtime.
> 
> With the IMA builtin measurement policy specified on the boot command line
> ("ima_policy=tcb"), moving init_ima from the late_initcall() to
> late_initcall_sync() affects the measurement list order.  It's unlikely, but
> possible, that someone is sealing the TPM to PCR-10.  It's probably not a good
> idea to backport the change.
> 
> An alternative would be to continue using the late_initcall(), but retry on
> failure, instead of going directly into TPM-bypass mode.
> 
> As far as I can tell, everything is still being measured and verified, but more
> testing is required.

Romain, Paul, another report of IMA going into TPM-bypass mode is here: 
https://github.com/raspberrypi/linux/issues/6217.  Deferring IMA initialization
to late_initcall_sync() did not resolve the problem for them.  Please take a
look at the report.

thanks,

Mimi


