Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D347314EC60
	for <lists+linux-integrity@lfdr.de>; Fri, 31 Jan 2020 13:19:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728484AbgAaMTD (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 31 Jan 2020 07:19:03 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:36642 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728442AbgAaMTD (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 31 Jan 2020 07:19:03 -0500
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 00VCEx8W031825
        for <linux-integrity@vger.kernel.org>; Fri, 31 Jan 2020 07:19:02 -0500
Received: from e06smtp02.uk.ibm.com (e06smtp02.uk.ibm.com [195.75.94.98])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2xvkrf91xu-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-integrity@vger.kernel.org>; Fri, 31 Jan 2020 07:19:01 -0500
Received: from localhost
        by e06smtp02.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-integrity@vger.kernel.org> from <zohar@linux.ibm.com>;
        Fri, 31 Jan 2020 12:18:59 -0000
Received: from b06cxnps4075.portsmouth.uk.ibm.com (9.149.109.197)
        by e06smtp02.uk.ibm.com (192.168.101.132) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Fri, 31 Jan 2020 12:18:56 -0000
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com [9.149.105.59])
        by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 00VCItqT54263808
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 31 Jan 2020 12:18:55 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id B5334A4053;
        Fri, 31 Jan 2020 12:18:55 +0000 (GMT)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 9656EA4051;
        Fri, 31 Jan 2020 12:18:54 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.85.193.32])
        by d06av23.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Fri, 31 Jan 2020 12:18:54 +0000 (GMT)
Subject: Re: [PATCH 5/8] ima: allocate and initialize tfm for each PCR bank
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Roberto Sassu <roberto.sassu@huawei.com>,
        jarkko.sakkinen@linux.intel.com,
        james.bottomley@hansenpartnership.com,
        linux-integrity@vger.kernel.org
Cc:     linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, silviu.vlasceanu@huawei.com
Date:   Fri, 31 Jan 2020 07:18:53 -0500
In-Reply-To: <20200127170443.21538-6-roberto.sassu@huawei.com>
References: <20200127170443.21538-1-roberto.sassu@huawei.com>
         <20200127170443.21538-6-roberto.sassu@huawei.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.20.5 (3.20.5-1.fc24) 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 20013112-0008-0000-0000-0000034E8BA9
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 20013112-0009-0000-0000-00004A6F0F7C
Message-Id: <1580473133.6104.48.camel@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.572
 definitions=2020-01-31_03:2020-01-31,2020-01-31 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=2 adultscore=0
 spamscore=0 mlxlogscore=937 priorityscore=1501 phishscore=0 bulkscore=0
 malwarescore=0 mlxscore=0 lowpriorityscore=0 clxscore=1015 impostorscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-1911200001
 definitions=main-2001310108
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Mon, 2020-01-27 at 18:04 +0100, Roberto Sassu wrote:
> This patch creates a crypto_shash structure for each allocated PCR bank and
> for SHA1 if a bank with that algorithm is not currently allocated.
> 
> Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>

<snip>

> +int __init ima_init_crypto(void)
> +{
> +	enum hash_algo algo;
> +	long rc;
> +	int i;
> +
> +	rc = ima_init_ima_crypto();
> +	if (rc)
> +		return rc;
> +
> +	ima_algo_array = kmalloc_array(ima_tpm_chip->nr_allocated_banks + 1,
> +				       sizeof(*ima_algo_array), GFP_KERNEL);

Perhaps instead of hard coding "nr_allocated_banks + 1", create a
variable for storing the number of "extra" banks.  Walk the banks
setting ima_sha1_idx and, later, in a subsequent patch set
ima_hash_algo_idx.

> +	if (!ima_algo_array) {
> +		rc = -ENOMEM;
> +		goto out;
> +	}
> +
> +	for (i = 0; i < ima_tpm_chip->nr_allocated_banks + 1; i++) {
> +		ima_algo_array[i].tfm = NULL;
> +		ima_algo_array[i].algo = HASH_ALGO__LAST;
> +	}

ima_init_crypto() is executed once on initialization.  I'm not sure if
it makes a difference, but if you're really concerned about an
additional loop, the initialization, here, could be limited to the
"extra" banks.  The other banks could be initialized at the beginning
of the next loop.

thanks,

Mimi

> +	ima_sha1_idx = -1;
> +
> +	for (i = 0; i < ima_tpm_chip->nr_allocated_banks; i++) {
> +		algo = ima_tpm_chip->allocated_banks[i].crypto_id;
> +		ima_algo_array[i].algo = algo;
> +
> +		/* unknown TPM algorithm */
> +		if (algo == HASH_ALGO__LAST)
> +			continue;
> +
> +		if (algo == HASH_ALGO_SHA1)
> +			ima_sha1_idx = i;
> +
> +		if (algo == ima_hash_algo) {
> +			ima_algo_array[i].tfm = ima_shash_tfm;
> +			continue;
> +		}
> +
> +		ima_algo_array[i].tfm = ima_alloc_tfm(algo);
> +		if (IS_ERR(ima_algo_array[i].tfm)) {
> +			if (algo == HASH_ALGO_SHA1) {
> +				rc = PTR_ERR(ima_algo_array[i].tfm);
> +				ima_algo_array[i].tfm = NULL;
> +				goto out_array;
> +			}
> +
> +			ima_algo_array[i].tfm = NULL;
> +		}
> +	}
> +
> +	if (ima_sha1_idx < 0) {
> +		ima_algo_array[i].tfm = ima_alloc_tfm(HASH_ALGO_SHA1);
> +		if (IS_ERR(ima_algo_array[i].tfm)) {
> +			rc = PTR_ERR(ima_algo_array[i].tfm);
> +			goto out_array;
> +		}
> +
> +		ima_sha1_idx = i;
> +		ima_algo_array[i].algo = HASH_ALGO_SHA1;
> +	}
> +
> +	return 0;
> +out_array:
> +	for (i = 0; i < ima_tpm_chip->nr_allocated_banks + 1; i++) {
> +		if (!ima_algo_array[i].tfm ||
> +		    ima_algo_array[i].tfm == ima_shash_tfm)
> +			continue;
> +
> +		crypto_free_shash(ima_algo_array[i].tfm);
> +	}
> +out:
> +	crypto_free_shash(ima_shash_tfm);
> +	return rc;
> +}

