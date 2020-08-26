Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0565D25342A
	for <lists+linux-integrity@lfdr.de>; Wed, 26 Aug 2020 17:59:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727786AbgHZP57 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 26 Aug 2020 11:57:59 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:13026 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727882AbgHZP54 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 26 Aug 2020 11:57:56 -0400
Received: from pps.filterd (m0187473.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 07QFW2UE189368;
        Wed, 26 Aug 2020 11:57:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=HccGIv1kXZpAh+2ptA3ZwBl+YCt3qQZHYAt/DHYIo6A=;
 b=ANtUBcFPSlnyCBhe5XzhRefOY2CgJjUqIOmxh1eIBlq0ufnA9irIv25sJwTzxLxVs4p6
 C0HUMNg7YT8OzXYjH5hIeUu/5kiVVPv4P3U3s9g1YYkVPhkLsbGnmhKXeNamTTYZ3+yy
 I3kaShD2c3D67HVwlSDeTlPyRNX+noqw9Zc9kqrsvjOPRppGshX74HTFT5RTBSwnkTYy
 dZFQIrHOO/Kl3gRRd+uW946QfWb9U3SjWwc91o7JuimsHddlbM5xvNygwBK+sX8GIRNy
 Kcl+Eo386LY5WQvXv/iU2gA/3W0PWt6RNsjdyQhFNLpBjsmaWT0SCZelxQwa5dpgsULv qA== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 335t9v8x77-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 26 Aug 2020 11:57:49 -0400
Received: from m0187473.ppops.net (m0187473.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 07QFW54D189756;
        Wed, 26 Aug 2020 11:57:48 -0400
Received: from ppma02dal.us.ibm.com (a.bd.3ea9.ip4.static.sl-reverse.com [169.62.189.10])
        by mx0a-001b2d01.pphosted.com with ESMTP id 335t9v8x5r-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 26 Aug 2020 11:57:48 -0400
Received: from pps.filterd (ppma02dal.us.ibm.com [127.0.0.1])
        by ppma02dal.us.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 07QFVqnL020411;
        Wed, 26 Aug 2020 15:57:46 GMT
Received: from b01cxnp23033.gho.pok.ibm.com (b01cxnp23033.gho.pok.ibm.com [9.57.198.28])
        by ppma02dal.us.ibm.com with ESMTP id 335kvcbp2q-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 26 Aug 2020 15:57:46 +0000
Received: from b01ledav002.gho.pok.ibm.com (b01ledav002.gho.pok.ibm.com [9.57.199.107])
        by b01cxnp23033.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 07QFvjWl56099296
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 26 Aug 2020 15:57:45 GMT
Received: from b01ledav002.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 9E942124055;
        Wed, 26 Aug 2020 15:57:45 +0000 (GMT)
Received: from b01ledav002.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id AB9CD124052;
        Wed, 26 Aug 2020 15:57:44 +0000 (GMT)
Received: from swastik.ibm.com (unknown [9.160.97.86])
        by b01ledav002.gho.pok.ibm.com (Postfix) with ESMTP;
        Wed, 26 Aug 2020 15:57:44 +0000 (GMT)
Subject: Re: [PATCH v2 0/2] ima: Fix keyrings race condition and other key
 related bugs
To:     Tyler Hicks <tyhicks@linux.microsoft.com>,
        Mimi Zohar <zohar@linux.ibm.com>
Cc:     Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
        James Morris <jmorris@namei.org>,
        "Serge E . Hallyn" <serge@hallyn.com>,
        Lakshmi Ramasubramanian <nramas@linux.microsoft.com>,
        Tushar Sugandhi <tusharsu@linux.microsoft.com>,
        Nayna Jain <nayna@linux.ibm.com>, linux-kernel@vger.kernel.org,
        linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org
References: <20200811192621.281675-1-tyhicks@linux.microsoft.com>
From:   Nayna <nayna@linux.vnet.ibm.com>
Message-ID: <48c98a62-01f0-825b-7648-7d8fa9f13b40@linux.vnet.ibm.com>
Date:   Wed, 26 Aug 2020 11:57:44 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200811192621.281675-1-tyhicks@linux.microsoft.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-08-26_09:2020-08-26,2020-08-26 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999
 priorityscore=1501 lowpriorityscore=0 malwarescore=0 phishscore=0
 mlxscore=0 clxscore=1015 bulkscore=0 impostorscore=0 suspectscore=0
 adultscore=0 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2008260114
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org


On 8/11/20 3:26 PM, Tyler Hicks wrote:
> v2:
>   - Always return an ERR_PTR from ima_alloc_rule_opt_list() (Nayna)
>   - Add Lakshmi's Reviewed-by to both patches
>   - Rebased on commit 3db0d0c276a7 ("integrity: remove redundant
>     initialization of variable ret") of next-integrity
> v1: https://lore.kernel.org/lkml/20200727140831.64251-1-tyhicks@linux.microsoft.com/
>
> Nayna pointed out that the "keyrings=" option in an IMA policy rule
> should only be accepted when CONFIG_IMA_MEASURE_ASYMMETRIC_KEYS is
> enabled:
>
>   https://lore.kernel.org/linux-integrity/336cc947-1f70-0286-6506-6df3d1d23a1d@linux.vnet.ibm.com/
>
> While fixing this, the compiler warned me about the potential for the
> ima_keyrings pointer to be NULL despite it being used, without a check
> for NULL, as the destination address for the strcpy() in
> ima_match_keyring().
>
> It also became apparent that there was not adequate locking around the
> use of the pre-allocated buffer that ima_keyrings points to. The kernel
> keyring has a lock (.sem member of struct key) that ensures only one key
> can be added to a given keyring at a time but there's no protection
> against adding multiple keys to different keyrings at the same time.
>
> The first patch in this series fixes both ima_keyrings related issues by
> parsing the list of keyrings in a KEY_CHECK rule at policy load time
> rather than deferring the parsing to policy check time. Once that fix is
> in place, the second patch can enforce that
> CONFIG_IMA_MEASURE_ASYMMETRIC_KEYS must be enabled in order to use
> "func=KEY_CHECK" or "keyrings=" options in IMA policy.
>
> The new "keyrings=" value handling is done in a generic manner that can
> be reused by other options in the future. This seems to make sense as
> "appraise_type=" has similar style (though it doesn't need to be fully
> parsed at this time) and using "|" as an alternation delimiter is
> becoming the norm in IMA policy.
>
> This series is based on commit 311aa6aafea4 ("ima: move
> APPRAISE_BOOTPARAM dependency on ARCH_POLICY to runtime") in
> next-integrity.
>
> Tyler
>
> Tyler Hicks (2):
>    ima: Pre-parse the list of keyrings in a KEY_CHECK rule
>    ima: Fail rule parsing when asymmetric key measurement isn't
>      supportable
>
>   security/integrity/ima/ima_policy.c | 142 +++++++++++++++++++---------
>   1 file changed, 96 insertions(+), 46 deletions(-)
>

Sorry for delay in responding.

The patches look good. Feel free to add my tag

Reviewed-by: Nayna Jain <nayna@linux.ibm.com>

Thanks & Regards,

     - Nayna




