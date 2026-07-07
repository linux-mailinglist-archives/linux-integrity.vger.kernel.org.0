Return-Path: <linux-integrity+bounces-9888-lists+linux-integrity=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-integrity@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id Z5xCHZxtTGqZkQEAu9opvQ
	(envelope-from <linux-integrity+bounces-9888-lists+linux-integrity=lfdr.de@vger.kernel.org>)
	for <lists+linux-integrity@lfdr.de>; Tue, 07 Jul 2026 05:08:12 +0200
X-Original-To: lists+linux-integrity@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id BECD2716F2B
	for <lists+linux-integrity@lfdr.de>; Tue, 07 Jul 2026 05:08:11 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=ibm.com header.s=pp1 header.b=s+sMeewO;
	dmarc=pass (policy=none) header.from=ibm.com;
	spf=pass (mail.lfdr.de: domain of "linux-integrity+bounces-9888-lists+linux-integrity=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="linux-integrity+bounces-9888-lists+linux-integrity=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2BE943042241
	for <lists+linux-integrity@lfdr.de>; Tue,  7 Jul 2026 03:04:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C89D6377EB8;
	Tue,  7 Jul 2026 03:04:08 +0000 (UTC)
X-Original-To: linux-integrity@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E26413B293
	for <linux-integrity@vger.kernel.org>; Tue,  7 Jul 2026 03:04:07 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783393448; cv=none; b=kaCsvBufSP/mPv6W5qadjKE7H7tsBWcJT9Q2bR08KkEi4/Dx44TC836nOSnCHphscCCT+IhOUuBcDBzDbPmqsx5ANedQaO7B1p2UrL0PHr0C92B1hKu9VWOAQF6BpW6GcYRctca2r2MBW+83IpdIHy1elz9lHsGb3SC5B3lg77w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783393448; c=relaxed/simple;
	bh=uiLuoXsrUE6nZ0UzQ8U9rScoVdPDNp9BDW6lnRHeF50=;
	h=Message-ID:Subject:From:To:Cc:In-Reply-To:References:Content-Type:
	 Date:MIME-Version; b=ny5Qudoq4xbvZ2uwpdKqKjNi/5JX06QFXdiDty6Tsprjuh+t3Wtzvim/0YyPnUTnzVK4S8Rg8vrQ8yw+AajwVt04e16BIrB6We7f39PNF+dhPSBPKMXNGjI0HfCU9gEhd0XMJmb5PeTRyOiiqpIIr8U1RYd+GyvkhY8kWUFGcTE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=s+sMeewO; arc=none smtp.client-ip=148.163.156.1
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 666KIVGD1289475;
	Tue, 7 Jul 2026 03:03:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=bC9MGJ
	aQjuPTTZgS7B5K3D8n+kGKl0Lsx0qQSq44VoQ=; b=s+sMeewODaIeXvzgcqgE/T
	XmJSYr2jjVznuqJLs4jWMOIu3auSIeWJtBVJGRtTQAlOAIKGqzlqi7TncTTV0Ll5
	N1SRkamr2ZKQiWuub/f+IstQkg8p/4rBH8PTIIZEuMTGjK/3K2wv7ZAjzn/wGTDn
	gLdRibpLZaXeFQBrPzoFoSjhQkphh/81Dgh+9VNEMx0tBTkH994B04OUo+th+qUZ
	nO+eep4+u1DlLgNEXXIcvxZuvFzGcihPnOZbyo6ozKjH1Ll0t96IuNySf8sTGkpn
	yx5yEeU2+Ssc4XahMSHHD7vH66XpIguPHVvHj8OpZfGSyKcuPxGKEU8UWRrMzFrg
	==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4f6sp3mryp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 07 Jul 2026 03:03:52 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 6672nalh030487;
	Tue, 7 Jul 2026 03:03:51 GMT
Received: from smtprelay02.dal12v.mail.ibm.com ([172.16.1.4])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4f7f6y07vc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 07 Jul 2026 03:03:51 +0000 (GMT)
Received: from smtpav03.wdc07v.mail.ibm.com (smtpav03.wdc07v.mail.ibm.com [10.39.53.230])
	by smtprelay02.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 66733omU30802648
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 7 Jul 2026 03:03:50 GMT
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 93A505805F;
	Tue,  7 Jul 2026 03:03:50 +0000 (GMT)
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id F136F58054;
	Tue,  7 Jul 2026 03:03:49 +0000 (GMT)
Received: from li-43857255-d5e6-4659-90f1-fc5cee4750ad.ibm.com (unknown [9.61.12.88])
	by smtpav03.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Tue,  7 Jul 2026 03:03:49 +0000 (GMT)
Message-ID: <002330a72cdec8eaa554fddd5b8d428245ed83e4.camel@linux.ibm.com>
Subject: Re: [PATCH v5 2/2] ima: measure userspace policy writes before
 parsing
From: Mimi Zohar <zohar@linux.ibm.com>
To: Enrico Bravi <enrico.bravi@polito.it>, linux-integrity@vger.kernel.org,
        dmitry.kasatkin@gmail.com, roberto.sassu@huawei.com
Cc: eric.snowberg@oracle.com
In-Reply-To: <20260702190403.5844-3-enrico.bravi@polito.it>
References: <20260702190403.5844-1-enrico.bravi@polito.it>
	 <20260702190403.5844-3-enrico.bravi@polito.it>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Date: Mon, 06 Jul 2026 23:03:49 -0400
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Evolution 3.58.3 (3.58.3-1.fc43) 
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Authority-Analysis: v=2.4 cv=KsJ9H2WN c=1 sm=1 tr=0 ts=6a4c6c98 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=iQ6ETzBq9ecOQQE5vZCe:22 a=k-j7cIN_mrTqlliAKiUA:9
 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA3MDAyNSBTYWx0ZWRfX64zh0fPbmtyS
 5sp81F8oObL6cUERtWaVRTCS9/eFv/FT3rdJw8iYEEf3DKH42VvU8U+NUKPwlN/P488r25xTchd
 cDGova+KkkWRyBZGn/OwXa6FlvjzZuA=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA3MDAyNSBTYWx0ZWRfXzJQknCwvjyU2
 /y8knQMc1lgZI9c6XPq1oaMTbqCodqMf1sxK8OjHpe930tFcRRaHv6vk+w9CTjJRs3wCy35I5K5
 JJCMSr2jNQiIiwGAppQvAd3wOxkt5PLS6FRBiZReH4yOMiYsAuplq2vSXY9oK5TsFSiOIIHHXXY
 /ZQi6H1y0BaGOIA0XyoZ1mp7M0ZbDhAYSBmqAZpoxrbMoCDbaqo0M712t/JBFed+e9ft+o2axUq
 cqLYX9ItYvC+S0RWJfyiR5CVzRxbHk1GGbcdcpidscyiU948bsD4Cinyd92+hkVus11+Rh2G3yX
 WexCrkLvkK/+4nJr/IcFp7sORmYeXQ+BUiDFlJdAuIHBUbC/qOqBVCiOiOO/eDY7fUWZ0KKPbCr
 OfsqhrkBvpXplLAfZKzpxPGoO3mNfBugW6ChOS+xMzbhYv5V9c3Zklj0GFDDxa6sMEU3nQ8hBya
 m+fy2cC2fZAoDTugT8g==
X-Proofpoint-ORIG-GUID: DJI2F0XYPXIWnu2tc2xZAAKwqvpvuzhh
X-Proofpoint-GUID: ye_QblJ_pHBDUwwg5I6hRflz6AUP9tuY
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-06_03,2026-07-06_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 malwarescore=0 spamscore=0 adultscore=0 clxscore=1015
 suspectscore=0 lowpriorityscore=0 priorityscore=1501 bulkscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607070025
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[ibm.com,none];
	R_DKIM_ALLOW(-0.20)[ibm.com:s=pp1];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-9888-lists,linux-integrity=lfdr.de];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FREEMAIL_TO(0.00)[polito.it,vger.kernel.org,gmail.com,huawei.com];
	FORGED_RECIPIENTS(0.00)[m:enrico.bravi@polito.it,m:linux-integrity@vger.kernel.org,m:dmitry.kasatkin@gmail.com,m:roberto.sassu@huawei.com,m:eric.snowberg@oracle.com,m:dmitrykasatkin@gmail.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[zohar@linux.ibm.com,linux-integrity@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,linux.ibm.com:mid,linux.ibm.com:from_mime];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[zohar@linux.ibm.com,linux-integrity@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[ibm.com:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[linux-integrity];
	RCVD_COUNT_SEVEN(0.00)[11]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: BECD2716F2B

On Thu, 2026-07-02 at 21:04 +0200, Enrico Bravi wrote:

> diff --git a/security/integrity/ima/ima_policy.c b/security/integrity/ima=
/ima_policy.c
> index a65b7e4b64d6..d6d249190705 100644
> --- a/security/integrity/ima/ima_policy.c
> +++ b/security/integrity/ima/ima_policy.c
> @@ -591,6 +593,7 @@ static bool ima_match_rules(struct ima_rule_entry *ru=
le,
>  	switch (func) {
>  	case KEY_CHECK:
>  	case CRITICAL_DATA:
> +	case POLICY_CHECK:
>  		return ((rule->func =3D=3D func) &&
>  			ima_match_rule_data(rule, func_data, cred));
>  	default:

Hi Enrico,

Unlike the other hooks, KEY_CHECK and CRITICAL_DATA are special cases, whic=
h
only allow a set of keyrings or labels respectively.  POLICY_CHECK rules ca=
n be
defined in terms of other file metadata (e.g. uid, gid, ...). With this cha=
nge,
any options specified on the rule will be not be matched.

ima_match_rule_data() should only be called for buffer measurements, when t=
here
is no inode.=20

+               return ((rule->func =3D=3D func) && !inode &&
                        ima_match_rule_data(rule, func_data, cred));

Otherwise the patch looks good.

Mimi

