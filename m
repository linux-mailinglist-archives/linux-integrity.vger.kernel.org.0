Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F029A5B9014
	for <lists+linux-integrity@lfdr.de>; Wed, 14 Sep 2022 23:25:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229812AbiINVZg (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 14 Sep 2022 17:25:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229808AbiINVZd (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 14 Sep 2022 17:25:33 -0400
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13DAC65671
        for <linux-integrity@vger.kernel.org>; Wed, 14 Sep 2022 14:25:30 -0700 (PDT)
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 28EKmjv3017076;
        Wed, 14 Sep 2022 21:25:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=Uoo46dihfrU2KdRPwbD5ICiz2dteJ1weruqQzh/j5NU=;
 b=G8jzba1QVCaTVQ74j1DaPR52n4AlqYitKGyVlBSnETIhwsqS4S6C6g6zjmdDo6jfr/M/
 sQiE9MNDi0C4OS66D5rDYV8at7drAE38uy62/p9oaKV++ciHbS6eS8+9/1tfFm8GDJGQ
 hyb2uBVdk9pN1oQw17wj3P+VgOwHLFhiZfO+S5Vukm5uoyhQEOK5AWpag4o5FEkpEfCm
 dHhPNoT+YSba53SXsR+P8u8gVGM29rYHV0VWkrztNmkPKTHTRrTLNNWEfLHA4zLMSNts
 +IQzAhV8yrfDU2TfocNOYHTlwkcMbrEMGrhGTXWC52d04hYOLhArFlcgT8ta4yBEYokF 9Q== 
Received: from ppma02wdc.us.ibm.com (aa.5b.37a9.ip4.static.sl-reverse.com [169.55.91.170])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3jkpat0sw9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 14 Sep 2022 21:25:28 +0000
Received: from pps.filterd (ppma02wdc.us.ibm.com [127.0.0.1])
        by ppma02wdc.us.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 28ELLJgf024528;
        Wed, 14 Sep 2022 21:25:27 GMT
Received: from b01cxnp22036.gho.pok.ibm.com (b01cxnp22036.gho.pok.ibm.com [9.57.198.26])
        by ppma02wdc.us.ibm.com with ESMTP id 3jjy6jy66u-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 14 Sep 2022 21:25:27 +0000
Received: from b01ledav006.gho.pok.ibm.com (b01ledav006.gho.pok.ibm.com [9.57.199.111])
        by b01cxnp22036.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 28ELPQod28901650
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 14 Sep 2022 21:25:26 GMT
Received: from b01ledav006.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id C82CDAC059;
        Wed, 14 Sep 2022 21:25:26 +0000 (GMT)
Received: from b01ledav006.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 8F1FFAC05B;
        Wed, 14 Sep 2022 21:25:26 +0000 (GMT)
Received: from [9.47.158.152] (unknown [9.47.158.152])
        by b01ledav006.gho.pok.ibm.com (Postfix) with ESMTP;
        Wed, 14 Sep 2022 21:25:26 +0000 (GMT)
Message-ID: <73128146-5d00-dfe3-7a22-9f798a4989b1@linux.ibm.com>
Date:   Wed, 14 Sep 2022 17:25:26 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: [PATCH ima-evm-utils 3/4] Sanity check the template data field
 sizes
Content-Language: en-US
To:     Mimi Zohar <zohar@linux.ibm.com>, linux-integrity@vger.kernel.org
Cc:     Petr Vorel <pvorel@suse.cz>
References: <20220914142225.1381077-1-zohar@linux.ibm.com>
 <20220914142225.1381077-4-zohar@linux.ibm.com>
From:   Stefan Berger <stefanb@linux.ibm.com>
In-Reply-To: <20220914142225.1381077-4-zohar@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: si_KM4C2xGVwO-VrxvCmL5DK-gC_bbup
X-Proofpoint-GUID: si_KM4C2xGVwO-VrxvCmL5DK-gC_bbup
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-09-14_09,2022-09-14_04,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 impostorscore=0
 bulkscore=0 spamscore=0 suspectscore=0 malwarescore=0 lowpriorityscore=0
 mlxscore=0 priorityscore=1501 mlxlogscore=999 phishscore=0 clxscore=1015
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
> The field sizes of the original "ima" template data are static, but
> the other template data fields are not.  They're prefixed with a size.
> 
> Add some data field size sanity checks in ima_show_ng().
> 
> Signed-off-by: Mimi Zohar <zohar@linux.ibm.com>
> ---
>   src/evmctl.c | 42 ++++++++++++++++++++++++++++++++++++++++--
>   1 file changed, 40 insertions(+), 2 deletions(-)
> 
> diff --git a/src/evmctl.c b/src/evmctl.c
> index 9ab804fee37a..4a071143679e 100644
> --- a/src/evmctl.c
> +++ b/src/evmctl.c
> @@ -1591,8 +1591,9 @@ void ima_ng_show(struct template_entry *entry)
>   {
>   	uint8_t *fieldp = entry->template;
>   	uint32_t field_len;
> -	int total_len = entry->template_len, digest_len, len, sig_len, fbuf_len;
> +	int total_len = entry->template_len, digest_len, len, fbuf_len;
>   	uint8_t *digest, *sig = NULL, *fbuf = NULL;
> +	int sig_len = 0;
>   	char *algo, *path;
>   	int found;
>   	int err;
> @@ -1601,33 +1602,65 @@ void ima_ng_show(struct template_entry *entry)
>   	field_len = *(uint32_t *)fieldp;
>   	fieldp += sizeof(field_len);
>   	total_len -= sizeof(field_len);
> +	if (total_len < 0) {
> +		log_err("Template \"%s\" invalid template data\n", entry->name);
> +		return;
> +	}
>   
>   	algo = (char *)fieldp;
>   	len = strnlen(algo, field_len - 1) + 1;
>   	digest_len = field_len - len;
> +	if (digest_len < SHA_DIGEST_LENGTH ||
> +	    digest_len > MAX_DIGEST_SIZE) {
> +		log_err("Template \"%s\" invalid digest length\n", entry->name);
> +		return;
> +	}
>   	digest = fieldp + len;
>   
>   	/* move to next field */
>   	fieldp += field_len;
>   	total_len -= field_len;
> +	if (total_len < 0) {
> +		log_err("Template \"%s\" invalid template data\n", entry->name);
> +		return;
> +	}
>   
>   	/* get path */
>   	field_len = *(uint32_t *)fieldp;
>   	fieldp += sizeof(field_len);
>   	total_len -= sizeof(field_len);
> +	if (field_len == 0 || field_len > PATH_MAX || total_len < field_len) {
> +		log_err("Template \"%s\" invalid file pathname\n", entry->name);
> +		return;
> +	}
>   
>   	path = (char *)fieldp;
>   
>   	/* move to next field */
>   	fieldp += field_len;
>   	total_len -= field_len;
> +	if (total_len < 0) {
> +		log_err("Template \"%s\" invalid template data\n", entry->name);
> +		return;
> +	}
>   
>   	if (!strcmp(entry->name, "ima-sig") ||
>   	    !strcmp(entry->name, "ima-sigv2")) {
> -		/* get signature */
> +		/* get signature, if it exists */
>   		field_len = *(uint32_t *)fieldp;
>   		fieldp += sizeof(field_len);
> +		if (field_len > MAX_SIGNATURE_SIZE) {
> +			log_err("Template \"%s\" invalid file signature size\n",
> +				entry->name);
> +			return;
> +		}
> +
>   		total_len -= sizeof(field_len);
> +		if (total_len < 0) {
> +			log_err("Template \"%s\" invalid template data\n",
> +				entry->name);
> +			return;
> +		}
>   
>   		if (field_len) {
>   			sig = fieldp;
> @@ -1651,6 +1684,11 @@ void ima_ng_show(struct template_entry *entry)
>   		}
>   	}
>   
> +	if (total_len < 0) {
> +		log_err("Template \"%s\" invalid template data\n", entry->name);
> +		return;
> +	}
> +
>   	/* ascii_runtime_measurements */
>   	if (imaevm_params.verbose > LOG_INFO) {
>   		log_info("%d ", entry->header.pcr);

Reviewed-by: Stefan Berger <stefanb@linux.ibm.com>
