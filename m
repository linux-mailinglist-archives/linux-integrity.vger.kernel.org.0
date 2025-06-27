Return-Path: <linux-integrity+bounces-6565-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 473BEAEBCA9
	for <lists+linux-integrity@lfdr.de>; Fri, 27 Jun 2025 17:57:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CE50D18965C2
	for <lists+linux-integrity@lfdr.de>; Fri, 27 Jun 2025 15:57:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02E432E9EA6;
	Fri, 27 Jun 2025 15:56:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="bWUy2+KH"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 593A92E973C;
	Fri, 27 Jun 2025 15:56:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751039817; cv=none; b=aFctq4WXOLKldez+xaEi9VKqkZphaRmUt+sZFJFmVVZUgU2yHpg4QK5lrl9lfMybaik3DUD6H9kD1cBEsE8H+e01pUqxomVaFdrbulOBHyvGV7plnMFXK1tROpxJmxWX7BlL1jP8le6BhY8XbImsLuUEFvH9ZaB00srNgjih1nY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751039817; c=relaxed/simple;
	bh=IOusWH85S4yiTdywO3XqYqSK8cw+vKq9Jp+ntdI2tpE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Q9J6h84MhSrVDk4YCF1rOw8eG48y+lwTJ1dcSu5aUy1cwzS5wqJq1nDPx5lq/XOqPX8CCTlnfLHdZvi1H2IRmuN/9ToHSp+PObyKL8xNi+DFcvm/4wLqUI7PZiB1acenGIMpfoQeBacQbkE7hu/HureBoAVCqpCJI8P791a01MU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=bWUy2+KH; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55R8HC56010490;
	Fri, 27 Jun 2025 15:56:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=IOusWH85S4yiTdywO3XqYqSK8cw+vK
	q9Jp+ntdI2tpE=; b=bWUy2+KHyNK2AImHPoT/K7nzfyjM9NmbuPvmXplHr+g7Y1
	XypofmRRr63tOsATvlz60+Wh/jAkHbBDW1m06Xp4w2EWccwM0RJ8z8f/KoYWJeOg
	7/fYOrpDpOX/qcMMSetF5V0Yi78zQj8arGJTbiEmJrArgZI7GA1orxcm1ivZa2CO
	9fjaBYSiqaW49sfvXKOO5C6Vu7EeMAP6cSsfUCix4Ifi792kapFAfhH9xCBZ7UNx
	cni79E0bRZxeweolBPXZyKdVQdzJZeeSVMuK1+fX7xGK4fq9qDKhajNSSl7x8Do+
	1dO+VnToeXsnT3eToBYuSmsdNn/I5R3qzZDDED2A==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 47gsphva72-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 27 Jun 2025 15:56:27 +0000 (GMT)
Received: from m0356517.ppops.net (m0356517.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 55RFtCtW014897;
	Fri, 27 Jun 2025 15:56:26 GMT
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 47gsphva6v-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 27 Jun 2025 15:56:26 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 55RC14MI014987;
	Fri, 27 Jun 2025 15:56:25 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 47e72u52rw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 27 Jun 2025 15:56:25 +0000
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 55RFuLZq17498492
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 27 Jun 2025 15:56:21 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 869D720043;
	Fri, 27 Jun 2025 15:56:21 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 1E42A20040;
	Fri, 27 Jun 2025 15:56:20 +0000 (GMT)
Received: from li-008a6a4c-3549-11b2-a85c-c5cc2836eea2.ibm.com (unknown [9.111.0.221])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Fri, 27 Jun 2025 15:56:20 +0000 (GMT)
Date: Fri, 27 Jun 2025 17:56:18 +0200
From: Alexander Gordeev <agordeev@linux.ibm.com>
To: GONG Ruiqi <gongruiqi1@huawei.com>
Cc: Mimi Zohar <zohar@linux.ibm.com>, Roberto Sassu <roberto.sassu@huawei.com>,
        Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
        Jarkko Sakkinen <jarkko@kernel.org>,
        Madhavan Srinivasan <maddy@linux.ibm.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        Eric Snowberg <eric.snowberg@oracle.com>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Nicholas Piggin <npiggin@gmail.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>, "Lee, Chun-Yi" <jlee@suse.com>,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        linux-s390@vger.kernel.org, linux-integrity@vger.kernel.org,
        keyrings@vger.kernel.org, Lu Jialin <lujialin4@huawei.com>
Subject: Re: [PATCH RESEND] integrity: Extract secure boot enquiry function
 out of IMA
Message-ID: <aF6/ItTfd7oVN+Sn@li-008a6a4c-3549-11b2-a85c-c5cc2836eea2.ibm.com>
References: <20250626023617.3885806-1-gongruiqi1@huawei.com>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250626023617.3885806-1-gongruiqi1@huawei.com>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: ZVGn4lXE8Yi5L_H_NMtRZszsX8O1zlVQ
X-Proofpoint-ORIG-GUID: cRmhbyTPAwHuG266gZfp9uPvG-4fDGhs
X-Authority-Analysis: v=2.4 cv=Hul2G1TS c=1 sm=1 tr=0 ts=685ebf2b cx=c_pps a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17 a=kj9zAlcOel0A:10 a=6IFa9wvqVegA:10 a=i0EeH86SAAAA:8 a=MfmPClk6on00Wl0lz3oA:9 a=CjuIK1q_8ugA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjI3MDEyOCBTYWx0ZWRfX6FVFnTWLiZx0 z+RdbizKGA2mloifLyiTyqfs1kKkb6HuDB7ShsfyeOqkPjTZQ2RFoKFT6dgyhrDmqMjux7VWIhh 1sclUvGeNFDf8T/69PdD+yAWPwgTzIPkpYSQDQOOlTU+Q3kohFm9WF7bQSgMvdjoASGwEtnXvcY
 6y+ex2clQaDlEgQmJ06Fff03IWLZROr7C1eXc6Df7d/Z+tqVlulcx8L546Q1zKdlECtopleiyQ2 QhKyVwbYOwhggvmbHlMyekUCKU7JpeaDVC4OBgVMcngHb2SiwhL/a1PfRc+8dEBCYVnzzvPidyN iJlbRUHMzNB2FsUG296X4cX4R6GG8CqcCKCaJA3nmlNYVy7ram2mcjJ09GJWSOVzIvDWMmgtY2B
 mAjNLCSr8qBAq/aNrZEhsp1J54ZLASLtkHcj3YTHS5pQmacwx9wmLyhvEpCo0XcQkn+m54j9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-06-27_05,2025-06-26_05,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0
 mlxlogscore=952 bulkscore=0 mlxscore=0 adultscore=0 spamscore=0
 impostorscore=0 clxscore=1011 priorityscore=1501 lowpriorityscore=0
 suspectscore=0 phishscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2506270128

On Thu, Jun 26, 2025 at 10:36:17AM +0800, GONG Ruiqi wrote:

Hi GONG,

...
> Compile-tested for powerpc, s390 and x86, all with allmodconfig.

This breaks defconfig and debug_defconfig builds on s390
since IMA_ARCH_POLICY=n in these configurations and thus
CONFIG_IMA_SECURE_AND_OR_TRUSTED_BOOT=n as well:

s390x-15.1.0-ld: security/integrity/ima/ima_main.o: in function `ima_load_data':
/home/agordeev/linux.c3/security/integrity/ima/ima_main.c:902:(.text+0x54e): undefined reference to `arch_integrity_get_secureboot'
s390x-15.1.0-ld: security/integrity/ima/ima_appraise.o: in function `ima_appraise_parse_cmdline':
/home/agordeev/linux.c3/security/integrity/ima/ima_appraise.c:30:(.init.text+0x44): undefined reference to `arch_integrity_get_secureboot'
make[2]: *** [scripts/Makefile.vmlinux:91: vmlinux.unstripped] Error 1
make[1]: *** [/home/agordeev/linux.c3/Makefile:1236: vmlinux] Error 2
make: *** [Makefile:248: __sub-make] Error 2

> Signed-off-by: GONG Ruiqi <gongruiqi1@huawei.com>

Thanks!

