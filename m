Return-Path: <linux-integrity+bounces-545-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F1048191BE
	for <lists+linux-integrity@lfdr.de>; Tue, 19 Dec 2023 21:54:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C24C21C24E9D
	for <lists+linux-integrity@lfdr.de>; Tue, 19 Dec 2023 20:54:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06C1A39AEA;
	Tue, 19 Dec 2023 20:54:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="KxZQ3UDy"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8F3D39AC5
	for <linux-integrity@vger.kernel.org>; Tue, 19 Dec 2023 20:54:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3BJJKIG7030868;
	Tue, 19 Dec 2023 20:54:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 content-transfer-encoding : mime-version; s=pp1;
 bh=AU1usG5XdRDSCWGFfZCSJ5raOiGmZTulNTZJJxFk0hw=;
 b=KxZQ3UDyZPtPKwGQIc2gkgu5La+0lLctbIKG5gfKhqeKCt0Te0hqzVQI40noJxKNK1C/
 FCuI03UoNVn6ailaw6nsgS7h8Cvky5zLOEmVnrz6KBnI8tt/SgkCPCTlEfWxLsnDHI3T
 R2IbZDj6evOUfpTNHttF4CneckxBpw/AFP1i/EOKxoMEt1yUjutgMieir/cfDj7VCWVf
 Ab7RpjLvn7cNl41tzAFMfCQ66LCPDwiUrY2MTBfP7pKJZhd2WzzmcrNHj8o8Mi1QQsFe
 Pse1jOOwvCUNyju7Z0eDBBH/0gAAht8nJDqSQs6zeUdSlj0Op2pxKkrVcg9Opqy/wSyG 4A== 
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3v3gx8tjvr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 19 Dec 2023 20:54:06 +0000
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 3BJImMcZ013893;
	Tue, 19 Dec 2023 20:54:05 GMT
Received: from smtprelay07.dal12v.mail.ibm.com ([172.16.1.9])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3v1qqka756-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 19 Dec 2023 20:54:05 +0000
Received: from smtpav06.wdc07v.mail.ibm.com (smtpav06.wdc07v.mail.ibm.com [10.39.53.233])
	by smtprelay07.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 3BJKs47t28508676
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 19 Dec 2023 20:54:05 GMT
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C0B8A5804E;
	Tue, 19 Dec 2023 20:54:04 +0000 (GMT)
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 3AA3A5803F;
	Tue, 19 Dec 2023 20:54:04 +0000 (GMT)
Received: from li-f45666cc-3089-11b2-a85c-c57d1a57929f.ibm.com (unknown [9.61.42.19])
	by smtpav06.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 19 Dec 2023 20:54:04 +0000 (GMT)
Message-ID: <8bf7eaf170cf609fb4280475d3340179283fd196.camel@linux.ibm.com>
Subject: Re: [RFC][PATCH] ima: add crypto agility support for template-hash
 algorithm
From: Mimi Zohar <zohar@linux.ibm.com>
To: Enrico Bravi <enrico.bravi@polito.it>, linux-integrity@vger.kernel.org,
        roberto.sassu@huawei.com
Cc: Silvia Sisinni <silvia.sisinni@polito.it>
Date: Tue, 19 Dec 2023 15:54:03 -0500
In-Reply-To: <20231214145152.36985-1-enrico.bravi@polito.it>
References: <20231214145152.36985-1-enrico.bravi@polito.it>
Content-Type: text/plain; charset="ISO-8859-15"
X-Mailer: Evolution 3.28.5 (3.28.5-22.el8) 
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: xnsRdWabxysfuC5C4rPIvJKf7oVTqBn7
X-Proofpoint-ORIG-GUID: xnsRdWabxysfuC5C4rPIvJKf7oVTqBn7
Content-Transfer-Encoding: 7bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-19_12,2023-12-14_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 suspectscore=0 mlxscore=0 priorityscore=1501 spamscore=0 bulkscore=0
 phishscore=0 malwarescore=0 clxscore=1011 mlxlogscore=999 adultscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2312190154

Hi Enrico,

On Thu, 2023-12-14 at 15:51 +0100, Enrico Bravi wrote:
> The purpose of this patch is to add the possibility to configure the hash
> algorithm to use when calculating the template-hash.

The patch description should be written in the imperative mood.  For an
explanation, please refer to "Describe your changes" in
Documentation/process/submitting-patches.rst.

For example:

The second field of the IMA measurement list, the template data hash,
contains a fixed sized SHA1 digest.  Add support to replace the SHA1
digest with other hash algorithms.  For backwards compatability, only
the new larger digests will be prefixed with ...

> The ima_template_hash command line parameter has been introduced to enable
> this configuration.

The term "ima_template_hash" could be misconstrued to refer to the hash
algorithm used to calculate the file digest.  To differentiate between
the hash algorithm used to calculate the file digest, the term
'ima_template_data_hash' is longer, but I think clearer.

> The entry will contain the hash_algo_name before the actual template-hash,
> separated by a colon (:).

This chnage will break existing userspace applications, unless the SHA1
digest isn't prefixed.

> An example of the resulting ima log is the following:
> 
> 10 sha256:64326[...]25313 ima-ng sha1:5fc9b[...]974e6 boot_aggregate
> 10 sha256:afd64[...]e3123 ima-ng sha1:5a493[...]f9566 /init
> 10 sha256:99329[...]a6353 ima-ng sha1:8c87d[...]3d8c7 /usr/bin/sh
> 10 sha256:a16ad[...]2ac0e ima-ng sha1:59d4b[...]330b0 /etc/ld.so.cache
> 
> This patch has been created starting from the master branch of the main tree:
> <git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git>

With the base-commit included at the end of the cover letter, this
comment is unnessary.  Please remove.

thanks,

Mimi

> 
> Signed-off-by: Silvia Sisinni <silvia.sisinni@polito.it>
> Signed-off-by: Enrico Bravi <enrico.bravi@polito.it>





