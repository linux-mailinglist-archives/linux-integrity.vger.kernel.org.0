Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 90081224385
	for <lists+linux-integrity@lfdr.de>; Fri, 17 Jul 2020 20:57:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728413AbgGQS5A (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 17 Jul 2020 14:57:00 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:57062 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727821AbgGQS47 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 17 Jul 2020 14:56:59 -0400
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 06HIWhQw033275;
        Fri, 17 Jul 2020 14:56:50 -0400
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 32be11xkgx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 17 Jul 2020 14:56:50 -0400
Received: from m0098394.ppops.net (m0098394.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 06HIneYf130321;
        Fri, 17 Jul 2020 14:56:49 -0400
Received: from ppma04wdc.us.ibm.com (1a.90.2fa9.ip4.static.sl-reverse.com [169.47.144.26])
        by mx0a-001b2d01.pphosted.com with ESMTP id 32be11xkgd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 17 Jul 2020 14:56:49 -0400
Received: from pps.filterd (ppma04wdc.us.ibm.com [127.0.0.1])
        by ppma04wdc.us.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 06HIdMA6016127;
        Fri, 17 Jul 2020 18:56:48 GMT
Received: from b01cxnp23033.gho.pok.ibm.com (b01cxnp23033.gho.pok.ibm.com [9.57.198.28])
        by ppma04wdc.us.ibm.com with ESMTP id 327529k46e-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 17 Jul 2020 18:56:48 +0000
Received: from b01ledav001.gho.pok.ibm.com (b01ledav001.gho.pok.ibm.com [9.57.199.106])
        by b01cxnp23033.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 06HIulD116318894
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 17 Jul 2020 18:56:47 GMT
Received: from b01ledav001.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id A45AF28064;
        Fri, 17 Jul 2020 18:56:47 +0000 (GMT)
Received: from b01ledav001.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id C2D7128058;
        Fri, 17 Jul 2020 18:56:46 +0000 (GMT)
Received: from swastik.ibm.com (unknown [9.160.101.126])
        by b01ledav001.gho.pok.ibm.com (Postfix) with ESMTP;
        Fri, 17 Jul 2020 18:56:46 +0000 (GMT)
Subject: Re: [PATCH v3 06/12] ima: Fail rule parsing when the KEY_CHECK hook
 is combined with an invalid cond
To:     Tyler Hicks <tyhicks@linux.microsoft.com>
Cc:     Mimi Zohar <zohar@linux.ibm.com>,
        Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
        James Morris <jmorris@namei.org>,
        "Serge E . Hallyn" <serge@hallyn.com>,
        Lakshmi Ramasubramanian <nramas@linux.microsoft.com>,
        Prakhar Srivastava <prsriva02@gmail.com>,
        linux-kernel@vger.kernel.org, linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org
References: <20200709061911.954326-1-tyhicks@linux.microsoft.com>
 <20200709061911.954326-7-tyhicks@linux.microsoft.com>
From:   Nayna <nayna@linux.vnet.ibm.com>
Message-ID: <336cc947-1f70-0286-6506-6df3d1d23a1d@linux.vnet.ibm.com>
Date:   Fri, 17 Jul 2020 14:56:46 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <20200709061911.954326-7-tyhicks@linux.microsoft.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-07-17_09:2020-07-17,2020-07-17 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 bulkscore=0
 phishscore=0 clxscore=1015 mlxlogscore=999 impostorscore=0
 priorityscore=1501 lowpriorityscore=0 spamscore=0 suspectscore=0
 adultscore=0 malwarescore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2006250000 definitions=main-2007170129
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org


On 7/9/20 2:19 AM, Tyler Hicks wrote:
> The KEY_CHECK function only supports the uid, pcr, and keyrings
> conditionals. Make this clear at policy load so that IMA policy authors
> don't assume that other conditionals are supported.
>
> Fixes: 5808611cccb2 ("IMA: Add KEY_CHECK func to measure keys")
> Signed-off-by: Tyler Hicks <tyhicks@linux.microsoft.com>
> Reviewed-by: Lakshmi Ramasubramanian <nramas@linux.microsoft.com>
> ---
>
> * v3
>    - Added Lakshmi's Reviewed-by
>    - Adjust for the indentation change introduced in patch #4
> * v2
>    - No change
>
>   security/integrity/ima/ima_policy.c | 7 +++++++
>   1 file changed, 7 insertions(+)
>
> diff --git a/security/integrity/ima/ima_policy.c b/security/integrity/ima/ima_policy.c
> index 1c64bd6f1728..81da02071d41 100644
> --- a/security/integrity/ima/ima_policy.c
> +++ b/security/integrity/ima/ima_policy.c
> @@ -1023,6 +1023,13 @@ static bool ima_validate_rule(struct ima_rule_entry *entry)
>   		if (entry->action & ~(MEASURE | DONT_MEASURE))
>   			return false;
>
> +		if (entry->flags & ~(IMA_FUNC | IMA_UID | IMA_PCR |
> +				     IMA_KEYRINGS))
> +			return false;
> +
> +		if (ima_rule_contains_lsm_cond(entry))
> +			return false;
> +
>   		break;
>   	default:
>   		return false;

Should there be a check for IMA_MEASURE_ASYMMETRIC_KEYS in Opt_keyrings 
in ima_parse_rule() to return immediately if not enabled ?

Thanks & Regards,

      - Nayna


