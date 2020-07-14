Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7C5E421FE28
	for <lists+linux-integrity@lfdr.de>; Tue, 14 Jul 2020 22:06:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729826AbgGNUGp (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 14 Jul 2020 16:06:45 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:8256 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729713AbgGNUGp (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 14 Jul 2020 16:06:45 -0400
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 06EK2UkV015507;
        Tue, 14 Jul 2020 16:06:42 -0400
Received: from ppma06ams.nl.ibm.com (66.31.33a9.ip4.static.sl-reverse.com [169.51.49.102])
        by mx0a-001b2d01.pphosted.com with ESMTP id 328s0dkuyy-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 14 Jul 2020 16:06:42 -0400
Received: from pps.filterd (ppma06ams.nl.ibm.com [127.0.0.1])
        by ppma06ams.nl.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 06EJvUUH009634;
        Tue, 14 Jul 2020 20:06:40 GMT
Received: from b06avi18878370.portsmouth.uk.ibm.com (b06avi18878370.portsmouth.uk.ibm.com [9.149.26.194])
        by ppma06ams.nl.ibm.com with ESMTP id 3274pguk01-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 14 Jul 2020 20:06:40 +0000
Received: from d06av24.portsmouth.uk.ibm.com (mk.ibm.com [9.149.105.60])
        by b06avi18878370.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 06EK6bIu54722972
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 14 Jul 2020 20:06:38 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id E6B054203F;
        Tue, 14 Jul 2020 20:06:37 +0000 (GMT)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 4D2A742041;
        Tue, 14 Jul 2020 20:06:37 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.85.155.184])
        by d06av24.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Tue, 14 Jul 2020 20:06:37 +0000 (GMT)
Message-ID: <1594757196.12900.191.camel@linux.ibm.com>
Subject: Re: [PATCH ima-evm-utils] Check for tsspcrread in runtime
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Petr Vorel <pvorel@suse.cz>, linux-integrity@vger.kernel.org
Cc:     Mimi Zohar <zohar@linux.vnet.ibm.com>
Date:   Tue, 14 Jul 2020 16:06:36 -0400
In-Reply-To: <20200714154659.8080-1-pvorel@suse.cz>
References: <20200714154659.8080-1-pvorel@suse.cz>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.20.5 (3.20.5-1.fc24) 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-07-14_08:2020-07-14,2020-07-14 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 priorityscore=1501
 suspectscore=0 spamscore=0 malwarescore=0 mlxlogscore=999
 lowpriorityscore=0 phishscore=0 clxscore=1015 impostorscore=0 adultscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2007140138
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Tue, 2020-07-14 at 17:46 +0200, Petr Vorel wrote:
> instead of checking in build time as it's runtime dependency.
> Also log when tsspcrread not found to make debugging easier.
> 
> We search for tsspcrread unless there is tss2-esys with Esys_PCR_Read(),
> thus pcr_none.c was dropped as unneeded.
> 
> file_exist(), file_exist() and MIN() taken from LTP project.

One of these "file_exists" I assume is suppose to be "tst_get_path".

> 
> Signed-off-by: Petr Vorel <pvorel@suse.cz>
> ---
> Hi Mimi,
> 
> small improvement based on the current next-testing branch
> (9638068aff2476b567185d7eb94126449ad89ca7).
> 
> I'm sorry I don't have the required setup, thus didn't test this patch.
> 
> Kind regards,
> Petr

Nice!  It works.

> diff --git a/src/pcr_tsspcrread.c b/src/pcr_tsspcrread.c
> @@ -47,8 +48,21 @@
> 
>  #include "utils.h"
> 
> -int tpm2_pcr_supported(void)
> +#define CMD "tsspcrread"
> +
> +static char path[PATH_MAX];
> +
> +int tpm2_pcr_supported(char **errmsg)
>  {
> +	int ret;
> +
> +	if (get_cmd_path(CMD, path, sizeof(path))) {
> +		ret = asprintf(errmsg, "Couldn't find '%s' in $PATH", CMD);
> +		if (ret == -1)	/* the contents of errmsg is undefined */
> +			*errmsg = NULL;
> +		return 0;
> +	}
> +

Any chance you could also emit the pathname on success as well?

>  	return 1;
>  }

