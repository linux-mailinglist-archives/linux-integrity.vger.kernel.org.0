Return-Path: <linux-integrity+bounces-9851-lists+linux-integrity=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-integrity@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 5909E0KhQmrB+wkAu9opvQ
	(envelope-from <linux-integrity+bounces-9851-lists+linux-integrity=lfdr.de@vger.kernel.org>)
	for <lists+linux-integrity@lfdr.de>; Mon, 29 Jun 2026 18:45:54 +0200
X-Original-To: lists+linux-integrity@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F6EB6DD775
	for <lists+linux-integrity@lfdr.de>; Mon, 29 Jun 2026 18:45:53 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=ibm.com header.s=pp1 header.b=bdZpYd8S;
	spf=pass (mail.lfdr.de: domain of "linux-integrity+bounces-9851-lists+linux-integrity=lfdr.de@vger.kernel.org" designates 104.64.211.4 as permitted sender) smtp.mailfrom="linux-integrity+bounces-9851-lists+linux-integrity=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=ibm.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 922943003719
	for <lists+linux-integrity@lfdr.de>; Mon, 29 Jun 2026 16:44:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56A8837E307;
	Mon, 29 Jun 2026 16:44:17 +0000 (UTC)
X-Original-To: linux-integrity@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E0F33E835B
	for <linux-integrity@vger.kernel.org>; Mon, 29 Jun 2026 16:44:15 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782751457; cv=none; b=Zw0epwuvEUgh+4+R+H+ggUl5UW1zFwd+v4zA+WylEBgLeSgBqH0FEF3PvHc33BCX4qV9MP5Kdu3fb9WzRZ/jM4zcjcxSyrjUTDkJK/dJORuDdf0rjSfVH7xgcXKdBvAe8pBfzaeF6GwEiyeUkU327nOxLXr4ZfSe7zfFvwXSBZM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782751457; c=relaxed/simple;
	bh=ADdPs1UWnaDggSoQZTcA2vpIA7qvYmugkjxvgXflDPk=;
	h=Message-ID:Subject:From:To:Cc:In-Reply-To:References:Content-Type:
	 Date:MIME-Version; b=KrI70RqXSDb3ZV/c5oh4ikXWBvWGavrKtXIGotQD4UW+FUdTkmSCpRk2RjCFN89k9EE1AjGgD+OIXIF0myKoy/71PWX8bCu6WQgJZ54yNitqiJBeYnhOFoAxikmxm8GcZBdp4V77ctZw2HESrakYAqpTnshg9xJUFHCWht5Vf1M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=bdZpYd8S; arc=none smtp.client-ip=148.163.156.1
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65TGK2OA3904436;
	Mon, 29 Jun 2026 16:38:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=YrVFm5
	XGMAEz7Hh/ApQjKbYio1B8IBwRYfmV1BCYLZY=; b=bdZpYd8StC76Hu/oAcPTTq
	e222C1g1mPoXFLDmo9ZhRENfSRoRur1yXHogKjWqCF59pbxx1HJy7egpSmDDKJtw
	ShK102pQ4KRKm+SdbF8imRJiT1ZjiQrYWbDZfT5YVWhhJZGWH20K6zWbatdIpZGQ
	4o3L8LM0IdFCVq5XkreKtFSPOBaM04Z+hQWyeyhhgPt7CCEV+I9DFFICQUwErkuL
	LRrRea0JW1L3nkmPMAnqfBsn9Vt8xQ6zk/uNDP3zyu7Mlsmz4jJ5B3RJ0wSy3kgK
	wYCjlWLq+/uBK+PFX9QI/T7WQX4nLuYTDNqAGt/s5tZpLTxldyJe5Lz6yRNZYlDg
	==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4f26qftg4k-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 29 Jun 2026 16:38:58 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 65TGYfro021274;
	Mon, 29 Jun 2026 16:38:58 GMT
Received: from smtprelay06.wdc07v.mail.ibm.com ([172.16.1.73])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4f2ruq6kk9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 29 Jun 2026 16:38:57 +0000 (GMT)
Received: from smtpav06.wdc07v.mail.ibm.com (smtpav06.wdc07v.mail.ibm.com [10.39.53.233])
	by smtprelay06.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 65TGcvnQ62587328
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 29 Jun 2026 16:38:57 GMT
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 334A958054;
	Mon, 29 Jun 2026 16:38:57 +0000 (GMT)
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 7C5595803F;
	Mon, 29 Jun 2026 16:38:56 +0000 (GMT)
Received: from li-43857255-d5e6-4659-90f1-fc5cee4750ad.ibm.com (unknown [9.61.122.185])
	by smtpav06.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 29 Jun 2026 16:38:56 +0000 (GMT)
Message-ID: <86ffed9e24d15bb726b836e92d18dc7bbb7593e4.camel@linux.ibm.com>
Subject: Re: [PATCH v4 2/2] ima: measure buffer sent to securityfs policy
 file
From: Mimi Zohar <zohar@linux.ibm.com>
To: Enrico Bravi <enrico.bravi@polito.it>,
        "roberto.sassu@huawei.com"
	 <roberto.sassu@huawei.com>,
        "linux-integrity@vger.kernel.org"
	 <linux-integrity@vger.kernel.org>,
        "dmitry.kasatkin@gmail.com"
	 <dmitry.kasatkin@gmail.com>
Cc: "eric.snowberg@oracle.com" <eric.snowberg@oracle.com>
In-Reply-To: <28759e3a57545d6d401ed111f38bd7e8b2ecf59d.camel@polito.it>
References: <20260617155832.434517-1-enrico.bravi@polito.it>
			 <20260617155832.434517-3-enrico.bravi@polito.it>
		 <997ae675fb1f987876226b3c6072c3f82a0d95cb.camel@linux.ibm.com>
	 <28759e3a57545d6d401ed111f38bd7e8b2ecf59d.camel@polito.it>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Date: Mon, 29 Jun 2026 12:38:56 -0400
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Evolution 3.58.3 (3.58.3-1.fc43) 
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Authority-Analysis: v=2.4 cv=RYqgzVtv c=1 sm=1 tr=0 ts=6a429fa3 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=uAbxVGIbfxUO_5tXvNgY:22 a=qhtuoew3j42Z4yni5SQA:9
 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjI5MDEzNiBTYWx0ZWRfX/AaBl4KK/cYj
 B/wTC9s3R9z0OS8t42Cyz3iqP/MEYOLK/NNzea6vEvi8QK5Y7AjuWiJunBhu4Ht29pd9bOMa1dd
 bMsNWSIdjaXb/amkQOzE8eWsrxDKemc=
X-Proofpoint-GUID: FHs_cnB8nLoHKyAGifysFuX70Y1mAkD0
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjI5MDEzNiBTYWx0ZWRfX3lMwe8W/T7oX
 OflP9IvmRvOuzc/TfJkra2DtaOcUiBKNp5IJ582q/I5eHPSolUAF/JRM0j9xEur/1jrUS2kxOqs
 4H1GvPVY4/GR0deoBQHgf7Thpc8whuqNb9qVsNgnHXjeOD+SgZ5VclNP8pz7lrVFWSfAXksVAvR
 Da0G/7r39SBfd6BNrnxK/Rv7Bluy9FXEDrMiDiqiCcDZe+w2eXY4Opl6awmeKnU9jwj8BJfehz0
 8e7Xy8wwkdlYc8Uz82v8Z+ry0CU2n4mmNkla4TYRP1fYJNsB3J8Lrq4mHhQWFVpN1L2Lnk8Q7WW
 xjDTg9GSUFaBmPB/zt6/BTHvRARCqXj4GknZR/NU6+WCPMrm/u7aALd6S5Hbh0p81P4ftZbEG0M
 654Jj0cABJWzXO5M2QMhXYRn+udLqxcSopx7co5kct5poMiN/SDs3naAk42QAQnxz+uYDJRyHar
 GEPgQ+X6joT9/f6ZvGA==
X-Proofpoint-ORIG-GUID: j8HxunPSStGxEYprvxM-xxcHxTTFvGa4
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-29_04,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 impostorscore=0 malwarescore=0 spamscore=0 lowpriorityscore=0
 adultscore=0 priorityscore=1501 suspectscore=0 bulkscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606290136
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[ibm.com,none];
	R_DKIM_ALLOW(-0.20)[ibm.com:s=pp1];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-9851-lists,linux-integrity=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:enrico.bravi@polito.it,m:roberto.sassu@huawei.com,m:linux-integrity@vger.kernel.org,m:dmitry.kasatkin@gmail.com,m:eric.snowberg@oracle.com,m:dmitrykasatkin@gmail.com,s:lists@lfdr.de];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	FORGED_SENDER(0.00)[zohar@linux.ibm.com,linux-integrity@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[polito.it,huawei.com,vger.kernel.org,gmail.com];
	TO_DN_SOME(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,linux.ibm.com:mid,linux.ibm.com:from_mime];
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
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	TAGGED_RCPT(0.00)[linux-integrity];
	RCVD_COUNT_SEVEN(0.00)[11]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 3F6EB6DD775

On Mon, 2026-06-29 at 09:26 +0000, Enrico  Bravi wrote:
> > > diff --git a/security/integrity/ima/ima_fs.c
> > > b/security/integrity/ima/ima_fs.c
> > > index 65e7812c702f..a277c9135944 100644
> > > --- a/security/integrity/ima/ima_fs.c
> > > +++ b/security/integrity/ima/ima_fs.c
> > > @@ -356,6 +356,7 @@ static ssize_t ima_write_policy(struct file *file=
, const
> > > char __user *buf,
> > > =C2=A0				=C2=A0=C2=A0=C2=A0 1, 0);
> > > =C2=A0		result =3D -EACCES;
> > > =C2=A0	} else {
> > > +		ima_measure_policy_buf(data, datalen);
> >=20
> > Should failure to measure the input policy rules be audited?
>=20
> process_buffer_measurement() is already auditing in case of failure befor=
e
> returning. Do you think it is necessary to audit also at this point?

No, you're correct.

>=20
> > > =C2=A0		result =3D ima_parse_add_rule(data);
> > > =C2=A0	}
> > > =C2=A0	mutex_unlock(&ima_write_mutex);
> > > diff --git a/security/integrity/ima/ima_main.c
> > > b/security/integrity/ima/ima_main.c
> > > index 5cea53fc36df..599495304712 100644
> > > --- a/security/integrity/ima/ima_main.c
> > > +++ b/security/integrity/ima/ima_main.c
> > > @@ -1221,6 +1221,25 @@ int ima_measure_critical_data(const char
> > > *event_label,
> > > =C2=A0}
> > > =C2=A0EXPORT_SYMBOL_GPL(ima_measure_critical_data);
> > > =C2=A0
> > > +/**
> > > + * ima_measure_policy_buf - Measure the policy write buffer
> >=20
> > Consider renaming this function to ima_measure_policy_input(), which pa=
rallels
> > the function ima_measure_loaded_policy() in the first patch.
>=20
> My intention with the previous ima_measure_policy_write() name was to hig=
hlight
> the fact it is not measuring every data sent to the policy file. For exam=
ple,
> writing the path of the file from which reading the new policy does not t=
rigger
> this measurement. Eventually, what do you think of ima_measure_raw_policy=
() or
> ima_measure_unparsed_policy()?

The policy could have comment lines, which are being measured.  Naming the
function ima_measure_raw_policy() is perfect.

>=20
thanks,

Mimi

