Return-Path: <linux-integrity+bounces-9831-lists+linux-integrity=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-integrity@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id NaYKDPF+PGr9oggAu9opvQ
	(envelope-from <linux-integrity+bounces-9831-lists+linux-integrity=lfdr.de@vger.kernel.org>)
	for <lists+linux-integrity@lfdr.de>; Thu, 25 Jun 2026 03:05:53 +0200
X-Original-To: lists+linux-integrity@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D1836C2112
	for <lists+linux-integrity@lfdr.de>; Thu, 25 Jun 2026 03:05:52 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=ibm.com header.s=pp1 header.b=kZCaNNM5;
	spf=pass (mail.lfdr.de: domain of "linux-integrity+bounces-9831-lists+linux-integrity=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="linux-integrity+bounces-9831-lists+linux-integrity=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=ibm.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 2B8693012CB5
	for <lists+linux-integrity@lfdr.de>; Thu, 25 Jun 2026 01:05:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D559DF59;
	Thu, 25 Jun 2026 01:05:49 +0000 (UTC)
X-Original-To: linux-integrity@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFFCB367F26
	for <linux-integrity@vger.kernel.org>; Thu, 25 Jun 2026 01:05:47 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782349549; cv=none; b=kNHNaqe6+d+9wEEDUHeGXBAN58z6NK0z3mMknmSikIyk9qLOQt1bI0ZGnTIatsUfIeA1cEd/hCn0OxCV26mkLO5mVjbB8IvxoWocmJ+LgLzUH74kQvOKElSxrcDwCRLoSWB5BQ8KyIMappszb+wX8G9KY6yqZmr9AzENQuyydi8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782349549; c=relaxed/simple;
	bh=x0p1WUTVAJL78QgJilXxvYrHAmEkGbvwGLh8PkYkTZE=;
	h=Message-ID:Subject:From:To:Cc:In-Reply-To:References:Content-Type:
	 Date:MIME-Version; b=HRAD+1RWmmBnyPWQPUfd9MP8qNSY/4kSZbjFeDPaQ71oLSxHD3F1k+WvddJqEloRX7hu1QJaw7vPxvXXG6qdFIUkLtm3bl/E3itGFDe8FH8FDVoh+SyqnpXhySzKDVxawINMHmjxhivXh2NCi/RYAMia8okLEk5rLWHEapWjyU0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=kZCaNNM5; arc=none smtp.client-ip=148.163.158.5
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65OJnMSQ1949258;
	Thu, 25 Jun 2026 01:05:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=0GAR1n
	eQ84sXtY2mgW82HcWR8Y1OryN+PCfqj2hVaeU=; b=kZCaNNM5xajcRuMCQB7yCa
	bCxIor7mQ+JsFyBHMQ8387ACNkeUj2JSGqJcqymsdMKlXr1ppGL7XvbGgDHJxN8n
	GEl8fWIk/4PZTZwqAv3E4C6gRe4rOowgVaNQwtvqbnx50jv8/F8kFr95pmm/GXVD
	tJ35AApZJp/5DuDaP5fFN/CAJw1vCZcnJL4DNfgbDTWB52y7jkCO42FkZEbV6bKG
	Tla23an/TskPlLgoj8d7cA1wzdDJgMjtNi3Dll4bwyysgZ3pnoeC0gfdw2GRTRy+
	UTg0p6pIdy7QzjkMTf6NDRC8ZYJRcdMf3arKUY68KpgjwJ3QNLH5ftyinPq7Uz1g
	==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4ewg9hydww-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 25 Jun 2026 01:05:36 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 65P14mkN014599;
	Thu, 25 Jun 2026 01:05:35 GMT
Received: from smtprelay06.wdc07v.mail.ibm.com ([172.16.1.73])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4ex6phkqhu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 25 Jun 2026 01:05:35 +0000 (GMT)
Received: from smtpav06.dal12v.mail.ibm.com (smtpav06.dal12v.mail.ibm.com [10.241.53.105])
	by smtprelay06.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 65P15ZiL21103140
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 25 Jun 2026 01:05:35 GMT
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id F267F58043;
	Thu, 25 Jun 2026 01:05:34 +0000 (GMT)
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 83C5A5805F;
	Thu, 25 Jun 2026 01:05:34 +0000 (GMT)
Received: from li-43857255-d5e6-4659-90f1-fc5cee4750ad.ibm.com (unknown [9.61.76.213])
	by smtpav06.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 25 Jun 2026 01:05:34 +0000 (GMT)
Message-ID: <997ae675fb1f987876226b3c6072c3f82a0d95cb.camel@linux.ibm.com>
Subject: Re: [PATCH v4 2/2] ima: measure buffer sent to securityfs policy
 file
From: Mimi Zohar <zohar@linux.ibm.com>
To: Enrico Bravi <enrico.bravi@polito.it>, linux-integrity@vger.kernel.org,
        dmitry.kasatkin@gmail.com, roberto.sassu@huawei.com
Cc: eric.snowberg@oracle.com
In-Reply-To: <20260617155832.434517-3-enrico.bravi@polito.it>
References: <20260617155832.434517-1-enrico.bravi@polito.it>
	 <20260617155832.434517-3-enrico.bravi@polito.it>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Date: Wed, 24 Jun 2026 21:05:34 -0400
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Evolution 3.58.3 (3.58.3-1.fc43) 
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-ORIG-GUID: QCpNKUJzZPn9f-xf2FW2smj6-Ww_T8Q_
X-Proofpoint-GUID: qgLll-gLQTbb6UdG14B6ZMBeeGKvYFiK
X-Authority-Analysis: v=2.4 cv=Y4XIdBeN c=1 sm=1 tr=0 ts=6a3c7ee0 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=i0EeH86SAAAA:8
 a=7uy6fJ_G-s78BpoCXhsA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjI1MDAwNCBTYWx0ZWRfX1aopuGxhIq/n
 napmZgpbzWhbK4VyI6YCAVwu/TCAseQPpAlBFZx0EfBMszC3fY2as/Hyd7WU9xRkZ7XN7470Cdz
 m9wqGinMfaiV86oEd5wT9U+gndefM9jgoJc7gJxm5QeZOKaLJt/J2/olKC8KbVEaGa9d82vhBRd
 +R4n+kLNf0tW3jKj90xt9mhjaKxfCIXJ5InAZuNKZwOVwVstMd0ZAoaIl3FkiuzMp8LV0m9Pe0M
 F9eRgGfyyFqGNWOVLUIUD8G+GcGsPCQPiTUtRr8fQ6LdU/CxTFPR+kG4JpmcdV/QWjktAyVqo1c
 tMgS8QTqv/+/Xwwng4c5rzPtraW/GW876AzsN4bLqTzoK+Ls//4MqWUXteu+h+34jlzmY2md04A
 goqa3/k2IBcRLgGpNzjjikIVevzLqXWrjvD1u+8X4nCEFkjZYb6oqM9s2rUu0fd3JPgEMkBqWIQ
 scThO/X32df3s5zfpJg==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjI1MDAwNCBTYWx0ZWRfXywh0LSplqPHQ
 7WIZFi7pqwFA3EI0SiCKOpqTkdeqdtrZdqCdow79R/3517YeQWvoqkDOWHZX7yExfeqbnqOK1jp
 b7N24vytA9etcJKgIebzdjX9oqummyo=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-24_04,2026-06-24_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 priorityscore=1501 malwarescore=0 lowpriorityscore=0 spamscore=0
 clxscore=1015 suspectscore=0 impostorscore=0 phishscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606250004
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[ibm.com,none];
	R_DKIM_ALLOW(-0.20)[ibm.com:s=pp1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-9831-lists,linux-integrity=lfdr.de];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FREEMAIL_TO(0.00)[polito.it,vger.kernel.org,gmail.com,huawei.com];
	FORGED_RECIPIENTS(0.00)[m:enrico.bravi@polito.it,m:linux-integrity@vger.kernel.org,m:dmitry.kasatkin@gmail.com,m:roberto.sassu@huawei.com,m:eric.snowberg@oracle.com,m:dmitrykasatkin@gmail.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[zohar@linux.ibm.com,linux-integrity@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,huawei.com:email];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-integrity];
	RCVD_COUNT_SEVEN(0.00)[11]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 8D1836C2112

The Subject line describes "how", not "what". Consider renaming it to "ima:
measure userspace policy writes before parsing".

On Wed, 2026-06-17 at 17:58 +0200, Enrico Bravi wrote:
> When a signed policy is not mandatory, it is possible to write the IMA
> policy directly on the corresponding securityfs file:

When a signed policy is not mandatory, userspace can write IMA policy rules
directly to the securityfs policy file:
>=20
> echo -e "measure func=3DBPRM_CHECK mask=3DMAY_EXEC\n" \
>         "audit func=3DBPRM_CHECK mask=3DMAY_EXEC\n" \
>      > /sys/kernel/security/ima/policy
>=20
> or by cat'ing the entire IMA custom policy file:
>=20
> cat ima-policy-file > /sys/kernel/security/ima/policy

Because these rules originate from userspace and cross the userspace/kernel
trust boundary, measure the raw write buffer before parsing.

>=20
> Add input buffer measurement, regardless of whether the new policy
> will be accepted or not, that can be caught when
> 'measure func=3DPOLICY_CHECK' is enabled (e.g., ima_policy=3Dtcb). The
> measurement template is forced to ima-buf.

> This follows the "measure & load" paradigm, exposing potential bugs in
> the policy code and detecting attempts to corrupt IMA. It also completes
> the POLICY_CHECK hook, which already measures partial policy load by file=
.

>=20
> To verify the template data hash value, convert the buffer policy data
> to binary:
> grep "ima_policy_written" \
> 	/sys/kernel/security/integrity/ima/ascii_runtime_measurements | \
> 	tail -1 | cut -d' ' -f 6 | xxd -r -p | sha256sum
>=20
> Suggested-by: Roberto Sassu <roberto.sassu@huawei.com>
> Signed-off-by: Enrico Bravi <enrico.bravi@polito.it>
> ---
>  security/integrity/ima/ima.h        |  1 +
>  security/integrity/ima/ima_fs.c     |  1 +
>  security/integrity/ima/ima_main.c   | 19 +++++++++++++++++++
>  security/integrity/ima/ima_policy.c |  3 +++
>  4 files changed, 24 insertions(+)
>=20
> diff --git a/security/integrity/ima/ima.h b/security/integrity/ima/ima.h
> index befa221716e5..d477fc06821f 100644
> --- a/security/integrity/ima/ima.h
> +++ b/security/integrity/ima/ima.h
> @@ -455,6 +455,7 @@ void *ima_policy_next(struct seq_file *m, void *v, lo=
ff_t *pos);
>  void ima_policy_stop(struct seq_file *m, void *v);
>  int ima_policy_show(struct seq_file *m, void *v);
>  void ima_measure_loaded_policy(void);
> +int ima_measure_policy_buf(const char *buf, size_t buf_len);
> =20
>  /* Appraise integrity measurements */
>  #define IMA_APPRAISE_ENFORCE	0x01
> diff --git a/security/integrity/ima/ima_fs.c b/security/integrity/ima/ima=
_fs.c
> index 65e7812c702f..a277c9135944 100644
> --- a/security/integrity/ima/ima_fs.c
> +++ b/security/integrity/ima/ima_fs.c
> @@ -356,6 +356,7 @@ static ssize_t ima_write_policy(struct file *file, co=
nst char __user *buf,
>  				    1, 0);
>  		result =3D -EACCES;
>  	} else {
> +		ima_measure_policy_buf(data, datalen);

Should failure to measure the input policy rules be audited?

>  		result =3D ima_parse_add_rule(data);
>  	}
>  	mutex_unlock(&ima_write_mutex);
> diff --git a/security/integrity/ima/ima_main.c b/security/integrity/ima/i=
ma_main.c
> index 5cea53fc36df..599495304712 100644
> --- a/security/integrity/ima/ima_main.c
> +++ b/security/integrity/ima/ima_main.c
> @@ -1221,6 +1221,25 @@ int ima_measure_critical_data(const char *event_la=
bel,
>  }
>  EXPORT_SYMBOL_GPL(ima_measure_critical_data);
> =20
> +/**
> + * ima_measure_policy_buf - Measure the policy write buffer

Consider renaming this function to ima_measure_policy_input(), which parall=
els
the function ima_measure_loaded_policy() in the first patch.

Mimi

> + * @buf: pointer to the buffer containing the policy write data
> + * @buf_len: size of the buffer
> + *
> + * Measure the buffer sent to the IMA policy securityfs file.
> + *
> + * Return 0 on success, a negative value otherwise.
> + */
> +int ima_measure_policy_buf(const char *buf, size_t buf_len)
> +{
> +	if (!buf || !buf_len)
> +		return -EINVAL;
> +
> +	return process_buffer_measurement(&nop_mnt_idmap, NULL, buf, buf_len,
> +					  "ima_policy_written", POLICY_CHECK, 0,
> +					  NULL, false, NULL, 0);
> +}
> +
>  #ifdef CONFIG_INTEGRITY_ASYMMETRIC_KEYS
> =20
>  /**

