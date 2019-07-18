Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9F9736D737
	for <lists+linux-integrity@lfdr.de>; Fri, 19 Jul 2019 01:23:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728135AbfGRXXq (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 18 Jul 2019 19:23:46 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:22088 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727972AbfGRXXq (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 18 Jul 2019 19:23:46 -0400
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x6INLhxS092780
        for <linux-integrity@vger.kernel.org>; Thu, 18 Jul 2019 19:23:45 -0400
Received: from e06smtp04.uk.ibm.com (e06smtp04.uk.ibm.com [195.75.94.100])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2ttxpnyuex-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-integrity@vger.kernel.org>; Thu, 18 Jul 2019 19:23:45 -0400
Received: from localhost
        by e06smtp04.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-integrity@vger.kernel.org> from <zohar@linux.ibm.com>;
        Fri, 19 Jul 2019 00:23:43 +0100
Received: from b06cxnps4075.portsmouth.uk.ibm.com (9.149.109.197)
        by e06smtp04.uk.ibm.com (192.168.101.134) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Fri, 19 Jul 2019 00:23:40 +0100
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com [9.149.105.62])
        by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x6INNd0A38469688
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 18 Jul 2019 23:23:40 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id DBB03AE04D;
        Thu, 18 Jul 2019 23:23:39 +0000 (GMT)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 3D514AE045;
        Thu, 18 Jul 2019 23:23:39 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.80.110.122])
        by d06av26.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Thu, 18 Jul 2019 23:23:39 +0000 (GMT)
Subject: Re: [PATCH 2/3] ima-evm-utils: Remove not needed argument from
 verify_hash_v2
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Vitaly Chikunov <vt@altlinux.org>,
        Mimi Zohar <zohar@linux.vnet.ibm.com>,
        Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
        linux-integrity@vger.kernel.org
Date:   Thu, 18 Jul 2019 19:23:21 -0400
In-Reply-To: <20190718213510.10829-2-vt@altlinux.org>
References: <20190718213510.10829-1-vt@altlinux.org>
         <20190718213510.10829-2-vt@altlinux.org>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.20.5 (3.20.5-1.fc24) 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 19071823-0016-0000-0000-0000029423B5
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19071823-0017-0000-0000-000032F201FF
Message-Id: <1563492201.4539.339.camel@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-07-18_12:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=2 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1907180233
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Fri, 2019-07-19 at 00:35 +0300, Vitaly Chikunov wrote:
> Since we now always call verify_hash_v2() with NULL keyfile (assuming
> all keys are already loaded into public_keys list), remove keyfile
> argument and its handling from verify_hash_v2().
> 
> Signed-off-by: Vitaly Chikunov <vt@altlinux.org>

Thanks!

> ---
>  src/libimaevm.c | 21 +++++++--------------
>  1 file changed, 7 insertions(+), 14 deletions(-)
> 
> diff --git a/src/libimaevm.c b/src/libimaevm.c
> index 97b7167..b153f1b 100644
> --- a/src/libimaevm.c
> +++ b/src/libimaevm.c
> @@ -453,7 +453,7 @@ void init_public_keys(const char *keyfiles)
>   * Return: 0 verification good, 1 verification bad, -1 error.
>   */
>  int verify_hash_v2(const char *file, const unsigned char *hash, int size,
> -		   unsigned char *sig, int siglen, const char *keyfile)
> +		   unsigned char *sig, int siglen)
>  {

While making this change, could we also make both this and
verify_hash_v1() functions static?  Should I make the change?

Mimi

>  	int ret = -1;
>  	EVP_PKEY *pkey, *pkey_free = NULL;
> @@ -467,20 +467,13 @@ int verify_hash_v2(const char *file, const unsigned char *hash, int size,
>  		log_dump(hash, size);
>  	}
> 
> -	if (public_keys) {
> +	pkey = find_keyid(hdr->keyid);
> +	if (!pkey) {
>  		uint32_t keyid = hdr->keyid;
> 
> -		pkey = find_keyid(keyid);
> -		if (!pkey) {
> -			log_err("%s: unknown keyid: %x\n", file,
> -				__be32_to_cpup(&keyid));
> -			return -1;
> -		}
> -	} else {
> -		pkey = read_pub_pkey(keyfile, 1);
> -		if (!pkey)
> -			return -1;
> -		pkey_free = pkey;
> +		log_err("%s: unknown keyid: %x\n", file,
> +			__be32_to_cpup(&keyid));
> +		return -1;
>  	}
> 
>  	st = "EVP_PKEY_CTX_new";
> @@ -581,7 +574,7 @@ int verify_hash(const char *file, const unsigned char *hash, int size, unsigned
>  			key = "/etc/keys/pubkey_evm.pem";
>  		return verify_hash_v1(file, hash, size, sig, siglen, key);
>  	} else if (sig[0] == DIGSIG_VERSION_2) {
> -		return verify_hash_v2(file, hash, size, sig, siglen, NULL);
> +		return verify_hash_v2(file, hash, size, sig, siglen);
>  	} else
>  		return -1;
>  }

