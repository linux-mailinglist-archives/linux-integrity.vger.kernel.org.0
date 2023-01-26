Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 60C5467D0B1
	for <lists+linux-integrity@lfdr.de>; Thu, 26 Jan 2023 16:55:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232216AbjAZPzx (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 26 Jan 2023 10:55:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229459AbjAZPzx (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 26 Jan 2023 10:55:53 -0500
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 092782BF39
        for <linux-integrity@vger.kernel.org>; Thu, 26 Jan 2023 07:55:51 -0800 (PST)
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 30QDjJiw023104;
        Thu, 26 Jan 2023 15:55:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=/7M08UJI+vnWWb7eEGpP4T9TJTm6za6JM8+gB7+kyiU=;
 b=Py7Wzy2OkxeTlCCKq/W8lwWiLJUXIZiNHQEXYWRgjkuVXIiPMbO3qvVB6EpJZfUx0WNo
 AaVpRixJIsH7CN9psqWLmmrtSBwTVtJ7qyygRK912opH4z4bT+qsDZN1gYkC7TtZ9dew
 VEVKkMJeFQ3X3QyOFdUMmhdhHcmePvYwxbITZH0Sl1IXIJV5/zPGmxm+EYwiJVErQKyG
 gPc2G2s3hmODQ/EHvJKcqZ/XfXjBC4gkjxuqnlqysnrQmHsrl/SedNOPCddAqFWkV45+
 5hhtyLEEAtJ1mpLbmGrhO88l8FKB5bdHc9xPgywPaJr4WyY5+ec9FLUdpgYH35+nYv4t kA== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (PPS) with ESMTPS id 3nbtp43cv0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 26 Jan 2023 15:55:27 +0000
Received: from m0098420.ppops.net (m0098420.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 30QFALrQ021354;
        Thu, 26 Jan 2023 15:55:26 GMT
Received: from ppma01dal.us.ibm.com (83.d6.3fa9.ip4.static.sl-reverse.com [169.63.214.131])
        by mx0b-001b2d01.pphosted.com (PPS) with ESMTPS id 3nbtp43cup-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 26 Jan 2023 15:55:26 +0000
Received: from pps.filterd (ppma01dal.us.ibm.com [127.0.0.1])
        by ppma01dal.us.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 30QF75bK004823;
        Thu, 26 Jan 2023 15:55:26 GMT
Received: from smtprelay05.dal12v.mail.ibm.com ([9.208.130.101])
        by ppma01dal.us.ibm.com (PPS) with ESMTPS id 3n87p8dk16-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 26 Jan 2023 15:55:26 +0000
Received: from smtpav06.wdc07v.mail.ibm.com (smtpav06.wdc07v.mail.ibm.com [10.39.53.233])
        by smtprelay05.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 30QFtP7q62193960
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 26 Jan 2023 15:55:25 GMT
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 5229658055;
        Thu, 26 Jan 2023 15:55:25 +0000 (GMT)
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 9ABCC5803F;
        Thu, 26 Jan 2023 15:55:24 +0000 (GMT)
Received: from [9.47.158.152] (unknown [9.47.158.152])
        by smtpav06.wdc07v.mail.ibm.com (Postfix) with ESMTP;
        Thu, 26 Jan 2023 15:55:24 +0000 (GMT)
Message-ID: <335c6fd0-20d2-1050-2bb4-091aab929514@linux.ibm.com>
Date:   Thu, 26 Jan 2023 10:55:23 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH ima-evm-utils v4 05/11] Add support for creating a new
 testing environment in functions.sh
Content-Language: en-US
To:     Roberto Sassu <roberto.sassu@huaweicloud.com>, zohar@linux.ibm.com,
        dmitry.kasatkin@gmail.com
Cc:     linux-integrity@vger.kernel.org, vt@altlinux.org, pvorel@suse.cz,
        Roberto Sassu <roberto.sassu@huawei.com>
References: <20230126135807.1848668-1-roberto.sassu@huaweicloud.com>
 <20230126135807.1848668-6-roberto.sassu@huaweicloud.com>
From:   Stefan Berger <stefanb@linux.ibm.com>
In-Reply-To: <20230126135807.1848668-6-roberto.sassu@huaweicloud.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: v0RZC4sRYr6XoUHlFsvPTPsW64E4ui87
X-Proofpoint-GUID: 6WxujnYt-6tAdc4rs6NGptTiKe0AE9oc
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-01-26_07,2023-01-26_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 spamscore=0
 priorityscore=1501 mlxlogscore=975 clxscore=1015 bulkscore=0 adultscore=0
 lowpriorityscore=0 suspectscore=0 impostorscore=0 malwarescore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2301260151
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org



On 1/26/23 08:58, Roberto Sassu wrote:
> From: Roberto Sassu <roberto.sassu@huawei.com>
> 
> Add the new functions _run_env(), _exit_env(), _init_env() and
> _cleanup_env() to run the tests inside a new environment specified with the
> TST_ENV environment variable.
> 
> A typical structure of a script with tests is:
> 
> trap '_report_exit_and_cleanup _cleanup_env cleanup' \
>      SIGINT SIGTERM SIGSEGV EXIT
> 
> cleanup() {
> 	<test cleanup>
> }
> 
> <tests implementations>
> 
> _run_env "$TST_KERNEL" "$PWD/$(basename "$0")" "env_var1=$env_var1 ..."
> 
> _exit_env "$TST_KERNEL"
> 
> _init_env
> 
> <tests init>
> 
> <tests call>
> 
> If TST_ENV is not set or empty, don't create a new testing environment and
> perform the cleanup in the current environment. Don't create a new testing
> environment also if the script is already executed in a new environment, to
> avoid loops. Instead, for cleanup, do it in the new environment and skip it
> in the host environment (if the cleanup function is passed to
> _cleanup_env()).
> 
> Signal to the creator of the environment failures of tests or of the script
> itself run in the new environment (if the exit code is 1 ($FAIL) or 99
> ($HARDFAIL)) with an unclean shutdown of the system.
> 
> Add haveged and systemd as dependencies for the tests in ci/fedora.sh,
> respectively for initializing the random number generator and for shutting
> down the system in the new environment.
> 
> Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>

Reviewed-by: Stefan Berger <stefanb@linux.ibm.com>
