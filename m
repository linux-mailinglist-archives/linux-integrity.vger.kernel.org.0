Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 277A66156B3
	for <lists+linux-integrity@lfdr.de>; Wed,  2 Nov 2022 01:45:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229742AbiKBApU (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 1 Nov 2022 20:45:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230155AbiKBApF (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 1 Nov 2022 20:45:05 -0400
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1968A18E31
        for <linux-integrity@vger.kernel.org>; Tue,  1 Nov 2022 17:44:53 -0700 (PDT)
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 2A20b7Dx001043;
        Wed, 2 Nov 2022 00:44:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=TEUGjMVeI2CyKiI4C8vGrKe/QFmzkOb9syxZARTd8CU=;
 b=sumRRY5t+i0xJucfoCxtJ07XGlKsQy9fGv8rBkXCQfs1L5YV+VvHXHnJo/fdEG2Zn2vu
 mo+mKJqdILQhtbQXPCOq+QAcUSfykquoVWNn13Po6W5aIRZ6liO3XiFJKkz7WiuumjWY
 pF9C6lCrnTPuuczYgtq2u9RgBI+6Hsw+QqmVYhD7RsJ7qqul3Fjp0GRMo90PMehwUnXn
 ruTsXcB1TqWNxBum1ZFHYp2H0aEcNvDqOezzIdzJOPgzY2OTs06N3i9k1Q4/WUet/3Al
 tYm0TN//uHRFVnYqwTHdwM0bF/fGz1ejVliQ5GQAWvxJg4uDnNfVHN4A2ZRpQdGMsMaq dA== 
Received: from ppma05wdc.us.ibm.com (1b.90.2fa9.ip4.static.sl-reverse.com [169.47.144.27])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3kjwjjt4j9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 02 Nov 2022 00:44:48 +0000
Received: from pps.filterd (ppma05wdc.us.ibm.com [127.0.0.1])
        by ppma05wdc.us.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 2A20bF4g028519;
        Wed, 2 Nov 2022 00:44:48 GMT
Received: from b01cxnp23034.gho.pok.ibm.com (b01cxnp23034.gho.pok.ibm.com [9.57.198.29])
        by ppma05wdc.us.ibm.com with ESMTP id 3kgut9qejh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 02 Nov 2022 00:44:48 +0000
Received: from smtpav06.wdc07v.mail.ibm.com ([9.208.128.115])
        by b01cxnp23034.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 2A20ilg664880986
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 2 Nov 2022 00:44:47 GMT
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id E4E4E5806D;
        Wed,  2 Nov 2022 00:44:46 +0000 (GMT)
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 682A458066;
        Wed,  2 Nov 2022 00:44:46 +0000 (GMT)
Received: from [9.47.158.152] (unknown [9.47.158.152])
        by smtpav06.wdc07v.mail.ibm.com (Postfix) with ESMTP;
        Wed,  2 Nov 2022 00:44:46 +0000 (GMT)
Message-ID: <7bf680af-5778-528d-0bbc-c96df707bbea@linux.ibm.com>
Date:   Tue, 1 Nov 2022 20:44:45 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: [PATCH ima-evm-utils v4 17/17] Fix d2i_x509_fp failure
Content-Language: en-US
To:     Mimi Zohar <zohar@linux.ibm.com>, linux-integrity@vger.kernel.org
Cc:     Petr Vorel <pvorel@suse.cz>, Vitaly Chikunov <vt@altlinux.org>
References: <20221101201803.372652-1-zohar@linux.ibm.com>
 <20221101201803.372652-18-zohar@linux.ibm.com>
From:   Stefan Berger <stefanb@linux.ibm.com>
In-Reply-To: <20221101201803.372652-18-zohar@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: rm3omQSPLQTRvzSZKT2JtK5ux8AVe2ap
X-Proofpoint-GUID: rm3omQSPLQTRvzSZKT2JtK5ux8AVe2ap
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-11-01_12,2022-11-01_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 mlxlogscore=999
 spamscore=0 bulkscore=0 priorityscore=1501 phishscore=0 clxscore=1015
 malwarescore=0 lowpriorityscore=0 adultscore=0 impostorscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2210170000 definitions=main-2211020000
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org



On 11/1/22 16:18, Mimi Zohar wrote:
> Before calling d2i_x509_fp(), make sure the keyfile is a regular file.
> 
> Signed-off-by: Mimi Zohar <zohar@linux.ibm.com>
> ---
>   src/libimaevm.c | 11 +++++++++++
>   1 file changed, 11 insertions(+)
> 
> diff --git a/src/libimaevm.c b/src/libimaevm.c
> index 8070ffd61a2c..e6fbec5bc17b 100644
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
> @@ -262,6 +263,16 @@ EVP_PKEY *read_pub_pkey(const char *keyfile, int x509)
>   	}
>   
>   	if (x509) {
> +		if (fstat(fileno(fp), &st) == -1)
> +			goto out;
> +

If this was to ever happen evmctl may just terminate without an error message.

> +		if ((st.st_mode & S_IFMT) != S_IFREG) {

This function can also read plain public keys in the else branch. Should this test cover both cases?



> +			if (imaevm_params.verbose > LOG_INFO)
> +				log_err("Keyfile is not regular file: %s\n",
> +					 keyfile);
> +			goto out;
> +		}
> +
>   		X509 *crt = d2i_X509_fp(fp, NULL);
>   
>   		if (!crt) {
