Return-Path: <linux-integrity+bounces-262-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 81FF37FBCD8
	for <lists+linux-integrity@lfdr.de>; Tue, 28 Nov 2023 15:37:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2C3231F20FA5
	for <lists+linux-integrity@lfdr.de>; Tue, 28 Nov 2023 14:37:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7280F5B5C0;
	Tue, 28 Nov 2023 14:37:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="qMoMW9DT"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B63A81B5
	for <linux-integrity@vger.kernel.org>; Tue, 28 Nov 2023 06:37:41 -0800 (PST)
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3ASEUUaU008165;
	Tue, 28 Nov 2023 14:37:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : reply-to : to : cc : date : in-reply-to : references : content-type
 : mime-version : content-transfer-encoding; s=pp1;
 bh=eIalQQi6PqwAduSFAesUjSxiL3jy/NQn8fzt+wzP0LY=;
 b=qMoMW9DTJhXsSSjnFVS4cOR2b3FaNFIAX6Vw8+92bE0jyV3Euh+CMKd//fN/OTc/ExOm
 2FJZJb1x6ayIowsNFt3JLLq1GsnigR0ViLioPSDBkcCoJC1uPmHHJb9sBtCurjBSg6AJ
 cXc/0/YhCpvXGncU/tnqIZJww/khcAoN8hT8s2PTtz6bLPnunBtDsJKA9G4Wlfvxn972
 j4nhxyLwDfblSMde29s4LDZhR9oOE7dKIVs5+W7HB2CR6IOGzsf5WHJ9VKGCtlsAKTSJ
 mZQpdyQO111DjbYdGi1Yfhh4Oeu5yknu8FqVMg8PEEpPibJ1ZV3sGn5Qt65uzD+yAhxn QA== 
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3unhs88qsj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 28 Nov 2023 14:37:34 +0000
Received: from m0356516.ppops.net (m0356516.ppops.net [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 3ASEVGTk012364;
	Tue, 28 Nov 2023 14:37:34 GMT
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3unhs88qs1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 28 Nov 2023 14:37:34 +0000
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 3ASDURtL027647;
	Tue, 28 Nov 2023 14:37:33 GMT
Received: from smtprelay06.wdc07v.mail.ibm.com ([172.16.1.73])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3ukumyge69-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 28 Nov 2023 14:37:33 +0000
Received: from smtpav01.dal12v.mail.ibm.com (smtpav01.dal12v.mail.ibm.com [10.241.53.100])
	by smtprelay06.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 3ASEbWdf50659616
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 28 Nov 2023 14:37:33 GMT
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id CC49858061;
	Tue, 28 Nov 2023 14:37:32 +0000 (GMT)
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 0880B58057;
	Tue, 28 Nov 2023 14:37:31 +0000 (GMT)
Received: from lingrow.int.hansenpartnership.com (unknown [9.67.129.184])
	by smtpav01.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 28 Nov 2023 14:37:30 +0000 (GMT)
Message-ID: <ed3d2c01a65b67cfba25ab517992d69590795aad.camel@linux.ibm.com>
Subject: Re: [PATCH v5 8/8] KEYS: trusted: tpm2: Use struct tpm_buf for
 sized buffers
From: James Bottomley <jejb@linux.ibm.com>
Reply-To: jejb@linux.ibm.com
To: "Serge E. Hallyn" <serge@hallyn.com>
Cc: Jarkko Sakkinen <jarkko@kernel.org>, linux-integrity@vger.kernel.org,
        Mimi Zohar <zohar@linux.ibm.com>, David Howells <dhowells@redhat.com>,
        Paul
 Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>
Date: Tue, 28 Nov 2023 09:37:29 -0500
In-Reply-To: <20231128143453.GA44257@mail.hallyn.com>
References: <20231121223130.30824-1-jarkko@kernel.org>
	 <20231121223130.30824-9-jarkko@kernel.org>
	 <20231128034802.GA33794@mail.hallyn.com>
	 <2de19a94132c6277cd754bc10eaf5df6a57f4434.camel@linux.ibm.com>
	 <20231128143453.GA44257@mail.hallyn.com>
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
X-Proofpoint-ORIG-GUID: Vru1dENk9SPt88Nz9DoULTVLJWNivRJ0
X-Proofpoint-GUID: xJmm2GsZ0BqUvrukp7Ahe27LkHMuLtyu
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-28_15,2023-11-27_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 spamscore=0 clxscore=1015 adultscore=0 mlxlogscore=421 lowpriorityscore=0
 impostorscore=0 malwarescore=0 mlxscore=0 phishscore=0 bulkscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311060000 definitions=main-2311280116

On Tue, 2023-11-28 at 08:34 -0600, Serge E. Hallyn wrote:
> On Tue, Nov 28, 2023 at 07:24:16AM -0500, James Bottomley wrote:
> > On Mon, 2023-11-27 at 21:48 -0600, Serge E. Hallyn wrote:
> > > On Wed, Nov 22, 2023 at 12:31:20AM +0200, Jarkko Sakkinen wrote:
> > [...]
> > > > diff --git a/security/keys/trusted-keys/trusted_tpm2.c
> > > > b/security/keys/trusted-keys/trusted_tpm2.c
> > > > index bc700f85f80b..97b1dfca2dba 100644
> > > > --- a/security/keys/trusted-keys/trusted_tpm2.c
> > > > +++ b/security/keys/trusted-keys/trusted_tpm2.c
> > > > @@ -228,8 +228,9 @@ int tpm2_seal_trusted(struct tpm_chip
> > > > *chip,
> > > >                       struct trusted_key_payload *payload,
> > > >                       struct trusted_key_options *options)
> > > >  {
> > > > +       off_t offset = TPM_HEADER_SIZE;
> > > > +       struct tpm_buf buf, sized;
> > > >         int blob_len = 0;
> > > > -       struct tpm_buf buf;
> > > >         u32 hash;
> > > >         u32 flags;
> > > >         int i;
> > > > @@ -258,6 +259,14 @@ int tpm2_seal_trusted(struct tpm_chip
> > > > *chip,
> > > >                 return rc;
> > > >         }
> > > >  
> > > > +       rc = tpm_buf_init_sized(&sized);
> > > > +       if (rc) {
> > > > +               tpm_buf_destroy(&buf);
> > > 
> > > It won't really hurt, but at the moment if tpm_buf_init_sized()
> > > returns non-zero, then it must be returning -ENOMEM, and
> > > tpm_buf_destroy(&buf) is not needed, right?
> > 
> > No ... buf was initialized further up in the original code (you
> > seem to be confusing buf and sized ...
> 
> You're right, I was.  Thanks.

No problem, it's actually an issue with reviewing patches.  The
original code that inits buf isn't in the patch, so you only see one
init and one destroy and we mostly go by patterns.

James


