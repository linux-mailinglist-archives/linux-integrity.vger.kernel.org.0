Return-Path: <linux-integrity+bounces-283-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B26927FDC45
	for <lists+linux-integrity@lfdr.de>; Wed, 29 Nov 2023 17:10:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E44C21C20926
	for <lists+linux-integrity@lfdr.de>; Wed, 29 Nov 2023 16:10:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4967A381A6;
	Wed, 29 Nov 2023 16:10:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="U141GIXe"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C088610A
	for <linux-integrity@vger.kernel.org>; Wed, 29 Nov 2023 08:10:45 -0800 (PST)
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3ATFvOc3031799
	for <linux-integrity@vger.kernel.org>; Wed, 29 Nov 2023 16:10:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : date : in-reply-to : references : content-type : mime-version
 : content-transfer-encoding; s=pp1;
 bh=JvRBcVviiYXZGtx3C0ufaV07tXGUXzpgkWJ10JE0OQw=;
 b=U141GIXeSZ10clBCJe65hTr9WGYa2CbRKHcvasoeGzNHZE0nVAGbQ3R3qJb4+V00R29j
 SurKgFbgVwvE6ZCaEmhb/v0SiwbQ4S5msY/1LgNGfc/MsGahg7sfucFTRYL78IrlT/tL
 wDEPzPXOUgfXPDplXt+4jWT7+7gq/nYFF+6xZIAZ8+kKuZi74CIEWHWIm0BiWz9Ro3wi
 3SvMIaqhDBI48ydQu9HY7W8YSbKuvWMSG/nPC1tnloGHnsavkIfDi2ZFScHabnGqY+o3
 JV26wzy7yAUMClnrRM+CNO0YEvKLx8U4e9Cw7gewnaIQzDSO5vTDY6NUQrp7RN+aCfel Cw== 
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3up7ps9ugj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-integrity@vger.kernel.org>; Wed, 29 Nov 2023 16:10:43 +0000
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 3ATEInDO014744
	for <linux-integrity@vger.kernel.org>; Wed, 29 Nov 2023 16:08:11 GMT
Received: from smtprelay04.wdc07v.mail.ibm.com ([172.16.1.71])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3ukumyrebw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-integrity@vger.kernel.org>; Wed, 29 Nov 2023 16:08:11 +0000
Received: from smtpav06.wdc07v.mail.ibm.com (smtpav06.wdc07v.mail.ibm.com [10.39.53.233])
	by smtprelay04.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 3ATG8Ald41812306
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 29 Nov 2023 16:08:10 GMT
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 1884C5804E;
	Wed, 29 Nov 2023 16:08:10 +0000 (GMT)
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A13DF5803F;
	Wed, 29 Nov 2023 16:08:09 +0000 (GMT)
Received: from li-f45666cc-3089-11b2-a85c-c57d1a57929f.ibm.com (unknown [9.61.29.194])
	by smtpav06.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 29 Nov 2023 16:08:09 +0000 (GMT)
Message-ID: <13e85919b1a01a1161ac68a72f8a7bf1f23c08fd.camel@linux.ibm.com>
Subject: Re: [ima-evm-utils PATCH 09/12] Use a local hash algorithm variable
 when verifying file signatures
From: Mimi Zohar <zohar@linux.ibm.com>
To: Stefan Berger <stefanb@linux.ibm.com>, linux-integrity@vger.kernel.org
Date: Wed, 29 Nov 2023 11:08:09 -0500
In-Reply-To: <7042007c-dcc5-404b-878c-f5f36f9fb5af@linux.ibm.com>
References: <20231119165043.46960-1-zohar@linux.ibm.com>
	 <20231119165043.46960-10-zohar@linux.ibm.com>
	 <93aa5f57-fd8a-475f-a1b8-c8d00772b251@linux.ibm.com>
	 <afbc47db6e3041bba6602d2dbd3c392ae2ac9d2e.camel@linux.ibm.com>
	 <7042007c-dcc5-404b-878c-f5f36f9fb5af@linux.ibm.com>
Content-Type: text/plain; charset="ISO-8859-15"
X-Mailer: Evolution 3.28.5 (3.28.5-22.el8) 
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: pwrYFSXsF924HdIbXHBZCkjxE_frjmfo
X-Proofpoint-ORIG-GUID: pwrYFSXsF924HdIbXHBZCkjxE_frjmfo
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-29_14,2023-11-29_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 impostorscore=0
 malwarescore=0 spamscore=0 priorityscore=1501 mlxscore=0 adultscore=0
 mlxlogscore=999 lowpriorityscore=0 phishscore=0 suspectscore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311060000 definitions=main-2311290122

On Wed, 2023-11-22 at 09:33 -0500, Stefan Berger wrote:
> 
> On 11/22/23 09:14, Mimi Zohar wrote:
> > On Wed, 2023-11-22 at 08:37 -0500, Stefan Berger wrote:
> >>
> 
> >> Now you are passing valid parameters into verify_hash2(). Would it not
> >> be possible to drop 4/12?
> > 
> > Just as we can't modify the library verify_hash() definition, I don't
> > think we should be modifying the verify_hash2() defintion either.
> > 04/12 defines and exports the final verify_hash2() definition.
> > 
> 
> The question is whether verify_hash2() can be only introduced here in 
> versus made available in 4/12 with a parameter that it doesn't use at 
> all at that point.

Correct, however 6/12 "Update cmd_verify_evm to define and use a local
list of public keys" calls verify_hash2().

-- 
thanks,

Mimi


