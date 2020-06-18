Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DAFF41FFAF4
	for <lists+linux-integrity@lfdr.de>; Thu, 18 Jun 2020 20:20:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730224AbgFRSUn (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 18 Jun 2020 14:20:43 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:8732 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725953AbgFRSUn (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 18 Jun 2020 14:20:43 -0400
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 05II2BaJ135798;
        Thu, 18 Jun 2020 14:20:40 -0400
Received: from ppma04ams.nl.ibm.com (63.31.33a9.ip4.static.sl-reverse.com [169.51.49.99])
        by mx0b-001b2d01.pphosted.com with ESMTP id 31r8xt1e0v-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 18 Jun 2020 14:20:40 -0400
Received: from pps.filterd (ppma04ams.nl.ibm.com [127.0.0.1])
        by ppma04ams.nl.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 05IIG3lB018287;
        Thu, 18 Jun 2020 18:20:38 GMT
Received: from b06cxnps4076.portsmouth.uk.ibm.com (d06relay13.portsmouth.uk.ibm.com [9.149.109.198])
        by ppma04ams.nl.ibm.com with ESMTP id 31qur61g2f-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 18 Jun 2020 18:20:38 +0000
Received: from d06av24.portsmouth.uk.ibm.com (mk.ibm.com [9.149.105.60])
        by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 05IIKZkh38142060
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 18 Jun 2020 18:20:35 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 99B274204C;
        Thu, 18 Jun 2020 18:20:35 +0000 (GMT)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 16F654203F;
        Thu, 18 Jun 2020 18:20:35 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.80.230.246])
        by d06av24.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Thu, 18 Jun 2020 18:20:34 +0000 (GMT)
Message-ID: <1592504434.4615.56.camel@linux.ibm.com>
Subject: Re: [PATCH ima-evm-utils] cmd_ima_bootaggr: Fix for systems without
 TPM 2.0
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Petr Vorel <pvorel@suse.cz>, linux-integrity@vger.kernel.org
Cc:     Mimi Zohar <zohar@linux.vnet.ibm.com>
Date:   Thu, 18 Jun 2020 14:20:34 -0400
In-Reply-To: <20200618181007.148765-1-pvorel@suse.cz>
References: <20200618181007.148765-1-pvorel@suse.cz>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.20.5 (3.20.5-1.fc24) 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.216,18.0.687
 definitions=2020-06-18_15:2020-06-18,2020-06-18 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 bulkscore=0
 adultscore=0 cotscore=-2147483648 lowpriorityscore=0 mlxlogscore=999
 mlxscore=0 spamscore=0 malwarescore=0 priorityscore=1501 clxscore=1015
 impostorscore=0 phishscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2004280000 definitions=main-2006180134
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Hi Petr,

On Thu, 2020-06-18 at 20:10 +0200, Petr Vorel wrote:
> For both kernel with and without CONFIG_IMA=y.
> 
> NOTE: ima_boot_aggregate was added in dc00c92, without TPM 2.0
> it just reported:
> EVP_DigestInit() failed
> (null):
> 
> Fixes: 917317a ("ima_evm_utils: emit the per TPM PCR bank
> "boot_aggregate" values")
> 
> Signed-off-by: Petr Vorel <pvorel@suse.cz>

I don't have a problem with accepting this solution, but I think the
 real problem is that hash_info.h is not included in the kernel-
headers package on the system.  One solution would be to include a
default hash_info.h file in ima-evm-utils and fall back to using it.

Mimi

> ---
>  src/evmctl.c | 10 ++++++++--
>  1 file changed, 8 insertions(+), 2 deletions(-)
> 
> diff --git a/src/evmctl.c b/src/evmctl.c
> index 1d065ce..94ec56b 100644
> --- a/src/evmctl.c
> +++ b/src/evmctl.c
> @@ -1998,11 +1998,17 @@ static int cmd_ima_bootaggr(struct command *cmd)
>  	 * Format: <hash algorithm name>:<boot_aggregate digest>\n ...
>  	 */
>  	for (i = 0; i < num_banks; i++) {
> -		if (!tpm_banks[i].supported)
> +		if (!tpm_banks[i].supported || !tpm_banks[i].algo_name)
>  			continue;
>  		bootaggr_len += strlen(tpm_banks[i].algo_name) + 1;
>  		bootaggr_len += (tpm_banks[i].digest_size * 2) + 1;
>  	}
> +
> +	if (!bootaggr_len) {
> +		log_info("No TPM 2.0 PCR bank algorithm found (no TPM 2.0?)\n");
> +		return -1;
> +	}
> +
>  	bootaggr = malloc(bootaggr_len);
> 
>  	/*
> @@ -2012,7 +2018,7 @@ static int cmd_ima_bootaggr(struct command *cmd)
>  	 * strings.
>  	 */
>  	for (i = 0; i < num_banks; i++) {
> -		if (!tpm_banks[i].supported)
> +		if (!tpm_banks[i].supported || !tpm_banks[i].algo_name)
>  			continue;
>  		calc_bootaggr(&tpm_banks[i]);
>  		offset += append_bootaggr(bootaggr + offset, tpm_banks + i);

