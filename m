Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5F427741FE
	for <lists+linux-integrity@lfdr.de>; Thu, 25 Jul 2019 01:24:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387535AbfGXXYj (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 24 Jul 2019 19:24:39 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:51184 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S2387494AbfGXXYj (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 24 Jul 2019 19:24:39 -0400
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x6ONOHJ3042388
        for <linux-integrity@vger.kernel.org>; Wed, 24 Jul 2019 19:24:38 -0400
Received: from e06smtp01.uk.ibm.com (e06smtp01.uk.ibm.com [195.75.94.97])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2txyrp2ed4-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-integrity@vger.kernel.org>; Wed, 24 Jul 2019 19:24:37 -0400
Received: from localhost
        by e06smtp01.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-integrity@vger.kernel.org> from <zohar@linux.ibm.com>;
        Thu, 25 Jul 2019 00:24:36 +0100
Received: from b06cxnps3074.portsmouth.uk.ibm.com (9.149.109.194)
        by e06smtp01.uk.ibm.com (192.168.101.131) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Thu, 25 Jul 2019 00:24:33 +0100
Received: from d06av24.portsmouth.uk.ibm.com (d06av24.portsmouth.uk.ibm.com [9.149.105.60])
        by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x6ONOVWe49938642
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 24 Jul 2019 23:24:32 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id E098E42041;
        Wed, 24 Jul 2019 23:24:31 +0000 (GMT)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 4273A42042;
        Wed, 24 Jul 2019 23:24:31 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.80.82.197])
        by d06av24.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Wed, 24 Jul 2019 23:24:31 +0000 (GMT)
Subject: Re: [PATCH] ima-evm-utils: Namespace some too generic function names
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Vitaly Chikunov <vt@altlinux.org>,
        Mimi Zohar <zohar@linux.vnet.ibm.com>,
        Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
        linux-integrity@vger.kernel.org
Date:   Wed, 24 Jul 2019 19:24:20 -0400
In-Reply-To: <20190724204204.25383-1-vt@altlinux.org>
References: <20190724204204.25383-1-vt@altlinux.org>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.20.5 (3.20.5-1.fc24) 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 19072423-4275-0000-0000-0000035044BC
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19072423-4276-0000-0000-000038606E70
Message-Id: <1564010660.4245.76.camel@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-07-24_09:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1906280000 definitions=main-1907240252
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Wed, 2019-07-24 at 23:42 +0300, Vitaly Chikunov wrote:
> Prefix `dump', `do_dump', and `params' with `ima_' to avoid colliding
> with other global symbols.

The package is named ima-evm-utils, the tool is named evmctl, and now
we're prefixing the global symbols with "ima".  Some of the functions,
like dump(), are used by both "ima" and "evm".  Aiming for some sort
of consistency, maybe it should be prefixed with "ima_evm", not just
"ima_"? 

dump() should never have been named just "dump".  It should have at
least been named "hexdump".
 
> 
> `params' is prefixed with a #define trick to avoid change in half
> hundred places.

Perhaps separate this change from the other change?

thanks,

Mimi
  
> 
> Signed-off-by: Vitaly Chikunov <vt@altlinux.org>
> ---
> 
> I think all other exported functions (good example is verify_hash) should be
> prefixed too.
> 
>  src/evmctl.c    | 6 +++---
>  src/imaevm.h    | 9 ++++++---
>  src/libimaevm.c | 6 +++---
>  3 files changed, 12 insertions(+), 9 deletions(-)
> 
> diff --git a/src/evmctl.c b/src/evmctl.c
> index 3289061..b2e5af5 100644
> --- a/src/evmctl.c
> +++ b/src/evmctl.c
> @@ -565,7 +565,7 @@ static int sign_evm(const char *file, const char *key)
>  		sig[1] = 3; /* immutable signature version */
> 
>  	if (sigdump || params.verbose >= LOG_INFO)
> -		dump(sig, len);
> +		ima_dump(sig, len);
> 
>  	if (xattr) {
>  		err = lsetxattr(file, xattr_evm, sig, len, 0);
> @@ -604,7 +604,7 @@ static int hash_ima(const char *file)
>  		log_info("hash: ");
> 
>  	if (sigdump || params.verbose >= LOG_INFO)
> -		dump(hash, len);
> +		ima_dump(hash, len);
> 
>  	if (xattr) {
>  		err = lsetxattr(file, xattr_ima, hash, len, 0);
> @@ -638,7 +638,7 @@ static int sign_ima(const char *file, const char *key)
>  	sig[0] = EVM_IMA_XATTR_DIGSIG;
> 
>  	if (sigdump || params.verbose >= LOG_INFO)
> -		dump(sig, len);
> +		ima_dump(sig, len);
> 
>  	if (sigfile)
>  		bin2file(file, "sig", sig, len);
> diff --git a/src/imaevm.h b/src/imaevm.h
> index 0414433..d00922c 100644
> --- a/src/imaevm.h
> +++ b/src/imaevm.h
> @@ -49,9 +49,12 @@
> 
>  #include <openssl/rsa.h>
> 
> +/* Namespace some internal symbols */
> +#define params		ima_params
> +
>  #ifdef USE_FPRINTF
>  #define do_log(level, fmt, args...)	({ if (level <= params.verbose) fprintf(stderr, fmt, ##args); })
> -#define do_log_dump(level, p, len, cr)	({ if (level <= params.verbose) do_dump(stderr, p, len, cr); })
> +#define do_log_dump(level, p, len, cr)	({ if (level <= params.verbose) ima_do_dump(stderr, p, len, cr); })
>  #else
>  #define do_log(level, fmt, args...)	syslog(level, fmt, ##args)
>  #define do_log_dump(level, p, len, cr)
> @@ -206,8 +209,8 @@ struct RSA_ASN1_template {
> 
>  extern struct libevm_params params;
> 
> -void do_dump(FILE *fp, const void *ptr, int len, bool cr);
> -void dump(const void *ptr, int len);
> +void ima_do_dump(FILE *fp, const void *ptr, int len, bool cr);
> +void ima_dump(const void *ptr, int len);
>  int ima_calc_hash(const char *file, uint8_t *hash);
>  int get_hash_algo(const char *algo);
>  RSA *read_pub_key(const char *keyfile, int x509);
> diff --git a/src/libimaevm.c b/src/libimaevm.c
> index 2d99570..afa978f 100644
> --- a/src/libimaevm.c
> +++ b/src/libimaevm.c
> @@ -89,7 +89,7 @@ struct libevm_params params = {
> 
>  static void __attribute__ ((constructor)) libinit(void);
> 
> -void do_dump(FILE *fp, const void *ptr, int len, bool cr)
> +void ima_do_dump(FILE *fp, const void *ptr, int len, bool cr)
>  {
>  	int i;
>  	uint8_t *data = (uint8_t *) ptr;
> @@ -100,9 +100,9 @@ void do_dump(FILE *fp, const void *ptr, int len, bool cr)
>  		fprintf(fp, "\n");
>  }
> 
> -void dump(const void *ptr, int len)
> +void ima_dump(const void *ptr, int len)
>  {
> -	do_dump(stdout, ptr, len, true);
> +	ima_do_dump(stdout, ptr, len, true);
>  }
> 
>  const char *get_hash_algo_by_id(int algo)

