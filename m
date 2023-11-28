Return-Path: <linux-integrity+bounces-259-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E23D7FBA03
	for <lists+linux-integrity@lfdr.de>; Tue, 28 Nov 2023 13:24:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7F75C1C20F66
	for <lists+linux-integrity@lfdr.de>; Tue, 28 Nov 2023 12:24:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BE8D4F8B0;
	Tue, 28 Nov 2023 12:24:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="bLm6wgwa"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4FDCCB8
	for <linux-integrity@vger.kernel.org>; Tue, 28 Nov 2023 04:24:28 -0800 (PST)
Received: from pps.filterd (m0353722.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3ASAj8Z1025526;
	Tue, 28 Nov 2023 12:24:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : reply-to : to : cc : date : in-reply-to : references : content-type
 : mime-version : content-transfer-encoding; s=pp1;
 bh=nkCV+z7Z/gs2vtX8zadwXZPFMnLEX6yd4FEMXZ1x4ts=;
 b=bLm6wgwawAigRIm9ifN4+uvaJzjlVnpS2cjsFjAo66v/QTFUtqmmqZ8ma1mxf9oU/vAa
 cYrIPjPKnK8MDugReEZMboB5Qsk7aa3yVCcf6RTsR3ffuPwn+sH6sfei7R+HDEyndC/X
 eAqwpx9t+jhxhh15UoqX65ZcuGhMM1BBzGimkaSNFhsqk0tofxYKi1F7CPeawzIEE9lx
 MTpHcvvLwk3Uy7Mv5IyUZKPS9mjH8vDtoOKcgU0Z0Wc565ugZ+Dv2cmF4y4z24jaOfrU
 PUCniyHEzc3qiDCyz6nHtflB2/kXU9LWD+AnM3yJqIMspThbX9ep/6OqJyl4tuDTENUa dw== 
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3uneqtaspj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 28 Nov 2023 12:24:21 +0000
Received: from m0353722.ppops.net (m0353722.ppops.net [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 3ASBfTFY024346;
	Tue, 28 Nov 2023 12:24:21 GMT
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3uneqtasp5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 28 Nov 2023 12:24:21 +0000
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 3ASAYs7Q028329;
	Tue, 28 Nov 2023 12:24:20 GMT
Received: from smtprelay07.dal12v.mail.ibm.com ([172.16.1.9])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3ukv8nfhc5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 28 Nov 2023 12:24:20 +0000
Received: from smtpav01.dal12v.mail.ibm.com (smtpav01.dal12v.mail.ibm.com [10.241.53.100])
	by smtprelay07.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 3ASCOJpC47055390
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 28 Nov 2023 12:24:20 GMT
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id CD49E58059;
	Tue, 28 Nov 2023 12:24:19 +0000 (GMT)
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 0C8495805D;
	Tue, 28 Nov 2023 12:24:18 +0000 (GMT)
Received: from lingrow.int.hansenpartnership.com (unknown [9.67.129.184])
	by smtpav01.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 28 Nov 2023 12:24:17 +0000 (GMT)
Message-ID: <2de19a94132c6277cd754bc10eaf5df6a57f4434.camel@linux.ibm.com>
Subject: Re: [PATCH v5 8/8] KEYS: trusted: tpm2: Use struct tpm_buf for
 sized buffers
From: James Bottomley <jejb@linux.ibm.com>
Reply-To: jejb@linux.ibm.com
To: "Serge E. Hallyn" <serge@hallyn.com>, Jarkko Sakkinen <jarkko@kernel.org>
Cc: linux-integrity@vger.kernel.org, Mimi Zohar <zohar@linux.ibm.com>,
        David
 Howells <dhowells@redhat.com>, Paul Moore <paul@paul-moore.com>,
        James
 Morris <jmorris@namei.org>
Date: Tue, 28 Nov 2023 07:24:16 -0500
In-Reply-To: <20231128034802.GA33794@mail.hallyn.com>
References: <20231121223130.30824-1-jarkko@kernel.org>
	 <20231121223130.30824-9-jarkko@kernel.org>
	 <20231128034802.GA33794@mail.hallyn.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.4 
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: Llby10UHNglbjAhnFBBy30QDG_F_p3re
X-Proofpoint-ORIG-GUID: wXoKA7DHE0hfoTp5sXXjzihyjBa7NHv4
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-28_12,2023-11-27_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=391
 impostorscore=0 mlxscore=0 malwarescore=0 spamscore=0 priorityscore=1501
 lowpriorityscore=0 clxscore=1011 adultscore=0 bulkscore=0 phishscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311060000 definitions=main-2311280098

On Mon, 2023-11-27 at 21:48 -0600, Serge E. Hallyn wrote:
> On Wed, Nov 22, 2023 at 12:31:20AM +0200, Jarkko Sakkinen wrote:
[...]
> > diff --git a/security/keys/trusted-keys/trusted_tpm2.c
> > b/security/keys/trusted-keys/trusted_tpm2.c
> > index bc700f85f80b..97b1dfca2dba 100644
> > --- a/security/keys/trusted-keys/trusted_tpm2.c
> > +++ b/security/keys/trusted-keys/trusted_tpm2.c
> > @@ -228,8 +228,9 @@ int tpm2_seal_trusted(struct tpm_chip *chip,
> >                       struct trusted_key_payload *payload,
> >                       struct trusted_key_options *options)
> >  {
> > +       off_t offset = TPM_HEADER_SIZE;
> > +       struct tpm_buf buf, sized;
> >         int blob_len = 0;
> > -       struct tpm_buf buf;
> >         u32 hash;
> >         u32 flags;
> >         int i;
> > @@ -258,6 +259,14 @@ int tpm2_seal_trusted(struct tpm_chip *chip,
> >                 return rc;
> >         }
> >  
> > +       rc = tpm_buf_init_sized(&sized);
> > +       if (rc) {
> > +               tpm_buf_destroy(&buf);
> 
> It won't really hurt, but at the moment if tpm_buf_init_sized()
> returns non-zero, then it must be returning -ENOMEM, and
> tpm_buf_destroy(&buf) is not needed, right?

No ... buf was initialized further up in the original code (you seem to
be confusing buf and sized ... they're two separate allocations).  We
can't return from here without destroying it otherwise we'll leak a
page.

James


