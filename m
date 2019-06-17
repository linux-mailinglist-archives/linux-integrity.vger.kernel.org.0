Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 01E2148805
	for <lists+linux-integrity@lfdr.de>; Mon, 17 Jun 2019 17:56:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728499AbfFQP4M (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 17 Jun 2019 11:56:12 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:25026 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727999AbfFQP4L (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 17 Jun 2019 11:56:11 -0400
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x5HFqrUt143535
        for <linux-integrity@vger.kernel.org>; Mon, 17 Jun 2019 11:56:10 -0400
Received: from e06smtp03.uk.ibm.com (e06smtp03.uk.ibm.com [195.75.94.99])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2t6dex9ame-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-integrity@vger.kernel.org>; Mon, 17 Jun 2019 11:56:10 -0400
Received: from localhost
        by e06smtp03.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-integrity@vger.kernel.org> from <zohar@linux.ibm.com>;
        Mon, 17 Jun 2019 16:56:08 +0100
Received: from b06cxnps4075.portsmouth.uk.ibm.com (9.149.109.197)
        by e06smtp03.uk.ibm.com (192.168.101.133) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Mon, 17 Jun 2019 16:56:05 +0100
Received: from d06av25.portsmouth.uk.ibm.com (d06av25.portsmouth.uk.ibm.com [9.149.105.61])
        by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x5HFu4qB49152140
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 17 Jun 2019 15:56:04 GMT
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id E82F611C05B;
        Mon, 17 Jun 2019 15:56:03 +0000 (GMT)
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id C03EA11C04A;
        Mon, 17 Jun 2019 15:56:02 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.80.81.90])
        by d06av25.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Mon, 17 Jun 2019 15:56:02 +0000 (GMT)
Subject: Re: [PATCH] ima: dynamically allocate shash_desc
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Arnd Bergmann <arnd@arndb.de>,
        Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>
Cc:     Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        Stefan Berger <stefanb@linux.vnet.ibm.com>,
        linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Mon, 17 Jun 2019 11:55:51 -0400
In-Reply-To: <20190617115838.2397872-1-arnd@arndb.de>
References: <20190617115838.2397872-1-arnd@arndb.de>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.20.5 (3.20.5-1.fc24) 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 19061715-0012-0000-0000-00000329E361
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19061715-0013-0000-0000-00002162FBD7
Message-Id: <1560786951.4072.103.camel@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-06-17_07:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1906170141
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Mon, 2019-06-17 at 13:20 +0200, Arnd Bergmann wrote:
> On 32-bit ARM, we get a warning about excessive stack usage when
> building with clang.
> 
> security/integrity/ima/ima_crypto.c:504:5: error: stack frame size
> of 1152 bytes in function 'ima_calc_field_array_hash' [-Werror,-
> Wframe-larger-than=]

I'm definitely not seeing this.  Is this problem a result of non
upstreamed patches?  For sha1, currently the only possible hash
algorithm, I'm seeing 664.

Mimi

> 
> Using kmalloc to get the descriptor reduces this to 320 bytes.
> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  security/integrity/ima/ima_crypto.c | 12 +++++++++---
>  1 file changed, 9 insertions(+), 3 deletions(-)
> 
> diff --git a/security/integrity/ima/ima_crypto.c b/security/integrity/ima/ima_crypto.c
> index d4c7b8e1b083..8a66bab4c435 100644
> --- a/security/integrity/ima/ima_crypto.c
> +++ b/security/integrity/ima/ima_crypto.c
> @@ -461,16 +461,21 @@ static int ima_calc_field_array_hash_tfm(struct ima_field_data *field_data,
>  					 struct ima_digest_data *hash,
>  					 struct crypto_shash *tfm)
>  {
> -	SHASH_DESC_ON_STACK(shash, tfm);
> +	struct shash_desc *shash;
>  	int rc, i;
>  
> +	shash = kmalloc(sizeof(struct shash_desc) + crypto_shash_descsize(tfm),
> +			GFP_KERNEL);
> +	if (!shash)
> +		return -ENOMEM;
> +
>  	shash->tfm = tfm;
>  
>  	hash->length = crypto_shash_digestsize(tfm);
>  
>  	rc = crypto_shash_init(shash);
>  	if (rc != 0)
> -		return rc;
> +		goto out;
>  
>  	for (i = 0; i < num_fields; i++) {
>  		u8 buffer[IMA_EVENT_NAME_LEN_MAX + 1] = { 0 };
> @@ -497,7 +502,8 @@ static int ima_calc_field_array_hash_tfm(struct ima_field_data *field_data,
>  
>  	if (!rc)
>  		rc = crypto_shash_final(shash, hash->digest);
> -
> +out:
> +	kfree(shash);
>  	return rc;
>  }
>  

