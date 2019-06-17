Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3D72248414
	for <lists+linux-integrity@lfdr.de>; Mon, 17 Jun 2019 15:35:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725884AbfFQNd7 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 17 Jun 2019 09:33:59 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:49086 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726215AbfFQNd7 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 17 Jun 2019 09:33:59 -0400
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x5HDXmSf074439
        for <linux-integrity@vger.kernel.org>; Mon, 17 Jun 2019 09:33:57 -0400
Received: from e06smtp01.uk.ibm.com (e06smtp01.uk.ibm.com [195.75.94.97])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2t69mrx3tf-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-integrity@vger.kernel.org>; Mon, 17 Jun 2019 09:33:52 -0400
Received: from localhost
        by e06smtp01.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-integrity@vger.kernel.org> from <zohar@linux.ibm.com>;
        Mon, 17 Jun 2019 14:32:58 +0100
Received: from b06cxnps3074.portsmouth.uk.ibm.com (9.149.109.194)
        by e06smtp01.uk.ibm.com (192.168.101.131) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Mon, 17 Jun 2019 14:32:55 +0100
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (b06wcsmtp001.portsmouth.uk.ibm.com [9.149.105.160])
        by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x5HDWsOg55181414
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 17 Jun 2019 13:32:54 GMT
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 2B3C9A405C;
        Mon, 17 Jun 2019 13:32:54 +0000 (GMT)
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 7FB73A405B;
        Mon, 17 Jun 2019 13:32:53 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.80.81.90])
        by b06wcsmtp001.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Mon, 17 Jun 2019 13:32:53 +0000 (GMT)
Subject: Re: [PATCH v4 1/5] ima-avm-utils: Make sure sig buffer is always
 MAX_SIGNATURE_SIZE
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Vitaly Chikunov <vt@altlinux.org>,
        Mimi Zohar <zohar@linux.vnet.ibm.com>,
        Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
        linux-integrity@vger.kernel.org
Date:   Mon, 17 Jun 2019 09:32:42 -0400
In-Reply-To: <20190614015410.26039-2-vt@altlinux.org>
References: <20190614015410.26039-1-vt@altlinux.org>
         <20190614015410.26039-2-vt@altlinux.org>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.20.5 (3.20.5-1.fc24) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
x-cbid: 19061713-4275-0000-0000-000003430D96
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19061713-4276-0000-0000-0000385330CA
Message-Id: <1560778362.4072.77.camel@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-06-17_06:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1906170125
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Fri, 2019-06-14 at 04:54 +0300, Vitaly Chikunov wrote:
> Fix off-by-one error of the output buffer passed to sign_hash().
> 
> Signed-off-by: Vitaly Chikunov <vt@altlinux.org>
> ---
>  src/evmctl.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/src/evmctl.c b/src/evmctl.c
> index 15a7226..b6333bf 100644
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
> +	assert(len < MAX_SIGNATURE_SIZE);

Should this be "<="?

Mimi

>  	if (len <= 1)
>  		return len;
>  

