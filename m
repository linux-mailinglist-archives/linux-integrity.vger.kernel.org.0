Return-Path: <linux-integrity+bounces-9844-lists+linux-integrity=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-integrity@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id eB6lJriAPmpiHAkAu9opvQ
	(envelope-from <linux-integrity+bounces-9844-lists+linux-integrity=lfdr.de@vger.kernel.org>)
	for <lists+linux-integrity@lfdr.de>; Fri, 26 Jun 2026 15:38:00 +0200
X-Original-To: lists+linux-integrity@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 086316CD7FD
	for <lists+linux-integrity@lfdr.de>; Fri, 26 Jun 2026 15:38:00 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=ibm.com header.s=pp1 header.b=dhkGeQiP;
	spf=pass (mail.lfdr.de: domain of "linux-integrity+bounces-9844-lists+linux-integrity=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="linux-integrity+bounces-9844-lists+linux-integrity=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=ibm.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 0D923301738D
	for <lists+linux-integrity@lfdr.de>; Fri, 26 Jun 2026 13:37:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CC283F23D7;
	Fri, 26 Jun 2026 13:37:57 +0000 (UTC)
X-Original-To: linux-integrity@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AD7B380FFD
	for <linux-integrity@vger.kernel.org>; Fri, 26 Jun 2026 13:37:55 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782481077; cv=none; b=Nth/oCcHO+rpT3zB0Tkuup4FMDnu1WEcOtltYtBzWUboIPsfG1DGBqgIT73zYUkN1rzvNXx4DYdv20CUYYmz4VlphKsqMNEVzARgO43ruLLWjalD8kk3UZnOl4slsgU2h0WpW1C/H6Za4wmd3KdYxpFK90d5I9R8zhW69vS17ik=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782481077; c=relaxed/simple;
	bh=MVUrmh8ExA1am62lwKyg+vNf2WHX4xidlfYJmOnAjIU=;
	h=Message-ID:Subject:From:To:Cc:In-Reply-To:References:Content-Type:
	 Date:MIME-Version; b=JOBkYWMAPYbCU4vFk4k4XW+0wr3oyVq35pAZdsIAMzaMYwEuuFoqU6DNUigmbppj4jiGzgdQR+CIi93fARvIy66L7bYEynNkQZtApgR9rIIBq9LquLj0/5zajvgvn/QGK3EgqUlZJIus8haQk2RS1tpinscXGSYIOpBLiaF8biw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=dhkGeQiP; arc=none smtp.client-ip=148.163.158.5
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65QAJ4l62661015;
	Fri, 26 Jun 2026 13:37:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=VC1ga9
	Y/f2wDO/1nL+yxxE5sRjVfzCK4qyRW098JenE=; b=dhkGeQiPuZ0hX/UWNXLawB
	1ybTk+6SjHt/hmN3/Ar5uLuJmqD1BXJempoix1A95j8pzvezvGNq3RztEVWjRjui
	r+lT7A7To+uBCqGNfRNJG9x01iy7pmXEhJf+Ep7fczS51v/Wz95/01U9x6gCrb7i
	UKD9QM93qeAjlezRGZdanabUvmssMciQPkVzeW0eLMRDBV68qzozoGDr7CZbkkqQ
	sCdCyMj34V6tN/buWiLcf9eYKxrqoYmwTYAYCZuw/6h6i+6s9KcJtQZ4bZxWt2f/
	hufnFA2NFqkk9d4be4b6A303XPdkVj9umFco2cPTkK2+KrQ8GFFEQIjZghRtg1pw
	==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4ewh9gxus1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 26 Jun 2026 13:37:42 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 65QDYmuY011894;
	Fri, 26 Jun 2026 13:37:41 GMT
Received: from smtprelay02.wdc07v.mail.ibm.com ([172.16.1.69])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4ex56quhdb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 26 Jun 2026 13:37:41 +0000 (GMT)
Received: from smtpav04.dal12v.mail.ibm.com (smtpav04.dal12v.mail.ibm.com [10.241.53.103])
	by smtprelay02.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 65QDbeVs27591248
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 26 Jun 2026 13:37:41 GMT
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id CED9F58052;
	Fri, 26 Jun 2026 13:37:40 +0000 (GMT)
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 6E5015805A;
	Fri, 26 Jun 2026 13:37:40 +0000 (GMT)
Received: from li-43857255-d5e6-4659-90f1-fc5cee4750ad.ibm.com (unknown [9.61.141.164])
	by smtpav04.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 26 Jun 2026 13:37:40 +0000 (GMT)
Message-ID: <52db2dff89c01f19c0783934d5da319ecbc19aa7.camel@linux.ibm.com>
Subject: Re: [PATCH v4 1/2] ima: measure loaded policy after write on
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
In-Reply-To: <a5ee67057fe003e0fd98f679e640c627af1f6b83.camel@polito.it>
References: <20260617155832.434517-1-enrico.bravi@polito.it>
			 <20260617155832.434517-2-enrico.bravi@polito.it>
		 <1f23b6cb35538f471dbb68534308784616130cb9.camel@linux.ibm.com>
	 <a5ee67057fe003e0fd98f679e640c627af1f6b83.camel@polito.it>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Date: Fri, 26 Jun 2026 09:37:40 -0400
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Evolution 3.58.3 (3.58.3-1.fc43) 
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-GUID: Z4c-zFGlDu1DqKGVtlaeg9wEJLCuXahZ
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjI2MDEwOSBTYWx0ZWRfXz7Qk4vkLiMzi
 tDq5g3TprMQFe5EXKmb5PIPRF6t7ScKeg10YJ1uqz4l/XaS1Bd+KbUi/NY+MY8uxO9xAAInolAQ
 H4gc/bbl5oOUGl2ZRdUWSjJuKlUZ7RQ=
X-Authority-Analysis: v=2.4 cv=c62bhx9l c=1 sm=1 tr=0 ts=6a3e80a7 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=V8glGbnc2Ofi9Qvn3v5h:22 a=DwVa56wyvVQJ833yV8MA:9
 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjI2MDEwOSBTYWx0ZWRfXyS97tO5l/ksX
 2t8Rm9kN4WU5OaXKPZFs1NsYYahDQpO83JhXvaUI3J03+7kLBY9S0dDkUJjTqFv7Vllm7ul7W/F
 HuPn4lQk/QNZbsZ7mpsSE26XnQwGL7tJw5aGbAYb+YkReK2ahAAqyAlsakp8DNwqs0B3JOeuA+S
 ByYrc1bJFF+utJghSUecsf5oR0ODYm9dXPGaRfpb4Sw+/hcKtGHJLHvNCCuWmpqTxwJl41Bjw4T
 TMU+hWhJozK9VywJywe4kbLXwLaXZTc/jhbl+AWGlJytOm2n+KGFSSl9bTUwZ7ZvHJsANaNbdoV
 iYA24/fkzeoVy+sNiUPgiQy/BrksxuHjh7YVMrr6g1Qfkifwk/kfmoMQLnwDxMNE9MygJV41qF4
 4Eq0IDwB8ZvhICfK0FMG/Cm1Fe3nlyPeTqKE2y91+7atq3YYw4vCXPsB0EwX3/+/XOqiGtvD+66
 AjHQqf963OWlfGfJGJQ==
X-Proofpoint-ORIG-GUID: rkt8TQdMjMxmBl-qWVpTi_nY-E2MnMTW
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-26_03,2026-06-24_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 impostorscore=0 adultscore=0 clxscore=1015 suspectscore=0
 priorityscore=1501 phishscore=0 spamscore=0 bulkscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606260109
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[ibm.com,none];
	R_DKIM_ALLOW(-0.20)[ibm.com:s=pp1];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-9844-lists,linux-integrity=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:enrico.bravi@polito.it,m:roberto.sassu@huawei.com,m:linux-integrity@vger.kernel.org,m:dmitry.kasatkin@gmail.com,m:eric.snowberg@oracle.com,m:dmitrykasatkin@gmail.com,s:lists@lfdr.de];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	FORGED_SENDER(0.00)[zohar@linux.ibm.com,linux-integrity@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[polito.it,huawei.com,vger.kernel.org,gmail.com];
	TO_DN_SOME(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.ibm.com:mid,linux.ibm.com:from_mime,vger.kernel.org:from_smtp,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo];
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
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TAGGED_RCPT(0.00)[linux-integrity];
	RCVD_COUNT_SEVEN(0.00)[11]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 086316CD7FD

On Fri, 2026-06-26 at 09:32 +0000, Enrico  Bravi wrote:
> >=20
> > > diff --git a/security/integrity/ima/ima_policy.c
> > > b/security/integrity/ima/ima_policy.c
> > > index f7f940a76922..0a70d10da70a 100644
> > > --- a/security/integrity/ima/ima_policy.c
> > > +++ b/security/integrity/ima/ima_policy.c
> >=20
> > > @@ -2379,3 +2378,70 @@ bool ima_appraise_signature(enum kernel_read_f=
ile_id
> > > id)
> > > =C2=A0	return found;
> > > =C2=A0}
> > > =C2=A0#endif /* CONFIG_IMA_APPRAISE && CONFIG_INTEGRITY_TRUSTED_KEYRI=
NG */
> > > +
> > > +/**
> > > +* ima_measure_loaded_policy - measure the active IMA policy ruleset
> > > +*
> > > +* Must be called with ima_write_mutex held, as it performs two
> > > +* separate RCU read passes over ima_rules and relies on the mutex
> > > +* to prevent concurrent policy updates between them.
> > > +*/
> > > +void ima_measure_loaded_policy(void)
> > > +{
> > > +	const char *event_name =3D "ima_policy_loaded";
> > > +	const char *op =3D "measure_loaded_ima_policy";
> > > +	struct ima_rule_entry *rule_entry;
> > > +	struct list_head *ima_rules_tmp;
> > > +	struct seq_file file;
> > > +	int result =3D -ENOMEM;
> > > +	size_t file_len =3D 0;
> > > +	char rule[512];
> > > +
> > > +	/* calculate IMA policy rules memory size */
> > > +	file.buf =3D rule;
> > > +	file.read_pos =3D 0;
> > > +	file.size =3D 512;
> > > +	file.count =3D 0;
> > > +
> > > +	lockdep_assert_held(&ima_write_mutex);
> > > +
> > > +	rcu_read_lock();
> > > +	ima_rules_tmp =3D rcu_dereference(ima_rules);
> > > +	list_for_each_entry_rcu(rule_entry, ima_rules_tmp, list) {
> > > +		ima_policy_show(&file, rule_entry);
> > > +		if (seq_has_overflowed(&file)) {
> > > +			result =3D -E2BIG;
> > > +			integrity_audit_msg(AUDIT_INTEGRITY_PCR, NULL,
> > > event_name,
> > > +					=C2=A0=C2=A0=C2=A0 op, "rule_length", result, 1);
> > > +			return;
> >=20
> > On failure the new IMA policy will not be measured. Instead of hard cod=
ing the
> > buffer to 512, define a file static global variable to keep track of th=
e
> > maximum
> > policy rule size.=C2=A0 ima_parse_add_rule() already returns the policy=
 rule
> > length.
> > Before returning update the max policy rule size variable as necessary.
> >=20
> > Here in ima_measure_loaded_policy() allocate/free the buffer.
>=20
> Yes, this is much better. In this way the check on seq_has_overflowed() s=
hould
> not be necessary anymore.
> Thank you very much for your suggestions.

Right, it isn't necessary, but there's no harm in keeping it either.

>=20
> > Missing rcu_read_unlock() before returning.
> >=20

thanks,

Mimi

