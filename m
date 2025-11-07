Return-Path: <linux-integrity+bounces-7606-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 43CD5C416FE
	for <lists+linux-integrity@lfdr.de>; Fri, 07 Nov 2025 20:28:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id BBD4E34A0B6
	for <lists+linux-integrity@lfdr.de>; Fri,  7 Nov 2025 19:28:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3986B2FFF9A;
	Fri,  7 Nov 2025 19:28:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="AqmzvWXS"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 843861D61A3;
	Fri,  7 Nov 2025 19:28:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762543724; cv=none; b=cP9NXhSxVWINtA9+m7ywctpwcHlbcPeBIXU9ZOp21i/0epD3PXl7tEdk3RA90ZsLSTEbNc6vq4+k/yZNILJ0WMPmxeAhjD9lmADMakobK6K2aY2da5Jpb8qcFMySTZdtFBhaDUkK80azaXD/9S+7gbNE0kQtjI4YcomXqcZN9J8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762543724; c=relaxed/simple;
	bh=ya4XpoRY6qfeCfP5tVgi2q6BSc1XdmfS1j7EHD9hYco=;
	h=Message-ID:Subject:From:To:Cc:In-Reply-To:References:Content-Type:
	 Date:MIME-Version; b=NfwVc+1Ytq3SaQAwIiBF+Otx5ql/CmVk6KIVH5I+LxYJw5FSvb36fPTz7Ke3NBnYKFQoHxFIMYoUiFtgUZ8WHxVQ01n36RLNmNtN50T9nOHrh8G/4lQoHGa+b3/BR9+XETa1qoMfDWFpzsWN0j54SA8BQixPuhIeLcW32+unk8w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=AqmzvWXS; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5A7INt3L001089;
	Fri, 7 Nov 2025 19:28:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=CT9azk
	Ev/aPtf/U6S3mJQlo0hHAnCMMMWFmhZQVC0Bs=; b=AqmzvWXSjxnAtcW2KlqW/b
	uk/KEJeVYJp9G/ESqYAWuKT7YDGTQiCWwhVMH587OgAZLs8Y2saqhIU7gOkocyIG
	C5jNzu5j+6sT8NWF1RNrNPoSLjCIY1q8IljRzZnJIGU20ZkyUa2Up05xraZedHwF
	QhQtqyIDCVhcTR+NxNnlk+ui/qqcsO+I5R5NWGc4W8QfAu5K36G7AqbggJ05JVKR
	bEaaYUg+7TiCW4nE1XAf1wBcc3UPNExFdHTn+XHtLoNlHNwgwX4B8ayPShmNx427
	h4/TX4eKUxLcFNh3hKwYh0smnQiDuCEELIs/wfmQHqvSrkUDxxCsmBSvO2IYdZfw
	==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4a9p0j886b-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 07 Nov 2025 19:28:17 +0000 (GMT)
Received: from m0353725.ppops.net (m0353725.ppops.net [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 5A7JSHtC001165;
	Fri, 7 Nov 2025 19:28:17 GMT
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4a9p0j8869-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 07 Nov 2025 19:28:17 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 5A7J40k9012845;
	Fri, 7 Nov 2025 19:28:16 GMT
Received: from smtprelay07.dal12v.mail.ibm.com ([172.16.1.9])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4a5y82c7t6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 07 Nov 2025 19:28:16 +0000
Received: from smtpav01.wdc07v.mail.ibm.com (smtpav01.wdc07v.mail.ibm.com [10.39.53.228])
	by smtprelay07.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 5A7JSF6U61604208
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 7 Nov 2025 19:28:15 GMT
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 7068E5805B;
	Fri,  7 Nov 2025 19:28:15 +0000 (GMT)
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E701658065;
	Fri,  7 Nov 2025 19:28:13 +0000 (GMT)
Received: from li-43857255-d5e6-4659-90f1-fc5cee4750ad.ibm.com (unknown [9.61.10.204])
	by smtpav01.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Fri,  7 Nov 2025 19:28:13 +0000 (GMT)
Message-ID: <0dfec96bf98b1c18d51bf40f4329c3ede48a9f32.camel@linux.ibm.com>
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
In-Reply-To: <b9eb78105115a00731b3677a5f3a39d5dde4d2ec.camel@linux.ibm.com>
References: <20250928030358.3873311-1-coxu@redhat.com>
		 <20251031074016.1975356-1-coxu@redhat.com>
		 <CAHC9VhRBXkW+XuqhxJvEOYR_VMxFh4TRWUtXzZky=AG_nyBYEQ@mail.gmail.com>
		 <baa39fcd1b6b485f14b8f06dcd96b81359e6e491.camel@linux.ibm.com>
		 <CAHC9VhToe-VNqbh6TY2iYnRvqTHRfQjnHYSRWYgt8K7NcLKMdg@mail.gmail.com>
		 <fftfj4o3kqxmfu3hb655xczqcddoeqjv55llsnwkrdu5isdm4z@6sqe3k24a6kk>
		 <84a0e1785c7f0ff816b3246be49012092ae12126.camel@linux.ibm.com>
		 <d24wnmefebnheerigmh6ts5yskkutz726l6a2f6g5s3s5fhhrv@osaactobwb5g>
	 <b9eb78105115a00731b3677a5f3a39d5dde4d2ec.camel@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Date: Fri, 07 Nov 2025 14:28:13 -0500
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Evolution 3.54.3 (3.54.3-2.fc41) 
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: SWk1h8H8EKXKk4tVyYBO4d8kvL87jVtJ
X-Authority-Analysis: v=2.4 cv=J9enLQnS c=1 sm=1 tr=0 ts=690e4851 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=IkcTkHD0fZMA:10 a=6UeiqGixMTsA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=NEAV23lmAAAA:8 a=IliqzFzewkCn4H2RUJwA:9 a=QEXdDO2ut3YA:10
 a=cPQSjfK2_nFv0Q5t_7PE:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTA3MDE1MiBTYWx0ZWRfX0NYW7h31FCur
 tbaEeK1gYjegkO4EMTERjNLsUVF6EYsogD8Idldq+fisZZuCBg468Lsbnrhqv/ClCmAtp5h3eAn
 wdVq50RbY9L3dMbBpvpMO/WSvwYsVFVKiFjpojBW/ksi5wMOanNXybrK0oYJ6ewPfuFBhpWijMP
 Ts71tqGQxV0rZW/CnFTlyalFSFGgBxbbnEr0aptuo1ptY3rtfNbuP6OZO8P4tGr09WFhBL51F+P
 +fCxcgRqQZHVlrALdu6Lu+BZHqs5nJTQ+M/8Q6vt9KYuFiTLAvU6d8M28pU4XRqNpeEUarv75zF
 ABrleeQUzUXh30hL4jm6qdpWzu5/3/S1enU/RHhshrzHj6Zvjw5S1PH5lEd0je5V7wpTzdDUket
 ttkiQPJ6uCiX2qx4jhwJHc4vKfGKNQ==
X-Proofpoint-GUID: Aw6UjcjfIaXneqyNXx7vGWc1oBiiQAa0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-07_05,2025-11-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 impostorscore=0 malwarescore=0 phishscore=0 suspectscore=0
 bulkscore=0 adultscore=0 priorityscore=1501 spamscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510240000 definitions=main-2511070152

On Thu, 2025-11-06 at 17:15 -0500, Mimi Zohar wrote:
> On Thu, 2025-11-06 at 21:29 +0800, Coiby Xu wrote:
> > On Wed, Nov 05, 2025 at 03:47:25PM -0500, Mimi Zohar wrote:
> > > On Wed, 2025-11-05 at 08:18 +0800, Coiby Xu wrote:
> > [...]
> > >=20
> > > Hi Coiby,
> > >=20
> > > Based on the conversation with Paul, there is no reason to remove the=
 existing
> > > security_kernel_post_read_file() call.
> > >=20
> > > The changes are similar to the 2nd link, but a bit different.
> > > - Define a single enumeration named READING_MODULE_COMPRESSED.
> > >=20
> > > - In module/main.c add a new security_kernel_post_read_file() call im=
mediately
> > > after decompressing the kernel module.  Like a previous version of th=
is patch,
> > > call kernel_read_file() with either READING_MODULE or READING_MODULE_=
COMPRESSED
> > > based on MODULE_INIT_COMPRESSED_FILE.
> > >=20
> > > - In ima_post_read_file() defer verifying the signature when the enum=
eration is
> > > READING_MODULE_COMPRESSED.  (No need for a new function ima_read_kern=
el_module.)
> >=20
> > Hi Mimi,
> >=20
> > Thanks for summarizing your conversation with Paul! I can confirm Paul'=
s
> > approach works
> > https://github.com/coiby/linux/tree/in_kernel_decompression_ima_no_lsm_=
hook_paul
> >=20
> > While testing the patch today, I realized there is another
> > issue/challenge introduced by in-kernel module decompression. IMA
> > appraisal is to verify the digest of compressed kernel module but
> > currently the passed buffer is uncompressed module. When IMA uses
> > uncompressed module data to calculate the digest, xattr signature
> > verification will fail. If we always make IMA read the original kernel
> > module data again to calculate the digest, does it look like a
> > quick-and-dirty fix? If we can assume people won't load kernel module s=
o
> > often, the performance impact is negligible. Otherwise we may have to
> > introduce a new LSM hook so IMA can access uncompressed and original
> > module data one time.
>=20
> ima_collect_measurement() stores the file hash info in the iint and uses =
that
> information to verify the signature as stored in the security xattr.=20
> Decompressing the kernel module shouldn't affect the xattr signature
> verification.

In the case when the compressed kernel module hasn't previously been measur=
ed or
appraised before loading the kernel module, we need to "collect" the file d=
ata
hash on READING_MODULE_COMPRESSED, but defer appraising/measuring it.

An alternative to your suggestion of re-reading the original kernel module =
data
to calculate the digest or defining a new hook, would be to define "collect=
" as
a new "action" and pass the kernel_read_file_id enumeration to
process_measurement().  IMA_COLLECTED already exists.  Only IMA_COLLECT wou=
ld
need to be defined.  The new collect "action" should be limited to
func=3DMODULE_CHECK.

The downside of this alternative is that it requires a new collect rule:
collect func=3DMODULE_CHECK mask=3DMAY_READ uid=3D0
appraise func=3DMODULE_CHECK appraise_type=3Dimasig|modsig

--=20
thanks,

Mimi

