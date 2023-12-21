Return-Path: <linux-integrity+bounces-559-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8143081C0C6
	for <lists+linux-integrity@lfdr.de>; Thu, 21 Dec 2023 23:05:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A60F31C20D13
	for <lists+linux-integrity@lfdr.de>; Thu, 21 Dec 2023 22:05:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6359877657;
	Thu, 21 Dec 2023 22:05:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="SRKjo18r"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA319745E6
	for <linux-integrity@vger.kernel.org>; Thu, 21 Dec 2023 22:05:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3BLJONKd029093;
	Thu, 21 Dec 2023 22:05:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 mime-version : content-transfer-encoding; s=pp1;
 bh=wjGNlgs81N+WZ4UHrF5lTKDnPfOfbJ48+JQHaEqIR4w=;
 b=SRKjo18r8VQ64mIXRudM/51rHyn3htwxBFoz1U6zNyWDTKXfLsOZ/YB240OCy8b76spC
 hfq2lMUPJL7wLYxZicN5Cbh8KR00ZzJNnJy9bqAmxZ7kp/Tk9l5CzlrbzxjLgoKrnXNl
 CPXHHa9u+oTI5met8IdWIuQPrV+CpiXxnHJeIqA1IzO+nWfkhHU09W8jY4OdJI1nIatU
 ER72CFdmZkuuj+iSZiojFh/sTSsgLqb46KwAAOqs5ULAOjo5KukL38nnJZqaI1TGaohN
 P4u9cyiv4yrEXdUNjj9eZvghEWK9gS0VNBpfXseY0U7zK6pZ27mMAnBDTvOctJoF6W9m iw== 
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3v4ug6u96a-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 21 Dec 2023 22:05:03 +0000
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 3BLLwgEq010840;
	Thu, 21 Dec 2023 22:05:02 GMT
Received: from smtprelay01.wdc07v.mail.ibm.com ([172.16.1.68])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3v1q7nyqmg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 21 Dec 2023 22:05:02 +0000
Received: from smtpav03.dal12v.mail.ibm.com (smtpav03.dal12v.mail.ibm.com [10.241.53.102])
	by smtprelay01.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 3BLM52sM27329186
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 21 Dec 2023 22:05:02 GMT
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 0974958063;
	Thu, 21 Dec 2023 22:05:02 +0000 (GMT)
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 842745803F;
	Thu, 21 Dec 2023 22:05:01 +0000 (GMT)
Received: from li-f45666cc-3089-11b2-a85c-c57d1a57929f.ibm.com (unknown [9.61.90.58])
	by smtpav03.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 21 Dec 2023 22:05:01 +0000 (GMT)
Message-ID: <89cea05a61ac4616774446683bf612165ba2f43c.camel@linux.ibm.com>
Subject: Re: [RFC][PATCH] ima: add crypto agility support for template-hash
 algorithm
From: Mimi Zohar <zohar@linux.ibm.com>
To: Enrico Bravi <enrico.bravi@polito.it>, linux-integrity@vger.kernel.org,
        roberto.sassu@huawei.com
Cc: Silvia Sisinni <silvia.sisinni@polito.it>
Date: Thu, 21 Dec 2023 17:05:00 -0500
In-Reply-To: <a27cd216-ab70-46a1-8c2c-4640728c99b2@polito.it>
References: <20231214145152.36985-1-enrico.bravi@polito.it>
	 <8bf7eaf170cf609fb4280475d3340179283fd196.camel@linux.ibm.com>
	 <a27cd216-ab70-46a1-8c2c-4640728c99b2@polito.it>
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
X-Proofpoint-GUID: _AEhC9MZhr2ky6VdYHC_Qra_qZWscacZ
X-Proofpoint-ORIG-GUID: _AEhC9MZhr2ky6VdYHC_Qra_qZWscacZ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-21_10,2023-12-21_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 adultscore=0
 spamscore=0 clxscore=1015 malwarescore=0 bulkscore=0 impostorscore=0
 priorityscore=1501 mlxlogscore=999 mlxscore=0 phishscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2312210168

On Thu, 2023-12-21 at 15:38 +0100, Enrico Bravi wrote:
> Hi Mimi,
> 
> thank you for your feedback.
> 
> On 19/12/23 21:54, Mimi Zohar wrote:
> > Hi Enrico,
> > 
> > On Thu, 2023-12-14 at 15:51 +0100, Enrico Bravi wrote:
> >> The purpose of this patch is to add the possibility to configure the hash
> >> algorithm to use when calculating the template-hash.
> > 
> > The patch description should be written in the imperative mood.  For an
> > explanation, please refer to "Describe your changes" in
> > Documentation/process/submitting-patches.rst.>
> > For example:
> > 
> > The second field of the IMA measurement list, the template data hash,
> > contains a fixed sized SHA1 digest.  Add support to replace the SHA1
> > digest with other hash algorithms.  For backwards compatability, only
> > the new larger digests will be prefixed with ...
> > 
> >> The ima_template_hash command line parameter has been introduced to enable
> >> this configuration.
> > 
> > The term "ima_template_hash" could be misconstrued to refer to the hash
> > algorithm used to calculate the file digest.  To differentiate between
> > the hash algorithm used to calculate the file digest, the term
> > 'ima_template_data_hash' is longer, but I think clearer.
> 
> Yes you're right, this name is ambiguous.
> 
> >> The entry will contain the hash_algo_name before the actual template-hash,
> >> separated by a colon (:).
> > 
> > This chnage will break existing userspace applications, unless the SHA1
> > digest isn't prefixed.
> 
> Yes, in the current patch, this value is present even in the case of SHA1. We
> can modifying the patch by omitting it in the case of SHA1; as an alternative,
> the addition of the hash algorithm information can be made configurable in the
> ima log to maintain backward compatibility with existing applications.

After thinking about this some more, I realized that we didn't discuss
carrying the measurement list across kexec.   How will the kexec'ed
kernel be able to differentiate between the original and new
measurement list?   Neither the Kconfig nor making SHA1 backwards
compatible address this.   How will attestation servers be able to
differentiate between the two logs?

Obviously the new measurement list with larger digests won't be
backwards compatible. Can we support carrying the original measurement
list across kexec to a new kernel?

As long we're making changes to the IMA measurement list, we should
mention that we could include multiple digests, but I don't think it is
necessary.

> >> An example of the resulting ima log is the following:
> >>
> >> 10 sha256:64326[...]25313 ima-ng sha1:5fc9b[...]974e6 boot_aggregate
> >> 10 sha256:afd64[...]e3123 ima-ng sha1:5a493[...]f9566 /init
> >> 10 sha256:99329[...]a6353 ima-ng sha1:8c87d[...]3d8c7 /usr/bin/sh
> >> 10 sha256:a16ad[...]2ac0e ima-ng sha1:59d4b[...]330b0 /etc/ld.so.cache

The template DATA_FMT_DIGEST_WITH_ALGO field is a composite field
defined as <hash algo> + ':' + '\0' + digest.   The above ascii display
looks like the template composite field, but isn't.  It is two separate
fields.  Perhaps it should look differently as well.   Consider instead
of a string use the hash_algo value (include/uapi/linux/hash_info.h).

binary measurement log:  <pcr> <hash_algo> <digest_len> <digest>

-- 
thanks,

Mimi


