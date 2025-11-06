Return-Path: <linux-integrity+bounces-7594-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id DD130C3D914
	for <lists+linux-integrity@lfdr.de>; Thu, 06 Nov 2025 23:16:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 71A0D34E50A
	for <lists+linux-integrity@lfdr.de>; Thu,  6 Nov 2025 22:16:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13FEB2DA760;
	Thu,  6 Nov 2025 22:16:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="ZI9UJQ8x"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0D4323EAAE;
	Thu,  6 Nov 2025 22:16:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762467369; cv=none; b=Key3+CKfq2tFvKFOQvJZFvbiyoCPmMf3nRvYRulKMsGnRl52mLPSnwyRzaOO61qKqo3d0ylCWJ0EfO9XlwJLZEB+GPQGG3p5f2MBn6WZtiRUY0I+k6Vv0aVmMhZSZbnZamiQac1irP5/5PE5jB4fIhs+mGVv7dqGUQ1ZGF9FnTk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762467369; c=relaxed/simple;
	bh=ZIk+AfMZgAYMOTCCjanRLeMZrq0PnmwmS8zTdHALF7Q=;
	h=Message-ID:Subject:From:To:Cc:In-Reply-To:References:Content-Type:
	 Date:MIME-Version; b=TgkPCY4OrzsPnav3G9S9taHg82oIsJhrWQorTIO2tsRnlBZh81DRFN6quvMw5ike8hVf2ISczETFhxxouDpzoiTNPwx+jt5g+vJfG1kuz3U0gj/iMd8uGwV66GdQqB0yECazutkN8I7/V2D4deVNIFZsjUsjDu3YI/xdpcrK2/A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=ZI9UJQ8x; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5A6Gd0Go028252;
	Thu, 6 Nov 2025 22:15:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=SiPPBV
	1cKgzYnuAXoEe9S7za3I6Ag2LuDK3mBAh6v2c=; b=ZI9UJQ8xkEowH1xZwMTkeH
	s4orfbGA1qB1DbcGbpIRSfARKmTd3LkeFN9wJFRo+HwCi+DNvN+YE4QY2zkXAeO7
	kn2LZAUy2ZwCG3hdW/Z3ySTg09op+JqHEBWpoJ/5JnMSpK+6ybVNsw/U1c3NGu0Q
	BEGvHXc5EdCxVdQgbzOPYIDOWOyOHZ8hoNiGJYBjr3z9y5+VKlAva7mqSwwlXZXB
	2exp2zBFuH6j4CcQsCO2du/YNf8BPPk+lG7l9Dx4RkywLw7Xc7uUejfDPcmD6u01
	PxPMNFri0NWuXuxhdfK7cybqODNZAs09L1qvWM64dhVw1GY1glbPYiTKfnuNGceQ
	==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4a59q99qur-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 06 Nov 2025 22:15:38 +0000 (GMT)
Received: from m0360083.ppops.net (m0360083.ppops.net [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 5A6MFcAE022146;
	Thu, 6 Nov 2025 22:15:38 GMT
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4a59q99qum-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 06 Nov 2025 22:15:38 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 5A6IdLFM009822;
	Thu, 6 Nov 2025 22:15:36 GMT
Received: from smtprelay07.dal12v.mail.ibm.com ([172.16.1.9])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4a5x1kqpx3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 06 Nov 2025 22:15:36 +0000
Received: from smtpav05.wdc07v.mail.ibm.com (smtpav05.wdc07v.mail.ibm.com [10.39.53.232])
	by smtprelay07.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 5A6MFZuu29164178
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 6 Nov 2025 22:15:36 GMT
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D275658053;
	Thu,  6 Nov 2025 22:15:35 +0000 (GMT)
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 4D6D158043;
	Thu,  6 Nov 2025 22:15:34 +0000 (GMT)
Received: from li-43857255-d5e6-4659-90f1-fc5cee4750ad.ibm.com (unknown [9.61.50.42])
	by smtpav05.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Thu,  6 Nov 2025 22:15:34 +0000 (GMT)
Message-ID: <b9eb78105115a00731b3677a5f3a39d5dde4d2ec.camel@linux.ibm.com>
Subject: Re: [PATCH v2] lsm,ima: new LSM hook
 security_kernel_module_read_file to access decompressed kernel module
From: Mimi Zohar <zohar@linux.ibm.com>
To: Coiby Xu <coxu@redhat.com>
Cc: Paul Moore <paul@paul-moore.com>, linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org, Karel Srot <ksrot@redhat.com>,
        James
 Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        Luis
 Chamberlain	 <mcgrof@kernel.org>,
        Petr Pavlu <petr.pavlu@suse.com>, Daniel
 Gomez	 <da.gomez@kernel.org>,
        Sami Tolvanen <samitolvanen@google.com>,
        Roberto Sassu	 <roberto.sassu@huawei.com>,
        Dmitry Kasatkin
 <dmitry.kasatkin@gmail.com>,
        Eric Snowberg <eric.snowberg@oracle.com>,
        open list <linux-kernel@vger.kernel.org>,
        "open list:MODULE SUPPORT"
 <linux-modules@vger.kernel.org>
In-Reply-To: <d24wnmefebnheerigmh6ts5yskkutz726l6a2f6g5s3s5fhhrv@osaactobwb5g>
References: <20250928030358.3873311-1-coxu@redhat.com>
	 <20251031074016.1975356-1-coxu@redhat.com>
	 <CAHC9VhRBXkW+XuqhxJvEOYR_VMxFh4TRWUtXzZky=AG_nyBYEQ@mail.gmail.com>
	 <baa39fcd1b6b485f14b8f06dcd96b81359e6e491.camel@linux.ibm.com>
	 <CAHC9VhToe-VNqbh6TY2iYnRvqTHRfQjnHYSRWYgt8K7NcLKMdg@mail.gmail.com>
	 <fftfj4o3kqxmfu3hb655xczqcddoeqjv55llsnwkrdu5isdm4z@6sqe3k24a6kk>
	 <84a0e1785c7f0ff816b3246be49012092ae12126.camel@linux.ibm.com>
	 <d24wnmefebnheerigmh6ts5yskkutz726l6a2f6g5s3s5fhhrv@osaactobwb5g>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Date: Thu, 06 Nov 2025 17:15:33 -0500
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Evolution 3.54.3 (3.54.3-2.fc41) 
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=StmdKfO0 c=1 sm=1 tr=0 ts=690d1e0a cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=IkcTkHD0fZMA:10 a=6UeiqGixMTsA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=NEAV23lmAAAA:8 a=hO0pNDKWLz_cAJWU_XQA:9 a=QEXdDO2ut3YA:10
 a=cPQSjfK2_nFv0Q5t_7PE:22
X-Proofpoint-ORIG-GUID: 2TcC7SZcOWEAivhxNgOLpr4EkIUjPptU
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTAxMDAxOCBTYWx0ZWRfX7dnqnmt6YAZs
 6vIe70aDIPD3i5Vz/yAe1lGDTPhsoeJFv4LKWysYZcaqB5AhZ0LpuOdbYqvShctUCJ1NU/miBxp
 V7tTIyHWxKxfH11I+HI5VpNCtFMOKcI+kAoc+gMOlbdf1sVDtgEsGsTOY9mGv1yX5FFbPNqH01A
 W6Z6l0FaXeBvhksyzAACTWu/Co2I5lwNY1AWvYG6IpNZGndY4j9VLLmCD8tkWek5cBtCdkwJpUP
 dhb7ET6FBhySgLKqVqFvduSKPXcVd5hNFfcByYDJza/5xkz4wMCvd8qMiIuZickBI49+sgdDRAQ
 9XPglZ/3FXQgdX3tPDTapAykC0CWXUF5FEzRmbF4Ek3euo4KMdwVlwW/v9ceQWT6V7QyLoOnwT7
 6KtuygcfsqsqGNBMG/JnJxDFYqpBkA==
X-Proofpoint-GUID: 2sSP0p4LOwrW01N-WrnspT1BYGzsKbWK
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-06_04,2025-11-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 suspectscore=0 phishscore=0 impostorscore=0 priorityscore=1501
 malwarescore=0 clxscore=1015 adultscore=0 bulkscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510240000 definitions=main-2511010018

On Thu, 2025-11-06 at 21:29 +0800, Coiby Xu wrote:
> On Wed, Nov 05, 2025 at 03:47:25PM -0500, Mimi Zohar wrote:
> > On Wed, 2025-11-05 at 08:18 +0800, Coiby Xu wrote:
> [...]
> >=20
> > Hi Coiby,
> >=20
> > Based on the conversation with Paul, there is no reason to remove the e=
xisting
> > security_kernel_post_read_file() call.
> >=20
> > The changes are similar to the 2nd link, but a bit different.
> > - Define a single enumeration named READING_MODULE_COMPRESSED.
> >=20
> > - In module/main.c add a new security_kernel_post_read_file() call imme=
diately
> > after decompressing the kernel module.  Like a previous version of this=
 patch,
> > call kernel_read_file() with either READING_MODULE or READING_MODULE_CO=
MPRESSED
> > based on MODULE_INIT_COMPRESSED_FILE.
> >=20
> > - In ima_post_read_file() defer verifying the signature when the enumer=
ation is
> > READING_MODULE_COMPRESSED.  (No need for a new function ima_read_kernel=
_module.)
>=20
> Hi Mimi,
>=20
> Thanks for summarizing your conversation with Paul! I can confirm Paul's
> approach works
> https://github.com/coiby/linux/tree/in_kernel_decompression_ima_no_lsm_ho=
ok_paul
>=20
> While testing the patch today, I realized there is another
> issue/challenge introduced by in-kernel module decompression. IMA
> appraisal is to verify the digest of compressed kernel module but
> currently the passed buffer is uncompressed module. When IMA uses
> uncompressed module data to calculate the digest, xattr signature
> verification will fail. If we always make IMA read the original kernel
> module data again to calculate the digest, does it look like a
> quick-and-dirty fix? If we can assume people won't load kernel module so
> often, the performance impact is negligible. Otherwise we may have to
> introduce a new LSM hook so IMA can access uncompressed and original
> module data one time.

ima_collect_measurement() stores the file hash info in the iint and uses th=
at
information to verify the signature as stored in the security xattr.=20
Decompressing the kernel module shouldn't affect the xattr signature
verification.

The patch with a few minor changes looks good:

- READDING_MODULE_CHECK -> READING_MODULE_CHECK
- Fix the enumeration name in ima_main.c
- scripts/checkpatch.pl code/comment line length has been relaxed to 100 ch=
ars,
but the section "Breaking long lines and strings" in
Documentation/process/coding-style.rst still recommends 80 characters.

There are cases where it is necessary to go over the 80 char line limit for
readability, but in general both Roberto and I prefer, as much as possible,=
 to
limit the line length to 80 char.  To detect where/when the line limit is
greater than 80 chars, use the scripts/checkpatch.pl "--max-line-length=3D8=
0"
option.

After fixing the patch, please post it to linux-integrity mailing list.

--=20
thanks,

Mimi

