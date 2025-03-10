Return-Path: <linux-integrity+bounces-5212-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E075A59A09
	for <lists+linux-integrity@lfdr.de>; Mon, 10 Mar 2025 16:33:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A1B3218859AA
	for <lists+linux-integrity@lfdr.de>; Mon, 10 Mar 2025 15:33:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2AB9922AE7C;
	Mon, 10 Mar 2025 15:33:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="ioAw/PLU"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1339226CFA
	for <linux-integrity@vger.kernel.org>; Mon, 10 Mar 2025 15:33:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741620825; cv=none; b=b83GLnlr63X/BoNQonbOiRP5z+pvS+wPC5j6jMa9OSqkmCk1h6jI7RXdyzqhubtzlG9sgx4uZGTXHRaYz51Udb6R5is8+JkpUZHcawNVJsQrA4/Z3U7VFkgW1erK3honbQDwJMVvTx2aVIQoKRJ4wCKoOzJnBaJBGXnr69bFdog=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741620825; c=relaxed/simple;
	bh=o0tsC9oK9M6nEEAEYY/fmef0g6Heg5iqkagCWBDHamE=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=n6mrhYGDGaVEgTCFIU+ZPN4Qxul0ZsJ6SbaciWcH3eQ+MwddggYf680Q/FnT0Wu7N5GUAHi70J2HGaLAgzES5ubZ35eGXcbt2tfx8327uZI7JUJB/+1Pf6ehJrUGrwUQofU8+mpJ4nKtwilq4aqsBa4Gq+utEnbcbhnfp2xE0fo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=ioAw/PLU; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52AE36uZ027805;
	Mon, 10 Mar 2025 15:33:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=omQjwO
	UOQ1zyN/xVouOTv/yvneXmz5VRfViFYgsL/rk=; b=ioAw/PLUJD7Ka5E4k0IILP
	A5e5dPJW0yZzk/j+q0VFrx+mImpZqrVNa/zJJJ2HjNysfz3mUeEr7zRTLL32u6MS
	HaPRKhibLWHkSxROzfRQ3waT30YwbvXdU1so8Et/QFDQh/e4+CSZAd4Mkm9DI0bR
	BbkPEJxeSQz7w/jPp8f8tVMkwaCzXvH33X+JPlMQjY7Nm5Or9ha7VFIW0VFJnPXe
	wDnn/84ctWcO748dE7xyIxb8buA5OzViCRKCDoVmTOhSalmX7nqdzuZL2Ew+JO0Y
	zdKpDEQ3WJ9GDLROMl6Cjv5t7jjNlaKW45T64iLkeul9I+llIY/UBrgiJUi9Z0Tw
	==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 45a1gp0h4m-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 10 Mar 2025 15:33:35 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 52AEI0f8022203;
	Mon, 10 Mar 2025 15:33:34 GMT
Received: from smtprelay06.wdc07v.mail.ibm.com ([172.16.1.73])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 45917n79je-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 10 Mar 2025 15:33:34 +0000
Received: from smtpav05.dal12v.mail.ibm.com (smtpav05.dal12v.mail.ibm.com [10.241.53.104])
	by smtprelay06.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 52AFXX8p17629696
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 10 Mar 2025 15:33:33 GMT
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 5F9F758068;
	Mon, 10 Mar 2025 15:33:33 +0000 (GMT)
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 0FA1558067;
	Mon, 10 Mar 2025 15:33:33 +0000 (GMT)
Received: from li-43857255-d5e6-4659-90f1-fc5cee4750ad.ibm.com (unknown [9.61.67.195])
	by smtpav05.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 10 Mar 2025 15:33:32 +0000 (GMT)
Message-ID: <88e87da5b2d5d731e6ad4e2b4043d39e4221684d.camel@linux.ibm.com>
Subject: Re: [RFC PATCH] IMA: Remove evm_overlay.sh
From: Mimi Zohar <zohar@linux.ibm.com>
To: Petr Vorel <pvorel@suse.cz>, ltp@lists.linux.it
Cc: linux-integrity@vger.kernel.org, Ignaz Forster <iforster@suse.de>
Date: Mon, 10 Mar 2025 11:33:32 -0400
In-Reply-To: <20250307102429.GA272497@pevik>
References: <20250114113239.611278-1-pvorel@suse.cz>
	 <20250307102429.GA272497@pevik>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.4 (3.52.4-2.fc40) 
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 0LHyb4Y1XXaj8hRMkk3VFVz1HqhdZcR3
X-Proofpoint-ORIG-GUID: 0LHyb4Y1XXaj8hRMkk3VFVz1HqhdZcR3
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-10_06,2025-03-07_03,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 clxscore=1011
 mlxlogscore=805 suspectscore=0 spamscore=0 impostorscore=0 bulkscore=0
 phishscore=0 malwarescore=0 priorityscore=1501 adultscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2502100000 definitions=main-2503100121

On Fri, 2025-03-07 at 11:24 +0100, Petr Vorel wrote:
> Hi Mimi, Ignaz,
>=20
> > Proof of concept, it was never fixed in the kernel.
> > Instead we should have some basic EVM tests.
>=20
> gently ping. Is evm_overlay.sh test useful for you?
> Otherwise I'll delete it.

Requiring the "ima_policy=3Dappraise_tcb" default policy to run the tests l=
imits
its usefulness.  Perhaps REQUIRED_POLICY_CONTENT could be defined.  I'll le=
t you
know. For now, please don't remove the test.

thanks,

Mimi

