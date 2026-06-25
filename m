Return-Path: <linux-integrity+bounces-9834-lists+linux-integrity=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-integrity@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id /uxjJkQ6PWo3zggAu9opvQ
	(envelope-from <linux-integrity+bounces-9834-lists+linux-integrity=lfdr.de@vger.kernel.org>)
	for <lists+linux-integrity@lfdr.de>; Thu, 25 Jun 2026 16:25:08 +0200
X-Original-To: lists+linux-integrity@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E15D96C69AC
	for <lists+linux-integrity@lfdr.de>; Thu, 25 Jun 2026 16:25:07 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=ibm.com header.s=pp1 header.b=dqcmJXI8;
	spf=pass (mail.lfdr.de: domain of "linux-integrity+bounces-9834-lists+linux-integrity=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="linux-integrity+bounces-9834-lists+linux-integrity=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=ibm.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 006C4315B815
	for <lists+linux-integrity@lfdr.de>; Thu, 25 Jun 2026 14:18:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E23A3672B7;
	Thu, 25 Jun 2026 14:18:14 +0000 (UTC)
X-Original-To: linux-integrity@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DA6E35DA75
	for <linux-integrity@vger.kernel.org>; Thu, 25 Jun 2026 14:18:11 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782397094; cv=none; b=H2HHNSXwnQeMlheKXHoxtHFs7opCCUmOPTrWkN0MIG8Snw4dUo0h6rysCRAkgq3K6rV1qbrixmtAimUCQyLql/gYcXxHpYOklJZUG+GiLgdchuOqZS3/B3V/mfHSZ2VkA3KWXkO69E4WvY8366z1rFQOqj8GtBGElqsrwUT+qIE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782397094; c=relaxed/simple;
	bh=BMYVQ81LOsyO4KZ45HuAD0vIO7UbFpHXpxT3IFmHMAc=;
	h=Message-ID:Subject:From:To:Cc:In-Reply-To:References:Content-Type:
	 Date:MIME-Version; b=ugpV0XlZyns38ooy5vpTNVnruWKEdfZ5BVLN1BO/OTGoMe44CjSdFLwtk0hHZM5TAKzitfLNxSMFra+imFDcXDn/Nrq8w6tPWfBFVMNabLsCE6eRKfmkNImCvFkInu/XF+zc+C4aF53Z/i6LlNS6eYw4sAT7myVMu9XfnrrXd0s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=dqcmJXI8; arc=none smtp.client-ip=148.163.156.1
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65P3mVDf2977929;
	Thu, 25 Jun 2026 14:17:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=wEcgv3
	KN7mGOq0n7qL7T/AuNyUJlp1EI4QpnXcml+qM=; b=dqcmJXI8E7eFdQZU5d6VmW
	Uq1hBmxCsqXlawhDyEdNHbwC/zkVd3pfNN5l9mSjViXcbRIm8jNoYVC2VtkqbaYi
	sUzn86SGX2ts2EkYWO4Z27Ca6qEKW9i5sZVpe+vwQNypdVhVNUnf6Pmn3Y+gs7Mv
	CQL3Aj416b4DaKH+DGXzSRWYQZIJGsmUslAG6jaSp4VSTTjiVfeiVwzmxvsS+Bdu
	BFAco/KLevEdvSJ5npQB/7zuPqtYIjCRhp/Qkjwc9kd5riXQew3OOj4LrSjxde78
	c0EdqO9C/V2wvzVX3dTcq0y/b2iiNTBvsKQWaZfit2tMHvuuSWqKedlnKPO7eyww
	==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4ewjk4t6w9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 25 Jun 2026 14:17:49 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 65PE4csw003261;
	Thu, 25 Jun 2026 14:17:48 GMT
Received: from smtprelay01.wdc07v.mail.ibm.com ([172.16.1.68])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4ex7vyx72u-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 25 Jun 2026 14:17:48 +0000 (GMT)
Received: from smtpav01.wdc07v.mail.ibm.com (smtpav01.wdc07v.mail.ibm.com [10.39.53.228])
	by smtprelay01.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 65PEHlN48324048
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 25 Jun 2026 14:17:47 GMT
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B329158059;
	Thu, 25 Jun 2026 14:17:47 +0000 (GMT)
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 15B1858055;
	Thu, 25 Jun 2026 14:17:47 +0000 (GMT)
Received: from li-43857255-d5e6-4659-90f1-fc5cee4750ad.ibm.com (unknown [9.61.18.134])
	by smtpav01.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 25 Jun 2026 14:17:46 +0000 (GMT)
Message-ID: <6bc5e716ce0e9b1b3a9d2adacdc63474e342c30e.camel@linux.ibm.com>
Subject: Re: [PATCH v4 1/2] ima: measure loaded policy after write on
 securityfs policy file
From: Mimi Zohar <zohar@linux.ibm.com>
To: Enrico Bravi <enrico.bravi@polito.it>, linux-integrity@vger.kernel.org,
        dmitry.kasatkin@gmail.com, roberto.sassu@huawei.com
Cc: eric.snowberg@oracle.com
In-Reply-To: <1f23b6cb35538f471dbb68534308784616130cb9.camel@linux.ibm.com>
References: <20260617155832.434517-1-enrico.bravi@polito.it>
		 <20260617155832.434517-2-enrico.bravi@polito.it>
	 <1f23b6cb35538f471dbb68534308784616130cb9.camel@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Date: Thu, 25 Jun 2026 10:17:46 -0400
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Evolution 3.58.3 (3.58.3-1.fc43) 
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjI1MDExOSBTYWx0ZWRfX44jSIz8ems4c
 Dysr/7WIJLMPw79OIyRGe3zO7fAiTkWUZf2bkfg0W9ZOlaFHVCYfdjX/C6tLzYGXM1vd8cX+s8y
 oK48IzuMWxIz0a+luq0kEewK5ih3FVw=
X-Proofpoint-ORIG-GUID: a_nZoJ_w2NKd7Gergjw-fr9vGDrTLpXi
X-Authority-Analysis: v=2.4 cv=Oph/DS/t c=1 sm=1 tr=0 ts=6a3d388d cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=U7nrCbtTmkRpXpFmAIza:22 a=L4Q49AYcEpNOPB0_MhEA:9
 a=QEXdDO2ut3YA:10 a=ZXulRonScM0A:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjI1MDExOSBTYWx0ZWRfX5vywx4ly10bt
 mayKOIJbXR+TV9XW/9ih/WLHNcMTgiOs3/WLDzaqpjJLYpdP6PY5cZQdUSn/1rW6rYNI57F1fBx
 PXrUCP1LDmTjfF6y2Lqlaujo7BAzbelPpbaGQPFAAw3qijk4P/Sj8Lbg16pJ9Au0ygQCGVTuBUo
 FdHgEbPfOZhM4qBWHvqdJwFUQFyjpP9ZdFxLdmi67Q2h0wjplx9xGRdcISFyTJ/cs9d0mqR4gao
 ZKZchosySWQzgWqIMTJAq7Fbqg9y5FpRQc2gZXsLXeedgF0opTpQMrHmAp/fKOXkoYC69WncLhl
 j3/yVGbDCNeDsnN3xTW01AyTFPDaoPBk+WpfXkdJVJhqRbVCTMrrg+WIjmAvbZiY63PpeAi4/sD
 r2pxyA4W56jD2SNlwzxn/nICliwjD0SJAlxW1fGfz59a4XBz8sh0jSLw9rspE1x/UGlQlkxciqC
 zPedZf4Twlbi3P5rRsA==
X-Proofpoint-GUID: D2P_GW8Dq5eWI39SlUK_CIRLHSfs3VlL
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-25_01,2026-06-24_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 lowpriorityscore=0 bulkscore=0 spamscore=0 priorityscore=1501
 clxscore=1015 impostorscore=0 malwarescore=0 adultscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606250119
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
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-9834-lists,linux-integrity=lfdr.de];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FREEMAIL_TO(0.00)[polito.it,vger.kernel.org,gmail.com,huawei.com];
	FORGED_RECIPIENTS(0.00)[m:enrico.bravi@polito.it,m:linux-integrity@vger.kernel.org,m:dmitry.kasatkin@gmail.com,m:roberto.sassu@huawei.com,m:eric.snowberg@oracle.com,m:dmitrykasatkin@gmail.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[zohar@linux.ibm.com,linux-integrity@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,linux.ibm.com:mid,linux.ibm.com:from_mime,checkpatch.pl:url];
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
X-Rspamd-Queue-Id: E15D96C69AC

On Wed, 2026-06-24 at 16:35 -0400, Mimi Zohar wrote:
[...]

> > diff --git a/security/integrity/ima/ima_policy.c b/security/integrity/i=
ma/ima_policy.c
> > index f7f940a76922..0a70d10da70a 100644
> > --- a/security/integrity/ima/ima_policy.c
> > +++ b/security/integrity/ima/ima_policy.c
>=20
> > @@ -2379,3 +2378,70 @@ bool ima_appraise_signature(enum kernel_read_fil=
e_id id)
> >  	return found;
> >  }
> >  #endif /* CONFIG_IMA_APPRAISE && CONFIG_INTEGRITY_TRUSTED_KEYRING */
> > +
> > +/**
> > +* ima_measure_loaded_policy - measure the active IMA policy ruleset
> > +*
> > +* Must be called with ima_write_mutex held, as it performs two
> > +* separate RCU read passes over ima_rules and relies on the mutex
> > +* to prevent concurrent policy updates between them.
> > +*/

Hi Enrico,

I forgot to mention that the kernel-doc formatting is off.  Refer to
checkpatch.pl for the details.  Either change it to a regular comment or fo=
rmat
it properly.

thanks,

Mimi
>=20

