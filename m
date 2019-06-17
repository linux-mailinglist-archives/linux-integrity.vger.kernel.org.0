Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C7FC448413
	for <lists+linux-integrity@lfdr.de>; Mon, 17 Jun 2019 15:35:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726248AbfFQNd4 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 17 Jun 2019 09:33:56 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:40256 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726215AbfFQNd4 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 17 Jun 2019 09:33:56 -0400
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x5HDXhKX059544
        for <linux-integrity@vger.kernel.org>; Mon, 17 Jun 2019 09:33:55 -0400
Received: from e06smtp04.uk.ibm.com (e06smtp04.uk.ibm.com [195.75.94.100])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2t69n4x38b-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-integrity@vger.kernel.org>; Mon, 17 Jun 2019 09:33:54 -0400
Received: from localhost
        by e06smtp04.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-integrity@vger.kernel.org> from <zohar@linux.ibm.com>;
        Mon, 17 Jun 2019 14:33:31 +0100
Received: from b06cxnps4076.portsmouth.uk.ibm.com (9.149.109.198)
        by e06smtp04.uk.ibm.com (192.168.101.134) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Mon, 17 Jun 2019 14:33:30 +0100
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com [9.149.105.59])
        by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x5HDXT0q51904716
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 17 Jun 2019 13:33:29 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 2F450A4051;
        Mon, 17 Jun 2019 13:33:29 +0000 (GMT)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 79FE0A4040;
        Mon, 17 Jun 2019 13:33:28 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.80.81.90])
        by d06av23.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Mon, 17 Jun 2019 13:33:28 +0000 (GMT)
Subject: Re: [PATCH v4 3/5] ima-avm-utils: Change read_priv_key to use
 EVP_PKEY API
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Vitaly Chikunov <vt@altlinux.org>,
        Mimi Zohar <zohar@linux.vnet.ibm.com>,
        Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
        linux-integrity@vger.kernel.org
Date:   Mon, 17 Jun 2019 09:33:17 -0400
In-Reply-To: <20190614015410.26039-4-vt@altlinux.org>
References: <20190614015410.26039-1-vt@altlinux.org>
         <20190614015410.26039-4-vt@altlinux.org>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.20.5 (3.20.5-1.fc24) 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 19061713-0016-0000-0000-00000289D113
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19061713-0017-0000-0000-000032E71ADC
Message-Id: <1560778397.4072.79.camel@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-06-17_06:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=2 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1906170125
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Fri, 2019-06-14 at 04:54 +0300, Vitaly Chikunov wrote:
> Introduce read_priv_pkey() to read keys using EVP_PKEY, and change
> read_priv_key() to be wrapper for it.
> 
> Signed-off-by: Vitaly Chikunov <vt@altlinux.org>
> ---
>  src/libimaevm.c | 32 +++++++++++++++++++++++++++-----
>  1 file changed, 27 insertions(+), 5 deletions(-)
> 
> diff --git a/src/libimaevm.c b/src/libimaevm.c
> index da0f422..c620c1e 100644
> --- a/src/libimaevm.c
> +++ b/src/libimaevm.c
> @@ -753,10 +753,10 @@ void calc_keyid_v2(uint32_t *keyid, char *str, RSA *key)
>  	free(pkey);
>  }
> 
> -static RSA *read_priv_key(const char *keyfile, const char *keypass)
> +static EVP_PKEY *read_priv_pkey(const char *keyfile, const char *keypass)
>  {
>  	FILE *fp
> -	RSA *key;
> +	EVP_PKEY *key;

In read_pub_pkey() EVP_PKEY is named pkey, not key.

> 
>  	fp = fopen(keyfile, "r");
>  	if (!fp) {
> @@ -764,18 +764,40 @@ static RSA *read_priv_key(const char *keyfile, const char *keypass)
>  		return NULL;
>  	}
>  	ERR_load_crypto_strings();
> -	key = PEM_read_RSAPrivateKey(fp, NULL, NULL, (void *)keypass);
> +	key = PEM_read_PrivateKey(fp, NULL, NULL, (void *)keypass);
>  	if (!key) {
>  		char str[256];
> 
> -		ERR_error_string(ERR_get_error(), str);
> -		log_err("PEM_read_RSAPrivateKey() failed: %s\n", str);
> +		ERR_error_string(ERR_peek_error(), str);
> +		log_err("PEM_read_PrivateKey() failed: %s\n", str);
> +#ifdef USE_FPRINTF
> +		ERR_print_errors_fp(stderr);
> +#else
> +		ERR_clear_error();
> +#endif

Why is this additional print needed?  Are you expecting multiple
errors?  By calling both log_err() and ERR_print_errors_fp() won't the
same error message be duplicated?  If calling "ERR_print_errors_fp()"
is indeed needed, please make this change as a separate patch, with an
appropriate patch description.

>  	}
> 
>  	fclose(fp);
>  	return key;
>  }
> 
> +static RSA *read_priv_key(const char *keyfile, const char *keypass)
> +{
> +	EVP_PKEY *pkey;
> +	RSA *key;
> +
> +	pkey = read_priv_pkey(keyfile, keypass);
> +	if (!pkey)
> +		return NULL;
> +	key = EVP_PKEY_get1_RSA(pkey);
> +	EVP_PKEY_free(pkey);
> +	if (!key) {
> +		log_err("sign_hash_v1: unsupported key type\n");
> +		return NULL;
> +	}

At least at this point in the patch series, failing to get the private
key isn't limited to sign_hash_v1.  Perhaps that might be true later.

Mimi

> +	return key;
> +}
> +
>  static int get_hash_algo_v1(const char *algo)
>  {
> 

