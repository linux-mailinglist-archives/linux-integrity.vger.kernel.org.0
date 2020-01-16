Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DEA2613DAB0
	for <lists+linux-integrity@lfdr.de>; Thu, 16 Jan 2020 13:58:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726684AbgAPM45 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 16 Jan 2020 07:56:57 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:53000 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726018AbgAPM45 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 16 Jan 2020 07:56:57 -0500
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 00GCq43Y038531
        for <linux-integrity@vger.kernel.org>; Thu, 16 Jan 2020 07:56:56 -0500
Received: from e06smtp02.uk.ibm.com (e06smtp02.uk.ibm.com [195.75.94.98])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2xj5xbkvsv-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-integrity@vger.kernel.org>; Thu, 16 Jan 2020 07:56:55 -0500
Received: from localhost
        by e06smtp02.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-integrity@vger.kernel.org> from <zohar@linux.ibm.com>;
        Thu, 16 Jan 2020 12:56:54 -0000
Received: from b06cxnps3075.portsmouth.uk.ibm.com (9.149.109.195)
        by e06smtp02.uk.ibm.com (192.168.101.132) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Thu, 16 Jan 2020 12:56:52 -0000
Received: from d06av25.portsmouth.uk.ibm.com (d06av25.portsmouth.uk.ibm.com [9.149.105.61])
        by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 00GCup5G57147398
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 16 Jan 2020 12:56:51 GMT
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id B9F3F11C04C;
        Thu, 16 Jan 2020 12:56:51 +0000 (GMT)
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 152B711C071;
        Thu, 16 Jan 2020 12:56:51 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.85.139.213])
        by d06av25.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Thu, 16 Jan 2020 12:56:50 +0000 (GMT)
Subject: Re: [PATCH] IMA: pre-allocate keyrings string
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Lakshmi Ramasubramanian <nramas@linux.microsoft.com>,
        linux-integrity@vger.kernel.org
Cc:     sashal@kernel.org, linux-kernel@vger.kernel.org,
        keyrings@vger.kernel.org
Date:   Thu, 16 Jan 2020 07:56:50 -0500
In-Reply-To: <20200116031508.3481-1-nramas@linux.microsoft.com>
References: <20200116031508.3481-1-nramas@linux.microsoft.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.20.5 (3.20.5-1.fc24) 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 20011612-0008-0000-0000-00000349E670
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 20011612-0009-0000-0000-00004A6A4028
Message-Id: <1579179410.5857.21.camel@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.572
 definitions=2020-01-16_04:2020-01-16,2020-01-15 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 suspectscore=0
 malwarescore=0 priorityscore=1501 mlxlogscore=999 clxscore=1015
 impostorscore=0 phishscore=0 lowpriorityscore=0 bulkscore=0 adultscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1910280000 definitions=main-2001160109
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Hi Laskhmi,

On Wed, 2020-01-15 at 19:15 -0800, Lakshmi Ramasubramanian wrote:
> ima_match_keyring() is called while holding rcu read lock.
> Since this function executes in atmomic context, it should
> not call any function that can sleep (such as kstrdup()).

Good catch!

> This patch pre-allocates a buffer to hold the keyrings
> string read from the IMA policy and uses that to check
> the given keyring in ima_match_keyring().

(Reminder: this patch description line length is a bit short.
 According to  Documentation/process/submitting-patches.rst, the patch
description line length should be line wrapped at 75 columns.)

> 
> Signed-off-by: Lakshmi Ramasubramanian <nramas@linux.microsoft.com>
> Fixes: e9085e0ad38a ("IMA: Add support to limit measuring keys")
> ---

 
> @@ -1120,8 +1117,17 @@ static int ima_parse_rule(char *rule, struct ima_rule_entry *entry)
>  				result = -EINVAL;
>  				break;
>  			}
> +
> +			ima_keyrings = kstrdup(args[0].from, GFP_KERNEL);
> +			if (!ima_keyrings) {
> +				result = -ENOMEM;
> +				break;
> +			}


This would work for a single "key" measurement rule, but not for
multiple rules, where the last "keyrings" string is shorter than the
previous ones.  For example, in addition to the builtin trusted
keyrings, another rule could measure a keyring owned by a user.

measure func=KEY_CHECK template=ima-buf keyrings=.ima|.builtin_trusted_keys
measure func=KEY_CHECK uid=1000 template=ima-buf keyrings=_foo

Mimi

>  			entry->keyrings = kstrdup(args[0].from, GFP_KERNEL);
>  			if (!entry->keyrings) {
> +				kfree(ima_keyrings);
> +				ima_keyrings = NULL;
>  				result = -ENOMEM;
>  				break;
>  			}

