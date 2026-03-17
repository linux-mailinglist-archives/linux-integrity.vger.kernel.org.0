Return-Path: <linux-integrity+bounces-9012-lists+linux-integrity=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-integrity@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qDCxEWmouWkhLwIAu9opvQ
	(envelope-from <linux-integrity+bounces-9012-lists+linux-integrity=lfdr.de@vger.kernel.org>)
	for <lists+linux-integrity@lfdr.de>; Tue, 17 Mar 2026 20:15:53 +0100
X-Original-To: lists+linux-integrity@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D55222B16BA
	for <lists+linux-integrity@lfdr.de>; Tue, 17 Mar 2026 20:15:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 35439303BF4A
	for <lists+linux-integrity@lfdr.de>; Tue, 17 Mar 2026 19:15:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6947919AD8B;
	Tue, 17 Mar 2026 19:15:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="b0UKRU8E"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1116C1DFF0;
	Tue, 17 Mar 2026 19:15:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773774950; cv=none; b=ZT0r9Sfqkj7dXuxQXOS7FcQnrKTELvzid/QhI7X6ppUhkpiqtyHFcwWTx/llywOjHPamll3iKXTs1DNClcN++Huq3WpH1895t9rAkOpazoaLRZ9hGfbX7Hf305jb8wH5WeOrC9tHHULRF+cxIshOVLILw7E2z60WxZD3iH2WaIE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773774950; c=relaxed/simple;
	bh=t9oHWXID0X3IHZuxMJ21N4KTmPJckQAHF9PGj65HaI4=;
	h=Message-ID:Subject:From:To:Cc:In-Reply-To:References:Content-Type:
	 Date:MIME-Version; b=PwvZaBpT8klmZ0e+BBPNnnCKxZGvNkyx5nxzLGr8NvBgWJpzbdW3seK2g2PVpgsV3RtuvwbnHNuSiN8lO8KSH8T32fEegl9oN6N9EB6Yx05AamKsWUC7mQI1fGVcRzcaVxxPLrMAs/C0HfHmNRGUzUg8I9+go7awxTNKwRUo0Hg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=b0UKRU8E; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62H9wbg81189478;
	Tue, 17 Mar 2026 19:15:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=LwbSbs
	xqaV6DD51oggoOiP/qa89tlN4mvUgF4J6nzno=; b=b0UKRU8EZwYdLN1mXAzHwQ
	lZHIyrhZ4c/VuTetYqSBPvNmABgGqq2adnyI4G08y7BM9AqP9Krq0ELfxJWFNp8P
	p6D2mIJQshF5U7Rzgl9COoNeNXpD+w+VsVC8MssX9+0PT4EnUnbZraumzpO/Flmi
	zMA46T7ZpZhR4czYIWXqoYXXWy7XEznqpELrAbOd9qUfnZaOx4rcAgTzhr8iPe+E
	D5kJptDxe1T7trBee9h2J8lRmf6LWdp5NB7v2UJvbQEKlh/79f+8zJWbtx3DlaJ4
	8npgCSo2F4tiLLxcLKb8MwY+ZXBW5SrSVjpRRiMM72t5X2wjfRP4sIl1VTwwtF1w
	==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4cx7vfgrjv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 17 Mar 2026 19:15:12 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 62HIkPxR028708;
	Tue, 17 Mar 2026 19:15:11 GMT
Received: from smtprelay06.wdc07v.mail.ibm.com ([172.16.1.73])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4cwkgkamua-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 17 Mar 2026 19:15:11 +0000
Received: from smtpav01.dal12v.mail.ibm.com (smtpav01.dal12v.mail.ibm.com [10.241.53.100])
	by smtprelay06.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 62HJFAYx18154188
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 17 Mar 2026 19:15:10 GMT
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 59C9758058;
	Tue, 17 Mar 2026 19:15:10 +0000 (GMT)
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 4CC3F58057;
	Tue, 17 Mar 2026 19:15:09 +0000 (GMT)
Received: from li-43857255-d5e6-4659-90f1-fc5cee4750ad.ibm.com (unknown [9.61.96.49])
	by smtpav01.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 17 Mar 2026 19:15:09 +0000 (GMT)
Message-ID: <c61aeaa79929a98cb3a6d30835972891fac3570f.camel@linux.ibm.com>
Subject: Re: [PATCH v3 1/3] ima: Remove ima_h_table structure
From: Mimi Zohar <zohar@linux.ibm.com>
To: Roberto Sassu <roberto.sassu@huaweicloud.com>, corbet@lwn.net,
        skhan@linuxfoundation.org, dmitry.kasatkin@gmail.com,
        eric.snowberg@oracle.com, paul@paul-moore.com, jmorris@namei.org,
        serge@hallyn.com
Cc: linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-integrity@vger.kernel.org, linux-security-module@vger.kernel.org,
        gregorylumen@linux.microsoft.com, chenste@linux.microsoft.com,
        nramas@linux.microsoft.com, Roberto Sassu <roberto.sassu@huawei.com>
In-Reply-To: <20260311171956.2317781-1-roberto.sassu@huaweicloud.com>
References: <20260311171956.2317781-1-roberto.sassu@huaweicloud.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Date: Tue, 17 Mar 2026 15:15:08 -0400
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Evolution 3.56.2 (3.56.2-2.fc42) 
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-ORIG-GUID: hEc5q3wd8MTvePR4-Qc55BKf-FHdD7Ji
X-Authority-Analysis: v=2.4 cv=KajfcAYD c=1 sm=1 tr=0 ts=69b9a840 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=U7nrCbtTmkRpXpFmAIza:22 a=i0EeH86SAAAA:8
 a=Pu4qpp7xOsI_tI_u5rgA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzE3MDE2OSBTYWx0ZWRfX4k2K5tgkU1o8
 jSQtcMJK6TS1yfvX0FMHmL2UFfFG9r1xa1kl0Nbc8J4QfqOUba0af1pTeb1TLjdm25lDpMBoOFb
 EU0I0V7ORdPX+BWSFHQdA+I3MDxDBEldDPnH2dOznGiSgc+ctcxKsyDENBgjAKvmPmJxSILMYf/
 AFzXuAPX0Gzk3hR/ECwQ8jbwldxGUx25atWVGZAX+z/COQxtCCDzOwOgkgd+jsdKchQRBcmw6GP
 inEEhuWmOCgXcKLpCtFxgvHXoy7Mxec4Roj9mz6Qg85gZKUFYHRm4X0i0UiNFC29K5GyqJ5+++q
 yIcCR877HJikqARa+EbztCc42YB4aQZlLFq+7sVetJ6Otcn7ZvF9QxYCdYTfO8oIAGm6mjpD6il
 HMK0U/8VpCf/Y0oRqQomGy8pfZNxmeZ8EQYztoKiZ2XzK8V2A7xMGlqT+0AjO40ZAZcZlsKvpU0
 KIAV1i+IQtPJMij3vWg==
X-Proofpoint-GUID: UUqMRk-lq9FK62kRCYkW6ZTtaKOkuVu7
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-17_04,2026-03-17_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 adultscore=0 spamscore=0 malwarescore=0 clxscore=1011
 impostorscore=0 bulkscore=0 lowpriorityscore=0 priorityscore=1501
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2603050001
 definitions=main-2603170169
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[ibm.com,none];
	R_DKIM_ALLOW(-0.20)[ibm.com:s=pp1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-9012-lists,linux-integrity=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[huaweicloud.com,lwn.net,linuxfoundation.org,gmail.com,oracle.com,paul-moore.com,namei.org,hallyn.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[16];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,linux.ibm.com:mid];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[zohar@linux.ibm.com,linux-integrity@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[ibm.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-integrity];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[11]
X-Rspamd-Queue-Id: D55222B16BA
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Wed, 2026-03-11 at 18:19 +0100, Roberto Sassu wrote:
> From: Roberto Sassu <roberto.sassu@huawei.com>
>=20
> With the upcoming change of dynamically allocating and replacing the hash
> table, we would need to keep the counters for number of measurements
> entries and violations.
>=20
> Since anyway, those counters don't belong there, remove the ima_h_table
> structure instead and move the counters and the hash table as a separate
> variables.

There's no cover letter or motivation in this patch description for needing=
 to
"dynamically allocating or replacing the existing hash table."

Saying that the htable, number of records in the measurement list, and viol=
ation
counter don't belong grouped together is insufficient.  There must have bee=
n a
valid reason for why they were grouped together originally (e.g. never remo=
ved
or reset).

Please provide a motivation for removing the ima_h_table struct and its usa=
ge
and defining them independently of each other.

thanks,

Mimi

