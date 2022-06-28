Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A1E9755EAF8
	for <lists+linux-integrity@lfdr.de>; Tue, 28 Jun 2022 19:25:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229772AbiF1RZ2 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 28 Jun 2022 13:25:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231738AbiF1RZ1 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 28 Jun 2022 13:25:27 -0400
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1A8539821;
        Tue, 28 Jun 2022 10:25:25 -0700 (PDT)
Received: from pps.filterd (m0127361.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 25SH86e2016204;
        Tue, 28 Jun 2022 17:25:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=m4j3y3RvkIM6SWeHtONEy1ljKBPfeHeA0FSrfKMn9qs=;
 b=qG1qnycdUJJg71tCbFND6rP86rIil8j2PsHZFDbyZ8o+W943G/lE28lH8dW/PNV9k5G4
 DHwuvG+dRZVoTu2WQKkq9549yZCg20G2hFWUJ4yocqecMdDa27z9dHQV8Ai2HlYguCVI
 VLErP6tHcCJIIie1QvmsG6qO9zhjg/Xjj2D0Gf6dxSJ5nZRT75ntNuGW9YxFzixTRSqW
 DyRnjZTpZl34dnRScCaqKiec+eVf9TLI9xdWMR0Yqw7Qzik6BDHVkMyBO4Uk6li/O1Tn
 05SAhXqdbtNf7hqrHEbB7Vz64UiI4RULlEoVDYcL4ttZAZE+nVWGtQA51qgsZ4gh3YrU HQ== 
Received: from ppma04wdc.us.ibm.com (1a.90.2fa9.ip4.static.sl-reverse.com [169.47.144.26])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3h05sd0huq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 28 Jun 2022 17:25:16 +0000
Received: from pps.filterd (ppma04wdc.us.ibm.com [127.0.0.1])
        by ppma04wdc.us.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 25SHLBC9021275;
        Tue, 28 Jun 2022 17:25:15 GMT
Received: from b03cxnp08026.gho.boulder.ibm.com (b03cxnp08026.gho.boulder.ibm.com [9.17.130.18])
        by ppma04wdc.us.ibm.com with ESMTP id 3gwt09pxyg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 28 Jun 2022 17:25:15 +0000
Received: from b03ledav005.gho.boulder.ibm.com (b03ledav005.gho.boulder.ibm.com [9.17.130.236])
        by b03cxnp08026.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 25SHPEOd33489318
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 28 Jun 2022 17:25:14 GMT
Received: from b03ledav005.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 64E64BE04F;
        Tue, 28 Jun 2022 17:25:14 +0000 (GMT)
Received: from b03ledav005.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id C91D2BE054;
        Tue, 28 Jun 2022 17:25:13 +0000 (GMT)
Received: from [9.47.158.152] (unknown [9.47.158.152])
        by b03ledav005.gho.boulder.ibm.com (Postfix) with ESMTP;
        Tue, 28 Jun 2022 17:25:13 +0000 (GMT)
Message-ID: <4dec36a6-e4be-196c-1af7-3d84c964394f@linux.ibm.com>
Date:   Tue, 28 Jun 2022 13:25:13 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Subject: Re: [PATCH v3 0/3] tpm: Preserve TPM measurement log across kexec
 (ppc64)
Content-Language: en-US
To:     kexec@lists.infradead.org, devicetree@vger.kernel.org,
        linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org
Cc:     nayna@linux.ibm.com, nasastry@in.ibm.com, mpe@ellerman.id.au
References: <20220628165820.883222-1-stefanb@linux.ibm.com>
From:   Stefan Berger <stefanb@linux.ibm.com>
In-Reply-To: <20220628165820.883222-1-stefanb@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: UPxcaoS2IWgnZEiR4HPlabB68h_GKNcO
X-Proofpoint-GUID: UPxcaoS2IWgnZEiR4HPlabB68h_GKNcO
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-06-28_10,2022-06-28_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 bulkscore=0 lowpriorityscore=0 suspectscore=0 impostorscore=0
 mlxlogscore=662 adultscore=0 malwarescore=0 clxscore=1015 mlxscore=0
 spamscore=0 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2204290000 definitions=main-2206280068
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On 6/28/22 12:58, Stefan Berger wrote:
> The of-tree subsystem does not currently preserve the IBM vTPM 1.2 and
> vTPM 2.0 measurement logs across a kexec on ppc64. This series fixes this
> for the kexec_file_load() syscall using the flattened device tree (fdt) to
> carry the measurement log's buffer across kexec.
> 
>     Stefan
> 

v3:
  - Moved TPM Open Firmware related function to 
drivers/char/tpm/eventlog/tpm_of.c

v2:
  - rearranged patches
  - fixed compilation issues for x86


> Stefan Berger (3):
>    tpm: of: Make of-tree specific function commonly available
>    of: kexec: Refactor IMA buffer related functions to make them reusable
>    tpm/kexec: Duplicate TPM measurement log in of-tree for kexec
> 
>   drivers/char/Makefile              |   1 +
>   drivers/char/tpm/Makefile          |   1 +
>   drivers/char/tpm/eventlog/of.c     |  31 +--
>   drivers/char/tpm/eventlog/tpm_of.c |  27 +++
>   drivers/of/kexec.c                 | 293 +++++++++++++++++++++++++----
>   include/linux/kexec.h              |   6 +
>   include/linux/of.h                 |   8 +-
>   include/linux/tpm.h                |   5 +
>   kernel/kexec_file.c                |   6 +
>   9 files changed, 315 insertions(+), 63 deletions(-)
>   create mode 100644 drivers/char/tpm/eventlog/tpm_of.c
> 
