Return-Path: <linux-integrity+bounces-9776-lists+linux-integrity=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-integrity@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id KvbrMPP0Jmr4ogIAu9opvQ
	(envelope-from <linux-integrity+bounces-9776-lists+linux-integrity=lfdr.de@vger.kernel.org>)
	for <lists+linux-integrity@lfdr.de>; Mon, 08 Jun 2026 18:59:31 +0200
X-Original-To: lists+linux-integrity@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 386FA659039
	for <lists+linux-integrity@lfdr.de>; Mon, 08 Jun 2026 18:59:31 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=ibm.com header.s=pp1 header.b=KHRE5MXI;
	spf=pass (mail.lfdr.de: domain of "linux-integrity+bounces-9776-lists+linux-integrity=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="linux-integrity+bounces-9776-lists+linux-integrity=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=ibm.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 19D203050F06
	for <lists+linux-integrity@lfdr.de>; Mon,  8 Jun 2026 16:52:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 762AB3D45E6;
	Mon,  8 Jun 2026 16:52:50 +0000 (UTC)
X-Original-To: linux-integrity@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E309E3D5222;
	Mon,  8 Jun 2026 16:52:48 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780937570; cv=none; b=euFLM1CUCzeeQj+6doCltNgaVOpU6afTiIb/SHMRhYNlC3sPjRsh6KlPn9iXu2h4uQK+3o/SryMNjnMitJHhitRty5V1GZYX+ehNX6tAGFLUdQKtqJRKFtFYz4tFCjU+VIR+VsbucKgS+jJidvU0EaMIuq5aZTSW4pKwlT4KvT8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780937570; c=relaxed/simple;
	bh=mPtBsy+JEQM/QSOjKTPZeXIZdIzx4qieLZmJh93pBMA=;
	h=Message-ID:Subject:From:To:Cc:In-Reply-To:References:Content-Type:
	 Date:MIME-Version; b=nwDnUBMBnIObMrqbiD9RqMSYy2tMnRTZuoJQc+ro0EjCRjAzYVDnkkUdwUAuI71pIzJDDxkEEnHMw2xdWclYBtNrlGjEvYI3oBfie34TSZHWr9pppJ9AZ5PTkUoa5Dp+Rd/Xmt1IKW+fSary4Bk5rgc2slU95fDuuL1ZITL0D9k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=KHRE5MXI; arc=none smtp.client-ip=148.163.158.5
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6587uwu82552576;
	Mon, 8 Jun 2026 16:52:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=zGaNqk
	goSv38Ogf/K1tCxTRfXEkhH9NMOPa088u/m+E=; b=KHRE5MXI1WCmWL317EHzX9
	YbVBvfd4NdDHq8ueAhDZuxju0o8KhhAAxdxJ8M1hKQw56FFgGFrr7uc5SYadsduo
	jShF+eprMYvjd1c4ysVB9A0hOXP2LVMHsR3tHvADdXSguyuPgj7YLyZGvge7tBY4
	3OL8w2+I31+pG/snjLjEY6u3WmRubsRPiLbmu2UlcftjYrMyQ+Dcu/GSzq6hdWxW
	GVBz2ZQWw3i5DOCdre8XqjoVTff0oi+ToMzFU0xgYwLb2qaExSjlf7UI/ThWAP51
	aINh8VUIpLfyNlif06XsEmq9b13ux2H65Y2gEwtECazW2zcFQbLxCDfGc/Bv7/bg
	==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4em8yhrg84-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 08 Jun 2026 16:52:27 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 658GnbWO018253;
	Mon, 8 Jun 2026 16:52:27 GMT
Received: from smtprelay02.wdc07v.mail.ibm.com ([172.16.1.69])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4en0jy60b5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 08 Jun 2026 16:52:26 +0000 (GMT)
Received: from smtpav03.dal12v.mail.ibm.com (smtpav03.dal12v.mail.ibm.com [10.241.53.102])
	by smtprelay02.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 658GqQk332178730
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 8 Jun 2026 16:52:26 GMT
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E837A58056;
	Mon,  8 Jun 2026 16:52:25 +0000 (GMT)
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 06A9D5803F;
	Mon,  8 Jun 2026 16:52:25 +0000 (GMT)
Received: from li-43857255-d5e6-4659-90f1-fc5cee4750ad.ibm.com (unknown [9.61.149.251])
	by smtpav03.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Mon,  8 Jun 2026 16:52:24 +0000 (GMT)
Message-ID: <9b499a2a3101cadcfdcd6fc32289f54df10fea80.camel@linux.ibm.com>
Subject: Re: [PATCH v6 1/4] security: lsm: allow LSMs to register for
 late_initcall_sync init
From: Mimi Zohar <zohar@linux.ibm.com>
To: Yeoreum Yun <yeoreum.yun@arm.com>, linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-integrity@vger.kernel.org
Cc: paul@paul-moore.com, roberto.sassu@huaweicloud.com, noodles@earth.li,
        jarkko@kernel.org, sudeep.holla@kernel.org, jmorris@namei.org,
        serge@hallyn.com, dmitry.kasatkin@gmail.com, eric.snowberg@oracle.com,
        jgg@ziepe.ca
In-Reply-To: <20260605144325.434436-2-yeoreum.yun@arm.com>
References: <20260605144325.434436-1-yeoreum.yun@arm.com>
	 <20260605144325.434436-2-yeoreum.yun@arm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Date: Mon, 08 Jun 2026 12:52:24 -0400
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Evolution 3.58.3 (3.58.3-1.fc43) 
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjA4MDE1OCBTYWx0ZWRfX6aZklMan4y3q
 XKC3waWy5BQnEBCTkG5KLepoLDzw0LqKn6D/sHn0BYb310LBNqpUpnAdaDMGOI0BfSGVHpl0v3w
 ALUswkYww36FkS3P4GeDclShUKLuYWh/q9LZWFQIVb1u35Kh4FCNQFqpUZedrvKiSYUfAo+lnu2
 9pOErlJKRcmz2vZkATTnV5g6pIuM55OmXPAXu8XYfHdEdJqXp9KNe65bjZKWhWZbgtG8SYRVO4l
 CipyDM1G1aYU5HwUJpQMHW2Vy/fN/V5+95e+QFtKbFPFb6X78ytJNLG/uhdf4+RtjqCm2f8OICv
 zd/3MehczhitIfZnuGLGO36jPRU+oTRFS10BKgJrYmTSEcZ08d82xvgBnPk36384+5EQIc7dL5b
 gjj0Atj/oKctybXMnRwKuLfrFE8WjJSpN3bpVk2TGRc4ZBaUzmWwN0aXlrg2+Qyr1UpwGat2Of/
 /XcA6htnoeLYVZ8n9Vw==
X-Authority-Analysis: v=2.4 cv=HvFG3UTS c=1 sm=1 tr=0 ts=6a26f34c cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=7CQSdrXTAAAA:8
 a=xVhDTqbCAAAA:8 a=XT_FTWJFjCYkr2puuRMA:9 a=QEXdDO2ut3YA:10
 a=a-qgeE7W1pNrGK8U0ZQC:22 a=GrmWmAYt4dzCMttCBZOh:22
X-Proofpoint-ORIG-GUID: MQwYZtoBAbIGrhJxgYHItEVsiBw_Lteg
X-Proofpoint-GUID: VcqwJ_2xMYRpZ31A2BoIgfS0AgQDXLTG
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-08_04,2026-06-05_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 clxscore=1015 lowpriorityscore=0 adultscore=0 suspectscore=0
 spamscore=0 priorityscore=1501 phishscore=0 malwarescore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2606080158
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[ibm.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[ibm.com:s=pp1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORWARDED(0.00)[lists@lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[14];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-9776-lists,linux-integrity=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:yeoreum.yun@arm.com,m:linux-security-module@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:linux-integrity@vger.kernel.org,m:paul@paul-moore.com,m:roberto.sassu@huaweicloud.com,m:noodles@earth.li,m:jarkko@kernel.org,m:sudeep.holla@kernel.org,m:jmorris@namei.org,m:serge@hallyn.com,m:dmitry.kasatkin@gmail.com,m:eric.snowberg@oracle.com,m:jgg@ziepe.ca,m:dmitrykasatkin@gmail.com,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[zohar@linux.ibm.com,linux-integrity@vger.kernel.org];
	FREEMAIL_CC(0.00)[paul-moore.com,huaweicloud.com,earth.li,kernel.org,namei.org,hallyn.com,gmail.com,oracle.com,ziepe.ca];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,linux.ibm.com:mid,linux.ibm.com:from_mime,arm.com:email,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,paul-moore.com:email];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
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
X-Rspamd-Queue-Id: 386FA659039

On Fri, 2026-06-05 at 15:43 +0100, Yeoreum Yun wrote:
> There are situations where LSMs have dependencies that might mean they
> want to be initialised later in the boot process, to ensure those
> dependencies are available. In particular there are some TPM setups (Arm
> FF-A devices, SPI attached TPMs) required by IMA which are not
> guaranteed to be initialised for regular initcall_late.
>=20
> Add an initcall_late_sync option that can be used in these situations.
>=20
> Signed-off-by: Yeoreum Yun <yeoreum.yun@arm.com>

Cc: Paul Moore <paul@paul-moore.com>

Jarkko has already queued 4/4.  Paul, can we get an Ack from you?


Mimi

