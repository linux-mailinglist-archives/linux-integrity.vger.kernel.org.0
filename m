Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E0844618AEB
	for <lists+linux-integrity@lfdr.de>; Thu,  3 Nov 2022 22:57:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229501AbiKCV5e (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 3 Nov 2022 17:57:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230306AbiKCV5b (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 3 Nov 2022 17:57:31 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8EA912250B
        for <linux-integrity@vger.kernel.org>; Thu,  3 Nov 2022 14:57:28 -0700 (PDT)
Received: from pps.filterd (m0187473.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 2A3K2SSD012919;
        Thu, 3 Nov 2022 21:57:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=tvecr0wzfa7fCbpIj37pcJG6ZOtRJfE5JMqH7IzKTnQ=;
 b=kVmPGqEvBZS0dUtpX0qUoJcv62cEiKT2CqBNFHXwkzSWsvEqSNoajx5l8vh5FVJ6Uogc
 7jstqBAL0sMAs84oP70fo6Jem4xMnCoEUCSCxMd4zqgJpMTuRXJM0oxnBNis+aM3+kS5
 HAK6mlgOfr/x5z+MjN+3sIlD6qcN3l4nNqW+Hzargzw9npQaLdUU03nf3BBeFJSMV0Hk
 vnFK7Jk8U6sODCtNfg0ltSvU9/NlPCmlsVg28agmiomLK4Op3QPug5w2F8pIzGZy8fmO
 gDoiXEu7PQkJADHvg5YT02pSngd68aVdD7y+xQv6LpxXVYcDLuLjw2RZHa8JSlz5FRX/ Aw== 
Received: from ppma04dal.us.ibm.com (7a.29.35a9.ip4.static.sl-reverse.com [169.53.41.122])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3kme16jjwd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 03 Nov 2022 21:57:23 +0000
Received: from pps.filterd (ppma04dal.us.ibm.com [127.0.0.1])
        by ppma04dal.us.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 2A3Lona7027413;
        Thu, 3 Nov 2022 21:57:22 GMT
Received: from b01cxnp23032.gho.pok.ibm.com (b01cxnp23032.gho.pok.ibm.com [9.57.198.27])
        by ppma04dal.us.ibm.com with ESMTP id 3kgutan4dn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 03 Nov 2022 21:57:22 +0000
Received: from smtpav05.wdc07v.mail.ibm.com ([9.208.128.117])
        by b01cxnp23032.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 2A3LvL0D66322786
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 3 Nov 2022 21:57:22 GMT
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 4D4E558043;
        Thu,  3 Nov 2022 21:57:21 +0000 (GMT)
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 9766358059;
        Thu,  3 Nov 2022 21:57:20 +0000 (GMT)
Received: from [9.47.158.152] (unknown [9.47.158.152])
        by smtpav05.wdc07v.mail.ibm.com (Postfix) with ESMTP;
        Thu,  3 Nov 2022 21:57:20 +0000 (GMT)
Message-ID: <1edd3194-2180-1ae9-4d79-ca9a9976c3a3@linux.ibm.com>
Date:   Thu, 3 Nov 2022 17:57:20 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: [PATCH ima-evm-utils v5 17/17] Make sure the key file is a
 regular file
Content-Language: en-US
To:     Mimi Zohar <zohar@linux.ibm.com>, linux-integrity@vger.kernel.org
Cc:     Petr Vorel <pvorel@suse.cz>, Vitaly Chikunov <vt@altlinux.org>
References: <20221103183904.103562-1-zohar@linux.ibm.com>
 <20221103183904.103562-18-zohar@linux.ibm.com>
From:   Stefan Berger <stefanb@linux.ibm.com>
In-Reply-To: <20221103183904.103562-18-zohar@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: oNuNECkZk7o1oZCgIrDhmAH3ZcFG3iAw
X-Proofpoint-ORIG-GUID: oNuNECkZk7o1oZCgIrDhmAH3ZcFG3iAw
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-11-03_04,2022-11-03_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 suspectscore=0
 mlxscore=0 phishscore=0 lowpriorityscore=0 mlxlogscore=999 bulkscore=0
 clxscore=1015 adultscore=0 priorityscore=1501 impostorscore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2210170000
 definitions=main-2211030147
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org



On 11/3/22 14:39, Mimi Zohar wrote:
> Before attempting to use the key file, make sure it is a regular file.
> 
> Signed-off-by: Mimi Zohar <zohar@linux.ibm.com>
> ---
>   src/libimaevm.c | 12 ++++++++++++
>   1 file changed, 12 insertions(+)
> 
> diff --git a/src/libimaevm.c b/src/libimaevm.c
> index 8070ffd61a2c..c09ed98fe508 100644
> --- a/src/libimaevm.c
> +++ b/src/libimaevm.c
> @@ -250,6 +250,7 @@ EVP_PKEY *read_pub_pkey(const char *keyfile, int x509)
>   {
>   	FILE *fp;
>   	EVP_PKEY *pkey = NULL;
> +	struct stat st;
>   
>   	if (!keyfile)
>   		return NULL;
> @@ -261,6 +262,17 @@ EVP_PKEY *read_pub_pkey(const char *keyfile, int x509)
>   		return NULL;
>   	}
>   
> +	if (fstat(fileno(fp), &st) == -1) {
> +		log_err("Failed to fstat key file: %s\n", keyfile);

no errno reset needed here I guess...

> +		goto out;
> +	}
> +
> +	if ((st.st_mode & S_IFMT) != S_IFREG) {
> +		if (imaevm_params.verbose > LOG_INFO)
> +			log_err("Key file is not regular file: %s\n", keyfile);
> +		goto out;
> +	}
> +
>   	if (x509) {
>   		X509 *crt = d2i_X509_fp(fp, NULL);
>   

Reviewed-by: Stefan Berger <stefanb@linux.ibm.com>
