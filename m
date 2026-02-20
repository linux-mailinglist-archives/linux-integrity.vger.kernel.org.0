Return-Path: <linux-integrity+bounces-8528-lists+linux-integrity=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-integrity@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wNOXKU+imGl0KQMAu9opvQ
	(envelope-from <linux-integrity+bounces-8528-lists+linux-integrity=lfdr.de@vger.kernel.org>)
	for <lists+linux-integrity@lfdr.de>; Fri, 20 Feb 2026 19:05:03 +0100
X-Original-To: lists+linux-integrity@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 026B8169F5A
	for <lists+linux-integrity@lfdr.de>; Fri, 20 Feb 2026 19:05:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 94DD33024CB9
	for <lists+linux-integrity@lfdr.de>; Fri, 20 Feb 2026 18:05:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 860CA35EDDD;
	Fri, 20 Feb 2026 18:04:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="NFARWaqS"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 654EC2EDD52;
	Fri, 20 Feb 2026 18:04:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771610699; cv=none; b=OKwf44m3RYJHR49ATureA8hHpgrbr6CeGvNHFxBO0Lp/KHrarW6S9eEu4dMFyetSAsrKrt4N9Yxiamq3PbkHaP/dXc9BIxLErZAo/1bDnuRqssWisQgQr2r+wDhDhazzhdk9dqAQUFZ/j9UDFiFq3w/g+no4+1t28xzBwQ0pxVE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771610699; c=relaxed/simple;
	bh=vHhECxKKSonNLCEDJDyJJCjAvm65oFi2MCzGiGPT2FM=;
	h=Message-ID:Subject:From:To:Cc:In-Reply-To:References:Content-Type:
	 Date:MIME-Version; b=fS0+7+WA2I8sDu8ZpvIpN3wWlERzsOv0l7CdB5xaPH22AEkh71f0j21LQpTBC84STf7X+dMFLOUJKKz9WZY5EUhEcXj56CsfS45OrxW2NNglSPRNZurRStbmtlT0ELl9aEY4AtfExUPg8iIpP9fLKLfsjlIzKiuIj+vO7gLfaog=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=NFARWaqS; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 61KE8abu1274421;
	Fri, 20 Feb 2026 18:04:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=nwtfnM
	qkvw4D0EDFUFyMqHPMa485sESF4URZogK//IY=; b=NFARWaqSCfEE55kRb1Xtgp
	lioJCJVbi+hm9OPHOrzzXbw3+3GkKj3pIGlfAOCGynGsqOOPRvLgftPXznMyVPtV
	H1K3NymlEQDtEIaNyxLMAaJ3ZZBogI09I5FcImlf3l96Hyczrz0ek0+iUb0Hfq5i
	1XmJ2Dlkku0S3SoPlTI/EW05gXT//d7bYENrf7FZ/b58+tj6rFkwEzlgdr/qm69E
	uLjVY5ttd09PwZYSBks0Hrim/8W/SfAEujOkv5vA1yBDHz4sZZR5dYgiWUmHiqFZ
	csL5P3aUXPGbOA8JjrWSFSS62NhWQrkQmVz7jnP3gF5i6Cj5CEF3fFq6sAdd6u8Q
	==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4caj6v4dth-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 20 Feb 2026 18:04:33 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 61KEY7XO017769;
	Fri, 20 Feb 2026 18:04:32 GMT
Received: from smtprelay05.dal12v.mail.ibm.com ([172.16.1.7])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4ccb28sdy0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 20 Feb 2026 18:04:32 +0000
Received: from smtpav05.dal12v.mail.ibm.com (smtpav05.dal12v.mail.ibm.com [10.241.53.104])
	by smtprelay05.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 61KI4VlH27394660
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 20 Feb 2026 18:04:32 GMT
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id DAD945806A;
	Fri, 20 Feb 2026 18:04:31 +0000 (GMT)
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id DE4F858052;
	Fri, 20 Feb 2026 18:04:30 +0000 (GMT)
Received: from li-43857255-d5e6-4659-90f1-fc5cee4750ad.ibm.com (unknown [9.61.32.193])
	by smtpav05.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 20 Feb 2026 18:04:30 +0000 (GMT)
Message-ID: <06a08cbbe47111a1795e5dcd42fb8cc4be643a72.camel@linux.ibm.com>
Subject: Re: [PATCH v9 01/11] KEYS: trusted: Use get_random-fallback for TPM
From: Mimi Zohar <zohar@linux.ibm.com>
To: Jarkko Sakkinen <jarkko@kernel.org>, linux-integrity@vger.kernel.org,
        Chris Fenner <cfenn@google.com>, Jonathan McDowell <noodles@earth.li>
Cc: Eric Biggers <ebiggers@kernel.org>,
        James Bottomley	
 <James.Bottomley@HansenPartnership.com>,
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
In-Reply-To: <20260125192526.782202-2-jarkko@kernel.org>
References: <20260125192526.782202-1-jarkko@kernel.org>
	 <20260125192526.782202-2-jarkko@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Date: Fri, 20 Feb 2026 13:04:30 -0500
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Evolution 3.56.2 (3.56.2-2.fc42) 
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Authority-Analysis: v=2.4 cv=E+/AZKdl c=1 sm=1 tr=0 ts=6998a232 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=IkcTkHD0fZMA:10 a=HzLeVaNsDn8A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=Mpw57Om8IfrbqaoTuvik:22 a=GgsMoib0sEa3-_RKJdDe:22 a=Vt9hyLhVu_K4TWJpMtYA:9
 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjIwMDE1MSBTYWx0ZWRfXx8OzFQ2LjLWn
 noyCkrBZi+/yVOw7BjW3yQ4kNelwIZRouK4085vYntXfgWVt2Gr+iiuGQGJ95ogwc7y+jf6v4mu
 OpeezWUjkldDYhGFp6Oi6GEEfmzC9gXc+l6ilDdOrLR4rgGZZCmNvtGgqdJ0+0vjRFgrBIUebjv
 Qjn1B5dTjmE9tuGCz+EVv0Y2ldXDlB53jgdIIbw5xTjW99dBUAFjzWc6zbopB766D97uJNncVN8
 eN3tABYVB2UEzeeKBExmsJTr5H3kvWWuoFxPT2+QhQpCdxdD3sq5tKGyWIf2LHSqiMLDoyMYs9B
 lyl3wXfMZ9vcXoZUcQHf9rmrqlTdkYH5X9l47ikAuNlzrKjxfGW47ZnHoXOc7JcfOvQcf3IgWGM
 AQes4WesDKekKWgLc1IB/NLJ+stxohtKGY/zQT8gfoOlLOyXo+oOAqyqAcrk24PPcZdQNcbax/p
 23jZCxcidrqjstySwGQ==
X-Proofpoint-ORIG-GUID: L34ya8ATJ-eL4atO6jNskeEgII66AEtM
X-Proofpoint-GUID: 48YtNvNjc2aDdlz_BKOfk7bS-oocurIF
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-20_02,2026-02-20_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 priorityscore=1501 malwarescore=0 phishscore=0 bulkscore=0
 suspectscore=0 spamscore=0 clxscore=1015 impostorscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2601150000 definitions=main-2602200151
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[ibm.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10];
	R_DKIM_ALLOW(-0.20)[ibm.com:s=pp1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[14];
	TAGGED_FROM(0.00)[bounces-8528-lists,linux-integrity=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[ibm.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,linux.ibm.com:mid];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[zohar@linux.ibm.com,linux-integrity@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	PRECEDENCE_BULK(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[linux-integrity];
	RCVD_COUNT_SEVEN(0.00)[11]
X-Rspamd-Queue-Id: 026B8169F5A
X-Rspamd-Action: no action

[Cc: Chris Fenner, Jonathan McDowell, Roberto]

On Sun, 2026-01-25 at 21:25 +0200, Jarkko Sakkinen wrote:
> 1. tpm2_get_random() is costly when TCG_TPM2_HMAC is enabled and thus its
>    use should be pooled rather than directly used. This both reduces
>    latency and improves its predictability.

If the concern is the latency of encrypting the bus session, please remembe=
r
that:

- Not all environments expose the TPM bus to sniffing.
- The current TPM trusted keys design is based on TPM RNG, but already allo=
ws it
to be replaced with the kernel RNG via the "trusted_rng=3Dkernel" boot comm=
and
line option.
- The proposed patch removes that possibility for no reason.

Mimi & Elaine



