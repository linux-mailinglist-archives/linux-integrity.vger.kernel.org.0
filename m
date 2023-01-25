Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 72B4867C0AA
	for <lists+linux-integrity@lfdr.de>; Thu, 26 Jan 2023 00:15:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229515AbjAYXPg (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 25 Jan 2023 18:15:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229483AbjAYXPf (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 25 Jan 2023 18:15:35 -0500
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5466442FF
        for <linux-integrity@vger.kernel.org>; Wed, 25 Jan 2023 15:15:34 -0800 (PST)
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 30PMNDsR012733;
        Wed, 25 Jan 2023 23:15:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=VaiJ8/pZoaza9XPsFNIvvCCvMQW63kq1saZxTn8Gfsg=;
 b=V8dZvksSer5tOjfZZWxv2In8iCT2zwrBN710mgbu1PfFqSyaQFWKBDh7ZoXh3kSiM5tF
 cweOIeUxcv0oAoSnIsWsNhUEIs61WLY+Ozoz1+vf4Pu7icHsXII6p9AFfnbc9eJZch6w
 5rGdh9yHdi5YYo0AFLx2CdQ0kvnX7tsFZw7TjYx4n+80v5pE5jLmZ2QPrpJZR6YQDMYR
 Lb7RsMQfYED52bKt9gvXEUkDoe1IHDXnGyL/A1jNwi7A1gZg3095qaEx4StzrRSPXoPt
 CG8MowxPHym5w1s4UOLMVdGpjQOANtGVNlAq9Lz4rMKtxR6QVI53AEnEB4tmkopDSjA3 sQ== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3nac21dvp2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 25 Jan 2023 23:15:18 +0000
Received: from m0098399.ppops.net (m0098399.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 30PNFHSk000952;
        Wed, 25 Jan 2023 23:15:17 GMT
Received: from ppma05wdc.us.ibm.com (1b.90.2fa9.ip4.static.sl-reverse.com [169.47.144.27])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3nac21dvnj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 25 Jan 2023 23:15:17 +0000
Received: from pps.filterd (ppma05wdc.us.ibm.com [127.0.0.1])
        by ppma05wdc.us.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 30PKADLb008021;
        Wed, 25 Jan 2023 23:15:16 GMT
Received: from smtprelay02.dal12v.mail.ibm.com ([9.208.130.97])
        by ppma05wdc.us.ibm.com (PPS) with ESMTPS id 3n87p72ejs-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 25 Jan 2023 23:15:16 +0000
Received: from smtpav04.dal12v.mail.ibm.com (smtpav04.dal12v.mail.ibm.com [10.241.53.103])
        by smtprelay02.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 30PNFFm339715430
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 25 Jan 2023 23:15:16 GMT
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id D6F3958052;
        Wed, 25 Jan 2023 23:15:15 +0000 (GMT)
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 6873A5805A;
        Wed, 25 Jan 2023 23:15:15 +0000 (GMT)
Received: from [9.47.158.152] (unknown [9.47.158.152])
        by smtpav04.dal12v.mail.ibm.com (Postfix) with ESMTP;
        Wed, 25 Jan 2023 23:15:15 +0000 (GMT)
Message-ID: <d9c60317-5371-6d3a-3f7c-c71011e0a126@linux.ibm.com>
Date:   Wed, 25 Jan 2023 18:15:14 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH ima-evm-utils v3 07/11] Add tests for EVM portable
 signatures
Content-Language: en-US
To:     Roberto Sassu <roberto.sassu@huaweicloud.com>, zohar@linux.ibm.com,
        dmitry.kasatkin@gmail.com
Cc:     linux-integrity@vger.kernel.org, vt@altlinux.org, pvorel@suse.cz,
        Roberto Sassu <roberto.sassu@huawei.com>
References: <20230125085030.1568256-1-roberto.sassu@huaweicloud.com>
 <20230125085030.1568256-8-roberto.sassu@huaweicloud.com>
From:   Stefan Berger <stefanb@linux.ibm.com>
In-Reply-To: <20230125085030.1568256-8-roberto.sassu@huaweicloud.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: Xyoq_c_hY2uxhY0p1HaYgQDls7wK5uXp
X-Proofpoint-ORIG-GUID: Eoq2aZDqSFDzOEKL1G99DXtkcChTPDcJ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-01-25_13,2023-01-25_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 bulkscore=0
 malwarescore=0 mlxscore=0 priorityscore=1501 spamscore=0 clxscore=1015
 impostorscore=0 mlxlogscore=818 lowpriorityscore=0 adultscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2301250205
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org



On 1/25/23 03:50, Roberto Sassu wrote:
> From: Roberto Sassu <roberto.sassu@huawei.com>
> 

> +
> +	last_char=${ima_xattr: -1}

To avoid last_char from spilling into the global variable space I would declare it as local. I would do this for **every** variable.

An example from functions.sh:

_evmctl_run() {
   local op=$1 out=$1-$$.out
   local text_for=${FOR:+for $ADD_TEXT_FOR}
   # Additional parameters:
   # ADD_DEL: additional files to rm on failure
   # ADD_TEXT_FOR: append to text as 'for $ADD_TEXT_FOR'

   cmd="evmctl $V $EVMCTL_ENGINE $*"
   echo $YELLOW$TMODE "$cmd"$NORM
   $cmd >"$out" 2>&1
   ret=$?

[...]
}

If I have a function like this here calling _evmctl_run() it will clobber even my local-declared ret and cmd variables because neither is declared as local in _evmctl_run.

foo() {
   local ret=123
   local cmd="mycmd"
   [...]
   _evmctl_run ...
   # my ret and cmd are now clobbered!
}


   Stefan
