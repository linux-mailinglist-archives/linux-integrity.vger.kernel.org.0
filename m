Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 45B72301000
	for <lists+linux-integrity@lfdr.de>; Fri, 22 Jan 2021 23:32:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729320AbhAVWbf (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 22 Jan 2021 17:31:35 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:4386 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728985AbhAVWb2 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 22 Jan 2021 17:31:28 -0500
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 10MLhdtX120771;
        Fri, 22 Jan 2021 17:30:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=references : from : to :
 cc : subject : in-reply-to : date : message-id : mime-version :
 content-type; s=pp1; bh=7mGn0WYopc0kF7PQBHUjZCd3m9ixqKMBlhNNMjrRDHI=;
 b=TrJn+c8k3HCYspJpz3IFCBuSgEZnwmOexpqOovSP6HdVaeUmJsHcbpeYw4ju2yJF7Oso
 TK3MgM6htuJA+PFkPB65Uli1PBPujbfkLLMOMYfUNo1sV+8SXlKHHLiiJdVlRQjY9jEa
 W3YiA9S7vW6aG8xaZf18FAF8AVAqJv5ngtBlXLk/dI6o1Y+6tbue+CXqdXrvelQuT7vz
 8Ho1AJfuAK+y+h+5SWlr6Kpk9WxdbDIUwxOYjr29OewM1q+UQEKW/Su2ymBANmVcIM7+
 sUwYzejaZnd7jjQFE1uLpLvS5c+TujSXELQMpEX1hvDvrdKl3RC9/W/Y8A/jrBpm6bn9 rw== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3686vagvr0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 22 Jan 2021 17:30:27 -0500
Received: from m0098410.ppops.net (m0098410.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 10MMA1Nj063811;
        Fri, 22 Jan 2021 17:30:27 -0500
Received: from ppma04dal.us.ibm.com (7a.29.35a9.ip4.static.sl-reverse.com [169.53.41.122])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3686vagvqg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 22 Jan 2021 17:30:27 -0500
Received: from pps.filterd (ppma04dal.us.ibm.com [127.0.0.1])
        by ppma04dal.us.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 10MMQu9Y014868;
        Fri, 22 Jan 2021 22:30:25 GMT
Received: from b01cxnp22034.gho.pok.ibm.com (b01cxnp22034.gho.pok.ibm.com [9.57.198.24])
        by ppma04dal.us.ibm.com with ESMTP id 367k0srrua-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 22 Jan 2021 22:30:25 +0000
Received: from b01ledav006.gho.pok.ibm.com (b01ledav006.gho.pok.ibm.com [9.57.199.111])
        by b01cxnp22034.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 10MMUOUf23069056
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 22 Jan 2021 22:30:24 GMT
Received: from b01ledav006.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id B6E9FAC064;
        Fri, 22 Jan 2021 22:30:24 +0000 (GMT)
Received: from b01ledav006.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 5C814AC059;
        Fri, 22 Jan 2021 22:30:22 +0000 (GMT)
Received: from manicouagan.localdomain (unknown [9.80.213.112])
        by b01ledav006.gho.pok.ibm.com (Postfix) with ESMTPS;
        Fri, 22 Jan 2021 22:30:22 +0000 (GMT)
References: <20210121173003.18324-1-nramas@linux.microsoft.com>
User-agent: mu4e 1.4.10; emacs 27.1
From:   Thiago Jung Bauermann <bauerman@linux.ibm.com>
To:     Lakshmi Ramasubramanian <nramas@linux.microsoft.com>
Cc:     zohar@linux.ibm.com, dmitry.kasatkin@gmail.com,
        ebiederm@xmission.com, gregkh@linuxfoundation.org,
        sashal@kernel.org, tyhicks@linux.microsoft.com,
        linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH 1/2] ima: Free IMA measurement buffer on error
In-reply-to: <20210121173003.18324-1-nramas@linux.microsoft.com>
Date:   Fri, 22 Jan 2021 19:30:20 -0300
Message-ID: <87eeic1u6b.fsf@manicouagan.localdomain>
MIME-Version: 1.0
Content-Type: text/plain
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.343,18.0.737
 definitions=2021-01-22_15:2021-01-22,2021-01-22 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 adultscore=0
 clxscore=1011 phishscore=0 malwarescore=0 priorityscore=1501 mlxscore=0
 suspectscore=0 bulkscore=0 mlxlogscore=999 lowpriorityscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2101220112
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org


Hi Lakshmi,

Lakshmi Ramasubramanian <nramas@linux.microsoft.com> writes:

> IMA allocates kernel virtual memory to carry forward the measurement
> list, from the current kernel to the next kernel on kexec system call,
> in ima_add_kexec_buffer() function.  In error code paths this memory
> is not freed resulting in memory leak.
>
> Free the memory allocated for the IMA measurement list in
> the error code paths in ima_add_kexec_buffer() function.
>
> Signed-off-by: Lakshmi Ramasubramanian <nramas@linux.microsoft.com>
> Suggested-by: Tyler Hicks <tyhicks@linux.microsoft.com>
> Fixes: 7b8589cc29e7 ("ima: on soft reboot, save the measurement list")
> ---
>  security/integrity/ima/ima_kexec.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/security/integrity/ima/ima_kexec.c b/security/integrity/ima/ima_kexec.c
> index 121de3e04af2..212145008a01 100644
> --- a/security/integrity/ima/ima_kexec.c
> +++ b/security/integrity/ima/ima_kexec.c
> @@ -119,12 +119,14 @@ void ima_add_kexec_buffer(struct kimage *image)
>  	ret = kexec_add_buffer(&kbuf);
>  	if (ret) {
>  		pr_err("Error passing over kexec measurement buffer.\n");
> +		vfree(kexec_buffer);
>  		return;
>  	}

This is a good catch.

>  
>  	ret = arch_ima_add_kexec_buffer(image, kbuf.mem, kexec_segment_size);
>  	if (ret) {
>  		pr_err("Error passing over kexec measurement buffer.\n");
> +		vfree(kexec_buffer);
>  		return;
>  	}

But this would cause problems, because the buffer is still there in the
kimage and would cause kimage_load_segment() to access invalid memory.

There's no function to undo a kexec_add_buffer() to avoid this problem,
so I'd suggest just accepting the leak in this case. Fortunately, the
current implementations of arch_ima_add_kexec_buffer() are very simple
and cannot fail, so this is a theoretical problem.

-- 
Thiago Jung Bauermann
IBM Linux Technology Center
