Return-Path: <linux-integrity+bounces-2029-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BF93989C93F
	for <lists+linux-integrity@lfdr.de>; Mon,  8 Apr 2024 18:02:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2D37A286008
	for <lists+linux-integrity@lfdr.de>; Mon,  8 Apr 2024 16:02:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C47721411EF;
	Mon,  8 Apr 2024 16:02:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="dyYE7TMW"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A47CB13E893
	for <linux-integrity@vger.kernel.org>; Mon,  8 Apr 2024 16:02:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712592138; cv=none; b=tl7z23FyXQGrAafYSoM9m89Ep4L4/x/fqRUbAF3TK6Ydeieg76kTPjhi3q+dNXEmRdFeHjqMNIRy7TrXvFwIwFKHs1/KFMC2yE09ZLPjHGpmL/vtIvgoPFEpYxxGfSvW5nyEwT0w/+kQZREaCa8NZb6CNQ1bGYNJuu8HASccPfk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712592138; c=relaxed/simple;
	bh=ubJS4khK/uTSkrn4NCeieG1QHcDZRbcXk/tNqcjqEPM=;
	h=Message-ID:Subject:From:To:Cc:In-Reply-To:References:Content-Type:
	 Mime-Version:Date; b=X4HvICRmXz9yYiA1auWj92KsFh2fSi+w4S8nv1VyRTE0QL0yAcF21VErc6szF9colLc1gMiVTkMt2+/Y+/+saq8ZS4vCgX3QNEvOOz1QjUt4ue85UVGXGPXqLIsx4HI0PfBAgXnY7/jCSPMAAutdAXznZKxnZa0Sx/XIMPrEI7Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=dyYE7TMW; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 438Faj1l006023;
	Mon, 8 Apr 2024 16:01:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : in-reply-to : references : content-type : mime-version :
 date : content-transfer-encoding; s=pp1;
 bh=i3bvqQeHI4bWhzxx5cxuCq7xV35EeenuXdfGjiKatjk=;
 b=dyYE7TMWode3kYOiv/37Kys5VOAr55EbFf6bes+pTgfkSw5u3qM5ogSE3UvYPK5KZcYw
 P3d1/p3uJEZBjvfh8atl7t26UvpnebuySGL7Z7FJjwVz4WjHxodLqXF/pRZhyS3z1VIy
 qt/ijzWOMsIgENDm/xgPnRU6llF+H9yf4fPl+YPD1LOPjVAHR/dyNv00uFIITTLSzmeg
 PMrl+JucwI4WyjelkuoSm5gqw7RFaoG3OGcqzsgzzhg5CvltVViy0HRbte7Yc9yMxPFQ
 SPJcNB8JBkikUmh5mn97Pl90FAUnioP4/KSF5hxt6QYQVAR2k1RLmJqB6N0qmes+p0ht oA== 
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3xcjt683yb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 08 Apr 2024 16:01:48 +0000
Received: from m0353725.ppops.net (m0353725.ppops.net [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 438G1mKI010013;
	Mon, 8 Apr 2024 16:01:48 GMT
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3xcjt683y6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 08 Apr 2024 16:01:48 +0000
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 438E0SdS019119;
	Mon, 8 Apr 2024 16:01:47 GMT
Received: from smtprelay05.wdc07v.mail.ibm.com ([172.16.1.72])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3xbh4015ac-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 08 Apr 2024 16:01:47 +0000
Received: from smtpav02.dal12v.mail.ibm.com (smtpav02.dal12v.mail.ibm.com [10.241.53.101])
	by smtprelay05.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 438G1iia16908864
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 8 Apr 2024 16:01:46 GMT
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 806DC58065;
	Mon,  8 Apr 2024 16:01:44 +0000 (GMT)
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 1ED7D5805A;
	Mon,  8 Apr 2024 16:01:44 +0000 (GMT)
Received: from li-5cd3c5cc-21f9-11b2-a85c-a4381f30c2f3.watson.ibm.com (unknown [9.31.110.109])
	by smtpav02.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Mon,  8 Apr 2024 16:01:44 +0000 (GMT)
Message-ID: <b59689cb482eee80586bc20fce4a832bad5246f2.camel@linux.ibm.com>
Subject: Re: [PATCH v5] ima: add crypto agility support for template-hash
 algorithm
From: Mimi Zohar <zohar@linux.ibm.com>
To: Enrico Bravi <enrico.bravi@polito.it>,
        Roberto Sassu
	 <roberto.sassu@huaweicloud.com>,
        linux-integrity@vger.kernel.org, dmitry.kasatkin@gmail.com
Cc: roberto.sassu@huawei.com, Silvia Sisinni <silvia.sisinni@polito.it>
In-Reply-To: <eb69441f-08aa-40b2-a667-437367a83c2a@polito.it>
References: <20240408111727.404486-1-enrico.bravi@polito.it>
	 <b82cceaa6505f75acd7c1702dfc4a70406a0a9d7.camel@huaweicloud.com>
	 <eb69441f-08aa-40b2-a667-437367a83c2a@polito.it>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Date: Mon, 08 Apr 2024 12:01:30 -0400
X-Mailer: Evolution 3.28.5 (3.28.5-23.el8_9) 
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: nYqr7yiSTry2BNIWcju97EJIhC5sVSpL
X-Proofpoint-ORIG-GUID: qlnO82z7_UHrfjJMpHDodFHIdjPd_uiS
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-08_14,2024-04-05_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 suspectscore=0
 clxscore=1011 mlxlogscore=999 phishscore=0 priorityscore=1501
 lowpriorityscore=0 bulkscore=0 malwarescore=0 impostorscore=0 spamscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2404010000 definitions=main-2404080123

On Mon, 2024-04-08 at 17:43 +0200, Enrico Bravi wrote:
> On 08/04/24 13:35, Roberto Sassu wrote:
> > On Mon, 2024-04-08 at 13:17 +0200, Enrico Bravi wrote:
> > > The template hash showed by the ascii_runtime_measurements and
> > > binary_runtime_measurements is the one calculated using sha1 and there is
> > > no possibility to change this value, despite the fact that the template
> > > hash is calculated using the hash algorithms corresponding to all the PCR
> > > banks configured in the TPM.
> > > 
> > > Add the support to retrieve the ima log with the template data hash
> > > calculated with a specific hash algorithm.
> > > Add a new file in the securityfs ima directory for each hash algo
> > > configured in a PCR bank of the TPM. Each new file has the name with
> > > the following structure:
> > > 
> > >         {binary, ascii}_runtime_measurements_<hash_algo_name>
> > > 
> > > Legacy files are kept, to avoid breaking existing applications, but as
> > > symbolic links which point to {binary, ascii}_runtime_measurements_sha1
> > > files. These two files are created even if a TPM chip is not detected or
> > > the sha1 bank is not configured in the TPM.
> > > 
> > > As example, in the case a TPM chip is present and sha256 is the only
> > > configured PCR bank, the listing of the securityfs ima directory is the
> > > following:
> > > 
> > > lr--r--r-- [...] ascii_runtime_measurements ->
> > > ascii_runtime_measurements_sha1
> > > -r--r----- [...] ascii_runtime_measurements_sha1
> > > -r--r----- [...] ascii_runtime_measurements_sha256
> > > lr--r--r-- [...] binary_runtime_measurements ->
> > > binary_runtime_measurements_sha1
> > > -r--r----- [...] binary_runtime_measurements_sha1
> > > -r--r----- [...] binary_runtime_measurements_sha256
> > > --w------- [...] policy
> > > -r--r----- [...] runtime_measurements_count
> > > -r--r----- [...] violations
> > > 
> > > Signed-off-by: Enrico Bravi <enrico.bravi@polito.it>
> > > Signed-off-by: Silvia Sisinni <silvia.sisinni@polito.it>
> > 
> > Reviewed-by: Roberto Sassu <roberto.sassu@huawei.com>
> 
> Thank you Roberto for the tag!
> 
> I noticed an error in the number of changed lines which produces a format
> error
> when applying the patch. I will send shortly a new version which fixes it.
> 
> I'm so sorry about that.
> 

Thanks, Enrico.  Please base it on the next-integrity branch.

Mimi



