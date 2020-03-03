Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 73865176DC9
	for <lists+linux-integrity@lfdr.de>; Tue,  3 Mar 2020 05:03:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727101AbgCCEDv (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 2 Mar 2020 23:03:51 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:46376 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726891AbgCCEDv (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 2 Mar 2020 23:03:51 -0500
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 02340Xut131481
        for <linux-integrity@vger.kernel.org>; Mon, 2 Mar 2020 23:03:50 -0500
Received: from e06smtp07.uk.ibm.com (e06smtp07.uk.ibm.com [195.75.94.103])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2yfhqqcwha-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-integrity@vger.kernel.org>; Mon, 02 Mar 2020 23:03:49 -0500
Received: from localhost
        by e06smtp07.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-integrity@vger.kernel.org> from <zohar@linux.ibm.com>;
        Tue, 3 Mar 2020 04:03:47 -0000
Received: from b06cxnps4074.portsmouth.uk.ibm.com (9.149.109.196)
        by e06smtp07.uk.ibm.com (192.168.101.137) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Tue, 3 Mar 2020 04:03:44 -0000
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com [9.149.105.232])
        by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 02343h1x54263954
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 3 Mar 2020 04:03:43 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 7928D5205F;
        Tue,  3 Mar 2020 04:03:43 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.80.229.179])
        by d06av21.portsmouth.uk.ibm.com (Postfix) with ESMTP id 970925204E;
        Tue,  3 Mar 2020 04:03:42 +0000 (GMT)
Subject: Re: [PATCH v3 7/8] ima: Calculate and extend PCR with digests in
 ima_template_entry
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Roberto Sassu <roberto.sassu@huawei.com>,
        James.Bottomley@HansenPartnership.com,
        jarkko.sakkinen@linux.intel.com
Cc:     linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, silviu.vlasceanu@huawei.com
Date:   Mon, 02 Mar 2020 23:03:42 -0500
In-Reply-To: <20200210100418.22049-1-roberto.sassu@huawei.com>
References: <20200210100418.22049-1-roberto.sassu@huawei.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.20.5 (3.20.5-1.fc24) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
x-cbid: 20030304-0028-0000-0000-000003E03FA6
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 20030304-0029-0000-0000-000024A56A70
Message-Id: <1583208222.8544.168.camel@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.572
 definitions=2020-03-02_09:2020-03-02,2020-03-02 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 phishscore=0
 priorityscore=1501 clxscore=1015 lowpriorityscore=0 bulkscore=0
 impostorscore=0 malwarescore=0 mlxscore=0 suspectscore=0 mlxlogscore=999
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2001150001 definitions=main-2003030028
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Mon, 2020-02-10 at 11:04 +0100, Roberto Sassu wrote:

> @@ -219,6 +214,8 @@ int ima_restore_measurement_entry(struct ima_template_entry *entry)
>  
>  int __init ima_init_digests(void)
>  {
> +	u16 digest_size;
> +	u16 crypto_id;
>  	int i;
>  
>  	if (!ima_tpm_chip)
> @@ -229,8 +226,17 @@ int __init ima_init_digests(void)
>  	if (!digests)
>  		return -ENOMEM;
>  
> -	for (i = 0; i < ima_tpm_chip->nr_allocated_banks; i++)
> +	for (i = 0; i < ima_tpm_chip->nr_allocated_banks; i++) {
>  		digests[i].alg_id = ima_tpm_chip->allocated_banks[i].alg_id;
> +		digest_size = ima_tpm_chip->allocated_banks[i].digest_size;
> +		crypto_id = ima_tpm_chip->allocated_banks[i].crypto_id;
> +
> +		/* for unmapped TPM algorithms digest is still a padded SHA1 */
> +		if (crypto_id == HASH_ALGO__LAST)
> +			digest_size = SHA1_DIGEST_SIZE;
> +
> +		memset(digests[i].digest, 0xff, digest_size);

Shouldn't the memset here be of the actual digest size even for
unmapped TPM algorithms.

> +	}
>  
>  	return 0;
>  }

