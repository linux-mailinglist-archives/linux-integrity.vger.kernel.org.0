Return-Path: <linux-integrity+bounces-9897-lists+linux-integrity=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-integrity@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id Mc+wE25cTWqdywEAu9opvQ
	(envelope-from <linux-integrity+bounces-9897-lists+linux-integrity=lfdr.de@vger.kernel.org>)
	for <lists+linux-integrity@lfdr.de>; Tue, 07 Jul 2026 22:07:10 +0200
X-Original-To: lists+linux-integrity@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9712671F79E
	for <lists+linux-integrity@lfdr.de>; Tue, 07 Jul 2026 22:07:09 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=ibm.com header.s=pp1 header.b="MpGf1Qe/";
	dmarc=pass (policy=none) header.from=ibm.com;
	spf=pass (mail.lfdr.de: domain of "linux-integrity+bounces-9897-lists+linux-integrity=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="linux-integrity+bounces-9897-lists+linux-integrity=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 44AAD30134AC
	for <lists+linux-integrity@lfdr.de>; Tue,  7 Jul 2026 20:07:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D8323B27FE;
	Tue,  7 Jul 2026 20:07:04 +0000 (UTC)
X-Original-To: linux-integrity@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE9F63DC850
	for <linux-integrity@vger.kernel.org>; Tue,  7 Jul 2026 20:07:02 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783454824; cv=none; b=A68DLFiwY86JgRtG6q8JSZ1m3MRG3QHPhlZZJzf65wniKJZHOiuaqAzx6lLjgE8gajLpgFUYBnYgUksdPFk4VnTEhHBvZsbB5zqbsMhQgfW0Yj61MXut1S0tqbTZA0HOEX/B/xouOm/tPmocZSwhdVH2lrSkbE3s5iUOi7ghklM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783454824; c=relaxed/simple;
	bh=8vx93YVi0+k1SN6fODmMcSf5lbT0wUFlJUEHZaC/7C8=;
	h=Message-ID:Subject:From:To:Cc:In-Reply-To:References:Content-Type:
	 Date:MIME-Version; b=ate1qLmzuoWvS1F5K1hW2ZM4dF6hENcXdEk9fyM4iH7pmMy4a5xL2E872TSb9xvystWrYKUnz2ZizLMKknUTIPD7rD4KSrx0uwMIDLOxa2boSbSBY5ySkLXYTI2UZAeJ8RlAR/PihzmdQt02rp8P1+OGmG49gfbtvsSBEpJloec=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=MpGf1Qe/; arc=none smtp.client-ip=148.163.158.5
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 667JIwAd1146627;
	Tue, 7 Jul 2026 20:06:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=NeTLIX
	XOExg5bXyjRxJWYHfyKrDekqs8cb3hCttfR58=; b=MpGf1Qe/WufhbCdfm3Vz01
	IgJvWzNfctg0kUrJEcBqKOD2+IC9U6uAE4J8mHxSdnpA/eeNiTwoo+nq07TAQVei
	PSMP9YqeIBequzdR0A920JSgA2yrNbjSB/zTKbg6pe9j5jynJzV1dpBY780IIWXr
	n44oK9KMaqwJBH32sIM4jBfJH0NYUocEnFCj1FlmEUOEXcX9FjnFOgEeL3Gk5Wtp
	nmeTQeK8LKAir1F6INb/g4BBzMQxf5v5GwRrya1R/8O+Gesk1xJI6I5ydOehPDyX
	GfqZAxufJB8qO+DIML3/mMhdq08dNHrgrW4Bt6+bxD1a4TB29KXc3Im91id/j1Qw
	==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4f6qknguv8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 07 Jul 2026 20:06:51 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 667K4gYm031893;
	Tue, 7 Jul 2026 20:06:50 GMT
Received: from smtprelay04.wdc07v.mail.ibm.com ([172.16.1.71])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4f7f6y46hj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 07 Jul 2026 20:06:50 +0000 (GMT)
Received: from smtpav02.wdc07v.mail.ibm.com (smtpav02.wdc07v.mail.ibm.com [10.39.53.229])
	by smtprelay04.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 667K6nGC36700816
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 7 Jul 2026 20:06:50 GMT
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D25F95805D;
	Tue,  7 Jul 2026 20:06:49 +0000 (GMT)
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 38B1858059;
	Tue,  7 Jul 2026 20:06:49 +0000 (GMT)
Received: from li-43857255-d5e6-4659-90f1-fc5cee4750ad.ibm.com (unknown [9.61.134.9])
	by smtpav02.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Tue,  7 Jul 2026 20:06:49 +0000 (GMT)
Message-ID: <80faa6f4928ab77604e1ce76ef625a5885e08c82.camel@linux.ibm.com>
Subject: Re: [PATCH v5 2/2] ima: measure userspace policy writes before
 parsing
From: Mimi Zohar <zohar@linux.ibm.com>
To: Enrico Bravi <enrico.bravi@polito.it>,
        "roberto.sassu@huawei.com"
	 <roberto.sassu@huawei.com>,
        "linux-integrity@vger.kernel.org"
	 <linux-integrity@vger.kernel.org>,
        "dmitry.kasatkin@gmail.com"
	 <dmitry.kasatkin@gmail.com>
Cc: "eric.snowberg@oracle.com" <eric.snowberg@oracle.com>
In-Reply-To: <801419f4424e106dd2fe66d8291a2343708245ba.camel@polito.it>
References: <20260702190403.5844-1-enrico.bravi@polito.it>
			 <20260702190403.5844-3-enrico.bravi@polito.it>
		 <002330a72cdec8eaa554fddd5b8d428245ed83e4.camel@linux.ibm.com>
	 <801419f4424e106dd2fe66d8291a2343708245ba.camel@polito.it>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Date: Tue, 07 Jul 2026 16:06:48 -0400
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Evolution 3.58.3 (3.58.3-1.fc43) 
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Authority-Analysis: v=2.4 cv=Q/XiJY2a c=1 sm=1 tr=0 ts=6a4d5c5b cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=Y2kxHp48a9q4ObHHh6gA:9
 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: _7-Yg2nVJfywxyUd0Plr6QQvQdUG9iEQ
X-Proofpoint-ORIG-GUID: 3mvKLQdsNl6AGh5qXvh1hDDfZWY2fQcb
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA3MDE5NCBTYWx0ZWRfX/W1cIX12+k9x
 2qdzUmvpNwGJbMNas333/LX7o6eimyeFsEnEVnWC1McbwYzD8RMjOOpI/m8e5zhhfcLiumxpTC2
 AGnbiHac9zjxfdBuP77fjNHmP00U0go=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA3MDE5NCBTYWx0ZWRfX68t/9OmpbvCJ
 e2TzwoxDrEY60BY9fuM3tm3wcsuMj2hjQV6/wDhch2fjjtqkuqZfr7IAAyAz80ZvLRoXOHsIzBM
 Is9MrgqR+Cdgh7YMdqghWqCJOFIDkuWJl9n2dBqch9X2CudUsLrnDqbGKMbm9rVndUY63l0ajWc
 p7nMaIQ1Yy3kzGmIMzYM9MUD2dNXGzK/d1+XbMcVMf3rPPD15wW05ZIxtEWItb/pyx0ziJMGYZK
 PvynKT7R98unPn8mQqWZAnBrdRKIRFnBJ+qNuM2ucZgwD5p2Dish/Ou90reUW/ZAY+Q/uUzaTU1
 8fYzMnrp9Cy0cNTI2QUaS43nJEtU0O+3GcdwR8wb67t6qbw868JOMTu5BiWCHjPoswQWE9OxmYy
 iKTrYRgguepbnPSb82a28soUi9wCEttGoa/8VnxP8MY0jdBjB4QetVQcDIsMLfg6/srBHqc3DeE
 xD+xy4mAVvWDGKeketg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-07_05,2026-07-06_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 impostorscore=0 spamscore=0 phishscore=0 priorityscore=1501
 bulkscore=0 clxscore=1015 lowpriorityscore=0 suspectscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607070194
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[ibm.com,none];
	R_DKIM_ALLOW(-0.20)[ibm.com:s=pp1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-9897-lists,linux-integrity=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:enrico.bravi@polito.it,m:roberto.sassu@huawei.com,m:linux-integrity@vger.kernel.org,m:dmitry.kasatkin@gmail.com,m:eric.snowberg@oracle.com,m:dmitrykasatkin@gmail.com,s:lists@lfdr.de];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	FORGED_SENDER(0.00)[zohar@linux.ibm.com,linux-integrity@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[polito.it,huawei.com,vger.kernel.org,gmail.com];
	TO_DN_SOME(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-integrity];
	RCVD_COUNT_SEVEN(0.00)[11]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 9712671F79E

On Tue, 2026-07-07 at 15:25 +0000, Enrico  Bravi wrote:
> On Mon, 2026-07-06 at 23:03 -0400, Mimi Zohar wrote


> > ima_match_rule_data() should only be called for buffer measurements, wh=
en
> > there
> > is no inode.=20
> >=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 return ((rule->func =3D=3D func) && !inode &&
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ima_m=
atch_rule_data(rule, func_data, cred));
>=20
> I was thinking that in this way, it would not trigger the measurement whe=
n
> loading the policy from a file. If inode is not NULL, it directly returns=
 false
> instead of continuing. What do you thing of something like this:
>=20
>         switch (func) {
> +       case POLICY_CHECK:
> +               if (inode)
> +                       break;
> +               fallthrough;
>         case KEY_CHECK:
>         case CRITICAL_DATA:
>                 return ((rule->func =3D=3D func) &&
>                         ima_match_rule_data(rule, func_data, cred));

Yes, your version is clearer.

Mimi

