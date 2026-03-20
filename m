Return-Path: <linux-integrity+bounces-9017-lists+linux-integrity=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-integrity@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kGq6DhJBvWn28AIAu9opvQ
	(envelope-from <linux-integrity+bounces-9017-lists+linux-integrity=lfdr.de@vger.kernel.org>)
	for <lists+linux-integrity@lfdr.de>; Fri, 20 Mar 2026 13:44:02 +0100
X-Original-To: lists+linux-integrity@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B4032DA707
	for <lists+linux-integrity@lfdr.de>; Fri, 20 Mar 2026 13:44:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id B3767301429D
	for <lists+linux-integrity@lfdr.de>; Fri, 20 Mar 2026 12:43:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2811D3B27C5;
	Fri, 20 Mar 2026 12:43:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="biqgZdZ4"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FF4937187C;
	Fri, 20 Mar 2026 12:43:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774010634; cv=none; b=OTgnHux+zSsOu43Ug6DaxouZckStIFcbAuA4c9lFU090OBEPqwMOAO6IvERojNklaiNrKx4wiUCbRFkW79CRBNflFr7ueg8zoh7Vca4JayyKoG58xJmpvgb/klhJka6CWfobgkFNECb82ecY5WhIMEqEAHX4SXjhhKXrkDOeTPY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774010634; c=relaxed/simple;
	bh=yNppS9cHlBOq3hi2OuU+lLqCPo6TTLgiTKj2ELmxZFo=;
	h=Message-ID:Subject:From:To:Cc:In-Reply-To:References:Content-Type:
	 Date:MIME-Version; b=plgJm4xG7t93BVWYcKz6FitQcUhW9qoOBbwByZdiQfZerm2eCOM24J9VQZTRaFkG0McTJ+lWrcFBVv0IkQis2sVOyokut28aO4T0SYA/WT7P4xu6M8cZvPJAFfxit4YM/zswbNpvW55XK7jzCiJu+4ZPgPlmQEqqZomG9DHvOj0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=biqgZdZ4; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62K9KQHp1190011;
	Fri, 20 Mar 2026 12:43:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=dVXFCD
	S6uoQ7xpxgXlI+9S5+RobPtFcQppGW3wo3APY=; b=biqgZdZ4cDNueXS2BO3mQm
	xXVsaYwbJqM2uf9/tdb3AZ9lsBk5YHz2c4t3oWYLgV7sVQFKvNcgqzLjoC1xhlBn
	drPTT0WGRkJAIK4ScbEtKLI1p3rjHN8clpMpi6QLVcE0c/hvWC6Js8JjyHC2uRbG
	e/+I9004fo8wWjdQWYxP0DPkif4oRrvn5ncdJ9wfAuhVIw0zl5bhxEANXk0ZKdPq
	ykXjkyGvnTzGyNcRla5Yz3YgE8XHOSkj3O2pa1g9Kb2ID5x1u3IgWh6f6Y3bfDEI
	RGvWlZE+COtux0FflNSawh+RSeXIah9f+Agjg91RSnorCzKiHW2HOnvG9rqpAPJg
	==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4cx7vfwux9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 20 Mar 2026 12:43:16 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 62KBtEVU014113;
	Fri, 20 Mar 2026 12:43:15 GMT
Received: from smtprelay02.wdc07v.mail.ibm.com ([172.16.1.69])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4cwjcyf7hs-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 20 Mar 2026 12:43:15 +0000
Received: from smtpav01.wdc07v.mail.ibm.com (smtpav01.wdc07v.mail.ibm.com [10.39.53.228])
	by smtprelay02.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 62KChExl29164222
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 20 Mar 2026 12:43:14 GMT
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D50BA5804B;
	Fri, 20 Mar 2026 12:43:14 +0000 (GMT)
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 48FDA58055;
	Fri, 20 Mar 2026 12:43:13 +0000 (GMT)
Received: from li-43857255-d5e6-4659-90f1-fc5cee4750ad.ibm.com (unknown [9.61.147.150])
	by smtpav01.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 20 Mar 2026 12:43:13 +0000 (GMT)
Message-ID: <ffe1d4645a66a690892163be8e16c4b5d24a690d.camel@linux.ibm.com>
Subject: Re: [PATCH v3 3/3] ima: Add support for staging measurements for
 deletion
From: Mimi Zohar <zohar@linux.ibm.com>
To: steven chen <chenste@linux.microsoft.com>,
        Roberto Sassu	
 <roberto.sassu@huaweicloud.com>, corbet@lwn.net,
        skhan@linuxfoundation.org, dmitry.kasatkin@gmail.com,
        eric.snowberg@oracle.com, paul@paul-moore.com, jmorris@namei.org,
        serge@hallyn.com
Cc: linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-integrity@vger.kernel.org, linux-security-module@vger.kernel.org,
        gregorylumen@linux.microsoft.com, nramas@linux.microsoft.com,
        Roberto Sassu
	 <roberto.sassu@huawei.com>
In-Reply-To: <25e0a273-9044-4e0d-9812-0171ec99e1b7@linux.microsoft.com>
References: <20260311171956.2317781-1-roberto.sassu@huaweicloud.com>
	 <20260311171956.2317781-3-roberto.sassu@huaweicloud.com>
	 <587e11bf4d29552bbbfc029f716146e8ebfca1eb.camel@linux.ibm.com>
	 <25e0a273-9044-4e0d-9812-0171ec99e1b7@linux.microsoft.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Date: Fri, 20 Mar 2026 08:41:18 -0400
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Evolution 3.56.2 (3.56.2-2.fc42) 
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-ORIG-GUID: LCuC5On_83ousWRx60Wk21U32FhyP-LH
X-Authority-Analysis: v=2.4 cv=KajfcAYD c=1 sm=1 tr=0 ts=69bd40e4 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=U7nrCbtTmkRpXpFmAIza:22 a=zauGFP8psBLEDG-jHCkA:9
 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzIwMDEwMCBTYWx0ZWRfXxmCEw0mb2dRQ
 bPt5+fyq4ZTouWloR4ChkkZ4PEz4tSCpg9QrvDmHiMaKU5/oMfwyrEZYbmG+5WjP023WWGr2Oha
 +hYk06QZpfewSJ06jH8951wdTiGaeYCUf7/JcoK6GhZrOBCEaAQwntLLOY6w7zHtIKUSOtYL4Lf
 G9OGdMrZTIIdK5wrYqA/s4nEk7bV7uUKuv3q+73Zc3SYuu/NGYqMqhgxCSvrtwXZg2hNlPEjki0
 F+teb4JHruekgob4FFzPQEGjW93ObKBummfOGownlwUZytZY0ofWFT2nnj0XOrABCHqeMv5BsUK
 vyLTDiMXw8LS1S7KcKRMK5E4zolcLLwW66YX4TTUPfQ8JR4oqMS3tfyJawLOAvvByN5BO58Q0kH
 RQat8qp7LMYu3sox1TAJdIHFqeH5Ga2HyAme9AFTTf2mVk0Tp6n3kjeX3xQ4ZzcrlGplqeb2LVh
 8+FmnlR3KbOXhWvswGg==
X-Proofpoint-GUID: WSIvWMAJxyv9drqAYdzx-nEZC9eLd_Br
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-20_02,2026-03-19_05,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 adultscore=0 spamscore=0 malwarescore=0 clxscore=1015
 impostorscore=0 bulkscore=0 lowpriorityscore=0 priorityscore=1501
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2603050001
 definitions=main-2603200100
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[ibm.com,none];
	R_DKIM_ALLOW(-0.20)[ibm.com:s=pp1];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-9017-lists,linux-integrity=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[linux.microsoft.com,huaweicloud.com,lwn.net,linuxfoundation.org,gmail.com,oracle.com,paul-moore.com,namei.org,hallyn.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[16];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[zohar@linux.ibm.com,linux-integrity@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[ibm.com:+];
	NEURAL_HAM(-0.00)[-0.997];
	TAGGED_RCPT(0.00)[linux-integrity];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[11]
X-Rspamd-Queue-Id: 8B4032DA707
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Thu, 2026-03-19 at 14:31 -0700, steven chen wrote:

> > - Support for deleting N measurement records (and pre-pending the remai=
ning
> > measurement records)
>=20
> Is there any problem to bring work of "stage" step together to the=20
> deletion step?
>=20
> "Trim N" method does everything that "staged" method can do, right?=20
> what's the "stage" method can do but "trim N" method can't do?
>=20
> in user space, if in "staged" state, no other user space agent can=20
> access the IMA measure list, right?
>=20
> Could you explain the benefit of bringing the "stage" step?

The performance improvement is because "staging" the IMA measurement list t=
akes
the lock in order to move the measurement list pointer and then releases it=
.=20
New measurements can then be appended to a new measurement list.  Deleting
records is done without taking the lock to walk the staged measurement list=
.

Without staging the measurement list, walking the measurement list to trim =
N
records requires taking and holding the lock.  The performance is dependent=
 on
the size of the measurement list.

Your question isn't really about "staging" the measurement list records, bu=
t
requiring a userspace signal to delete them.  To answer that question, dele=
ting
N records (third patch) could imply staging all the measurement records and
immediately deleting N records without an explicit userspace signal.

I expect the requested "documentation" patch will provide the motivation fo=
r the
delayed deletion of the measurement list.

Mimi=20











