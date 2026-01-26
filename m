Return-Path: <linux-integrity+bounces-8322-lists+linux-integrity=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-integrity@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +FtNGPzWd2mFlwEAu9opvQ
	(envelope-from <linux-integrity+bounces-8322-lists+linux-integrity=lfdr.de@vger.kernel.org>)
	for <lists+linux-integrity@lfdr.de>; Mon, 26 Jan 2026 22:05:00 +0100
X-Original-To: lists+linux-integrity@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B43908D7B7
	for <lists+linux-integrity@lfdr.de>; Mon, 26 Jan 2026 22:04:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7877D303A874
	for <lists+linux-integrity@lfdr.de>; Mon, 26 Jan 2026 21:04:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8FCD2DC77A;
	Mon, 26 Jan 2026 21:04:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="tOCxs1q6"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80C1B246BCD;
	Mon, 26 Jan 2026 21:04:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769461463; cv=none; b=BhiyUO5GeCtW3hnLMpHuGp1rVSvvUT3Yt/ZxhvmNFWt6a3aXcrDR34mU2UDu80bDPJRheFXlYLY+ZMrZIGpSlp+R1zX23L5jIXd3+z+r5wfwB8SXt9E0jq7i/prmoyVmdTA5NEc/iEWGr8MzIC/R5BpWckrgW22dro8ScFrxl78=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769461463; c=relaxed/simple;
	bh=4GPtziDPMSE9/EJRtGvLEo4AVyrxeTfH0UIqTZbgeKQ=;
	h=Message-ID:Subject:From:To:Cc:In-Reply-To:References:Content-Type:
	 Date:MIME-Version; b=kw7ngUiYAjF8eMH3Q/xQUqdK7Ozv7QxEJeO9TI3CRi/gg4HmPxKmgH5DzTWWt83Xag1lr7IrViujbhZF5k8wsOmOgGZ95J3I2MSYlI6Qo1rARG4d+AiZ5b1UZC31pRCn7iTqOTAONctlbntKxvRzWxN2J/g5AsdACWbBxK9dFcQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=tOCxs1q6; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 60QEw2OC028114;
	Mon, 26 Jan 2026 21:04:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=LizB25
	TOsA4kajp6h3isaWMwsisuSBOg7MXbmowpIY0=; b=tOCxs1q63IfEObeOW5m76E
	MZ3BezHnBTkbg0moaDd5uP8nn/Q/aJYSHKRgj4qyt1Jg40fZWdWVfouUUJq8TTow
	u8o59qmBO7rldau9bM9mQfS6EHw1tdlkV7+mq3D8C5BLQC3VOi0kjFY6WH0u1taR
	ORrY5/eMJHXoGezLLwPV3qRLP6FGHHv0GMZOakkRv/FcZqu4ooigfJQ/Rz0pMZZw
	G5wdMTnxrTKFgWed3VFx7RLlYInzUSxpXm3O6kUwRmbQq7Z4GWKZRLVDjFlPkZxB
	BDZ102bU1MY4Ryl013NjfoEmjuJ3vHK/Wx6suy92ig1Zd9Yr6HiToQeauog/xYsg
	==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4bvmgfrtxs-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 26 Jan 2026 21:04:06 +0000 (GMT)
Received: from m0353725.ppops.net (m0353725.ppops.net [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 60QKw28T005997;
	Mon, 26 Jan 2026 21:04:06 GMT
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4bvmgfrtxp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 26 Jan 2026 21:04:06 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 60QHAIjY023624;
	Mon, 26 Jan 2026 21:04:05 GMT
Received: from smtprelay04.dal12v.mail.ibm.com ([172.16.1.6])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4bwamjnxs6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 26 Jan 2026 21:04:05 +0000
Received: from smtpav04.dal12v.mail.ibm.com (smtpav04.dal12v.mail.ibm.com [10.241.53.103])
	by smtprelay04.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 60QL44ln22741662
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 26 Jan 2026 21:04:04 GMT
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id BC05D58052;
	Mon, 26 Jan 2026 21:04:04 +0000 (GMT)
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id F0B6458056;
	Mon, 26 Jan 2026 21:04:03 +0000 (GMT)
Received: from li-43857255-d5e6-4659-90f1-fc5cee4750ad.ibm.com (unknown [9.61.66.96])
	by smtpav04.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 26 Jan 2026 21:04:03 +0000 (GMT)
Message-ID: <821cb2becf70b2dcb903e74685643f8b60a5cbb6.camel@linux.ibm.com>
Subject: Re: IMA and PQC
From: Mimi Zohar <zohar@linux.ibm.com>
To: David Howells <dhowells@redhat.com>
Cc: Simo Sorce <simo@redhat.com>, Roberto Sassu <roberto.sassu@huawei.com>,
        Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
        Eric Snowberg
 <eric.snowberg@oracle.com>,
        Eric Biggers	 <ebiggers@kernel.org>, linux-integrity@vger.kernel.org,
        linux-crypto@vger.kernel.org, keyrings@vger.kernel.org,
        linux-modules@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <1783975.1769190197@warthog.procyon.org.uk>
References: <1783975.1769190197@warthog.procyon.org.uk>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Date: Mon, 26 Jan 2026 16:04:03 -0500
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Evolution 3.56.2 (3.56.2-2.fc42) 
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=Z4vh3XRA c=1 sm=1 tr=0 ts=6977d6c6 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=IkcTkHD0fZMA:10 a=vUbySO9Y5rIA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=VwQbUJbxAAAA:8 a=VAaF4WOGAAAA:8 a=e7iQgRXja1ti6KWjARAA:9 a=QEXdDO2ut3YA:10
 a=1LTzQqO7nuyEnyYsu_Ii:22
X-Proofpoint-GUID: C7c2I5_y-UyvzjPNTmdcd-tHbdy8bo-y
X-Proofpoint-ORIG-GUID: nSKvgNSZHLbx1PiW4tQWlxK8-FdQz7EI
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTI2MDE3OCBTYWx0ZWRfXzYKehUKHoTKT
 LHv8w/limEVGmbyTwdEE6ux8HjR37QzxSCoySxzM9O8HAIpIKojrp+/9tbcFnXJ6kyvk/zRYtOq
 VSsDyNsS/kyuoaj0BbmobYqh/uK2ueCn/wFHb3Z4lBeSlWlnAJMWV9nb9LPPvLH0NGeRhtwltRU
 pZfwQXKXHKlOnkCxUJbmYRL0XjAdRM6BIYJmkRP0IiEZiWvstWEygmJbYxxvtoif5Dr6ArOAIQM
 bk6HmkTqiELqVZKwVLjWmXdYhVsecQKqeWS5Lu4Mjt/9AEC+Ygswm09B23FP7KrPSsUbT4/5xEZ
 YiYyg/huUVBIGnj91lMayXBl9SXUtyvSjIEFzuvzPVFhMubOSKyL4R7Z0HhhcyomcQl6mdB6UVQ
 cpPMJj3B7+EXSAzbpTAGpOscxtrV++oMhqWY4wJhnIRD2zeLD/GsPW6jfj2QcRn0ymhh/45Y2a2
 8MxH2+AT2VW4RHKx7Hg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.20,FMLib:17.12.100.49
 definitions=2026-01-26_04,2026-01-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 malwarescore=0 phishscore=0 priorityscore=1501 bulkscore=0
 adultscore=0 clxscore=1011 lowpriorityscore=0 impostorscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2601150000 definitions=main-2601260178
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[ibm.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[ibm.com:s=pp1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[redhat.com,huawei.com,gmail.com,oracle.com,kernel.org,vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[ibm.com:+];
	TAGGED_FROM(0.00)[bounces-8322-lists,linux-integrity=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_TWELVE(0.00)[13];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[zohar@linux.ibm.com,linux-integrity@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[11];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-integrity];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: B43908D7B7
X-Rspamd-Action: no action

On Fri, 2026-01-23 at 17:43 +0000, David Howells wrote:
> Hi Mimi,
>=20
> I've posted patches which I hope will accepted to implement ML-DSA module
> signing:
>=20
> 	https://lore.kernel.org/linux-crypto/1753972.1769166821@warthog.procyon.=
org.uk/T/#t
>=20
> but for the moment, it will give an error to pkcs7_get_digest() if there'=
s no
> digest available (which there won't be with ML-DSA).  This means that the=
re
> isn't a hash for IMA to get at for TPM measurement.

IMA calculates the file hash for three different purposes: augment the audi=
t
log, extend the TPM, and of course verify the file data signature.

From what I gather there is ML-DSA pure and pre-hash modes.  What you've
implemented is ML-DSA pure mode which passes the data in order to calculate=
 the
file hash, not ML-DSA pre-hash.  For this reason, there is no option to use=
 the
file hash.

>=20
> Now, I probably have to make a SHA256 hash anyway for UEFI blacklisting
> purposes, so that could be used.  Alternatively, we can require the use o=
f
> authenticatedAttributes/signedAttrs and give you the hash of that - but t=
hen
> you're a bit at the mercy of whatever hashes were used.

Let's discuss alternatives and not jump to the conclusion that you have to =
break
IMA.

>=20
> Further, we need to think how we're going to do PQC support in IMA -
> particularly as the signatures are so much bigger and verification slower=
.

Perhaps, but these same reasons would apply to kernel modules, firmware, an=
d the
kernel image.  Why would IMA be special?!

>=20
> Would ML-DSA-44 be acceptable?  Should we grab some internal state out of
> ML-DSA to use in lieu of a hash?

Is ML-DSA-44 acceptable for kernel modules, firmware, or the kernel image?

Mimi


