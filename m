Return-Path: <linux-integrity+bounces-4953-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B47FCA3E6C0
	for <lists+linux-integrity@lfdr.de>; Thu, 20 Feb 2025 22:36:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6F2D63B199F
	for <lists+linux-integrity@lfdr.de>; Thu, 20 Feb 2025 21:36:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 062672641C2;
	Thu, 20 Feb 2025 21:36:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="TmylOpIO"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E9DA2638B8;
	Thu, 20 Feb 2025 21:36:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740087407; cv=none; b=D2JfVlK+mvMrp2VVMlZC8u7z48sE7dFe1sPSqv25/F/Cg/oVIMLfC4AYRwR9puGBL6/cOGEQ7TAK8ITswEXAkL/1CZmj6wgowrAfqJAiSEsV0TPE7OC1S9ZRmtKumkrAA6THCnYG+XHtvXht3j9HTiKZc/bMkjYKS2gIytKmkl0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740087407; c=relaxed/simple;
	bh=ocxn2vITOhCMlyY2Lv+YIJet0NEDux7ShrMIeChy5p4=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Y2uACJYrv05LTy3Bk7D4qu9AfNe7Vszm0fRtOAJ3MhUEILSBxcc6fzSPzD1j2xgWHFcdfoLgtsVQ83JYR6L6UbFqIbudDlVmFEn72dbDJQAjYULLf/X9EaZ2S2x3vMk/+QN533J8Gu2jCqlyznOmOn72Ggq4x9TdGFzqto4LhZg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=TmylOpIO; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51KH2MDn010151;
	Thu, 20 Feb 2025 21:36:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=ocxn2v
	ITOhCMlyY2Lv+YIJet0NEDux7ShrMIeChy5p4=; b=TmylOpIOcTcHOHXCMfW2rA
	Us2ztmKa3wjRUjjQSaqbV/XzKhG5RC2w65RfgOxjLT+cYMLy8Uk7d9BSWJ2sYRUu
	UwfECa7oUKaCqlZFYIrDtqml+hmJMlDjzuHhaaRzW+bqksx+IeESpSuqZ42LwN9a
	xiOb4TiKzSWCeVGgvr+kwJBGmWUaPlePIVWFNTIoBo33BHm3v5Q1a5FycrkY5Spr
	6t8hvYh0KpZBWHRB0YYSfIOOD1JkUHRaq3aXnbZ5Wujuf8JmNR5mU9SQ6nyRV6TO
	452G4r13BRVqJvPoVuQKDVURF7undN7MPzw5KJPdpY8J5uziPUVIeAhc4O5Yth7A
	==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 44wtfa5hfe-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 20 Feb 2025 21:36:23 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 51KL0SZO029296;
	Thu, 20 Feb 2025 21:36:21 GMT
Received: from smtprelay04.dal12v.mail.ibm.com ([172.16.1.6])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 44w024md7y-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 20 Feb 2025 21:36:21 +0000
Received: from smtpav03.wdc07v.mail.ibm.com (smtpav03.wdc07v.mail.ibm.com [10.39.53.230])
	by smtprelay04.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 51KLaKQF20382326
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 20 Feb 2025 21:36:21 GMT
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C60A45805A;
	Thu, 20 Feb 2025 21:36:20 +0000 (GMT)
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 23F875805D;
	Thu, 20 Feb 2025 21:36:19 +0000 (GMT)
Received: from li-43857255-d5e6-4659-90f1-fc5cee4750ad.ibm.com (unknown [9.31.103.152])
	by smtpav03.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 20 Feb 2025 21:36:19 +0000 (GMT)
Message-ID: <44a2c7cb424c769c6c8863324c522533cb70b0a5.camel@linux.ibm.com>
Subject: Re: [PATCH v8 6/7] ima: make the kexec extra memory configurable
From: Mimi Zohar <zohar@linux.ibm.com>
To: steven chen <chenste@linux.microsoft.com>, stefanb@linux.ibm.com,
        roberto.sassu@huaweicloud.com, roberto.sassu@huawei.com,
        eric.snowberg@oracle.com, ebiederm@xmission.com, paul@paul-moore.com,
        code@tyhicks.com, bauermann@kolabnow.com,
        linux-integrity@vger.kernel.org, kexec@lists.infradead.org,
        linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: madvenka@linux.microsoft.com, nramas@linux.microsoft.com,
        James.Bottomley@HansenPartnership.com, bhe@redhat.com,
        vgoyal@redhat.com, dyoung@redhat.com
Date: Thu, 20 Feb 2025 16:36:18 -0500
In-Reply-To: <20250218225502.747963-7-chenste@linux.microsoft.com>
References: <20250218225502.747963-1-chenste@linux.microsoft.com>
	 <20250218225502.747963-7-chenste@linux.microsoft.com>
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
X-Proofpoint-ORIG-GUID: YqhkbFQcJ59BFj7mB8ysqI2pJLMKyAve
X-Proofpoint-GUID: YqhkbFQcJ59BFj7mB8ysqI2pJLMKyAve
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-20_09,2025-02-20_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 suspectscore=0
 impostorscore=0 lowpriorityscore=0 priorityscore=1501 mlxlogscore=999
 bulkscore=0 phishscore=0 malwarescore=0 mlxscore=0 adultscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2502100000 definitions=main-2502200143

On Tue, 2025-02-18 at 14:55 -0800, steven chen wrote:
> The extra memory allocated for carrying the IMA measurement list across
> kexec is hard-coded as half a PAGE.=C2=A0 Make it configurable.
>=20
> Define a Kconfig option, IMA_KEXEC_EXTRA_MEMORY_KB, to configure the
> extra memory (in kb) to be allocated for IMA measurements added during
> kexec soft reboot.=C2=A0 Ensure the default value of the option is set su=
ch
> that extra half a page of memory for additional measurements is allocated
> for the additional measurements.
>=20
> Update ima_add_kexec_buffer() function to allocate memory based on the
> Kconfig option value, rather than the currently hard-coded one.
>=20
> Suggested-by: Stefan Berger <stefanb@linux.ibm.com>
> Signed-off-by: Tushar Sugandhi <tusharsu@linux.microsoft.com>
> Signed-off-by: steven chen <chenste@linux.microsoft.com>
> Reviewed-by: Stefan Berger <stefanb@linux.ibm.com>

Reviewed-by: Mimi Zohar <zohar@linux.ibm.com>



