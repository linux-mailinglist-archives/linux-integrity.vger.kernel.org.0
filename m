Return-Path: <linux-integrity+bounces-1372-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 324BF85EEC6
	for <lists+linux-integrity@lfdr.de>; Thu, 22 Feb 2024 02:48:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 626021C2198D
	for <lists+linux-integrity@lfdr.de>; Thu, 22 Feb 2024 01:48:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C236080C;
	Thu, 22 Feb 2024 01:48:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="lOsqQd87"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC283168AC
	for <linux-integrity@vger.kernel.org>; Thu, 22 Feb 2024 01:48:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708566517; cv=none; b=p58D89UD/cuetSwrCw7DUnnN0oUDfE6EJcm/v+RPmLiY/gxu4kCMJpk6V1OOtrkE/dcZbVtSjj9LHTJzhosLPT9mGwwOA6uNIN4j7e/69F+8e4p7ADipkz08zgqXVSKdskr8ZE3yL0pmP00WQdDfqKKiHGfeDtRoDEyYaI47qp4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708566517; c=relaxed/simple;
	bh=7xbqjzkJsujfxwPn/1/LiCpqSysgFsJHYRktpaqu/P0=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:Mime-Version; b=IKleULAHzwWzX58XdznITS55wtO1qTiLlAX72ZIW+B5Sm72HuTuMcs7qQFJe8yLHtvGujDdmWvwG2F7c6FqigkiocnS7MSkCvCrWdSNdb+wzGwknWXk2uKvX7z5DdY434RgASeMb3FTMK+UUXchtYqLWp8lApytI/R+aVZTBXAY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=lOsqQd87; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353723.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 41M1Gqpu032151;
	Thu, 22 Feb 2024 01:47:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 mime-version : content-transfer-encoding; s=pp1;
 bh=Xju1T3kaNJcv/xymaE79FVk7EEUpQgcxMygpLqc5hiQ=;
 b=lOsqQd871/XHyFCq/3AYDUCQLFeZ68JF4SheP0+DoBm7M6eGUhDG4NOeDig788geIvxy
 RZVNn2O/ApaNbzADveMOScf+2bBMQw47Kc2on+8XULRM2OYZt0DC8eXfK/sk/Tb5UG5X
 8Ij6kCczahKNQQlGYcVtH/QTBkvA3W00ZVbCBUu8Xcf7Is3TdI/HsHKOb0NFxoL/xOab
 OUZiginNh3yOJhxNAbRl7P2iQkc7Pfkx5QtTP23FWuH5YG4Syaxl+UlPWQZzA/9Fq13a
 GVK18XkE0ICvadycrzrdU+53vHYi/a5ITMN/DfHyKJ5C3E/XeluA6MLJuY1CkGP9/v75 TA== 
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3wdurehc53-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 22 Feb 2024 01:47:57 +0000
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 41M0KTpf014343;
	Thu, 22 Feb 2024 01:47:57 GMT
Received: from smtprelay06.dal12v.mail.ibm.com ([172.16.1.8])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 3wb9u2tmm8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 22 Feb 2024 01:47:57 +0000
Received: from smtpav05.wdc07v.mail.ibm.com (smtpav05.wdc07v.mail.ibm.com [10.39.53.232])
	by smtprelay06.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 41M1ls9I5637104
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 22 Feb 2024 01:47:56 GMT
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 5708358043;
	Thu, 22 Feb 2024 01:47:54 +0000 (GMT)
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 22BDB58065;
	Thu, 22 Feb 2024 01:47:53 +0000 (GMT)
Received: from li-5cd3c5cc-21f9-11b2-a85c-a4381f30c2f3.ibm.com (unknown [9.61.133.105])
	by smtpav05.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 22 Feb 2024 01:47:52 +0000 (GMT)
Message-ID: <fa85d215803c380ea06669703b9f101e8ec64fb4.camel@linux.ibm.com>
Subject: Re: [PATCH v5 5/8] ima: kexec: move IMA log copy from kexec load to
 execute
From: Mimi Zohar <zohar@linux.ibm.com>
To: Tushar Sugandhi <tusharsu@linux.microsoft.com>,
        roberto.sassu@huaweicloud.com, roberto.sassu@huawei.com,
        eric.snowberg@oracle.com, stefanb@linux.ibm.com, ebiederm@xmission.com,
        noodles@fb.com, bauermann@kolabnow.com,
        linux-integrity@vger.kernel.org, kexec@lists.infradead.org
Cc: code@tyhicks.com, nramas@linux.microsoft.com, paul@paul-moore.com
Date: Wed, 21 Feb 2024 20:47:52 -0500
In-Reply-To: <20240214153827.1087657-6-tusharsu@linux.microsoft.com>
References: <20240214153827.1087657-1-tusharsu@linux.microsoft.com>
	 <20240214153827.1087657-6-tusharsu@linux.microsoft.com>
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
X-Proofpoint-ORIG-GUID: qZCeno6HZx8Ym3DQSAKJ6eaxIZn_0uJA
X-Proofpoint-GUID: qZCeno6HZx8Ym3DQSAKJ6eaxIZn_0uJA
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-21_10,2024-02-21_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxlogscore=999 priorityscore=1501
 adultscore=0 bulkscore=0 suspectscore=0 mlxscore=0 malwarescore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2402220012


> @@ -195,7 +181,34 @@ void ima_add_kexec_buffer(struct kimage *image)
>  static int ima_update_kexec_buffer(struct notifier_block *self,
>  				   unsigned long action, void *data)
>  {
> -	return NOTIFY_OK;
> +	void *buf = NULL;
> +	size_t buf_size;
> +	int ret = NOTIFY_OK;
> +
> +	if (!kexec_in_progress) {
> +		pr_info("%s: No kexec in progress.\n", __func__);
> +		return ret;
> +	}
> +
> +	if (!ima_kexec_buffer) {
> +		pr_err("%s: Kexec buffer not set.\n", __func__);
> +		return ret;
> +	}

pr_ messages should already be prefixed with the module name.  There shouldn't
be a need to include the function name as well.

> +	ret = ima_dump_measurement_list(&buf_size, &buf,
> +					kexec_segment_size);
> +
> +	if (!buf) {
> +		pr_err("%s: Dump measurements failed. Error:%d\n",
> +		       __func__, ret);
> +		goto out;
> +	}
> +	memcpy(ima_kexec_buffer, buf, buf_size);
> +out:
> +	kimage_unmap_segment(ima_kexec_buffer);
> +	ima_kexec_buffer = NULL;
> +
> +	return ret;
>  }
>  
>  struct notifier_block update_buffer_nb = {


