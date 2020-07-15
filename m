Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 56ED22217CA
	for <lists+linux-integrity@lfdr.de>; Thu, 16 Jul 2020 00:30:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726786AbgGOWaU (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 15 Jul 2020 18:30:20 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:21738 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726479AbgGOWaT (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 15 Jul 2020 18:30:19 -0400
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 06FM2HxU082718;
        Wed, 15 Jul 2020 18:30:14 -0400
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 329cukxd6n-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 15 Jul 2020 18:30:14 -0400
Received: from m0098399.ppops.net (m0098399.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 06FM2N2b086494;
        Wed, 15 Jul 2020 18:30:13 -0400
Received: from ppma04ams.nl.ibm.com (63.31.33a9.ip4.static.sl-reverse.com [169.51.49.99])
        by mx0a-001b2d01.pphosted.com with ESMTP id 329cukxd5m-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 15 Jul 2020 18:30:13 -0400
Received: from pps.filterd (ppma04ams.nl.ibm.com [127.0.0.1])
        by ppma04ams.nl.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 06FMTwxx025173;
        Wed, 15 Jul 2020 22:30:11 GMT
Received: from b06avi18626390.portsmouth.uk.ibm.com (b06avi18626390.portsmouth.uk.ibm.com [9.149.26.192])
        by ppma04ams.nl.ibm.com with ESMTP id 329nmyh4uu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 15 Jul 2020 22:30:11 +0000
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com [9.149.105.232])
        by b06avi18626390.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 06FMSkES58327518
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 15 Jul 2020 22:28:46 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id C1C7452063;
        Wed, 15 Jul 2020 22:30:08 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.85.155.184])
        by d06av21.portsmouth.uk.ibm.com (Postfix) with ESMTP id 0A5F05204F;
        Wed, 15 Jul 2020 22:30:07 +0000 (GMT)
Message-ID: <1594852207.12900.350.camel@linux.ibm.com>
Subject: Re: [PATCH 3/3] ima-evm-utils: fix overflow on printing
 boot_aggregate
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Bruno Meneguele <bmeneg@redhat.com>,
        linux-integrity@vger.kernel.org
Cc:     Petr Vorel <pvorel@suse.cz>, Vitaly Chikunov <vt@altlinux.org>
Date:   Wed, 15 Jul 2020 18:30:07 -0400
In-Reply-To: <20200715213906.194041-4-bmeneg@redhat.com>
References: <20200715213906.194041-1-bmeneg@redhat.com>
         <20200715213906.194041-4-bmeneg@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.20.5 (3.20.5-1.fc24) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-07-15_12:2020-07-15,2020-07-15 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 bulkscore=0
 adultscore=0 spamscore=0 priorityscore=1501 phishscore=0 malwarescore=0
 suspectscore=0 mlxlogscore=999 mlxscore=0 lowpriorityscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2007150161
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Wed, 2020-07-15 at 18:39 -0300, Bruno Meneguele wrote:
> diff --git a/src/evmctl.c b/src/evmctl.c
> index 2f5bd52..2bd37c2 100644
> --- a/src/evmctl.c
> +++ b/src/evmctl.c
> @@ -2252,7 +2252,8 @@ static int cmd_ima_bootaggr(struct command *cmd)
>  		bootaggr_len += strlen(tpm_banks[i].algo_name) + 1;
>  		bootaggr_len += (tpm_banks[i].digest_size * 2) + 1;
>  	}
> -	bootaggr = malloc(bootaggr_len);
> +	/* Make room for the leading \0 */

^Trailing null

Mimi

> +	bootaggr = malloc(bootaggr_len + 1);
>  
>  	/*
>  	 * Calculate and convert the per TPM 2.0 PCR bank algorithm

