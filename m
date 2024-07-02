Return-Path: <linux-integrity+bounces-2964-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A3AE891ED03
	for <lists+linux-integrity@lfdr.de>; Tue,  2 Jul 2024 04:38:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D4D331C21049
	for <lists+linux-integrity@lfdr.de>; Tue,  2 Jul 2024 02:38:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47A2214A9D;
	Tue,  2 Jul 2024 02:38:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="eH5z7BE1"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02C78168A8;
	Tue,  2 Jul 2024 02:38:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719887907; cv=none; b=WrPfKPG2y2GhbZSos3JQnNrKuYTidmXCppTxuwqGDtVUixb7cHO/U1yVnG/Hn5G79lBE9TwYr2z78RX9Qg9lZy58e0ZyIpZ5JpIBTr8vcryvPoqlN1l3FmHjptJHTYGIb4emeVHCj2BFMxuhhKmZNNy0aj3VwUH4Yy5X3+iuDxY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719887907; c=relaxed/simple;
	bh=zA15/BuS2QNdz4cCYTBy9x+qacrIci0a/oQFaD0luXA=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=B2U7ckLMhHOI7h0nn7sShPgWy9qtERm7rYu376LBO9G69PatC39IwyyDAEgBYy4G7vd2hDLKFBlWeTxBYt67emvHVvfYYkI4kbCmUnLdTEREuHEu8fqiC6+0nkdDLp/2mUfSIRVvK0tIT7Tb+W0Ma3G7LWQtdJjrTRhFV+NL+bc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=eH5z7BE1; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4622LRJY010690;
	Tue, 2 Jul 2024 02:37:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=
	message-id:subject:from:to:cc:date:in-reply-to:references
	:content-type:content-transfer-encoding:mime-version; s=pp1; bh=
	5G10Lixps+J/SrJAGVwjF9YxL3IksWa13KqA59IUw4c=; b=eH5z7BE1GXy3/6Xv
	uYnjzc9l8IxGgssJmFwLXXwq0ywuiPeU+ainZcSgItKQXLAkBC0X+uQD9/rA68WW
	m3fU+2MYC7u6jHBaH7RG1e0nrQlphmoLhzVCdSMdaklakSRzS/dRRIQW0rka52Xm
	syH6P3oZl3nv4PCr1eUjfC5Gu5NzC25onaYJyldsD/Cz6al31Z0kzuj04tqlm7+/
	Jjof7bogMG0Ggf3YfdTr27Yre3Gv5GKJgtJUi+vbYFX0E6FTjaCQK6EPac0c8E8A
	3Sjj2T5SWN8QVxJGRIRFzX5OJrrx2wW408p5GDWuixxl3B/5NfpPWdP1F+4z50hJ
	qxaciQ==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4048btr2eg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 02 Jul 2024 02:37:52 +0000 (GMT)
Received: from m0360083.ppops.net (m0360083.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 4622bpOK001084;
	Tue, 2 Jul 2024 02:37:51 GMT
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4048btr2ee-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 02 Jul 2024 02:37:51 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 4620qI2f024095;
	Tue, 2 Jul 2024 02:37:50 GMT
Received: from smtprelay01.wdc07v.mail.ibm.com ([172.16.1.68])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 402ya3a2px-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 02 Jul 2024 02:37:50 +0000
Received: from smtpav01.wdc07v.mail.ibm.com (smtpav01.wdc07v.mail.ibm.com [10.39.53.228])
	by smtprelay01.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 4622blUa43712774
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 2 Jul 2024 02:37:50 GMT
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D823B58137;
	Tue,  2 Jul 2024 02:37:44 +0000 (GMT)
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id DB2CF58151;
	Tue,  2 Jul 2024 02:37:43 +0000 (GMT)
Received: from li-5cd3c5cc-21f9-11b2-a85c-a4381f30c2f3.ibm.com (unknown [9.61.36.24])
	by smtpav01.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Tue,  2 Jul 2024 02:37:43 +0000 (GMT)
Message-ID: <e197920f27bc67df45327ef56ee509d113435b25.camel@linux.ibm.com>
Subject: Re: [RFC] integrity: wait for completion of i2c initialization
 using late_initcall_sync()
From: Mimi Zohar <zohar@linux.ibm.com>
To: Romain Naour <romain.naour@smile.fr>, Paul Menzel <pmenzel@molgen.mpg.de>
Cc: linux-integrity@vger.kernel.org, linux-security-module@vger.kernel.org,
        serge@hallyn.com, jmorris@namei.org, paul@paul-moore.com,
        eric.snowberg@oracle.com, dmitry.kasatkin@gmail.com,
        roberto.sassu@huawei.com, Romain Naour <romain.naour@skf.com>
Date: Mon, 01 Jul 2024 22:37:43 -0400
In-Reply-To: <d7429218-7b48-4201-8ad9-63728e188be5@smile.fr>
References: <20240701133814.641662-1-romain.naour@smile.fr>
	 <c090cd3c-f4c6-4923-a9fa-b54768ca2a26@molgen.mpg.de>
	 <d7429218-7b48-4201-8ad9-63728e188be5@smile.fr>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5 (3.28.5-25.el8_9) 
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: qMiskM232WjBB-RqGNJBjjqD_6_TKtsC
X-Proofpoint-ORIG-GUID: PHgzAHwB6bTXv0hUio-xhULBrOuLBjMZ
Content-Transfer-Encoding: 7bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-01_23,2024-07-01_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 phishscore=0
 lowpriorityscore=0 impostorscore=0 suspectscore=0 mlxscore=0
 priorityscore=1501 malwarescore=0 mlxlogscore=999 adultscore=0 bulkscore=0
 clxscore=1011 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2406140001 definitions=main-2407020016

Hi Romain,

Please limit the subject line to 70 - 75 characters.


On Mon, 2024-07-01 at 16:58 +0200, Romain Naour wrote:
> > > [1]
> > > https://lore.kernel.org/linux-integrity/9b98d912-ba78-402c-a5c8-154bef8794f7@smile.fr/
> > > [2]
> > > https://e2e.ti.com/support/processors-group/processors/f/processors-forum/1375425/tda4vm-ima-vs-tpm-builtin-driver-boot-order
> > > 
> > > Signed-off-by: Romain Naour <romain.naour@skf.com>
> > 
> > Should this get a Fixes: tag and be also applied to the stable series?
> 
> The current behavior can be reproduced on any released kernel (at least since
> 6.1). But I'm not sure if it should be backported to stable kernels since it
> delays the ima/evm initialization at runtime.

With the IMA builtin measurement policy specified on the boot command line
("ima_policy=tcb"), moving init_ima from the late_initcall() to
late_initcall_sync() affects the measurement list order.  It's unlikely, but
possible, that someone is sealing the TPM to PCR-10.  It's probably not a good
idea to backport the change.

An alternative would be to continue using the late_initcall(), but retry on
failure, instead of going directly into TPM-bypass mode.

As far as I can tell, everything is still being measured and verified, but more
testing is required.

Mimi


