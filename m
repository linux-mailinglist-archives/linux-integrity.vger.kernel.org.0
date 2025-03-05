Return-Path: <linux-integrity+bounces-5094-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 15CFBA4F2A9
	for <lists+linux-integrity@lfdr.de>; Wed,  5 Mar 2025 01:26:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 43444167FB0
	for <lists+linux-integrity@lfdr.de>; Wed,  5 Mar 2025 00:26:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE0F717548;
	Wed,  5 Mar 2025 00:26:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="WTFtSMvZ"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 202272F3B;
	Wed,  5 Mar 2025 00:26:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741134374; cv=none; b=c6ToLmh05+5Yjd3aIa2+YSbHFLDVdfw1M8/lCcfhgbc734yuaeRtvp94WQXPRmeh3eAIxmdFOoxyvuYQ7K/F6fQI6s0ZTNdYD3qNx/QkErU/ReYenJPcjO4yEc6gmEEAlki6iEg94F/pc+IGet4+Q3F/xVB7l9KZlOzwQBTs8fs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741134374; c=relaxed/simple;
	bh=vjLN6lSpvjD572hY3rbpmZUskqG6jnfLQj70Gis6Yjo=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Tq2d61XDuyzN3vov7b1DRahlZ6gEzWI7cLCynyaf1VpO4hJfLcibaxmJMrswuuUcnHNaxMIW1o2seYUGAezVcr+v/VCew3YTD42ZIC11dVGxkOjt4SohsrfCnh+1VkC1zNLd5DYBqH5tZ+qZxonSB0aLx4kLiA5x7hzsIRkUxi8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=WTFtSMvZ; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 524MNwjf006540;
	Wed, 5 Mar 2025 00:25:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=JMr1RX
	SHWb9SLxqttG3/doTU1Tcw87vQ3XBWvafJeJs=; b=WTFtSMvZJPV9SfVFxjwAsr
	ApvAs8ohjNK9UhWsVqhFa6rL6Hx4VYeadnlhXJ5xzXMkjV+WVnzIOdorcdVJ9iDN
	ogJjh2tKlpCo3i9fJePOnGzJeUqI08/cG9p7y4VuiXBaGAwQeworzm3wAs3HJ8jW
	gKyDyTQqty+rWcK9FkXIBZuTLbqmR/ZEathb8Co9mTZNsv6P0ek7QBI5cM2oqTGc
	b+BAFYnJmNum5fMlGN0yeBaQcRuMqyCXWOo1Lt8kszup47f+b6GRQGCYQNzsObk1
	ky1P1wG9DTNBsewi5zsxZqOc3a5S+8EwKjqG3p8EEDbIeJnhbuj29nV27rFZBy6Q
	==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4561j332xb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 05 Mar 2025 00:25:49 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 524MuB6f020853;
	Wed, 5 Mar 2025 00:25:47 GMT
Received: from smtprelay07.dal12v.mail.ibm.com ([172.16.1.9])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 454djng5au-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 05 Mar 2025 00:25:47 +0000
Received: from smtpav04.wdc07v.mail.ibm.com (smtpav04.wdc07v.mail.ibm.com [10.39.53.231])
	by smtprelay07.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 5250PkOR26215044
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 5 Mar 2025 00:25:47 GMT
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A6D2A58052;
	Wed,  5 Mar 2025 00:25:46 +0000 (GMT)
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A47E158045;
	Wed,  5 Mar 2025 00:25:44 +0000 (GMT)
Received: from li-43857255-d5e6-4659-90f1-fc5cee4750ad.ibm.com (unknown [9.61.109.229])
	by smtpav04.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Wed,  5 Mar 2025 00:25:44 +0000 (GMT)
Message-ID: <330dbd19bf0c0fbf34908d4629cbcc548eb9c254.camel@linux.ibm.com>
Subject: Re: [PATCH v9 7/7] ima: measure kexec load and exec events as
 critical data
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
Date: Tue, 04 Mar 2025 19:25:44 -0500
In-Reply-To: <20250304190351.96975-8-chenste@linux.microsoft.com>
References: <20250304190351.96975-1-chenste@linux.microsoft.com>
	 <20250304190351.96975-8-chenste@linux.microsoft.com>
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
X-Proofpoint-GUID: uFqdO4lGR1CyUhH6pWvosWqXRv6Ii_6B
X-Proofpoint-ORIG-GUID: uFqdO4lGR1CyUhH6pWvosWqXRv6Ii_6B
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-04_09,2025-03-04_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0
 impostorscore=0 spamscore=0 mlxlogscore=999 phishscore=0 clxscore=1015
 priorityscore=1501 adultscore=0 mlxscore=0 bulkscore=0 malwarescore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2502100000 definitions=main-2503040192

Hi Steven,

On Tue, 2025-03-04 at 11:03 -0800, steven chen wrote:
> +void ima_measure_kexec_event(const char *event_name)
> +{
> +	char ima_kexec_event[IMA_KEXEC_EVENT_LEN];
> +	size_t buf_size =3D 0;
> +	long len;
> +
> +	buf_size =3D ima_get_binary_runtime_size();
> +	len =3D atomic_long_read(&ima_htable.len);
> +
> +	int n =3D scnprintf(ima_kexec_event, IMA_KEXEC_EVENT_LEN,
> +					"kexec_segment_size=3D%lu;ima_binary_runtime_size=3D%lu;"
> +					"ima_runtime_measurements_count=3D%ld;",
> +					kexec_segment_size, buf_size, len);

Variables should not be defined inline, but at the beginning of the functio=
n.
After doing that, scripts/checkpatch.pl complains about the formatting.

Mimi

> +
> +	ima_measure_critical_data("ima_kexec", event_name, ima_kexec_event, n, =
false, NULL, 0);
> +}
> +

