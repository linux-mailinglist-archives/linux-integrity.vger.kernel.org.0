Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 90FD4667A70
	for <lists+linux-integrity@lfdr.de>; Thu, 12 Jan 2023 17:13:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230519AbjALQNw (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 12 Jan 2023 11:13:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230173AbjALQNN (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 12 Jan 2023 11:13:13 -0500
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 722D3F582
        for <linux-integrity@vger.kernel.org>; Thu, 12 Jan 2023 08:08:51 -0800 (PST)
Received: from pps.filterd (m0187473.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 30CFct9h011857;
        Thu, 12 Jan 2023 16:08:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=j1nA+XmCEGjUxXsgaT51BWwv/iUchd6SoyQOlMfIxBE=;
 b=tkQfY67wAhDslEs7QFNmrxZ7wAuaAYPbuiJp2QkidROybvb1sbaTbCOFuIq75qm2ZERx
 zYAOqu52LaCmS2J7+YpHyfb7yA0VhfwD8Nvj3cnpAv7kcL6NtXsMjr22MsSbo6pb5VUl
 B5aoQcwhJSds1onKv0gZqeSU4zG+eTgGciSQBdabldkCyHRcPrTPaHo5nL+672DyyrdP
 1lefr09u3pFzJbQS9uYSqG3jgbgkM9Yx2kvbFDw3ck6RLe/48zrTnRZeyH1TYYpQtTSi
 VDuWFqwkpfR35c/WlBfeMOlU9TAdF0vgS351Fnp9nuwbVowf/xHLxlT6qpRbqTM49uor mw== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3n2mb0j4ns-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 12 Jan 2023 16:08:25 +0000
Received: from m0187473.ppops.net (m0187473.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 30CFfQ8W021551;
        Thu, 12 Jan 2023 16:08:25 GMT
Received: from ppma03dal.us.ibm.com (b.bd.3ea9.ip4.static.sl-reverse.com [169.62.189.11])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3n2mb0j4n8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 12 Jan 2023 16:08:25 +0000
Received: from pps.filterd (ppma03dal.us.ibm.com [127.0.0.1])
        by ppma03dal.us.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 30CEioKd012982;
        Thu, 12 Jan 2023 16:08:24 GMT
Received: from smtprelay05.dal12v.mail.ibm.com ([9.208.130.101])
        by ppma03dal.us.ibm.com (PPS) with ESMTPS id 3n1ka14tmk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 12 Jan 2023 16:08:24 +0000
Received: from smtpav01.wdc07v.mail.ibm.com (smtpav01.wdc07v.mail.ibm.com [10.39.53.228])
        by smtprelay05.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 30CG8MIa4391630
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 12 Jan 2023 16:08:23 GMT
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id B81F158065;
        Thu, 12 Jan 2023 16:08:22 +0000 (GMT)
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 11A335805B;
        Thu, 12 Jan 2023 16:08:22 +0000 (GMT)
Received: from [9.47.158.152] (unknown [9.47.158.152])
        by smtpav01.wdc07v.mail.ibm.com (Postfix) with ESMTP;
        Thu, 12 Jan 2023 16:08:21 +0000 (GMT)
Message-ID: <ae6cf263-87be-78d3-0475-b4d8c2f1f641@linux.ibm.com>
Date:   Thu, 12 Jan 2023 11:08:21 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH ima-evm-utils v2 9/9] ci: haveged requires EPEL on CentOS
 stream:8
Content-Language: en-US
To:     Roberto Sassu <roberto.sassu@huaweicloud.com>, zohar@linux.ibm.com,
        dmitry.kasatkin@gmail.com
Cc:     linux-integrity@vger.kernel.org, vt@altlinux.org, pvorel@suse.cz,
        Roberto Sassu <roberto.sassu@huawei.com>
References: <20230112122426.3759938-1-roberto.sassu@huaweicloud.com>
 <20230112122426.3759938-10-roberto.sassu@huaweicloud.com>
From:   Stefan Berger <stefanb@linux.ibm.com>
In-Reply-To: <20230112122426.3759938-10-roberto.sassu@huaweicloud.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 3IZiWo8qcMHy6Gt7L-brd9ABhlJvX4Bk
X-Proofpoint-ORIG-GUID: yBJu5du5_WS11xcHsc-dpFZARNNITdlg
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2023-01-12_08,2023-01-12_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 adultscore=0 priorityscore=1501 bulkscore=0 phishscore=0 clxscore=1015
 mlxscore=0 malwarescore=0 mlxlogscore=999 spamscore=0 suspectscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2301120116
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org



On 1/12/23 07:24, Roberto Sassu wrote:
> From: Mimi Zohar <zohar@linux.ibm.com>
> 
> The travis "fedora:latest" matrix rule fails due to not finding
> "haveged".  Install "haveged" after enabling EPEL.
> 
> Fixes: 1a2d4767a8b1 ("Add support for UML in functions.sh")
> Signed-off-by: Mimi Zohar <zohar@linux.ibm.com>
> Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>

Reviewed-by: Stefan Berger <stefanb@linux.ibm.com>

> ---
>   ci/fedora.sh | 4 +++-
>   1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/ci/fedora.sh b/ci/fedora.sh
> index 3f75d2e1ddbd..1d17c6bfb89d 100755
> --- a/ci/fedora.sh
> +++ b/ci/fedora.sh
> @@ -46,7 +46,6 @@ yum -y install \
>   	wget \
>   	which \
>   	zstd \
> -	haveged \
>   	systemd \
>   	keyutils \
>   	e2fsprogs \
> @@ -62,5 +61,8 @@ if [ -f /etc/centos-release ]; then
>   fi
>   yum -y install softhsm || true
>   
> +# haveged is available via EPEL on CentOS stream8.
> +yum -y install haveged || true
> +
>   ./tests/install-fsverity.sh
>   ./tests/install-mount-idmapped.sh
