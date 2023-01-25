Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 31A2567B3DA
	for <lists+linux-integrity@lfdr.de>; Wed, 25 Jan 2023 15:07:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235053AbjAYOHP (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 25 Jan 2023 09:07:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235045AbjAYOHO (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 25 Jan 2023 09:07:14 -0500
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D944B44BC8
        for <linux-integrity@vger.kernel.org>; Wed, 25 Jan 2023 06:07:09 -0800 (PST)
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 30PC0CDr006278;
        Wed, 25 Jan 2023 14:06:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=H7Xj+9aqxxd2PYEZatZyNWP3g/juBry/HD3iiF5WoIg=;
 b=TraG7pRz19YW6FAKOJgiEdnq8aavqLjVHfpvrXethywtP2FrZPQv/jXHFa81HVYV5qKw
 JT9Kt5zRpdQ5HL2we136mOcQEIdqY3J2LOuqWA4r7tCqUdb/gs2ZW8kS6XbRVvPWxxPU
 n4l0EVNGWaTZO2RqopcxWsCZCAJnJT5IgED9VBq6mjYZ21NxX2sPg10niBRFqMWbmex6
 5ER10nz+rogatLm+v0mDO0Kq6FDnD4WVu3xSW/ThFYADL+G7+hStj8skjrXcQ+vkSd3Y
 PdWJ/J4zFEjWrJPfRJml/wH35EEJMtmCJorD196OiC9WgcBThI2rC9X0MawbbOWXueAW UQ== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3naakpqk75-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 25 Jan 2023 14:06:48 +0000
Received: from m0098421.ppops.net (m0098421.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 30PDwMCN000597;
        Wed, 25 Jan 2023 14:06:47 GMT
Received: from ppma01wdc.us.ibm.com (fd.55.37a9.ip4.static.sl-reverse.com [169.55.85.253])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3naakpqk6n-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 25 Jan 2023 14:06:47 +0000
Received: from pps.filterd (ppma01wdc.us.ibm.com [127.0.0.1])
        by ppma01wdc.us.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 30PALrlU010674;
        Wed, 25 Jan 2023 14:06:47 GMT
Received: from smtprelay07.wdc07v.mail.ibm.com ([9.208.129.116])
        by ppma01wdc.us.ibm.com (PPS) with ESMTPS id 3n87p786dh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 25 Jan 2023 14:06:46 +0000
Received: from smtpav02.dal12v.mail.ibm.com (smtpav02.dal12v.mail.ibm.com [10.241.53.101])
        by smtprelay07.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 30PE6jHJ2228864
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 25 Jan 2023 14:06:46 GMT
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 8E3105805E;
        Wed, 25 Jan 2023 14:06:45 +0000 (GMT)
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 8CC4558068;
        Wed, 25 Jan 2023 14:06:44 +0000 (GMT)
Received: from [9.47.158.152] (unknown [9.47.158.152])
        by smtpav02.dal12v.mail.ibm.com (Postfix) with ESMTP;
        Wed, 25 Jan 2023 14:06:44 +0000 (GMT)
Message-ID: <db318103-c9a8-1e42-0d6f-7e9d139ab201@linux.ibm.com>
Date:   Wed, 25 Jan 2023 09:06:44 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH ima-evm-utils v3 06/11] Introduce TST_LIST variable to
 select a test to execute
Content-Language: en-US
To:     Roberto Sassu <roberto.sassu@huaweicloud.com>, zohar@linux.ibm.com,
        dmitry.kasatkin@gmail.com
Cc:     linux-integrity@vger.kernel.org, vt@altlinux.org, pvorel@suse.cz,
        Roberto Sassu <roberto.sassu@huawei.com>
References: <20230125085030.1568256-1-roberto.sassu@huaweicloud.com>
 <20230125085030.1568256-7-roberto.sassu@huaweicloud.com>
From:   Stefan Berger <stefanb@linux.ibm.com>
In-Reply-To: <20230125085030.1568256-7-roberto.sassu@huaweicloud.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: 4urMPRcNGqIszcVoq_Q_GFlZlD6PotS7
X-Proofpoint-GUID: xhMPDfSy3fepT3gtNmfR12wfJoajTaf0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-01-25_08,2023-01-25_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 clxscore=1015
 priorityscore=1501 impostorscore=0 mlxlogscore=999 spamscore=0
 adultscore=0 mlxscore=0 malwarescore=0 bulkscore=0 lowpriorityscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2301250126
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org



On 1/25/23 03:50, Roberto Sassu wrote:
> From: Roberto Sassu <roberto.sassu@huawei.com>
> 
> It might be desirable, due to restrictions in the testing environment, to
> execute tests individually. Introduce the TST_LIST variable, which can be
> set with the name of the test to execute. If the variable is set,
> expect_pass and expect_fail automatically skip the tests when the first
> argument of those functions does not match the value of TST_LIST.
> 
> TST_LIST can be also used in new environments, to execute a subset of
> defined tests for each environment. It is sufficient to add the variable
> and its value to the kernel command line.
> 
> Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>
> ---
>   tests/functions.sh | 12 ++++++++++++
>   1 file changed, 12 insertions(+)
> 
> diff --git a/tests/functions.sh b/tests/functions.sh
> index 9dc9b96d1d7a..d2edd8514e85 100755
> --- a/tests/functions.sh
> +++ b/tests/functions.sh
> @@ -72,6 +72,12 @@ declare -i TNESTED=0 # just for sanity checking
>   expect_pass() {
>     local -i ret
>   
> +  if [ -n "$TST_LIST" ] && [ "${TST_LIST/$1/}" = "$TST_LIST" ]; then
> +    [ "$VERBOSE" -gt 1 ] && echo "____ SKIP test: $*"
> +    testsskip+=1
> +    return $SKIP
> +  fi
> +
>     if [ $TNESTED -gt 0 ]; then
>       echo $RED"expect_pass should not be run nested"$NORM
>       testsfail+=1
> @@ -98,6 +104,12 @@ expect_pass() {
>   expect_fail() {
>     local ret
>   
> +  if [ -n "$TST_LIST" ] && [ "${TST_LIST/$1/}" = "$TST_LIST" ]; then
> +    [ "$VERBOSE" -gt 1 ] && echo "____ SKIP test: $*"
> +    testsskip+=1
> +    return $SKIP
> +  fi
> +
>     if [ $TNESTED -gt 0 ]; then
>       echo $RED"expect_fail should not be run nested"$NORM
>       testsfail+=1

return "$SKIP" would be better.

Reviewed-by: Stefan Berger <stefanb@linux.ibm.com>

