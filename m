Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7FEAC4DCF0
	for <lists+linux-integrity@lfdr.de>; Thu, 20 Jun 2019 23:42:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726351AbfFTVmg (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 20 Jun 2019 17:42:36 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:40726 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725911AbfFTVmg (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 20 Jun 2019 17:42:36 -0400
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x5KLfgD3009487
        for <linux-integrity@vger.kernel.org>; Thu, 20 Jun 2019 17:42:34 -0400
Received: from e06smtp03.uk.ibm.com (e06smtp03.uk.ibm.com [195.75.94.99])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2t8ht30yjg-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-integrity@vger.kernel.org>; Thu, 20 Jun 2019 17:42:34 -0400
Received: from localhost
        by e06smtp03.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-integrity@vger.kernel.org> from <zohar@linux.ibm.com>;
        Thu, 20 Jun 2019 22:42:32 +0100
Received: from b06avi18878370.portsmouth.uk.ibm.com (9.149.26.194)
        by e06smtp03.uk.ibm.com (192.168.101.133) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Thu, 20 Jun 2019 22:42:31 +0100
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com [9.149.105.62])
        by b06avi18878370.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x5KLgUR334406886
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 20 Jun 2019 21:42:30 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 1438EAE045;
        Thu, 20 Jun 2019 21:42:30 +0000 (GMT)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 47BCCAE04D;
        Thu, 20 Jun 2019 21:42:29 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.80.81.152])
        by d06av26.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Thu, 20 Jun 2019 21:42:29 +0000 (GMT)
Subject: Re: [PATCH v5 01/11] ima-evm-utils: Make sure sig buffer is always
 MAX_SIGNATURE_SIZE
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Vitaly Chikunov <vt@altlinux.org>,
        Mimi Zohar <zohar@linux.vnet.ibm.com>,
        Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
        linux-integrity@vger.kernel.org
Date:   Thu, 20 Jun 2019 17:42:18 -0400
In-Reply-To: <20190618135623.6861-2-vt@altlinux.org>
References: <20190618135623.6861-1-vt@altlinux.org>
         <20190618135623.6861-2-vt@altlinux.org>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.20.5 (3.20.5-1.fc24) 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 19062021-0012-0000-0000-0000032AFB40
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19062021-0013-0000-0000-0000216422E6
Message-Id: <1561066938.4057.18.camel@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-06-20_14:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1906200155
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Tue, 2019-06-18 at 16:56 +0300, Vitaly Chikunov wrote:
> Fix off-by-one error of the output buffer passed to sign_hash().
> 
> Signed-off-by: Vitaly Chikunov <vt@altlinux.org>
> ---
>  src/evmctl.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/src/evmctl.c b/src/evmctl.c
> index 15a7226..03f41fe 100644
> --- a/src/evmctl.c
> +++ b/src/evmctl.c
> @@ -510,7 +510,7 @@ static int calc_evm_hash(const char *file, unsigned char *hash)
>  static int sign_evm(const char *file, const char *key)
>  {
>  	unsigned char hash[MAX_DIGEST_SIZE];
> -	unsigned char sig[MAX_SIGNATURE_SIZE];
> +	unsigned char sig[MAX_SIGNATURE_SIZE + 1];
>  	int len, err;
> 
>  	len = calc_evm_hash(file, hash);
> @@ -519,7 +519,7 @@ static int sign_evm(const char *file, const char *key)
>  		return len;
> 
>  	len = sign_hash(params.hash_algo, hash, len, key, NULL, sig + 1);
> -	assert(len < sizeof(sig));
> +	assert(len <= MAX_SIGNATURE_SIZE);
>  	if (len <= 1)
>  		return len;
> 

A similar problem occurs in sign_ima.  Without these changes
sign_hash() succeeds, returning a length of 520 for
sha256/streebog256.  With these patches, for streebog256
EVP_PKEY_CTX_set_signature_md is failing, returning -1, but works for
sha256.  With a similar change as this patch, it also works, returning
520.

Obviously it isn't an issue of the buffer size.

Mimi

