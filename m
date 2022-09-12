Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC4315B5AC5
	for <lists+linux-integrity@lfdr.de>; Mon, 12 Sep 2022 15:01:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229511AbiILNBR (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 12 Sep 2022 09:01:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229811AbiILNBO (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 12 Sep 2022 09:01:14 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6B6820F57;
        Mon, 12 Sep 2022 06:01:13 -0700 (PDT)
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 28CBtgMg030115;
        Mon, 12 Sep 2022 13:00:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=qMiB5o6S9kg5JxvAdo4/TOmyv7/p5G29pPyRmWvJdzg=;
 b=nH2qaTd8wIeOU8VULuowa+Njcnv9TwH4RxFZ0mo+AqAiYx4kf7aIDj5mylYien9v+1VA
 agE/Y4Pg1x/Ax1aVsKz9aJ7w8Qgx0Wrjp2/cyHrxvYfZoELobEGhahSKwtG1RIuTCNpp
 rQOKfBk27Rr4PBIMuH+gBMwLNCKxaPrBQ0rm6UvSHWKnnSrf+bdTIGIRXP5fBDV/GvaF
 aBDfshOlj9OO4dNOpLpGMwkBBgYfDK+gqM4N4hV+DvVPovJcrHv69QIwBd8pg3v4z7pS
 JDBOm6H+VDuD2LYpNfzEpF2Frp4iCZfcGLQiGvunHXCjcbzUvyPKrkRHX93xHPGCmfpS 7Q== 
Received: from ppma02dal.us.ibm.com (a.bd.3ea9.ip4.static.sl-reverse.com [169.62.189.10])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3jj0kvht1p-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 12 Sep 2022 13:00:51 +0000
Received: from pps.filterd (ppma02dal.us.ibm.com [127.0.0.1])
        by ppma02dal.us.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 28CCodle014458;
        Mon, 12 Sep 2022 13:00:48 GMT
Received: from b01cxnp23032.gho.pok.ibm.com (b01cxnp23032.gho.pok.ibm.com [9.57.198.27])
        by ppma02dal.us.ibm.com with ESMTP id 3jgj79gchy-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 12 Sep 2022 13:00:48 +0000
Received: from b01ledav006.gho.pok.ibm.com (b01ledav006.gho.pok.ibm.com [9.57.199.111])
        by b01cxnp23032.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 28CD0lXT62587292
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 12 Sep 2022 13:00:47 GMT
Received: from b01ledav006.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 96EB1AC05E;
        Mon, 12 Sep 2022 13:00:47 +0000 (GMT)
Received: from b01ledav006.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 6C50EAC059;
        Mon, 12 Sep 2022 13:00:47 +0000 (GMT)
Received: from [9.47.158.152] (unknown [9.47.158.152])
        by b01ledav006.gho.pok.ibm.com (Postfix) with ESMTP;
        Mon, 12 Sep 2022 13:00:47 +0000 (GMT)
Message-ID: <ce08b0af-fb1b-0ade-61ac-f66e95d6eb6a@linux.ibm.com>
Date:   Mon, 12 Sep 2022 09:00:47 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: [PATCH v8 0/4] tpm: Preserve TPM measurement log across kexec
 (ppc64)
Content-Language: en-US
To:     Rob Herring <robh+dt@kernel.org>
Cc:     nayna@linux.ibm.com, nasastry@in.ibm.com, mpe@ellerman.id.au,
        "kexec@lists.infradead.org" <kexec@lists.infradead.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-integrity <linux-integrity@vger.kernel.org>
References: <20220901214610.768645-1-stefanb@linux.ibm.com>
From:   Stefan Berger <stefanb@linux.ibm.com>
In-Reply-To: <20220901214610.768645-1-stefanb@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: G-yXCW8Yz-bo8gyXPoEYlv6_u612-ggY
X-Proofpoint-ORIG-GUID: G-yXCW8Yz-bo8gyXPoEYlv6_u612-ggY
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-09-12_08,2022-09-12_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 adultscore=0
 spamscore=0 mlxlogscore=915 mlxscore=0 phishscore=0 impostorscore=0
 clxscore=1015 suspectscore=0 lowpriorityscore=0 priorityscore=1501
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2207270000 definitions=main-2209120041
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org


Hi Rob,

   can you take this series in your tree?

Regards,
    Stefan

On 9/1/22 17:46, Stefan Berger wrote:
> The of-tree subsystem does not currently preserve the IBM vTPM 1.2 and
> vTPM 2.0 measurement logs across a kexec on PowerVM and PowerKVM. This
> series fixes this for the kexec_file_load() syscall using the flattened
> device tree (fdt) to carry the TPM measurement log's buffer across kexec.
> 
>     Stefan
> 
> v8:
>   - Added Jarkko's, Coiby's, and Rob's tags
>   - Rebase on v6.0-rc3 that absorbed 2 already upstreamed patches
> 
> v7:
>   - Added Nageswara's Tested-by tags
>   - Added back original comment to inline function and removed Jarkko's R-b tag
> 
> v6:
>   - Add __init to get_kexec_buffer as suggested by Jonathan
>   - Fixed issue detected by kernel test robot
> 
> v5:
>   - Rebased on 1 more patch that would otherwise create merge conflicts
> 
> v4:
>   - Rebased on 2 patches that would otherwise create merge conflicts;
>     posting these patches in this series with several tags removed so
>     krobot can test the series already
>   - Changes to individual patches documented in patch descripitons
> 
> v3:
>   - Moved TPM Open Firmware related function to drivers/char/tpm/eventlog/tpm_of.c
> 
> v2:
>   - rearranged patches
>   - fixed compilation issues for x86
> 
> Palmer Dabbelt (1):
>    drivers: of: kexec ima: Support 32-bit platforms
> 
> Stefan Berger (3):
>    tpm: of: Make of-tree specific function commonly available
>    of: kexec: Refactor IMA buffer related functions to make them reusable
>    tpm/kexec: Duplicate TPM measurement log in of-tree for kexec
> 
>   drivers/char/tpm/eventlog/of.c |  31 +--
>   drivers/of/kexec.c             | 336 ++++++++++++++++++++++++++++-----
>   include/linux/kexec.h          |   6 +
>   include/linux/of.h             |   9 +-
>   include/linux/tpm.h            |  36 ++++
>   kernel/kexec_file.c            |   6 +
>   6 files changed, 346 insertions(+), 78 deletions(-)
> 
> 
> base-commit: b90cb1053190353cc30f0fef0ef1f378ccc063c5
