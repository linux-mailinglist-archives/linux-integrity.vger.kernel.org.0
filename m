Return-Path: <linux-integrity+bounces-8540-lists+linux-integrity=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-integrity@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oPbiCBCfnGnPJgQAu9opvQ
	(envelope-from <linux-integrity+bounces-8540-lists+linux-integrity=lfdr.de@vger.kernel.org>)
	for <lists+linux-integrity@lfdr.de>; Mon, 23 Feb 2026 19:40:16 +0100
X-Original-To: lists+linux-integrity@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 7FD7817B9ED
	for <lists+linux-integrity@lfdr.de>; Mon, 23 Feb 2026 19:40:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4AD6C30479DF
	for <lists+linux-integrity@lfdr.de>; Mon, 23 Feb 2026 18:38:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFA163385AB;
	Mon, 23 Feb 2026 18:38:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="coLR2RMc"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB533330317;
	Mon, 23 Feb 2026 18:38:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771871900; cv=none; b=HhhCl2ViBSWEsHSkJ1WRzN+wHhscCegJ8VO8jA7SZP4A8U6V4Y5JhP6qrIdPO3r+/YyMKExI1OSWO6vsHShnkzPw/PR80hZwmjjiKo4a+XrTuOcS72Zp3CPTy1Lcf9KfY3LwFRKNxJmk9ALmhzCNk+V8ov2AJvk5pRRIl3DTALw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771871900; c=relaxed/simple;
	bh=JMvy0l1fqGognu60QEz8wWzG3P9L9D0a9DQWPhiNSWk=;
	h=Message-ID:Subject:From:To:Cc:In-Reply-To:References:Content-Type:
	 Date:MIME-Version; b=EqyWyHGp7x2/ncexZm2CWFRkh3cQL+uG0C2xXmEyEALEBhYJ5N1H2vjLhYI7ABaPKKoYeZ0KwesneqDALkvx9jLN48n2N2Q/OODZQye5PhLejd/HDw8WKrSovl9pOh+YbZ+IB5iO+d/xqqujuJ3Wy33H049bEO/jVrFMQQRFNrY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=coLR2RMc; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 61NEFxL62722347;
	Mon, 23 Feb 2026 18:38:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=JMvy0l
	1fqGognu60QEz8wWzG3P9L9D0a9DQWPhiNSWk=; b=coLR2RMcQu8iIuV77CTY2Y
	ihEvdQIjPnYioGbBo9cA8R3mDIWw/nyGZTWR79M0aGCjs8QTcL1N4yGRDNF+dj4i
	b7cypd4uk0XyLFUztaEuzQxuOQDbpfBwT6sB+uvxAFiByL+t6ux9KNbWaF2NLtBC
	A/vO/eR8qdoqUWf5ynQiQYSdtrIIYPvMrzE1wdvd1Js92nSewnMwcBlz7fy1Nz9Z
	TlqwWG9fWiKqHAsDM5IdwhS9uN1qmEJONjuxNGUPMrdFb7C73TKch/48AIx1rAch
	XNzhw6x7kZWnFZU5kkR4JwLnhYJnbMX8EPbZ/7ayvP0FCpXj1jphkWZdQAeblLjg
	==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4cf471reec-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 23 Feb 2026 18:38:15 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 61NGjET2027821;
	Mon, 23 Feb 2026 18:38:14 GMT
Received: from smtprelay06.wdc07v.mail.ibm.com ([172.16.1.73])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4cfsr1nk0c-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 23 Feb 2026 18:38:14 +0000
Received: from smtpav06.wdc07v.mail.ibm.com (smtpav06.wdc07v.mail.ibm.com [10.39.53.233])
	by smtprelay06.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 61NIcC2l29229582
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 23 Feb 2026 18:38:12 GMT
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 9681D5804E;
	Mon, 23 Feb 2026 18:38:12 +0000 (GMT)
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 516FC5803F;
	Mon, 23 Feb 2026 18:38:11 +0000 (GMT)
Received: from li-43857255-d5e6-4659-90f1-fc5cee4750ad.ibm.com (unknown [9.61.83.143])
	by smtpav06.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 23 Feb 2026 18:38:11 +0000 (GMT)
Message-ID: <82f97981195dd5e0c1c265c21d5dac3ab907ed4c.camel@linux.ibm.com>
Subject: Re: [PATCH v3 3/3] s390: Drop unnecessary
 CONFIG_IMA_SECURE_AND_OR_TRUSTED_BOOT
From: Mimi Zohar <zohar@linux.ibm.com>
To: Coiby Xu <coxu@redhat.com>, linux-integrity@vger.kernel.org
Cc: Heiko Carstens <hca@linux.ibm.com>,
        Alexander Egorenkov	
 <egorenar@linux.ibm.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        Dave Hansen	
 <dave.hansen@intel.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Alexander
 Gordeev	 <agordeev@linux.ibm.com>,
        Christian Borntraeger
 <borntraeger@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        "open
 list:S390 ARCHITECTURE" <linux-s390@vger.kernel.org>,
        open list	
 <linux-kernel@vger.kernel.org>
In-Reply-To: <20260213012851.2532722-4-coxu@redhat.com>
References: <20260213012851.2532722-1-coxu@redhat.com>
	 <20260213012851.2532722-4-coxu@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Date: Mon, 23 Feb 2026 13:38:10 -0500
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Evolution 3.56.2 (3.56.2-2.fc42) 
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: OPsiRZ3ijIutWSWgxD1zPyXZ0wIY_47B
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjIzMDE1NyBTYWx0ZWRfX5sF0TZ0CaS70
 rrA4zZbVVUkn/Hr0pjDHscKty4i8X4vMZLBiJBbDPlgf6/kqHGJKxOla1qwCvhY0CsTct3/+IMd
 GNXqZV886El36mZKpk6xfYHYs5XueYDsvi1fiCIhXIlKNlsMLiVGNWmY1gZQwB3pWha6FB2LAax
 4RTqVky2Dp4AA3x2qNmZqZ6F1NWRsE/Q6VKWGxLaC0P69uIBjMkwPUm/rO3jmNpTI6yWWp3zsp6
 XcVbTM91QnihPy8earF0MIaTGUQ1FjRn9clynI9AuNy3A8iwQt0iRzj7GvB8Kt4wcbkXkwMAaub
 CgGamZNWQ9plmxcbz52W5Adccz6D0yN1Z9Q2UfYwjzy0Dp82G4EnhIn1ZqKaVbKvJC6SU2KlEzT
 5S5HDjEJpNo3FZ2t5PDFMnMLefPt7Jkw+dObG4VZB6AVWBtPeg0Y6He2L0gVzOfkr55BY2Zyo95
 idV6XSyZj8yDReHkXiA==
X-Authority-Analysis: v=2.4 cv=R7wO2NRX c=1 sm=1 tr=0 ts=699c9e97 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=IkcTkHD0fZMA:10 a=HzLeVaNsDn8A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=Mpw57Om8IfrbqaoTuvik:22 a=GgsMoib0sEa3-_RKJdDe:22 a=20KFwNOVAAAA:8
 a=wvvUMd83uN3BuOnqX7wA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: OPsiRZ3ijIutWSWgxD1zPyXZ0wIY_47B
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-23_04,2026-02-23_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 clxscore=1015 impostorscore=0 phishscore=0 spamscore=0
 suspectscore=0 malwarescore=0 bulkscore=0 adultscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2601150000 definitions=main-2602230157
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[ibm.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[ibm.com:s=pp1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[12];
	TAGGED_FROM(0.00)[bounces-8540-lists,linux-integrity=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[ibm.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,linux.ibm.com:mid];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[zohar@linux.ibm.com,linux-integrity@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	PRECEDENCE_BULK(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[linux-integrity];
	RCVD_COUNT_SEVEN(0.00)[11]
X-Rspamd-Queue-Id: 7FD7817B9ED
X-Rspamd-Action: no action

On Fri, 2026-02-13 at 09:28 +0800, Coiby Xu wrote:
> Commit b5ca117365d9 ("ima: prevent kexec_load syscall based on runtime
> secureboot flag") and commit 268a78404973 ("s390/kexec_file: Disable
> kexec_load when IPLed secure") disabled the kexec_load syscall based
> on the secureboot mode. Commit 9e2b4be377f0 ("ima: add a new CONFIG
> for loading arch-specific policies") needed to detect the secure boot
> mode, not to load an IMA architecture specific policy. Since there is
> the new CONFIG_INTEGRITY_SECURE_BOOT, drop
> CONFIG_IMA_SECURE_AND_OR_TRUSTED_BOOT for s390.
>=20
> Signed-off-by: Coiby Xu <coxu@redhat.com>

Alexander, you added your Tested-by for the original version of this patch =
set.
Can I apply it for v3?

thanks,

Mimi

