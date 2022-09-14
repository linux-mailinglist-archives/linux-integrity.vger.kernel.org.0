Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 206025B901C
	for <lists+linux-integrity@lfdr.de>; Wed, 14 Sep 2022 23:30:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229521AbiINVay (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 14 Sep 2022 17:30:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229473AbiINVax (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 14 Sep 2022 17:30:53 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D741581B1B
        for <linux-integrity@vger.kernel.org>; Wed, 14 Sep 2022 14:30:52 -0700 (PDT)
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 28EKULHA020444;
        Wed, 14 Sep 2022 21:30:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=CzA7nmemYBej1xbNL/lDM6Vgq7Bk5gWFqtZt6i1SSd0=;
 b=IuGFwUPu4Pg9sGqt8d1IcuMw5/dg2x72OTc1xqa59n1do+CBZRphLO9Mj0wxcPKECPqJ
 /mMonez5mIL/XEc+Zl4RSpLsSa0zCh22ozy1j+dVDM2sVb1mXjEHhlZwB/rUBxpaEPay
 9OT4i/11/q3ap22Bw5yvIUt1Nn53Q7WeKZGSx88TVWlGzndSGC1eh7bNDinkPpNPOQBM
 A/tJ4zwjXE+QlD3r5neoSDJUDVmONL8Ho8IVQ8Eedh/DxYRYDqxCzTZ3COHPHoPFthk3
 WSoL2HJaNXF4ykvUUIizkCOQsivozKkrbk8f7dIS8lD3X6AxdQYkIaDmi7udh+zFS1ge qQ== 
Received: from ppma01wdc.us.ibm.com (fd.55.37a9.ip4.static.sl-reverse.com [169.55.85.253])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3jkm0957vw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 14 Sep 2022 21:30:49 +0000
Received: from pps.filterd (ppma01wdc.us.ibm.com [127.0.0.1])
        by ppma01wdc.us.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 28ELLiCv015068;
        Wed, 14 Sep 2022 21:30:48 GMT
Received: from b03cxnp08028.gho.boulder.ibm.com (b03cxnp08028.gho.boulder.ibm.com [9.17.130.20])
        by ppma01wdc.us.ibm.com with ESMTP id 3jjypu71qa-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 14 Sep 2022 21:30:48 +0000
Received: from b03ledav002.gho.boulder.ibm.com (b03ledav002.gho.boulder.ibm.com [9.17.130.233])
        by b03cxnp08028.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 28ELUmNA64225618
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 14 Sep 2022 21:30:48 GMT
Received: from b03ledav002.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 144CD136053;
        Wed, 14 Sep 2022 21:30:47 +0000 (GMT)
Received: from b03ledav002.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id C00AA13604F;
        Wed, 14 Sep 2022 21:30:46 +0000 (GMT)
Received: from [9.47.158.152] (unknown [9.47.158.152])
        by b03ledav002.gho.boulder.ibm.com (Postfix) with ESMTP;
        Wed, 14 Sep 2022 21:30:46 +0000 (GMT)
Message-ID: <4da20657-7ee0-1cb0-72f7-53497b33cc34@linux.ibm.com>
Date:   Wed, 14 Sep 2022 17:30:46 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: [PATCH ima-evm-utils 1/4] Don't ignore number of items read
Content-Language: en-US
To:     Mimi Zohar <zohar@linux.ibm.com>, linux-integrity@vger.kernel.org
Cc:     Petr Vorel <pvorel@suse.cz>
References: <20220914142225.1381077-1-zohar@linux.ibm.com>
 <20220914142225.1381077-2-zohar@linux.ibm.com>
From:   Stefan Berger <stefanb@linux.ibm.com>
In-Reply-To: <20220914142225.1381077-2-zohar@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: __16dw9ix5xft_dFsH94eXOtR-KRE4SN
X-Proofpoint-ORIG-GUID: __16dw9ix5xft_dFsH94eXOtR-KRE4SN
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-09-14_09,2022-09-14_04,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 impostorscore=0
 adultscore=0 mlxscore=0 mlxlogscore=999 spamscore=0 priorityscore=1501
 bulkscore=0 malwarescore=0 phishscore=0 lowpriorityscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2208220000
 definitions=main-2209140101
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org



On 9/14/22 10:22, Mimi Zohar wrote:
> fread() either returns the number of bytes read or the number of items
> of data read.  Check that it returns the requested number of items read.
> 
> Signed-off-by: Mimi Zohar <zohar@linux.ibm.com>
> ---
>   src/evmctl.c | 12 +++++++-----
>   1 file changed, 7 insertions(+), 5 deletions(-)
> 
> diff --git a/src/evmctl.c b/src/evmctl.c
> index 2e21da67c444..bcf724c828f7 100644
> --- a/src/evmctl.c
> +++ b/src/evmctl.c
> @@ -2161,7 +2161,7 @@ static int ima_measurement(const char *file)
>   		}
>   
>   		memset(entry.name, 0x00, sizeof(entry.name));
> -		if (!fread(entry.name, entry.header.name_len, 1, fp)) {
> +		if (fread(entry.name, entry.header.name_len, 1, fp) != 1) {
>   			log_err("Unable to read template name\n");
>   			goto out;
>   		}
> @@ -2184,8 +2184,8 @@ static int ima_measurement(const char *file)
>   
>   		/* The "ima" template data is not length prefixed.  Skip it. */
>   		if (!is_ima_template) {
> -			if (!fread(&entry.template_len,
> -				   sizeof(entry.template_len), 1, fp)) {
> +			if (fread(&entry.template_len,
> +				  sizeof(entry.template_len), 1, fp) != 1) {
>   				log_err("Unable to read template length\n");
>   				goto out;
>   			}
> @@ -2205,7 +2205,8 @@ static int ima_measurement(const char *file)
>   		}
>   
>   		if (!is_ima_template) {
> -			if (!fread(entry.template, entry.template_len, 1, fp)) {
> +			if (fread(entry.template, entry.template_len,
> +				  1, fp) != 1) {
>   				log_errno("Unable to read template\n");
>   				goto out;
>   			}
> @@ -2217,7 +2218,8 @@ static int ima_measurement(const char *file)
>   			 * The "ima" template data format is digest,
>   			 * filename length, filename.
>   			 */
> -			if (!fread(entry.template, SHA_DIGEST_LENGTH, 1, fp)) {
> +			if (fread(entry.template, SHA_DIGEST_LENGTH,
> +				  1, fp) != 1) {
>   				log_errno("Unable to read file data hash\n");
>   				goto out;
>   			}

It was correct before as well ...

Reviewed-by: Stefan Berger <stefanb@linux.ibm.com>
