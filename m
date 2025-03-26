Return-Path: <linux-integrity+bounces-5455-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 19F46A7272F
	for <lists+linux-integrity@lfdr.de>; Thu, 27 Mar 2025 00:44:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AE8733BAEAB
	for <lists+linux-integrity@lfdr.de>; Wed, 26 Mar 2025 23:44:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC7D919AA5D;
	Wed, 26 Mar 2025 23:44:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="MD36ZbOf"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 251EF24C082;
	Wed, 26 Mar 2025 23:44:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743032679; cv=none; b=CuyaGhr9PFjIw/7guNCkl/1Sc7VHojRUbd3dpPVgjPAhmg1pouezsml/tYKUbUgIuVmSNXAs6vSXEvvmPbwp+SdIERo9XsslSBYSZMtQB+Rqw/d7uGR4S8SJlLWg2A3D0D2gicscFuwYBo10FzUOuAhjy0rjiYfHWUWNz0Y/npQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743032679; c=relaxed/simple;
	bh=D1apogL4fCUbwrUIBOk7sBJ0HDf+NbhOpks7NTMIzdM=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=MuiUvgw2c18odf1YDg5A68k+pcReLOrqTXD2jgF54FLXXRAPLCzoY7FUDJIoQYhmnzkbZw3Zy6ctLodqHYLue5VdTpgd19Nkr8phPzbUqfYLdA4IuUOj+0f/bXRS3mVb+04X8Eyh7mU5H1ly863B7GWIQKh07beZzwTW1W2/zp8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=MD36ZbOf; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52QLF1Nt008791;
	Wed, 26 Mar 2025 23:44:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=Pb0iPc
	dEeHebXeBafq6Cz5IsD8ru0VAgrLo98xb9RWo=; b=MD36ZbOfUkPrFh5VqvRb7v
	+Kt2tEfGngQGbB4KcQ126tLOG4YYdJWL3Com+ciIHdHK+1QXL92XGb06MMAOz0kS
	fdxKcbXQpA8ptNlQ9nhWiOutiRk5eDBLjr/moSQ6wSejDISOsYb4YKF8wmcZ1B9+
	/upSEo/DPU1iXFrTJKRTNL81Ct7PPlvkaf7TLth0drdpuFqBPy3TAyzwA8G5r6Pc
	Y2MHc4tXmKeASyZL8RD1W1QfSUY2f9O7Y/+NBlglnA4s4e4SvsyD9GCzKHGtA9BR
	CD7mFmYMc4xMeoI1JJLCX7QhE8SZjq5jb/ZQGL7azqipu6q8qoNlpBzmw1/z/LrA
	==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 45mk0qatqb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 26 Mar 2025 23:44:10 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 52QN7oei009737;
	Wed, 26 Mar 2025 23:44:09 GMT
Received: from smtprelay01.wdc07v.mail.ibm.com ([172.16.1.68])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 45j9rktmv5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 26 Mar 2025 23:44:09 +0000
Received: from smtpav05.wdc07v.mail.ibm.com (smtpav05.wdc07v.mail.ibm.com [10.39.53.232])
	by smtprelay01.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 52QNi8JM30737142
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 26 Mar 2025 23:44:08 GMT
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 87A7658059;
	Wed, 26 Mar 2025 23:44:08 +0000 (GMT)
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B48D65805D;
	Wed, 26 Mar 2025 23:44:06 +0000 (GMT)
Received: from li-43857255-d5e6-4659-90f1-fc5cee4750ad.ibm.com (unknown [9.61.98.130])
	by smtpav05.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 26 Mar 2025 23:44:06 +0000 (GMT)
Message-ID: <af61537d6d4b293813f86c4b55dcfe15a3139085.camel@linux.ibm.com>
Subject: Re: [PATCH v10 6/8] ima: kexec: move IMA log copy from kexec load
 to execute
From: Mimi Zohar <zohar@linux.ibm.com>
To: steven chen <chenste@linux.microsoft.com>, Baoquan He <bhe@redhat.com>
Cc: stefanb@linux.ibm.com, roberto.sassu@huaweicloud.com,
        roberto.sassu@huawei.com, eric.snowberg@oracle.com,
        ebiederm@xmission.com, paul@paul-moore.com, code@tyhicks.com,
        bauermann@kolabnow.com, linux-integrity@vger.kernel.org,
        kexec@lists.infradead.org, linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, madvenka@linux.microsoft.com,
        nramas@linux.microsoft.com, James.Bottomley@hansenpartnership.com,
        vgoyal@redhat.com, dyoung@redhat.com
Date: Wed, 26 Mar 2025 19:44:06 -0400
In-Reply-To: <2d2ea573-1ddd-44b4-8ba3-4ae86313d63f@linux.microsoft.com>
References: <20250318010448.954-1-chenste@linux.microsoft.com>
	 <20250318010448.954-7-chenste@linux.microsoft.com>
	 <Z9t4LVpE470DMBYU@MiWiFi-R3L-srv>
	 <3d7b5e06-5166-46bb-89dc-a0b95ca7c767@linux.microsoft.com>
	 <Z+E7X6LuQ82q1i5V@MiWiFi-R3L-srv>
	 <6583378c-55ee-4192-a95f-ebaf3f708bbb@linux.microsoft.com>
	 <Z+NmLtn0vojVYJ3H@MiWiFi-R3L-srv>
	 <2d2ea573-1ddd-44b4-8ba3-4ae86313d63f@linux.microsoft.com>
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
X-Proofpoint-GUID: 7gAqfQEYtFE5MeYFzlmWitnjt9waQDRW
X-Proofpoint-ORIG-GUID: 7gAqfQEYtFE5MeYFzlmWitnjt9waQDRW
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-26_09,2025-03-26_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0
 priorityscore=1501 phishscore=0 mlxscore=0 mlxlogscore=665 impostorscore=0
 malwarescore=0 adultscore=0 bulkscore=0 clxscore=1015 spamscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2502280000 definitions=main-2503260146


> > Hmm, it's easier, while maybe not good. We should not repeatedly
> > introduce similar things into codes. Here, it's similar as
> > what kexec_apply_relocations() and arch_kexec_apply_relocations() are
> > doing.
> >=20
> > int machine_kexec_post_load(struct kimage *image)

(As discussed) just as kexec_apply_relocation calls
arch_kexec_apply_relocations().  Name this function kexec_post_load() and c=
all
machine_kexec_post_load().

Mimi

> > {
> > #ifdef CONFIG_IMA_KEXEC
> >          ima_kexec_post_load(image);
> > #endif
> > 	return arch_machine_kexec_post_load();
> > }
>=20

