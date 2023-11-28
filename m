Return-Path: <linux-integrity+bounces-260-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C58C7FBA34
	for <lists+linux-integrity@lfdr.de>; Tue, 28 Nov 2023 13:35:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EB4141F2063A
	for <lists+linux-integrity@lfdr.de>; Tue, 28 Nov 2023 12:35:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F51B4F8B8;
	Tue, 28 Nov 2023 12:35:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="enNFw54G"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D78E10F7;
	Tue, 28 Nov 2023 04:35:25 -0800 (PST)
Received: from pps.filterd (m0353723.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3ASCQHI2010187;
	Tue, 28 Nov 2023 12:35:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=W2YwZ/OC+qrCGZ6ky0iGSWynUKcyYgVsTnESqnApOV0=;
 b=enNFw54G4dAx5OWb28ZdP+Wjoz0TxhsC5+jjJcgyhkzH69IdxhBFNH4kOMBPr3SWlbB3
 KYdLwvGRC9gqke3Sal2vZBI1gO9is3dIB9vEsjUkGatRlDxWJNn9XZYFJMCu22fPdPfk
 prDNWnJ/M5lZMNak+IZxWvKG+buIOgTca45NkMAvHvSIkwdvprqGHzhpt81UuJmmmSaE
 ftZP70qanShrX2BlovhNg9iQasHy73NLGBZiJ1Uvn5IOpfS26vpObYGt1j7l4E3GbVP3
 AMUC4mK+6KlVqsH7t1h0qc7Z0eLOmTLxsUcb3Zd6UV3bOPyZ0H9TZygeN7oztfp90Y+c GA== 
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3unfk01d60-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 28 Nov 2023 12:35:18 +0000
Received: from m0353723.ppops.net (m0353723.ppops.net [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 3ASBhg34025897;
	Tue, 28 Nov 2023 12:35:18 GMT
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3unfk01d5q-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 28 Nov 2023 12:35:18 +0000
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 3ASAR3f2018253;
	Tue, 28 Nov 2023 12:35:17 GMT
Received: from smtprelay02.dal12v.mail.ibm.com ([172.16.1.4])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 3ukwy1q2cw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 28 Nov 2023 12:35:17 +0000
Received: from smtpav05.dal12v.mail.ibm.com (smtpav05.dal12v.mail.ibm.com [10.241.53.104])
	by smtprelay02.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 3ASCZHOd32899640
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 28 Nov 2023 12:35:17 GMT
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id F2CAB58056;
	Tue, 28 Nov 2023 12:35:16 +0000 (GMT)
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 557E758052;
	Tue, 28 Nov 2023 12:35:16 +0000 (GMT)
Received: from [9.47.158.152] (unknown [9.47.158.152])
	by smtpav05.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 28 Nov 2023 12:35:16 +0000 (GMT)
Message-ID: <dd74fdb8-93af-4799-b23a-b2595acfc8aa@linux.ibm.com>
Date: Tue, 28 Nov 2023 07:35:15 -0500
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 7/8] tpm: Add tpm_buf_read_{u8,u16,u32}
Content-Language: en-US
To: Jarkko Sakkinen <jarkko@kernel.org>, linux-integrity@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
        James Bottomley <James.Bottomley@HansenPartnership.com>,
        William Roberts <bill.c.roberts@gmail.com>,
        David Howells <dhowells@redhat.com>, Jason Gunthorpe <jgg@ziepe.ca>,
        Mimi Zohar <zohar@linux.ibm.com>,
        Mario Limonciello <mario.limonciello@amd.com>,
        Jerry Snitselaar <jsnitsel@redhat.com>
References: <20231124020237.27116-1-jarkko@kernel.org>
 <20231124020237.27116-8-jarkko@kernel.org>
From: Stefan Berger <stefanb@linux.ibm.com>
In-Reply-To: <20231124020237.27116-8-jarkko@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: rP1408_SM3V8cG8L6CrC_155V6qQmkuY
X-Proofpoint-GUID: bsfUcVzLwJuE12EumUqxacs0-ek95nM1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-28_12,2023-11-27_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0
 impostorscore=0 lowpriorityscore=0 mlxscore=0 priorityscore=1501
 phishscore=0 suspectscore=0 mlxlogscore=675 clxscore=1015 bulkscore=0
 spamscore=0 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311060000 definitions=main-2311280100



On 11/23/23 21:02, Jarkko Sakkinen wrote:
> Declare reader functions for the instances of struct tpm_buf. If the read
> goes out of boundary, TPM_BUF_BOUNDARY_ERROR is set, and subsequent read
> will do nothing.
> 
> Signed-off-by: Jarkko Sakkinen <jarkko@kernel.org>
> ---

> + */
> +u16 tpm_buf_read_u16(struct tpm_buf *buf, off_t *offset)
> +{
> +	u16 value;

This should be __be16 ...

> +
> +	tpm_buf_read(buf, offset, sizeof(value), &value);
> +
> +	return be16_to_cpu(value);
> +}
> +EXPORT_SYMBOL_GPL(tpm_buf_read_u16);
> +
> +/**
> + * tpm_buf_read_u32() - Read 32-bit word from a TPM buffer
> + * @buf:	&tpm_buf instance
> + * @offset:	offset within the buffer
> + *
> + * Return: next 32-bit word
> + */
> +u32 tpm_buf_read_u32(struct tpm_buf *buf, off_t *offset)
> +{
> +	u32 value;

... and this __be32 to avoid this here:

drivers/char/tpm/tpm-buf.c:203:16: warning: cast to restricted __be16
drivers/char/tpm/tpm-buf.c:220:16: warning: cast to restricted __be32

