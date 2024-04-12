Return-Path: <linux-integrity+bounces-2060-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B33B98A3729
	for <lists+linux-integrity@lfdr.de>; Fri, 12 Apr 2024 22:40:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3EF9E1F21B9A
	for <lists+linux-integrity@lfdr.de>; Fri, 12 Apr 2024 20:40:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB96722615;
	Fri, 12 Apr 2024 20:40:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="SRnpJcKG"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F0F71FBB
	for <linux-integrity@vger.kernel.org>; Fri, 12 Apr 2024 20:40:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712954441; cv=none; b=fCDp3LW8YRHDcsnV6cndz/ag0IYPhXw7YulNh7B3vhd1++6keXJsxUJAyX7GffXQ2ssTxiY9MBC4q56TnhLX6lsemY5VGNabh2wPzcbSoc1N/PZD9ZmMgi+6HKt1yLoZfE+lPjzIIQs8oCT36C3mDN5wn718JLUKITWkfXeJKDw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712954441; c=relaxed/simple;
	bh=xevAiNnCm6GXKkrruUXrzBoxiEaccliSZ8v3rCJ6ljw=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:Mime-Version; b=a12CXE+OiNctES0p9jHWraWkRHmcYrQKOrqM72t9PknveAlTuvVxqh/1QUCvufuvFC4M1FTFqspk64uaH2gNlK1uRSTj8H3oxmKh6bNd/kTDfNyXQi5ytXmtYkOvoZTLJd2K6LtzFImzZvMZtxXWx10AlfwXnmDE1tsOO3OXbM0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=SRnpJcKG; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353726.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 43CIRFGB019646;
	Fri, 12 Apr 2024 20:40:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 mime-version : content-transfer-encoding; s=pp1;
 bh=b5vHL5L3MAHDFEI0wuZdWpY0BFYJoxcJXoEAiiGJr0Q=;
 b=SRnpJcKGRsnIjsLAnLGK50AFm8LY7/sxBCYMZkmV/5rKp3G4Ay9ooghNhFebgeuaxAeN
 FwJPh5vFvy18ir/T+0kRznZNqU2iLJX0jQewcam7INmP4D51Ci8FyAE7m2fVh2vpBbpI
 ZxH3LPqIP4H/hxIrj826WzHNUtSYXifS1QYvXQF6t/JaeLJ9sMQa2MlqQzYBin8gTZNV
 UH0ZE58Fl3Vvh2LcJqBvzi8M0UmcvKzvklEMW1heYdSnM0+3qBrPJ9DchgOIYn3U51kE
 qwLSpe3H5xskstFNFSFH+3dqTqiHL1uMBCbhaUYa6jrBszlEaoM90T0We0ytCqRrHlAg SA== 
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3xfa89r7ar-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 12 Apr 2024 20:40:28 +0000
Received: from m0353726.ppops.net (m0353726.ppops.net [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 43CKeSFU024496;
	Fri, 12 Apr 2024 20:40:28 GMT
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3xfa89r7ap-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 12 Apr 2024 20:40:28 +0000
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 43CJHsF4019108;
	Fri, 12 Apr 2024 20:40:26 GMT
Received: from smtprelay02.wdc07v.mail.ibm.com ([172.16.1.69])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3xbh40v9pf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 12 Apr 2024 20:40:26 +0000
Received: from smtpav02.dal12v.mail.ibm.com (smtpav02.dal12v.mail.ibm.com [10.241.53.101])
	by smtprelay02.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 43CKeO0J27918986
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 12 Apr 2024 20:40:26 GMT
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 26BCA5805E;
	Fri, 12 Apr 2024 20:40:24 +0000 (GMT)
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B12FA58069;
	Fri, 12 Apr 2024 20:40:23 +0000 (GMT)
Received: from li-5cd3c5cc-21f9-11b2-a85c-a4381f30c2f3.ibm.com (unknown [9.61.48.110])
	by smtpav02.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 12 Apr 2024 20:40:23 +0000 (GMT)
Message-ID: <682c89200ccc1879547715ed1c6f7dc5a7e72c3b.camel@linux.ibm.com>
Subject: Re: [PATCH v7] ima: add crypto agility support for template-hash
 algorithm
From: Mimi Zohar <zohar@linux.ibm.com>
To: Enrico Bravi <enrico.bravi@polito.it>, linux-integrity@vger.kernel.org,
        dmitry.kasatkin@gmail.com
Cc: roberto.sassu@huawei.com, Silvia Sisinni <silvia.sisinni@polito.it>
Date: Fri, 12 Apr 2024 16:40:23 -0400
In-Reply-To: <20240412090951.1893890-1-enrico.bravi@polito.it>
References: <20240412090951.1893890-1-enrico.bravi@polito.it>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5 (3.28.5-23.el8_9) 
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: 4D6znNr95QlktsXIGIocS49RDMEXDVGf
X-Proofpoint-GUID: 7YnL7RkjBFg4Sw_XehNlX78TUoypfjdb
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-12_16,2024-04-09_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 phishscore=0 spamscore=0 mlxlogscore=999 adultscore=0 malwarescore=0
 suspectscore=0 impostorscore=0 priorityscore=1501 mlxscore=0 clxscore=1015
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2404010000 definitions=main-2404120148

On Fri, 2024-04-12 at 11:09 +0200, Enrico Bravi wrote:
> The template hash showed by the ascii_runtime_measurements and
> binary_runtime_measurements is the one calculated using sha1 and there is
> no possibility to change this value, despite the fact that the template
> hash is calculated using the hash algorithms corresponding to all the PCR
> banks configured in the TPM.
> 
> Add the support to retrieve the ima log with the template data hash
> calculated with a specific hash algorithm.
> Add a new file in the securityfs ima directory for each hash algo
> configured in a PCR bank of the TPM. Each new file has the name with
> the following structure:
> 
>         {binary, ascii}_runtime_measurements_<hash_algo_name>
> 
> Legacy files are kept, to avoid breaking existing applications, but as
> symbolic links which point to {binary, ascii}_runtime_measurements_sha1
> files. These two files are created even if a TPM chip is not detected or
> the sha1 bank is not configured in the TPM.
> 
> As example, in the case a TPM chip is present and sha256 is the only
> configured PCR bank, the listing of the securityfs ima directory is the
> following:
> 
> lr--r--r-- [...] ascii_runtime_measurements -> ascii_runtime_measurements_sha1
> -r--r----- [...] ascii_runtime_measurements_sha1
> -r--r----- [...] ascii_runtime_measurements_sha256
> lr--r--r-- [...] binary_runtime_measurements ->
> binary_runtime_measurements_sha1
> -r--r----- [...] binary_runtime_measurements_sha1
> -r--r----- [...] binary_runtime_measurements_sha256
> --w------- [...] policy
> -r--r----- [...] runtime_measurements_count
> -r--r----- [...] violations
> 
> Signed-off-by: Enrico Bravi <enrico.bravi@polito.it>
> Signed-off-by: Silvia Sisinni <silvia.sisinni@polito.it>
> Reviewed-by: Roberto Sassu <roberto.sassu@huawei.com>

Thanks, Enrico.  It's now queued in the next-integrity branch.

Mimi


