Return-Path: <linux-integrity+bounces-4348-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 97D549ECBD8
	for <lists+linux-integrity@lfdr.de>; Wed, 11 Dec 2024 13:19:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 03949188A331
	for <lists+linux-integrity@lfdr.de>; Wed, 11 Dec 2024 12:19:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4908F1BD9C8;
	Wed, 11 Dec 2024 12:18:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="eAURM691"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A32DB2210D7
	for <linux-integrity@vger.kernel.org>; Wed, 11 Dec 2024 12:18:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733919535; cv=none; b=qcumIMh05+1qyV6PDf9znOWXmbUDOy0SqPz3CYhIGq00FZ7Y1c0WevwNhkzZMCO9XXO8FpzTRYY6L0moMjPEjYbt3egoaMFpBKmUzamAc8aTv7/yGOqwU4vb3fnRR5g51ANAJy7kGEodtNdt5f2UZmdojsXpyIb6zajC3ipyv7A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733919535; c=relaxed/simple;
	bh=BaqwCR7U/Z97lvPozgxZXcpNZdy78vBpNMwZfyf5OZM=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=k6tA1pFpb0eIRVZCEeTOlTv7K1dJe3YBwUeD3r76wbn9WCwNR3ZtgLHOGQfadTofej7LUqSlx3Q324oeb+AEaQEsZkHOJ+DAUxr56ywUZsiNLH02mmqoTa8sB1IjhxwIGAcOITMPOE4LZ/o8ilphsLYpKUe8E2xRYoTa+bI2K8o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=eAURM691; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4BBBIBUa008973;
	Wed, 11 Dec 2024 12:18:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=ORAUV+
	JiO6RE+BZek7JQsl/5yygpu1rmOlNgFc7NFoo=; b=eAURM691ksD9FmDiCL5iOs
	RXIQ11PAeO6sceHnstS7ZlykOjCVr/vvff1bUoMCsrrzcME7GfZfXQRR8HDKJZsC
	rnK4gb4n/lY6MTUEWuODXlAi1AUbnne7jIPN+yESicjlLztQaBQVpKLxbgHSIqsu
	omk95sgyyfasw6zHi4pVL0PzNikwgyLNIyn9YBNEfs1nJSKUOnhssQelEku1wl9l
	x4S8ljsTzEytK0+shkCeLacfJmWNA8CoRiyvAYlStX7umolzD33Hf+hEm2iuDzzu
	Y+11oidvW45uZs2us9prWz8iTxdmgsrAJRAUmGcn1wcTIvgAk0LHpOXQ+mwdk9lA
	==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 43ccsjm2j7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 11 Dec 2024 12:18:40 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 4BB9Y5vV000572;
	Wed, 11 Dec 2024 12:18:39 GMT
Received: from smtprelay02.wdc07v.mail.ibm.com ([172.16.1.69])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 43d1pn9b0e-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 11 Dec 2024 12:18:39 +0000
Received: from smtpav04.wdc07v.mail.ibm.com (smtpav04.wdc07v.mail.ibm.com [10.39.53.231])
	by smtprelay02.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 4BBCIdMw13304384
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 11 Dec 2024 12:18:39 GMT
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 63B2C58052;
	Wed, 11 Dec 2024 12:18:39 +0000 (GMT)
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E232158045;
	Wed, 11 Dec 2024 12:18:38 +0000 (GMT)
Received: from li-43857255-d5e6-4659-90f1-fc5cee4750ad.ibm.com (unknown [9.61.71.1])
	by smtpav04.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 11 Dec 2024 12:18:38 +0000 (GMT)
Message-ID: <710315f59b9378d76d226e209fee698f6bc11c06.camel@linux.ibm.com>
Subject: Re: [PATCH 2/3] ima_setup.sh: Allow to load predefined policy
From: Mimi Zohar <zohar@linux.ibm.com>
To: Petr Vorel <pvorel@suse.cz>, ltp@lists.linux.it
Cc: linux-integrity@vger.kernel.org,
        Roberto Sassu
	 <roberto.sassu@huaweicloud.com>
Date: Wed, 11 Dec 2024 07:18:38 -0500
In-Reply-To: <20241126173830.98960-3-pvorel@suse.cz>
References: <20241126173830.98960-1-pvorel@suse.cz>
	 <20241126173830.98960-3-pvorel@suse.cz>
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
X-Proofpoint-GUID: BfxQ6LX7SjTRq5f7ERZGtQXgi71bvrMj
X-Proofpoint-ORIG-GUID: BfxQ6LX7SjTRq5f7ERZGtQXgi71bvrMj
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-15_01,2024-10-11_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 adultscore=0
 impostorscore=0 spamscore=0 lowpriorityscore=0 bulkscore=0 mlxlogscore=999
 mlxscore=0 priorityscore=1501 suspectscore=0 malwarescore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2411120000
 definitions=main-2412110087

On Tue, 2024-11-26 at 18:38 +0100, Petr Vorel wrote:
> environment variable LTP_IMA_LOAD_POLICY=3D1 tries to load example policy
> if available. This should be used only if tooling running LTP tests
> allows to reboot afterwards (because policy may be writable only once,
> e.g. missing CONFIG_IMA_WRITE_POLICY=3Dy, or policies can influence each
> other).

Thanks, Petr.  Allowing the policy to be updated only if permitted is a goo=
d
idea.  Even with the LTP_IMA_LOAD_POLICY=3D1 environment variable, the poli=
cy
might not be loaded.  For example, when secure boot is enabled and the kern=
el is
configured with CONFIG_IMA_ARCH_POLICY enabled, an "appraise func=3DPOLICY_=
CHECK
appraise_type=3Dimasig" rule is loaded, requiring the IMA policy itself to =
be
signed.

On failure to load a policy, the ima_conditionals.sh and ima_policy.sh test=
s say
"TINFO: SELinux enabled in enforcing mode, this may affect test results".  =
We
should stop blaming SELinux. :)

thanks,

Mimi


