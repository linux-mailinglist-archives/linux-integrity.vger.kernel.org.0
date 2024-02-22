Return-Path: <linux-integrity+bounces-1392-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E40385FE35
	for <lists+linux-integrity@lfdr.de>; Thu, 22 Feb 2024 17:39:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DC0BD287983
	for <lists+linux-integrity@lfdr.de>; Thu, 22 Feb 2024 16:39:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88EE0153511;
	Thu, 22 Feb 2024 16:39:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="hyERcdDC"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EF9615098C
	for <linux-integrity@vger.kernel.org>; Thu, 22 Feb 2024 16:38:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708619942; cv=none; b=NbNZ7+7upm4u59rb9BncgjvN3R2fuiHax4Yu+CUcKw45fk7S0grIR0N4SlB+5Kv4Cy3X5ibM3fBFuoYt1zAGifofqiZH+8UPuOOAU/G6XE1aBTeKXY26VXZeHBQNMTQuQivX5d6JpJVgtewq+2CewR7fVs5hm/uHCzvRKcUchZM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708619942; c=relaxed/simple;
	bh=7CpdirNVBvUbfecUu8Z6kCsQa8uMxRWfD2HNUY14/Vg=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:Mime-Version; b=B1Sk3KbwvWRFAsfIAgWuHDJ3NCeIth/wY9fKPmjaflY/hASZVJxN6NMS72XFLtVogFaQuF/LlBsWC8pPwx+F7Hc97uW3m+vfPxwyJTNCXwAe+wzZvzL9glev7+PV5b6UoobP6tMnO+77KjVRRnZDlOuoWQTTnbkQN6BsMRu+rl4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=hyERcdDC; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 41MGCYvq030268;
	Thu, 22 Feb 2024 16:38:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 mime-version : content-transfer-encoding; s=pp1;
 bh=hBVCn4JTyk5zpW79u1HmKmXhJ5aN6oHaCdhr0WuwLpI=;
 b=hyERcdDCxE6hXVn+WXGJ//eBKL65DrAkU4e732UlrU6FFKbnisCTwdGEZ4LoBURQ55it
 1BiKFOyS0saC79kYNfNkZ+PG0PCuAArnOKF9lk5j/OycOT3RQZs634PXOq+w5lCtLU7R
 SrGzILKqT/+bnXpWWDMsI+ZY+84Q9dJCscono80hZTrPDP1IApq7iM7T8n6T/1vG/tnr
 b2QS6iJqyC1fMP7HoVoeVamoeTPLsWFLzViZHuq0H/VbJSj+c+3eHCtAnJFx8D2gHrXf
 bcEUCRc1oSYV7WpA3sIa5C8yblmRkE0Sv53uRA1kVWg+4XnT/LYttQvO+xNdLTpHokZp 4g== 
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3we9k68psg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 22 Feb 2024 16:38:29 +0000
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 41MGUcjh003615;
	Thu, 22 Feb 2024 16:38:28 GMT
Received: from smtprelay04.dal12v.mail.ibm.com ([172.16.1.6])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 3wb74tyq3m-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 22 Feb 2024 16:38:28 +0000
Received: from smtpav06.dal12v.mail.ibm.com (smtpav06.dal12v.mail.ibm.com [10.241.53.105])
	by smtprelay04.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 41MGcQBm19595824
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 22 Feb 2024 16:38:28 GMT
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E63975805D;
	Thu, 22 Feb 2024 16:38:24 +0000 (GMT)
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 3C0055806D;
	Thu, 22 Feb 2024 16:38:24 +0000 (GMT)
Received: from li-5cd3c5cc-21f9-11b2-a85c-a4381f30c2f3.ibm.com (unknown [9.61.99.109])
	by smtpav06.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 22 Feb 2024 16:38:24 +0000 (GMT)
Message-ID: <20b13e7bab048b3afb94a8878299aa7d61016364.camel@linux.ibm.com>
Subject: Re: [PATCH v5 6/8] ima: suspend measurements during buffer copy at
 kexec execute
From: Mimi Zohar <zohar@linux.ibm.com>
To: Tushar Sugandhi <tusharsu@linux.microsoft.com>,
        roberto.sassu@huaweicloud.com, roberto.sassu@huawei.com,
        eric.snowberg@oracle.com, stefanb@linux.ibm.com, ebiederm@xmission.com,
        noodles@fb.com, bauermann@kolabnow.com,
        linux-integrity@vger.kernel.org, kexec@lists.infradead.org
Cc: code@tyhicks.com, nramas@linux.microsoft.com, paul@paul-moore.com
Date: Thu, 22 Feb 2024 11:38:23 -0500
In-Reply-To: <cba09611c2e069be49faca2f137d99c772635831.camel@linux.ibm.com>
References: <20240214153827.1087657-1-tusharsu@linux.microsoft.com>
	 <20240214153827.1087657-7-tusharsu@linux.microsoft.com>
	 <cba09611c2e069be49faca2f137d99c772635831.camel@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5 (3.28.5-22.el8) 
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: 4lpycoiXWSoC6ncV3YuTuu16Vl4K81Zw
X-Proofpoint-GUID: 4lpycoiXWSoC6ncV3YuTuu16Vl4K81Zw
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-22_12,2024-02-22_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 adultscore=0
 clxscore=1015 mlxscore=0 phishscore=0 mlxlogscore=960 bulkscore=0
 priorityscore=1501 malwarescore=0 lowpriorityscore=0 spamscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2402220130


> > @@ -176,6 +195,19 @@ int ima_add_template_entry(struct ima_template_entry
> > *entry, int violation,
> >  		}
> >  	}
> >  
> > +	/*
> > +	 * suspend_ima_measurements will be set if the system is
> > +	 * undergoing kexec soft boot to a new kernel.
> > +	 * suspending measurements in this short window ensures the
> > +	 * consistency of the IMA measurement list during copying
> > +	 * of the kexec buffer.
> > +	 */
> 
> Either remove the 2nd sentence "suspending measurements in this short window
> ..." or explain what is meant by "short window".
> 
> 
> > +	if (atomic_read(&suspend_ima_measurements)) {
> > +		audit_cause = "measurements_suspended";
> > +		audit_info = 0;
> > +		goto out;

After the suggested changes, understanding how many measurements are not being
added to the measurement list and not being extended into the TPM would be
really interesting.

Mimi

> > +	}
> > +
> >  	result = ima_add_digest_entry(entry,
> >  				      !IS_ENABLED(CONFIG_IMA_DISABLE_HTABLE));
> >  	if (result < 0) {
> 
> 


