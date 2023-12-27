Return-Path: <linux-integrity+bounces-574-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C5A6081EF4B
	for <lists+linux-integrity@lfdr.de>; Wed, 27 Dec 2023 15:04:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 57BD71F21E15
	for <lists+linux-integrity@lfdr.de>; Wed, 27 Dec 2023 14:04:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F25124500F;
	Wed, 27 Dec 2023 14:04:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="p3ERahDh"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40A6945010
	for <linux-integrity@vger.kernel.org>; Wed, 27 Dec 2023 14:03:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353724.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3BRCJ2wW001545;
	Wed, 27 Dec 2023 14:03:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 mime-version : content-transfer-encoding; s=pp1;
 bh=nBoj/EwX1ohW7VnZXeK68ZIm1epsvBvrY9PaBtBNjXE=;
 b=p3ERahDhjncAZF1zDY9qMDsXryN6KdH/uTOsCYH5GqHaVagJ9PaCKNmAAvlXEgXZhNwV
 NQlStylAU0k962Jw+QKClcuBz/M4FqiI9/pP/sWXw33KcSAM22L4cwOFsNEPbyRsLrrF
 eA8iLNdBgNUUeEzYNdgBaeDdAA3UeupQmziHynIPYUykI2oM7zKHATBJiXE0yB4mh8ie
 kpypWH5q95orUEUMKB6fga5HJUDkk/wjmjyqxoXAJJ7q7Yx0eoJPE+TwDTGYt0UuuGgZ
 lcRmNh3txu5Z2NuKNgHW8DOp3SclLGi+3LOIiMtXcOfXvDp0SefBWJjx7RGjuF3y6T5L Bg== 
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3v8kts1tm4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 27 Dec 2023 14:03:42 +0000
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 3BRC9Vjj008281;
	Wed, 27 Dec 2023 14:03:42 GMT
Received: from smtprelay03.wdc07v.mail.ibm.com ([172.16.1.70])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 3v6ck1sy2e-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 27 Dec 2023 14:03:42 +0000
Received: from smtpav02.dal12v.mail.ibm.com (smtpav02.dal12v.mail.ibm.com [10.241.53.101])
	by smtprelay03.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 3BRE3fkl23134764
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 27 Dec 2023 14:03:41 GMT
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 0F1135806D;
	Wed, 27 Dec 2023 14:03:41 +0000 (GMT)
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A632C58065;
	Wed, 27 Dec 2023 14:03:40 +0000 (GMT)
Received: from li-f45666cc-3089-11b2-a85c-c57d1a57929f.ibm.com (unknown [9.61.80.254])
	by smtpav02.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 27 Dec 2023 14:03:40 +0000 (GMT)
Message-ID: <b1925a98aff62183790f8d68e473bcaaac8891e3.camel@linux.ibm.com>
Subject: Re: [RFC][PATCH] ima: add crypto agility support for template-hash
 algorithm
From: Mimi Zohar <zohar@linux.ibm.com>
To: Ken Goldman <kgold@linux.ibm.com>,
        "Guozihua (Scott)"
 <guozihua@huawei.com>,
        Enrico Bravi <enrico.bravi@polito.it>, linux-integrity@vger.kernel.org,
        roberto.sassu@huawei.com
Cc: Silvia Sisinni <silvia.sisinni@polito.it>
Date: Wed, 27 Dec 2023 09:03:40 -0500
In-Reply-To: <3da78a77-9bfb-45c7-9979-2dba6fe27f37@linux.ibm.com>
References: <20231214145152.36985-1-enrico.bravi@polito.it>
	 <8bf7eaf170cf609fb4280475d3340179283fd196.camel@linux.ibm.com>
	 <a27cd216-ab70-46a1-8c2c-4640728c99b2@polito.it>
	 <89cea05a61ac4616774446683bf612165ba2f43c.camel@linux.ibm.com>
	 <46e0fd93-86f6-bdf9-99d4-1ccf83f88afe@huawei.com>
	 <3da78a77-9bfb-45c7-9979-2dba6fe27f37@linux.ibm.com>
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
X-Proofpoint-ORIG-GUID: WulnTPHz_X6nLcMt0kdfYCl7N8yUNMB9
X-Proofpoint-GUID: WulnTPHz_X6nLcMt0kdfYCl7N8yUNMB9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-27_08,2023-12-27_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 mlxlogscore=999
 phishscore=0 mlxscore=0 lowpriorityscore=0 adultscore=0 impostorscore=0
 spamscore=0 priorityscore=1501 suspectscore=0 clxscore=1011 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311290000
 definitions=main-2312270104

On Tue, 2023-12-26 at 10:36 -0500, Ken Goldman wrote:
> 
> On 12/25/2023 8:00 AM, Guozihua (Scott) wrote:
> >> After thinking about this some more, I realized that we didn't discuss
> >> carrying the measurement list across kexec.   How will the kexec'ed
> >> kernel be able to differentiate between the original and new
> >> measurement list?   Neither the Kconfig nor making SHA1 backwards
> >> compatible address this.   How will attestation servers be able to
> >> differentiate between the two logs?
> >>
> >> Obviously the new measurement list with larger digests won't be
> >> backwards compatible. Can we support carrying the original measurement
> >> list across kexec to a new kernel?
> >>
> >> As long we're making changes to the IMA measurement list, we should
> >> mention that we could include multiple digests, but I don't think it is
> >> necessary.
> >>
> >>>>> An example of the resulting ima log is the following:
> >>>>>
> >>>>> 10 sha256:64326[...]25313 ima-ng sha1:5fc9b[...]974e6 boot_aggregate
> >>>>> 10 sha256:afd64[...]e3123 ima-ng sha1:5a493[...]f9566 /init
> >>>>> 10 sha256:99329[...]a6353 ima-ng sha1:8c87d[...]3d8c7 /usr/bin/sh
> >>>>> 10 sha256:a16ad[...]2ac0e ima-ng sha1:59d4b[...]330b0 /etc/ld.so.cache
> >> The template DATA_FMT_DIGEST_WITH_ALGO field is a composite field
> >> defined as <hash algo> + ':' + '\0' + digest.   The above ascii display
> >> looks like the template composite field, but isn't.  It is two separate
> >> fields.  Perhaps it should look differently as well.   Consider instead
> >> of a string use the hash_algo value (include/uapi/linux/hash_info.h).
> >>
> >> binary measurement log:  <pcr> <hash_algo> <digest_len> <digest>
> >>
> > Hi Mimi and Enrico,
> > 
> > As we are extending all supported algorithms of a PCR bank, does
> > algorithm of template-hash still matters?
> > 
> 
>  From a security and verification viewpoint, I think you are correct. 
> The template hash is redundant, and can always be calculated from the 
> template data. In that sense, the template hash can be removed.
> 
> On the other hand there is one benefit to the template hash. If there is 
> a bug in the software that creates the event log or the software that 
> consumes the event log, the template hash may help to determine which 
> event has a bug.
> 
> If the new event log has a template hash, I do believe that it also 
> needs a hash algorithm.

Scott are you asking, since the template data hash is redudant, why
bother changing the measurement list format to support other digest
algorithms?   After removing the SHA1 digest, perhaps SHA1 would not
need to be configured in the kernel.

-- 
thanks,

Mimi



