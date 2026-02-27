Return-Path: <linux-integrity+bounces-8685-lists+linux-integrity=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-integrity@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yJtKEKjmoWmUwwQAu9opvQ
	(envelope-from <linux-integrity+bounces-8685-lists+linux-integrity=lfdr.de@vger.kernel.org>)
	for <lists+linux-integrity@lfdr.de>; Fri, 27 Feb 2026 19:47:04 +0100
X-Original-To: lists+linux-integrity@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D8F031BC295
	for <lists+linux-integrity@lfdr.de>; Fri, 27 Feb 2026 19:47:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 4773030151EE
	for <lists+linux-integrity@lfdr.de>; Fri, 27 Feb 2026 18:47:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFA7230EF96;
	Fri, 27 Feb 2026 18:47:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="O2b/IYYl"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76DCE37BE9B;
	Fri, 27 Feb 2026 18:46:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772218020; cv=none; b=tf3t0WlNpuuY0K2a4ogNHLkADvZjfpLMFHv5sDkQVENIZV5tcAryjXyDsouHnDCPCjlfw19UDbSlm85ID0sojGIyx+xwDNe6Ozu1jSyY3dKkcV1YcxIPs6/U1OmUaIXruQfwxopS0RF+y13nUdYZ6ZUgYEq+bHA7wEBxtk/bWR8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772218020; c=relaxed/simple;
	bh=l5FLOa8OoBz6WlZAnlSDLhYDFS0I1GI+IauNHm9Rwz8=;
	h=Message-ID:Subject:From:To:Cc:In-Reply-To:References:Content-Type:
	 Date:MIME-Version; b=jSMtax5x4DGFAP3+LPLx+/M6r6feVuz6zTxaTfIJd4B9UVCWYIuNIEu4GF1SMgWTAnHuKKYjxXDtRIOlKMOklp56argyN7HrNcoI0a06jY2DJ+1qbhJBpadSu+89mGUSVDUdo2eLCcbzNsbeAvGaO+8851CTNSSMD1Zci1zS+eI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=O2b/IYYl; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 61RGFkei2346005;
	Fri, 27 Feb 2026 18:46:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=xESYnA
	wH+wG85a8XL7co7q9y7OKCMGEvMH95ZhSfjuw=; b=O2b/IYYlyjAqYZaNLoKGaI
	nR7DsDhb5STIB/Yo2PK9vSeUUSma65gp+DhSIcZSQSm9wXs8Ofr3JKOQSMrLWhMc
	p6j5gkovJXh0Rm/5ds4vE8LmIu2Clk8KTJexN20fs0DzJ3F2cp4H9uBNMdN9/7Bh
	s5S2JikIwMjvd0aUbcP4AkyuH6YyurVGCcZ+fWnhjFGcL9GlHVlpZPFxi2kiv+XG
	xGnc5YmLLO/tEniuqPFjDxlPV8uMl3rwfCpdRMd2aRrEAQzpJuRcKtjXTeCxv9id
	zs1fo5s6qd6p4TcruAA0sH5FTVOLNBrK8SQRLLsgLfoybossZXWZVNQbBzThblXA
	==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4ch8593k5g-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 27 Feb 2026 18:46:36 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 61RFtm7O003397;
	Fri, 27 Feb 2026 18:46:35 GMT
Received: from smtprelay03.dal12v.mail.ibm.com ([172.16.1.5])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4cfs8kbda9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 27 Feb 2026 18:46:35 +0000
Received: from smtpav06.wdc07v.mail.ibm.com (smtpav06.wdc07v.mail.ibm.com [10.39.53.233])
	by smtprelay03.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 61RIkYe128836470
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 27 Feb 2026 18:46:35 GMT
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D717A5804E;
	Fri, 27 Feb 2026 18:46:34 +0000 (GMT)
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 541AC5803F;
	Fri, 27 Feb 2026 18:46:33 +0000 (GMT)
Received: from li-43857255-d5e6-4659-90f1-fc5cee4750ad.ibm.com (unknown [9.61.86.1])
	by smtpav06.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 27 Feb 2026 18:46:33 +0000 (GMT)
Message-ID: <dee902ad4fcbc60ed2051cb0d165232ad27c45b1.camel@linux.ibm.com>
Subject: Re: [PATCH v5] ima_fs: Avoid creating measurement lists for
 unsupported hash algos
From: Mimi Zohar <zohar@linux.ibm.com>
To: Roberto Sassu <roberto.sassu@huaweicloud.com>, dima@arista.com,
        Roberto
 Sassu <roberto.sassu@huawei.com>,
        Dmitry Kasatkin
 <dmitry.kasatkin@gmail.com>,
        Eric Snowberg	 <eric.snowberg@oracle.com>,
        Paul Moore <paul@paul-moore.com>, James Morris	 <jmorris@namei.org>,
        "Serge
 E. Hallyn" <serge@hallyn.com>,
        Silvia Sisinni	 <silvia.sisinni@polito.it>,
        Enrico Bravi <enrico.bravi@polito.it>
Cc: Jonathan McDowell <noodles@earth.li>, linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org, Dmitry Safonov <0x7f454c46@gmail.com>
In-Reply-To: <0fde824faace320c6d3ef6137bf50cee0289c6c0.camel@huaweicloud.com>
References: <20260223-ima-oob-v5-1-91cc1064e767@arista.com>
		 <6808b1a8fcb014e6c7c18241d39155f5c12edc31.camel@linux.ibm.com>
	 <0fde824faace320c6d3ef6137bf50cee0289c6c0.camel@huaweicloud.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Date: Fri, 27 Feb 2026 13:46:32 -0500
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Evolution 3.56.2 (3.56.2-2.fc42) 
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjI3MDE2NCBTYWx0ZWRfX4ikwkWiOr3fo
 hpqqs/f4JxcIUyNSDJs1RzIc5LW8Z3FlwFpkvcEfX6HM95YQtinMlqJlukIs+LWzp9umfKA1E/q
 uLwXHimTzsRWFRN8jpsUOSC/3hFBUOlqJtkrn5oEL21c3iYEwTMY5C0P8yo3FZZoWJCQUU8XnGx
 ITyS/24JkId3LHIXNP3gQXP8XnVX4LNs9DZUJj5mbQRkkdKm94K5V0cXH93aEBs8XOwwt9lqkGs
 lUjRfmbxFlGMHW9FPSnOVNy8lOTwRpBD3scOWzoVZpODdtl+DRr4F+reVwcKC+bHpz000C0NkEZ
 pvWaH2Q/u/1mv34TYNGLPEY2u5I9Tt2OhyNfOjni7aTyrU3BTe/F+fElgPI2P+PvlWY6pI+ze/7
 74iXfKOap0o2EPPrIX/9wiXChGgkfciFBA8A/5tUbHd5IrOTUN2W82XvecTt4mBl3oxsMmrywsA
 cix4pUeBS2lAdrTkxmw==
X-Proofpoint-GUID: z9aNJUq5O6kg8zV9KGrsBKHK2KOghGe_
X-Authority-Analysis: v=2.4 cv=S4HUAYsP c=1 sm=1 tr=0 ts=69a1e68c cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=IkcTkHD0fZMA:10 a=HzLeVaNsDn8A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=Mpw57Om8IfrbqaoTuvik:22 a=GgsMoib0sEa3-_RKJdDe:22 a=f3jowhlJtBf6sRR6YjgA:9
 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: CsXVBNFM2kpkLJjWF4jEexV7Pk31WOaY
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-27_03,2026-02-27_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 clxscore=1015 impostorscore=0 malwarescore=0 bulkscore=0
 phishscore=0 adultscore=0 lowpriorityscore=0 spamscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2601150000 definitions=main-2602270164
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[ibm.com,none];
	R_DKIM_ALLOW(-0.20)[ibm.com:s=pp1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-8685-lists,linux-integrity=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[huaweicloud.com,arista.com,huawei.com,gmail.com,oracle.com,paul-moore.com,namei.org,hallyn.com,polito.it];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[earth.li,vger.kernel.org,gmail.com];
	RCPT_COUNT_TWELVE(0.00)[16];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,linux.ibm.com:mid];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[zohar@linux.ibm.com,linux-integrity@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[ibm.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-integrity];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	RCVD_COUNT_SEVEN(0.00)[11]
X-Rspamd-Queue-Id: D8F031BC295
X-Rspamd-Action: no action


> > > @@ -404,16 +398,24 @@ static int __init create_securityfs_measurement=
_lists(void)
> > >  		char file_name[NAME_MAX + 1];
> > >  		struct dentry *dentry;
> > > =20
> > > -		sprintf(file_name, "ascii_runtime_measurements_%s",
> > > -			hash_algo_name[algo]);
> > > +		if (algo =3D=3D HASH_ALGO__LAST)
> > > +			sprintf(file_name, "ascii_runtime_measurements_tpm_alg_%x",
> > > +				ima_tpm_chip->allocated_banks[i].alg_id);
> > > +		else
> > > +			sprintf(file_name, "ascii_runtime_measurements_%s",
> > > +				hash_algo_name[algo]);
> > >  		dentry =3D securityfs_create_file(file_name, S_IRUSR | S_IRGRP,
> > >  						ima_dir, (void *)(uintptr_t)i,
> > >  						&ima_ascii_measurements_ops);
> > >  		if (IS_ERR(dentry))
> > >  			return PTR_ERR(dentry);
> > > =20
> > > -		sprintf(file_name, "binary_runtime_measurements_%s",
> > > -			hash_algo_name[algo]);
> > > +		if (algo =3D=3D HASH_ALGO__LAST)
> > > +			sprintf(file_name, "binary_runtime_measurements_tpm_alg_%x",
> > > +				ima_tpm_chip->allocated_banks[i].alg_id);
> >=20
> > There's no point in creating either of the securityfs files if the kern=
el
> > doesn't support the hash algorithm.
>=20
> It is not useful per se, but since it is an information that it is
> produced and maintained by IMA, we can print it. And second, it will
> expose the fact that there is an unsupported algorithm (in the case of
> SHA3-256, the fix is add to the TPM - crypto subsystem mapping in tpm2-
> cmd.c).

Yes, agreed.

Dmitry, the Subject line implies the measurement lists aren't being created=
, yet
you're actually creating them.  Please update the patch description before =
re-
posting.

thanks,

Mimi

