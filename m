Return-Path: <linux-integrity+bounces-4936-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AE46CA3E24F
	for <lists+linux-integrity@lfdr.de>; Thu, 20 Feb 2025 18:24:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A0DC2160AB9
	for <lists+linux-integrity@lfdr.de>; Thu, 20 Feb 2025 17:22:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D306E204875;
	Thu, 20 Feb 2025 17:22:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="XYDRTG/p"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47FE71E2848;
	Thu, 20 Feb 2025 17:22:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740072174; cv=none; b=TLLhSDhUu2JuFiTfIvEJ/rMg8ziGzxlVvTtx+851TH9itTSblEb2DeaTzMiYLPKS8YiiRgG1yIOdOx3paWGCGxHdY9ExIkTuWA9IRZu4Tm7xuHMjGgQtTKNddKIR062H4YyHbVZ/cKTWojjlFYVHgQGHHNt+eozEjS+vgznBPmk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740072174; c=relaxed/simple;
	bh=iiCsnaoU0TQVN3Wn3gsInJiV1kvV/CCfVEHy+i7LKgI=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=qu9T7PjBMswDflRKzhLPeTtFbibtWZ2diCeLqETxCY1viZq7VQWYA1/GBZoqpq5eXxE5Myzsk51i3J0eXLoYcRjzujqw0b132Tqr+NZwvmVgHjHXWXm2QMqApmnI86u8HaocFQPJS2BH5TAFSXeobr84mmlKLNDQZV0gwwk9N9E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=XYDRTG/p; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51KH1ew6007899;
	Thu, 20 Feb 2025 17:22:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=S+lsw3
	J2GGZrkffZVS1uXbFw8jdnLUvAixzKeCH+EC0=; b=XYDRTG/pmvtz43XuqCR8Lk
	q4wHnqTWDvJyI0a7mnMN/TMyrLAhH596y1MmXEgma9OFnlhI+iKKbjY6fviALDQn
	6aiO/uZAbxz5/5aRiMeOEWEiQICjUbrSiNEyKH5g2+cThWluGSBhHTB5rF4df7Tf
	hDRuP2ebQnkB42k2hPyuQzOgqQhFCh3B8YV8sWeAbl6Lk5d96FXd+LgPxIxC3YOA
	7rhN9NYb2ZsL7YskeRvvtBbJ2uoUa4CkK++p6X+h9qI5Km6CTMYp61Twel/meDIq
	L3BQnS0D9aQHN+1NRj8JmS2ayvrOgbf4/I3lnazhbl2AsEjXyDVeGdaaVEHLR7XQ
	==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 44wtfa4bag-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 20 Feb 2025 17:22:27 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 51KF6sLU002343;
	Thu, 20 Feb 2025 17:22:26 GMT
Received: from smtprelay04.wdc07v.mail.ibm.com ([172.16.1.71])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 44w03xb6d3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 20 Feb 2025 17:22:26 +0000
Received: from smtpav05.dal12v.mail.ibm.com (smtpav05.dal12v.mail.ibm.com [10.241.53.104])
	by smtprelay04.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 51KHMPT129098640
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 20 Feb 2025 17:22:25 GMT
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 1E5D558052;
	Thu, 20 Feb 2025 17:22:25 +0000 (GMT)
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E475F58056;
	Thu, 20 Feb 2025 17:22:23 +0000 (GMT)
Received: from li-43857255-d5e6-4659-90f1-fc5cee4750ad.ibm.com (unknown [9.61.68.26])
	by smtpav05.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 20 Feb 2025 17:22:23 +0000 (GMT)
Message-ID: <c76a6a741b6f465d270153b65ea6f728383ca608.camel@linux.ibm.com>
Subject: Re: [PATCH v8 2/7] kexec: define functions to map and unmap segments
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
Date: Thu, 20 Feb 2025 12:22:23 -0500
In-Reply-To: <20250218225502.747963-3-chenste@linux.microsoft.com>
References: <20250218225502.747963-1-chenste@linux.microsoft.com>
	 <20250218225502.747963-3-chenste@linux.microsoft.com>
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
X-Proofpoint-ORIG-GUID: 9eyMENDAtdtjGXHKLQ0XI_TrwLnteDmW
X-Proofpoint-GUID: 9eyMENDAtdtjGXHKLQ0XI_TrwLnteDmW
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-20_07,2025-02-20_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 suspectscore=0
 impostorscore=0 lowpriorityscore=0 priorityscore=1501 mlxlogscore=999
 bulkscore=0 phishscore=0 malwarescore=0 mlxscore=0 adultscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2502100000 definitions=main-2502200119

Hi Steven,

On Tue, 2025-02-18 at 14:54 -0800, steven chen wrote:
> Currently, the mechanism to map and unmap segments to the kimage
> structure is not available to the subsystems outside of kexec.=C2=A0 This
> functionality is needed when IMA is allocating the memory segments
> during kexec 'load' operation.=C2=A0 Implement functions to map and unmap
> segments to kimage.

Obviously up to now Kexec was mapping the segments. Missing from this patch=
 description is
the reason "why" these functions are needed now.  It's not enough to say "i=
s needed when
IMA is allocating the memory segments during kexec 'load' operation".  The =
question is why
does "IMA" need to allocate the memory segments.  Don't make the kexec/kexe=
c_dump
maintainers guess.

Refer to the section "Describe your changes" in
https://www.kernel.org/doc/Documentation/process/submitting-patches.rst

>=20
> Implement kimage_map_segment() to enable mapping of IMA buffer source
> pages to the kimage structure post kexec 'load'.=C2=A0 This function,
> accepting a kimage pointer, an address, and a size, will gather the
> source pages within the specified address range, create an array of page
> pointers, and map these to a contiguous virtual address range.=C2=A0 The
> function returns the start of this range if successful, or NULL if
> unsuccessful.
>=20
> Implement kimage_unmap_segment() for unmapping segments
> using vunmap().
>=20
> From: Tushar Sugandhi <tusharsu@linux.microsoft.com>
> Author: Tushar Sugandhi <tusharsu@linux.microsoft.com>

Again, no such thing as an "Author" tag.  Refer to the comments on 1/7.

> Signed-off-by: Tushar Sugandhi <tusharsu@linux.microsoft.com>

As previously requested, please add the Cc's inline here and in all the kex=
ec/kdump
related patches:

Cc: Eric Biederman <ebiederm@xmission.com>
Cc: Baoquan He <bhe@redhat.com>=20
Cc: Vivek Goyal <vgoyal@redhat.com>
Cc: Dave Young <dyoung@redhat.com>

> Signed-off-by: steven chen <chenste@linux.microsoft.com>

thanks,

Mimi


