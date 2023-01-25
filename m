Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C69167C020
	for <lists+linux-integrity@lfdr.de>; Wed, 25 Jan 2023 23:45:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229570AbjAYWpu (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 25 Jan 2023 17:45:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229475AbjAYWpt (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 25 Jan 2023 17:45:49 -0500
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7591311165
        for <linux-integrity@vger.kernel.org>; Wed, 25 Jan 2023 14:45:48 -0800 (PST)
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 30PMAR03011696;
        Wed, 25 Jan 2023 22:45:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=P1R753LsKPlSs5lwo1+SIlk0dG4LOtQAwJX5ePgwoFU=;
 b=cIs+usAGDphQ46a/w3ffu3Ny3s+q66/EOkMBEvr7AHMT/3FjNmP/Ndvf28AJyJEoU96o
 Xny+DuqB0QNUU+mdl/c//QpxVZxNH2I/Twar2xQr8LmgvHenITC8QfDiOvW0TGe5S0+j
 V7sNmHZJZkeoFLXZYP89FV4bOmFiyuoV1ho31671H9STdr3eIUEdIt+6lqXhhQTipl+g
 ZZT6NG6LH/pMgFiHCfWuyfnwmqO9e8vU139xvsMeTYru65mjfZ2RqCKmRRqpnFJsGh6a
 lx262PhVRAQfOd+4i8PJuUTksEqbtSvjCkMxGl2QQyahgptkUKxJqkeYTbnmUoT3dkhz kg== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3na839hmb2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 25 Jan 2023 22:45:31 +0000
Received: from m0098404.ppops.net (m0098404.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 30PMjVfJ016195;
        Wed, 25 Jan 2023 22:45:31 GMT
Received: from ppma02wdc.us.ibm.com (aa.5b.37a9.ip4.static.sl-reverse.com [169.55.91.170])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3na839hmaa-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 25 Jan 2023 22:45:31 +0000
Received: from pps.filterd (ppma02wdc.us.ibm.com [127.0.0.1])
        by ppma02wdc.us.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 30PKSZdi012824;
        Wed, 25 Jan 2023 22:45:29 GMT
Received: from smtprelay06.wdc07v.mail.ibm.com ([9.208.129.118])
        by ppma02wdc.us.ibm.com (PPS) with ESMTPS id 3n87p7tb12-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 25 Jan 2023 22:45:29 +0000
Received: from smtpav01.wdc07v.mail.ibm.com (smtpav01.wdc07v.mail.ibm.com [10.39.53.228])
        by smtprelay06.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 30PMjSER66454006
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 25 Jan 2023 22:45:28 GMT
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id B3AE758066;
        Wed, 25 Jan 2023 22:45:28 +0000 (GMT)
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id E877358055;
        Wed, 25 Jan 2023 22:45:27 +0000 (GMT)
Received: from [9.47.158.152] (unknown [9.47.158.152])
        by smtpav01.wdc07v.mail.ibm.com (Postfix) with ESMTP;
        Wed, 25 Jan 2023 22:45:27 +0000 (GMT)
Message-ID: <cbfb1860-5b22-910d-6a85-9ee01657fc2a@linux.ibm.com>
Date:   Wed, 25 Jan 2023 17:45:27 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH ima-evm-utils v3 08/11] Adapt fsverity.test to be able to
 run in a new testing environment
Content-Language: en-US
To:     Roberto Sassu <roberto.sassu@huaweicloud.com>, zohar@linux.ibm.com,
        dmitry.kasatkin@gmail.com
Cc:     linux-integrity@vger.kernel.org, vt@altlinux.org, pvorel@suse.cz,
        Roberto Sassu <roberto.sassu@huawei.com>
References: <20230125085030.1568256-1-roberto.sassu@huaweicloud.com>
 <20230125085030.1568256-9-roberto.sassu@huaweicloud.com>
From:   Stefan Berger <stefanb@linux.ibm.com>
In-Reply-To: <20230125085030.1568256-9-roberto.sassu@huaweicloud.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: Sd_yMTw1QfAzngTrOFRsoHCw9fLwzBBi
X-Proofpoint-ORIG-GUID: umiAi6HXN_Y7oH8Gl1kCvxF1kOpmTwAJ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-01-25_13,2023-01-25_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 phishscore=0
 spamscore=0 mlxlogscore=999 adultscore=0 lowpriorityscore=0 bulkscore=0
 clxscore=1015 malwarescore=0 mlxscore=0 priorityscore=1501 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2212070000
 definitions=main-2301250200
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
> Adapt fsverity.test by adding calls to the testing environment API in
> functions.sh. If TST_ENV is set, create a new environment and run the
> kernel specified with the TST_KERNEL environment variable. Otherwise, keep
> the current behavior.
> 
> Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>
> ---
>   tests/fsverity.test | 11 ++++++++++-
>   1 file changed, 10 insertions(+), 1 deletion(-)
> 
> diff --git a/tests/fsverity.test b/tests/fsverity.test
> index be9594010de5..8261de4ea3c9 100755
> --- a/tests/fsverity.test
> +++ b/tests/fsverity.test
> @@ -47,7 +47,7 @@ FSVERITY="$(which fsverity)"
>   _require dd mkfs blkid e2fsck tune2fs evmctl setfattr
>   ./gen-keys.sh >/dev/null 2>&1
>   
> -trap '_report_exit_and_cleanup cleanup' SIGINT SIGTERM EXIT
> +trap '_report_exit_and_cleanup _cleanup_env cleanup' SIGINT SIGTERM EXIT
>   
>   cleanup() {
>           if [ -e $TST_MNT ]; then
> @@ -308,6 +308,15 @@ measure-ima() {
>   	return "$error"
>   }
>   
> +# Run in the new environment if TST_ENV is set.
> +_run_env "$TST_KERNEL" "$PWD/$(basename "$0")" "TST_ENV=$TST_ENV TST_KERNEL=$TST_KERNEL PATH=$PATH LD_LIBRARY_PATH=$LD_LIBRARY_PATH VERBOSE=$VERBOSE"
> +
> +# Exit from the creator of the new environment.
> +_exit_env "$TST_KERNEL"
> +
> +# Mount filesystems in the new environment.
> +_init_env
> +
>   # Dependency on being able to read and write the IMA policy file.
>   # Requires both CONFIG_IMA_WRITE_POLICY, CONFIG_IMA_READ_POLICY be
>   # enabled.

Reviewed-by: Stefan Berger <stefanb@linux.ibm.com>
