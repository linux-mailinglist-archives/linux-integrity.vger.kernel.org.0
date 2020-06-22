Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9EA3B2041B8
	for <lists+linux-integrity@lfdr.de>; Mon, 22 Jun 2020 22:14:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728439AbgFVUOx (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 22 Jun 2020 16:14:53 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:18112 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728363AbgFVUOx (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 22 Jun 2020 16:14:53 -0400
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 05MK276w105648;
        Mon, 22 Jun 2020 16:14:40 -0400
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 31tysqpa8n-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 22 Jun 2020 16:14:40 -0400
Received: from m0098404.ppops.net (m0098404.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 05MKDc4M150271;
        Mon, 22 Jun 2020 16:14:39 -0400
Received: from ppma03fra.de.ibm.com (6b.4a.5195.ip4.static.sl-reverse.com [149.81.74.107])
        by mx0a-001b2d01.pphosted.com with ESMTP id 31tysqpa7t-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 22 Jun 2020 16:14:39 -0400
Received: from pps.filterd (ppma03fra.de.ibm.com [127.0.0.1])
        by ppma03fra.de.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 05MKBLoJ026964;
        Mon, 22 Jun 2020 20:14:37 GMT
Received: from b06cxnps4075.portsmouth.uk.ibm.com (d06relay12.portsmouth.uk.ibm.com [9.149.109.197])
        by ppma03fra.de.ibm.com with ESMTP id 31sa381j4u-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 22 Jun 2020 20:14:36 +0000
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com [9.149.105.62])
        by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 05MKEYPK53411960
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 22 Jun 2020 20:14:34 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 7CE21AE056;
        Mon, 22 Jun 2020 20:14:34 +0000 (GMT)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 4B430AE04D;
        Mon, 22 Jun 2020 20:14:32 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.80.202.125])
        by d06av26.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Mon, 22 Jun 2020 20:14:32 +0000 (GMT)
Message-ID: <1592856871.4987.21.camel@linux.ibm.com>
Subject: Re: [PATCH] ima_evm_utils: extended calc_bootaggr to PCRs 8 - 9
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Maurizio Drocco <maurizio.drocco@ibm.com>, roberto.sassu@huawei.com
Cc:     Silviu.Vlasceanu@huawei.com, dmitry.kasatkin@gmail.com,
        jejb@linux.ibm.com, jmorris@namei.org,
        linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-security-module@vger.kernel.org, serge@hallyn.com,
        mdrocco@linux.vnet.ibm.com
Date:   Mon, 22 Jun 2020 16:14:31 -0400
In-Reply-To: <20200618201126.2081-2-maurizio.drocco@ibm.com>
References: <b744c1b79ba14a17a786f5de04c1f3c4@huawei.com>
         <20200618201126.2081-1-maurizio.drocco@ibm.com>
         <20200618201126.2081-2-maurizio.drocco@ibm.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.20.5 (3.20.5-1.fc24) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.216,18.0.687
 definitions=2020-06-22_11:2020-06-22,2020-06-22 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 malwarescore=0
 mlxscore=0 bulkscore=0 spamscore=0 clxscore=1015 priorityscore=1501
 lowpriorityscore=0 impostorscore=0 phishscore=0 mlxlogscore=999
 cotscore=-2147483648 suspectscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2004280000 definitions=main-2006220127
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Thu, 2020-06-18 at 16:11 -0400, Maurizio Drocco wrote:
> From: Maurizio <maurizio.drocco@ibm.com>
> 
> If PCRs 8 - 9 are set (i.e. not all-zeros), cal_bootaggr should include
> them into the digest.
> 
> Signed-off-by: Maurizio Drocco <maurizio.drocco@ibm.com>
> ---
>  src/evmctl.c | 16 +++++++++++++++-
>  1 file changed, 15 insertions(+), 1 deletion(-)
> 
> diff --git a/src/evmctl.c b/src/evmctl.c
> index 1d065ce..554571e 100644
> --- a/src/evmctl.c
> +++ b/src/evmctl.c
> @@ -1930,6 +1930,18 @@ static void calc_bootaggr(struct tpm_bank_info *bank)
>  		}
>  	}
>  
> +	if (strcmp(bank->algo_name, "sha1") != 0) {
> +		for (i = 8; i < 10; i++) {
> +			if (memcmp(bank->pcr[i], zero, bank->digest_size) != 0) {
> +				err = EVP_DigestUpdate(pctx, bank->pcr[i], bank->digest_size);
> +				if (!err) {
> +					log_err("EVP_DigestUpdate() failed\n");
> +					return;
> +				}
> +			}
> +		}
> +	}

Roberto, now that we're only including the PCRs 8 & 9 in the non-sha1
"boot_aggregate", they can always be included.

Please reflect this change in the patch description and, here, in the
code.

thanks,

Mimi
