Return-Path: <linux-integrity+bounces-9015-lists+linux-integrity=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-integrity@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WJ5dGj0KvGkArgIAu9opvQ
	(envelope-from <linux-integrity+bounces-9015-lists+linux-integrity=lfdr.de@vger.kernel.org>)
	for <lists+linux-integrity@lfdr.de>; Thu, 19 Mar 2026 15:37:49 +0100
X-Original-To: lists+linux-integrity@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C8222CCF88
	for <lists+linux-integrity@lfdr.de>; Thu, 19 Mar 2026 15:37:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C7A1331DEB00
	for <lists+linux-integrity@lfdr.de>; Thu, 19 Mar 2026 14:33:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B28A72622;
	Thu, 19 Mar 2026 14:33:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="nr2QB+fZ"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEDE1261B91;
	Thu, 19 Mar 2026 14:33:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773930810; cv=none; b=L0mViFxHnvXYaAVr+k55Y9S1QGf2Qs3hiU1OWyXJm1d5mDeB5w294jcXW4oqY6TQ3AGuS7vRo17BDAtTnfu++A80r3mz8MKkH8dIlYKEUITYp+XmdpdQszu+YHSvDm8S+Wz6dI/4O/LT09SrmSDD1IQxpe3hErL9u4Nl5MS3bRU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773930810; c=relaxed/simple;
	bh=RT7FwktFpb29DaqAupVSSEfNUSGsoU+teIsnk49uA6A=;
	h=Message-ID:Subject:From:To:Cc:In-Reply-To:References:Content-Type:
	 Date:MIME-Version; b=UUKgKg4pgqMr6+l/jndBX/BqDpZjEgoz72ohxt7DoaWuhha0iJmE+AKAn0LEH8ygMOwuQXdEFlHHNWnBJnB02285K2hzXl29D9qDrFbnSbWJdixv3/PbE0y4QFfZhlNu8FF9orVoVlAPbx/saMowNAQuYk9IHaNd/xIQWc2s3ug=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=nr2QB+fZ; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62J2mEF31290637;
	Thu, 19 Mar 2026 14:28:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=qFB5++
	i/C1ClZVxHPppdZTpFPMK1X7VzwAi9Mhyv3j8=; b=nr2QB+fZ26ch+pVrMAzNtx
	m+77zRBMF8ta5lUqNWS0lrwG90oI2faA46xUC1yAXGHQC3llISkKJYLseLWu62rw
	eViq0mxsj/ZbJWTtxdBPlkP5lME/j9h+ykJ4xP8tX1mCJaRITx93iJRh2uqA19Zr
	sBp/IdtrA0aomoWkunB6U86asRNn/5nrVjvh0lzHvdn8ESJOin03ZPqw4UqnjUn1
	49tKPp78DPJ7Bw/RE8YOQBY0vWwWhflHgPGFhA9Bx/VjBWDrhLBickbr2/WMVVjo
	OyaeB/SZnyx2hJba0akfeh1xBuwpT53ll+8bT85OOZJbnB7ijicXXvo+Elpa4QjA
	==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4cvyaupjqb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 19 Mar 2026 14:28:05 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 62JEN1uO032346;
	Thu, 19 Mar 2026 14:28:05 GMT
Received: from smtprelay02.dal12v.mail.ibm.com ([172.16.1.4])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4cwm7k2mg8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 19 Mar 2026 14:28:05 +0000
Received: from smtpav03.dal12v.mail.ibm.com (smtpav03.dal12v.mail.ibm.com [10.241.53.102])
	by smtprelay02.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 62JES4vL21758618
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 19 Mar 2026 14:28:04 GMT
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A15BE58056;
	Thu, 19 Mar 2026 14:28:04 +0000 (GMT)
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B57C65803F;
	Thu, 19 Mar 2026 14:28:03 +0000 (GMT)
Received: from li-43857255-d5e6-4659-90f1-fc5cee4750ad.ibm.com (unknown [9.61.191.110])
	by smtpav03.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 19 Mar 2026 14:28:03 +0000 (GMT)
Message-ID: <df0a54666d890d5223877e0a0f90ac9082b2d038.camel@linux.ibm.com>
Subject: Re: [PATCH v9 01/11] KEYS: trusted: Use get_random-fallback for TPM
From: Mimi Zohar <zohar@linux.ibm.com>
To: Chris Fenner <cfenn@google.com>
Cc: Jarkko Sakkinen <jarkko@kernel.org>, linux-integrity@vger.kernel.org,
        Jonathan McDowell	 <noodles@earth.li>,
        Eric Biggers <ebiggers@kernel.org>,
        James Bottomley	 <James.Bottomley@hansenpartnership.com>,
        David Howells
 <dhowells@redhat.com>, Paul Moore <paul@paul-moore.com>,
        James Morris
 <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        "open
 list:KEYS-TRUSTED"	 <keyrings@vger.kernel.org>,
        "open list:SECURITY
 SUBSYSTEM"	 <linux-security-module@vger.kernel.org>,
        open list	
 <linux-kernel@vger.kernel.org>,
        Roberto Sassu
 <roberto.sassu@huaweicloud.com>
In-Reply-To: <CAMigqh2kW_srDgnOs+1t=sk9Q9jJgaQVswO0ZRHhV-6zrOAZ6A@mail.gmail.com>
References: <20260125192526.782202-1-jarkko@kernel.org>
	 <20260125192526.782202-2-jarkko@kernel.org>
	 <06a08cbbe47111a1795e5dcd42fb8cc4be643a72.camel@linux.ibm.com>
	 <CAMigqh1H1NKP9gddjhf4M1v-aM=+EpW9O4KJmu=UysOWhn4ryA@mail.gmail.com>
	 <aadTgsbzDDkCg1Pr@kernel.org>
	 <dca994cd0ed11a262d4022c4984984460ba06a78.camel@linux.ibm.com>
	 <CAMigqh2kW_srDgnOs+1t=sk9Q9jJgaQVswO0ZRHhV-6zrOAZ6A@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Date: Thu, 19 Mar 2026 10:28:03 -0400
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Evolution 3.56.2 (3.56.2-2.fc42) 
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzE5MDExMiBTYWx0ZWRfX1vL4slwmrZjw
 UffY4/XgGepcxpkhqcL5iDHs+27MiNsxzCB9jmXBnM8rgidCdEc7VsRAxnhfgjzzLH5exQn5xoQ
 +WABZWZgSwwRcgwZ7Up+1Rctj5qkpdWODG9c8w5HTNrQPhLwaylc8MHoZELAobGpj79m4K2M5VO
 1Lfur9R6rk/i/7AsRnnA5hwP8GSwkXwCT8DPzwO06pbjUV5B8kDZFa0OhA7qmWZHmHRe3x1QCZC
 n/8UMqRkkqqlpksh1EBycVf1aPypjyRXUFSbuIvomWuCad5oswtsFl1Cai3wE9urr3sUAJZkQih
 BFAWfvKd+0wDDqWfckLe8ZOZmS11Fwuk711UGIILChxb6sm1LJp2YY+YU4mRYnc54SKbZSe76ti
 74veebRRplzcc1+t91xgMxz0zIIAkWisbkfqB3mIsUkYJiv7hXvpXW8O0psktKdKPHodwOFHvbQ
 5B9BrsfO78K3MWwmWIA==
X-Authority-Analysis: v=2.4 cv=GIQF0+NK c=1 sm=1 tr=0 ts=69bc07f6 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=RzCfie-kr_QcCd8fBx8p:22 a=MohcscOFZqetLROXmg4A:9
 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: 2WcX6f7d7qETkcLkD1yiCnqfkIBDiJe6
X-Proofpoint-GUID: ypJgEjxL_aZyQAXumKmyGiUD0PG08LKS
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-19_01,2026-03-19_05,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 priorityscore=1501 bulkscore=0 lowpriorityscore=0 malwarescore=0
 phishscore=0 impostorscore=0 suspectscore=0 adultscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2603190112
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[ibm.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[ibm.com:s=pp1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[14];
	TAGGED_FROM(0.00)[bounces-9015-lists,linux-integrity=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[ibm.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[zohar@linux.ibm.com,linux-integrity@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	PRECEDENCE_BULK(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[linux-integrity];
	RCVD_COUNT_SEVEN(0.00)[11]
X-Rspamd-Queue-Id: 0C8222CCF88
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Wed, 2026-03-18 at 10:36 -0700, Chris Fenner wrote:
> Apologies if my long message derailed this discussion. I meant to
> support Mimi's concern here and project a future vision where
> TCG_TPM2_HMAC doesn't conflict with other features.
>=20
> More concisely, I think that:
>=20
> > tpm2_get_random() is costly when TCG_TPM2_HMAC is enabled
>=20
> is not a compelling argument for removing TPM as an RNG source,
> because TCG_TPM2_HMAC is known to have poor performance already
> anyway.

Agreed.  Thanks, Chris!  FYI, we raised concerns about IMA performance with=
 the
TPM HMAC and encrypted feature while it was being developed. James had some
ideas, at the time, as to how to resolve the performance issue for IMA.  Ye=
t it
was upstreamed without those changes and with CONFIG_TCG_TPM2_HMAC enabled =
by
default on x86 systems.

Jarkko has queued this patch in the "queue" branch, without indicating whet=
her
it will eventually be upstreamed or not.

Mimi

