Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1828225808C
	for <lists+linux-integrity@lfdr.de>; Mon, 31 Aug 2020 20:15:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729272AbgHaSPW (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 31 Aug 2020 14:15:22 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:65350 "EHLO
        mx0b-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727058AbgHaSPW (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 31 Aug 2020 14:15:22 -0400
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 07VICSOM010830;
        Mon, 31 Aug 2020 14:15:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 mime-version : content-transfer-encoding; s=pp1;
 bh=2Zt60Da8ydmfnwL5qNmLq+grEYSEGAAJLsSW2Aj+kEU=;
 b=hSZmsJ6x/E8w9k3QpIr9V9sDC8DIieH0tXD0gBI7boybRHgfmP1qtdgufXL59okj1eZP
 FozffYjP7L/4dL8ZPQwxtaQXfBegu/fiIBlXC44rGBXVFeNfu/FT4rvldRDeAX9qNkPd
 n7Tnd8A7ipeQVeP0eG+zM1KKXQh8iUrYFS9mmyNq2J5IbMsqV2pdP2RJTzOEjHHVi7d4
 DDNPM4JNLjGXxStGAxNElrecg/e/Mm+8Dmuvy0jCUaUj5T4+0XaeXujUgzFtWBK+r5Go
 QX2UtmgTs6lYQ4dnTdOOkeYGc5R9dZoMK9CwDQ8SLlNcMewmbzIg0w2S6hvDzBFF/Tt/ Bg== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 33969br22u-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 31 Aug 2020 14:15:15 -0400
Received: from m0098417.ppops.net (m0098417.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 07VIE72u013986;
        Mon, 31 Aug 2020 14:15:15 -0400
Received: from ppma06ams.nl.ibm.com (66.31.33a9.ip4.static.sl-reverse.com [169.51.49.102])
        by mx0a-001b2d01.pphosted.com with ESMTP id 33969br21a-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 31 Aug 2020 14:15:15 -0400
Received: from pps.filterd (ppma06ams.nl.ibm.com [127.0.0.1])
        by ppma06ams.nl.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 07VICxFc004273;
        Mon, 31 Aug 2020 18:15:13 GMT
Received: from b06cxnps4075.portsmouth.uk.ibm.com (d06relay12.portsmouth.uk.ibm.com [9.149.109.197])
        by ppma06ams.nl.ibm.com with ESMTP id 337e9gten0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 31 Aug 2020 18:15:13 +0000
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com [9.149.105.59])
        by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 07VIFB4A15860132
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 31 Aug 2020 18:15:11 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id D9A50A4072;
        Mon, 31 Aug 2020 18:15:09 +0000 (GMT)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 85E9EA4069;
        Mon, 31 Aug 2020 18:15:06 +0000 (GMT)
Received: from li-f45666cc-3089-11b2-a85c-c57d1a57929f.ibm.com (unknown [9.160.2.129])
        by d06av23.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Mon, 31 Aug 2020 18:15:06 +0000 (GMT)
Message-ID: <652406e1a08d855a5d9a3e3815835653a12df411.camel@linux.ibm.com>
Subject: Re: [PATCH v3 4/6] IMA: add policy to measure critical data from
 kernel components
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Tushar Sugandhi <tusharsu@linux.microsoft.com>,
        stephen.smalley.work@gmail.com, casey@schaufler-ca.com,
        agk@redhat.com, snitzer@redhat.com, gmazyland@gmail.com
Cc:     tyhicks@linux.microsoft.com, sashal@kernel.org, jmorris@namei.org,
        nramas@linux.microsoft.com, linux-integrity@vger.kernel.org,
        selinux@vger.kernel.org, linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, dm-devel@redhat.com
Date:   Mon, 31 Aug 2020 14:15:05 -0400
In-Reply-To: <20200828015704.6629-5-tusharsu@linux.microsoft.com>
References: <20200828015704.6629-1-tusharsu@linux.microsoft.com>
         <20200828015704.6629-5-tusharsu@linux.microsoft.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5 (3.28.5-12.el8) 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-08-31_08:2020-08-31,2020-08-31 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0
 impostorscore=0 mlxscore=0 lowpriorityscore=0 clxscore=1015 adultscore=0
 phishscore=0 bulkscore=0 priorityscore=1501 mlxlogscore=999 spamscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2008310104
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Thu, 2020-08-27 at 18:57 -0700, Tushar Sugandhi wrote:
> There would be several candidate kernel components suitable for IMA
> measurement. Not all of them would have support for IMA measurement.
> Also, system administrators may not want to measure data for all of
> them, even when they support IMA measurement. An IMA policy specific
> to various kernel components is needed to measure their respective
> critical data.

The base policy rules are wide, but may be constrained by specifying
different options.  For example the builtin policy rules cannot be
written in terms LSM labels, which would constrain them.  A policy rule
may measure all keyrings or may constrain which keyrings need to be
measured.  Measuring critical data is not any different.

Please rewrite the above paragraph accordingly.

> 
> Add a new IMA policy "critical_kernel_data_sources" to support measuring
> various critical kernel components. This policy would enable the
> system administrators to limit the measurement to the components,
> if the components support IMA measurement.

"critical_kernel_data_sources" is really wordy.   Find a better, self
defining term for describing the type of data, one that isn't so wordy,
and reflect it in the code.

> 
> Signed-off-by: Tushar Sugandhi <tusharsu@linux.microsoft.com>
> ---
>  Documentation/ABI/testing/ima_policy |  3 +++
>  security/integrity/ima/ima_policy.c  | 29 +++++++++++++++++++++++++++-
>  2 files changed, 31 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/ABI/testing/ima_policy b/Documentation/ABI/testing/ima_policy
> index cd572912c593..7ccdc1964e29 100644
> --- a/Documentation/ABI/testing/ima_policy
> +++ b/Documentation/ABI/testing/ima_policy
> @@ -48,6 +48,9 @@ Description:
>  			template:= name of a defined IMA template type
>  			(eg, ima-ng). Only valid when action is "measure".
>  			pcr:= decimal value
> +			critical_kernel_data_sources:= list of kernel
> +			components (eg, selinux|apparmor|dm-crypt) that
> +			contain data critical to the security of the kernel.

This original policy definition, for the most part, is in Backus–Naur
format.   The keyring names is an exception, because it is not limited
to pre-defined kernel objects.  The critical data hook is measuring
things in kernel memory.  As new calls to measure critical data are
added, new identifiers would be added here.

For example, if SELinux is the first example of measuring critical
data, then the SELinux critical data patch would include
"critical_data:= [selinux]".  Each subsequent critical data being
measured would extend this list.  At the same time, the list of known
"critical data" defined in patch 6/6 would be updated.

Normally a new feature and the first usage of that feature are included
in the same patch set.  Separating them like this makes it difficult to
write, review and upstream.

Mimi

