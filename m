Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 400835305D9
	for <lists+linux-integrity@lfdr.de>; Sun, 22 May 2022 22:24:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237183AbiEVUYt (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Sun, 22 May 2022 16:24:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235342AbiEVUYp (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Sun, 22 May 2022 16:24:45 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4425B35258
        for <linux-integrity@vger.kernel.org>; Sun, 22 May 2022 13:24:44 -0700 (PDT)
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 24MFi0IU013989;
        Sun, 22 May 2022 20:24:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=QVeRFtDTaD61t/suA64zSti/hD3cRZSPyTz93kPalCw=;
 b=Dr7AthFW7rlwblnuBLsw+ImcTLFgFSHnk0KUhzeKq7UQ1ixkJLAfOfNqWCnovPjJKb+Y
 m0xWKOw/kja48PpkrJWXQiz0St53f6j9Bxfa9V4MSyq9EOLZfKXjsecrqxVlncm1o2T0
 xVly0tPJHnP21NykJ06q0MU73vypQVwFFtIJ90BqXRLDNmlneG1SLM44IOYKRPhx8ZBR
 X4f6InWISYsHkNlkGNdjVMsUY0fmlpDLvyeTYC5Swq4GqIVY1UkZSDNmhfmB4YlEWmsJ
 0HG0Jfbi2eHNbhJJBD9E5FqMvpFWdYKXs9aVfMb1jqvo0j/mPseX/NM5Lq7S094ps9j5 QA== 
Received: from ppma02wdc.us.ibm.com (aa.5b.37a9.ip4.static.sl-reverse.com [169.55.91.170])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3g7a1e5821-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 22 May 2022 20:24:42 +0000
Received: from pps.filterd (ppma02wdc.us.ibm.com [127.0.0.1])
        by ppma02wdc.us.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 24MKH17Q016827;
        Sun, 22 May 2022 20:24:40 GMT
Received: from b03cxnp07027.gho.boulder.ibm.com (b03cxnp07027.gho.boulder.ibm.com [9.17.130.14])
        by ppma02wdc.us.ibm.com with ESMTP id 3g6qq9k55a-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 22 May 2022 20:24:40 +0000
Received: from b03ledav002.gho.boulder.ibm.com (b03ledav002.gho.boulder.ibm.com [9.17.130.233])
        by b03cxnp07027.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 24MKOdC828049878
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sun, 22 May 2022 20:24:39 GMT
Received: from b03ledav002.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id D0594136053;
        Sun, 22 May 2022 20:24:39 +0000 (GMT)
Received: from b03ledav002.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 957B013604F;
        Sun, 22 May 2022 20:24:39 +0000 (GMT)
Received: from [9.47.158.152] (unknown [9.47.158.152])
        by b03ledav002.gho.boulder.ibm.com (Postfix) with ESMTP;
        Sun, 22 May 2022 20:24:39 +0000 (GMT)
Message-ID: <49d46643-222a-599a-755b-330cd2706795@linux.ibm.com>
Date:   Sun, 22 May 2022 16:24:39 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Subject: Re: [PATCH v3 ima-evm-utils 1/3] Reset 'errno' after failure to open
 or access a file
Content-Language: en-US
To:     Mimi Zohar <zohar@linux.ibm.com>, linux-integrity@vger.kernel.org
Cc:     Eric Biggers <ebiggers@kernel.org>
References: <20220520161103.373554-1-zohar@linux.ibm.com>
 <20220520161103.373554-2-zohar@linux.ibm.com>
From:   Stefan Berger <stefanb@linux.ibm.com>
In-Reply-To: <20220520161103.373554-2-zohar@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 5P3M9H11X0CKnDt-qmh_tXiKxfms1rWQ
X-Proofpoint-ORIG-GUID: 5P3M9H11X0CKnDt-qmh_tXiKxfms1rWQ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.874,Hydra:6.0.486,FMLib:17.11.64.514
 definitions=2022-05-22_11,2022-05-20_02,2022-02-23_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 malwarescore=0
 adultscore=0 priorityscore=1501 suspectscore=0 lowpriorityscore=0
 phishscore=0 clxscore=1015 spamscore=0 impostorscore=0 mlxlogscore=999
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2202240000 definitions=main-2205220127
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org



On 5/20/22 12:11, Mimi Zohar wrote:
> Not being able to open a file is not necessarily a problem. If
> and when it occurs, an informational or error message with the
> actual filename is emitted as needed.
> 
> Reset 'errno' to prevent the "errno: No such file or directory (2)"
> generic message.
> 
> Signed-off-by: Mimi Zohar <zohar@linux.ibm.com>
> ---
>   src/evmctl.c    | 16 ++++++++++++++--
>   src/libimaevm.c |  4 ++++
>   src/utils.c     |  5 ++++-
>   3 files changed, 22 insertions(+), 3 deletions(-)
> 

> diff --git a/src/utils.c b/src/utils.c
> index 294dac554392..1026d44776da 100644
> --- a/src/utils.c
> +++ b/src/utils.c
> @@ -11,6 +11,7 @@
>   #include <string.h>
>   #include <sys/stat.h>
>   #include <unistd.h>
> +#include <errno.h>
>   
>   #include "utils.h"
>   
> @@ -26,8 +27,10 @@ static int file_exist(const char *path)
>   {
>   	struct stat st;
>   
> -	if (!access(path, R_OK) && !stat(path, &st) && S_ISREG(st.st_mode))
> +	if (!access(path, R_OK) && !stat(path, &st) && S_ISREG(st.st_mode)) {
> +		errno = 0;

!access and !stat are actually successes, so resetting errno in this 
particular place should not be necessary.

>   		return 1;
> +	}
>   
>   	return 0;
>   }
