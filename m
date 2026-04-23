Return-Path: <linux-integrity+bounces-9309-lists+linux-integrity=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-integrity@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4Fu0AHdU6mkhxgIAu9opvQ
	(envelope-from <linux-integrity+bounces-9309-lists+linux-integrity=lfdr.de@vger.kernel.org>)
	for <lists+linux-integrity@lfdr.de>; Thu, 23 Apr 2026 19:18:47 +0200
X-Original-To: lists+linux-integrity@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E0684556CF
	for <lists+linux-integrity@lfdr.de>; Thu, 23 Apr 2026 19:18:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C9716300D6B1
	for <lists+linux-integrity@lfdr.de>; Thu, 23 Apr 2026 17:13:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6ACD825A354;
	Thu, 23 Apr 2026 17:13:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="R/FILJHY"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EDCE393DDB;
	Thu, 23 Apr 2026 17:13:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776964422; cv=none; b=iJY7Irpm94BR5Rha7qwVIN2+5TpucT0hJDAud9AKSLK/WKWC8hZldTS+bAFtWT+9ZKj8lSnlbEXG3phgsKVBQC8XEGNH+sdlDd5HLM02/NT4c/95j8FwCzUOPS5Vlf30axdo027CDcqsY9bFzm3WzeRimlNztR2bqWdQ4Q0METQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776964422; c=relaxed/simple;
	bh=4vLcAbmB1zBC5sgUc5/ceTrNVMT9tf9WFlg2G3Kym2o=;
	h=Message-ID:Subject:From:To:Cc:In-Reply-To:References:Content-Type:
	 Date:MIME-Version; b=f5KFgZOn1jXfWa50HKo56FbZ02NTvx1RbVgf+myAh5bFwYrRKQPldhPzmY0fDBhzwGVTA7n+AmLoz0lcvUV8FUgrIgb7scff4zloWcQ/1u+6/IJmMl4dOaktIbFwX4Ic9stRZam5lWg9z8chuV0QFfMSDl3I4s+y7gFisfnQnU4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=R/FILJHY; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63N7QFF53514960;
	Thu, 23 Apr 2026 17:13:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=rJaeCK
	EtayuzlEYXUriE4LWZP+/cgwW6bIQN+h+7zTo=; b=R/FILJHYT53kb4HH9oGbfq
	fEjVFMxcmPm1IBSRSL/5PXNc3MK9h/kQnYi4Io6SrrmroCag0/VBLC7EixNGKtu+
	9KYYSNWlnLS1vTMPcM4u2X6N6Yc19UssHFq3w6qvM4RCfpDf5zSA5aW9mu8+StBP
	M/YaLV/sg656/fnX96DAN8kXsJbb1ho1XDnX1Ybj0fUIO5B7sKsjUDBwgOgfLv6+
	y724ntDlhHCnDrrg8vzyJXcbIyHLaXHe3mQ4BxaKuc4phhD8P62jJWYNhx74s4V5
	VIPvarPMd1Ij4YPiwIlxZyhDV8il3lZJkV5KIWtOLn7R/1rOqMENP4ZkseSDfH6g
	==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4dpeu29vaf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 23 Apr 2026 17:13:15 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 63NH5NAW012928;
	Thu, 23 Apr 2026 17:13:14 GMT
Received: from smtprelay02.wdc07v.mail.ibm.com ([172.16.1.69])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4dpjky7gx0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 23 Apr 2026 17:13:14 +0000 (GMT)
Received: from smtpav02.wdc07v.mail.ibm.com (smtpav02.wdc07v.mail.ibm.com [10.39.53.229])
	by smtprelay02.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 63NHDDCP24838876
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 23 Apr 2026 17:13:13 GMT
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 59AD35805B;
	Thu, 23 Apr 2026 17:13:13 +0000 (GMT)
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 554FF58059;
	Thu, 23 Apr 2026 17:13:11 +0000 (GMT)
Received: from li-43857255-d5e6-4659-90f1-fc5cee4750ad.ibm.com (unknown [9.31.96.173])
	by smtpav02.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 23 Apr 2026 17:13:11 +0000 (GMT)
Message-ID: <fa1cba435e079c9012f1c5d7d2a1bf5420be666f.camel@linux.ibm.com>
Subject: Re: [RFC PATCH v2 1/4] security: ima: call ima_init() again at
 late_initcall_sync for defered TPM
From: Mimi Zohar <zohar@linux.ibm.com>
To: Jonathan McDowell <noodles@earth.li>
Cc: Yeoreum Yun <yeoreum.yun@arm.com>, linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-integrity@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev,
        paul@paul-moore.com, jmorris@namei.org, serge@hallyn.com,
        roberto.sassu@huawei.com, dmitry.kasatkin@gmail.com,
        eric.snowberg@oracle.com, jarkko@kernel.org, jgg@ziepe.ca,
        sudeep.holla@kernel.org, maz@kernel.org, oupton@kernel.org,
        joey.gouly@arm.com, suzuki.poulose@arm.com, yuzenghui@huawei.com,
        catalin.marinas@arm.com, will@kernel.org, noodles@meta.com,
        sebastianene@google.com
In-Reply-To: <aepQwcY523aukAvw@earth.li>
References: <82803bb3b471898a77084c449b73c7f7b4eb2149.camel@linux.ibm.com>
	 <aem0SSQuE1e3pGOS@e129823.arm.com>
	 <56a8aab50a3b5ce0a345fc2079fb2abc7d0f1b23.camel@linux.ibm.com>
	 <aeoAlVEwzRUPrlVe@e129823.arm.com> <aeoRxWPyOHGJd+Jh@e129823.arm.com>
	 <aeoWO2Cwo04YYu2l@earth.li>
	 <bd908e28298d968740d03c97bc7e441de188b7b4.camel@linux.ibm.com>
	 <aeokwrC86WI7uT+K@e129823.arm.com> <aeomlp3I0eVE5mce@earth.li>
	 <2866f7679fe6933de667ce74ae68bd4ea9198e2a.camel@linux.ibm.com>
	 <aepQwcY523aukAvw@earth.li>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Date: Thu, 23 Apr 2026 13:13:10 -0400
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Evolution 3.56.2 (3.56.2-2.fc42) 
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDIzMDE2NyBTYWx0ZWRfXyUgMZm1RnAYH
 Nsy8eNb2A1u2zmIjH7rBl5HRJ0yhf9nZT3AQYGDoxQz4hhcXoiyXD4uSgf9YQmbQ95XGVlSkQJ2
 KfGChdYbi+3o8xcS1HaS/XOY+ijFpvlvjJLWk2meZ+/mF3yda5oAgQDWKMkZDzh8UThbhWRjDy0
 wq/qxvNeGb0/kfj/jQzMZrSuiSynYaWQ3ml6kmUN6vbTo+sM+7OebrKnvEOTm3KfUqGHtmZPJvu
 Br7fYJMQKLE/rPzjbAwwKr+kCUR6+64lJjgTeJQESAxdrFUeuU05UMJZ/zku0YqQIGFyZxrToLp
 ry/uk5N34+P5jvt4fJAh1pslik7UBYEmeSBlwPLhEOAAziQ3cyeyIXXKT2mAcmw7nJKfYYDxfcJ
 pcUOZ8DNjUe/LtWKLsZaFOQQrDlYsNbcED3r/G3V0srXUeW8jCBZjU/TBodCW2qSlzAX5VYDE2w
 Tg6I12aO9Vuj25m6O5A==
X-Proofpoint-ORIG-GUID: pC9mLLj3OfCH9cVB1IahK0HdCebjXzl9
X-Proofpoint-GUID: _gF3ttoQHZEMVej8gUL2B61bY_rxrf4E
X-Authority-Analysis: v=2.4 cv=XMUAjwhE c=1 sm=1 tr=0 ts=69ea532b cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=iQ6ETzBq9ecOQQE5vZCe:22 a=pqNCOWEjtIZj0EiKEvsA:9
 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-23_03,2026-04-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 clxscore=1015 priorityscore=1501 impostorscore=0 bulkscore=0
 spamscore=0 lowpriorityscore=0 phishscore=0 adultscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604200000 definitions=main-2604230167
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[ibm.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[ibm.com:s=pp1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[25];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-9309-lists,linux-integrity=lfdr.de];
	FREEMAIL_CC(0.00)[arm.com,vger.kernel.org,lists.infradead.org,lists.linux.dev,paul-moore.com,namei.org,hallyn.com,huawei.com,gmail.com,oracle.com,kernel.org,ziepe.ca,meta.com,google.com];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
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
X-Rspamd-Queue-Id: 3E0684556CF
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Thu, 2026-04-23 at 18:02 +0100, Jonathan McDowell wrote:
> > > > > >=20
> > > > > > I think what Mimi's proposing is:
> > > > > >=20
> > > > > > If we're in late_initcall, and the TPM isn't available, return
> > > > > > immediately with an error (the EPROBE_DEFER?), don't do any ini=
t.
> > > > > >=20
> > > > > > If we're in late_initcall_sync, either we're already initialise=
d, so do
> > > > > > return and nothing, or run through the entire flow, even if the=
 TPM
> > > > > > isn't unavailable.
> > > > > >=20
> > > > > > So ima_init() just needs to know a) if it's in the sync or non-=
sync mode
> > > > > > and b) for the sync mode, if we've already done the init at
> > > > > > non-sync.
> > > > >=20
> > > > > Thanks, Jonathan.  That is exactly what I'm suggesting.  Any othe=
r changes
> > > > > should not be included in this patch.  Since Yeoreum is not heari=
ng me, feel
> > > > > free to post a patch.
> > > >=20
> > > > I see. so what you need to is this only
> > > > If it looks good to you. I'll send it at v3.
> > >=20
> > > FWIW, I pulled the tpm_default_chip check out a level to account for =
the
> > > extra init you mentioned, and have the following (completely untested=
 or
> > > compiled, but gives the approach):
> >=20
> > Thanks, Jonathan!  It looks good.  Similarly untested/compiled.
>=20
> FWIW, it does compile.
>=20
> > Emitting a message on failure to initialize IMA at late_initcall is goo=
d, but
> > the attestation service won't know.  Could you somehow differentiate be=
tween the
> > late_initcall and late_initcall_sync boot_aggregate records?
>=20
> Are you thinking "boot_aggregate" and "boot_aggregate_late" or similar=
=20
> as the "filename" on the entries, just so it's clear when we did the=20
> init in the log, or something else?

Perfect!

Mimi

