Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C3475698BD
	for <lists+linux-integrity@lfdr.de>; Thu,  7 Jul 2022 05:19:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234957AbiGGDTc (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 6 Jul 2022 23:19:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234890AbiGGDTb (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 6 Jul 2022 23:19:31 -0400
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BDB5230F50;
        Wed,  6 Jul 2022 20:19:25 -0700 (PDT)
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 2672jJgi023338;
        Thu, 7 Jul 2022 03:19:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 mime-version : content-transfer-encoding; s=pp1;
 bh=ewEvjwCu5GaxlyxrOtKYIf26jccNqy2aF7IVAq2XlCs=;
 b=Nmwn6jpiQ6ku70TyKirPR/YGsF6y9VY8lOHxSuN8EtKB4tt3K8Sdo+E9PWLPflZjTU14
 qlj5E5RKmXYdNRVLCQuLSQyDUmnZvE1x6mYgc+T/8GqPOx5w7lUeEUPBZkFX84ZPNdyy
 Ng4RxBOxkl/JvzTISzB1+YWWjML9dPvXXAOW2zO391/qeS+XhEgq1pllh8iOqKKpC68P
 48bY6VmThvX9SOeJl6ZcWHuiwkx3jTZIbISG/zc228+DY3Hgey1+g/Sj6RgGJxgh1G99
 RrXLezrPtlF3x27RUN1bcLKexe1WErrG7ve+0jZW8g9Zy7jq0cSX2CRLdbzAqV5GyKrb rw== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3h5mcvbwsm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 07 Jul 2022 03:19:15 +0000
Received: from m0098417.ppops.net (m0098417.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 26739ixG025579;
        Thu, 7 Jul 2022 03:19:15 GMT
Received: from ppma01fra.de.ibm.com (46.49.7a9f.ip4.static.sl-reverse.com [159.122.73.70])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3h5mcvbws2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 07 Jul 2022 03:19:15 +0000
Received: from pps.filterd (ppma01fra.de.ibm.com [127.0.0.1])
        by ppma01fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 26738MNJ016780;
        Thu, 7 Jul 2022 03:19:13 GMT
Received: from b06avi18626390.portsmouth.uk.ibm.com (b06avi18626390.portsmouth.uk.ibm.com [9.149.26.192])
        by ppma01fra.de.ibm.com with ESMTP id 3h4ukw1der-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 07 Jul 2022 03:19:13 +0000
Received: from d06av22.portsmouth.uk.ibm.com (d06av22.portsmouth.uk.ibm.com [9.149.105.58])
        by b06avi18626390.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 2673Hrio19530146
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 7 Jul 2022 03:17:53 GMT
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 0D4844C044;
        Thu,  7 Jul 2022 03:19:11 +0000 (GMT)
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 1A8584C040;
        Thu,  7 Jul 2022 03:19:09 +0000 (GMT)
Received: from li-f45666cc-3089-11b2-a85c-c57d1a57929f.ibm.com (unknown [9.163.26.108])
        by d06av22.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Thu,  7 Jul 2022 03:19:08 +0000 (GMT)
Message-ID: <0196570e0deb244b5e846925098ddc5085dddaf9.camel@linux.ibm.com>
Subject: Re: [PATCH] ima/evm: Fix potential memory leak in ima_init_crypto()
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Jianglei Nie <niejianglei2021@163.com>, dmitry.kasatkin@gmail.com,
        jmorris@namei.org, serge@hallyn.com
Cc:     linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Wed, 06 Jul 2022 23:19:07 -0400
In-Reply-To: <20220704005932.2217025-1-niejianglei2021@163.com>
References: <20220704005932.2217025-1-niejianglei2021@163.com>
Content-Type: text/plain; charset="ISO-8859-15"
X-Mailer: Evolution 3.28.5 (3.28.5-18.el8) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: 2SHe4gmWDMj28RF8IlCg-3RjXnh4bZuw
X-Proofpoint-GUID: Dt9uzsfmEQvwxV8e1gEgjWNjmZxTAFmV
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-07-07_02,2022-06-28_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015
 priorityscore=1501 impostorscore=0 mlxlogscore=999 lowpriorityscore=0
 malwarescore=0 mlxscore=0 bulkscore=0 suspectscore=0 spamscore=0
 adultscore=0 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2206140000 definitions=main-2207070011
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Hi Jianglei,

Thank you for the patch.

On Mon, 2022-07-04 at 08:59 +0800, Jianglei Nie wrote:
> ima_init_crypto() allocates a memory chunk for "ima_algo_array" with
> kcalloc(). When some errors occur, the function jumps to "out_array"
> and releases the "ima_algo_array[i].tfm". But "ima_algo_array" is
> not released, which will lead to a memory leak.

There's too much low level code details in the above paragraph.  The
patch description should be written from a higher level perspective. 
Refer to the original commit 6d94809af6b0 ("ima: Allocate and
initialize tfm for each PCR bank") for an example.
> 
> We can release the ima_algo_array with kfree() when some errors occur
> to fix the memory leak.

Please re-word the above sentence in the imperative mode.  Refer to
Documentation/process/submitting-patches.rst for an example.

thanks,

Mimi
> 
> Signed-off-by: Jianglei Nie <niejianglei2021@163.com>

