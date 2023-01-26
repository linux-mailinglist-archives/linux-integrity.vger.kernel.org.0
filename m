Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (unknown [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6012967D84C
	for <lists+linux-integrity@lfdr.de>; Thu, 26 Jan 2023 23:26:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231651AbjAZWZj (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 26 Jan 2023 17:25:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229813AbjAZWZi (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 26 Jan 2023 17:25:38 -0500
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88AE94A23D;
        Thu, 26 Jan 2023 14:25:37 -0800 (PST)
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 30QLePsg024992;
        Thu, 26 Jan 2023 22:25:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=xvhz7s98kQ6LyPUTtIiOoOJOeYRwStvFiluZ2yyJIUw=;
 b=HlXhTBHhcEkpIV+60fKn8WDIqBSXPIc77UOinbUqBa9SFC/yyDroWD6OQE59Y5y+OYVg
 GeeL96RNgfNiXdhHvKJAIFuTx/XT8Us42oPJtKeBZvAotvBon5jOcgYxz44uOkkIANoe
 090u5lF6xt7YLg4p/bAbjxcSuX+yzB9F2gmB52yYSy9brKe/UyFZM5sAZE1FxWMJUMbz
 42TpAtzKJ4KLEmlqqLmdjiYjTJvqVo1wPS/4hjLQxbwJRe1x4tCzo9db7q4XpGulb/F6
 mS3XaDKZwj1bMdigBoLXjYKommLtyi93rsRIM/WaYaiua8sERSYkHkqFeeOvWcuUXgnw MA== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3nc1aq133k-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 26 Jan 2023 22:25:19 +0000
Received: from m0098396.ppops.net (m0098396.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 30QMAUfW005888;
        Thu, 26 Jan 2023 22:25:19 GMT
Received: from ppma02dal.us.ibm.com (a.bd.3ea9.ip4.static.sl-reverse.com [169.62.189.10])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3nc1aq1332-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 26 Jan 2023 22:25:19 +0000
Received: from pps.filterd (ppma02dal.us.ibm.com [127.0.0.1])
        by ppma02dal.us.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 30QLFf2F025656;
        Thu, 26 Jan 2023 22:25:18 GMT
Received: from smtprelay07.wdc07v.mail.ibm.com ([9.208.129.116])
        by ppma02dal.us.ibm.com (PPS) with ESMTPS id 3n87p7ydpe-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 26 Jan 2023 22:25:18 +0000
Received: from smtpav05.dal12v.mail.ibm.com (smtpav05.dal12v.mail.ibm.com [10.241.53.104])
        by smtprelay07.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 30QMPGGb2818710
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 26 Jan 2023 22:25:16 GMT
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 7958258056;
        Thu, 26 Jan 2023 22:25:16 +0000 (GMT)
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id CA6EF5804C;
        Thu, 26 Jan 2023 22:25:15 +0000 (GMT)
Received: from [9.47.158.152] (unknown [9.47.158.152])
        by smtpav05.dal12v.mail.ibm.com (Postfix) with ESMTP;
        Thu, 26 Jan 2023 22:25:15 +0000 (GMT)
Message-ID: <5a2b46ef-71de-03f5-3d4d-ef6834a33971@linux.ibm.com>
Date:   Thu, 26 Jan 2023 17:25:15 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH ima-evm-utils] Add tests for MMAP_CHECK and
 MMAP_CHECK_REQPROT hooks
Content-Language: en-US
To:     Roberto Sassu <roberto.sassu@huaweicloud.com>, zohar@linux.ibm.com,
        dmitry.kasatkin@gmail.com, jmorris@namei.org, serge@hallyn.com
Cc:     linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, viro@zeniv.linux.org.uk,
        Roberto Sassu <roberto.sassu@huawei.com>
References: <20230126163812.1870942-1-roberto.sassu@huaweicloud.com>
 <20230126163812.1870942-3-roberto.sassu@huaweicloud.com>
From:   Stefan Berger <stefanb@linux.ibm.com>
In-Reply-To: <20230126163812.1870942-3-roberto.sassu@huaweicloud.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: -Mw7vpOL2zgx8fWd_5w-IhiqtoV88s2L
X-Proofpoint-GUID: DLJtTCkGPSqhABZM3YmwNIV8g3FhYvV3
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-01-26_09,2023-01-26_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 adultscore=0
 spamscore=0 malwarescore=0 priorityscore=1501 phishscore=0 suspectscore=0
 mlxscore=0 lowpriorityscore=0 mlxlogscore=718 impostorscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2212070000
 definitions=main-2301260207
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org



On 1/26/23 11:38, Roberto Sassu wrote:
> From: Roberto Sassu <roberto.sassu@huawei.com>
> 
> Add tests to ensure that, after applying the kernel patch 'ima: Align
> ima_file_mmap() parameters with mmap_file LSM hook', the MMAP_CHECK hook
> checks the protections applied by the kernel and not those requested by the
> application.
> 
> Also ensure that after applying 'ima: Introduce MMAP_CHECK_REQPROT hook',
> the MMAP_CHECK_REQPROT hook checks the protections requested by the
> application.

below LGTM

How do you tell the user that the patches need to be applied for the test to
succeed and not worry about it when the patches are not applied?


> 
> Test both with the test_mmap application that by default requests the
> PROT_READ protection flag. Its syntax is:
> 

> +
> +check_mmap() {
> +	local hook="$1"
> +	local arg="$2"
> +	local test_file
> +	local fowner
> +	local rule
> +	local result
> +	local test_file_entry
> +

you can write them all in one line: 'local test_file fowner rule result test_file_entry'
