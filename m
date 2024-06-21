Return-Path: <linux-integrity+bounces-2912-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 23F98912E9E
	for <lists+linux-integrity@lfdr.de>; Fri, 21 Jun 2024 22:34:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 58C1FB255B7
	for <lists+linux-integrity@lfdr.de>; Fri, 21 Jun 2024 20:34:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A926616D304;
	Fri, 21 Jun 2024 20:34:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="Afd3s0/W"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13574374DD
	for <linux-integrity@vger.kernel.org>; Fri, 21 Jun 2024 20:34:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719002083; cv=none; b=oY2cAidFbnZNgrjqS1mf9AJDX0MA5S6NvBEh01EK8p0q8cx7BGpjiGhSz2jTb1ZdAuP5lT6tflxDmq1FI+BP1qtUJ/Qw+CTtxAiY2W3KjF3UH60rL7grf0Ql8FBshytwcm7DkgjesTARmtCq/y/eD3wo4DvTW5Lk5yFhkSqhTqY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719002083; c=relaxed/simple;
	bh=dl/Q+qnwxcRQyT1ACYnHmDe7mZJSw0E/y0xmJVorrHo=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=EowlJnruxJ5Lr5GVzQvrAz+SiLmzhl4hb/uP0qXQoYgQrhVkxsajtPM3mgDE6Yn6lA/PwcS8hSaTGeCH2MLXJqzcHxxBSqqC1ljThHjCjmAjVs6mhfVKsuQCbttFx/QCwiH6ZpEY/iLDF+KlX41VoJMykzvKGG0FvFSQ4CDh7PQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=Afd3s0/W; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45LKUVuh008167;
	Fri, 21 Jun 2024 20:34:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=
	message-id:subject:from:to:cc:date:in-reply-to:references
	:content-type:content-transfer-encoding:mime-version; s=pp1; bh=
	ZElm1vn8u6TtGKo5TAK8grmUoyUwj+C4JIeIFChFZhw=; b=Afd3s0/Wi+ufmcDc
	eyvX+bpx3P4RQVbImO6N7IIc2mQX4Vq7o9oTP8K1kjHPQA8vN8+3TeBe5wrm/cht
	xn71utOOg855TKRUKYaVxd0uhuYuSH8+fkXxhlEsgkV9BSsZ67G86VSyJCFhmmr7
	VyJCIoSKIYofxcWOqhVyDtpK2kXn6M8DajJcrxWc0bQ+qCpKq7WVPE0rJlYd9HG9
	V/a9lDkibtm4J+PW3YOerGX/QfISSI9vJYbM+OZ2eXjGat4Mdn7zOn0l1qSSScNa
	MVRjvb5ZY6THxgGhV1kxjEUgB06K2rsKZd8GqGcsN8n0E/1B+/OmY42JNU1+2uSZ
	2QARWA==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3ywgm4808b-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 21 Jun 2024 20:34:37 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 45LJAFGZ031347;
	Fri, 21 Jun 2024 20:34:36 GMT
Received: from smtprelay06.wdc07v.mail.ibm.com ([172.16.1.73])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3yvrrq95w9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 21 Jun 2024 20:34:36 +0000
Received: from smtpav04.wdc07v.mail.ibm.com (smtpav04.wdc07v.mail.ibm.com [10.39.53.231])
	by smtprelay06.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 45LKYYtI19923508
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 21 Jun 2024 20:34:36 GMT
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 217C158054;
	Fri, 21 Jun 2024 20:34:34 +0000 (GMT)
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 93F4F58052;
	Fri, 21 Jun 2024 20:34:33 +0000 (GMT)
Received: from li-5cd3c5cc-21f9-11b2-a85c-a4381f30c2f3.ibm.com (unknown [9.61.41.136])
	by smtpav04.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 21 Jun 2024 20:34:33 +0000 (GMT)
Message-ID: <c7cace8cd944ea83bf93f8db652ead0b07611fe5.camel@linux.ibm.com>
Subject: Re: [ima-evm-utils][PATCH 2/3] CI/CD: Disable pkcs11 providers for
 Debian and AltLinux
From: Mimi Zohar <zohar@linux.ibm.com>
To: Jonathan McDowell <noodles@earth.li>
Cc: Stefan Berger <stefanb@linux.vnet.ibm.com>,
        linux-integrity@vger.kernel.org, Stefan Berger <stefanb@linux.ibm.com>
Date: Fri, 21 Jun 2024 16:34:33 -0400
In-Reply-To: <ZnVni8XlHevSIfEB@earth.li>
References: <20240621005912.1365462-1-stefanb@linux.vnet.ibm.com>
	 <20240621005912.1365462-3-stefanb@linux.vnet.ibm.com>
	 <ZnVP1nLxm1vhc1l0@earth.li>
	 <5fc85cd29bc8456bfd1cd47b6dbe38bfbaeb4907.camel@linux.ibm.com>
	 <ZnVni8XlHevSIfEB@earth.li>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5 (3.28.5-25.el8_9) 
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: -rCa4i8xTIBqGZcvt7WFOmS400R5NbfX
X-Proofpoint-ORIG-GUID: -rCa4i8xTIBqGZcvt7WFOmS400R5NbfX
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
 definitions=2024-06-21_11,2024-06-21_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 malwarescore=0
 clxscore=1015 lowpriorityscore=0 adultscore=0 priorityscore=1501
 impostorscore=0 suspectscore=0 mlxlogscore=999 phishscore=0 mlxscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2406140001 definitions=main-2406210145

On Fri, 2024-06-21 at 12:44 +0100, Jonathan McDowell wrote:
> On Fri, Jun 21, 2024 at 06:24:38AM -0400, Mimi Zohar wrote:
> > On Fri, 2024-06-21 at 11:03 +0100, Jonathan McDowell wrote:
> > > On Thu, Jun 20, 2024 at 08:59:11PM -0400, Stefan Berger wrote:
> > > > From: Stefan Berger <stefanb@linux.ibm.com>
> > > > 
> > > > Disable testing provider support on Debian:latest and AltLinux:sisyphus
> > > > since both now get stuck while running OpenSSL provider-related tests.
> > > > This is most likely due to an update in a dependency (OpenSSL, libp11,
> > > > softhsm,  or others).
> > > 
> > > This seems to disable it for both Debian stable + testing.  Is it
> > > actually broken for both?
> > 
> > There is no pkcs11-provider package on stable, so the test is skipped.
> 
> Ah, right. I can't actually figure out what tree Stefan's patch is
> against to try myself. https://git.code.sf.net/p/linux-ima/ima-evm-utils
> does not have the commented out softhsm2 / pkcs11-provider apt line.
> Where should I be looking?

Upstream should be based on the next-testing branch of 
https://github.com/linux-integrity/ima-evm-utils.git.

Mimi


