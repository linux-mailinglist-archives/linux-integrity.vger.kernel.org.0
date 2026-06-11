Return-Path: <linux-integrity+bounces-9791-lists+linux-integrity=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-integrity@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id EcVEIMDGKmprwwMAu9opvQ
	(envelope-from <linux-integrity+bounces-9791-lists+linux-integrity=lfdr.de@vger.kernel.org>)
	for <lists+linux-integrity@lfdr.de>; Thu, 11 Jun 2026 16:31:28 +0200
X-Original-To: lists+linux-integrity@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D2B90672B9A
	for <lists+linux-integrity@lfdr.de>; Thu, 11 Jun 2026 16:31:22 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=ibm.com header.s=pp1 header.b=dT6BsrEP;
	spf=pass (mail.lfdr.de: domain of "linux-integrity+bounces-9791-lists+linux-integrity=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="linux-integrity+bounces-9791-lists+linux-integrity=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=ibm.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 11A113197FAF
	for <lists+linux-integrity@lfdr.de>; Thu, 11 Jun 2026 14:31:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 911CF405F7;
	Thu, 11 Jun 2026 14:30:59 +0000 (UTC)
X-Original-To: linux-integrity@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6D4227AC31
	for <linux-integrity@vger.kernel.org>; Thu, 11 Jun 2026 14:30:57 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781188259; cv=none; b=GgnsaV8rNCxyalXTx/BjqNXcd6acq6ofXhqJQAWdzv77fcdxMUxxuyh9bYgvmrC85r5bqqXAUaEuObbrnSLnnIY+xUfP6vuv5/cDc6oWObFSsCgl798sRDqXAu/uYDV7JZYYghBJgohiw3R98X2yC301FTOdt1rjgpjTdREOpLs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781188259; c=relaxed/simple;
	bh=P5DcPQcRovV4Sr2tpVOuRxUa2dUkWwFFwQEDdTDgP6U=;
	h=Message-ID:Subject:From:To:Cc:In-Reply-To:References:Content-Type:
	 Date:MIME-Version; b=gLxBmvC7j2e1rVLzkuaAod5xNmYhQprR0TnH5FKOolRruitwAWVh6H7RWYkR/eHrjutqgYllHqGsjFY98mwf3mF9hG8T+RZ+E4smMrTPheAs3OKNSvO58DcNV5M9Up5Pnh3Nc0sUCuvZD4qN7m6deXd+MHd176OcKa7kx1nHzA8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=dT6BsrEP; arc=none smtp.client-ip=148.163.158.5
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65BBhArH677384;
	Thu, 11 Jun 2026 14:30:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=u37Ucs
	DXP+BBsqksXDaR7f6c09tTKgY8OlcJ5u/JvTQ=; b=dT6BsrEPHvhg6a8ShYcHmQ
	1cICtlPB4MLNpYW3/QorYwnInFxJDzYI48c6BPGDOlEAO8lCuk8TmrkChva4A3t6
	O82XrScNIL5/6JpTeSqsDl+d0FuiMoIbOkOh/YITTQndJNxecTQQnu045mcK/7WB
	GRIJ447ygeQ1I16D9KvFuEHyTs8CZMk1jpfyc3J0TpwBuIXJSEEwKkYNYWiI92Et
	UKl96tt4HSMUTg0H3BnG7M02kuReZnXjPj9E14cS+EGSJJBd7Cy56kBOYRqU0HtH
	92D+f2lhKQ6hediiLdzP/rbLOt4KexEzDZ2PbG5CS5FQg6yuiwwdVuFt7WciGYLQ
	==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4eqe8am2rn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 11 Jun 2026 14:30:41 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 65BEJcjb020643;
	Thu, 11 Jun 2026 14:30:41 GMT
Received: from smtprelay07.dal12v.mail.ibm.com ([172.16.1.9])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4eqe09kj3g-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 11 Jun 2026 14:30:41 +0000 (GMT)
Received: from smtpav06.wdc07v.mail.ibm.com (smtpav06.wdc07v.mail.ibm.com [10.39.53.233])
	by smtprelay07.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 65BEUex923921216
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 11 Jun 2026 14:30:40 GMT
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 70DEF5803F;
	Thu, 11 Jun 2026 14:30:40 +0000 (GMT)
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D2B6058055;
	Thu, 11 Jun 2026 14:30:39 +0000 (GMT)
Received: from li-43857255-d5e6-4659-90f1-fc5cee4750ad.ibm.com (unknown [9.61.141.118])
	by smtpav06.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 11 Jun 2026 14:30:39 +0000 (GMT)
Message-ID: <5703152fed864a39eb54cfccb571e9781a493760.camel@linux.ibm.com>
Subject: Re: [RFC][PATCH v3 1/2] ima: measure loaded policy after write on
 securityfs policy file
From: Mimi Zohar <zohar@linux.ibm.com>
To: Enrico Bravi <enrico.bravi@polito.it>,
        "roberto.sassu@huawei.com"
	 <roberto.sassu@huawei.com>,
        "linux-integrity@vger.kernel.org"
	 <linux-integrity@vger.kernel.org>,
        "dmitry.kasatkin@gmail.com"
	 <dmitry.kasatkin@gmail.com>
Cc: "eric.snowberg@oracle.com" <eric.snowberg@oracle.com>
In-Reply-To: <7149d8e873fe59fedffd23a06c9c647d42660328.camel@polito.it>
References: <20260526135118.289633-1-enrico.bravi@polito.it>
			 <20260526135118.289633-2-enrico.bravi@polito.it>
		 <f48148da72e9111235cb06d9c4d6c959d5c67035.camel@linux.ibm.com>
	 <7149d8e873fe59fedffd23a06c9c647d42660328.camel@polito.it>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Date: Thu, 11 Jun 2026 10:30:39 -0400
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Evolution 3.58.3 (3.58.3-1.fc43) 
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-ORIG-GUID: CL3WvLx_LJIeRmALdNQIsZYQurOTb3EF
X-Authority-Analysis: v=2.4 cv=TdKmcxQh c=1 sm=1 tr=0 ts=6a2ac692 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=RzCfie-kr_QcCd8fBx8p:22 a=bYbbU_mBg596tDSxjskA:9
 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjExMDE0MiBTYWx0ZWRfX8Yix+4eqlU3j
 JPYk1aiVaBShEI/+1l/FsV0UlAXB/KmvLccbRU8HOs3bNk3l5vYskdwCj9aAnLt2obBYCXrpz9A
 MixxzqF6dQVselnqaGPph+4RLmqq4lgvQJUW1vdo0vMvSc13vjuM55aaxHvlX5AXx513CkgZSNe
 7yScciAtXPLEJDxqzwhR+tnp/l2rYG9Jt1vraA2d4ILKszM4Aw4QldzWWSuGyTo1ZrNbmRJkL6v
 hKSCS0tvnhZ59iFvtAUS4fAUU+wMYIRhnXSp30A5rM5IUHILTarG3I3Jl4ALKx5uLJbfz/Xiin8
 lyvyJd/odMSuv9ntlqXAvFuSG0DyIeFro18TQvI9sLXmH6yZ6BRPw0dyOlJhLUCy7wwsgyhJ4nH
 FC05JAq8FcqxeskB3ZqTkwnK4H/7nSP6Zt6QaKtdCEqE6+M1kFiTtl57gb69lu14fVzOui3XWYu
 Hm+IeTOetXfWXB/6zmw==
X-Proofpoint-GUID: ET5ZfiKbOpafTcKQZDG3-C50tz2E5O9W
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjExMDE0MiBTYWx0ZWRfXyAR9LJ1YN2JV
 jHcvg0ULELio2bq4WTYDnjnbiq6eniaVxJqL3v3ROlsC9EGDLGoMydO3UgHrTeRhe2uSzAp4y8O
 GnrV1Yk/CnMZ0EHUP4Q3NHoPWUNdQEQ=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-11_02,2026-06-11_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 malwarescore=0 clxscore=1015 impostorscore=0 adultscore=0
 bulkscore=0 priorityscore=1501 lowpriorityscore=0 spamscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606040000 definitions=main-2606110142
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
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-9791-lists,linux-integrity=lfdr.de];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[polito.it,huawei.com,vger.kernel.org,gmail.com];
	FORGED_RECIPIENTS(0.00)[m:enrico.bravi@polito.it,m:roberto.sassu@huawei.com,m:linux-integrity@vger.kernel.org,m:dmitry.kasatkin@gmail.com,m:eric.snowberg@oracle.com,m:dmitrykasatkin@gmail.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[zohar@linux.ibm.com,linux-integrity@vger.kernel.org];
	FORWARDED(0.00)[lists@lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,vger.kernel.org:from_smtp];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	MAILSPIKE_FAIL(0.00)[2600:3c0a:e001:db::12fc:5321:query timed out];
	FROM_NEQ_ENVFROM(0.00)[zohar@linux.ibm.com,linux-integrity@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[ibm.com:+];
	FORGED_SENDER_FORWARDING(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[linux-integrity];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[11]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: D2B90672B9A

On Thu, 2026-06-11 at 12:51 +0000, Enrico  Bravi wrote:
>=20
> > > diff --git a/security/integrity/ima/ima_efi.c
> > > b/security/integrity/ima/ima_efi.c
> > > index 138029bfcce1..8e9f85ec9a86 100644
> > > --- a/security/integrity/ima/ima_efi.c
> > > +++ b/security/integrity/ima/ima_efi.c
> > > @@ -60,6 +60,8 @@ static const char * const sb_arch_rules[] =3D {
> > > =C2=A0#endif
> > > =C2=A0#if IS_ENABLED(CONFIG_INTEGRITY_MACHINE_KEYRING) &&
> > > IS_ENABLED(CONFIG_IMA_KEYRINGS_PERMIT_SIGNED_BY_BUILTIN_OR_SECONDARY)
> > > =C2=A0	"appraise func=3DPOLICY_CHECK appraise_type=3Dimasig",
> > > +#else
> > > +	"measure func=3DCRITICAL_DATA label=3Dima_policy",
> > > =C2=A0#endif
> >=20
> > =C2=A0None of the other arch "measure" policy rules are conditional.=C2=
=A0 Should the
> > new
> > "measure" rule be limited?
>=20
> This condition aims to avoid measuring the policy loaded even if a signed=
 policy
> is required. In that case, it would not be possible to directly write the=
 policy
> in the securityfs file.

Good point. Since it is different than the other rules, could you add a com=
ment
here or in the patch description.

>=20
> > > =C2=A0	"measure func=3DMODULE_CHECK",
> > > =C2=A0	NULL
> > > diff --git a/security/integrity/ima/ima_fs.c
> > > b/security/integrity/ima/ima_fs.c
> > > index 012a58959ff0..75cb308cf01f 100644
> > > --- a/security/integrity/ima/ima_fs.c
> > > +++ b/security/integrity/ima/ima_fs.c
> > >=20
> > > @@ -2381,3 +2380,55 @@ bool ima_appraise_signature(enum kernel_read_f=
ile_id
> > > id)
> > > =C2=A0	return found;
> > > =C2=A0}
> > > =C2=A0#endif /* CONFIG_IMA_APPRAISE && CONFIG_INTEGRITY_TRUSTED_KEYRI=
NG */
> > > +
> >=20
> > Please add kernel-doc here, something like:
> >=20
> > /**
> > =C2=A0* ima_measure_loaded_policy - measure the active IMA policy rules=
et
> > =C2=A0*
> > =C2=A0* Must be called with ima_write_mutex held, as it performs two
> > =C2=A0* separate RCU read passes over ima_rules and relies on the mutex
> > =C2=A0* to prevent concurrent policy updates between them.
> > =C2=A0*/
>=20
> Sure, thank you. If it is ok for you I can directly add what you suggeste=
d.

This was suggested by Claude, so it should be acceptable to use.

>=20
> > > +void ima_measure_loaded_policy(void)
> > > +{
> > > +	const char *event_name =3D "ima_policy_loaded";
> > > +	const char *op =3D "measure_loaded_ima_policy";
> > > +	const char *audit_cause =3D "ENOMEM";
> > > +	struct ima_rule_entry *rule_entry;
> > > +	struct list_head *ima_rules_tmp;
> > > +	struct seq_file file;
> > > +	int result =3D -ENOMEM;
> > > +	size_t file_len;
> > > +	char rule[255];
> >=20
> > The 255-byte buffer may be insufficient for custom policy rules that in=
clude
> > additional fields such as LSM labels and other file metadata, unlike th=
e
> > simpler
> > built-in and architecture-specific rules. Please increase the buffer si=
ze to
> > accommodate the worst-case serialized rule length.
>=20
> Yes, I wrongly took as reference the arch policy rules case. I don't know=
 if the
> worst-case can be precisely estimated. I could increase the buffer size a=
nd
> check in any case if seq_has_overflowed(). Could it be an idea?

Sounds good.

>=20
> > > +
> > > +	/* calculate IMA policy rules memory size */
> > > +	file.buf =3D rule;
> > > +	file.read_pos =3D 0;
> > > +	file.size =3D 255;
> > > +	file.count =3D 0;
> > > +
> >=20
> > Please add "lockdep_assert_held(&ima_write_mutex);"=C2=A0 here.
>=20
> Yes, and this would actually fail because I'm not acquiring ima_write_mut=
ex in
> ima_release_policy().

Thanks.

Mimi
> >=20

